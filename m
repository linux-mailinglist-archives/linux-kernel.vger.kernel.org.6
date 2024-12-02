Return-Path: <linux-kernel+bounces-427734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017319E057D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FD816DE85
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B120E02A;
	Mon,  2 Dec 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="rOVlOKqN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A220DD6C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149951; cv=none; b=iiCZC6iwYbztKcpc6pf8sKcnSvCS+HJqQzwROOhBwDUfLOz8GqkqR1HSN6O5JxN9//VXAuaXALPQjy3FRIEk6JaxvT0ipoltBMRnh3h91OoQx4pXXa3WcCQOEmU4P4IU9m0mFa2NdihpIhl+CPTj2vl6vL0wqjgP4nq0krPXpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149951; c=relaxed/simple;
	bh=VpIZ3WAj8mBewaf40+mFXB+hswqRhINEMgjB6sIu+Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCoGTwyMfMIbZa+oZUcl7CRE+XCsNMytmGAN7Nwq+JG8QDoKiVLwnGUkf3KWUMn13pR0nSSQHGxWj0Qt4/vgWSGK/PLPvk4ntdbL+8mFxksVzEI4+2J5j3gMS1BoBkZVQg2xMP22ndnJEVPs2EXOJkqpNCuVH8wio+xjvy1SSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=rOVlOKqN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a736518eso54702045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733149948; x=1733754748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoO0W1lzMLcOdS6iQBTqdnnGTSDtRuJivefn0QP3emg=;
        b=rOVlOKqNRaLJKPfY3LeLf/dLnSSeXjaRxsQZ3ndhAbTn+WPM5mMOfZK5mHYLoTAoTb
         rIPIjMCgH/IsLoxPZ/VVtYOPR7kS8tBpQ6xhvkTOPHFalKq4exvumPcgA+1I/JpLUXkV
         30hEk+3a9ctVtM49gCRKGKVcYtgoCM2JSzNkUi3RXX7oQDjEB3GkAwz3xOs1B+FA/WrI
         8JkweOd3LotNUxRnQfTBL6TFRFUK2hLA4Hd/5E8xw9K0iahBAVWnSo4Dto8vUaKF3hdb
         dNw/xE1mVKyGuD1KYR5pnQgnUJIRZgsRECau15nVVwLSjPmG06W7bswQjth7a6Fp3Cou
         WZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149948; x=1733754748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoO0W1lzMLcOdS6iQBTqdnnGTSDtRuJivefn0QP3emg=;
        b=UBa6DPwTKxMU0Ze8gfqtFalzy1xe/dZYyN1CVACoO2GESJ18egR5Tlf4T/2wT+7pHU
         +a17KMZ6phv9/DQnFHRdBL6b/GXlGFsLwqKjzSknKQ+z26h6tVHYdEbxtMaXiwiq21p7
         6gYz1iCkFwL7RAEaA0TkwgYeEdOIICG6pqJPylCyEslmacDUMLQJ2hoUxWOJ8DB7vZla
         EJdiLh1Do1wDbh5nO6GIljuHymRKsIuXMpWIa4PBUJ5/Ef5ocxAT9aL6s2yQu2SEUQha
         buEpyhpT/3OsyevZpakHxTCSAPT/ggVFqeNTjm+XxOSFoYlF2L5I36QFZsa1TL8eu0iW
         1OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwAM5zNMR1yR5IfsfMmrUs0x6kJo9nlv6QHYjFbjnn2lu78hBsxrZ8QcuB5uvcInTmBU06CvvERdfjRnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPoLsfQW130knWmzBpMRDkpUo03wO8D1eN6jVMtJoXnXkhQfj
	DjlA3QjlBIVm7KR8muSl6qBzGA2T/Ha1TwyS64TtAKoGd0MQHC0jQUJrAwYz5wM=
X-Gm-Gg: ASbGncs8Quorqj7ecOgsYzHnVCgnVpeCh+4ShnW4KhEfrJ+zfItWWauQjzcC1rtETNL
	bPT0u03cKoNv9cDgcUUQqFkBLkCPv5d/gMmzwlIPv0/xEPzrJrIaZc/RslL53wfIHhrfrQ3UddU
	waKrwWsBljyNDoNLpzta48/7EySCaQiu+NiH3b90+1gSdHxxZda01LHzxAyW+5gmJYfIh260ox8
	1GNSr4A6kPD78HNUjui2WwaV/nA2hR44/wGesR3sw==
X-Google-Smtp-Source: AGHT+IE0KkUbbY+W4pZJfpChMoM/Bgrd/vrm1xb0nOBeoKJCjAgqt5slzwSLTSLUpuVmedDgVR+CWQ==
X-Received: by 2002:a05:600c:3549:b0:434:a923:9321 with SMTP id 5b1f17b1804b1-434a9dbb626mr248858685e9.5.1733149941245;
        Mon, 02 Dec 2024 06:32:21 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm188429555e9.9.2024.12.02.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:32:20 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 02 Dec 2024 14:31:59 +0000
Subject: [PATCH 6/7] arm: dts: broadcom: Add interrupt-controller flag for
 intc on BCM2711
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dt-bcm2712-fixes-v1-6-fac67cc2f98a@raspberrypi.com>
References: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
In-Reply-To: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

BCM2711 DT was producing dtbinding validation errors of

interrupt-controller@40000000: 'interrupt-controller' is a required
property
interrupt-controller@40000000: '#interrupt-cells' is a required property

Fix them by adding the required flags.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index e4e42af21ef3..313b1046d74f 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -51,6 +51,8 @@ soc {
 		local_intc: interrupt-controller@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
 			reg = <0x40000000 0x100>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		gicv2: interrupt-controller@40041000 {

-- 
2.34.1


