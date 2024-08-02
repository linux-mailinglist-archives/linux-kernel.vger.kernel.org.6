Return-Path: <linux-kernel+bounces-272839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606069461B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9256A1C220F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13931C231B;
	Fri,  2 Aug 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGL9AZHV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NoGZhqoi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DE166F2B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615349; cv=none; b=eo1rSXfRPCm6WToxucvd/iaPAH/i6R481xSUW315cwNDjKA6vfKSm9NelgZMzK7dUMcAiWYOAGDZCXp+9BeHcaaiQOrKMp9zFzh+3K1oQvDGbLe3YXU/SyUidro3j0PtWi8kgbpTl0ai5qi+fw0inz84Gc7Hnn17KvJsXYH7vFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615349; c=relaxed/simple;
	bh=/PblH/2hmTtg1PwsKLYOOwcxGtXJMkw2mo9Rh14Np7M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iBVD6chr+Xfm3T5iWeBZFv2ACSKJ7MRnLUNzNN20b3akNb/emkTRp3/jxLbUoHiwtkj7g2hgpjF+mAztqpKBRWGKaBlSxNWpP0MBDp4FX2piV/MZnyn6s2kZCR4FfyubDZdEKnyGAR3lX8Sl22SKm6vYkWoMSGI67OT09GmPzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGL9AZHV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NoGZhqoi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.843266805@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NvWyjYqggPv9q7d5bTQ1InFLBiONgQR2ak2ONK1XkAI=;
	b=lGL9AZHVOReen+dbHFVFsHWu2PkEqrRssoKFkrZiyn690YhxWxKz8iIoPSZZ0m0zAk+ZtK
	1AXH69Lg+tIBNXDqSluuTB1Xyczq79iqhcJAPb4fb2gNRjtakNve6D2ShbX4H6HaUp4oZ1
	FKqKsdUfbmO/3mKAGS9zNf4nXwMimwDoLqWUhPoozUJx+N2EQuifFTY38aX8idJxhYuRLU
	R7fG+ub6YSM5rtKY7CmtEhQMkuQUcOjgsFL2RQaMxV/79SFCsu4HAGPFDOPhmGGjLxp7vf
	bovpuCb27yOEcPmLpqlyGrzu6XwUoeiOLuRid/Dgw5YC0Guq3Qe9ey45OatAWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NvWyjYqggPv9q7d5bTQ1InFLBiONgQR2ak2ONK1XkAI=;
	b=NoGZhqoi0yqQvvecCQI1ccNwhPuv7sf333AuPOurG4RQPxM8w/cE+PxJg0x/BXnVdFshaK
	y9+MfUj7sfINYCAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 10/15] iommu/vt-d: Cleanup apic_printk()
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:45 +0200 (CEST)

Use the new apic_pr_verbose() helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/iommu/intel/irq_remapping.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1352,12 +1352,11 @@ static void intel_irq_remapping_prepare_
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
 		set_ioapic_sid(irte, info->devid);
-		apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
-			info->devid, irte->present, irte->fpd,
-			irte->dst_mode, irte->redir_hint,
-			irte->trigger_mode, irte->dlvry_mode,
-			irte->avail, irte->vector, irte->dest_id,
-			irte->sid, irte->sq, irte->svt);
+		apic_pr_verbose("IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
+				info->devid, irte->present, irte->fpd, irte->dst_mode,
+				irte->redir_hint, irte->trigger_mode, irte->dlvry_mode,
+				irte->avail, irte->vector, irte->dest_id, irte->sid,
+				irte->sq, irte->svt);
 		sub_handle = info->ioapic.pin;
 		break;
 	case X86_IRQ_ALLOC_TYPE_HPET:


