Return-Path: <linux-kernel+bounces-369253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C39A1AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA12853E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C371925B1;
	Thu, 17 Oct 2024 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRdBujC/"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AC1922CF;
	Thu, 17 Oct 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147311; cv=none; b=geB6nuYWg8eCnAkC8myChILaJh9MB9QCzxh83omQOs6H1326QZTuI/6AJA2GdKq9xKlez8Fuc72QEQ2tDI4WA3n+75C694TGc9SYgAZbUtbFN2Zj8tc/Lwpm9uuVVwoqscurIcROSiKIZyzuds3/XP+g7G8KzTh0PJ4LNNjDQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147311; c=relaxed/simple;
	bh=JhAptwO2JSYZHXDh8T5Sim3dYS875G7Jg6ADu8A9wVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED8gfSFCBftiFq6LtxPOb6vhof6AX1WGLN6mEsMGv6AwdRenwC/gB1y9W+mmwmpkyZMzPpltjaF2HSrWLGUfSMJCBjl1VsHxQVLf1zZsoN1Be//z2T5gEr8HSgDpGifaxfdiTKP4PcToCI1KMxuIlkv4H34Nel0JX3pqDtpECbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRdBujC/; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5d3f039ccso345111b6e.0;
        Wed, 16 Oct 2024 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729147308; x=1729752108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC8B12diaw0316EjryPxswII1rxWpWPO6nyoBVEE4H0=;
        b=MRdBujC/vwLGnc0aLuD6Q6AvZW8neKublmCRAygDB8TXlBP6brwz5gDB0SsazdpFu0
         0Wy2ixxGSNAxmxzzgMBGmVbB/eRZ560eoL5apEBnQhB2NQrnlNcaNcRpGlx0LpKClaZN
         gYF5wP1l47v7W4wfzqfFvV6+OpvIhZjESbe6eEy9Gapm31/pKmadQ+3ohtwKixNHGNwU
         6Y3uz4C7/QUSh5MxA6vJpNiOUYqBjS+8gC/vZq5W8k7JKVSD1F805v1vmdcvmmXnpdy8
         DoLyZa4ir0NFW2c8qwJQx0NDLuPnd5GM3wAqjsjyytcsuD+o1UqR8UxLBnUHDHjD9497
         UMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147308; x=1729752108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC8B12diaw0316EjryPxswII1rxWpWPO6nyoBVEE4H0=;
        b=NoiPONAVitua/72OYd1SXn+SRjBWDzYBYm8FgOdhk0YP/ryq4aUvZMeNjcMu1lyuM4
         OWqVyFFTrSk0yjoEAYTHSBiIYOoD9MP8Xgmf5CeFFL92JlhIOhwA+PuC2XVqb/gOPynr
         llN1eKUJkJmH9S8+iA+xKEAB92FB1dUvPfgFl/R06lFRCA4pIcrt/RWVcLrKA2GUkyR7
         pYyDqmAr/WffT3wfjNiXn/hvgbUK1pXfRVkKJpPUW2GK3p/PgDSLztwhD54X1CS/IzjQ
         6ktsK7g0O03pKwRj3yhTCC+F3k/cbZUeR3UvVo1egLuxUF5TjxvlAbXEtci3AcrwVPYy
         pb/A==
X-Forwarded-Encrypted: i=1; AJvYcCXnYYGZ9btzHB2C9e/bohjzFXH7CQdGyKvngvRxAp5Qf1Lwl5WzsrhFPQpD9GdlqNRxSl6FVsT+8O0JWmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiHe+pgsgsSFUTSm22UOahFWpuLCfqQ30JFWcTYIvQDliHAVm
	FcYMSDR3zQ1HNwC7bUdkwYP5pRWIr/t3rAuY+Xnl3fWaYJw4xFDAhL3XSz9dZ0k/RVmX3ahy7S5
	ytUz9kD0TticrY3Cq4Mv1x5XrHORXvQ==
X-Google-Smtp-Source: AGHT+IGZU49YeXSxAotjEP5RQHN+ozUmRXiWYgPhtvis7m+KY8OMeQym/W/Wnr3rOZmIS67qpIEfH40VNNTZomRinzE=
X-Received: by 2002:a05:6808:170f:b0:3e5:e243:1861 with SMTP id
 5614622812f47-3e5e2431942mr8768458b6e.27.1729147308442; Wed, 16 Oct 2024
 23:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 17 Oct 2024 08:41:37 +0200
Message-ID: <CAMhs-H9M+ZW1c7Wrdc0ff_hD=hrbq_S-KqzzjH7ux97sZO4mHA@mail.gmail.com>
Subject: Re: [PATCH 0/3] clk: ralink: mtmips: some fixes and sdhc clock support
To: linux-clk@vger.kernel.org
Cc: sboyd@kernel.org, mturquette@baylibre.com, tsbogend@alpha.franken.de, 
	yangshiji66@outlook.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 6:40=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Stephen,
>
> The following first two patches contains several fixes for having a corre=
ct
> clock plan from the beggining in old ralink SoCs that could not be tested
> when the driver was mainlained due to the lack of users. Now some issues
> have been reported regarding RT3883 in openWRT[0] so I am addressing and
> fixing them here.
>
> The last patch adds new clocks to properly support sdhc 48 MHz clock for
> Mt7620, Mt7628 and Mt7688 SoCs. OpenWRT people updated to use SDHC upstre=
am
> driver so they were forced to add a not desired fixed dts node[1] to make=
 it
> works. The correct thing to do is just support it in mtmips driver. Hence
> we have add it here.
>
> Thanks in advance for your time.
>
> Best regards,
>     Sergio Paracuellos
>
> [0]: https://github.com/openwrt/openwrt/issues/16054
> [1]: https://github.com/openwrt/openwrt/pull/15896/files
>
> Sergio Paracuellos (3):
>   clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
>   clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs
>   clk: ralink: mtmips: add mmc related clocks for SoCs MT7620, MT7628
>     and MT7688
>
>  drivers/clk/ralink/clk-mtmips.c | 56 ++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 15 deletions(-)

Gentle ping on this series :-)

Thanks,
    Sergio Paracuelllos
>
> --
> 2.25.1
>

