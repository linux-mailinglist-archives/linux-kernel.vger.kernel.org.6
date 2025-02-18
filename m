Return-Path: <linux-kernel+bounces-519014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84368A39713
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A331896F95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437B023315A;
	Tue, 18 Feb 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jO5KWb97"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99723236C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870827; cv=none; b=bIbzFDBKRt2jNJF/ELEO2VXNi5qOZiEPbnSH3frmA0XDVxE6Z7S7sG0gApuYI2pEUaP/YkaKSCvgamHRFSsiQf+clTIHsfcd4lVVl0peSAOQ/IQHbF4QNyQal8eIqmH3yRuz0dg/elptwJeXayb66Ubhntgrr9xW60eqKOppLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870827; c=relaxed/simple;
	bh=MriLzKzAAEIyF0n21wSKbavIuTWQW69OLGHxVTJ12Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXlYUHjd69xGzzRQUntZ53+SCoL69upyGqc6gF4NP5+4fCH0r6BmwDiqTbEoXfofh6Hx2N+DmpakwJXoN4BFCIC+7GVI5DaoIYpiSv+GroJOolg7Ybk0GyPh7dz47M18SlU1LEyOhq08Zs3UKkVqCDUNbSAKL7D62qKf3s6iKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jO5KWb97; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so8990289a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739870824; x=1740475624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BhUxzH6oEqhcLF8JGu78MOnEz5ur1uVJcS1EtL5slw=;
        b=jO5KWb97uNFlKaKdO3gCGyzxwWn6d60ZrDDylBIGmg6zk4Raig/ZmiqmUTnsTmZ1Xb
         z6jGxi8zvUmgmHTH0vTBjJVmgilWJV1eAAp3tHdipjXSiYdBHlZf6cBAkXgF2SZ+Ef36
         3YRCKa/dDS1Ky0ScUTzRTIwZ9Wf8hk5mDEFOJWl5FUduf8xmLbCjqYOhZpkU7Scf3VOG
         /u0xU70yLGkMEa3wUPv4FAUfgp0h2O1BhIcqk9k4C4FWXn0d6kB6Cu/ga6jHNGWGUqhS
         /7Drs2TiuUiAERjaWFM32sd2Q49uIvqQnI+zwl1houZhNqJdEvTlU0UrGpcC9MQm8b+F
         KGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870824; x=1740475624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BhUxzH6oEqhcLF8JGu78MOnEz5ur1uVJcS1EtL5slw=;
        b=nGBDu8XdEMqxQ1gGLabQo53etKryY21EY0Q9O/4/wF6yhiuvc6fSrTzKySCCQ78/Iv
         7Kf2EMi8wUPyFcl6zuftfxkMZ5DiiUa7P00XhNyDNc/KrX3sedO2hbabPekY0RQUQBWh
         11lej0KlHN8aE2XSL1Lq/HF9IkyAYqvk1XvAWoRpruGUO1fdIolyq3r3nUB5TqF9R5gC
         8/QnWIHuG7kXz27cyENDEVD44ae9BmtUI5n4Vwlelz04vjK4WfG9qrnWq6v0wF0VUvhi
         TYFY7Ew77+xmVhlUqAfdb6cS9O6cSqczWLzXVTw/MgOg4Ic6t2mfPPK/vd5RcT5Un78+
         +zNA==
X-Forwarded-Encrypted: i=1; AJvYcCXfwK6OTzDAI3nVgQ8RXYmcc/+UcrATmn6E3hnoQ8/6IsguY+iNNl0n1PAAFRTXbeHNPhjYd0xQJ029Mco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AQSv/9KPAexfkO0qwDmBZpmLRpd8koWwaQPOfwyKXmM/wMnY
	lpGliz+TGC5Z42XBIE81ma5357cMViiWybiv9oup2+03dr21qpyX3nFc6Ae81CU=
X-Gm-Gg: ASbGnctHzixnfGtuQTvSED4TahQCDPW+iInUhf/9u24yi1UUMbFJx34mJqgUk9HcAZr
	zl1o8uxHNDHXnnSPDBNoN6sBZSAMVwc7+rpwD11zEN8aZMbNPa9LQQsgjtczpWrwJ7AhQ81Ycsz
	cWFz6CT8QF32qdoDc5EFHmce649cezvszF/8FjPrdWAX9il6Xy691ybXsUaMvLAR3eEX23zImHz
	iI4+yubgVSdRCLWqAx6Pzseq8XQxbFQnSmWcoxBFRNbFFS18BdXZthFqiRCDib6Gj4zYeULEKS2
	xF87O4A0k6h+/Gi5Zq6QzTwmKwM=
X-Google-Smtp-Source: AGHT+IGjPWmulA6Wm4cfnS6vwEaBjcuzifQAXHXx0FB+cG+S71ZxSZy2T1iZVOVPgEyId5cZUv/+tw==
X-Received: by 2002:a17:906:4794:b0:ab7:e8d6:3b12 with SMTP id a640c23a62f3a-abb70a958eamr1318865766b.1.1739870823557;
        Tue, 18 Feb 2025 01:27:03 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:202d:2fec:52ff:5dac])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb0fb63ecsm151544466b.115.2025.02.18.01.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:27:03 -0800 (PST)
Date: Tue, 18 Feb 2025 10:26:58 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <Z7RSYqQx72v-sPSt@linaro.org>
References: <20250206-x1e80100-ps8830-v6-0-60b1e49cfa8d@linaro.org>
 <20250206-x1e80100-ps8830-v6-2-60b1e49cfa8d@linaro.org>
 <Z68EUTlHcm6TxjlY@hovoldconsulting.com>
 <Z7Q8xwcfeE3tcBLL@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Q8xwcfeE3tcBLL@hovoldconsulting.com>

On Tue, Feb 18, 2025 at 08:54:47AM +0100, Johan Hovold wrote:
> On Fri, Feb 14, 2025 at 09:52:33AM +0100, Johan Hovold wrote:
> > On Thu, Feb 06, 2025 at 11:28:28AM +0200, Abel Vesa wrote:
> > > The Parade PS8830 is a USB4, DisplayPort and Thunderbolt 4 retimer,
> > > controlled over I2C. It usually sits between a USB/DisplayPort PHY
> > > and the Type-C connector, and provides orientation and altmode handling.
> [...]
> > > +	/* skip resetting if already configured */
> > > +	if (regmap_test_bits(retimer->regmap, REG_USB_PORT_CONN_STATUS_0,
> > > +			     CONN_STATUS_0_CONNECTION_PRESENT) == 1)
> > > +		return gpiod_direction_output(retimer->reset_gpio, 0);
> > 
> > I'm still a little concerned about this. Won't you end up with i2c
> > timeout errors in the logs if the device is held in reset before probe?
> 
> You should be able to use i2c_smbus_read_byte() to avoid logging errors
> when the boot firmware has *not* enabled the device.
> 

FWIW, regmap_test_bits() doesn't seem to print any errors either, so I
don't think switching to i2c_smbus_read_byte() is necessary.

Since I was curious, I tried booting the X1E80100 with
 1. One PS8830 instance left as-is
 2. One PS8830 instance changed to invalid I2C address
 3. One PS8830 instance changed to have reset pin asserted via pinctrl

There are no errors whatsoever, even for the one with invalid I2C
address. In other words, the slightly more concerning part is that the
driver doesn't check that any of the regmap reads/writes actually
succeed.

The diff I used for testing is below. (1) prints "skipping reset", (2)
and (3) print "continuing reset".

Thanks,
Stephan

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index fee694a364ea..1f8d61239723 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -1010,9 +1010,9 @@ &i2c1 {
 
 	status = "okay";
 
-	typec-mux@8 {
+	typec-mux@42 {
 		compatible = "parade,ps8830";
-		reg = <0x08>;
+		reg = <0x42>;
 
 		clocks = <&rpmhcc RPMH_RF_CLK5>;
 
@@ -1673,6 +1673,7 @@ rtmr1_default: rtmr1-reset-n-active-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
+		output-low;
 	};
 
 	rtmr2_default: rtmr2-reset-n-active-state {
diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 10e407ab6b7f..04ed35d14fd6 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -370,8 +370,12 @@ static int ps883x_retimer_probe(struct i2c_client *client)
 
 	/* skip resetting if already configured */
 	if (regmap_test_bits(retimer->regmap, REG_USB_PORT_CONN_STATUS_0,
-			     CONN_STATUS_0_CONNECTION_PRESENT) == 1)
+			     CONN_STATUS_0_CONNECTION_PRESENT) == 1) {
+		dev_info(dev, "skipping reset\n");
 		return gpiod_direction_output(retimer->reset_gpio, 0);
+	} else {
+		dev_info(dev, "continuing reset\n");
+	}
 
 	gpiod_direction_output(retimer->reset_gpio, 1);
 

