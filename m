Return-Path: <linux-kernel+bounces-380137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B832C9AE96B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77633283F02
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214731E490B;
	Thu, 24 Oct 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIkztskb"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BA1E2009
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781655; cv=none; b=Hf7LEXFvl67Qfk4VKi1hlLlL1vmudNLU4hROpgiKwszKUSUfQyZY5lrVaIVkrrLUsnjTaDAyBXFLOMOWXvgO1e5WGMPGAkHsVTI6VpJsfJqzliTJEjcEJdCHWF300f9eL8ZVZtEG41xkQCZhjkq3f674sdf84HWGhc6/5ab3gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781655; c=relaxed/simple;
	bh=uAMb2IgjaubzKm4Pv4bjVb+MiCOKSuwGG4QO6mWiWn4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NHgrQbjtaLAm1meL3+V348En5KJdRB6crBTAAIEtUSHJQJkRD1PnAH56CUhX/2NgAw/2LGSLr7ULtwgXhY4e20sdwp1I1YR3V9vDFwwF2oqW7B/pMz5HgJMZH/kXmAr6rVjiClOIyVCnTS+MJ2TCvcGk9U3UxQM9XbnN2vvN6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wIkztskb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so10813285e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729781651; x=1730386451; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KigJxvM6Pu8IjVv23yLbwetYwa80FJB9vzgDeDlUbdw=;
        b=wIkztskb6Bk1cq0LTo9jcsP2zSRezvw+4cY/iv9/1ssPDjS4zqw36rJ9WNHvTrW/kV
         nUSGK9nLQF171e4I5svhlv6+Y2EAHpRGJ/4E+mByNqnfbVtPnHJtlkCUuVlwILRwtoqR
         qWtRydpHRk8hYuYB/YycseADzMhH15qKK76EwhoCHmHdbcxouPfQlDAKgffvAD20lyH4
         lPZYESzW0aTm0YN0tHweq0S1Mt6Yn2a7Yl1JpyutI+0nBqaUMpGAUxIO4eTnSDCeXcS0
         7ji0KJUTHgRj0Kkn6tnj2+hGAU5WmAbg08Yu5HgXbJoBra+heWlxR/0zydweiY/iwXsI
         RxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729781651; x=1730386451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KigJxvM6Pu8IjVv23yLbwetYwa80FJB9vzgDeDlUbdw=;
        b=oQOubCNKcYGJrn+Yss09h2yn3NluQmMp9X7GG+S9QMbsC1+OKE7pchtLJgPMmTAddu
         jI00FCWBzCTPMPq19YFbJjajdlri2Qfp4JUwXzBJeari6xQ62JSd46wJh42RIFWHFeyt
         RbMm8a+G5IfMSXDz1EZ5ffcyGR3OumX4ofGBCB/nGnPpH1Nbz+qqFGSVxIwCOpDcDxuq
         LulVmTmNjQtk//PSBWJ2zX+P2qnZfFDtbnPttKe0X2RgheM3FRP1l3rZroPvSQO251P/
         AUAgMq8PLZY5lD5riJvEip1qk0k6wZ13WHVS1BV7Cqk19ZeFXG9CGKEJ81wqnA/Ts3/r
         HRgA==
X-Forwarded-Encrypted: i=1; AJvYcCVyWVifNmoy+sQsg2N033JKQ8HxrF1wbIvNX5qKwQ08iZRWZU1WdHLRcSdmnc5aWCQHU3F05mkuZWFvGII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKX6ULRaRQ3Q+E+yAbRwaFsyFcC7ay4yTBbGy5m3NwfYXjFnl
	GWf7CrL55eJYIwESvp2UfB9HfVPZLbPHWaAoEjLHGw0TdmPcONO3oXPMB0/hb0Q=
X-Google-Smtp-Source: AGHT+IGkQcN99NsdyWzH4q11hXaQb6QOi/LmJNuJ/1tfYBfHT3ynjuSALbNxurEDnxEdnmq8cBHvAQ==
X-Received: by 2002:a05:600c:310b:b0:431:5eeb:2214 with SMTP id 5b1f17b1804b1-4318c780bb2mr16799805e9.33.1729781651245;
        Thu, 24 Oct 2024 07:54:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b57b5d9sm20251115e9.44.2024.10.24.07.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:54:10 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:54:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Laura Nao <laura.nao@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: ben.copeland@linaro.org, naresh.kamboju@linaro.org,
	anders.roxell@linaro.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC] driver core: add a dbg printk for successful probes
Message-ID: <dc7af563-530d-4e1f-bcbb-90bcfc2fe11a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Laura, and Nicolas,

I've been thinking about the driver probing talk you gave last year.  The
talk was about how tricky it is sometimes to determine which drivers have
probed successfully.  The drivers might be built into the kernel instead of
as a module, for example.  The idea was that we could make a list of
drivers we expected to probe successfully and find regressions in probe
that way.

Why couldn't we just add a printk in call_driver_probe() and then we could
pass

	dd.dyndbg="func call_driver_probe +p"

at the kernel command line.

On my qemu system the `dmesg | grep succeeded` looks like this:

[    0.135501] reg-dummy reg-dummy: probing reg-dummy succeeded
[    0.169490] psci-cpuidle-domain psci: probing psci-cpuidle-domain succeeded
[    0.188039] ctrl 9000000.pl011:0: probing ctrl succeeded
[    0.188598] port 9000000.pl011:0.0: probing port succeeded
[    0.206720] uart-pl011 9000000.pl011: probing uart-pl011 succeeded
[    1.071943] pl061_gpio 9030000.pl061: probing pl061_gpio succeeded
[    1.117740] pci-host-generic 4010000000.pcie: probing pci-host-generic succeeded
[    1.159963] virtio-mmio a003e00.virtio_mmio: probing virtio-mmio succeeded
[    1.166752] virtio-pci 0000:00:01.0: probing virtio-pci succeeded
[    1.168180] virtio-pci 0000:00:02.0: probing virtio-pci succeeded
[    1.173959] virtio-pci 0000:00:03.0: probing virtio-pci succeeded
[    1.178934] ctrl serial8250:0: probing ctrl succeeded
[    1.179059] port serial8250:0.0: probing port succeeded
[    1.182032] port serial8250:0.1: probing port succeeded
[    1.182490] port serial8250:0.2: probing port succeeded
[    1.182916] port serial8250:0.3: probing port succeeded
[    1.183309] port serial8250:0.4: probing port succeeded
[    1.183705] port serial8250:0.5: probing port succeeded
[    1.185558] port serial8250:0.6: probing port succeeded
[    1.185962] port serial8250:0.7: probing port succeeded
[    1.186352] port serial8250:0.8: probing port succeeded
[    1.189519] port serial8250:0.9: probing port succeeded
[    1.189972] port serial8250:0.10: probing port succeeded
[    1.190378] port serial8250:0.11: probing port succeeded
[    1.190791] port serial8250:0.12: probing port succeeded
[    1.191180] port serial8250:0.13: probing port succeeded
[    1.191595] port serial8250:0.14: probing port succeeded
[    1.192017] port serial8250:0.15: probing port succeeded
[    1.193533] port serial8250:0.16: probing port succeeded
[    1.193955] port serial8250:0.17: probing port succeeded
[    1.194360] port serial8250:0.18: probing port succeeded
[    1.197551] port serial8250:0.19: probing port succeeded
[    1.197965] port serial8250:0.20: probing port succeeded
[    1.198353] port serial8250:0.21: probing port succeeded
[    1.201960] port serial8250:0.22: probing port succeeded
[    1.202528] port serial8250:0.23: probing port succeeded
[    1.202997] port serial8250:0.24: probing port succeeded
[    1.203415] port serial8250:0.25: probing port succeeded
[    1.203819] port serial8250:0.26: probing port succeeded
[    1.204279] port serial8250:0.27: probing port succeeded
[    1.204669] port serial8250:0.28: probing port succeeded
[    1.205659] port serial8250:0.29: probing port succeeded
[    1.209673] port serial8250:0.30: probing port succeeded
[    1.210117] port serial8250:0.31: probing port succeeded
[    1.210643] serial8250 serial8250: probing serial8250 succeeded
[    1.212911] kgdboc kgdboc: probing kgdboc succeeded
[    1.291410] virtio_blk virtio0: probing virtio_blk succeeded
[    1.309485] virtio_blk virtio3: probing virtio_blk succeeded
[    1.331200] virtio_net virtio1: probing virtio_net succeeded
[    1.354786] fw_cfg 9020000.fw-cfg: probing fw_cfg succeeded
[    1.356688] scmi_virtio_transport firmware:scmi-vio-backend: probing scmi_virtio_transport succeeded
[    1.357830] scmi-virtio virtio2: probing scmi-virtio succeeded
[    1.394738] scmi-clocks scmi_dev.3: probing scmi-clocks succeeded
[    1.415087] arm-scmi arm-scmi.0.auto: probing arm-scmi succeeded
[    1.426512] armv8-pmu pmu: probing armv8-pmu succeeded

I kind of wish all the printks in that function started with __func__.  Would
this be useful for you?  Send me any feedback you have and I can resend this as
a proper patch.

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9b745ba54de1..e8cc710ead76 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -579,6 +579,7 @@ static int call_driver_probe(struct device *dev, const struct device_driver *drv
 
 	switch (ret) {
 	case 0:
+		dev_dbg(dev, "probing %s succeeded\n", drv->name);
 		break;
 	case -EPROBE_DEFER:
 		/* Driver requested deferred probing */


