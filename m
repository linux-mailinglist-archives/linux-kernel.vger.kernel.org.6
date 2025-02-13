Return-Path: <linux-kernel+bounces-512700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3DA33CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2633A32B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3E21322B;
	Thu, 13 Feb 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaB1HbS/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F220B815
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442698; cv=none; b=U4E+zmp7iSFd846pOWJF1bBjpr5yu2rHbuFu37jdIrBniCcB3r/lPlZxS5ilHXutgqu9spJ+9bTdIwvkCAxt9z9nomcgWoSeyPrmNvbb60lSHGR2Wo8MF/GUXA2FySRuueACix9KKAtf1AGdyaNeIkMxoVGee+jFXGzhLYSidFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442698; c=relaxed/simple;
	bh=EMHWCfcGdBNxqYWkfC34XIyDNIoSqseONRJzl/P926w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWRNPVudaeZt6wTn4ybkNbzW3ppzLNBMq8qodq36bnCdeMHd55qyH98Xg9eEMNSnyCU8CJ2dDiJIBXNMu6RwQwLhaCR4Q+C/l6ihJDZ/2qD15PB3gs6FgfWQAgxM5QbfBShE6KAP2JUrzsOblIn7YqON7QCC4zLWcFQiIpH/7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaB1HbS/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f286b5281so131860f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739442695; x=1740047495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5v6y/RGLou6n//Ox/p9DubvRBsDa4+/GRuy0MzgkNg8=;
        b=BaB1HbS/ucPzVW5PymG0Jmu3l4Qn1Jxh+W4Q4+EjVxsmd3/tl2hvfns0G9sfc0fPnA
         KjXRY1S9gDpGrDw4yGGhBpBbrA3iCx8VjdEahw61h+VsQoZU3AAJcFt1yNDlL8trMOgO
         10V/gzH5cD5Js2qF2u0XU/2gOQPpL/Q/4vIYZGwYp/dxvmsFh0uDXBuC+Ph+YfRADfET
         pSPvP+Jy3M7uazUmu3C97dwSF0kvpzM9ZyX/yLBBbe3DfkoliJ/efxifmc0T6Qc1d2N+
         tz03PErSIJu0Eci6QkOq5INxtAS8iFmEO9J/SxVHE8LVmXY4t5SV+mAm3G704ZDX+Byv
         O1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739442695; x=1740047495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v6y/RGLou6n//Ox/p9DubvRBsDa4+/GRuy0MzgkNg8=;
        b=gmKV4wRVdvP/4JI2gVLZrV8Jl3JwVq5GHH4QDA/OxCYJsq6q/SMd9eK92qOwR6c0ql
         xsmtYL0K1Iv7pCoapChni1k2b6YYl4UWABClLvHOyNqyUSMWFBhf8f+QBGaFw/Qm4qMZ
         oKb1YU/U9Yel1yxa/xWSQ576eN0G/MlAMpS40w+xYzwApcO+Zt3ddhTcPZdijpgXQBzU
         YxKcKgQuWdBdPEY/5K9PAdDKNn2FP9CO69KE3136F3cgJGnR0ultCaqZP8/6bOUXlI+T
         /d2G2AHIZKSso5BxXhXM+J0pdCbClbTEpbwV2xvw3Nl5ih4MTP+cNYF8om8Oiu9FCzho
         8I6g==
X-Forwarded-Encrypted: i=1; AJvYcCW4G6DVhIv9hqt6RKO9bNsEkzeLiAANUK53kKjQP0KBzbHy14Kd9PZrjXa53c3bwMXjVVU2ZeU382s1H1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqvs2oaES/VolC80QTFxG4NRtEApIf43SHm6lHKpPVp3s0XWIg
	S5k83z7ytftowkX2mKUqzn71bcFr6ISATZt5Cv1X+frZw52YgbuJ
X-Gm-Gg: ASbGncvAB65081beV0aJ8jVby9Ojvhb342QLJE8hVMS0sIDvgpy9+soIfTKuobGweFh
	nuZN+avBW6FVTS+wneVynG/a2yqLkyk6WYMNB5xkLtyUb84d7OeDaVDfwpXvmdsVmneuMJANcl2
	HdukjcEzWM4hAzqMjvpGAImrbRT5UwnD7hyHur9P4nIxH8liP/5qpMQCXgVeTxAQ9DgpOyz6Rvt
	ViV5qYJ1FMYbMkvvmwfkW7Ul42r2e4QK6Mef+mvjcb1ARanne9W32Naqg1JRU1L7kVYdWi4AoHP
	0hX2lVVWzsAZFEhy6ebG5NggmXmHUefUccvmC9x0Nby7tKeagk0=
X-Google-Smtp-Source: AGHT+IF/H6NTFcN+gTu1zGXAcHdCzcnS1GE6g8RlW5NNRLaMhFR6h3Gx0RipALbA1xBd66s+r0UWJg==
X-Received: by 2002:a5d:584e:0:b0:38d:ddf2:aff5 with SMTP id ffacd0b85a97d-38dea256daemr6642693f8f.3.1739442694719;
        Thu, 13 Feb 2025 02:31:34 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b434fsm1509540f8f.16.2025.02.13.02.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:31:33 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] staging: gpib: Fix cb7210 pcmcia Oops
Date: Thu, 13 Feb 2025 11:31:12 +0100
Message-ID: <20250213103112.4415-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The  pcmcia_driver struct was still only using the old .name
initialization in the drv field. This led to a NULL pointer
deref Oops in strcmp called from pcmcia_register_driver.

Initialize the pcmcia_driver struct name field.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502131453.cb6d2e4a-lkp@intel.com
Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/cb7210/cb7210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 7785d674f397..cb0d8a721687 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -1347,8 +1347,8 @@ static struct pcmcia_device_id cb_pcmcia_ids[] = {
 MODULE_DEVICE_TABLE(pcmcia, cb_pcmcia_ids);
 
 static struct pcmcia_driver cb_gpib_cs_driver = {
+	.name           = "cb_gpib_cs",
 	.owner		= THIS_MODULE,
-	.drv = { .name = "cb_gpib_cs", },
 	.id_table	= cb_pcmcia_ids,
 	.probe		= cb_gpib_probe,
 	.remove		= cb_gpib_remove,
-- 
2.48.1


