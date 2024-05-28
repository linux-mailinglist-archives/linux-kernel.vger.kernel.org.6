Return-Path: <linux-kernel+bounces-193214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF988D286F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AC7286B03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33C13F45B;
	Tue, 28 May 2024 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="iD2NbI+P"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D713EFEE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937008; cv=none; b=Bg3nETsMOo2otccgiQyvT65Xgzu6G0VAaKk7mcgqHGimeUtwYRNIeF7XlKFWg4v98CxsDBqdU/3GYR0rc8q/AAEW8xKUOuz1fJFTZvkZnZyUDCgytRmFx/x3C/UVmS3eD2m5SvQ/ZIQNYUo3xEmAIhz6p1sWrHKLN63sFezXSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937008; c=relaxed/simple;
	bh=7229M79Y66nlOhdazLYoW34jJ11Id2JncfgjC23Qf/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJ7jY5ziMk4Eai5PmHMhwp8gNEWEtM8blyN+ckIRVToJ1Be732+exvQ8y54k0n64SW/FERmRCWnJ77ZVuNhu/WoGmoqCc7AbSUVcYicPH2f4MNrOZPMjmOVdaUQG2uN2dQOK2c4oea7GpoMi2DQu9VkhuVESVrj3tSQGom9a1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=iD2NbI+P; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E81CB2C0345;
	Wed, 29 May 2024 10:56:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716937002;
	bh=yaNex6nf4R3aaiKyz05XcDPBgeuOxBytmLnSvAxSUpc=;
	h=From:To:Cc:Subject:Date:From;
	b=iD2NbI+Pj8Snh0ASZFOJ0tkAFfNHGp9d6UoeVkiK+bM3enq2HQEo6a5U+5/idMwF7
	 V5AK4IpDTG3I1KsepztFdIXKaeRUTcPawEktf0OVPPvO3k8zty/jjfPLQ1j+1AI6Jg
	 oZnkM9JA9+7lq/ruHG5iCjxrl0dbizBj6b6cNbe1+VIdG7vyWZPQRy838IPfvi8TTc
	 6yQhbOoi38fnRS3UEf4xuTAcVPJfBH++3I1iLkUoMt/+9P0RTdLDsa+2g8uMe0qZ57
	 B17hE/w/3Wkjw93nOWczimltUkfUHZ71QQ1u9HkgCjhIaGj+lJ0kdVRqBtac1zs1oi
	 pNumpx2XrYObQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6656612a0000>; Wed, 29 May 2024 10:56:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id A7AC113EC7E;
	Wed, 29 May 2024 10:56:42 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id A036A280A37; Wed, 29 May 2024 10:56:42 +1200 (NZST)
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
Subject: [PATCH v4 0/3] hwmon: (adt7475) duty cycle configuration
Date: Wed, 29 May 2024 10:56:35 +1200
Message-ID: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6656612a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=1vY5SClPdTbzMX9iZtUA:9 a=3ZKOabzyN94A:10
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
specify these properties. The devicetree support was reasonably straight
forward (example usage is in the binding patch). I struggled to get the A=
CPI
version working well and in the end the code had to distinguish between t=
he
of_node and other case. The ASL I've ended up with is

    Device (ADT0)
    {
        Name (_HID, "PRP0001")
        Name (_CRS, ResourceTemplate () {
            I2cSerialBusV2 (0x2E, ControllerInitiated,
                            100000, AddressingMode7Bit,
                            "^^CH00", 0x00,
                            ResourceConsumer, , Exclusive, )
        })
        Name (_DSD, Package () {
            ToUUID (UUID_DEVICE_PROPERTIES),
            Package () {
                Package () { "compatible", "adi,adt7476" },
                Package () { "#pwm-cells", 4 },
            },
        })
        Device (FAN0)
        {
            Name (_ADR, 0)
            Name (_DSD, Package () {
                ToUUID (UUID_DEVICE_PROPERTIES),
                Package () {
                    Package () { "pwms", Package () { 0, 22500, 1, 50 } }=
,
                }
            })
        }
        Device (FAN1)
        {
            Name (_ADR, 0)
            Name (_DSD, Package () {
                ToUUID (UUID_DEVICE_PROPERTIES),
                Package () {
                    Package () { "pwms", Package () { 2, 22500, 1, 50 } }=
,
                }
            })
        }
    }

If had to introduce a code path that parses that because try as I might I=
 could
not convince fwnode_property_get_reference_args() to fetch the informatio=
n out
of the ACPI data. If I've missed something obvious please let me know.

Chris Packham (3):
  dt-bindings: hwmon: Add adt7475 fan/pwm properties
  dt-bindings: hwmon: adt7475: Deprecate adi,pwm-active-state
  hwmon: (adt7475) Add support for configuring initial PWM state

 .../devicetree/bindings/hwmon/adt7475.yaml    |  27 ++++-
 drivers/hwmon/adt7475.c                       | 112 ++++++++++++++++++
 2 files changed, 137 insertions(+), 2 deletions(-)

--=20
2.45.1


