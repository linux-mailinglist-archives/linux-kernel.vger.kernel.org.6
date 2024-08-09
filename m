Return-Path: <linux-kernel+bounces-280460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65A94CAE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4674D1C220A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C6916D4DA;
	Fri,  9 Aug 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W77Cw5OG"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840432905;
	Fri,  9 Aug 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186982; cv=none; b=g4lATok42Dj35tAFhFkgT3Ld19zlmpFa7Fgu2MIRY8hF2xgEGomx3Gd/LQX+Efct3ZVBBQhgFG7N3XK7l7R9xqhCjq11EY0mkpSIW7aM6QDHeMrP74ot1L++GcHHVUC/bktwM0KrDyzPayXkGHGptUPs3wtOtRTG/k7+EpU2Uvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186982; c=relaxed/simple;
	bh=k4x5T0MieqJ09ZNfbjNF9VKFJcCuwoT1Sorug5O3vUE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Y+DPbYHQs/t9eNcG88vWsNS2PErX3Z+W8RuRxvd1tiaGb+ws4HQRUc5HdD6UYei6UqJIXBzoJBHP1GzSrcNA7VUfM2BuiDsBKKYahtYM0ujgIxZxuFLU3IFeNkFn7OtZD/T7raWimKdprToq1cc3Q3+sDxHM5vBC1gwX+bWtK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W77Cw5OG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb55418470so1510926a91.1;
        Fri, 09 Aug 2024 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723186981; x=1723791781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0BfdVbYhSOGX9L5+SEe9oTBYxIcSn2KcXGJDrTLXXyg=;
        b=W77Cw5OGNVbMNEtsPBxBltXqU7VG7MMaiM9dEKuQ4zDTyuISyDnbc2vQITHB4CEpRR
         NHo8uyJWE9y/o/vPB4zjDSIoT4dlz/bg3FYdVFABs+98f/zcFuMIcbZ7lKD6YLzZkTtC
         PqfhYG6YvWke0UG3IjwLfksiw8/q1+jstu+68IZfeAr9+oEkvtFdm3lCQY3knCvL1vPQ
         jo5+d39Rd/yvnqeluI3BPpa/SMYUEAk+7gCtUdAMrKdDQyZYWC/QM8e6kirD4r9Fv9Pd
         YVCHrhtnZjZU/YMxiSEff9nTOTMl+xlj4ObjqzFxUG/o89Qwx7XUAcKOi5CIqcMXP6lm
         wIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723186981; x=1723791781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BfdVbYhSOGX9L5+SEe9oTBYxIcSn2KcXGJDrTLXXyg=;
        b=p6nHuvygxrNsaluzEEDhJLEQxioxXKTZ2Hg3gyVWlQfnlmMIER7PpVjB176Fu1qVPg
         39PVfUQTRYWkibiy8Iz0dBIUDhSITaQngdaCwbsZbwhz0DKJrhU3fqJTKsr2nLRMN7ps
         zl+OSfxilI529OfFjG0Y3dmK8lOgpLihIUbYF0B9HdZaXBKrFdeWpU4fZ0yGFJccsd5/
         9p4vf3q6lUGLeyQedCFLq776HdUnbV0a30uhOdju8oOoa5Ji3PSmFW09N0b+A0slO+Mx
         7gZALzBKnUv9RUdLDkzmdgsOPs0zaCzNS0GbxXZk57aIbE4Bc2SW6lPFpYdxZCPBxiqu
         GDVg==
X-Forwarded-Encrypted: i=1; AJvYcCXN/OaXF5IQOoxEe7zCf90JIK1AqxOzihPEkVbm1PpND0s5rYYxL3c6mxWgMaUIOutX3FbEp7Ok4pel@vger.kernel.org, AJvYcCXaMwaurZXsv13aKh75CF3Z4l/AM+lF3vmm0WrF0FeIgjK0uEz0ShyptwyQ6zJEPy8OVtSskAaoepAlXedR@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbLH2myJPOKEIrP4st5lisXpdnHn36vg9ZiqVqnoPeRFVhBxE
	emAI3MeEO2x91aDe22F+h3MgwyNcX9Oh+dPHd/S8H9ePyO76gD4t
X-Google-Smtp-Source: AGHT+IGmu1//tWp7p2kQUU5NMHo6xEX7ajfRCrdddMTpWCuQHzziAjeVwc1F4ZUZWh9IwhcZE02ZxA==
X-Received: by 2002:a17:90b:4b0d:b0:2c9:6f03:6fd6 with SMTP id 98e67ed59e1d1-2d1e7fecba4mr579582a91.17.1723186980525;
        Fri, 09 Aug 2024 00:03:00 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c7ad59sm2248233a91.13.2024.08.09.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:03:00 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: trivial-devices: add isil,isl69260
Date: Fri,  9 Aug 2024 15:00:54 +0800
Message-Id: <20240809070056.3588694-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the "isl,isl69260" compatible, which is already used in the
DTS files but was not previously documented in the bindings.
The ISL69260 is a digital dual output multiphase controller
that supports Intel VR13, VR13.HC, and VR14 specifications.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---

Change log:

v1 -> v2:
 - Fixed the binding format.

v1:
 - Created the isl69260 binding.

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7913ca9b6b54..6ec8b4cc9e56 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -164,6 +164,8 @@ properties:
           - isil,isl29030
             # Intersil ISL68137 Digital Output Configurable PWM Controller
           - isil,isl68137
+            # Intersil ISL69260 PMBus Voltage Regulator
+          - isil,isl69260
             # Intersil ISL69269 PMBus Voltage Regulator
           - isil,isl69269
             # Intersil ISL76682 Ambient Light Sensor
-- 
2.25.1


