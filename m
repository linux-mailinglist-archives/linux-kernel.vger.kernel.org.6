Return-Path: <linux-kernel+bounces-576779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4DA7145B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2079E16C6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040E1B0439;
	Wed, 26 Mar 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j0FRvxoT"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203F8C1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983398; cv=none; b=H6S2xAdVBQ9vFZwr4idhB3Jhp5RWAYXVIfk3xGoKFSCdLJEcjwiO9SepGEI2ybBgZtmZ+dY55n4br4OVjh92uYU3gK4mO3jfgdh6+40AJMvZ6DlsNtp22y6G4bkvxsMsLSDqoYxYLvHFE/GFBoHDYtEmoX9zbDkyw3ec/HWCcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983398; c=relaxed/simple;
	bh=o1OW7eMPI7BT9Kuja4q/FC0vO0bwCYy1NuCvSDE5Qag=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jOtzsDGj7oKfJU10q8g/sySRl11yKlmFzpACvUQwFtNpR4NLCSWUDJR7dsJ9PzhDp6vDP6/9Fu6MUsNiq3o3h8OCurLoKq5okQwmDhymFrfi7CGF4WYtQZDk+aBf1/mjHU4tEvjZtF+GRBRNwCuyMEyyRc6hAuXdrt7Xx97fLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j0FRvxoT; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742983082; bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=;
	h=From:To:Cc:Subject:Date;
	b=j0FRvxoTbT01zf/sjp8fcfTnbRau335bjg4qoWCTzhfjLK4C3nhxuGdo+i8ntdRdz
	 fvjGE3aTpbe4xwURgzIP7Bf8/aiNmfWlNbN4/7h0hCMILdUSQogLf6SFE3iosnelYI
	 be7LsyZySLAHUdkQRTzAMMeU4T9T6M6jbSRUJQ4g=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id E809F01D; Wed, 26 Mar 2025 17:58:00 +0800
X-QQ-mid: xmsmtpt1742983080t69ymxsez
Message-ID: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+ZrUAlHVGcvrCGFv1twgmb9koVlBwb4p/Bzwcwg8qFg910QmTNx
	 kbsyisMmk1x9HuhXNbtiWlDyX+SoNWTkloYzuNVcQtc9IooAOddpCIfDa0MMRKRaV+re7IzkqNgn
	 3l+LLZMu9BVCit9xXwef98f16wYkR41OxptHEGkZyFwHZFTfKZT7U0orbd4lNj1AZMftzXSd5WR0
	 wKG0lbNgICf2yl0V5KBGTbQUY7A4g24rcaTPa67Z0RIGdLMocyuf9e+a+usO5Mw9CHUZ8JyZpQab
	 gP0JHREkqgZPIyJn5Uj6ny9rHP/MVmZ+zzZ3O9xLj3rqJGqlP2ukiBMt0ji9jSgYAiH7oCanknbS
	 E5ndXEXpcUq5n677IeNeFdscg+NkfNpf5wvAgqMg6uYni79CvkQ5jxTQ5tcXVs4aLIs0u9Pox4Fv
	 HN5M1K8t+bSSlHuJiY8dSF+d/9uD7M9RJ4Gl1ZGbuqQn82+yLL66MGy2NFgjxYZ2heDqV7G70jP4
	 eN5aKmDD7+q5suoBTJpYoi5eAELeXFhE4dJwx+mdk2yl3R0/TMekS+Q5350+QQrfTB7S8L2fgVlt
	 zbGfirFsqSzVMvB+AF0aGFs0Q869ZlfpIYperZxvnaI3YlS5t3MbJVAsO4MDgzieANgzDvvQtnyi
	 WOgRN6x6hdJ6wdI3mpFr9C4VAIIrMe1jxro/dWl3BlHFFxNTDPT1L3f5DKGJez8wjtU3+W2/jkvQ
	 FGILC79K5Uup7BYlDq+34J+nXOHf8dI0vgFZ1V1KqjGfTAqRr4QaQg2xoMEOpx/zBx10zDcDXBO6
	 JniRfspyEqBC9wDvAX4V38CNNDxVdMrUqfMITUEi21eOxCb9AseXluZeBcRpkS9r2Iy9ScQvTjy8
	 6bwkZzh64O1HSZ35tnzE+4Aa17U3+SbNj4tRoFYw7fafPGJJAwUAX6KwBBRgy+24tndd42kXM5
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] nvme: Add sysfs interface for APST configuration management
Date: Wed, 26 Mar 2025 17:57:56 +0800
X-OQ-MSGID: <20250326095759.1292617-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

This series enhances NVMe APST (Autonomous Power State Transition) support by:
1. Adding warnings for PST table allocation failures
2. Exposing APST tables via sysfs for runtime inspection
3. Providing per-controller sysfs interface for APST configuration

The changes allow better visibility and control of power management settings
through userspace tools while maintaining the existing functionality.

Yaxiong Tian (3):
  nvme: Add warning for PST table memory allocation failure in
    nvme_configure_apst
  nvme: add sysfs interface for APST table updates
  nvme: add per-controller sysfs interface for APST configuration

 drivers/nvme/host/core.c  | 24 ++++++++++------
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/sysfs.c | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.25.1


