Return-Path: <linux-kernel+bounces-552124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73BEA57604
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11517A704E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D2259C80;
	Fri,  7 Mar 2025 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1T5v1nd"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9C258CD8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390124; cv=none; b=K8RaTN+ckUAMtXGTbqz+Xh1EyVMhykTTGNIFWmBguO/3YFFVFOlXB6KwxKCFYM/i1P8Qid+OhV7/np200H8hzq1VEgsnYwQO9gz/3mfZlJ1JyNPFNaaS3Ji0mV4lVQU5Fp/FvfJXzCyW+OHvcWoitFwn/DLjOiz32m9yCIwLS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390124; c=relaxed/simple;
	bh=KDNVqr/S/byS4T7wBHLFLKUTFNzAkppqHeaF42sUSNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjcSol+6FYm9jKhXedu26Nx+Q2BiHtlGP+FSrLbfTseOhb4i/Uyb1Q2Y1RjuDYVRRtTBcalfNAtYbPHkgaXfla3v/ILSNxoVjqZDgui2HhD3VCHIqqxL0bFOGcOK37N5wrj2i0tp/hIJu/cRI3RCMFZuoCcy5CXMWRdQdE7iOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1T5v1nd; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3b63dfebfso272208185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390121; x=1741994921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lRPqFGRZw6NFdUejOY/dH/DT35a3CucFgKyNntrLxXk=;
        b=G1T5v1ndOaEQX+YTmxvaQl+9AJDWkmiuVmdBC0vjwMQNaUXaG425PVp0D57vkR+3MX
         UZdd/AEpzqlicxFgCcEY/IoFaLawCNpPMDTg5eroQJ4muBUztLXxoI1IxCwwIdtCBE3c
         yz9wq77YVkdAnIUNDa8ElrYQcnOEuXDn+j9k6creThl9BFvFAuSOysoV66a0ivvZaSSy
         AiFssyAhy/SJd/TuN5Xs5jfz+ePMUpLiAhesnORmb3lLlaeJWOUAzrPcKcFfy9K7GO/f
         HfXmSyNOFtqZVuX0ZszvzmzbOLy83za+xpe44pudYlc5YLoGYSN2rGLKB1xUBiTov8x3
         Ohig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390121; x=1741994921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRPqFGRZw6NFdUejOY/dH/DT35a3CucFgKyNntrLxXk=;
        b=UhHZ7R/7j7N/RjMb4nw23nrutgtgZP6Hdp+TkPGO8LumhVZI0r26lq3GaODgi7k0EG
         90BH7Okr8EL/VeuR9ru7m77zHtqRFevaa3iixjjBBAJe6ZFdGIDAPHMZ8ERyhQJwKmRQ
         IgZKqEfqH4Y+zide0xbB50zRLAULHhaghk6LTAcAO+nli5+vnRgaa4wi0xfx9Z/yicdI
         GdPr/TJ4Wh0bgKzEWB4YQszyYP/qKdGvCKnOPdoNoFvZZbEjHRTSoNEyfLZB5Vg9kq2H
         rJarCOAE8VdmZ0ibPls9tgyCwXw9e3/K6TZ9y+Sb0ANHnOubCk6ZnONqCguA4MKdKzqf
         xAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs33vcL6XYmojTQi934nBgDnMrFbYW8IBFM33XvdZEFYGxZ345oqf2cFVice8NWpkAioF8DhBUjz2zhZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+IqrrrFy6burZlK3pVLhQy9bw5BLyyhcYh7FLRTTBhGElKXT
	KHzJ9rt+ALBcRq6apZZUpSiacxwsJuNEcutfpirDLKhBpcXtX0y3
X-Gm-Gg: ASbGncvQrXyLvTFvD+rdIpBR1pkS1jNDhGbk7CbpfCunUvlc9B+Hj1HnnfFt0hgsist
	UWB1iLVw74v23ZJhAPDKScpvSV5jVdetlbTmnBoHKt1Y2w7n5RK/b283HAi3sBW+oGea8Qwt+qN
	qWlO+hPbjcHYsC5gEdaBa5pTPiJMhMgtTUJK6XZCdGtee5CM7kKQgKocWBgrPvTVZl0coJDR7R/
	aw76jKvTKsNdtqRN/NUU+ihxw1FLLOiAzmrg7UZ10zoTbwoYCrGZPbRvCplZyggTPqWJlIhRsF2
	O3JF0I/WA2hdGXOtQKuV2UPGi2C9uuxT6sv3qaKqiaqE+qTXTOmjO2nXUx2zv+poQB7n+jPZ0vd
	4A0szypAd5RI1tSFRs6JcEqBmOVrm4PgZa8s=
X-Google-Smtp-Source: AGHT+IFyGDiG9sfPUruLtGIwuXWA8Of7BRLMxPCHa7zC6WxZM5GLrB1q8EP1fULDJ4zqghRVSf3fww==
X-Received: by 2002:a05:620a:4808:b0:7b6:d26e:9d89 with SMTP id af79cd13be357-7c4e6178cefmr736471185a.42.1741390121626;
        Fri, 07 Mar 2025 15:28:41 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5381d16sm302866485a.51.2025.03.07.15.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:28:41 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC6C0120006A;
	Fri,  7 Mar 2025 18:28:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Mar 2025 18:28:40 -0500
X-ME-Sender: <xms:KIHLZ_nvAP3g1heUaEWgwOaWz1B5UtJcIMcOTAKsarU_IuxS3_P41g>
    <xme:KIHLZy3_gQDJOAl8QLiaTNcedD_tcL8ZaXOjRUXDPtImJ46R3tD2gcAPPGPHhNlj_
    ZDa1djkNNYnRr-UVA>
X-ME-Received: <xmr:KIHLZ1pseD0Qs4SKDFwNhm9QJnPz6CyUmW4KQlXAqJOEJyB-fVMwCaOy6Qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprh
    guuhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehr
    vgguhhgrthdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:KIHLZ3lqepFcX4QKk3TiikAeU3bwzOi1CZn4l6ugGSn-U7qsf-85eg>
    <xmx:KIHLZ93Plz4qJAkjz6mhI84g5pOgjHOD_QwSo3efbiucdkefhUTOeQ>
    <xmx:KIHLZ2urBtImAPCfwBD_XpXiSU2WxNuMiOtoH1a2Ls8-GxSD3S0Q3A>
    <xmx:KIHLZxWwGq4F0feLO5p0FXJfdmNsxl9k2u2CzDyaGkqxkofyMhM1Dw>
    <xmx:KIHLZ82jnK1gWws4mDoNH9Q2qXDGfFGeRj5MleIiRlSmZNP4zwKKi04b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:28:40 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH locking 01/11] locking/rtmutex: Use struct keyword in kernel-doc comment
Date: Fri,  7 Mar 2025 15:26:51 -0800
Message-ID: <20250307232717.1759087-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

Add the "struct" keyword to prevent a kernel-doc warning:

rtmutex_common.h:67: warning: cannot understand function prototype: 'struct rt_wake_q_head '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250111063040.910763-1-rdunlap@infradead.org
---
 kernel/locking/rtmutex_common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c38a2d2d4a7e..78dd3d8c6554 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -59,8 +59,8 @@ struct rt_mutex_waiter {
 };
 
 /**
- * rt_wake_q_head - Wrapper around regular wake_q_head to support
- *		    "sleeping" spinlocks on RT
+ * struct rt_wake_q_head - Wrapper around regular wake_q_head to support
+ *			   "sleeping" spinlocks on RT
  * @head:		The regular wake_q_head for sleeping lock variants
  * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */
-- 
2.47.1


