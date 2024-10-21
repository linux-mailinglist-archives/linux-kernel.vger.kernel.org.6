Return-Path: <linux-kernel+bounces-373549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087499A58B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE84281123
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73CE74BF5;
	Mon, 21 Oct 2024 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JvfTU+Ys"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616B54BD4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729475640; cv=none; b=u0LVFGe1v/YdauxxMDeSK32NNQbGdNCVyLTJtBUa07eUygLK/BZ18ExpsmhTM8PRcGK5RJEfD0dnwYb4Y6iAoewE3n5EPtMQaNq6+CdUT75nivAQQr2ux+1+BxsqbUAIu3MFTPayaZ6IkJUqRCX9oAL+vfW9spU13T8judu1PpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729475640; c=relaxed/simple;
	bh=fNcofMdMGqSdkpD7cvRXzDTPFTdNqqwK2UlNXiWtTNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDjksuNngLUi4BfjRLuj0mjlDnvEVWWQdmtJm4K/8xfP5cn14KEDiRmAeMkwHtmPDUuzQ3SM00/4d4nLCBse7eGvcvgDyxkpRDxSahwpvo1hzkY8y3i70TXxm3VRAATqXYXeIJHQlYDwAJV+MthcjL/MlQZ/C86B8rB7c1exPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JvfTU+Ys; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-207115e3056so30921315ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 18:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729475637; x=1730080437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FePUDPVukA9o3l+UniZnQUedPYlrvLH3uHGO+zGSqIk=;
        b=JvfTU+YsliO/DYqIBVIOHGzeWWoFl/dssMDMKmIAz+j/9ez7j7kukXKPhYQb6Z2tWg
         BNnqC5nyhhegkGbg3lZTJ+lh9MxL53Ekyn4GQ4CDuirErr6Bqql9Hg62ALnzPCob1/kr
         SLPWOum86rtBZH1FRsoF+Wzsqklsn8OaGSCYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729475637; x=1730080437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FePUDPVukA9o3l+UniZnQUedPYlrvLH3uHGO+zGSqIk=;
        b=BWvo3kTGtrU3WB9GvmbRICFMJhuZdOpF9s8qx2OXNJyCi1lOW/I6ZQdD1evhZgWWJE
         b2xkHvmeYqAqoYKjH53LEivjKPPMln+IhqtYe4fn8cXkhwa48AqIcx+Tfg3JaRTh+ScH
         BIhiOlZeCqcpBj2N3PsQNEH9K9bUTesvIwnhK5nXE2dfjh+AtRKCnK7gBr9yINhkVRCE
         Xn48R2nrwg4siCqU7fVrlJuqztU0ynTrjEb+Fs0N64swCCUUqg/ph5tyym8nXL3mFIZq
         LWVKtMqXm/NZKRITM9wKgo18mVRJ2TrTbRUoUn3Nm7lrFX5spxMAJ8TYo2Y7dxMgrP0X
         yQTg==
X-Forwarded-Encrypted: i=1; AJvYcCUqTRGOYeuUf9TAt99m79wL5Z/3g/kOr6XLfA5OO+zB859PNc1VoMIlscAi6JiB2AcPdaJjn5e81XSK7nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTACxi6BihejWuNIODMK5m0sxWnoHXpE1ATPkXlLf4NNHqpZhP
	b8JESR52zxkSsN2356/3/ZwzFTNBFv4pwtXjnxSTeeKV3Cm1ahqhEUiNYYuDfls=
X-Google-Smtp-Source: AGHT+IEhfBRZa4e9pXBSkhlDjOdj0kT4hP3ReRxh8NImFNH/yZPYPV6MnIfG85+rxL+mQSbyDRjkwg==
X-Received: by 2002:a17:902:e74d:b0:20c:bb1c:d216 with SMTP id d9443c01a7336-20e5a773ebbmr154528285ad.21.1729475637501;
        Sun, 20 Oct 2024 18:53:57 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee650bsm15859985ad.34.2024.10.20.18.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:53:57 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: namangulati@google.com,
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
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 3/6] net: Add control functions for irq suspension
Date: Mon, 21 Oct 2024 01:52:58 +0000
Message-Id: <20241021015311.95468-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021015311.95468-1-jdamato@fastly.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

The napi_suspend_irqs routine bootstraps irq suspension by elongating
the defer timeout to irq_suspend_timeout.

The napi_resume_irqs routine effectively cancels irq suspension by
forcing the napi to be scheduled immediately.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 v1 -> v2:
   - Added a comment to napi_resume_irqs.
  
 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index f03040baaefd..c858270141bc 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -52,6 +52,9 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
 			void *loop_end_arg, bool prefer_busy_poll, u16 budget);
 
+void napi_suspend_irqs(unsigned int napi_id);
+void napi_resume_irqs(unsigned int napi_id);
+
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index a388303b26b9..143b3e690169 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6512,6 +6512,45 @@ void napi_busy_loop(unsigned int napi_id,
 }
 EXPORT_SYMBOL(napi_busy_loop);
 
+void napi_suspend_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		unsigned long timeout = napi_get_irq_suspend_timeout(napi);
+
+		if (timeout)
+			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+				      HRTIMER_MODE_REL_PINNED);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(napi_suspend_irqs);
+
+void napi_resume_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		/* If irq_suspend_timeout is set to 0 between the call to
+		 * napi_suspend_irqs and now, the original value still
+		 * determines the safety timeout as intended and napi_watchdog
+		 * will resume irq processing.
+		 */
+		if (napi_get_irq_suspend_timeout(napi)) {
+			local_bh_disable();
+			napi_schedule(napi);
+			local_bh_enable();
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(napi_resume_irqs);
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 static void __napi_hash_add_with_id(struct napi_struct *napi,
-- 
2.25.1


