Return-Path: <linux-kernel+bounces-429023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96239E1660
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEDD164F44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C71DE4C4;
	Tue,  3 Dec 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kjpHwtkZ"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2B1DE4C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216037; cv=none; b=q0Ak/xYy/j8r2PO5ZMvdZ0FpezQahNzHC22bqmI+GU5PLSNV0wtIFidl/6eaioXT8KWKXgXiBGqxh1hNudBiuPJK96qJo2qc5Y9XPrlPNDxGHsUOKJfKODxYDzsapWG32psm2IpFrMgpRLd4esKz6C0nBj3+h+JKtX7Dc8cjqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216037; c=relaxed/simple;
	bh=nN8mpIVj9xbeipfBZZo6MnJF+K+pxb3WCk8yiNfl2Yk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qk43YhJIHtU8ZHYNTZLweUXnCnX+HihlrudHQm6VvPOJqYSenDeXh3AJD4IJfuy4CpQYCeOQEvSpvee4XQiP/X3UW1JZMTuIIAowk3psHLPg76BO9s7mMy1wMVYOnfwXTRR34Do6Vnb19sqjZpu60LSWFKq4PNlHkwKyF7qNiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kjpHwtkZ; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733216027; bh=nN8mpIVj9xbeipfBZZo6MnJF+K+pxb3WCk8yiNfl2Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjpHwtkZPbaZno7xIE/pxLzx3NwtpnURKUzRUVLw4+MmlDgkdFLLiRxNcmddKEdxA
	 yTFP5USptflqiKdggmGF4AAF/eqsQq3WpDbg337RIIjXYskgAyouzirEvL3q1GP6x2
	 J4WxyC4Fhkrl92qjUm4zvldpBSRTvpxc6r9AcWOM=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id D6D89A32; Tue, 03 Dec 2024 16:53:45 +0800
X-QQ-mid: xmsmtpt1733216025thh89m0iu
Message-ID: <tencent_71D0A5DA0DCD1219DDA35DBD9936CF948D07@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06imZ0feDfSC1p3p2mTF+RgZwexk0H2rqJ/LBtULJEQf0NYMQUlkK
	 fDK9I2gEBqOKpiHyBi/lvNWuVV61eJKAC0EU0eYuZd/oCX7SiXQTPK8TRnonxU0vS/dpuQ97ClIA
	 C4x7OpcxsEbkUssF1knaCgZalAvkHC+eRNIJr6P7wmDXPgp8oHEzivKiYpQXfZOcAzfb0nRv2/oU
	 9oRq/KyG9LQIRgYc8AiEkja9/rZ2e1PqGInWjsH0/yv99wtME/lEkDw3xy1+ORWQ95a/V6qfT1a3
	 3m/7yg7evkQyDtXLOnPabtKi1/YoDbeYRXFRXoiYdWetmZ0sPZfr7FeDAbYge1EDdj4wek+NIO/s
	 AhSfUzW9uQ16lrlVr/0x3aKU94L/AnGJDjea4ap0Lyq34CIq27z7kB4Dsr50BHdjal8KoVCtTWsm
	 /+PwArQb3We5Jypx8MrvBhiYEwXRZDpmpxWan4k0xexx+hUsUqa5G08+MqPq41t3IvYTflmjSP+a
	 yJmEJDxOqJ5B7WL5HE9HSH3ATpTixZza5A9SPMjRJEBIzok5ryNR+9WqyCRGJr50jVbxRIfBl8X+
	 NV9KDnSPY6DwD8wH7lId4MaKdgYnMcCX4CWLfTTN2/xT8wGopO8j52RTJbuBYUkNWlN6IRIPY8a0
	 2e7DMuEY4jW9+f2FAB7lbyy6heuuykIZ6IzQjRnlSuoahwN45xxoMw0fyWiveBsiBqrr2dgc0AUj
	 mg0sJIIQtpJ2do0V6ilF9pDiHxY0779zi/J4C5hPN4VoM7eKF+IV5eJGo1GnUd0kvqrWoxQ6Cgzh
	 Cp2nnPDc5Eux4/ik3uXAKPX7lTde8u6rvLgkaOhXQdu955MuH36qwktuXQuovHfbrxw/C6nbgpNb
	 joyQzUj6D79/kg96IrN12bndTlQBodLcu0pXu0qRWE43mu97yv3ewrZq7GOmGEznTKcC14f/6z
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] divide error in dbAllocAG
Date: Tue,  3 Dec 2024 16:53:46 +0800
X-OQ-MSGID: <20241203085345.510536-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
References: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/ea1davis/linux jfs/syzv2


