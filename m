Return-Path: <linux-kernel+bounces-428510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF8B9E0F73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB95282F56
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486A817;
	Tue,  3 Dec 2024 00:02:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FE3D66
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184138; cv=none; b=u4j4eZpdNhGweAojezQaKzBfeSS1CGKtCv//CASunQ+/vcJGyxl32Ef1s2D6chFCMy3lL9bHTPhMiK0g5/wY92YFYPYzvQZ6oLtewbic9lMF76YXOF/2UDF23TTftvlX71kehF9SpwDpRqUa2jDomwchjhqvc70zCiJuAF7SUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184138; c=relaxed/simple;
	bh=WXgB2ALyMODWhqlf6lVCULHJf4GmOAN9O43IYelZGBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cP9f6tuSo+5+aFjuzzu9FuLvHZr7CcyZoGLIAL0MkJrPoAJb9LM4ULteoujnaGKKRI0VoGF9Yd+U/71mkjt2Y0OsNL9JU4UbVHJ8UeeY7SCtcLu75QTRh4KgNa5QuXTs3Wvc85exDUP7aOaaB/B4Egx7OItvnyJw+V+DuXRtEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6278EFEC;
	Mon,  2 Dec 2024 16:02:39 -0800 (PST)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAA903F71E;
	Mon,  2 Dec 2024 16:02:10 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: gshan@redhat.com,
	steven.price@arm.com,
	sami.mujawar@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 0/1] arm64: CCA TSM module autoloading
Date: Mon,  2 Dec 2024 18:01:55 -0600
Message-ID: <20241203000156.72451-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TSM module provides both guest identification as well as
attestation when a guest is run in CCA mode. Lets assure by creating a
dummy platform device that the module is automatically loaded during
boot.  The TSM module will be loaded by udev daemon after it receives
the device addition event. Once it is in place it can be used earlier
in the boot process to say decrypt a LUKS rootfs.

v1->v2:
	Various comment updates/variable renames
	Add missing __maybe_unused to the platform_device_id

Jeremy Linton (1):
  arm64: rsi: Add automatic arm-cca-guest module loading

 arch/arm64/include/asm/rsi.h                    |  2 ++
 arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  8 ++++++++
 3 files changed, 25 insertions(+)

-- 
2.46.0


