Return-Path: <linux-kernel+bounces-552836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5AA57F3F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF30E7A0717
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D7A1EB5DF;
	Sat,  8 Mar 2025 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUsWOlo3"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244A14D2BB;
	Sat,  8 Mar 2025 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471541; cv=none; b=XJH29Un2EvoN2k1Xta6vnNLq/bytEygY2dz2Byz1XnOHK3JscKdX7i4jw2S5sSBzyEBfKh65mbwfr1Bk+CI6fdHOPJ9K9xS3p0KCg00X7zzI6fC0f+E1m8kn33NJnrYIfJ7B2Zq5/LVzqRFMsq5O/dvG66H+22z92nEUvSOSvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471541; c=relaxed/simple;
	bh=KPs9tYws9SF733Muci8tPEy/KEO2XeHQReNvq9Xwg1s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tpHU72YMDT+315KqNCws/7/t8Cgo+FwF9VqmoY5YUhstjrkTTk0dXkTQ1kR35q/W/brx9UfmVBV94zVrJ81oHJM3yjtiQMFRoiJgXq7xKRBcO3+SB+5OptvIyRMVbokahCHkTkNo012NxRfB7palVDA411hysvwNFMW+LeYQR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUsWOlo3; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so2585385276.3;
        Sat, 08 Mar 2025 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741471538; x=1742076338; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4EJp1oVI2HCDz+CTTq8TQX70bV462l8u4W3ccmhZ2E=;
        b=JUsWOlo3Z5MtaSltZjUA/4Sf0KMtRbt9GolisodATq7GTEvmwZ0lVVo0B/reh1xytQ
         5yJQKW6ODmzI/Vsce1N8IiyCw6xxfbYNtbZFrytqKRB35Mxz7lZJDPVcnoci/opXz1xb
         pmTXL+A9ESguRNeb3t6O83bBFaytg4yBH4sMif+7SlasACQzKxe8PDVe1MiXV9FiNJic
         CG7FJ7JyI1V/EcLMWrO9BIW79H65XI43rNt2Cl9FpZK6549c+hm52sSPAD28WyYdFcZ1
         v74YdvkJo8OFSqyTUB3r4d8Kvw0Jnkt2DMCa+sBfGfKdStOThKibzZgVf1HLfiSdVCCe
         bbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741471538; x=1742076338;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4EJp1oVI2HCDz+CTTq8TQX70bV462l8u4W3ccmhZ2E=;
        b=PmaSOXNHKBFVz8xm+RXLevT8gblk87zhcq5qJOn/g1u/LXNRYqqAM6c6lpRBeWtTNW
         nPFAKkBO9VnLCiDlMdUwoq/PdHcsrLgbqeUhRBfYVRI6wUryGiIdOIuhagE4HybZEUdm
         Dwg0LK9Zz9qQnYur5WEtWoFPjQU3aO14vpttLhtGCQyq5e9nEivk0zyuem3ZON9qb5dd
         RWwpXggBXDd/WgRgYkAokCBfe68csrtPHnTVgYKvTSZx2Xo6rQApv9CgQBzHZdNkxL4g
         AJ6l2CKoa6UtMQ4VH3+4RUGBHlLgUZVuPcAHHpvx9475jTmFmmgMqUkw5S9VTXSOuv12
         +WFA==
X-Forwarded-Encrypted: i=1; AJvYcCU7cmdhpmGvX7XQ1PkxFFnwX/am6qc3T/DH8Mq3ram029rcUO/jIqZ8LvsWjhguhbiTBMdNDPKxknFkeog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYE2cNtj6CQb7iqdGKSIvfPGrRJ5KrrTBxbZB/QXQQdFf0KZX
	SKcqzN9ExSnI3BSPA8idPaRWdIbIZyXg5IpdSNeeChjMjBjnYUlV
X-Gm-Gg: ASbGncsMwb0FHJqp81DySZzxrbn9vo2Yn6UBUCz2fv16mvz6UsQkcGVNnv0lfx7tPAv
	+RlClqBriPLbtDPnOEZOetlGx/OdMOK/kVIKU5hzgx6zE5hLBUWEGycaCxBZ3/KlVFQTkw2pw+c
	xz2bxhCUUTP//mZmsA3h97U0wzFwpuZ8+LvYUdnYJLfz58VHTmIjYk84XlRYFucvm6SFVdTAwDw
	z7Iv3z6//wz2Y1dKkePkIARA3DXLNlCTie36sbzqUz4E9jskTAZy2KXMCowie+bm1UfDolfm6Cu
	WD4J+2+wFZsr/40MLI93OpKKuBNR78dm5RR8XBtlnBzQ9A==
X-Google-Smtp-Source: AGHT+IEXoZl1HtHrAK/wRRAdra4hl24cD3Se5LnD4oAOttl98w2IItqGdHgkN0gn9tlbpga1Cv5cUQ==
X-Received: by 2002:a05:6902:e0e:b0:e60:915b:19e with SMTP id 3f1490d57ef6-e635c13ac56mr11214193276.15.1741471538493;
        Sat, 08 Mar 2025 14:05:38 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b8e8ef6sm1524824276.36.2025.03.08.14.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 14:05:37 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH RFC 0/2] platform/x86: alienware-wmi-wmax: Extend support
 to many devices
Date: Sat, 08 Mar 2025 17:05:27 -0500
Message-Id: <20250308-awcc-uid-v1-0-6360892d8b95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACe/zGcC/z3OzQ6CMAzA8VdZenZJGRsDriY+gFfDgW2d7AAon
 yaEd3cq8fhvm1+6wUhDoBFKtsFASxhD38VITgxsU3d34sHFBoFCYYo5r1dr+Rwcz8hiZoxQWji
 I54+BfHh9qRtcL2eofsOBnnNkp2PzV0t2mIo3a8u9Nq5IChRG6XKRH9HUI3Hbt22YSkZKU21Ie
 INSFgop8955wiTHNI8tUxcfMhqqfX8DXfEmw9YAAAA=
X-Change-ID: 20250308-awcc-uid-6ec06bb2572d
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Hi all,

After a few months of searching for acpidumps of elegible laptops, I
came to the conclusion that if I continue this way, many devices will
never get support for this interface. This is due to very few users
uploading acpidumps of their machines or contacting me of that matter.

With this patchset, hopefully all (or almost all) elegible devices will
get support.

I'm submitting this as an RFC because I'm extending the WMI API and also
extending support to many unknown laptops models.

This depends on

	platform/x86: alienware-wmi-wmax: HWMON support + DebugFS + Improvements 

series, because I made a few generalizations there that work even for
Alienware desktops.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (2):
      platform/x86: wmi: Add wmidev_get_acpi_device_uid()
      platform/x86: alienware-wmi-wmax: Check for AWCC support using _UID

 drivers/platform/x86/dell/alienware-wmi-wmax.c |  3 +++
 drivers/platform/x86/wmi.c                     | 12 +++++++++---
 include/linux/wmi.h                            |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)
---
base-commit: e57eabe2fb044950e6ffdfe01803895043dec0b7
change-id: 20250308-awcc-uid-6ec06bb2572d
prerequisite-change-id: 20250305-hwm-f7bd91902b57:v4
prerequisite-patch-id: 06ff44ce0c6f9bce77eb61a08f358240f1485914
prerequisite-patch-id: d270ae9f1f681a6b6b9685cc13802e8baba0105f
prerequisite-patch-id: 5f744ce03af74a23560118b761ac6529a7c9b172
prerequisite-patch-id: 22c6c5256aee2c17bcd710ec1493b1abccd414cf
prerequisite-patch-id: 75191e2094746de3c12fdd885885d18b2239af89
prerequisite-patch-id: 9f26a3b64824b4f175bbea47c8c9a59fd67f3316
prerequisite-patch-id: 4ff2263e236230e1f96703265d135f0b90390ebd
prerequisite-patch-id: b8844283f8bb46c05ba2e9d7b901bdedfd941731
prerequisite-patch-id: c5122bcce8e7330cdbb18c5d43e321ce69116272
prerequisite-patch-id: ed78dcf947e19652f175d124ade13c08eb3950cc
prerequisite-patch-id: d46a626481e1c49bdd91f6add36f4d6b89edde3e
prerequisite-patch-id: e68a77ec73be34006d5dd754592285e44ffc7f68

Best regards,
-- 
 ~ Kurt


