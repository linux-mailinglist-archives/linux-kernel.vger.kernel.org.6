Return-Path: <linux-kernel+bounces-251212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D759930229
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BE41C210C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72085298;
	Fri, 12 Jul 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0RF8ug1"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAB7F7FB;
	Fri, 12 Jul 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720823803; cv=none; b=sZHFw7Ua7c7WcHb9An0fr2l7m8WoWOT/oD2ORVSMWa0sxNDgQQGjII01eCtYSGeoIJp3Eluk8QguGz569bT4VxTPRFbtha7VuXOHj/dgXWFFHs3xA7V3OlSibcw3HwWVjkP2e4xj54WIl5ykesh3vU7QyhfJeJtrkCfHALGexPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720823803; c=relaxed/simple;
	bh=qkASzPzjNMSeYMQLDsLAKiFjJF2MAimi/PdOy1+z6fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOQtd167mdzE4ek/7i4Dd7sbX1aHk9cAMrQJN1ah4BYPV8oGgRaIda9wqQRG4FYZgTmPH5l2Re0Y8z8pMaJlqvAeZiCDaapuMxUIaquHlEuwFcf3shBANN9bnBsQta7Tek3kWozUbFd7E1OK8WR8wkmufzaCnv8QaKrds/ZSIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0RF8ug1; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e035f4e3473so2357174276.3;
        Fri, 12 Jul 2024 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720823801; x=1721428601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkASzPzjNMSeYMQLDsLAKiFjJF2MAimi/PdOy1+z6fI=;
        b=i0RF8ug1Iwzl1yIbQ4pofuDD6SNJIELVk9Lf3916WlzMozlDt1P92bDImvz8jHqtBc
         57u2DVAHOLmBaoOVn+eRRz5ij6IX9L54tLjsrck7rNOFGKETh1KdRqSP/WuuwoTaAMIm
         9Yuoz1huy7K5kYC/wVHQRhgMFUhjbkK76RIIT8c4SWbji84mh4NzLFzFm5mFOJibR1JC
         VOmmNpLuAp6rI4LNSQD/jab37ZkpfJOPZjyPjtSptBRFDjjc41fSYuUbQBaIibPbVvqn
         yk0McQuN0DfHhUw3sTVIFTTX6nZadhF0sYI5ESbVF+kQGsD16KknGMEc+0azgwUnGIhy
         j+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720823801; x=1721428601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkASzPzjNMSeYMQLDsLAKiFjJF2MAimi/PdOy1+z6fI=;
        b=wOg603HpddM39yCmUZH95unBOJ/xJUjTX6j0GptUzbHEiv2jGnTgvipS+0G9GT+SkW
         jNKc+aThYMpOnukpTRQt3KjCgxf+hOsLFt/mlz4y7FOfN9OexFnHdCTmVQdBdaz/50DM
         ruFahXQT22lZXxadIXivCL9qYioNamk1YpkXQ1PyiRLPB/F/Wl+uWmJirDDXSEDdLqiR
         Zy52aeG5Ky9IcBTp2dnjWuEEcZo8n6y3eL/0cVPz3hzPeVLgK96uRsbyEQtb2Wbr3SpN
         XvPpkMhsc7cqbM+9rSSD22feVzbmpbRzgmPt0+x2NAfNIZ59cVCIKeYKlx5K3GbSODwR
         sMnA==
X-Forwarded-Encrypted: i=1; AJvYcCULIJK0cVo1l1Yot2KGRrO0zAE1GE6QFN4qAhyA42hYkWu4juz6isWiV0SSBUyGfFL5zReg3i5j5Wyk6SMHPBgvFpgGxAjl/Zpk+JXEjpIWfIAlpzw7x49eNzwLJ9tOCWOgoaznH4S9
X-Gm-Message-State: AOJu0YxZfBS3XW8geLhrqW9c4+183kFb80g2JQdHjwOIMBItPwI7JyNe
	Qe0/dSr3BJDsUYy7GgEQDCYGXQcqsQcRptnaRV9atQiu5xQkohFcfMa8cjOb3YB9c/nvcrblPQe
	43v1LWyjfzTazxh6HyRqRqziRvFs=
X-Google-Smtp-Source: AGHT+IEfRngAry3fAk2Q0OflTPBnSqJsQeCzMJqXZvzmBdMAdeDaSX1xQkT/TMFBVwfkVTmmZPmrn/0AjlgcY2vWGa0=
X-Received: by 2002:a5b:b92:0:b0:e03:b61f:22e6 with SMTP id
 3f1490d57ef6-e041b039ad6mr14440524276.9.1720823800917; Fri, 12 Jul 2024
 15:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-6-flintglass@gmail.com> <CAKEwX=MmwqevpoGnskXrsYQWKOR8yx4t0moasVO=risu0P7-uA@mail.gmail.com>
 <CAPpoddenrRxWkSHTrrWEN9=uYGiQtvLDCifhAPyy2jkcdwfE-A@mail.gmail.com>
In-Reply-To: <CAPpoddenrRxWkSHTrrWEN9=uYGiQtvLDCifhAPyy2jkcdwfE-A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 12 Jul 2024 15:36:29 -0700
Message-ID: <CAKEwX=O+7=rTjaUEQ+3v=f9UHF_GOXWQO9HVZtLZOPCTRh6sVw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 2:38=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> 2024=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=97=A5) 8:53 Nhat Pham <nphamcs@gmai=
l.com>:
> >
> > I tried to propose something similar in the past. Please read the
> > following discussion:
> >
> > https://lore.kernel.org/all/CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=3DvMGhf=
F4iN2B4VKw@mail.gmail.com/
> >
> > But, the TLDR is Yosry was (rightly) concerned that with this
> > approach, memory reclaiming could end up increasing memory usage
> > rather than reducing (since we do not free up the page that fail to
> > zswap-out, and we need extra memory for the zswap metadata of that
> > page).
> >
> > So my vote on this patch would be NACK, until we get around this issue
> > somehow :)
>
> It seems the discussion on the thread mixed up memory allocation
> failure (system runs out of memory reserve) and incompressible pages
> (compression algorithm successfully compressed but the result is equal
> to or larger than PAGE_SIZE).
>
> zswap has been storing pages into dedicated pages 1:1 when compressed
> to near PAGE_SIZE. Using zsmalloc, current zswap stores pages
> compressed to between 3633 bytes (=3Dhugeclass+1) to 4095 bytes
> (=3DPAGE_SIZE-1) into 1 page. This patch changes the range to 3633 to
> 4096 by treating PAGE_SIZE as a special case. I could not find a
> reason to reject only PAGE_SIZE while accepting PAGE_SIZE-1.
>

I'm not actually sure if this is true in practice. While yes, zsmalloc
has the capability to store near-PAGE_SIZE objects, this also depends
on the compression algorithm.

At Meta, we use zstd. What I have found is that a lot of the time, it
just flat out rejects the page if it's too poorly compressed. Without
this change, we will not have to suffer the memory overhead of the
zswap_entry structures for these rejected pages, whereas we will with
this change.

We might need to run some tracing to get a histogram of the
distribution of post-compression sizes.

> zswap wastes memory for metadata for all accepted pages but reduces IO

Key word: accepted. The compression algorithm might already have some
built in logic to reject poorly compressed pages, preventing the cases
where the overhead might be too high for the saving.

> amount and latency by compressed buffer memory. For pages between 3633
> to 4096 bytes, zswap reduces the latency only. This is still
> beneficial because the rare incompressible pages trigger urgent
> pageout IO and incur a head-of-line blocking on the subsequent pages.
> It also keeps LRU priority for pagein latency.
>
> In the worst case or with a malicious dataset, zswap will waste a
> significant amount of memory, but this patch does not affect nor
> resolve the scenario. For example, if a user allocates pages
> compressed to 3633 bytes, current zswap using zsmalloc cannot gain
> memory as the compression ratio, including zsmalloc overhead, becomes
> 1:1. This also applies to zbud. The compression ratio will be 1:1 as
> zbud cannot find buddies smaller than 463 bytes. zswap will be less
> efficient but still work in this situation since the max pool percent
> and background writeback ensure the pool size does not overwhelm
> usable memory.
>
> I suppose the current zswap has accepted the possible waste of memory,
> at least since the current zswap_compress() logic was implemented. If
> zswap had to ensure the compression ratio is better than 1:1, and only
> prefers reducing IO amount (not latency), there would have been a
> compression ratio threshold to reject pages not compressible to under
> 2048 bytes. I think accepting nearly incompressible pages is
> beneficial and changing the range to 4096 does not negatively affect
> the current behavior.

FWIW, I do agree with your approach (storing incompressible pages in
the zswap pool to maintain LRU ordering) - this is *essentially* what
I was trying to do too with the attempt I mentioned above.

I'll let Johannes and Yosry chime in as well, since they were the
original folks who raised these concerns :) If they're happy then I'll
revoke my NACK.

