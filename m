Return-Path: <linux-kernel+bounces-395606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247B9BC072
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881A11F229BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1B1FE10E;
	Mon,  4 Nov 2024 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="taWpFtIV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30CB1FDF84
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757417; cv=none; b=W/FYzMceSL6AJqhs/EjI5SpwAYoQUzSlTcsl4aD4d0pgilUGOtzYu1qxFiTqPJA2IxKmev5AmqNapv2yfxAZiwO3Sc2fVqQcIhqjRXrvn2YIwQyV41CvKxToyyk4g+httLfkzHEBMbxJBvNb9XNKHj7YMXDRshKa34/Qz0nrhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757417; c=relaxed/simple;
	bh=tXmbRF7JGULYsZzWA5kM9IZCbzo0EHRzhvKrW+Ho9eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3ljH4nYfTp2+I20fDbaZNHigetDMOtzlrUPiOKnxLo9WRAvormoS1+xVChJLvqhEyGRRNTGp5rqUjS2+kbPH6p2DULvZh67JwI//Vr3wAuua/yWPpyYA9kQ8Z77naJxj8SpnFIq0J+sEftTcY968gk82w1gkhBoPgAvz8xpqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=taWpFtIV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c803787abso37047235ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757415; x=1731362215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHqyHgTj8Yctl5o5QmypsxoBptb79nPdd8vssXFP5EA=;
        b=taWpFtIVh6mcztJdhULO0QDu6BTez/MOWY9vy7xVqQAPVUzMubsH/rlDwag4wqJsQU
         jdZfbx1Qf5uyJib/X2jd7m86nIok1dvac0uqaqkESDGQSYEZJD4l0eVKVXufngJfegUe
         NBY7L9c57Y4GICN2wDYVcdo2PxvFAOfg8G/jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757415; x=1731362215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHqyHgTj8Yctl5o5QmypsxoBptb79nPdd8vssXFP5EA=;
        b=WlLLFCAOk1RDH/WKkGOxP9qAcxyeZrHbh7iXY7orX1qt4TCj6BK6FijwXaKQlCaNRJ
         SzJIa0mWHOnAK62aIo6LjDVZgSdHinp0QK87BrY8Q00Iv5FiGWxdPEP9BFV/c1MUrWpw
         MY4bz1rf5jpTWJWQxT3OAOtmFrkFHu+upypXyauluQadR2xR0w84G/E034gwKDMPMyi3
         U6Fu/QD/Q5o6PysKoiehZIPl+4+sn6+ytWQIhHd7nMsY6q51H9/JXvlOmvJBeyZtPLaX
         hIySVrWW4onMbBxKK55nR2qYWcP1rFkdQ36Ya3CVYsoMYsXhr3F0UmomeELG3JlJtGhw
         MOEw==
X-Forwarded-Encrypted: i=1; AJvYcCXaWIlBes/GmqfDjJ6xHuV1D5/xe9KWb5V6dvXj0p5aw9Jnjqrmfrix/2VsGF7If68XL/tvDMYGU+7ue1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzlIBJaQiP5sdpRpbFoAAvd+HvgpZ9T5C9qv3uMY+Vp0TXnsD
	Pygxt3dnlHgxeat6qJGEhVEGUzV1WQqCK1CzkJsa6OMY3uU87XtBTGbI36F2FKY=
X-Google-Smtp-Source: AGHT+IG4On17GabDHBC3yACoyI+WQMOVq40oxy4XmgSoW7mjsUhDj5n65cNYrCv07168lAziXYJmbw==
X-Received: by 2002:a17:902:ccd2:b0:20c:9026:93a with SMTP id d9443c01a7336-2111946831emr232382795ad.19.1730757413554;
        Mon, 04 Nov 2024 13:56:53 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:53 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
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
Subject: [PATCH net-next v6 3/7] net: Add control functions for irq suspension
Date: Mon,  4 Nov 2024 21:55:27 +0000
Message-Id: <20241104215542.215919-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104215542.215919-1-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
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
index 51d88f758e2e..9d903ce0c2b0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6516,6 +6516,45 @@ void napi_busy_loop(unsigned int napi_id,
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


