Return-Path: <linux-kernel+bounces-429657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E109E1F30
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B90B164E12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E21F4707;
	Tue,  3 Dec 2024 14:31:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F33BB24
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236275; cv=none; b=cLc8dJaNTWW6eWcWiQP7LsEu1ImEv+DG1x7kILbEcZ+9lm4OjSgSsMS8Xm9ZlgLZJiczEIt5ZUObonwyGr6knhQb3PFJdVJvR5cHCZiDwPFOcOFEV2XMjwcSNe94o7jHrZMEDKT9byDdMxo0t3/zOPuHQbrdN8V7H99Fv5QEYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236275; c=relaxed/simple;
	bh=u33N5pjzA+TQ8lEsaBuPDibGBDJF2NQ140/CmBxc9js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxSrIsmr/iosa45XM5aYiaPy5FDyAZnscMkVmd0oIUPy/HrleF/+tKlsJwWd6AKb7iOZGgP7iLVGbbDhLbRyW5gXYLqaglXr27qfO35+GIbOiHK67Vz28oAtwy13OBSm9eKk4bNysdJMW2D8CbQ8raG0qQIhafpdHHttCircClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43FA3FEC;
	Tue,  3 Dec 2024 06:31:40 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F5A73F71E;
	Tue,  3 Dec 2024 06:31:11 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 0/2] small fixes for arm_ffa driver
Date: Tue,  3 Dec 2024 14:31:07 +0000
Message-Id: <20241203143109.1030514-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset small fixes for arm_ffa driver:
    - change ffa_device_register()'s declaration and its return value.
    - fix direct message request version 2 uuid setup.


v1 -> v2:
    - Restore error return in ffa_device_register().
    - change type __be64 to unsigned long to suppress warning.

Levi Yun (2):
  firmware/arm_ffa: change ffa_device_register()'s parameters and return
  firmware/arm_ffa: remove __le64_to_cpu() when set uuid for direct msg
    v2

 drivers/firmware/arm_ffa/bus.c    | 15 +++++++++++----
 drivers/firmware/arm_ffa/driver.c | 13 ++++---------
 include/linux/arm_ffa.h           | 12 ++++++++----
 3 files changed, 23 insertions(+), 17 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


