Return-Path: <linux-kernel+bounces-525689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E6A3F333
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F77D19C0DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ABE20967B;
	Fri, 21 Feb 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSGPSgql"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79720897C;
	Fri, 21 Feb 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138172; cv=none; b=CVvMmVBVENgJPnzGbIfegEhlq+alBKv6DHJSXlII76N8+EqZdyOGw/vWAGqwWPXGlIMJEYbB00ivXS9yMGdqQHX7saTAV0CPmyTR1W2FkTfPPvrj1qumBdK1G7U+PkieL+LBFBn2eIKS3UTsH2WoERnSIgWcr2euiKyMVQ7FfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138172; c=relaxed/simple;
	bh=XkLj3L4dQlpMsdIQhF3lEl4OZRGB90PZA1PEkLCsjsA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UM3slonnH5GqjCtt41meFN8vfslzSReO6+WSOG5naW2EeIRvTnHFENi6NSpGAgmuKMWoi2A4YT7ttf+tq+3DCBlFmEosA3nIjWFObQwL9WG6tMAmSX5wrMa1boFnBGgG4Gh1jUTZctTEh0ev3KtwOZyir9ybg38cTHAvwh0Rr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSGPSgql; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so5723615a12.1;
        Fri, 21 Feb 2025 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740138168; x=1740742968; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkLj3L4dQlpMsdIQhF3lEl4OZRGB90PZA1PEkLCsjsA=;
        b=HSGPSgqlEvWAR7VlAJQncfX4f6eqWs/3iXGvtjD4TTF9h9sLBNGwQGFv6C8mDwK75y
         q0WQmNsn8v3gm8gCms3VWcZLACARLhmFUwzNaAzSL7Oachfd/2x25zCJ7WAUQpfBwx6J
         MPhDmC1Knm9DS0ptM2sf0eV1tqIESEUQFqo/TPpBApnW41/VZPpCfT/AksWpFY01KuKS
         PzIwIQRaiyMVKZdVHhkB6XqqzFeHscLjuudVHjkWkVc8YBbrF2g1FeEeCbqgdXUhqnRd
         LNfXguIoxVkIIxOF28IZ8McKzxP13gDEauL/HBYDdknb3bRKAEqSJMnaVlYyT0gEhoDC
         bFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138168; x=1740742968;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkLj3L4dQlpMsdIQhF3lEl4OZRGB90PZA1PEkLCsjsA=;
        b=ERof8Wi5BxIVdcq/MT7nuV6K2mkZ8/CwShJO9wISOv1cXgEoQqZ/e0cnDYwkdrjz/y
         sFMNPzaIYhq7dCQUfF1QTJnWFnsVr13MqEf39aIpzIyRcDDnjdjVSqBlr0uvzhI62mZi
         h6DdwWxMYV04kJNIPlP+KF1QV4Y1PiYjeLqm1/o/ZWN5okjCncbTs7tDtk6epTeGmDbH
         m0n2UlswjrxKwMlSsZ4KFvXHAXlBI9uer4LgwRESu0cgbq9Ukw68p6chv/SNboBGBd1n
         L65JpvNEcrwYo6x7/H5vF7r5KbECXEzjcQ8Cduvlpgy+VSRMCtTL77ZWU44zKB1Qu57P
         0Ybg==
X-Forwarded-Encrypted: i=1; AJvYcCWe7DBl970YqlBL9xYrLpYE9UBtsrwtG7PrGWtlmuVSqSeKbso6dp5NQh8VCB16WlAWTNJLIhVNH+cs@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsqI30pRzQQhtJn3m+Z2xq+d+VwAb7YN2EWwH457dGB/HsJQ/
	D39l6Q8uEAs/yoKS4yYP/UiB75q1QIVQPYmx4GAO5DnH+5eplcZyb8Kgq4S2
X-Gm-Gg: ASbGncsCI7ua9AX52wG8XTlVlhBVIskWBnVVuPsTfUqqJpVDfWMdmJLlUXpJIOa2s9w
	/fQzR3gkaJlJKIXfwpWerUIyzd09EQ0hDjIx/dzwrbczou9tm+ZUaUg/EghDkzQEAHFHreM67Rj
	Hl25+Ix6OFLHA3ANyGDNdFnRBQVwqg6CqaoSeIYs8zCch9QCb2SOaJmkCf8xBWjOTlSj1yhn9lm
	cnrK9mLsdVA9tL//8ajTOsK5eZhbuvX3Ju7lzCALOyn13p3D9mNpADbfrJWi60+Iw1Pu9H0EXOV
	MvA60q0a029GF3YDuJ7WNktGgnwmMJPwjRmZhcsUshpFcUDqvmxXp/yUrLT+Ijzwu2u7eFB3rwR
	k9L6aacs=
X-Google-Smtp-Source: AGHT+IGqnd85Z6uUbc80gi8ICKJ1IHVsX+dg/Mm+5UiTzJwBP7TGxu1s6WSYqAFeYjWEnu0FlWu8JQ==
X-Received: by 2002:a17:907:7e8e:b0:abb:b411:5e02 with SMTP id a640c23a62f3a-abc0aea5253mr285729366b.18.1740138167711;
        Fri, 21 Feb 2025 03:42:47 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbad879b26sm789563166b.44.2025.02.21.03.42.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2025 03:42:47 -0800 (PST)
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
In-Reply-To: <BA73C4A1-C680-4748-9CE1-4B3B19A14261@gmail.com>
Date: Fri, 21 Feb 2025 12:42:31 +0100
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
Message-Id: <5E535D58-AEFF-45A4-A1EA-1FA282F366AE@gmail.com>
References: <20250217215641.372723-1-detlev.casanova@collabora.com>
 <B8EF5196-55FB-44EC-B93C-E327C791225B@gmail.com> <2357838.ElGaqSPkdT@earth>
 <BA73C4A1-C680-4748-9CE1-4B3B19A14261@gmail.com>
To: Detlev Casanova <detlev.casanova@collabora.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


Small data point: on rock5b switching in dts analog audio: from =
audio-graph-card to simple-audio-card (so dts is: =
https://gist.github.com/warpme/349b27e49bc6f617ef1041047e75adab ) makes =
kernel oops go away with analog audio still working=E2=80=A6

so maybe issue is in audio-graph-card code (or its dts fragments)?



