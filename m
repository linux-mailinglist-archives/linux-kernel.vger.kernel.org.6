Return-Path: <linux-kernel+bounces-183371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5218C9822
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 05:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366A8B212D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B212C12E40;
	Mon, 20 May 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="n2GotalE"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE8C8DE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716174219; cv=none; b=n5wDVClK7rTc45Tu/q4QSVHfZUInrkd2OuxEz3mlc4aobPBQc6/skVxyuzljabZM/t46QrpGmvxl1U4z1OwwuBzcbMfTh/9rxPjqM6JJqKEMZSd0S5iHxtwXMYPR2XnyWR2T0u2T8qNV1bTHzBDrlVLojtrYwtG0z+9E3bufRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716174219; c=relaxed/simple;
	bh=aAI2zLN5nL5fNuEbKbiHyV0nb3poKIMbOc0yZeWz20o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAlfUITrnpJVWE/4pkVabMjL9YBo6D6+H9qOUH8sF0gw2ISuvMY843wD2Ea0c3MvcrjK8j1cdmfW/BP8CgvEbwygyLNWCYSSxz2FOj07o4bnw4ouozj3SBC+o3hx09x+i5AtU/25A6K2e8wlZzXGd4t8yhykOC+ZixSVVI5ZxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=n2GotalE; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AF44C2C04C9;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716174206;
	bh=qBEkpY66taeBlnWk2DhxpsiVQOBe9f1iaS58CXZ2tKE=;
	h=From:To:Cc:Subject:Date:From;
	b=n2GotalEtVcCjoJ7UnpDtNFTG3tyKCFhnYKoeLlaryYcbzXSTE82wTjP9q1K2MqOv
	 N3c+WPrPD/A6N9mkH2eQs4HC+UpQ3fOI3FT916q8zrs7I52yhsvua+1kLt5AJ9xaSk
	 meF1H98I0NKRcuK2d/lE+GKvSx/jZuunKL4oac+evBpWaTT+59ilS0rZ1ROy3ZpbqP
	 df3x2687cnfO5kt39MigVK2KVeDbELsEPkaetbbRTPQY3961HJTpCRFdw9vigl/koc
	 vbZmeoUuhnh2f99jQuAjE9t4qePQ+J6Ev/iq+CzNSTRJcthr03L/FgMMDuqb9hX7JP
	 48HInqsi8BpEQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B664abd7e0000>; Mon, 20 May 2024 15:03:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 5DCE013ED95;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 55190280C1C; Mon, 20 May 2024 15:03:26 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/3] hwmon: (adt7475) duty cycle configuration
Date: Mon, 20 May 2024 15:03:18 +1200
Message-ID: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=664abd7e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=1vY5SClPdTbzMX9iZtUA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

I have a system that has very over spec'd fans so the amount of noise whe=
n they
run at 100% duty cycle is considerable. We have userspace monitoring tool=
s that
will configure appropriate fan control parameters but there is a bit of a=
 delay
between the kernel loading the driver and the userland tools catching up =
to
configure the fan control. This series adds device properties that allow =
the
PWM duty cycle to be specified via device properties so the PWM duty cycl=
e can
be reduced as soon as possible.

This series attempts to setup the adt7475 as a pwm provider so that we ca=
n
specify these properties. I'm reasonably happy with the devicetree suppor=
t but
I'm struggling to figure out how to make this work for ACPI (which is act=
ually
the platform I need this on). I figure the ASL is something like

    Device (ADT0) {
        Name (_HID, "PRP0001")
        Name (_CRS, ResourceTemplate () {
            I2cSerialBusV2 (0x2e, ControllerInitiated,
                            100000, AddressingMode7Bit,
                            "^^CH00", 0x00,
                            ResourceConsumer, , Exclusive, )
        })
        Name (_DSD, Package () {
            ToUUID (UUID_DEVICE_PROPERTIES),
            Package () {
                Package () { "compatible", "adi,adt7476" },
            },
            ToUUID (UUID_HIERARCHICAL_DATA_EXTENSION),
            Package () {
                Package () { "fan-0", "FAN0" },
            }
        })
        Name (FAN0, Package () {
            ToUUID (UUID_DEVICE_PROPERTIES),
    	    Package () { 0, 22500, PWM_POLARITY_INVERTED, 255 },
        })
    }

But I've got no idea how to parse that out keeping as much code in common=
 with
the devicetree version.

I'm sending this series out now to get some feedback ton the DT code and
hopefully someone will give me some suggestions for dealing with the ACPI=
 case.

Chris Packham (3):
  dt-bindings: hwmon: Add adt7475 fan/pwm properties
  dt-bindings: hwmon: adt7475: Deprecate adi,pwm-active-state
  hwmon: (adt7475) Add support for configuring initial PWM state

 .../devicetree/bindings/hwmon/adt7475.yaml    | 27 +++++++-
 drivers/hwmon/adt7475.c                       | 63 +++++++++++++++++++
 2 files changed, 88 insertions(+), 2 deletions(-)

--=20
2.45.1


