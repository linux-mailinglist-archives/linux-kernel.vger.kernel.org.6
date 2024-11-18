Return-Path: <linux-kernel+bounces-412653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605AC9D0BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CCC284EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512E1922F1;
	Mon, 18 Nov 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZV+TU7NO"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A7D18E03A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922822; cv=none; b=bc+RoWl8LdIMGCpv15PhVUQQv05T8tGA6XCC+LOy3ojDdp4qjTRMJdfVQ0wLxpEDQcw77eXSSQ89iSrUAPTLzfkdP8hSvIgqLOo+kenOVQWC9HIK2LO9PUsJXKE0hXH8gHxJBnF7MvP/NdVeUAfw60vuv+AhZMjQa1xPKR5LAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922822; c=relaxed/simple;
	bh=sCgDf9HmfpnPuFGw6HgxCSG4fFokGM5DQWc7VQ0OyAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhTwX49rwr94piOualtVGSNPTvdy1VOaknWbn/dhPyLo8d97VI4wCyHzmDRO49vDizO1fEVadeiLIo+pLmNdE0bo21Z5fiiy+dlmF1gFj9ua3sSl6/qoyHs5KJI+y7e4H68SXZq0nLb9Zut1/NMdpvIQiiEuUy0u81hzhCHZLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZV+TU7NO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3823eb7ba72so925116f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731922819; x=1732527619; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCgDf9HmfpnPuFGw6HgxCSG4fFokGM5DQWc7VQ0OyAY=;
        b=ZV+TU7NOJI40iDDH+7QIyyvyzwmDPk5q5oVOAM2vME0PtVYf6q8aGB9Ylnw2COb2a/
         xz1yfCBiDQAFlDH9kPdVkuZ2/Wg6Jfgis8a7VHWrB4qHTzVzrD7qpeJORBuO8SJDtx1i
         1pRCUsZhsu25gs7nwvqaiAn2Z3G2J3HijK3cT+5TUZKz5Q1IVna1M8lx0rbYf/suuZF4
         FHFX6a+j5s3mLUItgNapuMxE6r0+OroRTSHWHvOIo2XyeRqf/C9N2nejc3ttesjywWE0
         5FjNU1wp9qHzRNv3OrqMyHqZO1apq4bG3/hg59/DDZSbIdX1pazYGmMGKZdhoFikbk7A
         J7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922819; x=1732527619;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCgDf9HmfpnPuFGw6HgxCSG4fFokGM5DQWc7VQ0OyAY=;
        b=M8diukiL3omffqOsVJCbE9KDe+XE3OkO5N/kvE7Rehhf0YLLI9pwiYet34MZ/Q0rNE
         kXB8xElsI5pAd0nYQJOt5jYhEFHI/O43vIJUdUzZky1OV1fOcfNWyt9ohkKFM3YTd2bw
         zNvqY1MpTGBBxQDfueCj/MeQ2k46cO5uvZh8UzTLtlyZfh4I/NmelGV/2DSwQtAFjdil
         NZ7LvJKCuNrxL3BcaME5K3Ni7xJM9TDl8Q1MqoQZzBoWfd8lbKL8TGGOJeip+4GorP4D
         +OkzUUKK2iyO5HFRTQqxf6QCykgFanlpmtWi4yp3s6e8x5lbbnN/E9XDm8IP8txGdEqa
         LKXg==
X-Gm-Message-State: AOJu0YxPAHSW9es5HiRmQ8exrioJaGBu/dyHLVTlqvvfnbxUdLhy8+qL
	FTs2iLK8IrmdaKtYprMPfSLgYRJ8+dikgF8mkC8fAF5GCCTFxa7SfEJ3WP+/d8A=
X-Google-Smtp-Source: AGHT+IGHa7gc48NoS0q6ZGoDNAksIkFsU8teJxL7tX5AMyhsKg2Sq4IjQbIZKZWs65VOlUxgPKn/cw==
X-Received: by 2002:a05:6000:2c6:b0:374:c3e4:d6de with SMTP id ffacd0b85a97d-38225aa8607mr8472740f8f.41.1731922818924;
        Mon, 18 Nov 2024 01:40:18 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382456ba017sm3220899f8f.97.2024.11.18.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:40:18 -0800 (PST)
Message-ID: <939800a57d356771b405de49bc198d33327b4fe8.camel@linaro.org>
Subject: Re: [PATCH] pinctrl: samsung: Fix irq handling if an error occurs
 in exynos_irq_demux_eint16_31()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Krzysztof Kozlowski
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org
Date: Mon, 18 Nov 2024 09:40:17 +0000
In-Reply-To: <f148d823acfb3326a115bd49a0eed60f2345f909.1731844995.git.christophe.jaillet@wanadoo.fr>
References: 
	<f148d823acfb3326a115bd49a0eed60f2345f909.1731844995.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-11-17 at 13:03 +0100, Christophe JAILLET wrote:
> chained_irq_enter(() should be paired with a corresponding
> chained_irq_exit().
>=20
> Here, if clk_enable() fails, a early return occurs and chained_irq_exit()
> is not called.
>=20
> Add a new label and a goto for fix it.
>=20
> Fixes: f9c744747973 ("pinctrl: samsung: support a bus clock")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
>=20
> Review with care, irq handling is sometimes tricky...

Well spotted, thanks.

It looks like there is a similar problem in exynos_irq_request_resources()
in same file. It should likely call gpiochip_unlock_as_irq() if clk_enable(=
)
failed.

Care to fix that as well?

That said,

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


Cheers,
Andre'


