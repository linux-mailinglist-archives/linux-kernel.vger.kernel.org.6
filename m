Return-Path: <linux-kernel+bounces-292842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701495751A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1FC1C23A67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226F1DD384;
	Mon, 19 Aug 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWtzfSrw"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2E145341
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097479; cv=none; b=nPIjBrwirV1DkwszkP719tKkfwRbqvdEkWLR0Gs5ptlzJLLIB8JE26TuOtmlNBhA2Dr0NlwhhuKICjS2LWqTWCrxJ6wCtJLjRKo63J1QXgi7aGptMB1kA8YTw+E6IWBrBZxD81N1juPGEtN6wN1OLVGh/3V+2sNYawndC5d2dJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097479; c=relaxed/simple;
	bh=KeLyc45Fa3bvQdr6Qz/zOaHsEIUZHjNw5l90KB0Fe2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIpevzZAIwT0j54nrWxBP6a153xG/Ugp2PUJeZyEqXiS9HOFiA9iGsYqz2H6oXXLbUbQCVMUvrlux8U+4hIS+LvQ2bNLJ5IHnNVBFCX1a2alh+YIRVHByMAc50i2m4jvsg2Zvf4gWGjowwTEI8NjrRMjb6w2KYBFCVumpjI+RmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HWtzfSrw; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49294575ad8so2670355137.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724097476; x=1724702276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnpJD7zOEcGCzuRggKrq3czVGY129TNUmE3//qsWRmo=;
        b=HWtzfSrwOl8a6Hb7+DK3i2y5eg5z8Uk8xjmPKAFYp4x2zHgriLxt/F8SSjBagpw9xO
         vK5AuAsHLocWr1OBpd596MgoRv6T1GexDFngBJTWkPnyhYgyJewhfb+TIQWQsrKimeOF
         CMaDHvWnFDt5wSznRiG+R1HA2hOWG0CvAsMIya2bVK0l52DK2AwHFdNC9SwzOQotEd86
         shxzrx7kpM48y1x74WC8k3LohAHERXtkR8tTAvp7u0a5qDQjqC1Xgln/N6U3nxdFdXHP
         3tB8qMe8UKMNsq6HD3mQSYTh0r0FuZ165YEOOHZM+cYmCeOs40VxqyiVU+9KpRHYikHw
         JuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097476; x=1724702276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnpJD7zOEcGCzuRggKrq3czVGY129TNUmE3//qsWRmo=;
        b=Imr/BlPQlr8j4bqehPFM8EupkZady5kFonHJprJJ2w04bREkSQgzBllE50LNe8Ym20
         Rw78UijtE6lU4ttp3NfOoHJe55FtrASMyV1pjY7NdXhtO6qMHomaapbzLd4RfxMsrnZU
         2YQHuhFBaWgkvxvbbyFJOfOox2wJ7e+r8AwkIcE3/WO6mdsYTca3nyTr0ufQENGskHD7
         GWVRalbIfwNdQOVrThOJH8/ibTYWs5tQOo0FT7ItM3qTnKyZnqGIj9pwpQissebmYpau
         MAvgVRUOqqXr4fjoW3w80wSQ7AGyyXwgy8kuLg3oTvB4RdM4JGIV4tP3Sl4Jwhg2bcfM
         MNXA==
X-Forwarded-Encrypted: i=1; AJvYcCXuSVzFYUWQXqEmpa4lvTIlbhdPFRnL48MFnYdFVczkRnIZaKLE5KmAv3N32a0WWQ3Iu9gUU/9w3SSFYas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58cMsjGxej5uZUYagZnwt/mX5QEiM+Zaa2Zug6N7VezL9bp9X
	egkQq47BzQYW+Bxq3eAPZsAVGlUJK0/ZN4RUy3TH2hqdrYQsXuVys7pTRomZlrIVXZpdFTMV+Gy
	SgciACkwOfKTH/KeQX8rtfAy1caxE3awepKKw5A==
X-Google-Smtp-Source: AGHT+IGK0LY3tdtqWeFRG+uZZtVR/W7GoroGGMy79582gduYyn5m8Nqwz9BjE5mfCd13Nrjeql+K94+u37gPhcxzdQU=
X-Received: by 2002:a05:6102:3912:b0:48f:361:9fe9 with SMTP id
 ada2fe7eead31-498be9fdbc6mr800429137.3.1724097476320; Mon, 19 Aug 2024
 12:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuFDon59=Nw6WCdgp0FanZ1oE3dCkoq71EK0Bxe6Jhe_g@mail.gmail.com>
 <CA+G9fYtd1Hw9YLpceUAwwC+UytVQVXOET4gmGT9jiCgHa+WexQ@mail.gmail.com> <CAMgjq7Bz0DY+rY0XgCoH7-Q=uHLdo3omi8kUr4ePDweNyofsbQ@mail.gmail.com>
In-Reply-To: <CAMgjq7Bz0DY+rY0XgCoH7-Q=uHLdo3omi8kUr4ePDweNyofsbQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 20 Aug 2024 01:27:44 +0530
Message-ID: <CA+G9fYv42RAzYp6i-hUNz2dDn0i=_qoQXtjgc6h4z+wY9-GREA@mail.gmail.com>
Subject: Re: gcc-8: mm/swapfile.c:863:40: error: array subscript 1 is above
 array bounds of 'struct list_head[1]' [-Werror=array-bounds]
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Barry Song <21cnbao@gmail.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Aug 2024 at 17:14, Kairui Song <ryncsn@gmail.com> wrote:
>
> On Mon, Aug 19, 2024 at 6:16=E2=80=AFPM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Mon, 19 Aug 2024 at 13:58, Naresh Kamboju <naresh.kamboju@linaro.org=
> wrote:
> > >
> > > The x86 builds failed with gcc-8 due to following build warnings / er=
rors on
> > > Linux next-20240802 to next-20240819.
> > >
> > > x86_64 defconfig gcc-8 build failed
> > > x86_64 defconfig gcc-13 build pass
> > >
> > > First seen on the next-20240802 tag.
> > >
> > >   GOOD: next-20240730
> > >   BAD:  next-20240802
> >
> > Anders bisected this and found the first bad commit id as,
> > aded4352f648 ("mm: swap: separate SSD allocation from
> > scan_swap_map_slots()") first faulty one
> >
> > - Naresh
> >
>
> Hi Naresh,
>
> Thanks for the report, the problem will occur when CONFIG_THP_SWAP is
> disabled. Can you try the following patch? I can confirm it's fixed
> with my test.

Thanks for the patch.
I have tested your patch and it fixes the reported problem.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

- Naresh

