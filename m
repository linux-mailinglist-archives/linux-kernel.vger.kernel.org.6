Return-Path: <linux-kernel+bounces-322776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4496E972DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AC61C20298
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0FF18B493;
	Tue, 10 Sep 2024 09:31:28 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B1189F52
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960688; cv=none; b=gWBfvycPCE/ZbYB3vmq1UbqfpUSIFyg1idvB/xRrJY9o54spdgLMCfB2PCcZBagRyJiS8dJwIpnaATiLdCNBNJ0OHO1xoxc/4jL5GqYqX2PwfsvQW7L1Xm8zjgCSP8RmD6BcwG79G5EaIXL9MfaipX+LfUWkgspLI5sEijVVzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960688; c=relaxed/simple;
	bh=CXs9EKEfEvHBN29jcDuttEIyfUXf3+kMM0EWcoc26BI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ixm4oFVcYIhDHYM8MH86YiuI9kYhJ7hTAQbNIRx9iLEr3vo8DO4jZw+FaO2DJ+FMLUN5ExqZfezjoKZD64BFIPAo26sVuvSM9gCTX8L6lgtxKFevdbhUoUZvkZiHJx4TgBYftbndjqSmfEDRy7/1dgXdLedUHeeYi+c6QjK9ERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1725960677-086e237610120230001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id zIDDeZBNS16GxvdP (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 10 Sep 2024 17:31:17 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Sep
 2024 17:31:17 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Tue, 10 Sep 2024 17:31:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from localhost.localdomain (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 17:26:53 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH v2 0/3] x86/mce: Add Zhaoxin MCE support
Date: Tue, 10 Sep 2024 17:26:49 +0800
X-ASG-Orig-Subj: [PATCH v2 0/3] x86/mce: Add Zhaoxin MCE support
Message-ID: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024090910439.3349-1-TonyWWang-oc@zhaoxin.com>
References: <2024090910439.3349-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/10/2024 5:31:15 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1725960677
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1499
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130251
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
X86_VENDOR_CENTAUR, so add the centaur vendor to support
Zhaoxin MCA in mce/core.c and mce/intel.c.

For the sake of code standardization, add zhaoxin.c to
override the Zhaoxin MCA code.

Zhaoxin CPUs support CMCI compatible with Intel, because
Zhaoxin's UCR error is not reported through CMCI, and in
order to be compatible with intel's CMCI code, so add Zhaoxin
CMCI storm toggle to support the new CMCI storm switching
in mce/intel.c, mce/zhaoxin.c, mce/threshold.c, and mce/internal.h.

v1->v2:
 - Fix multiple definition of "mce_zhaoxin_feature_init" (patch 2/3)
 - Fix multiple definition of "mce_zhaoxin_feature_clear" (patch 2/3)
 - Fix multiple definition of "mce_zhaoxin_handle_storm" (patch 3/3)

Lyle Li (3):
  x86/mce: Add centaur vendor to support Zhaoxin MCA
  x86/mce: Add zhaoxin.c to support Zhaoxin MCA
  x86/mce: Add CMCI storm switching support for Zhaoxin

 arch/x86/Kconfig                    |  8 ++++
 arch/x86/kernel/cpu/mce/Makefile    |  2 +-
 arch/x86/kernel/cpu/mce/core.c      | 70 +++++++++--------------------
 arch/x86/kernel/cpu/mce/intel.c     |  8 ++--
 arch/x86/kernel/cpu/mce/internal.h  | 14 +++++-
 arch/x86/kernel/cpu/mce/threshold.c |  4 ++
 arch/x86/kernel/cpu/mce/zhaoxin.c   | 53 ++++++++++++++++++++++
 7 files changed, 104 insertions(+), 55 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mce/zhaoxin.c

--=20
2.34.1


