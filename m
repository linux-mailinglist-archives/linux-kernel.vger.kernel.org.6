Return-Path: <linux-kernel+bounces-307841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9414B9653AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B3D1F22783
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D518EFD2;
	Thu, 29 Aug 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lL37nd3s"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364C18991C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724975733; cv=none; b=b87Hm5wXjMnYKRxhZLJ0kgxYWlQGbq7l1TouRVZjJYKxrCbM6+pP4TSbNMoLZ7pIkvBdfGSoOSnOTXKX+ty4akKZpGmCBK6YZy60LT+2gA5u7TgODvly7+VljOptgS2teZfxgsroZHIB4Ku0v0eFsCvHBEgioSvzwQpidx+PenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724975733; c=relaxed/simple;
	bh=sdAvHc83bX/ecNjmq9gi7vYmOYomwU4OlkBorgJXCks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy2rShlcqnlKodbC51Y8tN97LrhZk609pLQjHNqe9jeD3asX8j+JP4v0/qopu/ezRAD7wEtUcQyzvKLW8YaKevWGora8js8Svy0skyZdEksIpyY7axuH0OP0gYM3pLM9HF8dE0vr0PAXdwszlk7DXLFTwfTWRdHzNiUEq0pnXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lL37nd3s; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a866cea40c4so141821366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724975730; x=1725580530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdAvHc83bX/ecNjmq9gi7vYmOYomwU4OlkBorgJXCks=;
        b=lL37nd3s0cnK3jO1uKP6Au9lIGDinMFHkL6lxfBNj59xHys3hurkYGSU4/PJy80YOe
         nLsHxYEJRNpnj55ukSya4/rgv083dqsh+UWXH4R6att/BLVxT14cuagkXvByO93M/Duc
         BxmDyjrdVix7YPX6dvcHSGdL7UQtovtr6H35kM+qVTTwzyOo0/BHUdU4fuSox1pRDBbi
         m4vKoaucgE011UY6P03+8FAjvWwpD8f12dlk+Xbc1slHEeXWSDrIywTQ+4aNj7A9CxNc
         EjkkoLJY2027oB2UjpJbXp3elRhRReKrLQsb6pP7EbkEl/255vh8JVBMZo5B/FEOuBz9
         MGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724975730; x=1725580530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdAvHc83bX/ecNjmq9gi7vYmOYomwU4OlkBorgJXCks=;
        b=Nx2SLhATh8HdOodvVx1/sdBdHpdJlc9xEzDkDAYozCIUbQtXN07ctMQRaWTFIlpT6C
         CrOeblKwBFghDQGCX4QJilsyIN9uNTgggHnqZIsI7bIJjhyOqlhN1V0zxfFtwzCfnvAp
         kVDjcVDz+E0ooxCyozjvzVrFanqAsPznasr3SrvWpmKaqva1UvPHZ6ULAiYqoUpf3bnk
         Zu9VpFcRpcN2Tlw2oD/gi/SyUYjkpwDN6uJambS9tL1jqtheVtotRXYhD94cNifdiy9D
         ptEGQgS/r/I6MGkz6jFW8qUvADATu/D7nHEwy2CTRgzV3oUfp5Z6uh6IxRye/CCi9HEn
         wxqA==
X-Forwarded-Encrypted: i=1; AJvYcCVKyQpSad2ZXPyZd2vhiFu5cLDGWVmH3AEv5h7/xDC7mDzo22DirWDifMEzwA3G3Lx4OndGtXy+xMwtwWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFBz9MOxU8DlNSuIF0TZrlxaAYH3cPL3mzte3+4cHAC3yErYK
	zrUsG3YMHbPYMz1le8GSAf0vUr3MCM1jH3fu3x+0aDqkom10C44vHY2nO78PpEPyMlayNv5OOvr
	fPwjvEBeDvj0VN7FNQyNi0ZZXTDbK/Cjl2EIj
X-Google-Smtp-Source: AGHT+IENa/McnSHCBU5bHgcdBBrsnWg/0vBXZsFH1k7w/8v7wrjS9aP1kCpbK58pID2mp/I9T4JoqKyeZ8/xsKvl17k=
X-Received: by 2002:a17:907:9717:b0:a86:7ddf:2909 with SMTP id
 a640c23a62f3a-a897f7894e5mr309081766b.14.1724975729054; Thu, 29 Aug 2024
 16:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com> <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
In-Reply-To: <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 16:54:53 -0700
Message-ID: <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:45=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Aug 29, 2024 at 3:49=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Aug 29, 2024 at 2:27=E2=80=AFPM Kanchana P Sridhar
> >
> > We are basically comparing zram with zswap in this case, and it's not
> > fair because, as you mentioned, the zswap compressed data is being
> > accounted for while the zram compressed data isn't. I am not really
> > sure how valuable these test results are. Even if we remove the cgroup
> > accounting from zswap, we won't see an improvement, we should expect a
> > similar performance to zram.
> >
> > I think the test results that are really valuable are case 1, where
> > zswap users are currently disabling CONFIG_THP_SWAP, and get to enable
> > it after this series.
>
> Ah, this is a good point.
>
> I think the point of comparing mTHP zswap v.s mTHP (SSD)swap is more
> of a sanity check. IOW, if mTHP swap outperforms mTHP zswap, then
> something is wrong (otherwise why would enable zswap - might as well
> just use swap, since SSD swap with mTHP >>> zswap with mTHP >>> zswap
> without mTHP).

Yeah, good point, but as you mention below..

>
> That said, I don't think this benchmark can show it anyway. The access
> pattern here is such that all the allocated memories are really cold,
> so swap to disk (or to zram, which does not account memory usage
> towards cgroup) is better by definition... And Kanchana does not seem
> to have access to setup with larger SSD swapfiles? :)

I think it's also the fact that the processes exit right after they
are done allocating the memory. So I think in the case of SSD, when we
stall waiting for IO some processes get to exit and free up memory, so
we need to do less swapping out in general because the processes are
more serialized. With zswap, all processes try to access memory at the
same time so the required amount of memory at any given point is
higher, leading to more thrashing.

I suggested keeping the memory allocated for a long time to even the
playing field, or we can make the processes keep looping and accessing
the memory (or part of it) for a while.

That being said, I think this may be a signal that the memory.high
throttling is not performing as expected in the zswap case. Not sure
tbh, but I don't think SSD swap should perform better than zswap in
that case.

