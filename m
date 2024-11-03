Return-Path: <linux-kernel+bounces-393691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFB9BA41B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B40D1C20ABD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E115821A;
	Sun,  3 Nov 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vv4x46c4"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A42155C8C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730611493; cv=none; b=AAUmxDW7EF46Pf65nsjG/VK7EXk7wx4b4YmHNwpwTRxw2B4uFTmFybhzOXINYDGPFh0wFkPYsgDy5ILcVsQOnQ1ydBFf81pN/lx3SZMJKXwtRcgDtmcD3LnNnKY9pfJmL3l0yvdSOwS3CNjAUU706fA9YlWdCxzl4s08oojQhxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730611493; c=relaxed/simple;
	bh=OodwMsu6GphoAslfKl1LgS8kToCLyqz2m3IDnGDSc7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+7HAahLN8zt7K+57nd4vvCiqrA2GBQlSegOmnTNRV4/NknbwoynPZazuPlDyr74TGFL9cqFksncFRhVMlekW8RsJcAt2qv3W5d7j4Au1nsFrh8beNXuuBdjXFDijIbsyzStsWTetuucSnBGX9W4qEniI9d/l7NyboOFDxC/UYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vv4x46c4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso2180923a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 22:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730611491; x=1731216291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHTcnyI8OB/3G3DumGaoUFWEu1m3gZBmE22QPK1+GKg=;
        b=vv4x46c4oahwA+JLv9LncoteNWzwBIE7TGRUFVINk2xoLozzEByyzcCn5jS7nvHkm/
         fBPjGSlMzDuor7akvU1YMaU4FTHRyeeo7XONzFuvcISRZLhJ71rU1j7SYtyFHcu0YRdT
         1L8/fijo4ya2tuZBWZ/ir7VRRtgzs05CwXyTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730611491; x=1731216291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHTcnyI8OB/3G3DumGaoUFWEu1m3gZBmE22QPK1+GKg=;
        b=AJ9YW/H4zF2oqNdLRJ/2cbryHPIyjR48Y5mWOllUJ0Sam1YGD0ZChr8aTah0aNtqbw
         KBmnnClGC15OeK9ziThAsNctCoG0xIsHiBmX64zo0aZ7tqqPW0IV3cWUmlmASO3Hz2YR
         8ETHw9mJWBWbgmVmBY6DaHxajsLiKyaPEEw4getmFkdBbmDTob2USk/TSzmInamIABW/
         PesgXLKyxlhrKbHDokmegqc+QzoD7nXcSFWB2NdzjbbdNazhvBm9GCXQ6ySId6MR+kRL
         TpvCPk9qKyBSFP4fXaSIH65f62bZjNcxeCrc6Gf2CAe0UvBDctn1yNG9hwvz7/okHC5H
         U3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX0miYcxOH7vkaNTS7rabwB0ATqocB5JNpHolmjOyO2UkxE2QcIVXqdFGMH2ZGenmWXakVPHFbTe4PTLvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/uInXrzquPXm2X37T1Nya7wKjCcNcsj76+jGsMEb5l0Oy7UW
	jTBuMFD60Eomz+rFZoPpuYFfxziyk9QLvBncVZW2ZfYUhWieBkqwMwwjpIc4yEY=
X-Google-Smtp-Source: AGHT+IEKpl/+DA0mVE4NlyIaRJAe06i9+Y1RZpvTFdBsiN/w40DtbzCTo7TPhl66rs5pKUjJQBMhsQ==
X-Received: by 2002:a17:902:ea0e:b0:20d:27f8:d72a with SMTP id d9443c01a7336-210c6cd6531mr373585075ad.61.1730611491524;
        Sat, 02 Nov 2024 22:24:51 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93dac02acsm5896036a91.27.2024.11.02.22.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 22:24:51 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 2/7] net: Suspend softirq when prefer_busy_poll is set
Date: Sun,  3 Nov 2024 05:24:04 +0000
Message-Id: <20241103052421.518856-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241103052421.518856-1-jdamato@fastly.com>
References: <20241103052421.518856-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
irq_suspend_timeout is nonzero, this timeout is used to defer softirq
scheduling, potentially longer than gro_flush_timeout. This can be used
to effectively suspend softirq processing during the time it takes for
an application to process data and return to the next busy-poll.

The call to napi->poll in busy_poll_stop might lead to an invocation of
napi_complete_done, but the prefer-busy flag is still set at that time,
so the same logic is used to defer softirq scheduling for
irq_suspend_timeout.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v3:
   - Removed reference to non-existent sysfs parameter from commit
     message. No functional/code changes.

 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4d910872963f..51d88f758e2e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6239,7 +6239,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
-	if (n->defer_hard_irqs_count > 0) {
+	if (napi_prefer_busy_poll(n)) {
+		timeout = napi_get_irq_suspend_timeout(n);
+		if (timeout)
+			ret = false;
+	}
+	if (ret && n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
 		timeout = napi_get_gro_flush_timeout(n);
 		if (timeout)
@@ -6375,9 +6380,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = napi_get_gro_flush_timeout(napi);
-		if (napi->defer_hard_irqs_count && timeout) {
+		timeout = napi_get_irq_suspend_timeout(napi);
+		if (!timeout) {
+			napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
+			if (napi->defer_hard_irqs_count)
+				timeout = napi_get_gro_flush_timeout(napi);
+		}
+		if (timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
 		}
-- 
2.25.1


