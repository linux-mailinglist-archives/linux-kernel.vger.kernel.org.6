Return-Path: <linux-kernel+bounces-337427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6A9849FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472251C20BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DB1ABEBB;
	Tue, 24 Sep 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnN4wpEf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D761ABEA0;
	Tue, 24 Sep 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196631; cv=none; b=h1soKE7KG7llKq6bvQGVZO0IOJAs+FkGSjibE9Eikz0LX6ZE0HcC8ADMab1LmMc2366N7wkDnR6Y2FaCT6FRId+2hKYc3HJNI3gn82lVCTwzo/65E3Gw695xc+SbtKYhrIRIh59L6MxY9y9PozdS4kwz7wkYVy7gZyy9xEFYdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196631; c=relaxed/simple;
	bh=k4z37PBBqp5fmyzET3BqDMVMHN1TqYd2jjf2Z4433yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFnv2+SCPj++NGjN/FtL8EZDJhTiUldGNIv2/y7Gzwpt8ZgEcJvRslm9C/4O5TNY1ev6sZzw5pfvVLNkjwFNfAB6ZcjKqKP1M92mjhE71TKkzuw7hRiVwJGnSh18SDGL9mP5XbpNCsElRFx9d8hRU3CnZHhKFE/jsrG16w3pL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnN4wpEf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-206b9455460so520745ad.0;
        Tue, 24 Sep 2024 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727196629; x=1727801429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XrLxPgkgKOiPm2BGxnQytFvFW36owhoRBcwb0NgVun8=;
        b=VnN4wpEf3bgCg14QoXnT9UoqX+uybS9BUBoTKb+OXO8DfzHsmDFu6bIP9fpU1/0INi
         CNo4EPebJ+0P8zToRft3TBZZhOjhyFNGYf9F6ZXmAprQERgtuM9wmrzvF2YsptRZzJc4
         SBJKDhmp754ekBv1KL9Vm7ddfqx4NHFHGiliwmfKY0YcVgtmZWUjVOqNhsdxqzcEBsaZ
         Sm1v7jPqcM0a2zEy13GxPuRpZfpDIv77C4BVH3D3zM4rjvc6evQHYNlxJc/v8QArNsPW
         QU638bdLgkcgfhWiD85cNob6Y4+KX5STvelBYTIsXRbudIT8p0VecpwZizDTJs5UYLHe
         LjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196629; x=1727801429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrLxPgkgKOiPm2BGxnQytFvFW36owhoRBcwb0NgVun8=;
        b=o+AKg/zxl7ll36dm0BPcwkjuehnkEXd5YB1SgLOMsWi659kEALNoPIfG9sM3FJU/ff
         iq01UllKNMf+JFiO8bwifl6p3Mr0yAuAhYoH/V3icSKJFXyPvH+MfNv6chtAWCeZ0IKZ
         nfpiGw89KARdZx7OU2MOwGzKgIHnyF/4RV7YTNDOSAu8hsMhxr1h8zsUx5XmTpNyYzxO
         7kkYLferXHBDIFHYgdPtmkv7j9NEcMyi2rLOEwPj0fKy1Ju1FjQgZgHV5pc7cFYZbTwP
         G8XSZkcEfG1Jqk6cwMPixS2UhS6f1h/89w0wQxiwF/9O2VqnYjemZnKfYlpn8lH4uMC+
         kQVw==
X-Forwarded-Encrypted: i=1; AJvYcCUva3UvuX4oQZV7XTXz3evD4mH4Um2gjY+GLBjG5goY/d5fPbeY4CdRaKMR2rFyyKQP5bkRu06+NM4oO9tQ@vger.kernel.org, AJvYcCWoPh7cKOB+ZFBXMxiD0eElBrKI0fdMkBhuFzJp8gkztbRvienzIOa5zDlL7Im4e3fYEGIX8aydHpeT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64YpXGWtkE6+IQ6GQYotfkS9dh3+cP+UIlmA+UWO3BxHH9U79
	gpRh6dLIJwxcysKyBPvwoSElQ0kwaqgq1YRlCXWB9IOCxjg3yHdn
X-Google-Smtp-Source: AGHT+IFqfUUaDOPnE1y9rGSkTZU20gXomlidJ6gg6vYqzx/bbHaIxhoy3MT4T10BvyOIE84H7hgXng==
X-Received: by 2002:a17:902:f60a:b0:205:5d71:561e with SMTP id d9443c01a7336-20aed13c417mr58688885ad.26.1727196629208;
        Tue, 24 Sep 2024 09:50:29 -0700 (PDT)
Received: from joaog-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17dfeedsm12290045ad.147.2024.09.24.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 09:50:28 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:50:21 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: freescale: imx8mp-verdin: Add Ivy
 carrier board
Message-ID: <20240924165021.n6lln424llsfzhtu@joaog-nb>
References: <20240924114053.127737-1-francesco@dolcini.it>
 <20240924114053.127737-4-francesco@dolcini.it>
 <ZvLWP62Gw0nygxaF@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvLWP62Gw0nygxaF@lizhi-Precision-Tower-5810>

Hi Frank,

On Tue, Sep 24, 2024 at 11:09:51AM -0400, Frank Li wrote:
> On Tue, Sep 24, 2024 at 01:40:53PM +0200, Francesco Dolcini wrote:
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> >
> > Add Toradex Verdin Ivy carrier board support. One notable feature of Ivy
> > is the analog inputs. These inputs are multiplexed, allowing the same
> > input to measure either voltage or current. For current measurements,
> > a GPIO switch enables or disables the shunt resistor. This process is
> > automatically managed by the Linux kernel using the IIO and MUX
> > subsystems. Voltage measurement is always enabled, but the voltage
> > measured by the ADC is scaled by a cascade voltage divider. In the
> > device tree, the equivalent gain of the voltage divider is used, which
> > can be calculated as follows:
> >
> >                ------------
> >                +          |
> >                          .-.
> >                   R1=30K | |
> >                          | |
> >                          '-'
> >                           |-------------------
> >     Analog Input (AIN)    |                  |
> >                          .-.                .-.
> >                   R2=10K | |         R3=30K | |
> >                          | |                | |
> >                          '-'                '-'
> >                           |                  |
> >                           |                  |--------
> >                           |                 .-.      +
> >                           |          R4=10K | |
> >                           |                 | |      ADC Input (Channels 0 and 1)
> >                           |                 '-'
> >                -          |                  |       -
> >                -----------|                  |--------
> >                          ===                ===
> >                          GND                GND
> >
> > Vin  = Analog Input (AIN)
> > Vout = ADC Input
> > Rth  = Thevenin Equiv. Resistance
> > Vth  = Thevenin Equiv. Voltage
> > RL   = Load Resistor
> >
> > R1 = 30K, R2 = 10K, R3 = 30K, R4 = 10K
> > RL = R4 = 10K
> >
> > Rth  = (R1 // R2) + R3 = 37500 Ohms
> > Vth  = (Vin * R2) / (R1 + R2) = Vin/4;
> > Vout = (Vth * RL)/ (Rth + RL) = Vth/4.75 = Vin/19
> > Gain = Vout/Vin = 1/19
> 
> which properties related these value?

The gain value is used on the "ain1_voltage_unmanaged" node for the full-ohms
and output-ohms properties.

Best Regards,
João Paulo Gonçalves

