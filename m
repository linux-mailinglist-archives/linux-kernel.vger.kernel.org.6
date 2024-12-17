Return-Path: <linux-kernel+bounces-449287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298339F4CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0886A1654B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029521F471B;
	Tue, 17 Dec 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgeJ66eR"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5E1E8823
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443519; cv=none; b=Uti9ASNzx86GCpVTddlwNh4xywpuakvKsVjz4vUz/8A5HADg6DZajkLDDYDB65NAHGn2ZpmM8fhISi+a7vX+3cGbCJMiXKlVhZszg2j8PB3GbT/MW/9ITKao+3M8s94Pv8sdz+VojeT2f5VUY4jO6bnaFl5jdPHd008fe8aYIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443519; c=relaxed/simple;
	bh=h8hZa0shBeOvBBhYcCnxg3/TvPld1ws9Sgpa6d41cfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1IvvRETqBH9woij2332wdA7VlWqIP55clJ6KrBDBEf4MDV2njChgouNKcrHx20dQRBDSzDH3V4GM7ONWOiyV8lZdbwqzIJ+7+y3RKM+7V0A2tFiU5TLrsweI40mxG2u3uk+/M/Uw69Q8phrXCpcLcAcII4NH2Avnvw6tKYXwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgeJ66eR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso5453287e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734443514; x=1735048314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8hZa0shBeOvBBhYcCnxg3/TvPld1ws9Sgpa6d41cfU=;
        b=cgeJ66eRqPQThPQAJ6or6kknsqwct/k29AUP/gEWNRVD4bnUcNNPRWprO7hn/GdwPt
         pesLPDmqrUn09lCNu1iX3pcrZ0iOdZUVTqt0+VSn1kDZQ3egibEmnenjKoaziqIdlJb4
         5DzJuIS6vPlfdcUYTdSgXD7GJg/HY6bW0Gjj7bqlUbhinSjlJkXg01wyGj+UrvMhUIBp
         R8ycyi3DwZpgN2hsLRmW5PkEwj/iU3mEeE/YruXx1VLoXZDB6Bwekf3WFz8kO9EyRqtU
         thbtb3ecN8ofBfBXUKWR4traLYLd1cDIoUyutjG8IiJZ9hKTbSoTElxNu3DX4H9V+tHU
         8gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734443514; x=1735048314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8hZa0shBeOvBBhYcCnxg3/TvPld1ws9Sgpa6d41cfU=;
        b=WAaYLMqfJ3VBvuCGaX2N1cSZ5JeySqh3imTA/MwZofCRDTaifDgw/JV0axYyKiOUAN
         WQK2yeFmHJLamMVnLqwL4LptWWxIHUIndyfKM7M166NAi28BsvIHclW2p+/Ylb1E03QJ
         fFmYtK+JpMlS+eOBB87xGotT6b4AEU3yENGLHQOcqXU/Dx6viM9ADhbS8jnE/pd83xHj
         WNLyodo7NeUuT44p+0bCr8iFbFGjxOgbOVeHCBDIVfQJn/1+QvlGlz0CSdY5WsUmHU13
         sC1Ot6yxh3BLZlWuDutsPhz6NYkdFm0xPHuEAcCd5inWhNuRxd/brMIFfE0UqkUbzhkP
         lEqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQMUmvpwSQbA4fbwrJsQBt5KqbNVIvWDUjQxji/bGee/qngaurYpZBEkqW34f4lRvvhPq3hJs6se1x+78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZEjZQq6bF+Pv16p2h6/9TtZYh4L1HtqpLVNUnnD9JSyJBHTx
	6LHRZwzOdlSCx7pfJnJjRW2tl+ih5YbesNbf+UQ7qZneT66yEs96LBB3qyYMhmAa68VtSUKxUZP
	XAcXrpWJLVoPaSE0A1HSMjwsEl0T2kMZzviwbLw==
X-Gm-Gg: ASbGncv1IcLb0lEnpBxEYCji0ea5Qc5wYEnOnazPwWA6ee+HtVZKMjRe2T+9yKSb/a8
	IhsvX4W3swcL7yrqVukcmzg46GnLiOXwfgDUXwA==
X-Google-Smtp-Source: AGHT+IGEoFk2/Y9yrHF2fZnMacxBmdTscNpmAK7EbqwQBtmcHIHv87leDmZg8DYb1oBejBKphi50861qTul7AFls5Aw=
X-Received: by 2002:a05:6512:4005:b0:541:1c5f:bf83 with SMTP id
 2adb3069b0e04-5411c5fbfbdmr5399848e87.35.1734443514494; Tue, 17 Dec 2024
 05:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205042214.2410982-1-zmw12306@gmail.com>
In-Reply-To: <20241205042214.2410982-1-zmw12306@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 14:51:43 +0100
Message-ID: <CACRpkdbcn8FD8v8PYv9g5JObC3ty+6xvKKCpS2uc3WKYXcmLiA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: Add check for clk_enable()
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiasheng Jiang <jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 5:19=E2=80=AFAM Mingwei Zheng <zmw12306@gmail.com> w=
rote:

> Add check for the return value of clk_enable() to catch the potential
> error. Change return type of nmk_gpio_glitch_slpm_init casade.
>
> Fixes: 3a19805920f1 ("pinctrl: nomadik: move all Nomadik drivers to subdi=
r")
> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Looks correct, patch applied.
Thanks Mingwei!

Yours,
Linus Walleij

