Return-Path: <linux-kernel+bounces-514888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EBA35CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D201883E63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36621266587;
	Fri, 14 Feb 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgClqt0O"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38AA263C7D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533678; cv=none; b=ut0eypwgR2YzRJq/gE/bP/Z5ugliB4+vtWSxasZJur7c+p5ePo463ZK4x+YslgNtRdplaKBLswO9omxLdS0uQWNy84PteYXdQmNdQbUG4g6GHq3aIuAMyskwud0Z9xEdwkklIaRlaIp9cjwnOfS1MYB4/6ijpSmoy3uiACC630E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533678; c=relaxed/simple;
	bh=ZPsxNDdLxN/WEv2Kchtqn9tK2nC5fl4GJweyGM1bGwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKZbtha+nTYyIlMOwB3Y4j2mpNkpTxquaSpHnw3MIL+Ngon7gWZL7Ad5TB1co3JLeFDknGqqutcTkRY7rJP2OtEtZTh8iYKdkB7ouXXZPPRZtegs6WOD4JgEkFAWdK7sXzbQ4+4U84aaPauuZv027MwZtCHJHO2pu23EbDdc4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgClqt0O; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso3486005e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533674; x=1740138474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec71cd/p1hU2cNYNpB/ZLydfzU3d5LhvXmsLFtr772Q=;
        b=LgClqt0OZyG1HX2dhPM7iZ2KwbkByvJ2es9U04UvcqXTUn1JcQKoIiBmyglYqknwJN
         imM/LScyNqFuKlbYeLyAF1FG/Ps+YYzQX9W3pOffBRcuT6VGtpMC/q1cmZ51ocSWGOlF
         zhl4KPiwrrmbSQ9OcpqbFu+/Ee7AtJtkv67z4RGNz4hjHpUZ5inu3qFtA7NfeSFqb6lC
         gGjoQjn3k7ojDKYvPbdBwwNb4Kpmf5Twashq8vs11bR7hZLAenwxsJJdhYyGfX5umpkF
         b3FeGRCUPrhSu+HVbkTp21Q2YLnLtaif0Tf/JfxydIpOuXyaRN2e/CPAHHu8Qw1Z2+yu
         /7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533674; x=1740138474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec71cd/p1hU2cNYNpB/ZLydfzU3d5LhvXmsLFtr772Q=;
        b=BUXHA/aUtVWFSyFbBAEwFTYanfI290WsplLGs8UVi8RuSo8V+ky4fovNgHN0bByDU8
         0A045XyA99bAWeIAT0q6t31QvfoDdkuuaoscZIrRgNGXKCZP6RXVPlpUmqrMNLxc1shn
         sfZkI9U9YMy+Ymm/E18xxIVFJHB7/RUEMV/hI23f51k5tWVJAQ9wZ3KFdLVn9aOPyTbG
         wk8UMkghhkGLXfYTeq80PePFUHX8aMwA647qLfE4zCv8LFjBCrYCWTWKf3TDLRavA8AA
         qmtP1kHxypqAoSRn4jRpoYZ2jRXiVJcE+G5M3bioTvTMAm2Vtm40Iz7fAFVdNf/0lDsF
         2fOw==
X-Forwarded-Encrypted: i=1; AJvYcCU7OnZb/yB3hc8O+GeNlcyz0WgHWoMCaKl4pscxLMAt0UeXV4DBelKzA8ArnnmgC6Qfw3+BpZ7DelX1tM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyet5LPr4aE4krJIQN0VY81pk9Zzu8LlWHjaePde6lpZ4RI0sGa
	Q2Fr2BUcrhy62La+Se8iF96Rijypykoj/UOoRRf1wG8pEwoIbAlVMoSG9g==
X-Gm-Gg: ASbGncsxFtrQ32exiFK4DuuvtrDaSFuoiTFsKdKkt3v0rsQPU8tZap6ydD+tF+X5FTO
	DdqBomIbvNbn48J+S7uhGx9XTK3hR3rmYLse1CmybkNMbnOR7ZceLmHCOoFFdYhI5VM9QmfTxJo
	SkY1uEIs0OO8zOeTiEsVv+7rez67YveSYHNFzRCFBV26vQegX+Q7fJ30TK3sRuakjdOxZCabnh1
	PpK8i7eYcICiZJ/uGeUVvi8qNrrUtzpnmOXCi9h6Jw0xFpf1X0jlV2FKk+NohbVRsW3ZvFzLha1
	jUU/O0IpcWHiZvuvtFPPDO4TrIqPq9dIKPtVWyFl81omDs82wY0=
X-Google-Smtp-Source: AGHT+IGgguSbTbESk+Ov1C1vagzixWuyEOgymSOQurmS8GN7IKNeKOjCL+nOvt0DUJLwkNwpAHQhRw==
X-Received: by 2002:a05:600c:511a:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-4396b570e93mr9299385e9.17.1739533674023;
        Fri, 14 Feb 2025 03:47:54 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:53 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 16/17] staging: gpib: tms9914 console messaging cleanup
Date: Fri, 14 Feb 2025 12:47:07 +0100
Message-ID: <20250214114708.28947-17-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable module name to be printed in pr_xxx and dev_xxx

Remove pr_err on go_to_standby timeout.

Remove write wait and command wait interrupted messages.

Remove __func__ parameter on error messages

Change pr_err to dev_err where possible.

Remove commented printk

Uncomment dev_dbg in interrupt_have status

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/tms9914/tms9914.c | 33 +++++++++++---------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index ec8e1d4d762f..1f2bb163cfb5 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -4,6 +4,9 @@
  *   copyright		  : (C) 2001, 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/module.h>
@@ -83,10 +86,8 @@ int tms9914_go_to_standby(gpib_board_t *board, struct tms9914_priv *priv)
 			break;
 		udelay(1);
 	}
-	if (i == timeout) {
-		pr_err("error waiting for NATN\n");
+	if (i == timeout)
 		return -ETIMEDOUT;
-	}
 
 	clear_bit(COMMAND_READY_BN, &priv->state);
 
@@ -175,7 +176,7 @@ void tms9914_set_holdoff_mode(struct tms9914_priv *priv, enum tms9914_holdoff_mo
 		write_byte(priv, AUX_HLDA | AUX_CS, AUXCR);
 		break;
 	default:
-		pr_err("%s: bug! bad holdoff mode %i\n", __func__, mode);
+		pr_err("bug! bad holdoff mode %i\n", mode);
 		break;
 	}
 	priv->holdoff_mode = mode;
@@ -437,10 +438,9 @@ static int wait_for_read_byte(gpib_board_t *board, struct tms9914_priv *priv)
 	if (wait_event_interruptible(board->wait,
 				     test_bit(READ_READY_BN, &priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		pr_debug("gpib: pio read wait interrupted\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		return -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		return -ETIMEDOUT;
 
@@ -472,7 +472,7 @@ static inline uint8_t tms9914_read_data_in(gpib_board_t *board, struct tms9914_p
 	case TMS9914_HOLDOFF_NONE:
 		break;
 	default:
-		pr_err("%s: bug! bad holdoff mode %i\n", __func__, priv->holdoff_mode);
+		dev_err(board->gpib_dev, "bug! bad holdoff mode %i\n", priv->holdoff_mode);
 		break;
 	}
 	spin_unlock_irqrestore(&board->spinlock, flags);
@@ -548,10 +548,9 @@ static int pio_write_wait(gpib_board_t *board, struct tms9914_priv *priv)
 				     test_bit(WRITE_READY_BN, &priv->state) ||
 				     test_bit(BUS_ERROR_BN, &priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		return -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		return -ETIMEDOUT;
 	if (test_bit(BUS_ERROR_BN, &priv->state))
@@ -667,10 +666,8 @@ int tms9914_command(gpib_board_t *board, struct tms9914_priv *priv,  uint8_t *bu
 		if (wait_event_interruptible(board->wait,
 					     test_bit(COMMAND_READY_BN,
 						      &priv->state) ||
-					     test_bit(TIMO_NUM, &board->status))) {
-			pr_debug("gpib command wait interrupted\n");
+					     test_bit(TIMO_NUM, &board->status)))
 			break;
-		}
 		if (test_bit(TIMO_NUM, &board->status))
 			break;
 
@@ -761,8 +758,6 @@ irqreturn_t tms9914_interrupt_have_status(gpib_board_t *board, struct tms9914_pr
 					write_byte(priv, AUX_INVAL, AUXCR);
 				}
 			} else	{
-				// printk("tms9914: unrecognized gpib command pass thru 0x%x\n",
-				// command_byte);
 				// clear dac holdoff
 				write_byte(priv, AUX_INVAL, AUXCR);
 			}
@@ -799,7 +794,7 @@ irqreturn_t tms9914_interrupt_have_status(gpib_board_t *board, struct tms9914_pr
 	// check for being addressed with secondary addressing
 	if (status1 & HR_APT) {
 		if (board->sad < 0)
-			pr_err("tms9914: bug, APT interrupt without secondary addressing?\n");
+			dev_err(board->gpib_dev, "bug, APT interrupt without secondary addressing?\n");
 		if ((read_byte(priv, CPTR) & gpib_command_mask) == MSA(board->sad))
 			write_byte(priv, AUX_VAL, AUXCR);
 		else
@@ -807,8 +802,8 @@ irqreturn_t tms9914_interrupt_have_status(gpib_board_t *board, struct tms9914_pr
 	}
 
 	if ((status0 & priv->imr0_bits) || (status1 & priv->imr1_bits))	{
-//		dev_dbg(board->gpib_dev, "isr0 0x%x, imr0 0x%x, isr1 0x%x, imr1 0x%x\n",
-//			status0, priv->imr0_bits, status1, priv->imr1_bits);
+		dev_dbg(board->gpib_dev, "isr0 0x%x, imr0 0x%x, isr1 0x%x, imr1 0x%x\n",
+			status0, priv->imr0_bits, status1, priv->imr1_bits);
 		update_status_nolock(board, priv);
 		wake_up_interruptible(&board->wait);
 	}
-- 
2.48.1


