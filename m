Return-Path: <linux-kernel+bounces-254829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4DB933841
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047FE1F22984
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16FF2135B;
	Wed, 17 Jul 2024 07:50:01 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A811C68F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202601; cv=none; b=pEp+SP88dpNEF2GYvLXsgv83bQWLc2xROKKxeEfqr9ruoqt8MTEM5FRn7LvQmXNZ8tvuoL7A0AXd5FWqhY/OMF8fAOcg+He0jOjVsiEllXl7BaXKaQDFZMD1mc93Hzf8xDj/bGh+kr9Fv73eNC7v4Il4L9L6L1I+BmZQygE+QT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202601; c=relaxed/simple;
	bh=mUorW585kESl/Ad/7tH+uLqI2fpfwcvvi/aUNxJGhc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVS2c4V85FhzJ02EQiBIe+ywyTMHfjzrLJoHYwuGVJa0xhhdoxVZHlq6zwGQ6bBOXVNPZJj/hqy5TjW/m1oPd04zwf7aDqwTqUlkSdoqa2JT/FLSXReAHLGzQlOHe2FMm2uvSePGycLV6/AMA4RZ7w5kCkTtscyIKCXxQcQsJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WP7Jx4hYXz2ClD7;
	Wed, 17 Jul 2024 15:45:37 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 30AD114037B;
	Wed, 17 Jul 2024 15:49:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 15:49:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <arnd@arndb.de>, <deller@gmx.de>,
	<javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<peterz@infradead.org>, <julian.stecklina@cyberus-technology.de>,
	<rafael.j.wysocki@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 0/2] Fix crash memory reserve exceed system memory bug
Date: Wed, 17 Jul 2024 15:54:37 +0800
Message-ID: <20240717075439.2705552-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

On x86_32 and arm32, the crash memory reserve may exceed system memory
and display "reserved ok", fix it.

changes in v3:
- Handle the check in reserve_crashkernel() Baoquan suggested.
- Split x86_32 and arm32.
- Add Suggested-by.
- Drop the wrong fix tag.

changes in v2:
- Also fix for x86_32.
- Update the fix method.
- Peel off the other two patches.
- Update the commit message.

Jinjie Ruan (2):
  x86/kexec: Fix crash memory reserve exceed system memory bug
  ARM: Fix crash memory reserve exceed system memory bug

 arch/arm/kernel/setup.c | 5 +++++
 arch/x86/kernel/setup.c | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.34.1


