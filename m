Return-Path: <linux-kernel+bounces-557911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3DA5DF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C1817CCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC74256C76;
	Wed, 12 Mar 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="GCknDqXQ"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04E254842
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790512; cv=none; b=shvIdpVdKEjIk53HLUcwYJUfRGcDsbxYAXmDYRowvIa51ZUebpsIOCe/dDA2IU2Cdw01A+ZTorSB4lPweKUovRVx1k5Ynrsei6foRKsXcrQmuEygSOWa+H54vFnrVoikX4P9KfpL3HuM09kBuh7bcDo/xK1VJ09YMgQ/JcXF26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790512; c=relaxed/simple;
	bh=e+xwvOdPFWgt5Z7loNHF37gpAdHrHZ+OzlPVYDr/koM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvufdGpAkFA28bWTIt/y7KUr3hQEmfiumyf1Hcc61PdSapCWxvpdvhqrTt5Icg6RIVKD/ogpIKrw2lkjiu5J9gHdadhRQ8dc8P9+Pv0JCiQVnBqP2WVJwxIN26+iDUG0wvTZOtQOoAouKVEl+o+aas+zRFaS3gNYg6Sc7Z8Y46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=GCknDqXQ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from cap.home.8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 37F9E4550C;
	Wed, 12 Mar 2025 15:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741790503;
	bh=e+xwvOdPFWgt5Z7loNHF37gpAdHrHZ+OzlPVYDr/koM=;
	h=From:To:Cc:Subject:Date:From;
	b=GCknDqXQXQTV2B3UwefczHhEciqSAKRQECaM066hx6Kqw63EaAtWlN83EmhuvVVV6
	 4oopjJMufWR+uwerkzp4qy0XU7RcHhHTkZLb3RhkcIC6Vi6Dg8Mihjy9V/Om1DDBbN
	 zEu/3wcKMZ7C+LjfBadwEmIzRgOZwyeEO+m9/AL0Er08xje4A3MJiziCAnW9rX0yC1
	 XGlZQ6cBmiHNROf2cF1omOl3cad8thCUTV99MgQyIPd0JQNxn85uP9gafyxi9Z3lgG
	 4vo/29nf6Tos+/9CxuPQl6uBHJ4z1QyeP0A8DepZcSlJ9yhC5Ob8cModGQEiOUbu6L
	 AERYPuMo6jcMw==
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Cc: hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Larry.Dewey@amd.com,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	kirill.shutemov@linux.intel.com,
	alexey.gladkov@intel.com,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 0/2 v2] Move SEV sysfs information and expose MSR_SEV_STATUS
Date: Wed, 12 Mar 2025 15:41:05 +0100
Message-ID: <20250312144107.108451-1-joro@8bytes.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Hi,

these changes move the SEV sysfs directory to /sys/hypervisor/ as
discussed on the mailing-list[1] and add an attribute to expose the
raw value of the SEV_STATUS MSR.

For compatibility reasons a symlink is created at the old location of
the directory to link the new location.

Regards,

	Joerg

[1] https://lore.kernel.org/lkml/20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local/

Joerg Roedel (2):
  x86/coco/sev: Move SEV SYSFS group to /sys/hypervisor/
  x86/sev: Make SEV_STATUS available via SYSFS

 .../ABI/testing/sysfs-devices-system-cpu      | 11 ++-----
 Documentation/ABI/testing/sysfs-hypervisor    | 15 ++++++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/coco/sev/core.c                      | 30 +++++++++++++++----
 4 files changed, 42 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor

-- 
2.48.1


