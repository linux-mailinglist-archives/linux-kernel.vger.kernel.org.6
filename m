Return-Path: <linux-kernel+bounces-227087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DD914823
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C1B23C88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A0137901;
	Mon, 24 Jun 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arZuFiCw"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B997137760
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227406; cv=none; b=BE7AiTI+EvRYo6icReOBr3FNcX1fGP5HgcnieY1ciAduPvl0pq0UUJD5onacKhLXg+plgsZCgop4QQfZ3ptnZvnemuwaeg/EdpLvD8DzThsrHqZ9OalV5FEEY4PxMXQJueTYvBZoxORsgO/BeDTRVe3hVSreLIVnBAFUC+smIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227406; c=relaxed/simple;
	bh=AD1VtzVCE0TJ9OF4Gv0gbV96kcusmSBZgcLK8llfDL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd87vO0RnTbQTA1u4hCVCqF+erI2xae1cNoxIAvvQuuMO1DoIqdv0e0RRC4zRQqAS4/UPKDtYElvG67I3GpIoGMLtj8O8S8iHmJ09OgzqlzOlvRnGeEABE5U6drt5K0Rd8+Pi4drb6srEUNUCokIRI0NrWwJdORJ+vaRA79clwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=arZuFiCw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cd6784aa4so3045437e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719227403; x=1719832203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8tSU0GAEUZoLkEFf7w79CW05hil/2XBKzKpS6M/7QY=;
        b=arZuFiCwfp32T39xkCjbgmnQpJs5OmDb/8TZIKoil/3eaowxqI4OoLZw+IqVpjCnqd
         pYAbGfTxJHuA7MLw25ntGQneqJLJyLWs/I6V6sF2yCVB0RX63/nEn+vqDhTltKHfsbdW
         vHgI3TDjHJ7DuCtG1kwTH0d6xkak8vseSTDXZOLIT2GY9lp31lwlDU21JHDMnKCbGYfW
         xrU1dsoAtUXBlY7u5ENcTGbmaoVCIR6mjOh+89NcLXN3W4XT73pNF9Mvr1THteGd8aB0
         G//rtiYUnhhVVdsBLJ0XeDaQv+awd4XZ/UA89YdhInNoYNCEUzaeoyYbFSX10gywKGbS
         2CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719227403; x=1719832203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8tSU0GAEUZoLkEFf7w79CW05hil/2XBKzKpS6M/7QY=;
        b=d08YIm6aO5rSYCBR9a/faaQOAQFvsv7m3LaGeoyoN7MccJfItwJU6PbmAVELhLg/75
         RTCi9GZ6fAmTQyVNmcZHwE5Clw+5rrDEZW/DvpvFJTGS+6b2iv+dLbhbfMGVzlSIG1f0
         G+tr+oEqjJPWkMiayBb/HKvxhRzjkSMSkqtKhj7hnzTLi9faEC83+USd6nvnhunQhn9V
         AcwuWaSscDQ+rcrnn7u0oXh8PBtRO1W0dB6TbPsEnA4O/QrQiz/n1Jk8fnqRdmLQXt1+
         Mzg1B6cHq4jUVUocRQ4u4H1T8ArWV9/wfGYq4JkeIDYy/WVyvZK4A3dZq0nGrmuvbGmo
         blJA==
X-Forwarded-Encrypted: i=1; AJvYcCXTm+ERgXNMlCg/aZsgCaGuA48sQeOjxkLq11SZ+a8m8M02j5eNLk5tcKH9Onwx4RwYPVWs8iKGqrhxBqNcOlg2cyA8VONm5132hgHq
X-Gm-Message-State: AOJu0YzTL9Tw3Cc9CfSxAu/xEjfUC2OWd6MPcUCxdx67Uy4oxG6O1ozk
	Z9/yrGizTngO2O5zNfsIoSnsrxi+vwbgQFo+OUG7KbSoKjT1OtA5UUmsX4U0MvE=
X-Google-Smtp-Source: AGHT+IGzuF4UMykQ47sI9hyqTgZzQSukllIxeZ9vAheW6vdrszmQVfCDHhejrRkJQpptDHWPTfMrHw==
X-Received: by 2002:a19:6454:0:b0:52c:dae5:6511 with SMTP id 2adb3069b0e04-52ce18345a6mr2382105e87.23.1719227401721;
        Mon, 24 Jun 2024 04:10:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdb4f3726sm826433e87.204.2024.06.24.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:10:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 14:09:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100: add soundwire controller
 resets
Message-ID: <pb25qgv6c2fb4vjby7yiqyorzqft7oyuucotw5267bshgvw3rg@4wry5qxoubhy>
References: <20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org>
 <20240624-x1e-swr-reset-v1-3-da326d0733d4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-x1e-swr-reset-v1-3-da326d0733d4@linaro.org>

On Mon, Jun 24, 2024 at 11:55:32AM GMT, Srinivas Kandagatla wrote:
> Soundwire controllers (WSA, WSA2, RX, TX) require reset lines to enable
> switching clock control from hardware to software.
> 
> Add them along with the reset control providers.
> 
> Without this reset we might hit fifo under/over run when we try to write to
> soundwire device registers.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

I doesn't look like this was tested against the bindings.

-- 
With best wishes
Dmitry

