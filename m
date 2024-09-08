Return-Path: <linux-kernel+bounces-320454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791EA970AA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2526F1F2186E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105F176ABB;
	Sun,  8 Sep 2024 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="O/09M+iP"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9C3A1B5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838703; cv=none; b=T4LEwx9hlSUoWuS1okqRx3tdM1XUjlW6hPj6eESp6AHphrp5ji4EX+oORuwLDegmeJRB5SeT+clYHh9ENSSy+gCEHdCUYiMrqQdcjTLBD5jBAFFfNHKo1fYZP0MFcC3abBlu/n2RHG8bC4YnS9wsE/LZvSqtiF7d2skQlfxnFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838703; c=relaxed/simple;
	bh=Dj4MoV4hsIynWlsoGPPVJFos9puRUE2tAgL9QZP4TS4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ExqGoagSAyxyM59FRcZNDBA/6c+sHe8TMzO0Mi7/jTi7+S1O76kVf/KPRZa/qEnqF+IVi26r+3kXyUslYH4dFBLdCD7g6kxX0mJu7czMq9SyqqbzXItJcysf+CTkbIN+SSnMl2iGC7HamWDjwzGnYuYDdR3opvRU+00LDmHMFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=O/09M+iP; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725838701;
	bh=QIBaVkqGzxSWra+zHU8UfAmVOyhjZbzEI6VLZbkAULo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=O/09M+iPfQAicq+ExBLFEVulm4hP7HqE/X0cNdwiiqqBOltzUvD93xCcQ0WbdK5tU
	 mkAt2EnAAgoR+P3NJkCCDmViqgYOmzvzF3tpFhLdaAI6efuT+34HknuZJTjO/sWgFQ
	 ZK2kXtehbVbANemQtBX5eEPjeAlRdApZLRQTVfimXJ4uFpz/kP9Y2nVCM91aUNInNZ
	 jGakZydEUjsjdAt0xi7OyumrLeiIm3FzEbcZElEkz/WJi2PuuKoJnR8BhjIuUBN62M
	 iU4cpyFq5LejfVHRtKAxq/mjT8JP1wyM4sGrlCAY/4h1k3Byezc/N0l9GcyNpTDGbF
	 E61x4S0aJyT3g==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id B991A6E02B7;
	Sun,  8 Sep 2024 23:38:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
Date: Mon, 09 Sep 2024 07:37:31 +0800
Message-Id: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADs13mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3bTMivjE3KREXYM0A8vERMO0ZOMkQyWg8oKiVKAc2KhopSA3Z6X
 Y2loAPGiEbl8AAAA=
To: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Isaac Manjarres <isaacmanjarres@google.com>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Zijun Hu <zijun_hu@icloud.com>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: tD0yY0G5g8nHoFQmdmJYM4ThIdNePukn
X-Proofpoint-ORIG-GUID: tD0yY0G5g8nHoFQmdmJYM4ThIdNePukn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=761 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409080205
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to make amba_match(), as bus_type @amba_bustype's
match(), also follow below ideal rule:

bus_type's match() should only return bool type compatible integer 0 or
1 ideally since its main operations are lookup and comparison normally.

Which has been followed by match() of all other bus_types in current
kernel tree.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (3):
      amba: bus: Warn on adding an AMBA device without valid periphid
      amba: bus: Move empty @amba_proxy_drv's definition to the front
      amba: bus: Move reading periphid operation from amba_match() to amba_probe()

 drivers/amba/bus.c       | 130 ++++++++++++++++++++++++++---------------------
 include/linux/amba/bus.h |   1 -
 2 files changed, 72 insertions(+), 59 deletions(-)
---
base-commit: 888f67e621dda5c2804a696524e28d0ca4cf0a80
change-id: 20240829-fix_amba-0f09aa1fc3b1

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


