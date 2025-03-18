Return-Path: <linux-kernel+bounces-566392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A72A67749
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DE43AF3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0520E6F1;
	Tue, 18 Mar 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU8tTh5S"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7220E003
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310588; cv=none; b=dEaeN/Ki6+EW/oHg4R4yjNSlcrRwWX5DQD+OrQhffpNLxLgmiOzcFP3P/HAyeLE4xO2Dos0i/1Egk12VuZ1bzyXNz3jGK5RMNpfTymb2sVycHbNba4Ezh/+Af8aGT1gPGQ12csYkgxoBU0LymYtWwdw09YZpvC+zIt1S2U3VwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310588; c=relaxed/simple;
	bh=up3vEH/2NyMI9+tvTMWFdSxU1SLIqBztBb2NGlnwDRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EXW/lW6LVyhult1cKF5kYtohfkKmeMqUGoh4BfLbrQx9BJ02m1/x7f7cPoDN54bUdzPYMU17a5A1suwXi6JY7V5nD/kMNQZAXqqiVNs/F/dHF9qRx3WdAAZKWAIaPLOx2ZY9/8ssZcQgfYr4fj+bFOuJ8afPqJP25zHpNAIDgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DU8tTh5S; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3c4ff7d31so738675585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742310585; x=1742915385; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8KvHOzHLjO6KpO+17xD+gf6z/bYQ+D5l2z1JLTz/U8=;
        b=DU8tTh5SKGppkzoBZ0pI3UVQvyIWEWfirWnGzz9zRTGeP0Zw1sPrpVYPSMN7sMIOL0
         Muk2bTLi47Ff4VSOB9CL1wTUuzl/2CIuKY05G0RSW2kAsYT0soSemBkNXUbT9w6JsJdw
         aFq5RXrtFR5oAWLmwQDQfCpsF6/XG9cBG5eQB9gJTvZCarwi44hDxI4U9AixCCdcg+LB
         Z7okyfMfiRao6q85i3I+5xpTR8TDnEpKVeIz1l+uPbw+a8upPs7MaDoRmnzXOGQrIQCl
         6Jv9kAAnzDT6/6l4FBBJIiejDGhiLaObkCsL8uUyjie103fpOS8oESQ5N/YURSGryEDA
         wbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310585; x=1742915385;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8KvHOzHLjO6KpO+17xD+gf6z/bYQ+D5l2z1JLTz/U8=;
        b=D5P91a4D7+HZnMQLkrq01ifaqDhso7VfeH2rz4X01ZTmP0QW+Q6LL/zk0VyRWFZi/N
         O+nVOAV9BBB2m13mak1h3Ew5Heg2ja9aXAOfy3wUQb6cBOON9ClJkUH83/kGipvhifCr
         FVXbSE83CPB36eDbPoknmNddv2OClv91YulZ8niacJax2B5fPcXhxIUJKoJVftNE90w5
         YCUy06D4nqZJ0GA5HhUMMkvKlsD163V6P44vFuj8kFHx8p8f15jCKsThC2RJjwYrj1mO
         iKkPWZadvWBCs6L2Dtg4VumYCQezDUVgDwW6dkq2jJzITDEH45Ox1R+iNMBuXBM1oal/
         68uw==
X-Forwarded-Encrypted: i=1; AJvYcCXeC5x6GFWVyfm0dAfSo17yW139m7KqP53fLMWTHoE3CtjNUmIBmsMPvihCsHEs0XH0VDrg8mFTZJOZnz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKU+aO4Y1Btz5bVtgnxO8Kg6Ro3HK3/ht+agFl2qwYnFDPL6D
	TJn0DcQLq4EIbpp1Vy0JHG8SmCMTpfn7JWvyIsgPCwYNDIQkTbpxcz07xxP2C7M=
X-Gm-Gg: ASbGncuL2B5qRmHIZcPCXKerbYGzp5F4pySjJNF+QmD33w7reyyYeuLa7kUIiPcCykv
	hGGlRwg9Dt6OO5Ze8v3EY1c6LJgKdgZ76r8B4NDr0hbUma81vYkVdm/GcDnKxjWkJ1ChtdAwW0Z
	igWaCZhOBYPTyIJYucOX2juRkGaLYa3YT5Ig05vRNkUAERzzZOnlNsX8q+kBI0fcLxtoFWrg0pn
	KRSGGn5WKSagfcSbZUgB5fZx3ssQD0k2TVKF31aS8BG+1NuPDWiSl599Zx64uFLPJcEab0Zkhdw
	WdbJNaHDAqEYHtjqTeyK3NqXOkqWKzASSwn34a28ts4FG7IcL7vo2l8CGblkueEQp4ZYT4k=
X-Google-Smtp-Source: AGHT+IEvlO3xHMq98UWUgmnAVEnhA/g6K+SfAxe199aM//I35slXn4vPlXVoilOfP/0Qmw5F3dgFjA==
X-Received: by 2002:a05:620a:4010:b0:7c5:5768:40b9 with SMTP id af79cd13be357-7c57c8fc43amr2395060285a.43.1742310585406;
        Tue, 18 Mar 2025 08:09:45 -0700 (PDT)
Received: from maple.netwinder.org ([174.89.15.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d701besm735044185a.68.2025.03.18.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:09:45 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 18 Mar 2025 11:09:32 -0400
Subject: [PATCH v2] usb: cdns3: Fix deadlock when using NCM gadget
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-rfs-cdns3-deadlock-v2-1-bfd9cfcee732@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKuM2WcC/z3MQQrCMBCF4auUrJ2STEi1rryHuAjJpA22SZkRE
 UrvbnDh8oP3/l0JcSZR125XTO8suZYGPHUqzL5MBDk2K9TotDUInARCLGIhko9LDU8YxnNMLvh
 oA6l23JhS/vyi90dz4rrCa+a2/6fQjOZinBt6o1FrHMEA+2Wbe8m0CpXbkovn2lee1HF8AYgWL
 Y2oAAAA
X-Change-ID: 20250312-rfs-cdns3-deadlock-697df5cad3ce
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Roger Quadros <rogerq@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-c25d1

The cdns3 driver has the same NCM deadlock as fixed in cdnsp by commit
58f2fcb3a845 ("usb: cdnsp: Fix deadlock issue during using NCM gadget").

Under PREEMPT_RT the deadlock can be readily triggered by heavy network
traffic, for example using "iperf --bidir" over NCM ethernet link.

The deadlock occurs because the threaded interrupt handler gets
preempted by a softirq, but both are protected by the same spinlock.
Prevent deadlock by disabling softirq during threaded irq handler.

cc: stable@vger.kernel.org
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
v2 changes:
- move the fix up the call stack, as per discussion at
https://lore.kernel.org/linux-rt-devel/20250226082931.-XRIDa6D@linutronix.de/
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index fd1beb10bba72..19101ff1cf1bd 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1963,6 +1963,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 	unsigned int bit;
 	unsigned long reg;
 
+	local_bh_disable();
 	spin_lock_irqsave(&priv_dev->lock, flags);
 
 	reg = readl(&priv_dev->regs->usb_ists);
@@ -2004,6 +2005,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }

---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250312-rfs-cdns3-deadlock-697df5cad3ce

Best regards,
-- 
Ralph Siemsen <ralph.siemsen@linaro.org>


