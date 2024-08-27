Return-Path: <linux-kernel+bounces-303640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3786961293
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56C5B2A3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47601CE71D;
	Tue, 27 Aug 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2sme2mz"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A18D517
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772620; cv=none; b=PDsSz1hxWIUUWDt4bUKwatRO0zqQ/k+0EvFn045GHlqqGcBrW//eaSzbCDs5DfyPa03VyXPw3BYBwUXZj0SawfVrWIaL7CnJLL+EOqX5933VtxBuqtlj4sbsxlcsIK2GeJOpG0hN27VEBuApHjW//rT9VYIS2zUDkT9xJ36iwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772620; c=relaxed/simple;
	bh=7jm3xFc0dXv2M23e5J5aWzOy2qkpwbTAtkHRKIIJvDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4QkmEEWXb2RTDbkTYGM9FTUe72LV3SbPiNF/8Xgsad41CzqDQrPnuURn34G4Tm1DarDoQ9fX73slWQLmEuN0yOcv/8ZgQbmDZNNv8uD+zxc30MtbZh/Ia1pMmrZelNRfcoyROGY8sKd/4IYPNNAsULLNBW4UlCkZVDy+mao8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2sme2mz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf7ec5c837so28938626d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772617; x=1725377417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jm3xFc0dXv2M23e5J5aWzOy2qkpwbTAtkHRKIIJvDY=;
        b=g2sme2mzTbMjScxXykedk8edulUNZw7LxqbRrGGUVaDW6apLLAw/NNvLulTDaDiucm
         iZQ8ONBbFQ0ULw5knlLJOd1jGCgck1VA9KT/LkWDhAlIDb5240Jqt9H+aidvl7+qglXK
         0PIHV0Hq7Mlenag0zQVMqYB17EssUcGLE76oiIHyoc9jkXdgVlPPNJgD0p+RpLeh+/IK
         4v5H4H6XaTrvRST1ZmISUuQqe2nmhm495Nza+nJb+B6r89biOg06l3NGhaajLmPmSxTe
         2chPfNKz5kGKK7F2gS5MAQ4juhK6cK33yrW39+WqNwd8tLeklFivTdUpOwTJ3HwLw0qM
         iTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772617; x=1725377417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jm3xFc0dXv2M23e5J5aWzOy2qkpwbTAtkHRKIIJvDY=;
        b=sek03/DWM3QcTWaB9+auQn35qYQcJX18+EWY9za1r+adSZ7WoMeCOzeny7dMTTnQ3T
         9elHCoyLU4psk304gpDPZCW2loeAkaixF/6xstU6RjyU43f7C4pEfq3bkQPE3tUa/mEf
         M5XAWhhTCl1iUrpCIfIvtH042NNb6oxVbeG8siB6mPIc/jQtm67i5pPg4GOvvPeOB0vG
         AkzUYnBmyiuPn8CTahwN/CdSCSy2wpNSshqOH8L4cT5JiBYOCRHne3J/uDC0yuIQqkv/
         RtCkVr83jatJiHR5nq8O1E9xpWWMhuykiPONbGa9QQkp6lKDCIKYYtZaMDatXmAahaB1
         EefQ==
X-Gm-Message-State: AOJu0Yw+YpNvBTIn29yX6ybSOZUhxoAFuWAOQRhLX9Fl9XeeS9h9Ge0U
	w3Qn20PMaAuaLBQajfIrp+uUyLuRF5Z4hDhSrYamD/sXXRU/+tBrCVA/ZF7x3QNZiKdAguLEF3U
	s9gEHGcR7rrUfgK8toWihrZwpYUs=
X-Google-Smtp-Source: AGHT+IGKLcIXb/w8cLd3ngwE7M+nOPJdIGuEGmG5ng8mqPOpTxobnxoZa8U6iwMkw193NPuj35ixsYTnbt7XHrZ0cGs=
X-Received: by 2002:a05:6214:4381:b0:6b5:7e97:7151 with SMTP id
 6a1803df08f44-6c16dca0124mr149980676d6.17.1724772617188; Tue, 27 Aug 2024
 08:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
 <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
In-Reply-To: <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 27 Aug 2024 08:30:06 -0700
Message-ID: <CAKEwX=MPM8v6WZ3XUD11MkZceo7Y82C0pMTwLJuZX67Wo27WbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 8:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Aug 26, 2024 at 11:08=E2=80=AFPM Sridhar, Kanchana P
> <kanchana.p.sridhar@intel.com> wrote:
> Yeah that's a bit unfair still. Wild idea, but what about we compare
> SSD without zswap (or SSD with zswap, but without this patch series so
> that mTHP are not zswapped) v.s zswap-on-zram (i.e with a backing
> swapfile on zram block device).
>
> It is stupid, I know. But let's take advantage of the fact that zram
> is not charged to cgroup, pretending that its memory foot print is
> empty?
>
> I don't know how zram works though, so my apologies if it's a stupid
> suggestion :)

Oh nvm, looks like that's what you're already doing.

That said, the lz4 column is soooo bad still, whereas the deflate-iaa
clearly shows improvement! This means it could be
compressor-dependent.

Can you try it with zstd?

