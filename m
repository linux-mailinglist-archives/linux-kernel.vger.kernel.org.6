Return-Path: <linux-kernel+bounces-389450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E29B6D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924B62820AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96731BD9D8;
	Wed, 30 Oct 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VTAFKu62"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DB1990C9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318674; cv=none; b=c+KmF5Rz4dusanzEvwJwm58Hm3QFs0C7x4c6DrzooodMJ+pToGH4gBpz/xmQeX0JgOz6ejV9sNzek0OtcOVqSacVII5QIcwDohrHgP5dczoVYa3atR9jplgdO5XDCqgCs4Eos6uRz3M75u7b9/SNZ7sHt+osi9bO8HrP1iXNJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318674; c=relaxed/simple;
	bh=uVgPnvdvVixUrLvSSmzOwFP1ifO3Y5wM1O4TUyu6hVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAPjba+cD4UHxugUKVLsjTXMbiMZCAhJtYPD9WOoy+mBJpJMdfMEm9fZbGzjIqG+S9DbGTKTEjQtBlBT8PClJaz4tJ+bbtomsa8YuQ909oxMKSVgx/3LDt+pXAYFVrsCaIVC3rN3NyOXNDQFeRbVmLBvA7yjdTOLC2VczPOpI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VTAFKu62; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so145836b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730318670; x=1730923470; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQzFRfxxx9a4+2mBsj0Xqoq7m6oJoVrd/IVmDiqDLcY=;
        b=VTAFKu62o3GP5mEXNj/d9LEvmaDwRxfnG54IVbgBN0hOGKiIXOGFpeMrzF6Rj0ziKk
         3ydTL5QRsiu6Tndjlzv9A+v8SivRh+9JmRSOtLGjTF4tCFhUMYJGpR1twI4vN48Hat7K
         r15lGmm3plKmIK4yc0bTaTWGS+hQRFcJdG5C67OnXWWqXGMC8V1j+8UVD0wdkrmoMxDU
         T0L9zw0aSn8vEOU3e0Xo5V31qh5N+Q4avNLVoU6fzYoGiaJ7NFeUUTxN7SNZcH5UrSpT
         8juOqBUVntR/MwQByZGiPIhiHHPE+yWN6IfVU9cUc7Y8bWNz0XNOclyp6xm6LYciqBXn
         qJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318670; x=1730923470;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQzFRfxxx9a4+2mBsj0Xqoq7m6oJoVrd/IVmDiqDLcY=;
        b=k2YxliiQ0cV9tVCmXlR+51OlRr1mlUQ/tu8oOPidr/emrC1UhBi97+fW3iupmd6x7F
         PeAnTuFpmUxY+Jp8dDCU7Di4fOCOqPbpemiTIksXGaZQC9S4QfQj2S3lUxx4K2JuGjg6
         yxkD0e81b+5mVWg20VBn4c84Qwje9PnMg0uwLqyR96DrHbXgOVoiKmANk6+4+IRo3HZt
         lcnLxJLeDwSGObGKqd30ZFQvLO8hf/tUc0ufUgvW5W7LcEKNLhDtaCJLST67Ae9CIAHQ
         5p3oQmA+qwrPFgqscIeb9reg++zi9Rkait5D59c5o5qosFYP9K8qvNoXG3QZsg2J49X7
         nkGA==
X-Forwarded-Encrypted: i=1; AJvYcCUWx8w/0x/1NUy6axHN4fXn7GK2Lnp2LhqAugv+Nd2UEcaDh16p1t6hL5isHx/zb3O9l99RSP2iFDU89z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54zap6amYdfzDU5KEwJY6vkXcY3qu2BeEVQqbQxtQ3Iak3Z2F
	/bzx0dnSa2GwKH87iFu7kaI9+rPni/stjvIYcRreE957VNmprAP+IvPZUTuBt54=
X-Google-Smtp-Source: AGHT+IGVMEfUTc5x54Nwx1RTWRE+uqmsaKPPq5D46+jAG7fPOuoQ1j0ELW9wLdgJ/Zu3YwUM52plmg==
X-Received: by 2002:a05:6a00:3ccb:b0:71e:4ee1:6d78 with SMTP id d2e1a72fcca58-720ab39e56emr5383301b3a.1.1730318670285;
        Wed, 30 Oct 2024 13:04:30 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c046sm9623477b3a.194.2024.10.30.13.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:04:29 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, vishalm@ti.com, sebin.francis@ti.com,
 d-gole@ti.com, Devarsh Thakkar <devarsht@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH RFC] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
In-Reply-To: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
References: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
Date: Wed, 30 Oct 2024 13:04:28 -0700
Message-ID: <7hmsilqrw3.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> writes:

> At the moment the driver sets the power state of all the PDs it creates
> to off, regardless of the actual HW state. This has two drawbacks:
>
> 1) The kernel cannot disable unused PDs automatically for power saving,
>    as it thinks they are off already
>
> 2) A more specific case (but perhaps applicable to other scenarios
>    also): bootloader enabled splash-screen cannot be kept on the screen.
>
> The issue in 2) is that the driver framework automatically enables the
> device's PD before calling probe() and disables it after the probe().
> This means that when the display subsystem (DSS) driver probes, but e.g.
> fails due to deferred probing, the DSS PD gets turned off and the driver
> cannot do anything to affect that.
>
> Solving the 2) requires more changes to actually keep the PD on during
> the boot, but a prerequisite for it is to have the correct power state
> for the PD.
>
> The downside with this patch is that it takes time to call the 'is_on'
> op, and we need to call it for each PD. In my tests with AM62 SK, using
> defconfig, I see an increase from ~3.5ms to ~7ms. However, the added
> feature is valuable, so in my opinion it's worth it.
>
> The performance could probably be improved with a new firmware API which
> returns the power states of all the PDs.

Agreed.  I think we have to pay this performance price for correctness,
and we can optimizie it later with improvements to the SCI firmware and
a new API.

> There's also a related HW issue at play here: if the DSS IP is enabled
> and active, and its PD is turned off without first disabling the DSS
> display outputs, the DSS IP will hang and causes the kernel to halt if
> and when the DSS driver accesses the DSS registers the next time.

Ouch.

> With the current upstream kernel, with this patch applied, this means
> that if the bootloader enables the display, and the DSS driver is
> compiled as a module, the kernel will at some point disable unused PDs,
> including the DSS PD. When the DSS module is later loaded, it will hang
> the kernel.
>
> The same issue is already there, even without this patch, as the DSS
> driver may hit deferred probing, which causes the PD to be turned off,
> and leading to kernel halt when the DSS driver is probed again. This
> issue has been made quite rare with some arrangements in the DSS
> driver's probe, but it's still there.
>
> So, because of the DSS hang issues, I think this patch is still an RFC.

Like you said, I think that DSS hang is an issue independently of this
patch, so it shouldn't hold this up IMO.

> Hopefully we can sort out all the issues, but this patch (or similar)
> will be part of the solution so I'd like to get some acks/nacks/comments
> for this. Also, this change might have side effects to other devices
> too, if the drivers expect the PD to be on, so testing is needed.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

We already discussed this a bit off-list, but for the record, I agree
with the approach.

I also tested it on k3-am62a7-sk where I've been doing the other TI SCI
pmdomain work and everything still working fine.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

