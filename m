Return-Path: <linux-kernel+bounces-412208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5D99D053F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3003B21EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920D1DBB0D;
	Sun, 17 Nov 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="KtkQIxay"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505126ACB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869079; cv=none; b=jmAMvdRU+9ljXDgBg2U4GlKMnYU8x7vAUEEHE0aBu1ng15ZC5dgrz8I4GstF38SoV2K9K2x7I5s71rnCbsKcANAamJqZBflMDbYtBUduakhLJuJmSEH/hXFs7yCA8QBkqlaYXAtDzmeI4a6KjgcrV4YsMXq0YznR2U+iT+e1+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869079; c=relaxed/simple;
	bh=1vF/ooWorH2Ca5CAOB4mMV8CTmrs5ciK2QzG1YGK8h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6vwsEF7tNzbgCSNKTu8Uo+lgTDGXVOSw+5Oqwmnb3Mc84eaC/sVdfgebGQDOqW8ULOX5LcrwU2rrXkbdpyk1T6OW945+EhuuKQ0psfZYB/1YQg7NtaJC73tGtaJTBeHc/XaxCZNVK2wu3HJkteQmiPoijkIRgrJf5JeZkJviAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=KtkQIxay; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2FBC1518E778;
	Sun, 17 Nov 2024 18:44:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2FBC1518E778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731869067;
	bh=ZfOJ3PpDEgEr9Zel8CG5ZDup6WjpmnQFHw2f6/BApFI=;
	h=From:To:Cc:Subject:Date:From;
	b=KtkQIxayYNhqUiSE/e2qdEjmr0Ov5PDq6l8Plza3soLEpAMndcyjl78R0okRttA8e
	 Ka1Mjgs510jInDqGeSM4ZVh/Arn+nqDmGL5+vAZ3SKzYHQuxwVyBwnQklyO9NfWvSg
	 g8C6Ufxm8hRixG5ITD6GNahvNnoC5t4vXiuoJ7VY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	David Woodhouse <dwmw2@infradead.org>,
	Wang Yong <wang.yong12@zte.com.cn>,
	Lu Zhongjun <lu.zhongjun@zte.com.cn>,
	Yang Tao <yang.tao172@zte.com.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/2] jffs2: fix a couple of uninit value errors
Date: Sun, 17 Nov 2024 21:44:10 +0300
Message-Id: <20241117184412.366672-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a couple of places where uninit value is touched on error
handling paths in jffs2 code. Fix them.

Fedor Pchelkin (2):
  jffs2: initialize filesystem-private inode info in ->alloc_inode
    callback
  jffs2: initialize inocache earlier

 fs/jffs2/fs.c       | 2 --
 fs/jffs2/os-linux.h | 1 +
 fs/jffs2/super.c    | 3 ++-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.5


