Return-Path: <linux-kernel+bounces-324855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B997519E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9662A1F2273A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DB189918;
	Wed, 11 Sep 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lgF0XIce"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8D1891A5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056748; cv=none; b=CAw/IIoV8daRT0mPKspLTI/Irx3Oi7KggEbrN6BHW1mWmLbmhqoE7nBQN6uQIYKmgmG65535Z/F+Nb1tXk1AqjmQduCWkzslMnN7idKUVttI4yMcZvMc9BwIgiSYZkxtPwolJl/yD3GGynS7kVRNyuRaAEsNJCQ2b1tp/5asWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056748; c=relaxed/simple;
	bh=WDNcKA21aT5pUEgURguHtXwWDVZydHmBg3GZZS9FSAo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QOQ7o9x0o693FDvY/QVzEpbKM2RvelOJD56lIxVcPjIcca1/XXpgrh2eoV2PAWtVr6T9ZX1PWnzlSxsDAgmoDjVp10PBn9I0kxDlaaA1srk67O9VoBWRcUdMkoAp4S97TQW3xZFvBos7xJExZQlkLbVGs6OU4j78KmdEcn0evE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lgF0XIce; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726056737; bh=E3p6u9xK5sZWsuUf8nACxdaVl5NnjWcuqDOV48fB02I=;
	h=From:To:Cc:Subject:Date;
	b=lgF0XIce+KWldEzWP9YlVneGOO0DDmcG+iaJSKuJoFfxxf7lm+Fv1cJYIDpqb/zrP
	 uUUDH/zGYxzHCbkov7+bKz1aEKXCZdsyd1ulEVEt2yDmsv9sHQvvzODjuT7nSvZ6/n
	 QpTEJ4BGhtl/lljEf7vGZ+OpCFhEIUOvpv96e1ik=
Received: from Ruihai.localdomain ([27.47.132.2])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 180A787C; Wed, 11 Sep 2024 20:06:00 +0800
X-QQ-mid: xmsmtpt1726056360tl1gf28rc
Message-ID: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjk0Qrj4lIdTDqdZZs0PQzzciRtzhtHu+iByHP4GmiS6nZQ/mftN
	 POpdFSTvdBwIf6XDn3Q5RgurVx1yKxqAt5tkUe8BGqGwC7gkChh60MF8w0gaqz3ep2KTR4r1R+i1
	 6RYMtqjfxuuVACoaZ6XRlYSxa6K8FenHURlvHZfThNIzYI+Lg6mATLV/kU1GTKBrOKqjuMs+uy98
	 2hgGB381gKahLk39dKbJ4FixuTp93uR6WxkDYlXsOO25bNU/WiTxavRt3hpnkwd3LRuCy0RkfNcg
	 IVRqR5a3vs3+mPQeDtSADVCpeFLeRc4Q12wadZOJYqcOJSppkI2qDU80pVA/6Ol04ot3HFF4yPUl
	 S6QdUe9TmwdYS3mkh5KdnnyfZaJ+qezja3bmgPhTX9gTcUdeZivjL4PDcLubz1WZjDFXeY5XJp4N
	 EMe5F+43nLA5E3jB2Jhp07RJn8QAsi50kh6/HA8WGU9r/nWBU1aNx7xlqrS4Tk1AwKh50C90Ic3s
	 6eFx+57GO8HgvqLVwrkzoJ171C9+fH/qpyMsW9uSYSI9FZOfT8tu6QlhZi0MluoiUZTcNANkeG6p
	 bt0bqzIxPgb0s6kbob8NB9FxXF3ly7mIxa7NAwO5ebohfYBS1FI9/EIqiT40/x+2+VY5RoPiHnxI
	 HPVyAhkUsoUXPMB9cOBEivKe05e76blGUhZeuNxDZ6e1XXfKOWOYg4wov+DM9kUQxnpqAtkCMFfM
	 +xO9mrzm8uie9RHo+9woSLGN97XCiqYDz/sg27XsdkvMCnQH8KEu91lWDCF/xaGOHMkBGWcxt/QU
	 CH6IwPddY7uivccXLVjJkGv6Nv93BMEJi9HEKu2buc30ke7sUBknebsdqQQyGs0wi+CgO+D9QJZ2
	 OXkxpj0axMqez+BZTgMYtEyKOmmVnLwR33hO7h6QpXeopIsP04bwQehppYdFUl8q2urXk+lzPso8
	 WbWSqwRnFHGZadWGBQP6JW244jWfxk72t17xSThtKqdUstQfMmgjK8+8bDfAyoDarK6pZvBAk=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Ruihai Zhou <zhou.ruihai@qq.com>
To: srinivas.kandagatla@linaro.org,
	gregkh@linuxfoundation.org,
	msp@baylibre.com,
	zhou.ruihai@qq.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: core: Fix memleak in nvmem_add_cells_from_dt error path
Date: Wed, 11 Sep 2024 20:06:55 +0800
X-OQ-MSGID: <20240911120655.105-1-zhou.ruihai@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the nvmem_add_cells_from_dt(), if the devicetree 'bits' property
is outside of the valid range, the info.name alloc by kasprintf will
cause memleak. Just free before return from nvmem_add_cells_from_dt
in the error path.

Fixes: def3173d4f17 ("nvmem: core: Print error on wrong bits DT property")
Signed-off-by: Ruihai Zhou <zhou.ruihai@qq.com>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 516dfd861b9f..ce71bee5e1a9 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -826,6 +826,7 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 			info.nbits = be32_to_cpup(addr);
 			if (info.bit_offset >= BITS_PER_BYTE || info.nbits < 1) {
 				dev_err(dev, "nvmem: invalid bits on %pOF\n", child);
+				kfree(info.name);
 				of_node_put(child);
 				return -EINVAL;
 			}
-- 
2.31.1


