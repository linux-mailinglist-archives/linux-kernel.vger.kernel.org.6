Return-Path: <linux-kernel+bounces-543420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBEFA4D55F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C48E18833D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E61F583F;
	Tue,  4 Mar 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7jbZIFP"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9C2AE8D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074707; cv=none; b=ek8iggosGGspjtbScgKx+cycJU2wQ4eeuaYVV771Bh0PA1rfDhonxrhlcSRfL5Atcdrt13b75FuewLmU+pSoy7gjixFZZ4YSZiide4WhR4FmuMz377WhwPeFWv0xRBsRZ04L7JEsyhJZ9Jxmg/2Gp9DFvBsW7TAl3O3TGq+RqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074707; c=relaxed/simple;
	bh=u9ZCYhaK23fUJUUt5s7FYrwFuoV7Wm409Bw5a49OPOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LztfcEXDpUNajPYhwviVgKhDupeO7HEKWi4MDh0ZB02E2esWu6ETE4yfvYkzHqR34J4aULLAvQXF5KkM3oJXTfKGOCHkQEssGUxcFowGblLcwcMR1WbJSptHZGRb3PpnZNcLOsWJOfguQN/2swFBdsg1jwzK4wrOCADJU5FfRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7jbZIFP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54965898051so2043029e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741074704; x=1741679504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA6zLWQ+dYJkLtBz+wtBiNsIVYV44LsyhmBHfgcYN+Y=;
        b=X7jbZIFPqI8JAVpRk1d6NEU3kZGfohQ8AM0VeK9OaPWz0+8GMUkLao79JE7gko/6eP
         fsDak7rS4FvpICROy2ti/qV+TZcoFkgFkDpVAuzQv5jFXHzVRfUuVwJ1gmA5m4HVw/B3
         q+gOrNsJCljeCco2lg4gRvgtZKBWWuIRWOeapL1i8sO16+m4kRjWozHN07k4uJ8pJHBz
         VWtQks94MRZwp1tZ5oUYMKQz+bhqh0kJlRyiG2E8J63qxGrb/pjfiYPZHpIfkdkiyepu
         WvoCICCvdZ7tHGUPGzj6bpPS4MRuHQOsUPIIsqLD2YiRflyVvddQ0qw9yxqsrcqs0Jsj
         gliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074704; x=1741679504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA6zLWQ+dYJkLtBz+wtBiNsIVYV44LsyhmBHfgcYN+Y=;
        b=UQesBiJVfVPSE9f9iw453DH4Ybw/o2EQ3K7MGnqAjPzk9xrfjWp7z17dwLSDU6+hmd
         BJzv1aCp6ZCFGHA6kkFFplosEBXy7INKcKPQ9lAJZgGnbn1ApBpyU8dtSziUGwNLGJ21
         5Qz879TSmAtaYHJSa6tClsivrVqdZ4b1uefidw1dB6M6oHSBsIiilsnOeWc/61zwrinI
         jThdNqCAe8TMBL92prSY8xkC6c4S6pOWCgMcCENIv9DbObha9U70WiPIO+qEn8mrdHyy
         64OOC3PmfrkDAqkYSZ491g5SX1EdMeMLjIA4+4tMrdjC4BEjl2MLm+gYvHlfRFflUb1g
         tIYg==
X-Forwarded-Encrypted: i=1; AJvYcCUxzgovypKPr4nL1zwm0hDSdOn9uoarlYJLFhLnRf8oKRpMJX/hAtq/SdQDTCkt19bOiIu8KrumOV0Qr1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIe9pf+EUmeoK40gUMXxBuJFhc/7rnpnAR9LBO3e2bOs5XyB/a
	eNGq8gyH4gvUhIiwv8gk7RjT7zDqpNCBYVMuKp/wed0+9h2iH3UIgeAE0tUKeXX/gXeFqf9b6Us
	b2pUN09n7CM1das7SO6JVV53P+7xjpsWHwU1qwA==
X-Gm-Gg: ASbGncvfNg4dsuiJArwMM1TPTiaKCk1WsryYLmK785eTvyg8QrPVMa/17ylXUZAJvAi
	9/DIc49DQwTXYYcrfRHo/5OSUpcFbAi0IXhKhGPiSxOqGI9qg80BTIppNZzsV6aZaY999qnB9u0
	Fz6KeojtSX5vDSTKVfXDxIysfZOA==
X-Google-Smtp-Source: AGHT+IF2HnTvgALEagtidtwMTknG9FoykhqBphkMLjIu+urEhq+snaAKQPbxfAEiEdOYOfpEU/z8RIcNqZf0RTZQZA0=
X-Received: by 2002:a05:6512:1292:b0:545:c9d:ef26 with SMTP id
 2adb3069b0e04-5494c34fcd9mr5744703e87.46.1741074704091; Mon, 03 Mar 2025
 23:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228064024.3200000-1-jonas@kwiboo.se>
In-Reply-To: <20250228064024.3200000-1-jonas@kwiboo.se>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:51:32 +0100
X-Gm-Features: AQ5f1Jqk33uHsY5UV1F0bE-LoNlIC6DrZiXxoZsYoJWU763-1spk-ecprSEFCuY
Message-ID: <CACRpkdaELuU6XDKacOLsWAF8ncbudJ9Tp0jykAyf-NXRLjoSdw@mail.gmail.com>
Subject: Re: [PATCH 0/7] rockchip: Add support for leds and user button on
 Radxa E20C
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Fri, Feb 28, 2025 at 7:40=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:

>   dt-bindings: pinctrl: Add pinctrl support for RK3528
>   pinctrl: rockchip: Add support for RK3528

These two patches applied to the pinctrl tree.

Please funnel the rest through the SoC tree, it seems
it should all be able to go in orthogonally.

Yours,
Linus Walleij

