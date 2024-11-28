Return-Path: <linux-kernel+bounces-424184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A509DB166
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E5F165A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04D45005;
	Thu, 28 Nov 2024 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m5pFuPWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DDE38DFC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759957; cv=none; b=dV9EMz5X19aBsBlcDgzo393I2/xn4V9z6msCawx2CiAdva6JyFMaoV7n1ME3RjPKRSww6lHdCQwrhhjSf4ZAEPvx3TsmWpVAsK50X16ZhRU77+zO9e1BtQHKi9QOdn+klGcGigMeHvGVjsjxYvDkifykcDfACKrHnM7J0arLm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759957; c=relaxed/simple;
	bh=EFAkbkif0Gs/nkRjYXPe7137O1e2r9f1+s32iGQcAk8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fx6twSMffjPDnpI3+LgrfGG/CcRoKGdf04NHtLqWfXCbcRS717eDR5jlDbElNNyw8p+GBRxIScc9XLTWAYQr4QBIPxzv9bfv8k+Kg704TKrFgdVSNro1/l0Ym3dXtKFJ2FeJFTC0UUi3DLgt3Y1YuOkug8cH45RzNuvOXzKtnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=m5pFuPWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B164C4CECC;
	Thu, 28 Nov 2024 02:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732759956;
	bh=EFAkbkif0Gs/nkRjYXPe7137O1e2r9f1+s32iGQcAk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5pFuPWzaCXZfhX8m/IH+XI4GxSOyneAiLD0LI5PNLzm9pRR/Opifh2vz/66gr8nu
	 ZGmOjqTVbc+PI26GAMau5BNfkzANW92gIXomr4G4DboHudZm4IQSXAmaTEcgQViUBZ
	 0NeRFZuO4IUhCbgERWS2Zn4gvgDEbJvaA0lHOGf8=
Date: Wed, 27 Nov 2024 18:12:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Yann Collet <yann.collet.73@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: Question about extensions to lib/lz4
Message-Id: <20241127181235.d4dbd5a17a42d3b26130fa5d@linux-foundation.org>
In-Reply-To: <20241119235727.GA26223@hu-cgoldswo-lv.qualcomm.com>
References: <20241119235727.GA26223@hu-cgoldswo-lv.qualcomm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Nov 2024 15:58:39 -0800 Chris Goldsworthy <quic_cgoldswo@quicinc.com> wrote:

> Hi Folks,
> 
> Qualcomm is designing a LZ4 compression / decompression engine, with the goal of
> being able to do single-pass operations (i.e. we only read input from DDR once
> for compression and decompression). This is achieved by using buffers internal
> to the engine that store:
>  - For compression, the running literal we've encountered, which is used as a
>    search buffer
>  - For decompression, the last part of the running decompressed output we've
>    produced
> 
> The outcome of using internal (and obviously fixed-size) buffers for the above,
> whilst not making any changes to the LZ4 format, are as follows:
>  - For compression, if we fail to produce a match after running out of input
>    buffer space, compression will fail.
>  - For decompression, if the copy offset for a given block extends beyond
>    what we're holding in our buffer, decompression will fail
> 
> We don't want to constrain our HW as such whilst maintaining compatibility with
> SW, and allow it to compress and decompress streams of arbitrary lengths.
> Focusing on decompression for now, we've proposed an extension to LZ4 that would
> allow SW to decompress streams compressed by HW like ours, which is described in
> more detail here [1] in a Github discussion on the lz4 repository owned by Yann
> Collet. The changes we've proposed are as follows, though we would want to add
> a static branch check as well to remove overhead for those who do not want to
> use this extension:
> 
> diff -rupN "torvalds linux master lib-lz4/lz4_decompress.c" lib-lz4-patched/lz4_decompress.c
> --- "torvalds linux master lib-lz4/lz4_decompress.c"  2024-08-11 09:51:42.000000000 -0700
> +++ lib-lz4-patched/lz4_decompress.c  2024-08-12 06:26:33.986693000 -0700
> @@ -166,6 +166,7 @@ static FORCE_INLINE int LZ4_decompress_g
>       ip += 2;
>       match = op - offset;
>       assert(match <= op); /* check overflow */
> +      if (unlikely(!offset)) continue; /* skip copy with zero offset */
>  
>       /* Do not deal with overlapping matches. */
>       if ((length != ML_MASK) &&
> @@ -289,6 +290,7 @@ static FORCE_INLINE int LZ4_decompress_g
>     offset = LZ4_readLE16(ip);
>     ip += 2;
>     match = op - offset;
> +    if (unlikely(!offset)) continue; /* skip copy with zero offset */
>  
>     /* get matchlength */
>     length = token & ML_MASK;
>  
> Yann Collet has indicated that these changes could be acceptable and implemented as
> part of a LZ4 v2 block format, which would include several other changes as well
> that have been proposed over the years. The timeline for making / socializing
> this would be on the order of years though, if it does go through [1].
> 
> So our question is as follows: as part of submitting our driver, would it be
> acceptable to take the above changes?

It's unclear (to me) what are the expected effects upon existing users
of this library code.  I'm assuming "none"?  If so, please send out a
suitably changelogged standalone patch asap and I can add it to
linux-next for some testing.

When are you expecting to send this new driver out for
review/test/merge, btw?

