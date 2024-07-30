Return-Path: <linux-kernel+bounces-266843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C4940860
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815321F2349B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF418E771;
	Tue, 30 Jul 2024 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pbq61u+4"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5418D4DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320952; cv=none; b=FOKU67ZOZszX5SThe+ZqE0kA53wBTc+cxq9HiG/i+Mx2FX7fwEO1MZverqRo6ZQ/wxd95lgKoCgo9dxce1GS/SGUSI9LsZLTqW/gUXR2s1JCiYct1YuZKif/lrVtuZ80KpgR++98tX/u0SYHOorRhobZSzrcj0SgtT387YwfrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320952; c=relaxed/simple;
	bh=mYyDTItdugrFG889z486+jC47DzgqAgJwTPiILTTcJE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tpXPM1XGAafDdP302wwZR/yjHrH3YSadKMstkScFnOGPEjr2sMT2mjHUwz9kyNeXUYNF8/X13RtORcU08XSV1s+dRrFqHHjdFrGLZ1JnQ2gyRYCAAhrXohvTd3ZPaNP11g6WessTxD3A26+8Fwk50EuCBV3tJwkIsbpwDaERLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pbq61u+4; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722320947; bh=NmAPAg4bB8SMVeovM7xGSgHIzKs1w+WburVBHjuSDuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pbq61u+4CSuENcgn7vVr7nVqv10urjHEpx3uEW+lF4FfFUVXXLcJqNhHyowEE4ieb
	 9KQZgX0XfOR8nNVRxeylnpjylQ+ezc510WNTObmqPrpEq7f6eXd4+T+KhvJkCBtK9K
	 IC5NhUQhiPBodz97DnqMGz57+XqukPMFptJeqRBc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 74505C53; Tue, 30 Jul 2024 14:29:05 +0800
X-QQ-mid: xmsmtpt1722320945tso84k8pb
Message-ID: <tencent_55464A0A741D765767043CCB37A896943709@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIehfzFPdK2rWV++WcxpaZ2+7/YtR+/tIMb3jngbQE9js1E5TNzhg
	 R5oMZ8eUSJHkWkFJfuIf/JpftlqZVJhj+7mKCTr7xWlEczO/kV4kzlaV8AmTZPSWXteW2FyUDeZU
	 bsLN6ZSEzNAw0vy5XxNiEu3MXiXVspysnwp0XeWWt+DqajavdkH43QyiVpuSuLezG3nsQfFrY2R1
	 +6Mc84uKYMTEPeKJDfYkGWoFmBGiLc96N+cVWl1Amfc1QMD9u+MXde2EByITYcb8u1MK36xBJsLN
	 sKICTiooDLJYeE4enbl47nFwUQJJpoYLrZ2C2ie4Mgtk0z8J851J2czKt2Greasd5Lievbz7Csyi
	 2220p+xY996wg/AO2PWBUZF1ZBTxD6UTjOhtoDeqAbiG5PL+voJHLv9Xvi0ZQ9vAcox59U0Dc1AS
	 7P3lFDZKyRmVR0//9sM/sdTAFhSOfdUIizWaU7fjIImZRFRb4TavRe2r7B67AVuPvjtY3h6xTcCq
	 Tl5WKPJz7tNVPhSHQpK5RNXjl9sQI84erkB5JQuHELwbGuFRjgpWagzefIK4e8tfJKM5t6r7gvYk
	 d5opXi2nrV6xtbCbVXf3UIynO0ZNVxs2SLCCeFXUsuz5wOgAc6LvIST5Fv0Pq4CazqsxrNXFSmf8
	 0XH2eAx8auCGGnVjQJUdz92fcgufzWRnIKI61sSdAlemH50iH/6G2mOTsx+pfGf6+TUA6A9Bbgxk
	 4Kl9E2wgOoPTq4eChKMI3i5pBCAJjgbhYtTvDy3A2qQMeoaMcMCIog6zSXOO89O8hQ4Mb0vPKm89
	 JPPlywh7SKKS3GiRBRe22YBAryLqTxLqQhEbCQxf7Sil9HyfOf/Dh4sgnL9qBUjUObQbQtaMZklH
	 QUhwN4MDrJB21hP+Og6vkK/+mSGSTMKWfl64S08rtzI1tH3ap4WAKB13RZpm/NxyZoYL1sPA3Yhc
	 tv4nDlvQVvcnzP/6cNIRhs4y7Apj5vMdNyJj3My1Z1NIvAkwm7sAZADDBbFaIU0NmMJ8tUvCQX4C
	 2uzpd4W+9Ub6mfv+X/
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
Date: Tue, 30 Jul 2024 14:29:06 +0800
X-OQ-MSGID: <20240730062905.206197-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000043dc4061e61370a@google.com>
References: <000000000000043dc4061e61370a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move the relase dev to the end

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 933069701c1b


diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 83d352394fdf..02f5aeadd8fd 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1027,6 +1027,8 @@ static int __device_attach(struct device *dev, bool allow_async)
 
 		ret = bus_for_each_drv(dev->bus, NULL, &data,
 					__device_attach_driver);
+		if (!ret)
+			get_device(dev);
 		if (!ret && allow_async && data.have_async) {
 			/*
 			 * If we could not find appropriate driver
@@ -1036,7 +1038,6 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 * try them.
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
-			get_device(dev);
 			async = true;
 		} else {
 			pm_request_idle(dev);


