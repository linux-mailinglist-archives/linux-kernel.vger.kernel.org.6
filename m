Return-Path: <linux-kernel+bounces-243537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4709192975D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECAB1F21589
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5F17BAF;
	Sun,  7 Jul 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="HGFVogR7"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEC1CD00
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720346991; cv=none; b=CCRqlSDJfmQ8IvhY68WyGEcUffuKzOGvxPUSzMRsh/DyVAe5lSr/ByutPv0WEu1ICMoOvj9qXjGHA7mpQoiP7MDxCI3qFvUV6DgtlhfBqG5Q6iOf5QI9HqYiWogtB5s7fYCEwPfJyobPqgVAaZvF0EzlunluqhfN/ZikEod5frI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720346991; c=relaxed/simple;
	bh=3ZYlLu04Ywqm8rfuotLw74fxgWjLu6rHcBQkAIb6njo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=G02074lKlqnRuZy/B4uAI3eMKNvbLv8ynfFpmIU18/BJVeDHZ8tIElpVeaY0fdVIX2BfFJOMtKZn6vHuVp5yOtoeN0xd5XYAcHpr0DVjNlm9RAkHODna6ROnILY6kOx+tC5Ks4aHWBa6bVqf3F7rJZ9rkgYyglMDk95lcv6j9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=HGFVogR7; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 7759 invoked from network); 7 Jul 2024 11:43:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720345385; bh=sWhQn7uhVSBsy0cQPSzL+KpFMsoHdTR8s6pTkJVXcSI=;
          h=From:To:Subject;
          b=HGFVogR7PISmSWEvsYUepG+ck0Ne3OHFG4rD5WBY4ZdcNeSDGzjFMw/tCV6Z2QoLb
           IxiQJcVzHwOGmIFAsvGMfRSQiKhxoB2grlrzoD4CC3fqQxVHTJQ4Gi5lONNLGA/NkI
           cZ/3a0LIr3VdpsUkP8K8nh5J4MRuMiI4NTRGHrmo=
Received: from 83.5.245.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.245.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <ms@dev.tdt.de>; 7 Jul 2024 11:43:05 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: ms@dev.tdt.de,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linus.walleij@linaro.org,
	nico@fluxnic.net,
	olek2@wp.pl,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/1] mtd: cfi_cmdset_0001: Fix compilation error if FORCE_WORD_WRITE is 1
Date: Sun,  7 Jul 2024 11:43:01 +0200
Message-Id: <20240707094302.784948-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 4b7de137d175a33030cd5034704572ee
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [8dM0]                               

This patch fixes compilation errors when FORCE_WORD_WRITE is set to 1
and CONFIG_WERROR is enabled. CONFIG_WERROR was enabled by OpenWRT
a year ago and this patch has been used downstream since then.

Changes in v2:
- Rebased on top of the master

Aleksander Jan Bajkowski (1):
  mtd: cfi_cmdset_0001: Disable write buffer functions if
    FORCE_WORD_WRITE is 1

 drivers/mtd/chips/cfi_cmdset_0001.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.39.2


