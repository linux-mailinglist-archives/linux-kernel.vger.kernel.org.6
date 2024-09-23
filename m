Return-Path: <linux-kernel+bounces-335674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75897E8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52E2281897
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353BD194AD8;
	Mon, 23 Sep 2024 09:43:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06BD528;
	Mon, 23 Sep 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084626; cv=none; b=aYRho8PXrUyBl3iT5wltWynYrBUygyF4ecV1sZZJD/Uo1ewS1kWt6V517fLiLTaLe5Ge7tPqBSHq/scmyCOhdyaAgPO8Rbtjb+Q3DBiIm8lRKJe9rxq3l6p/zhUtMV8fsK1v3g6xfynzQlkjDpWPiKogVT1GxETAhRC501ZiD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084626; c=relaxed/simple;
	bh=JZUNM73rGtmosVc+T2+DmF9U5ZG0YfwH4SCnPQrsNGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/1GHi+0To/faazHh3NeIvzXxWvUsrl7A2cfTmmx2PenpqPTZlFwOOzj8Px8lv9IA1U0osMm8pP1k0nI9Y/0/bDl7GPRFKjGzJgJ9M1/o1BZH+LPM1i2JMS81fmZ6M5sxE3PE//vs7LyzycuTQItiELIsdEj2NFw60KH4Fnffbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4d2176a2799011efa216b1d71e6e1362-20240923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:cb66d07a-25cb-405c-a076-6e7e6a7317e3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:c078da8ebb61f91720fae8694270c408,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4d2176a2799011efa216b1d71e6e1362-20240923
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2000938568; Mon, 23 Sep 2024 17:43:34 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9F0FDE0080FF;
	Mon, 23 Sep 2024 17:43:34 +0800 (CST)
X-ns-mid: postfix-66F13846-4593351211
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id 22751E0080FF;
	Mon, 23 Sep 2024 17:43:33 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: linux@armlinux.org.uk,
	robh@kernel.org,
	saravanak@google.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 0/2] Add dev_is_amba and replace the usage in platform
Date: Mon, 23 Sep 2024 17:42:46 +0800
Message-ID: <20240923094249.80399-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add dev_is_amba function and use dev_is_platform()/dev_is_amba()=20
instead of checking bus type directly.

Kunwu Chan (2):
  amba: Add dev_is_amba() function and export it for modules
  of/platform: PCI: Use dev_is_platform/dev_is_amba to identify
    platform/amba devices

 drivers/amba/bus.c       | 6 ++++++
 drivers/of/platform.c    | 4 ++--
 include/linux/amba/bus.h | 5 +++++
 3 files changed, 13 insertions(+), 2 deletions(-)

--=20
2.43.0


