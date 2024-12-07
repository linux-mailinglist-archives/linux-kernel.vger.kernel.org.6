Return-Path: <linux-kernel+bounces-435827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03C9E7DB3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F9F1886E80
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AAB9460;
	Sat,  7 Dec 2024 01:21:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F584C79
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534496; cv=none; b=H9SsLbwvzOjhXofjRPHeEIM1qwZWBjG3ODWUhRp4oFTIL08beRj/yraOj+FnuKj/Appd7HkcRKMScU3lCUGdN0JBzonjbYrABMw94EjpH70f8OLqikWYK7TahOShGJHyzRbAxfQLMrEOW8NE1S1q6W0wmSzS8qZDNczQVuGZS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534496; c=relaxed/simple;
	bh=UZnzwChy5gMF1uihxG6r1yF51WkftqCzWMG7Zr0FIV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbcdtqs2AIFNihhlTy7SR1YjjEh/YJwwrBX+cZmV6mUc5lJsDyjy3pK874bSBmpBmHA7TPD5MmbnHDSYwni6Kp/OknHLDrRsiEm2cWzfic9aL9QP8MtgiO40hc+4ftkSfgWnxUsVCQUP7964vKuMNGUxAPaILXJ9etFtiJ/UqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8502711FB;
	Fri,  6 Dec 2024 17:22:00 -0800 (PST)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439923F5A1;
	Fri,  6 Dec 2024 17:21:32 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: suzuki.poulose@arm.com,
	gshan@redhat.com,
	steven.price@arm.com,
	sami.mujawar@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 0/1] arm64: CCA TSM module autoloading
Date: Fri,  6 Dec 2024 19:21:27 -0600
Message-ID: <20241207012128.247522-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide module tables and a platform device so that the
CCA TSM module will autoload when needed.

v2->v3:
	Fix __maybe_used placement, it does fix CLANG builds now.
	Add reviewed-by tag, Thanks Gavin!
	Ugly commit message cleanup.
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


