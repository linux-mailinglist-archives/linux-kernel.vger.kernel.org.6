Return-Path: <linux-kernel+bounces-189533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D998CF15C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12303281AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A07129E6B;
	Sat, 25 May 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1Zt9xuE"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67B127E2A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716668249; cv=none; b=gKG5tnpdk0jcsNmHVNrX3aJYr+823I3aG0VK8BVdEmmtCRzCx9E7OBBB4BA2kUKeXaImGyijSfKo1gPIJI5jPOLG0ddEflAKpnmKBreoYXT8KzQ6F+uBWZ0liMEf6wDm9qeprFraBfUnUsS8j9m+YQJjxItI/SoG32BDHdMJ4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716668249; c=relaxed/simple;
	bh=QHSmgW7osBH+KHXlF1/WzNWwE9eqv8p67wUx/Ts4k+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LG4B4ji8Ikke15cvxuFS1Cpqgp6NRLAigTGjutMLZT19npp5WtnRH8mZA3TQVM6LNTBQVYnKFWJ5uRlS0aWP1BsXaKnmXcnab9HRhVGixEXUWXZWWvFMI6Zgozy1hnhklrYnPVbxl/+9GvlpiBjqj5ESTle1LA5oMry29wRvGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a1Zt9xuE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e964acff1aso13142011fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716668245; x=1717273045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqkkaAhB5zodAiahm8ADezWoNphieJvlbxZ1nCfU3mY=;
        b=a1Zt9xuEhGY7mqVaV75M8sfydzfi2SwzfyQu9V/3H2laKtqxUCcXbjmAQsQK2qLHQs
         HZRqG2EWtd7oPS+8Q15rOnmICwsj2Gr2ZNaTXzQ1l5r9FKXgrwEoovEeV7pDHTR4j+dX
         /USe3NPzsI0SsQU8w/AYgQW9Wwzhvy+j2rXwnQoXNpRV5tlPtEFDPRO9fhuPS9Jr03Mh
         K/iTKymmjHGFzm3Qd0eXV0y4DXy+Dkp2KjPg/lqOCPPW9oj8dIuhed53nM1tZMtJo5Ns
         9wO0v2E12NXjEqZlW8dT3tPza2BieAlGrb7SJCV7OqMGfaWzg8OuHeAcfavU3i2nYspv
         pdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716668245; x=1717273045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqkkaAhB5zodAiahm8ADezWoNphieJvlbxZ1nCfU3mY=;
        b=t0OOHZGzh0STRRfDWoSlp1/ODG3+Tpt8ouQ56EPQYZauTunHGsDqaBdBshIEa2wGsm
         2L5siEjXywfkQy8UQBZ9DRdm2XUSjKViqWDaWMWNuU4wns9BGs3HnKgPJXxCEL4j8qel
         sx23CdI/rPIma1xE9S28ZfwxHmGfdIiZY2tIjQ8/0vaTLzojeqvhvlq540BLFohHGBlL
         7YXcdDbqFiPZV+mO42vCblipP0l3w7UmKKCuW4+95ClhXDZG+uM+3RNQFhRwn4JrE4JI
         hIdUXsu5K6M+ZjTVG6Aca9wjMHC4QtoIw0zGBLTn1rSKNbPMrFoctSzAAyZoPFjpAjwP
         spdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfAofK5ZEMaFEqCQwIupO10lpqszQbjiDz11JjbKuCyA2Lrl3zqLSUfZX7Gla3YZZBgorGd62qrWh4k+dCSreZScGV7W3n0Yl6qc2u
X-Gm-Message-State: AOJu0Ywg2cb9mRLvcNOeIWewE4KB0AkppxYPT4WKSy7It9ZzTTXh5gfQ
	yhplU7Uf1todb8QE8qbOddRKPBiWMTwe7pdJwdRt0WICjcCeVQGH5qBntEhYUag=
X-Google-Smtp-Source: AGHT+IHXljxuGalAvmyjvzrcNfI1wbojmx0iYFgMUe8hBfLdt+A/BD1AGKqWABqy13mTAz406l/ehQ==
X-Received: by 2002:a2e:a178:0:b0:2e2:1a8b:e2f with SMTP id 38308e7fff4ca-2e95b0bcf29mr34404251fa.2.1716668245179;
        Sat, 25 May 2024 13:17:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcf4bdfsm8686871fa.63.2024.05.25.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 13:17:24 -0700 (PDT)
Date: Sat, 25 May 2024 23:17:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-usb@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sc8180x-lenovo-flex-5g: Enable
 USB multiport controller
Message-ID: <dazmvgycbywpsbgtrnhi4hv3jgi6lt7dpws4gn2du7z4q4ygr2@ph44udnljkhr>
References: <20240525-sc8180x-usb-mp-v1-0-60a904392438@quicinc.com>
 <20240525-sc8180x-usb-mp-v1-10-60a904392438@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-sc8180x-usb-mp-v1-10-60a904392438@quicinc.com>

On Sat, May 25, 2024 at 11:04:03AM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The Lenovo Flex 5G has a camera attached to the multiport USB
> controller, enable the controller and the four phys to enable this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

