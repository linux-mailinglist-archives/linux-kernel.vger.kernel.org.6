Return-Path: <linux-kernel+bounces-321243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2336E97165B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19FC283F70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F171B582F;
	Mon,  9 Sep 2024 11:17:07 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CEFC11
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880626; cv=none; b=hc7r8EIcrKHrwLRyXONvy2EnRYeS+lwckT4TNViXbibNCgZkj63tvGPcRiL5AoHe0O2lrOC2JGRrf4V3WiTok4BHoBAqJasfy4ZUaHyKeNeQxh3iSSJH5MrB+RkhA/rG5jQenFu/9lx0GeB3iFYENY9jMOkm0p+c+/j3Y2F2Owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880626; c=relaxed/simple;
	bh=j7TzpTKVOYCvmDGK7/SfcHzwlXA74UJnZY8/B2guLZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N8lJy/6AlKfHO+/YAMdsTRgnD0UdB3YeWWt6YvWs21+OTlBrfv4kjTaAtQhzRXe9oGVi8AUgUMNocSz4fBQwwIPr9aLIPaZwUa++UWUBUzdir7uWXgbA7NDrrDePgEn9iDxgJ8yS/pbU0bBuclXo7zT0frn8/wQ2U+MBQ6+2i40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1725879759-1eb14e31a8f3ce0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id 12UxryVDVEAGjzFm (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 09 Sep 2024 19:02:39 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Sep
 2024 19:02:38 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 9 Sep 2024 19:02:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from tony.zhaoxin.com (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 18:43:49 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: [PATCH 0/3] x86/mce: Add Zhaoxin MCE support
Date: Mon, 9 Sep 2024 18:43:46 +0800
X-ASG-Orig-Subj: [PATCH 0/3] x86/mce: Add Zhaoxin MCE support
Message-ID: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
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
X-Moderation-Data: 9/9/2024 7:02:37 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1725879759
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1278
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130206
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: Lyle Li <LyleLi@zhaoxin.com>

Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
X86_VENDOR_CENTAUR, so add the centaur vendor to support
Zhaoxin MCA in mce/core.c and mce/intel.c.

For the sake of code standardization, add zhaoxin.c to
override the Zhaoxin MCA code.

Zhaoxin CPUs support CMCI compatible with Intel, because=20
Zhaoxin's UCR error is not reported through CMCI, and in
order to be compatible with intel's CMCI code, so add Zhaoxin
CMCI storm toggle to support the new CMCI storm switching
in mce/intel.c, mce/zhaoxin.c, mce/threshold.c, and mce/internal.h.

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


