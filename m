Return-Path: <linux-kernel+bounces-449069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE239F4945
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA3316D5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130B1EB9E8;
	Tue, 17 Dec 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEy63q2G"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76B1DFD9D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432829; cv=none; b=Jube5hdjSWH+SjseV5VOXtCpThZ5VUF9Cvom4IoZ+MPrq20aCb8v2K+LvIYzHpGss63x7a/5vybnaQIFQPg61OfccznO3k7m5wUxdoaC3poHtAJmca5QduD1oiy51JIuCcROkgeutDpSlAgQUoIyMeiLtiger+kZOblRI6fDvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432829; c=relaxed/simple;
	bh=sn/GJ4+g44OhE9Mc8Vrz5T6j/3vd76+SDLofs3xOB4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSivS6WEtABPmhHG/elT99fuBXHGPXOunWg033tg3NPgV7dxmMAyhx9Vuj5yRgRUR5oDX8p+DjslrlayXjuouUYB2HjgCRv6PSYdjCaZmnFiNiFbw3eTNYUNF7eRcR76dIUw0zlLor4V2EkjaK50at9QW+Dzs6w3658sgaw15J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CEy63q2G; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so6753361e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734432826; x=1735037626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TC5jCVTWg7lej2YzYw5kT82WMr/4h0gli5MbAUjaM8=;
        b=CEy63q2G4ruYlwFglV5g0nsvR0DrhO2Q3RusQmORCfhjo/GKsXfuSg14deeNToGFOz
         fEUWaKadMYdOH74OmUALYS2QWHOmRXZZBFnqSnnjTlk7QNx4xOWLDG1y3egQ0st8OV1o
         OIfQv7JUlfcNDYJxzBR0oWQAz8/NgPs6wuF6868Fko4J4fOvuUCuUy3t/OwkFNX0IYj7
         3K/xOr1nzdYN62mRXXEUkPRcm4ObRa6rbSaesn3SX03YO6lJYCqPoqiMMUZIIY76Tut7
         yH3Nd2maMvAd9r/XsUN+ZUt3HltIJLSwsGI05/INlFMPoTltU+cOq0/v+rNNDHTVLwrU
         ypxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432826; x=1735037626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TC5jCVTWg7lej2YzYw5kT82WMr/4h0gli5MbAUjaM8=;
        b=Wu/oxhVEYqKzD6FO4jDmpd8meravGeI4VMQiIHI84Wlzrn8qKGIyxfeB7PcUzlu62H
         J1iuWCO0u3ppLtAqcPfooO4CKgNzy+A3chVCZszOXGTzvG5rHcFKvKrlKSL7P/V4qmLJ
         j9BNiZ7barU0nYsGPpDkAUfLdnmzhJw7k+XECfuWRtEUWlM6ty/zdB+IpmbkcUKNytkV
         jxNdfXTqyQkLs2xCovg3CQw6+Nm4ihj913hTTVerF7/WhiEUwSE2Ix3ETcODm981N0Wr
         GcuNYhK7yCwuCRXVMr9tu2vAVB6MjwCdH/7jew46610vqj3ckpoAWbu0okbTmIYp6SgP
         BAUw==
X-Forwarded-Encrypted: i=1; AJvYcCWHIzus61rIOyytXnrBhKd7XMTIHRbl3lCCxGBqfsLNDgvC0NPnsfSUc0dlpHVVPxzprGDQU/Pzgg9Vy8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMYsfMz+BQp7NowM7wC+HUrEQZuylA+n7nxFlarNrPckL7mqI
	558+5QYAe2WRz4s4FcO7LUcoPYmBWIzp3BJRJzL4sXuX3usd3EJ/RrnF+XDxditD3J0hxvqZhvi
	nhZWjV850UvIgbtLdUh9s2zlIkJx688tLH7kVOg==
X-Gm-Gg: ASbGncvqzX2bOtGeYx6OMjG76IS+bLd9q850V4o1o563fD6dZYFRgZ2Ukmj/61ZQmxM
	lt7ZzxE9iBpNX0zHvC97zSW5X/S8bogKacSi+uQ==
X-Google-Smtp-Source: AGHT+IFCphVocPAZunWIma8kPi4+wa7YjuJsfjmpYKp21Qxrzj+4sr7LDLYc8cAc2pcpQ3Dk/5SYwN1smESPCaOVYA0=
X-Received: by 2002:a05:6512:3094:b0:541:1c5f:bf86 with SMTP id
 2adb3069b0e04-5413158b015mr867723e87.18.1734432826342; Tue, 17 Dec 2024
 02:53:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217091308.3253897-1-quic_mmanikan@quicinc.com>
In-Reply-To: <20241217091308.3253897-1-quic_mmanikan@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 11:53:35 +0100
Message-ID: <CACRpkdZimr26=3hndy58OkxgVxDZ2990h_xRHwMweJykfhT=4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add SPI0 support for IPQ5424
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, konradybcio@kernel.org, quic_srichara@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:13=E2=80=AFAM Manikanta Mylavarapu
<quic_mmanikan@quicinc.com> wrote:

> Add an SPI0 node to the IPQ5424 device tree and update the relevant
> bindings, GPIO pin mappings accordingly.
(...)
>   dt-bindings: pinctrl: qcom: update spi0 function
>   pinctrl: qcom: ipq5424: split spi0 pin group

These two applied to the pin control tree!

>   arm64: dts: qcom: ipq5424: add spi0 node
>   arm64: dts: qcom: ipq5424: configure spi0 node for rdp466

Please funnel these through the SoC tree!

Yours,
Linus Walleij

