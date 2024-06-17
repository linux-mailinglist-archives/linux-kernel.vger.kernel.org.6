Return-Path: <linux-kernel+bounces-216922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A090A89F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EB51C20B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5590190496;
	Mon, 17 Jun 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oc9LBP4f"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AC17F5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613490; cv=none; b=P4QafdVCUToHnQ/AaqZFQsS1/98+W+RTGTXiXwYRCNBI+N0IIhXfFXwKMBQqIGspApm/x3RkmA6gT/KZV/EzyGvHGe6HkJSEduuaXo590Zzy8o7VmykYVXTVOPeLGMa4t8jMLe/DxEtJ2tC634MOBzJvGEVIjXg2K/Tc4R1owak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613490; c=relaxed/simple;
	bh=Ad+DEAJ96q3Mb3dlvrA9VWDHz1PLJ9uuY9NHcvPv2lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpihvtDcEOKDDkfyS6GzLoekv7Bg+mgnKBLz3fLbws/KuMy64dv6vEq1KP6/v7aHCDTUvp7sseW6CDRQjSTF4LbNwPlIkzQObDln9q7jAC+tZItI3YGcHdO5YGMsRkG4ME5EVTe1fLXJi80cW4jX1Z42/5IpSA++FYjH+T016sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oc9LBP4f; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc335e49aso4695688e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718613487; x=1719218287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad+DEAJ96q3Mb3dlvrA9VWDHz1PLJ9uuY9NHcvPv2lQ=;
        b=Oc9LBP4f3MrrZ2v2Q4OBaiPp4mjevzAlyGTLP4X4mtfpSv509//To8fNPMPuULQEqu
         3buGaLszW1BSx19Y8QKs/+k03hyaMZ89tlhkzBPhwr2MHRZF60XSw7g+REB7cVyNhDFh
         adYLwwZTY7ag3p/TBzc0SZb6Gt0ci3Twv3JbQLyiHE2OkGhxkwm2Ui+Sn1kJho417gpf
         Dg8NoWyiVUI+1XgqMdXofX3BjngiQ5AE4Qu2JvR29YKYnOzyUouBz69c/FdRSKdDFyAU
         hIzw82w2h2TZwNnqss/E1AfKmlgMlIUtNmZhOKs4Ds6G/eUTjKFme4iRQNrxlKlBXEaM
         fb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718613487; x=1719218287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad+DEAJ96q3Mb3dlvrA9VWDHz1PLJ9uuY9NHcvPv2lQ=;
        b=LM+vNdZPU45vyvTz6O1STgh77jVXE3jzXvAu4akpI9uI+ox9bojHH5n9241Q2HLQqR
         uhZlvio06LAjz3QO7zi5JSghKmVifPpNF9o7XAS565vxMC/HUpn3ZrniTVATsZIgfxvU
         rAh/KqxLVPYoV3Y890WUPr8JeGaXRJldAjg910aLcAxhuGVBJRhYa2fIZ7qQWvn91Pio
         hnVqFx/258ms/UGcvT0r4Flw16WfZaG+c5vKU56WXriJbR4B2eXmTjDgLreBzXxAltmy
         l8dWF4XvUkIxzZgdbH3+tHHClfeZbmNxCjHlrGqxPGHyx9iSyZxYe2hFCEworWUwJkdN
         M5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXauwW9KvWqaupv7gtRJ3ANFQojiWAUYOiCJ/Fo74b7cUNlI/kwf6L7qXpC2IIS/1eyAAh7QgrgcR1m/zNJCzplAcgwz8xJUtEgz6pY
X-Gm-Message-State: AOJu0YwsqKbHUeiLE48q3oE7dzmQh3rbDIlpD+ANw8XqshE4zrT0yuQl
	tF3Npp5XtcEVGqqRV0Gl4Imr8SYYvGh/CGcSFAT1P6kFzSmRsvhLo7gwkSNeSmEFZN3e6IzIxaw
	x4fyLPVndp6jKgKb+ojwfx4jME4hCqu2afyis4bQ2mb4CUTyX
X-Google-Smtp-Source: AGHT+IFutrW6UzBgAviJa/d7uO/iq8C5wSF7SgFGox1gHdBAGL1yUWbpxRacXxzbupfXHiyhG6WNRXED7ADEqQ0l7ZA=
X-Received: by 2002:a19:c515:0:b0:52c:8479:21fb with SMTP id
 2adb3069b0e04-52ca6e64c25mr6506284e87.27.1718613486857; Mon, 17 Jun 2024
 01:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606125755.53778-1-i@eh5.me> <20240606125755.53778-2-i@eh5.me>
In-Reply-To: <20240606125755.53778-2-i@eh5.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 10:37:56 +0200
Message-ID: <CACRpkdYv3DTqJD1dtgLO7rxn-34ZpyfXCygwvgeJpEFWhyKQrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pinctrl: rockchip: fix pinmux bits for RK3328
 GPIO2-B pins
To: Huang-Huang Bao <i@eh5.me>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Huang-Huang, Heiko,

all four patches applied for fixes!

Yours,
Linus Walleij

