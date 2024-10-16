Return-Path: <linux-kernel+bounces-366988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C299FD51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E529DB22962
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208914277;
	Wed, 16 Oct 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMOeOOGO"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A863FBA5;
	Wed, 16 Oct 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039324; cv=none; b=qsvvWFfjjnPMFji/A5wL3PcasiR6Y7O15JcQUW+bKjKWGeN46t7oBstRZh22LxkbNdwBjlKXP4XgmduSiqcKCjkLuDzkQTJyMgYXDqow9cy78vknxN9UT283G3Cl63guGXlWNS/4SVJIih8Qt5V2l1gPaelRidgUpWxaewoCAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039324; c=relaxed/simple;
	bh=Q6S8x1mbaUJvn/eaxv2yTmQR+pRUTTVEiCmTemYZaTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzhMe89Eh+7pgVG0pdsMVCh3Ixbd9D2tJdrcnd9ivprQT38v91rtjeR+XpRrC8ROO/R+r2VvA9jNSAUXshMRpDe4S9Dk2oBWPVXpXi2yJDcMPHkmayLcZ67a5u+FDkIjfoYHkPRpxgWvAodv5KEaQ1DDy9L50eNJnkRpTHDoeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMOeOOGO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314b316495so6199975e9.2;
        Tue, 15 Oct 2024 17:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729039321; x=1729644121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvcX0gGeep0GUuFVn3JiQ4Xt9Q6qGunv1EzUF9AFO/8=;
        b=kMOeOOGOkIaIpkgte7VZZgiasmbZaX/VgnzJJboIA2ZOKIf1bOlUOjPvnGEX02sCqW
         q6mahJUyDn2EUBdjbIxRG3xke6nEB5G6rh0JKpE1LffeMQCLyAohkniXsMMZeFEb9hxD
         bN3F0c8h18T0HnW4c1oCdjEjkIgvplJFWuaqd0WgE51Q4iB/nFc69Us6T+TTY4s/432n
         2jpO6Gqs2eUMYOJ8/oluP++8IKEpBuVV44nhirIUmQQ4gXpgUOGWDoImkIJwcfWO0dEL
         /Pn3BHLbaPHG5iPyuPOCXfcD3+tXxzObzHPd9JYbF3VFdTetpa/I6IJUZtfjR2q9qNpQ
         N3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729039321; x=1729644121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvcX0gGeep0GUuFVn3JiQ4Xt9Q6qGunv1EzUF9AFO/8=;
        b=Glg2xoYxO1VSHrUpQkZb9B0d3Re7IiTnpexpKLFFdTrLL2XsecAuIipcZOrT55STfM
         y8P8ys8GjXirz/r6rNuAcWQynHeqEznK7Zfgr+ItTrzdGQFHeACuW7kiuqcC4Z8hULgV
         riXU/P4Bvwf8/iJ7/OC9vLEpz30ub4hgJNHAGkhUyf3swJxmmLJsCDGmURV+lih/6OPU
         UvY3wVFLrTHCRONplKHwpKXaUwWKLEkypDyS/eCYcg3Nll3lD0o6ZFmNbwlJUGEKcIPU
         T3eKb0cMvuEacYgmZkCqV9vMQXGpusIPxXKK8MaNHQYGHjY+mVd7Q5wQUHjaewJoUtT9
         cQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZn4cHqMge4FprHugxw8Rd8vuTj8BJt/c93SdIYYDij0WTtKoc/FelRD+1q6ee92ZoyUJTRSFCsZbi@vger.kernel.org, AJvYcCWNpTxIzO+iQZ9hYl9RvwDMfz9ufn3W2Zdpt5hq7BoXjA4HmqoZ6b1WXG+bPoqUqwefVgNgso82u0nJOYE6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/Jt6rL28cACDml6wgQmzONRaJLKQQnSajZBoFmT3fg++Hbn/
	KTZGPPSFxYycA0EFa3WJm0JHPX6afqit0A1zdSFEeLalfsBX2ZxZeBNB8Kkr5kF4g4xNoxmNXV5
	bO02g7xeXi8Y60/SMF8Si7b4FosQ=
X-Google-Smtp-Source: AGHT+IErA0JGeWcAknCGVEPwXfu/nx8v5bP7gX5Pgx/kAAKv1urxza1nggwKBv/4ZtWjALceGSIICkf/jqP9FPFZMvo=
X-Received: by 2002:a05:600c:1c9e:b0:430:57f2:bae5 with SMTP id
 5b1f17b1804b1-4311df42aa5mr122976905e9.27.1729039321310; Tue, 15 Oct 2024
 17:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015192905.28969-1-cenk.uluisik@googlemail.com> <20241015192905.28969-2-cenk.uluisik@googlemail.com>
In-Reply-To: <20241015192905.28969-2-cenk.uluisik@googlemail.com>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Tue, 15 Oct 2024 19:41:49 -0500
Message-ID: <CALWfF7K5vGL6GPMWdi0_kwXPabKv70LSoGwK-QxL+Br+PDowqw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Andy Yan <andyshrk@163.com>, 
	Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Jing Luo <jing@jing.rocks>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3588s-orangepi-5.dtsi"
> +
> +/ {
> +       model = "Xunlong Orange Pi 5";
> +       compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
> +
> +       vcc3v3_pcie20: vcc3v3-pcie20-regulator {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> +               regulator-name = "vcc3v3_pcie20";
> +               regulator-boot-on;
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               startup-delay-us = <50000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +};
> +
> +&pcie2x1l2 {
> +       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> +       vpcie3v3-supply = <&vcc3v3_pcie20>;
> +       status = "okay";
> +};
> +
> +&sfc {
> +       status = "okay";
> +};

Regression tested on the original Orange Pi 5. Still works after the refactor.
The microsd card is accessible from /dev/mmcblk1 just like the
vendor's 6.1 kernel.
NVMe works
SFC works

Tested-by: Jimmy Hon <honyuenkwun@gmail.com>

