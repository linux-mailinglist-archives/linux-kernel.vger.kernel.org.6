Return-Path: <linux-kernel+bounces-352934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E099265A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2021C223DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F65187FFE;
	Mon,  7 Oct 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CIumdcZo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cdsLnsOl"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79F184549
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287392; cv=none; b=Bpd7vrupbQm6Joo7h/d2V5xd4di4YMD7EuxNcvhabYKrdHNuk1skF9w5gFduTYQ6WoGPHmYnPxqGKJV/8djhqhzk/FlNuImCaZtf2p3+yO191tzVQVmUjGKrTFWpRNnSX7vVg87CQHfgaAOttP9TJxLyTApASz42+2a8lfSSqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287392; c=relaxed/simple;
	bh=5JJ2VAJJt5L79tAQrhdvX1wtWytvyLnTk5lv7Uid6bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kkKz0xDu7UZxLQ/A6zv9dQQ4TH72Kyd10JkZDNKw+wP5PM7ddjb1gS1PsArfBP4dEOSKJKYcct6AMkJf0yQA+83fzUHv2epKGTgrYeh4AYuO9b6kTDVSqcuyBa3+gcSJoRkBMuWSjeO9+2lL510jJO+Yf31Vx9Dg85oHtYuN8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CIumdcZo; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cdsLnsOl reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1728287390; x=1759823390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ztZWkDqY99BDUP7+ib4kL2smsBbGTSr9fF5IVfjlSXI=;
  b=CIumdcZov9oUOUUBmSIVQlrNgH9Mgqz+a8/k1kHvYkU6NJ65tfBXcSDS
   2BhNiteY+yB+4BEnGZwD4/XfMyxlTBtBHoxPKJze7Olpu9+zmj+IB5YGj
   tZFk4/VEwlNNfXkS8cGMC7dOCfdc76gMjW2Vpzmkez8AHPiCwqvUHh7TO
   cOkIPfa1mLSsTBy1ltL7dZFpHpQHBfeL89GWauKc9pPznjf+SgedhYOI6
   ouxJKpU7bIMc5MDS22MeRiQoUnVIHPGNvUXfHu7Cqfk54EVizjzh7bWiJ
   HaM7i6JlBk4CbjqAhAc3AMOk93w0xaBk52A3atRcwjtMIPBCBC8E2XYWB
   Q==;
X-CSE-ConnectionGUID: +iOH/cQISqWa3dP8XzJ50w==
X-CSE-MsgGUID: IURFG3i9RnWezA0FdrLhHg==
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="39297560"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Oct 2024 09:48:39 +0200
X-CheckPoint: {67039257-1C-F5F7BCAD-D99768E6}
X-MAIL-CPID: 16F41E41131326FB213CC270C069F9C5_3
X-Control-Analysis: str=0001.0A682F1C.67039257.0087,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4B7816A45E;
	Mon,  7 Oct 2024 09:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1728287314;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ztZWkDqY99BDUP7+ib4kL2smsBbGTSr9fF5IVfjlSXI=;
	b=cdsLnsOlgxEldqSV23ChB1/C8glBK4s+rgycyJLwvg8ec2PHKM7QbDJPAN0+k1gfcPoU9R
	U655mqFWH/vqogW1rbpFgB3ljq7U9PtWrWYWfo7pTh3MYtNfE+Y3CGfTnIKqJGTYSoh4iZ
	IrY+qMvmth4L4FLmmsqdhV0oOMXrlRc78+op2ymcp2yds0CjSJJpng1/qkCJbVbloWUsFw
	KacUunFPC0tVIARmoEVjWtc2qZjHWF/SCRalsRZmxbG48nVY96yB00M6xwrJcxgbVu5qms
	QU0NDdUFRYd/ozSuP6U9qpvfhnuAD36pm3nmyj0zyteFjDSfMHUImjPtzyEkRw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 0/5] mfd: tqmx86: new hardware and GPIO/I2C IRQ improvements/additions
Date: Mon,  7 Oct 2024 09:48:03 +0200
Message-ID: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Patch 1 adds support for 3 new TQMx86 COMs. GPIO support on SMARC
modules is currently limited (not all GPIOs can be controlled, pins use
incorrect default directions, IRQ configuration is handled incorrectly),
however this is a preexisting issue also effecting the TQMxE39S and
TQMxE40S, not only the new TQMxE41S. This will be addressed by a future
patch series involving both the TQMx86 MFD and GPIO drivers.

Patches 2-5 improve module parameter description and error handling of
GPIO IRQ configuration and add support for configuring an IRQ for the
TQMx86's OpenCores I2C controller in the same way.

Changelog:

v2: improve module parameter description (new patch 2, adjusted patch 5)
v3: replace IRQ 0 resource entries with empty placeholders to simplify
    error handling (patches 4 and 5)
v4: remove tqmx86_irq_to_irq_cfg() function (patch 3)

Gregor Herburger (1):
  mfd: tqmx86: add I2C IRQ support

Matthias Schiffer (4):
  mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and
    TQMxE41S
  mfd: tqmx86: improve gpio_irq module parameter description
  mfd: tqmx86: refactor GPIO IRQ setup
  mfd: tqmx86: make IRQ setup errors non-fatal

 drivers/mfd/tqmx86.c | 109 +++++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 34 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


