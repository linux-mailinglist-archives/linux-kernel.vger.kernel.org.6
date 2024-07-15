Return-Path: <linux-kernel+bounces-253100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E01931C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FF9284856
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321113CA93;
	Mon, 15 Jul 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b="QP+tZhWN"
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCAA13C67E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077806; cv=none; b=hPS7MUVbfwHYS9c3s8nU2FdMam/5vHJY0ozQMnZGtd1vso9CJtXTC7/L+KlAC6I/3tq4s5pt1em779XSMHDjyvOnzCAWzLSfktVZLZp16WGz3nF1KpO+cNv7ww3x2hALST+KP/tzVmYnuQ1a2krVnhNeohL+iO0GiW2szGQkAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077806; c=relaxed/simple;
	bh=u1w1RSPyvouaCu29N86pT19j/1+b1aqhYphRKX0gLXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqnkWBFSRYdrReUGM2WmgUa6XyeOD564WRwiqhlUibIY9l2N0gjZV13gxh+ysKUDAZ5UusB2ae7TDE8KVEUR0tx4RWWB9cLFl5haMK2DNsv9DNB5rUUupqA5rsFipbZDAh4wmpDWqJQS40cHaTeRQMkmAeZveMouOeTOErO7mlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se; spf=pass smtp.mailfrom=blueri.se; dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b=QP+tZhWN; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blueri.se
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so63735381fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=patrick-wildt-de.20230601.gappssmtp.com; s=20230601; t=1721077803; x=1721682603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1E/MglafaC0iSeZ1zI5mAhmpx2DB0Xx9LGnb5AqC2Qc=;
        b=QP+tZhWNjGDLUFuG4YLCpr7Gj9qUvZTfWrNMuG8d/a4/KNXqUp7FZy4Xo4Kn+n1Gv8
         FCfNODVhT6q9Tz882QKaQr/wwpI+Uj+g1r/HxwG1kx5rZdAJgxp8FMrvSu97nyhK87UZ
         FjOCoXNqkP1WevFrlIP+ClFzpphf6qsiplOOTEPnTBT5PcgqcpvFq35Ob+5AINN54uN7
         klTlOsV48zBjSguple5zG5Q3buGUTwEudoOxlFn+fxB5wJ4Yy4qpbJ8MxIJM5i4vjfTS
         eJmJ1q4lmr790ewLCda1LHVh8WS0rl55gVNehcg4G/+q/V8BVRo1Q8mCSuxLhPl/wxJz
         AcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077803; x=1721682603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E/MglafaC0iSeZ1zI5mAhmpx2DB0Xx9LGnb5AqC2Qc=;
        b=uTPxOrGrWVIk5cRjCrh9SpbgvLZ/NmhGXZ2NWKEP9Rtd0FnsCl7cHFozcXfJSS5fL2
         81vixXHOy/Oc0nRl09SrIgEAvNktA0u9qDng/kdsjv2wmFY788jLmUpRSmta9jpw/9kW
         e8LzcyBmXUvDygBRir6Hbcka5Jkfh2RuV8jPxpXd8emowh9K2U3PXBa6qSwxcOzqCxEZ
         6EsmT2uK6rE/iIvCgb7yJ7smAyOSObbJ9Chy5HOtyajXrYwwoBtWvCfGJOI47apbCmaX
         +nVKgkHAHicDQNkpaReprOwQSrTZFzxtoO2LYbZKjInEiHKOxYB2sJBSgotosy5gXcWg
         VCFw==
X-Forwarded-Encrypted: i=1; AJvYcCVJNa0b02i+n24MnWgKG7DpwL60Ht3S7uohprcrRsy42y8wdc/XD1OHCJxo7xdd2E3sWNmEfk3vTah3PJgOXW4aq8HMwzPyeSVC6ZNo
X-Gm-Message-State: AOJu0Yxuw+HQoDAsLagLr56J4B5MCg7U2HGcpvAVrQd9HmsZ2XAMSr/r
	k3Aw1REKfgGEw6p6eL5DRxLIByV/qJQFGQqUhH13TijSO2D06QQ8MBpalFR2V+9B45E9vGBTljf
	KHDEpP3Injpk5SVc7Lq9paJrpoARLilEFtWE9CYpzwssauppU
X-Google-Smtp-Source: AGHT+IGr0eKJQDn+miWwt865fhI8Jw3s3SNaJU/TIdLiI/YGgzmQ4yRL/+c6jpc+YHdFr7Ga15A3MjTH5DRE
X-Received: by 2002:a2e:bc23:0:b0:2ec:617b:4757 with SMTP id 38308e7fff4ca-2eef418bf09mr2322601fa.13.1721077803054;
        Mon, 15 Jul 2024 14:10:03 -0700 (PDT)
Received: from mone.local (p200300c1c7288900101feb289c80409b.dip0.t-ipconnect.de. [2003:c1:c728:8900:101f:eb28:9c80:409b])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4279f23edafsm2961325e9.7.2024.07.15.14.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 14:10:03 -0700 (PDT)
X-Relaying-Domain: blueri.se
Date: Mon, 15 Jul 2024 23:10:00 +0200
From: Patrick Wildt <patrick@blueri.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: add ath12k pcie bindings
Message-ID: <ZpWQKMX9jhb-nNlh@mone.local>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <ZpV7B9uGVpeTSCzp@windev.fritz.box>
 <d921bf20-1d83-492f-ab88-0f23de26a649@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d921bf20-1d83-492f-ab88-0f23de26a649@lunn.ch>

Am Mon, Jul 15, 2024 at 10:54:18PM +0200 schrieb Andrew Lunn:
> On Mon, Jul 15, 2024 at 09:39:51PM +0200, Patrick Wildt wrote:
> > Add devicetree bindings for Qualcomm ath12k PCIe devices such as WCN7850
> > for which the calibration data variant may need to be described.
> 
> Hi Patrick
> 
> General, the device tree binding and the needed changes to the driver
> to implement the binding are in the same patchset. I don't see
> anything implementing qcom,ath12k-calibration-variant here? Does the
> driver already support this, and you are just fixing up missing
> documentation?
> 
> 	Andrew

Hi there,

technically I could try and make that change, but I don't actually run
this driver or Linux at all; this change is for running OpenBSD on that
machine with a correctly defined device tree.

The realities of Linux being the de facto upstream for device tree
bindings force me to submit changes here so they end up being usable
for other operating systems as well.

I would assume that eventually someone that runs Linux will adjust the
ath12k driver as well, because this kind of binding has been used for
both ath10k and ath11k and this is just a copy with a name change for
ath12k.

Cheers,
Patrick

