Return-Path: <linux-kernel+bounces-337826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10D4984F77
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DED71C20FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA1BDDA6;
	Wed, 25 Sep 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v3If9BOB"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB28C8FF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224320; cv=none; b=tzwiuKJlFsSgWFIy12cn7EPS4oxF1PuB6i8DBI4VQZd6jvl5VQWRj8TxM3bp9U5UahwNyzXJlW7DuSPBhu1dnJIT7h0wP+8OiiKAwqmohB6xn5g8q6MgT8W2x55Jt8DpUEofQMt1/07macTLeJUr63eOSIGk/SBrOzrldW+rsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224320; c=relaxed/simple;
	bh=iveDUNzlNFl3ql9YrU9NiXfQ8Ds5Tvh4d+zzEq5zQw8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=o3Fon2SP6oO6bvVBnRedjN7OPIsDCE1KBahbU8Yyf1B16Liu1hG4pandVNU/M+SaF0ZU7fU56ECdvN1qym7eGtAbm0gG2HuTzfANIpFffvFxg/sdUJcbq7FcmxPFXwa8W8E7AvLe62QiUxfEcKo+yijW/OanlQWpN/nnyEalGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v3If9BOB; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727224307; bh=vpVWgiJhx2Rid7BwpDRT5JT5s7sa/hkRaaHKbr+MCm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v3If9BOB24Xl94LTDxKTgs1OoXeRLWUgIf1MfLfxGhAT1SJutJHxl6iihfuj7DSZ4
	 OgbPTDnyZgW3j5P+8UP44GPNs2lkAX57A9f/elbXdp1HUf8/og0WbFWFf4VVZ/0CR/
	 hbTCK+wDBjqm2bGcWir3oHBnVSI914zNuv5YOZXI=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 5E698A9B; Wed, 25 Sep 2024 08:23:38 +0800
X-QQ-mid: xmsmtpt1727223818tk8f6zy33
Message-ID: <tencent_32A5A08D89123A5DB6DD8A19514F8B8DD107@qq.com>
X-QQ-XMAILINFO: MRw/zKT/0BpPrprfKPF0l6gNpU2NTl39rTuFtj4RmdV3QomwJdEVKQFOREF0Vw
	 mth53AuVHl60k8Kh8oeDWGeK9Jsye/ujHvcSkWec0JaoayNPlNpcQiQlBiYXuRWGdwiAp/EZzKNF
	 hF5NWdr+afC2wm17m8MXD/6OoWq3xtKasj782cmKCVdG8wuTZCtLARYrubmVjugD8DNwR3q2FzGG
	 wB6yydzNMRGvDAxuZSwxhahhTBR513LzZZOM4HDDxUvvfVnVO/04pC/qWkZzwEmAp3kr2w8rDef6
	 44++VgyxjSOF17av6cLuaN+gYds7doRRzzxks4nodKIxe1OeRa7HphWvr9ySzPUMK7AsOPa0bJba
	 gMWLVnVR2hApwQ6REh6euHwzTiJFMcexkpBjtpKZyEOIbF/MmFa3oTNycHiax7MJ7LKoHWRvNKwI
	 q/tiFk3g4jJi8n78/hjSH8+IZLatQcF2yql1Sus5JmiOlGG+mJdcMVZn4mvaPTrB52GxJ10b38uy
	 fE/7cs6NGI8WJupP75gcew7c1Iw3Ak7ncV+7xiaBa4UrmMVW7TlnCClhCprAS5QW//NdrkwyTe5D
	 mZ6kqGrRFseOvRO/TM+frODlAqDd+vibY5S1+ZiA/UZuJVFAg6ZcwaWKabC1MmK160Ha4AUZnCB7
	 FJg2dVncL0eyOIJZNLFNnLr46iqAkw5zi37M4UFm7fMTSm5Y7KJXZmTq+tXuq/XJtgw3NWAVZKm1
	 466FcBjcAhCSK6aEUCQSxyVBmHVhgxZgMAjK0bx7gmBQ55qpD7Zx4WtayDa9IXVs8FQZZ3g14LvT
	 ZtCktp31dSSeeNVCp6uNVU3zxwjHmVvNr541FIKJAnA6GeLaxj1I80zuxcwdPIHm6za6moybp5le
	 ggRrqp289MBeIa9TNDwhIZFeAn0yOeFTIRZcL/nrND
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
Date: Wed, 25 Sep 2024 08:23:39 +0800
X-OQ-MSGID: <20240925002338.779950-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66f33aad.050a0220.457fc.0030.GAE@google.com>
References: <66f33aad.050a0220.457fc.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EPERM support

#syz test

diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
index 60b7875adada..4119ef5e1fa1 100644
--- a/fs/bcachefs/errcode.h
+++ b/fs/bcachefs/errcode.h
@@ -102,6 +102,7 @@
 	x(ENOSPC,			ENOSPC_sb_downgrade)			\
 	x(ENOSPC,			ENOSPC_btree_slot)			\
 	x(ENOSPC,			ENOSPC_snapshot_tree)			\
+	x(EPERM,			EPERM_fc_root)				\
 	x(ENOENT,			ENOENT_bkey_type_mismatch)		\
 	x(ENOENT,			ENOENT_str_hash_lookup)			\
 	x(ENOENT,			ENOENT_str_hash_set_must_replace)	\


