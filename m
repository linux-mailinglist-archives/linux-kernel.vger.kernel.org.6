Return-Path: <linux-kernel+bounces-517252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D8A37E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655153AAA65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A71FDA7C;
	Mon, 17 Feb 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqIvi/bh"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA11FCFFC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783832; cv=none; b=FHxROhDKkCD1I5UIBMsLjDtf2gV8l8x8LA3nptKjLktyULFqUfZlfUhXuF6v8aoCN38XrTxkw208nXUiVIMyDaAbTL7bnK+13blf/KSCbT+bxGndwX0l3x3C5lvxMGrNwVNgmPUtJDXN/MelLoIUWej+4Mfh0t4iGHDmjWIKSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783832; c=relaxed/simple;
	bh=4ntcKW1tB+N27ADy4lWAK7yXsvL0R0RQM5l19jhhaJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bENR9XHrSfVdict0WeQBEm/rhUt9h04rHEyspsV9WbF+BJ/IAH0ZHR4doYXVzMG2n1PjptXdWaP7mCbr1zsSdeOY4HYh/tCr36opFeliIzKoXz5QUM2tFa4oWMMAnMhZInI1rPydpU0rhEAH9QmXavoJmsbE7HHkaUDOqWhAsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FqIvi/bh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2613005f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739783828; x=1740388628; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ntcKW1tB+N27ADy4lWAK7yXsvL0R0RQM5l19jhhaJ8=;
        b=FqIvi/bh9MQ9ocDSG/ltU7WZcuZscIBEqWH5uIkZg3Jz1CzkvB6AOf5xpQWIzsyYvG
         CQFansTQm8Qx5nqDz+efQW9z39XLH3FVu/twKKyaG/RYOqI2jGg/aM+f9V9GLFyTL5hN
         RvbiOhbzBX3F6MR4BN31Cyu2+moe/OidcidL5bQ6suNAiY6zjP66pYbhja8oJxtYi/7h
         +glh1mvFNTEYIYFrxkJc+HcUYxkz0l3af+YMPbxjhPr6mKRIObjT4WLbE8rb9KuPHT50
         rhyT5f0TvXgbG+VNjDn+RXd4DuW9mc0zhH0qBfFsm1iE37pBdxpDna6zknqR7AaoRXi0
         ho4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783828; x=1740388628;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ntcKW1tB+N27ADy4lWAK7yXsvL0R0RQM5l19jhhaJ8=;
        b=LiziybZJx6c3SNs0Prm5WzmAxnojuL79mDC3YTCVvL4yFZC/Q+NxxqfMVU0tZVHix1
         dgEVkxqhZAjjOfuD4UVaCrvuVep/vsQGC27jN4fcmKlrfgspZVGnmtvg2XX7Hd+RNbD5
         1cTnra8hEVLLvUG1a5NZ6xrpuQz2Wr1mW057S0Ip/aQ5O5yMLCgMfmbPLsU4b9+DarL3
         S5LXKQ4crvTDVcA/vPd9A9vooV3CJkt/L1O1Vz4qdsxv9VPo4lNS/DjcQTbMmoh2Jjzn
         SwOxtbQOMEP3dLx46Cx9Ee4TkjlG9cjtmbOvXaNtnVlf33OkVS97Vta677RhrqEgWpLh
         r9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLwPSmFwtnv64kr6i9LAR3QOWxNQS9NPkO5eNTZsvosisckUWMXdRykm4Ok0NceF3CkfQ32WEmNN5ZgWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfb9ozi5TPyhu+Nz3xgZYryYtkEJyPyzO+oBfPMljSsIzfyyZg
	URlsN1SokTo6oEfC5HcEIlJAM3YdQy0xRHKG+nXjF1t9uGfj3BYJZN/vqYsnmhzpLlJrLW3ETBw
	5fD4=
X-Gm-Gg: ASbGncsL2mHYbTCYb2Y9DJ8endgnFOzCJzFUvZtvhnwv9HNdlM/n+qby0NL9WD/gwnW
	VbwwsqpxaxTKpMjtWVi+iv42aqEwRFfMcVmXHfveNuix6qfvwGY4VaAiBh5XYmqsE1+XTaXoHBn
	boXJg39gBjMLXvnvcSNzesciRwJvBmFveU/o+feFYUNmitNWtK/0C0LSFpDo+ERTf0+gqkI5cvg
	i0D31BRTxbEA6b5la1N+t2F4CsXBOxeCXomFx2uCrNCKjUAyzuKhgbWhG9ozxfB5C0zikE2g8iN
	vT+MFdEs3v04ySbyvxs=
X-Google-Smtp-Source: AGHT+IEtKLFRxuP1nVmL4IgHksUscZagskY4I9yGJDc/hGcqpUxar3eun+zNllhMxzPrVCBSF8kWUg==
X-Received: by 2002:a5d:4684:0:b0:38d:d8c0:1f8c with SMTP id ffacd0b85a97d-38f3406cb07mr8581595f8f.38.1739783828394;
        Mon, 17 Feb 2025 01:17:08 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccdabsm11679604f8f.28.2025.02.17.01.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:17:08 -0800 (PST)
Message-ID: <f940d41b549becc79538a9b100ac2d65e1bd6804.camel@linaro.org>
Subject: Re: [PATCH v3] phy: exynos5-usbdrd: Fix broken USB on Exynos5422
 (TYPEC dependency)
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski
	 <m.szyprowski@samsung.com>
Date: Mon, 17 Feb 2025 09:17:07 +0000
In-Reply-To: <20250217090518.137606-1-krzysztof.kozlowski@linaro.org>
References: <20250217090518.137606-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 10:05 +0100, Krzysztof Kozlowski wrote:
> Older Exynos designs, like Exynos5422, do not have USB Type-C and the
> USB DRD PHY does not really need CONFIG_TYPEC for these devices at all.
> Incorrectly added optional dependency on CONFIG_TYPEC caused this driver
> to be missing for exynos_defconfig and as result Exynos5422-based boards
> like Hardkernel Odroid HC1 failed to probe USB.
>=20
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Closes: https://krzk.eu/#/builders/21/builds/6139
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/3c0b77e6-357d-453e-8b63-4757c3231bde@=
samsung.com/
> Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notif=
ier if required")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


