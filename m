Return-Path: <linux-kernel+bounces-258661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A4938B53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87FC28148C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB901684A8;
	Mon, 22 Jul 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jDtQI1wB"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303331662EF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637430; cv=none; b=MkyO/RntLKr12iefemHR89yaUJJ/zXGxXx7Vz4Y2NnUzs2y3uJEYOKPvpd1+of6f+XUf5sI0zPZB3uYOtEoow3w32nmauofNyz2T9mz5bg6h9eBTVnk6d7SIDv50FcnI58VeL3PDMDbNR9J62qQxFwnSQ0NFWOz4hKJX1Ey7+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637430; c=relaxed/simple;
	bh=46kRvm6OFMQTyQNXg8QchgNBwqh7VFWCZdHe/zf1KFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/Yv8mW4tmaDTybWrqG3e3nwv2Ij/591HdhcfXRVwQisakLXx70pXUKJvEpFJ4pz5g2STn/Ojm+KQUs8BGnvnrXPWkgvHaeAnNjLj6NqJy2Pij4Wec8ITdiKHTIcFBzNr8dYWbrOTRpG93biMSMi2e/zXjjsczdtSZgICvYkCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jDtQI1wB; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2789A3FE16
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721637426;
	bh=HpNZIN5xTexJ1U8TLubq24eNb4tcjfL0OXQsYeqcBOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=jDtQI1wB97AbzsSTgigiOhXUElbvcghnQaZ03KrRnxA1aSB+CnsEh5/31uS6apbH6
	 6XLiMZ37eJ5ScEOrA52IJC+IvmLzsjA/qCXcJm9P2omgndsoxfM4plC4Kynw5J2ZMy
	 kqgM8d28qqHoAnjz+S00fx4e7DtL5vo0m7JO6q/G0cWI4UyFwhMaFhKFxdHhNtMdv+
	 2gZggiP0KQo8iH5t5UNOE9OeSvRaPn6WPboGglnKeam0Xnq9WGg/5uXqrQUkLfnD50
	 njP9J7nvZ+BIf6h3ltOXIEzpj1B+G7FKhvEZ6ahmm0a19RR9ZMTYclqMkPslUo4xLg
	 IBX4IgR2scSBA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb90e56eaeso32981505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637424; x=1722242224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpNZIN5xTexJ1U8TLubq24eNb4tcjfL0OXQsYeqcBOg=;
        b=COaI4tldgklUolfxjASQJlw+HjbTRXUSVbzco028iwjQ03u7A+z+KE5vB+w4a4RVon
         JeD3rcjY75Xvj266SDSgMUmWT7bzsbX0HA4iQF0AcXvTWRiyX+8BYec4shjZS5qb34Nk
         WNklnF2TTvsjY2GVoOzjfUxBSEQaThZHqahiO+n2/OP58Eo/Bnrtefvit91Qrfc4XZyf
         2aIs5UJEL9DAn7+qCy79ezYxhZeUY6mttV8tTWEQY/aILhnOgivqYVWnnDizsEr/RTlh
         nczblYB2DTgV8zo+QVzSpmqpzd16XoNsCW4X5BqC/OuiDm9wX5ZdjljNEvK0AyccnlwV
         yeWg==
X-Forwarded-Encrypted: i=1; AJvYcCXRgFg2gDHufsPHN5OLZc6KylgrOwTfagN52oiSu1CfuMLGOkYmg6ojPCkpqQjCWSb/knC9wUB2YCJePKkRl2eekAieZOCPM5pbmN2r
X-Gm-Message-State: AOJu0YxzgYA87XewsyGK3qcosUM6mfy7Y9LOcSuFkBP51YfCNbw4A/cX
	kWLvoRG3FmciHAZhrU+26bIeDJG0GeAPvtvKjlMgDnOev4y8oHCnmDHZ0srHDmxR7OW6ecDC1Ns
	NMLzi0xc0u9ZkAR1xl9l6uawK0oKDGR9AKVecAn5QZfUZZ7QQ0MwkQkoW9SpRVc7WS2PySOm3Rk
	bpAq4LZruw6w==
X-Received: by 2002:a17:902:d492:b0:1fb:a1cb:cb31 with SMTP id d9443c01a7336-1fd7454f2eamr45863035ad.17.1721637424374;
        Mon, 22 Jul 2024 01:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvUsZL/+q6ITqJCqx0MJ/oH9erXZnWjJN6OZgEq136r3jlAkhnKbuP1XiFvE3Oa7UD9sMpKw==
X-Received: by 2002:a17:902:d492:b0:1fb:a1cb:cb31 with SMTP id d9443c01a7336-1fd7454f2eamr45862825ad.17.1721637423916;
        Mon, 22 Jul 2024 01:37:03 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31f625sm49271785ad.161.2024.07.22.01.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:37:03 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: acelan.kao@canonical.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: en-wei.wu@canonical.com,
	Kostadin Stoilov <kmstoilov@gmail.com>
Subject: [PATCH] platform/x86: intel-vbtn: Support for tablet mode on Dell Venue 11 Pro 7140
Date: Mon, 22 Jul 2024 16:36:58 +0800
Message-ID: <20240722083658.54518-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Dell Venue 7140 tablet with the keyboard/touchpad/battery dock, when
disconnecting the dock there is a kernel bug:

BUG: kernel NULL pointer dereference, address: 0000000000000018

And this causes the following things not to work:
1. Suspend to idle - the system simply hangs
2. Poweroff normally (the only way is forcing it via long press the power button)
3. USB ports: both the USB port on the tablet and also plugging in the keyboard again

The error message above (plus some crash dump) isn't so useful for debugging, but we
have noticed that there is a debug message shown before the crash dump:

intel-vbtn INT33D6:00: Registering Intel Virtual Switches input-dev after receiving
a switch event

The messages above is shown right after the dock is disconnected, and the message implies:

We failed to set the priv->has_switches to true in the probe function since the
Dell Venue 11 Pro 7140 is not shown in the dmi_switches_allow_list, and this causes a problem
that no input_register_device() on the switch device is called. Afterward, When a user
disconnects the dock, intel-vbtn receives the ACPI event and finally find that there is a
switch out there. So intel-vbtn starts to register the switch device, which may be a dangerous
behavior since there might be some device-related objects/structs that has been freed (due to
the disconnection of the dock).

To solve this problem from the root cause, simply add the Dell Venue 11 pro 7140 to the
dmi_switches_allow_list.
(The Dell Venue 11 Pro 7140 is a 2-in-1 model that has chassis-type "Portable".)

BugLink: https://bugs.launchpad.net/bugs/2073001

Fixes: 8169bd3e6e19 ("platform/x86: intel-vbtn: Switch to an allow-list
for SW_TABLET_MODE reporting")
Reported-by: Kostadin Stoilov <kmstoilov@gmail.com>
Tested-by: Kostadin Stoilov <kmstoilov@gmail.com>
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/platform/x86/intel/vbtn.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index 9b7ce03ba085..46d07d3cd34b 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -235,6 +235,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7140"),
+		},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-- 
2.43.0


