Return-Path: <linux-kernel+bounces-266489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C270B940093
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799881F22C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF5918C33E;
	Mon, 29 Jul 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Q/dyU7c8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947778C98;
	Mon, 29 Jul 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289538; cv=none; b=JQKUFQ+w6rYtg8En4odtK8yblw8XqVHBWNUX8OOzAuiSRbtXunF9Qgd8d9tLrmNZYjOVl/nFKcVXtqLePT21OoArJ86QgROLUqhgHbWgRlOZhqEMolfLirUQPHreTjfpNbF8oUmDNdyvRFV4PyQ73qS/glhcCAiseK1oOvb2VF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289538; c=relaxed/simple;
	bh=uO9ks+NOLiu7zBta3aaZKpJ37G1y5Q61GBrRgOC9wYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QZrbOTS9+mR2kBuOSH9JuQlz13+g26y8eF4V1hp8xJ+8n4sLtZhob/amTNtljEfA52Fkp979CjKxG4DGUX2Cm/5RBT9Fd2QLif1NHjXCDaVZx5wAlF/DZKfc28HCveO2QnPsEzK0vldzSJAVXkPrfCRiMnO+jXNYtwlmnz21RnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Q/dyU7c8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F0EFA418A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1722289536; bh=tPsQRPSENkGLn0KLOHzkvflk7Bryvsbei78Q5KJMiMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q/dyU7c8FeE+yN1PSqjuYohjoFbJUixO5C3NkM/0b7ok3lrS6lpHM5VdEJvXKi/A+
	 mQWVs3e0O7nM68ujo6ybXCg8ORFuEwoEsS3OqVHBxLQQRZU/Gfix6J6Cie9DIVXyDN
	 oDcfvHown3vtMgwS9CMBdTFHQnq1Fk2vIFL0Ogy1lX1dR2HtXy8Tt5BuQQFBAZyKI0
	 MkXWSwLii83B1pSXT7POxMthsseCC69Gcgek0nRb+V5nz4L8I8qMXuE4iixO0dEsRS
	 Ink+fW5lEkwlhjXEDo9Lk7nQusrES4Y1RRhqaODJ2MuDUHneIDkUGKWnCs8p0m0xx/
	 Ci4o8dEkA95iA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F0EFA418A0;
	Mon, 29 Jul 2024 21:45:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Luis Chamberlain
 <mcgrof@kernel.org>, David Gow <davidgow@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add detailed explanation for 'N' taint flag
In-Reply-To: <20240717203521.514348-1-bpoirier@nvidia.com>
References: <20240717203521.514348-1-bpoirier@nvidia.com>
Date: Mon, 29 Jul 2024 15:45:35 -0600
Message-ID: <87jzh398jk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Poirier <bpoirier@nvidia.com> writes:

> Every taint flag has an entry in the "More detailed explanation" section
> except for the 'N' flag. That omission was probably just an oversight so
> add an entry for that flag.
>
> Fixes: 2852ca7fba9f ("panic: Taint kernel if tests are run")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index f92551539e8a..700aa72eecb1 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -182,3 +182,5 @@ More detailed explanation for tainting
>       produce extremely unusual kernel structure layouts (even performance
>       pathological ones), which is important to know when debugging. Set at
>       build time.
> +
> + 18) ``N`` if an in-kernel test, such as a KUnit test, has been run.

Applied, thanks.

jon

