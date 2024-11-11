Return-Path: <linux-kernel+bounces-404185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE09C4065
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03591C21970
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB3419F487;
	Mon, 11 Nov 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UYWXysfO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XS1PZAhS"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A019EEBD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334287; cv=none; b=lIxj3l8C+UX3WwsxdB9W+ufsBgoYzBCXf7X6lHqEKHAvKV9PbCofga0HtQUc+CNuTeIMkHu87aJqyZTGAC8je/IYfEFpzhkjhmedX5cc5Aroyo692WZBxBYwkXOwfQRSKauYAwt/wFj8AXLmpnG/tuTaDFQQYeJdDF7Z1CW0zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334287; c=relaxed/simple;
	bh=uk4wsERGoIOX1Fk7xg06M7ZY2WxYZB/LDCpNrxNMxP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joRZAqL6jIqblNYrJ26jlnLGHnsSxlCVWPgzrO1wit9CmsTHrnLEWRSqCUCAkO7vhsiKvOrmrblP/Vox5SJ1Gul2r+t+EoJoO3fMZUFKZvUKFvrducK7HDEGb9lSzFyJB/fXO1ZIvPAFIMd4HxuEUULfFEOZTwqPeHezDH+0xms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UYWXysfO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XS1PZAhS reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731334285; x=1762870285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NMjJJ31S9MfCGcGfo7ORsrgnYAV3c84znAhxi9fkMtM=;
  b=UYWXysfOgs2UZvVC/hXjT21BJHCYqKnXyiuAiC3xqfXZNoCZ9FKM3l7+
   g3pMNFnPB7rwrQ/LdEkafEHWiURUw9/0eRnHex9ChML1GjH6JXXOJjmHr
   RSk9s9YYtEtk/yL91LYB7HZcuE6ljD0rtYBH4cOsRK15EVc6s54/VVb30
   7ON0qvTnp94GFI5v82TvTL1mHFmQWeyPRs6Oa9Q8UeFziCu69+PBO//k/
   r8Lzhko5wDKrGfBBdCBI7Y6Zfh/frLrclHp4xkvLXquv9S89s6TucL6Vj
   m1xKRvcStT1XW8M3ugKpDtf2tGjG8fJT2xwxCBANRfzLVy5WXX68ctU8J
   A==;
X-CSE-ConnectionGUID: QncgqJ5bTxK6YqXDSgNJsw==
X-CSE-MsgGUID: z5f0wQYBQE2utiNvVoYq9w==
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="39967037"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Nov 2024 15:11:24 +0100
X-CheckPoint: {6732108C-1E-90CD5875-E0265C0B}
X-MAIL-CPID: 29CD4D53042DCE80D6930DDF4B639E85_3
X-Control-Analysis: str=0001.0A682F15.6732108C.00F0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D12B166B5E;
	Mon, 11 Nov 2024 15:11:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731334280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMjJJ31S9MfCGcGfo7ORsrgnYAV3c84znAhxi9fkMtM=;
	b=XS1PZAhSJDOCYE/Er3zwLwQEpD336jxXRMdhntlj3mvxLzu8c2fxH+fUOD7Idw+Wvwr+gd
	nPGirMfHqRRjVibfV91e5iNnHmXU8y9L8A1ijhFCEnxc3qErWVWhPaNxJvBZuaYxdDIIas
	6g+Ji9KgisOoki0R/9sEWiz7Mb+EVv76Jr5Y8ultFAgB5o1xj2YJlP1dm/L8NUybABYk3w
	GoAT7fonFa35uK5utjRieQmDys8EwYPbznINrcOsFjEssx+ZkF236f1zjHzqYZWlr+Bo4z
	tvSXk0o99RnRFf69vicvEi7By0pwtftyY9E4QRaH8WFUTcU41IhlpJ3ldqwlMg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v7 2/5] mfd: tqmx86: improve gpio_irq module parameter description
Date: Mon, 11 Nov 2024 15:10:29 +0100
Message-ID: <3275f436b66f6807c02256bc852d39b03ebd64d5.1731325758.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Clarify that "7, 9, 12" refers to the valid arguments that can be
passed as gpio_irq.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index e15b9be98c2db..7b2f9490a9af5 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -58,7 +58,7 @@
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
-MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
+MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
 static const struct resource tqmx_i2c_soft_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


