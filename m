Return-Path: <linux-kernel+bounces-558555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219BA5E790
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53081899F44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C31F130C;
	Wed, 12 Mar 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mCGKV3ac"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AA1F0E42;
	Wed, 12 Mar 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818982; cv=none; b=m71wcSuDB6o06XGUx6v7xnY0ldo5tf+EfafrD7lMeVWj4ZwcOTUzqklY3uqI26awqmrCOKgMFpVVvKOMPKgq1+SI1xupdhJhx1CZqm5o5s96eq7mFoO7Aaab08+DxuQPgtkkuO8bItZCdTD6jHwuQO7RkbYldfiN5BQRGY72Ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818982; c=relaxed/simple;
	bh=BaVWbSQENie34pWfic/pbRF/wriQKKMjAg34hMpBRvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J8TpyL8zRuYrPN1U9PJYwz8jjFYTboXrjC8SRNGIJgfE0jSWZkrepdMk0MhfcUY9HFw4czVD7RL8mVdXYq30sqoJjvoXlQ88+fCV+KqJ7LWFuFCNo+DXo+VN41gCKzrAfdtcYpZhbNJPuniMaXdzcoJMzq/DtXs54PvAkNPctF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mCGKV3ac; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0FB7E41063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741818980; bh=GTMfbvfPe3rGQpfvz+NRGN74Tvu8HffllNDpfQa9owA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mCGKV3acK+jLSNTwFG4FSzwiDSq690fcbkqEMydifNSaBFsaxZPO6dPWlKhLMmIib
	 yFOIUY7n9Z2bwDy9Jn5D+4eB+A13pMdkkTB19Ii9WgmL/Rl++ppWhTuS+vMCrDJXtb
	 FTXCQEb34bWO73R7fO+Vzos7qbgGRrrKENjNBoJN06yJtO1TpcP/wAuCXgBq8FyWxm
	 sQQPgsR6oA3oeHZ9dvJ1gUJFtZUQmjjCEhk12rqGeR6QtRfKlrDEOWVLuNquvmMKst
	 /+P8M4UAUQ+QTtmjf5tBNXiFSiy4NemJeMaOiSC49TNSuxHDfMQNbCGotIIbAHvYZy
	 KP8ino3r31b+g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0FB7E41063;
	Wed, 12 Mar 2025 22:36:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ignacio Encinas <ignacio@iencinas.com>,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, Marco
 Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Ignacio Encinas
 <ignacio@iencinas.com>
Subject: Re: [PATCH] Documentation: kcsan: fix "Plain Accesses and Data
 Races" URL in kcsan.rst
In-Reply-To: <20250306-fix-plain-access-url-v1-1-9c653800f9e0@iencinas.com>
References: <20250306-fix-plain-access-url-v1-1-9c653800f9e0@iencinas.com>
Date: Wed, 12 Mar 2025 16:36:19 -0600
Message-ID: <87o6y5lvvg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ignacio Encinas <ignacio@iencinas.com> writes:

> Make the URL point to the "Plain Accesses and Data Races" section again
> and prevent it from becoming stale by adding a commit id to it.
>
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> I noticed this while reviewing the documentation.
>
> The "fix" isn't perfect as the link might become stale because it points
> to a fixed commit. Alternatively, we could lose the line number
> altogether.
> ---
>  Documentation/dev-tools/kcsan.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index d81c42d1063eab5db0cba1786de287406ca3ebe7..8575178aa87f1402d777af516f5c0e2fc8a3379d 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -203,7 +203,7 @@ they happen concurrently in different threads, and at least one of them is a
>  least one is a write. For a more thorough discussion and definition, see `"Plain
>  Accesses and Data Races" in the LKMM`_.
>  
> -.. _"Plain Accesses and Data Races" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt#n1922
> +.. _"Plain Accesses and Data Races" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt?id=8f6629c004b193d23612641c3607e785819e97ab#n2164
>  

This seems like an improvement over what we have, so I've applied it.

It would be best, of course, to get the memory-model documentation
properly into our built docs...someday...

Thanks,

jon

