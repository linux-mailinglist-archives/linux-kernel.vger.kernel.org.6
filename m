Return-Path: <linux-kernel+bounces-350381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E633199045C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF223283036
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666F8212EEE;
	Fri,  4 Oct 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fwmitTmp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149033D5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048638; cv=none; b=mAVLk2h1JVCNiPzt+/SeUChgTaFjx3tkqUfOFUI4v//y9oVocKvX0YjCD6ms2MPXozTkLZbN6pJCOOR0Od9brrry8LQCh5U0yJSFHXIoe5bEuiaVf6qoHI9N4JK8rhsh3Ck4TyFpkZfhnaS9PDyLTto9JfATW8PrtoQ9l7A2Urc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048638; c=relaxed/simple;
	bh=PVxhKrEyWijKHMWdwhZC/YRs5099qukyA3185jt5uLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kZMok5gbKRQxuFX9knUgQ+0i3AS/HqAZAlsI4u6mjXQhNto1JE1Tjbkj6yGrUV5MB5TJfjVxgp3n3Uasrbazz8hbAiW9FJZqad1TDG//PjLkZtP4S6SwqXGDthsyLd0C0a4xvjAJZOPgpEHwsBfUgTMQlpoWTygPltHEDiUdbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fwmitTmp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so17235795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728048635; x=1728653435; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PL12oHhNupzORthJ0SyLBGQ2sKgGXlY+AklWKmc3OZs=;
        b=fwmitTmpdYAuyJ+3rV8uPyiD1WIqB08n1XrgqA9cddNyvPZoWmB8z+xHqvw5NLqCeC
         cXYbpWnzNUZk+F25iJZ6rQNWklh77RHUz28yWj7XVGSLG98CBO3zkPkstdP70XF2PSUa
         C4xgLAjoGX8YK6RKWtbKj2PQXnTlKD1w3ognFkT4XJ5P3ICYfDtrKZRMqncOEI5EDuTd
         VHiN/Zw4p7FOiU228dHG2Q5Bs9/vOl+igs4hfAKLsD+0sURzTQ+L6INilN/4yWhNrOeQ
         yHgx3KzH4pydxGziNRgiB8clrT/Hg9zxqP9pFx7iy9ai//gg12fXSX+z66GPMJ+eLR2F
         +mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728048635; x=1728653435;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PL12oHhNupzORthJ0SyLBGQ2sKgGXlY+AklWKmc3OZs=;
        b=pH726wS5+SJzMkzuvZblasgd4c/AKY3Y/FrGrGHRHlODEoejiFOmBtbyBg9ZgPeqqB
         KxU3Qu7AKNeXchUlTNf4GrDzbPnn8TFWer3F6GNPbWmDzNYxu4+Lhf2YTF0OH64EUXrJ
         rOPfoP5LWpSXVvn/lrSyGWCT6I34dcMEnu6jZv1+xaK44jrSa0vXr8s30132dbCfiBMk
         rIm9cQy9WUmuqgCDHXn+GjbYDd44Ck6qvkEBoJvq6Gj5uGdtHfk+03hsbuKFJgVS0Ocs
         i46sziMrE6hzglF05kFTgJj9a08k2cHbmPbVMyzzxdR1Bqqp6MxQLrjhhx3KyDPxs3/2
         AKQw==
X-Forwarded-Encrypted: i=1; AJvYcCXzRbL+Kfc4zNke2NzDTAxmXY59MgLIBMv1p7E+kJSt8pctqU1II3OCHERv32xww8/sHce3k5MlGhKQ0UA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1MN5gOReulYpPcHo+f8nF2exFLCc2fVnkfttZhJuB5Y0uORE
	0M/eOlMurdjIECsAVQN0MOpdb99lkWpjnyg8CGLOSNY7u+0c/YFDLFC4vB1LQwI=
X-Google-Smtp-Source: AGHT+IHtZmn6OQssLbni+42dDDNbAXZ5rxq7ZlG7Jnlgb+spldqzmQavRoTAVSMSi1whdFtbCdGAbw==
X-Received: by 2002:a05:600c:1c23:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-42f85af551cmr20227755e9.34.1728048635370;
        Fri, 04 Oct 2024 06:30:35 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:6080:c6bd:7a14:2250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b444a4sm15637085e9.29.2024.10.04.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:30:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Jiucheng Xu
 <jiucheng.xu@amlogic.com>,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] reset: amlogic: split the device core and
 platform probe
In-Reply-To: <01aff9c0f129f8c1cf41c7ae53dac38048aa34a8.camel@pengutronix.de>
	(Philipp Zabel's message of "Mon, 30 Sep 2024 18:56:05 +0200")
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
	<20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
	<8cb81058c8f45e378675e078e296336a2cf74308.camel@pengutronix.de>
	<1jldzwkpsu.fsf@starbuckisacylon.baylibre.com>
	<01aff9c0f129f8c1cf41c7ae53dac38048aa34a8.camel@pengutronix.de>
Date: Fri, 04 Oct 2024 15:30:28 +0200
Message-ID: <1jsetcro5n.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 30 Sep 2024 at 18:56, Philipp Zabel <p.zabel@pengutronix.de> wrote:


> I've applied them to reset/next them unchanged, at:
> https://git.pengutronix.de/cgit/pza/linux/commit/?id=5b93105afcdc
> and sent a follow-up patch to fix the alignment.

Thanks Philipp.

Would it be possible for you to tag it, so I can pull it the amlogic
without waiting for the next rc1 ?

We have couple of changes pending depending on this.

>
> regards
> Philipp

-- 
Jerome

