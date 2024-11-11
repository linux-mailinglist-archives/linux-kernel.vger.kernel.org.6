Return-Path: <linux-kernel+bounces-404183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822039C4063
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BDA1F220E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D719E97A;
	Mon, 11 Nov 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cUQNk+eS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Jc106dW4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE519CD0E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334283; cv=none; b=fuliarrKZw5xD4lA3qZqgfqf2oasX840/BKovoS0q7LxZTWVzhG+IzoSmqNwdcopKmPVkpwYjDCN+yIhWf6Y1DIaXIS8JafL2SZ9OPaSVgu/C0DAIxE7HJfokqyPIVm+CfDSiq6vT4h38t4lnt6p6f2CUDVyajtE5Vc1ObHuXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334283; c=relaxed/simple;
	bh=jCOxLwvh7C2p0JLIyM+gsxEuaXaWXwvBivCiEjjwOd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JiirGMFsl960ljEAT+BNz4+qGkuragMKBMTTidhmZK6AcO0iZnD4W8Xn7xeocx429uO7DrHTEuZ7ZKGHbA+XBbxiAHwnpXd4W14u0aaSRKiSbTyiQrFMVJinK5unrluUXGZV/6mGzaZGpqrbMWIdMWzdpRDxbNx5AceMOgr7c8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cUQNk+eS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Jc106dW4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731334279; x=1762870279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SBRKjCDmNpQLqy/F+SAhTgNBF926ZxkPY6Sl5Uxf7cg=;
  b=cUQNk+eS3eCP6ISOcj/YeyXd0DrorcOKqTfAwQROeeKj/ax7fQMtONx1
   Ul+7wVdLp6gmvLecxf7nG5xvttdl7myaH3PuRJtJTsKPQx9rIEl99Z9tq
   FD/MkvfrljJabf7y+B+vEFBZx+ybQFCgZQO+tVFVj90KF9xikb6sWm+u7
   pdH4+SL7rC59ZrPRzI0lbx43YiTGVkANVbRSZssg8S7Ujm3uOYCxgxjru
   H2oSIfNwT6VTWgzwHSx+3Lm8uPWt7/17RwAx6shTQ1mYhhQd1JlRPBf0V
   kh7GQi5qYAJU/hTJf8kCVKVUbypvxnVrfUtmsJB+4Uaxmt4EqxDxYoCvH
   Q==;
X-CSE-ConnectionGUID: lkLw+gGTROmq5vmMCaC/XQ==
X-CSE-MsgGUID: 1XT1Q7waRcWfIoRRJBbReg==
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="39967033"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Nov 2024 15:11:15 +0100
X-CheckPoint: {67321083-28-5736D786-D50827BE}
X-MAIL-CPID: 74957C9BDAB2CA9381F929A650FB20AB_2
X-Control-Analysis: str=0001.0A682F16.67321084.0011,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36476166E82;
	Mon, 11 Nov 2024 15:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731334271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SBRKjCDmNpQLqy/F+SAhTgNBF926ZxkPY6Sl5Uxf7cg=;
	b=Jc106dW4uJ/8n9JVdev84G8NESHmMG4wN4MLkDD3HiC++O2oYYyyW+7SEtHmduxa1KIRLZ
	j68Z7GHWcPYafZ7GGUHS4LkAPP6fHZ8lUyMRW2ZPVB2D4g0IfVLTztD2hHVxCo82xO5dJU
	kCu2ilR0zFY4DA4wNO03aFQWRaaumZpaqwqYDxTqFhPQKPbpSsRoIj43pqkR9ijPwGbXLx
	dtfzAed05LLvtWQHb10+oBDNw4Yx6aPU23NtrsoQk+hciKoHZV0XIF5/tp4M8+fMJIuM+2
	kkt4jtyd0dASjR1oR/kA2h+E739Cg0heUTXchwgJasYovubzMhij4SrBfsf5eg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v7 0/5] mfd: tqmx86: new hardware and GPIO/I2C IRQ improvements/additions
Date: Mon, 11 Nov 2024 15:10:27 +0100
Message-ID: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
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
v5: move placeholders to the end of the resource arrays, use defines for
    index (patches 4 and 5)
v6: remove obsolete comment; refer to I2C controller as I2C1 (patch 5)
v7: replaced index defines with enums; shortened verbose comments (patch 4
    and 5)

Gregor Herburger (1):
  mfd: tqmx86: add I2C IRQ support

Matthias Schiffer (4):
  mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and
    TQMxE41S
  mfd: tqmx86: improve gpio_irq module parameter description
  mfd: tqmx86: refactor GPIO IRQ setup
  mfd: tqmx86: make IRQ setup errors non-fatal

 drivers/mfd/tqmx86.c | 115 +++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 36 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

