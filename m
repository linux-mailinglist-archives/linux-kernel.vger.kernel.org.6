Return-Path: <linux-kernel+bounces-376260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3839AA257
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1D28171D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF919D8BD;
	Tue, 22 Oct 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHEBE9hE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CE19D097
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600979; cv=none; b=n1awX+u/uLcqcfWj+akmYfp8jE0I7cGq1EQxQA1t36Efypu4//LjLsfbCMBKFW/gm3PNlKLHNBi1LVsLufITlkd4U87DJKEQo8VszaMnML/+XAdO9dGzfhzrmx8Rud+zM3WopOVlj75zyZSc7aaEqhBTeBLJH03eUjA4XxbFgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600979; c=relaxed/simple;
	bh=ARtJ6kvqIGcFruTXV6okIoHVDlTbGuGMZPlyUCFrYwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITsxZIC5bfQkNuZMYFFLArM/mPDD05QNcoLznSOCyyl/bjxvK+5Qrw0A+pyQTmTfZOiRxvltaTMQNH7dz5DoUY6XzUdsrBqF3q0H7RQrTzZ0LL5RoaKuMvLQHTQ8eOXRjCgTnL2j97oZULyWL1KTCslT4xZmLTKb/FrPfOJVC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BHEBE9hE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f72c913aso6478246e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729600976; x=1730205776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARtJ6kvqIGcFruTXV6okIoHVDlTbGuGMZPlyUCFrYwk=;
        b=BHEBE9hEaqC6baMwuNBt5nYatLvADUvDXL9ZHcL3GcqprjCwLoe0MFvdQcYnOaIuf8
         bfg6q4TtTS+CyqfLkgH48tpq2TIs/7MzjtrgbqH3rRpDWDKEmBU84+eBgEFJ/J4HZxoP
         GolojXA9o5l91ZNCM3vBKGu0ktjcuJR/YZhFuypxwSfxzTn11jqmhmJffniOx6kxDQFt
         wC5JSF7zpKfIBJC6REu9MoPfu6Z7br0oVn3MU4yaKitIUTVQXY/iaq1bpQg08t+oFqVP
         pggl4lPEXz9hwyY4qgEQFinI6Bhf57bYwkGT8U8UcXJUO/oghEyMrbRphcd3xA0mjp/8
         6/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729600976; x=1730205776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARtJ6kvqIGcFruTXV6okIoHVDlTbGuGMZPlyUCFrYwk=;
        b=L7rSJVIimwePJTua2+lwZkEzyT/EKwWNilmewx64MqbJGlY/lHfnRAKztvW0jBn++2
         QJd6FSV+fXkiTLn75WRyZLew0RKubE73BhDoC5Pf3a4ehYfed6KzpB8YGtZJBKCZoDmL
         CoHgp7lX1M9XPKwUqvQB+0QGfle7YB2ij9jA20QwIfqsNa4OtntYm/EQyRO2JD6Rl2z8
         eRAwfqXHxwG216HyDdsObSve2TQUgd52ZxF1hxaNeoDfLgUVb619xY7IZWtIv2/cSgp5
         /icoGlJR2AWW5cy6e94fNo/AecJaWeIl+9nIaLb+jib5U5w4BjF0x5qJE8GGUEbTTZXQ
         j+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtVb6bKHeyRR2PWXAeZL0wL0ukpYQdPwgwqQx2m/lBll3ZgDI0VMsE7CEq7qHvP9IeYS7XZzV4nWsO1y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKTZ/FtqY89MR2JDIUPOCJSTB4b85Tqd1Zvw6O/VUzbS17dYt
	LP+wNqSPHvj6qk2qSHGGnHflddoZVBUCdiK2p68jBlweHyI4XrEuLZhsXEVRsmrp8a0qZs8f6He
	ZZltRmSU2grWyBn5KqQME+zt90LXDPQ7H8SzK0g==
X-Google-Smtp-Source: AGHT+IEBcVfZ3JWaOM04XJNSL54UsLyONVoNwTnqh64hkWL8NFdGQD13XXBI25QnSA6vmIj5FcVBmPLEvaztSgYOWOI=
X-Received: by 2002:a05:6512:2393:b0:539:f65b:401 with SMTP id
 2adb3069b0e04-53a154a2413mr6984977e87.57.1729600975700; Tue, 22 Oct 2024
 05:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018-qcs8300_tlmm-v3-0-8b8d3957cf1a@quicinc.com>
In-Reply-To: <20241018-qcs8300_tlmm-v3-0-8b8d3957cf1a@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 22 Oct 2024 14:42:43 +0200
Message-ID: <CACRpkdYY=qLocvD_c-1TkJep3QMAOOWkmAYanvDzhyBgsC0RYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pinctrl: qcom: Introduce Pinctrl for QCS8300
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, quic_tengfan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 5:20=E2=80=AFAM Jingyi Wang <quic_jingyw@quicinc.co=
m> wrote:

> Introduce Top Level Mode Multiplexer dt-binding and driver for Qualcomm
> QCS8300 SoC.
>
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>

ACKs on bindings, up to v3 and no maintainer comments, driver
looks fairly standard. Patches applied!

Yours,
Linus Walleij

