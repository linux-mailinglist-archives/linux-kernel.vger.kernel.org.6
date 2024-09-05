Return-Path: <linux-kernel+bounces-317738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459896E30E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93B5B25498
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C12F18DF81;
	Thu,  5 Sep 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XuETjLHE"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25445154C0D;
	Thu,  5 Sep 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564106; cv=none; b=fmWd5HYNloninMTPTSLKzMcfSfY+N6uPeY+zpQrcL/jMPGpAzcm3NZxOQNXesAjgkcn9dRwzUky91R+NPVs3/6UsrXNYuszIg5EUE/MKGQL4R2eg4QMb3boewfYGUIgszyM+4sJeQLN3ny8MOqm6aa0pSkeLvSABqu/YRO7BLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564106; c=relaxed/simple;
	bh=Zt80gJU/E8JxJfEAs4fZfFSGot7J84Ph3ZlW7fe7r6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlbE4FFZXABwP9GNX12cXWfeoNz3PrdcWOF3HB3E57iUdnR/X9lxDELTpFbb/VqAD6Rb3H5y8sSF58gW+rypGnEIC6kA4zxt073g4NB0W4LvXz/d9sH7ph8SLBNssYmm8UeJBJHWvIoJpPbtrMGMJudteTJTtVpnbYCvjJr6ScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XuETjLHE; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3BB5842B29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725564104; bh=uagHCIsyAYAmFT/BSQs+jNz+k84PCsehN66qqYLVdCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XuETjLHEeWRQ64a+XV7bXheW6gFnEOf3EkGW34ycSkRMNTB5D8DJANn/r3IxhBtz7
	 o39HP6eUQ7f3gDZ5Z/Jx3NPjI5iMv5yfdl5X94SGlG5qTW4LmJrzdfqAWkkq98WkMg
	 fNqbXfUd8DDi0Rzorgj9qAtDZ3aV6gm4hFJRnnPTrHaZsAxmJafxbDA6Tdx7sj7rKo
	 2D7Qn5Q92y3GvXVmTVoNTjo1QwmkqkTBk6EBeXn/euxgMpLg8ieJ2tjUD+HLzRsfqp
	 rZRd9Su3N3yNNzSsHuLx3N8NZR4Z1RkvQLSJ2U44YZ+S/VG9dzjIRN3dZvgaHFHdll
	 xnHKCv0du+/Iw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3BB5842B29;
	Thu,  5 Sep 2024 19:21:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Kreimer <algonell@gmail.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse
 <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Andrew
 Kreimer <algonell@gmail.com>
Subject: Re: [PATCH] docs/mm: fix a typo
In-Reply-To: <20240902183210.2130-1-algonell@gmail.com>
References: <20240902183210.2130-1-algonell@gmail.com>
Date: Thu, 05 Sep 2024 13:21:43 -0600
Message-ID: <87y145hpo8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> Fix a typo in documentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/mm/hmm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> index 0595098a74d9..3dcf1b69e807 100644
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst
> @@ -405,7 +405,7 @@ can be used to make a memory range inaccessible from userspace.
>  
>  This replaces all mappings for pages in the given range with special swap
>  entries. Any attempt to access the swap entry results in a fault which is
> -resovled by replacing the entry with the original mapping. A driver gets
> +resolved by replacing the entry with the original mapping. A driver gets
>  notified that the mapping has been changed by MMU notifiers, after which point

Applied, thanks.

jon

