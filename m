Return-Path: <linux-kernel+bounces-539853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA42AA4A9E9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC30E189A9B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6E1D54C2;
	Sat,  1 Mar 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJrNC32H"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719461C5D79;
	Sat,  1 Mar 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740820331; cv=none; b=GVs2HRKdVpgFOaitW3dWfYMY31pkzKMXqQYTxwoR2qjiXhZrS89uycmEFbV0fYq61VPtOwClehDGKaZX/HkTTmGvso6ouWFteBVNhyu+aTwUOnsQ0qj85Y1o++UJQvPq6brFpvseHWMm58zMBxuc8V246BTRmiKSTgfB7n7AN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740820331; c=relaxed/simple;
	bh=62M00yAg51rrJZ04g8zC95EvNZ84F8x3AjdAvJoHunw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=na178HSb1DbRoVX5MQYICnd+wSfc/vLQX5LJRqAQZXuQPEM8myj0TSk6/TWfaWckVLMdyxhtm41FaWItiODOErebaEMduPtGpCV09VfVF34ELsgqQR/5Akp0BAZEliiCMWhCHAph2KPLG3ix93mVXwaGepI7UhuEIwE2wKbXkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJrNC32H; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso4458983a12.2;
        Sat, 01 Mar 2025 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740820328; x=1741425128; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62M00yAg51rrJZ04g8zC95EvNZ84F8x3AjdAvJoHunw=;
        b=nJrNC32HViEFftZ8PYK7V4DYwlat8wJPA9ubi3zwMc0s2vKEI7YgYN7Zyr3NPNmjoO
         7TZvnZ71INCQqG/GWZl4YI06GEvYHhPZHasXCJq9RgsxoqVXDqYJsyqMLwpTKDDgTLKS
         Q7vLG9dNML+FeBY1BfYSEa25A+sisfu9knaMhGqGFjbJUvvhllRsTqE1CLbnk8CPBWPJ
         /c7qV62l9LbbjTFoAYibyer3EoyQyoPI4Kp1qlrfOFYzzP9UartbxiIOwI/EMFksU51A
         JQ+rbBe+4sde5M+EgmxBOG0JmHkuqh/LYv5wpNDIOlitMPCakcfLFirzJLVK8XXhs11W
         44+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740820328; x=1741425128;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62M00yAg51rrJZ04g8zC95EvNZ84F8x3AjdAvJoHunw=;
        b=bbSAfsuqX+SV6yOudy/jFI7wN/eNmub0YQn+IaJ6aH3GnoBg0ovm4gDRHuprRtEhcm
         3DXwVrObheBz9/vtWJtCS/4CJj+4SPLTCV/Gm4cPjMbleUanfdtjxM/+oHs2lzdO6qzx
         1lcz2u2ewulGtLOOAj++csYBZggqUAnDZgigxoT2XCf4fwA69+TCz4ymwqlw+QVSI+Pw
         0DQxlC1WIWcH9zRuBDf5f3vhDWuYVGHoE0saXCte+vRSNzUyYLeCyfQ93rioj9VPl1+W
         /8PBmn8qE9RKElYTDP4Rn+XFZ7vb9oHRxdGuAWJfygQAP0oL9mjQjkhkOtg3wdMxht0Q
         //rA==
X-Forwarded-Encrypted: i=1; AJvYcCVjC38v7JqGDxpglKnjsFfN5xhu5Vakf+RLaRjXlcR+89tNf0goBoPA2kqJIhJMBLV2WoIbLZdZkvoa@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4yu8Y+TF8cMS5Qs0frcVz+qxaEEjsmHSobKHfjyxv3z6xP1I
	bM1Z7b7Fp7DrF+ekCt9Cj8OQfqlaQCbIFV3zvIFqrxqyIMkv5pSR
X-Gm-Gg: ASbGnctEPhLePWxOUEkct18d6KEAcnP2X7yXb+bI5HGhlc317LavSJaaiuyTPWvpt5S
	nIIEfQYhE3xmw4mtdTpvWqGDdDqRSNeGfSH2gfJFjZgOXRudS2PnJwCzEWVKYc5rUMI2ewLzbDE
	oPgusrXJfdIBVY1KfwaKwz4t9TqnFUgi0jFpi6JQzPRDayPNgyXMOYvpUJ/6GNBDVWHact3JkKZ
	FjnjXKA7G+f3q10HE+aaBuzQm3Xoxz2GTAdxmkPTF4asxUEEDL1M3Uj4fblk5mvH8rz3PWSOsqF
	r5/1q/EXu3c1CuboUY3YmUNH1MyCzXyPyaPuyqTktnhY21/AgMdtiZLk7auGXLZqKC2pbp92K8D
	eKcIXlRYSvdOrRzphsTFXXp3jIA==
X-Google-Smtp-Source: AGHT+IEV8xcpINPWUe49yXpBYPm3MtVspqPFUx6SBprxmJEllwjfLWfeeFh1xeuz1VE+t2lFH6t06w==
X-Received: by 2002:a17:907:7288:b0:abf:5922:b7a8 with SMTP id a640c23a62f3a-abf5922dccamr135545766b.41.1740820327515;
        Sat, 01 Mar 2025 01:12:07 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b98b5sm436358366b.3.2025.03.01.01.12.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Mar 2025 01:12:07 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v7 0/3] Add HDMI audio on the rk3588 SoC
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <3337030.aeNJFYEL58@trenzalore>
Date: Sat, 1 Mar 2025 10:11:54 +0100
Cc: linux-kernel@vger.kernel.org,
 Algea Cao <algea.cao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel@lists.freedesktop.org,
 Niklas Cassel <cassel@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 kernel@collabora.com,
 David Airlie <airlied@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org,
 Chen-Yu Tsai <wens@csie.org>,
 FUKAUMI Naoki <naoki@radxa.com>,
 devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A30138B-183E-4816-80FF-AACDCFE3B3A6@gmail.com>
References: <20250217215641.372723-1-detlev.casanova@collabora.com>
 <87frk2sumw.wl-kuninori.morimoto.gx@renesas.com>
 <8734g2sg4t.wl-kuninori.morimoto.gx@renesas.com>
 <3337030.aeNJFYEL58@trenzalore>
To: Detlev Casanova <detlev.casanova@collabora.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Detlev Casanova =
<detlev.casanova@collabora.com> w dniu 25 lut 2025, o godz. 15:58:
>=20
> =46rom what I see, the error is not present anymore on linux 6.14-rc4. =
I tried=20
> reverting your patch "ASoC: simple-card-utils.c: add missing =
dlc->of_node"=20
> (dabbd325b25edb5cdd99c94391817202dd54b651) and the error reappears.

Guys,

Just FYI:

On 6.14-rc4 without =
0001-ASoC-simple-card-utils-Don-t-use-__free-device_node-.patch - i =
still have oops like this: =
https://gist.github.com/warpme/ed75c05d3b68f995d429dbd9097005ba
They are happening not every boot - but still happening.

However applying =
0001-ASoC-simple-card-utils-Don-t-use-__free-device_node-.patch (with =
some adaptations as it not applies cleanly on 6.140rc4) - dmesg becomes =
clean (10 boots; all ok)






