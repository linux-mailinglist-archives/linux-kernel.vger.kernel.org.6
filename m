Return-Path: <linux-kernel+bounces-553643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F38A58CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C63AA9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555991CAA7D;
	Mon, 10 Mar 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IEqtXiRp"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240051CAA70
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591547; cv=none; b=jSighS3eHpnB5ZBp8lVoos9IZlJexRIpSs90xgO5UZLdweejq7/02MOmuj0Efywc8VEUmiB+3klY2B9v1qC9JYn5ufpUAoSOb4lhyagucQJLiU+mPN9bOT58mcXWX5c9KuIKeU7CiQMawdzEYRujHmnVxRsrU213DNQJ1FfddA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591547; c=relaxed/simple;
	bh=fq05aJvii9M9tH5nUzsmzfC9jiUArPMzjVHXJMObHXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8HkZRthK0xOziy+Et/bUsttaYHF/adcatZVHDS+Tchh1g8anL7GlNweCMhZzRIk4X086lzaprAZyyrZOTpu1K41tsbtj6OcTnsZmy5MR3p9e2gzC7RN9dicucuNGwbywjWO69RqMJQn0kpb995Oux0uRq4YtfMyk+s+exNJUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IEqtXiRp; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741591469;
	bh=Wy+jnUoivwyS60gpTT9Uw9KftbsOYh42amALLbDE8D8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IEqtXiRpvSLTLZCdYEECw7CbNez1RDCfH55X9M3fKj3uhvEXofzRyi6ho1OpOrW99
	 5XS/mdxHNX2+kI+CWbnAcDyUQ4DzEGXyQBoKWsRxrXFrk3g/FRxtI39zjzvFLXd+J+
	 dNODXZJxUqauTCEXtfxK8dUiVxyeYiYr41kNQcyQ=
X-QQ-mid: bizesmtpip3t1741591455tlup6ji
X-QQ-Originating-IP: C5l8J16DYC9HptF8KBT0mnAZGyZbnYXd4QOp+OU39QY=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Mar 2025 15:24:13 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6406034055523155332
From: WangYuli <wangyuli@uniontech.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] drm/arm: Suppress "ARM devices" menu if not essential
Date: Mon, 10 Mar 2025 15:23:57 +0800
Message-ID: <D20815A68EE4902F+20250310072357.52841-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OAOHw7tUGLQOmUO5QGLUlZ0rTas9nWoVLFV94VzqTjHvUXGxUVCBub1I
	rbYvbxq4GlQ/OCoGI7YWfLGRbej9vqQ5mWNKIdUHKvMxY7bzYipsKRT7tdv1kccdDUlMtXY
	DXal1fBG8Jb/KcWjK46ImzTfm/EDbNe+39Z1wQTv1L+Qeuj5Xsa0rpd5RZuMNV/xw7yS9SL
	nS2tS8oMeMZ0yNP32mQhaWzP5YWHMW4XMSeh7GDCW+q+tuxgT3MkaUsU9cP11HImjLkan5q
	VR5EORQ71CIzhffhc2JYma5xmrMuY0Vz/h8Cx0ObXKyg3y14s44VYaCehfoR6hm9239Hyds
	oOCyH2NfcAb7KXYBjMxowryYy+4WwdY48k0wb+GjbDKMVd2cr1U6joHMBulNsa8TQIS5wOO
	vE4HmsO4A1YYBUczWKx9DzGh7JMcv4/6uQfjEjGY1Gcg38xPbrmMvwPpzmNaZeKZW3Bb72A
	G7F8HJOQgSYeBR6RG7CWCYjEjuaC+Qu9AghNVdnpKHFrprq6w1Ia4m4RimRGrvs9Vva2MXx
	Js6vEKs3Mo9gP04Hx0x61/J4FfpuEQiQ87jk/3BTX4IMuF4h/dmzHQGuAgpG+ilU7ziKUFu
	lHKOZSa+A0vpDqrer35l93Bkc9JE6m5p4CJgBNaW0PqKRhsi6g76PmwFkP5zalO2stT5B2d
	8rxwD5qvJCPctjVBsFWfcMU9xaYVQK8Fxjiy/QGsvEC1ehZxAk1Qef5vD1D2Co6PHm4sstN
	09JIrlPDrJqSU5bt0bRppk+RbL8R+dzFbRqIppDQVkCwy+92H/m9Jv1JgQkwG8jN6SYPhN1
	74+ZxVofxeNOBX1ZCUiyf/8mcFnBWjEHMqWw9uFJ+bz9XMLltEw7dft5828hyNF5I8ufHas
	FuWdkz5WRryNmy7wgZaRDmZkF55FQ+DzEaBPRihUilPmN8gOgf9LqVjs8rbCZ4yZAhQk8E+
	KFq5ubBC1Y35n3y+NtE8murbJM2fg5yMISLyAKlkdgIdiZZaX23QiLEifHos+9RuxKO306N
	BFuRqX/cCPCV7TUPewBYzjBb2N8mBPI4NDy3Agjw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Manifestly, the "ARM devices" menu is appropriate only for the ARM
architecture.

Inasmuch as every single item in this menu is predicated on
(ARM || ARM64 || COMPILE_TEST), it is therefore illogical for the
"ARM devices" menu itself not to be predicated upon
(ARM || ARM64 || COMPILE_TEST), and displaying a blank menu in other
architectures is unwarranted.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index c901ac00c0c3..0aa6a54567b6 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "ARM devices"
-	depends on DRM
+	depends on DRM && (ARM || ARM64 || COMPILE_TEST)
 
 config DRM_HDLCD
 	tristate "ARM HDLCD"
-- 
2.47.2


