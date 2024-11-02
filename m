Return-Path: <linux-kernel+bounces-393087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB09B9BB3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067721C20FB1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FA13D520;
	Sat,  2 Nov 2024 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xOxFoGD6"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C613A27E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508864; cv=none; b=GumW6Est06fXutCEcZ1H+L+ZS18tNAHG3+zLOWeAKvjGZa5nhplmnufFkCeQse7QIxXfMjRFJcxQ+fLdrt8m/fzDIaRMGvdmy0OX6+NEmW9fEZ8fYvUDOMJcCW/mBivrz3GDeEvQYVucrdj9KmUtpm3bcMUNq8TYk0cJH2UwyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508864; c=relaxed/simple;
	bh=PWViL6q8Ik93O4ERMxXS2gmZYAwGt4r2r4c5oDTCHHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NI78nKrRvkOWlpS5i5xVCkHHCPwc44qalqALcBhZHavHuA/ztBnGwvNgiyhjdDK9DXYBAL02lYWueWObFweVSe1hgjFHSTRDLbhmm0zw6wWfJ3KF3o7a7y2Pxo/Y1xsTh44acrARmLCRVwR5gXvesQ0Jh1YEunqZMcgwzjmgkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xOxFoGD6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72097a5ca74so2262579b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730508862; x=1731113662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cowMVecIc98twj3oz3N3KSXhshX1IlkBIcMXBfIIcK4=;
        b=xOxFoGD6gC58ZEy7Uq9ySEe2hK9AteQrrHK9EPGF07DvCCB9XaMq/I/4edJvk2SnVG
         PraoFGNDiQwCt4NJY/3OZjhichindbBEkO9amM+jJTu2fBSIhSvn8AHHhKK6GwwXTZ2b
         dquZUReMhmzl9QRrG97iCoCfszkfZtd5u17Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508862; x=1731113662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cowMVecIc98twj3oz3N3KSXhshX1IlkBIcMXBfIIcK4=;
        b=TgzzMMkchx7Bikmc4U6EADfd1gntHRJX1/LlxROfXFboce95iru3g1zGEyoW8Nk7KX
         YKQUv5seqsseoTjaOyTTK+Bq61DMRGD2zkdDTzbUQciKn4sqD9yJ3KpOFr5spB+IgUMp
         wWH1vhbWzol9KVk2nI9BIZJP8gTSs28ksjyaix3WOIRH5b0SV7n6RZ2k/Yjl9nFxhgQb
         HqqAu33UrI+1DkHJRz+ie71M+xCS4tRsnI1Myf8lvMrL+EPyHnx3bgpSiwvNx7FQc0Vo
         acO+2rRQFV1S8/EukNeaeFAcmYpAj3Iqrw1KpAxyrf1FXNqt62Ku94EDDqOROUa4Qm8M
         2VmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI6FIEcVuJtzGX5UcM3e+rii72tRe4i5VVgOHopY1XMpB9qu4/zdR6JhDDvO5RRp+NwRHkqdhEG3RlgVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTGuc1O7P3+d8xfmWUuGlekzbvoSdx0BV3UgNEutOXSSU27lx
	rtcScTP63sdTvHYSoi0D5c1w6mv5enKiAtReTZ1S6fivgZC1n+wuh7an8vMYtPk=
X-Google-Smtp-Source: AGHT+IFr7qZjgfjWh1ZeX1UrAInfHBp8hSAl5n/18pjKlhd/LyE+tXCxBx2zpn0LXs98lHcOVThdsA==
X-Received: by 2002:a05:6a00:a93:b0:71e:f83:5c00 with SMTP id d2e1a72fcca58-720c98a19d4mr7356126b3a.2.1730508862448;
        Fri, 01 Nov 2024 17:54:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc3152fesm3274549b3a.195.2024.11.01.17.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:54:22 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: bagasdotme@gmail.com,
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
Subject: [PATCH net-next v4 3/7] net: Add control functions for irq suspension
Date: Sat,  2 Nov 2024 00:51:59 +0000
Message-Id: <20241102005214.32443-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241102005214.32443-1-jdamato@fastly.com>
References: <20241102005214.32443-1-jdamato@fastly.com>
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


