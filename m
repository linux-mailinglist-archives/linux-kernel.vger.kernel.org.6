Return-Path: <linux-kernel+bounces-394281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA69BACD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C11281767
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15C18C342;
	Mon,  4 Nov 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3WyJhmn"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FB62CA8;
	Mon,  4 Nov 2024 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702900; cv=none; b=RpOsZhk/gb3AnZaP2ex/CngJc4ax6ECQrVk9uAzFRrPqQJYTsN0ezaxqmuu8/xMX+5Zkq1pvELRwgCJGkvMc+qQjtOWVdGPpLddprzHwX/sDGEKsLyRoS+2gvzn7GLGMmowEWSGqvFY5sF4w2fN7HtoF95FUk6td9XmGf0wbiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702900; c=relaxed/simple;
	bh=jlfO/UikiZs9hQJpMwu5V3TVRejUWA79MBHRzI7bCh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc/baZ0iX37Yhd3iN7HfYJNPkCyX5i4If8TwD+ZTrC3IhObJXlsK+Drsv46VxOcdKm0mz47jO4qMMpeWQpqvZXIuDlAMsmxO8E2s0QY7nm3YYY59GhvU7r7s6t1hoeDag+zRzmfRxqXEYO6solB8VhVS9MoAaYjNkggWUJDzZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3WyJhmn; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc04d4777so1885573eaf.2;
        Sun, 03 Nov 2024 22:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730702898; x=1731307698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoFFRDhx7P8Vjncyt+RKO34ZfvsUqWh2Ai+071gCkzA=;
        b=V3WyJhmnjSoE6Evhj7QNRWQ7TCFjpraSyOVs8A+7afPqVbSuyYoGvJBdH6BTkU41uA
         Pnek7GHdohXODgT7oI2ftre7YH2F8F5NepBe9FqcSCG+RBKRxaFDCc9nWBtGtZ7ACN1X
         nOkFog/R87ospyGStzsli4pNOJLK1M6UF+SA2n7fA1KLv6n5dUiRK+WerJ1q16Qp1S5i
         ItN5BWqv8l0A2YvctGIKOMUU+RGKUasxR+zsWHkrdNF8SckyiSPdbYTo3eUO2BMWqNmp
         OPwJhYNZC2hWxJO5OYJjs+O+/8nzpxXRvk4TnWBY+jYgzTPWfkmg5NdiffvjZeNA71LX
         1xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730702898; x=1731307698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoFFRDhx7P8Vjncyt+RKO34ZfvsUqWh2Ai+071gCkzA=;
        b=aRVTT4LeKD1AM8F3GvpgJTVgwjXjgYkBk+a87J897CeZ23C4e2SmuwoTQ5LLuulbDZ
         24kpWzr1RxinrhCpvHIy+XLCtEp29a0X/eLGa5ey2JbH1Is1hp/hM5XdgnZp7nlO7gbO
         JUv8gRtPi3MwHDpukvP7/rF1VHgdZRYXJgQ7v5rbPSY4Fg8hf4H9uFijvGdoj9iMm1Cl
         acf9LvoKLVXJBFKO4HUvWZJ7PryF0E9W/eFhWip+g5teD0/l7LkIZ4owILAFVOaPDsht
         8xg8dSI4mNDLIm+0ymr2e8HiVgLso6fuD8eTQj/Y3pB27lddfqrQ2za2qeOSAoYrs4CC
         WSgw==
X-Forwarded-Encrypted: i=1; AJvYcCWPn8SyiCOT0jBO42eTUNrPUgOrP6efnTVisAHcgQRYWy+4xD4aaVbBgTNy3ZudN1y2RQbSyeeySjCHaMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIk8ZR2phoNmkaVkVJ5Vj2g+TvvyM9aeKBRZvgy0/FMPgwOnU
	Tohp+O0kCk0X/mNQmaTpSQ/PlezMR/pq5MuqjEWD9m9c7X6JsOX43BLxrY3dSitxlWz1uenaExk
	CeudFS9pSRVTSE6hPTT0kfQ/wZPyIvw==
X-Google-Smtp-Source: AGHT+IFAu7cciozCRJztsew2CmEuJHN5eOvT64Hy1mT2HOzMA7Jtg0n6/YzNVPREoGGGjsknmB3pBOk5A19eeHHV6GE=
X-Received: by 2002:a05:6820:1ca6:b0:5e5:c073:9ea5 with SMTP id
 006d021491bc7-5ec5ec942e3mr10980119eaf.6.1730702898198; Sun, 03 Nov 2024
 22:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com> <CAMhs-H9M+ZW1c7Wrdc0ff_hD=hrbq_S-KqzzjH7ux97sZO4mHA@mail.gmail.com>
In-Reply-To: <CAMhs-H9M+ZW1c7Wrdc0ff_hD=hrbq_S-KqzzjH7ux97sZO4mHA@mail.gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Mon, 4 Nov 2024 07:48:06 +0100
Message-ID: <CAMhs-H-Fy6d4q6dQzG9Gik4jj10tXUHcE8BXZW5iRpbYDW638w@mail.gmail.com>
Subject: Re: [PATCH 0/3] clk: ralink: mtmips: some fixes and sdhc clock support
To: linux-clk@vger.kernel.org
Cc: sboyd@kernel.org, mturquette@baylibre.com, tsbogend@alpha.franken.de, 
	yangshiji66@outlook.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:41=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Tue, Sep 10, 2024 at 6:40=E2=80=AFAM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi Stephen,
> >
> > The following first two patches contains several fixes for having a cor=
rect
> > clock plan from the beggining in old ralink SoCs that could not be test=
ed
> > when the driver was mainlained due to the lack of users. Now some issue=
s
> > have been reported regarding RT3883 in openWRT[0] so I am addressing an=
d
> > fixing them here.
> >
> > The last patch adds new clocks to properly support sdhc 48 MHz clock fo=
r
> > Mt7620, Mt7628 and Mt7688 SoCs. OpenWRT people updated to use SDHC upst=
ream
> > driver so they were forced to add a not desired fixed dts node[1] to ma=
ke it
> > works. The correct thing to do is just support it in mtmips driver. Hen=
ce
> > we have add it here.
> >
> > Thanks in advance for your time.
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > [0]: https://github.com/openwrt/openwrt/issues/16054
> > [1]: https://github.com/openwrt/openwrt/pull/15896/files
> >
> > Sergio Paracuellos (3):
> >   clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
> >   clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs
> >   clk: ralink: mtmips: add mmc related clocks for SoCs MT7620, MT7628
> >     and MT7688
> >
> >  drivers/clk/ralink/clk-mtmips.c | 56 ++++++++++++++++++++++++---------
> >  1 file changed, 41 insertions(+), 15 deletions(-)
>
> Gentle ping on this series :-)

Another gentle ping on this series :-)

Thanks in advance for your time.

Best regards,
     Sergio Paracuellos

