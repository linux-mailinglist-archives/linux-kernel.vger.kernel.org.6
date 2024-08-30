Return-Path: <linux-kernel+bounces-307848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5981A9653EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A3B1C222F2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA9F20EB;
	Fri, 30 Aug 2024 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afScu07F"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4229182
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724976896; cv=none; b=Ib8i8Zx0mLMClPxwpwv1+VR5ty9Tw+P6k9Nj1xDFZlsdqtacupqoJaQ5ObphUzbNvc2pRnSzqHfXGZC5PEj45wJMU0p7o/fsdHiKHPJSQ/aQF/fxS4ikYrBE7D3vmG732S/c10nWYcjbPmJ5gkz8KLcvHk+0g2plNXV0XOELn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724976896; c=relaxed/simple;
	bh=R7Nb/imqwjRvNHvXv+72s2YMbv5nBhWUPovMyoDLXeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y27WNVNKCoBlIAZUgwkzZbjcHBJ1np0EprWVJwG5SmMKyMADsjQZH6mfntqUk6dXBwdulMqdSegnSvvtgpRPOEpSr3pKoS84WLS+qnArcbdhXBsWe1dKaljR2binCkWJDGJYdnEG7DPxZwbC7/Cc+a+WjzDL3CPbZAx1G9h5G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afScu07F; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334879ba28so1666524e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724976892; x=1725581692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7Nb/imqwjRvNHvXv+72s2YMbv5nBhWUPovMyoDLXeE=;
        b=afScu07FwXw3jBejUvKiHiYPhkMlSe9J5g8iMSK+TWuKo6DMSZqExBjECF9/RNh6zL
         YEjDU5qYjfJ56OI2PP00lu7UcO/E+1ZjgktWGY2ImQoQfUPX04zOqSB63jo3nVVY/UqG
         INvefurUD33LqsNppad1P7oQDGE5qKE6RdkxEHSK79e72g6LNjrYsR06LOE8Vu/hFY5r
         AbgkcsnS26xcr3fRCyJxndbotRFbHQKuKelP/hpTz4R16NibtV9ua8RAQfoa5gqvgZzH
         EmIGKr+WbD+jxBKcbXxPkINn8dCgKHhUWUnpXYYTG6Xafigxiv9pU7Wt074z3yQEiYZz
         UTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724976892; x=1725581692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7Nb/imqwjRvNHvXv+72s2YMbv5nBhWUPovMyoDLXeE=;
        b=oPZBKxrlT1v7uN655MHmoBZ6UAMNQ1PXLhD9QCMMx1bFf0gRbx+4f4WpgemHWZRB6g
         cERtepFcONONIOQnxWVvQRdMK4tGacAMP1rmIpGQjTmPX3352t12jKjuU8JoVXEGW3vW
         oE4ydT9knc4HM95fVtvct6zsqtg17nyUywLks82horLQwZ35g0/2uTqTIhwOFy979+ru
         y5BBPoxXvXNuooD4PsehebeAoYyFOBgY/xhNk8Ouuyd3Fntb8obtln4qNr5k+CdkS+yj
         FywJ+xZRfErdjNL20EmToLQKvwIpMPCbQabj6jnVcBMqVvQncEiMOsSKgBj/cSKd2rp2
         Ltzw==
X-Forwarded-Encrypted: i=1; AJvYcCXATbvopFXrMV7KwK+MDjPLTSBX2+nqIJpcR5iNFSOCN1QaN8AmydHyco/ZAPmHuFi7SLDtdRsRYknBahs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3uqqtGHfcWgxcAmFHLpWyY4HkEuc1KnboPHQBd9g+2GtEstXS
	HGwDquGF48NcFkkrwcUuybiN4cWDOIsm3reAX7xbRX1BDHuGsO/k7o17Q57rQfvcTr1weN7t2nI
	4ej78aYXS2CRvDqv3rnZDRPNy/5qNH/8SAP7/
X-Google-Smtp-Source: AGHT+IEbKyyCb/ML5+UgYqhqK1/RS6RIvLVjm0XzQnqug7sH8rzZxXoc8TXSfeuvq+9nVj+ZlrnSr4B6zMcyIpPMF8U=
X-Received: by 2002:a05:6512:282a:b0:533:6f3:9844 with SMTP id
 2adb3069b0e04-53546afa387mr160737e87.11.1724976891667; Thu, 29 Aug 2024
 17:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
 <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
 <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com> <CAKEwX=Mz_tmU1Qjm8ExfnmCVvkNcd2cYpcLQLZBBx0QCXJvOpA@mail.gmail.com>
In-Reply-To: <CAKEwX=Mz_tmU1Qjm8ExfnmCVvkNcd2cYpcLQLZBBx0QCXJvOpA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 17:14:15 -0700
Message-ID: <CAJD7tkY9SQ3NOukRY3Zh9ML4yyN-zC0krNkpoUzeCd5tyE1Zgw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:06=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Aug 29, 2024 at 4:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Aug 29, 2024 at 4:45=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > I think it's also the fact that the processes exit right after they
> > are done allocating the memory. So I think in the case of SSD, when we
> > stall waiting for IO some processes get to exit and free up memory, so
> > we need to do less swapping out in general because the processes are
> > more serialized. With zswap, all processes try to access memory at the
> > same time so the required amount of memory at any given point is
> > higher, leading to more thrashing.
> >
> > I suggested keeping the memory allocated for a long time to even the
> > playing field, or we can make the processes keep looping and accessing
> > the memory (or part of it) for a while.
> >
> > That being said, I think this may be a signal that the memory.high
> > throttling is not performing as expected in the zswap case. Not sure
> > tbh, but I don't think SSD swap should perform better than zswap in
> > that case.
>
> Yeah something is fishy there. That said, the benchmarking in v4 is wack:
>
> 1. We use lz4, which has a really poor compression factor.
>
> 2. The swapfile is really small, so we occasionally see problems with
> swap allocation failure.
>
> Both of these factors affect benchmarking validity and stability a
> lot. I think in this version's benchmarks, with zstd as the software
> compressor + a much larger swapfile (albeit on top of a ZRAM block
> device), we no longer see memory.high violation, even at a lower
> memory.high value...? The performance number is wack indeed - not a
> lot of values in the case 2 section.

But when we use zram we are essentially comparing two swap mechanisms
compressing mTHPs page by page, with the only difference being that
zram does not account the memory. For this to have any value imo it
should be on an SSD to at least provide the value of being a practical
sanity check as you mentioned earlier. In its current form I don't
think it's providing any value.

