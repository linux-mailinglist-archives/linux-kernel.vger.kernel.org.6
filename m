Return-Path: <linux-kernel+bounces-217712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6990B61A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19669B3E005
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627713DDA0;
	Mon, 17 Jun 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="IEOVp81I"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9898413D89B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633607; cv=none; b=W6dZeKW80GIov7wSUUmOfmR96nym+GDNjcgWLLPsGqTLN9vix3Te1YW9VQNF+G6ogLjjdJnVSHaLgogeCq1y7vhPVkSy+xRcoxw3fpXsdRBH1MpGON74EEt9oXZ/lYFrwe3f8BgOLu7+B0alaWEHBV7l3Vhr6TIOHss8r5wzO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633607; c=relaxed/simple;
	bh=WbP6JlvYUOCRrvrolImvmqZUSzO7TNqCzTdTFU3eGjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxkBrklF/jqj5Z86+ZddJiwbtQHsP0xdp0G4nQvMHiq/qFdX+VkLBwnBaOiOwuOyoRRjmOYEPAQ7xNlg5f8j/UVXVydC4hl+cZooIQ3vZmHVCBbQqj20isNMao+ewyRFxIyMTTKI/Jx4YtS66dGTGpOEqWbsbnBBGB93m2E7HNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=IEOVp81I; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b065d12e81so21662066d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1718633604; x=1719238404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEPYDVeLkU0IonjTu34unuOh82lmo92YGof/pNWGY/U=;
        b=IEOVp81I86D3wRnf3RGHFsurStgHObMwgTipjdjqrka/iE1UN7LfAtAKRXixdPJnuM
         R3vsyABapOBOSGISa+Cbr+BNNzGVpDb++Yybl6i8g6MudxE0cNiiT4YECs/neoEccGRA
         BY8HL7DYJAg8gYVbiYprlo/TOvYp1KijpM6ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633604; x=1719238404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEPYDVeLkU0IonjTu34unuOh82lmo92YGof/pNWGY/U=;
        b=br+eS0hXgSNKVdmkuqQTMIHtIxhlUaEs+dCQCZ9PSe/oaJrefTWnoWlhfIz+OfwrSJ
         sPAKTT+fX/HKbL4Q8wW+znZg6MbEdW9qmcGqylH/ExBvwtr2bzE/IUcJiNknA+69jIp2
         fu3J2Vvb1wK+ydTnw4K7kz1Jr1VRT0WBPvzIDlDg0L+SRQOtgzxowrWDK+084qdc5Z8X
         m22X/knjB8pE/IAyN31dmaD38mtrHQygVsaLrB1pwEVxO3/NdDCS50BTPQwOUJxn7RcR
         V59nvuble2ebDXZfgneo/cyXaUyAeHOplhqXNhi2LmuUcVSDSWJpawWi9chKJ1WXbXOf
         mZRw==
X-Forwarded-Encrypted: i=1; AJvYcCUtItSOaTOTEAxNKtg15zPlnOuZTez/T/vFBU3FRxyCj3gIZO/7acnt6ODr5qBxTY2xqEKWIKjYOLoOLPp9xt5LAQj3XZez0TsjAOka
X-Gm-Message-State: AOJu0YwEiYbEF2za8Z7mEcC92wk3coa5XmtqI4e4vAGl+EXRXc0eotME
	5xapYUiytyMfopSbZtOhFQzzoZvoHepwrXex8kP8mdhAs9IEqArEB00ggRCL8os=
X-Google-Smtp-Source: AGHT+IGng51gHJ++fAhRU0HYTBiDRSVfUV9r9cDVWxS6lcJMbyubX5iCAI3jBFKyZg6BMsISJA1PAA==
X-Received: by 2002:a0c:e6ca:0:b0:6b2:c888:6c7 with SMTP id 6a1803df08f44-6b2c888089emr48248246d6.7.1718633604500;
        Mon, 17 Jun 2024 07:13:24 -0700 (PDT)
Received: from fziglio-xenia-fedora.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4811sm55124386d6.77.2024.06.17.07.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:13:24 -0700 (PDT)
From: Frediano Ziglio <frediano.ziglio@cloud.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Frediano Ziglio <frediano.ziglio@cloud.com>
Subject: [PATCH] x86/xen/time: Reduce Xen timer tick
Date: Mon, 17 Jun 2024 15:13:03 +0100
Message-ID: <20240617141303.53857-1-frediano.ziglio@cloud.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current timer tick is causing some deadline to fail.
The current high value constant was probably due to an old
bug in the Xen timer implementation causing errors if the
deadline was in the future.
This was fixed in Xen commit:
19c6cbd90965 xen/vcpu: ignore VCPU_SSHOTTMR_future

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 52fa5609b7f6..ce30b8d3efe7 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -30,7 +30,7 @@
 #include "xen-ops.h"
 
 /* Minimum amount of time until next clock event fires */
-#define TIMER_SLOP	100000
+#define TIMER_SLOP	1000
 
 static u64 xen_sched_clock_offset __read_mostly;
 
-- 
2.45.1


