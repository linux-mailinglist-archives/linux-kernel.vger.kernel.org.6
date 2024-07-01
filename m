Return-Path: <linux-kernel+bounces-235846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC591DA64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F085928212B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854D12DDA9;
	Mon,  1 Jul 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Oy0nN5QB"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464712D747
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823628; cv=none; b=LLjHk6gAKhCfqCFqnOcY7+gS/M2Cu7SAxLhJfl4rEXXR6eshsuxvjadFAzMksIPlp9ggl9Z/pRaHBJvkov1xOopBsKMpfYA/wJkS25uYLUPpqRiclpSaJTZpP2CXVN43lDWqFT8iL3bWvZj3wvuUPb2+FQoHV3P1SX8Yzzl2b/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823628; c=relaxed/simple;
	bh=J80nLZeZGFfK8pG+9YlUTYaSTzxaU2ZIMPTzngHBP8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3qSSpNIwnSpwGK4hhp+PpNu0b0qZs8vwc7vhQkthj4coWVcl6oaqUL0cBU7kSzcuEI7T9rY2maT0J1EMgROXeVrOS459vSLaJZMhmbKiRz/+MkIaCPZslJ/ZULNeZpdOaQcaBEFj4FZ58VvejwS7+BGnSmCgTZ570R03+AsJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Oy0nN5QB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3672aec418cso1496373f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719823626; x=1720428426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J80nLZeZGFfK8pG+9YlUTYaSTzxaU2ZIMPTzngHBP8Q=;
        b=Oy0nN5QBODmwJ8nHAohQ/YLmEPveQl1kccDscCDwh2VaxtpAmaYdYTpOo9IsS6hzWv
         jODEAB5cznuSUdSDw2q0J3vEqDkbO50q4jr1A7bDQ0TdjCunuojA9OKCBssyJ7G0iSD0
         iSv/xWEzys6wBZTN/lwuyw63CeS5wgsJDKp/5R8dVkJE90xkFLpCTKv6gq1h5kKhxJtC
         IjQtCZQsqVTdeNd6wWhyz6CVGAI2tTfXlwvY58GvNbMzRAsNUnjns6e42SSdJElMnELM
         kpSqat8jxfErzqOeWYrUtFfkzFxNu9+DVOyK9LfmNik16CuTvgpc652jugppsYnpC9dd
         4pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823626; x=1720428426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J80nLZeZGFfK8pG+9YlUTYaSTzxaU2ZIMPTzngHBP8Q=;
        b=UoMpqTTJlKpSjltnKScoaim+FTYDMhLRxbSilpnRvE0j9NgEXXf5X+UkZTg3W60SY/
         G9624e+kzsR8jB03GQgwUHXyF/M6it00WRw6r05gi3Uysz4v9pl8ZcwGTPonYyUGQGvr
         +t2736myeAWsN0YDd0SYVuMoigRn10ktdQYH4uyMPtI209TVSumlIV4hq20vjRnIUdTS
         fWrrUB0yzTLyk0gOGapz95iAMhbH1Mdc4/FWvUcmBRfrZc2GAkhw/4tbI4niSMZBTEL2
         a2pr1jzOKQAzLLcC63CN+UJmaZON7oHNFOvk/SLyQEKyAEo5JoELzI3WpXSbxhWhAHfV
         y9rA==
X-Forwarded-Encrypted: i=1; AJvYcCWWB49fT86uSh9B1hXll76Di+DOzof+RXMUNHTJwS0fv2ahYeKKD5rPd4s4UCZ+U5j2XpL83/RqFtoBiOMOqAim9uRU3q5SZ9Es/lcn
X-Gm-Message-State: AOJu0YzkwXfVNKZzKKkrLteBZRBrFqwY80e0wAFhwPDosdvdYN3mwaBY
	cdqZKtekJano4JjVhfpImjwNrUaXNQ11m/7x8BK8eMy5VeznlW2CB0h/S3pmo0/RsoBDjLRL2k9
	lLKd+TdJGEXBPynTtlxAhEGpY2h2A+QGlEhbc3ima1bVhEl1OD9A=
X-Google-Smtp-Source: AGHT+IHZzhPL1bKVGPiXe8Dh3Q3HBIQDIiL2qqpYO18rzYiBiZCgigcg19dFmv1YMa3eNChS4ZAzrtshCj/BZXUawAk=
X-Received: by 2002:a2e:a889:0:b0:2eb:dd0b:b9ec with SMTP id
 38308e7fff4ca-2ee5e3a30e0mr38212871fa.20.1719823605163; Mon, 01 Jul 2024
 01:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628080146.49545-1-andrei.simion@microchip.com>
 <20240628080146.49545-2-andrei.simion@microchip.com> <CAMRc=MeJyByMvcFT2aJDK87bz4=+UXEuMtQ4G4MZUAUt39SS1Q@mail.gmail.com>
 <67d3646f-1b84-4d2d-9e36-be898f13be90@microchip.com> <CAMRc=MeJM4LmczCbZ8bKytLZKY_mP=Q8eaUprLMmO8BYHecStw@mail.gmail.com>
 <c1b53308-d1d5-412b-9558-9f40dd237397@microchip.com>
In-Reply-To: <c1b53308-d1d5-412b-9558-9f40dd237397@microchip.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 1 Jul 2024 10:46:34 +0200
Message-ID: <CAMRc=Mewx0NAdFBX6hpes_oa62M_Jp=LtzAPK73tZv+tKxnScA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] eeprom: at24: avoid adjusting offset for
 24AA025E{48, 64}
To: Andrei.Simion@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, arnd@arndb.de, gregkh@linuxfoundation.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	claudiu.beznea@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:23=E2=80=AFAM <Andrei.Simion@microchip.com> wrote:
>
> >>
> >> For those types of eeprom 24AA025E{48, 64} adjusting offset is not req=
uired (at24_get_offset_adj()).
> >> So, indeed, it is an entanglement in logic.
> >> To keep the implementation as it is:
> >> adjoff (which is a flag that indicates when to use the adjusting offse=
t) needs to be 1 for old compatibles but for these new ones needs to be 0.
> >>
> >> I think that is enough not to break the existing users. What are your =
thoughts?
> >>
> >
> > Wait... is the adjoff field effectively a boolean? Why u8?
> >
>
> struct at24_data contains offset_adj which will get value calling at24_ge=
t_offset_adj()) if adjoff is true (1).
> Yes, adjoff needs to be treated as a boolean. I will change it in the nex=
t version.
>

No, wait. Why can't you just do:

AT24_CHIP_DATA(at24_data_24aa025e48, 48 / 8, AT24_FLAG_READONLY);

and avoid this whole new macro variant entirely?

Bart

