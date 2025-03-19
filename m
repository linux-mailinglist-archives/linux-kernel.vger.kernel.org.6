Return-Path: <linux-kernel+bounces-567100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5CA68126
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875CA7A85A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86014B5AE;
	Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c15ZypT8"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF812B71
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343340; cv=none; b=OuU5Jh1axwQW14gB54kAH9uTf/GnoYnpOPzV8StBMpUpwHJ1USRkh0MhSb8jSxbBSKNzAHho83RgzOuK/wXtpwZJzAb5D9BUKxtPNQM6k3pQVpQlWwBsJhkT3kuh+d/rV8RybAY3QQ3HIr4fZrumOG01RPXvR/nvTRiqlZ1/7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343340; c=relaxed/simple;
	bh=F+Fl+hJmeyq3YWzTs6D9ZDaWGOG6IPUOQDfOlysIeuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2P7sWwGdjURUIiGxPDrGHj9XOHRs7BOA/65AVYInKcm/APc3QxKugURWFYI9KRvfnj+4aXK25bQlRQOVKzqvUaVpybwUqXwMrHurjE1ddaM1DSIM6CWsyLCHvn6Ar3fGMmVTjMjdSKJobk+o05mUPIWIB38kT/cmH/gbbMAUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c15ZypT8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso6173239a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343338; x=1742948138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=c15ZypT8L1mzw749Vu6yvbOQWTg1d566iXrxBwFUrtc04MkaXhvFKCRKYekK66oUAe
         hniCMAklfD3Okow66BOahdsnXukn+F4oQMvLgsBOSizEUMOcBMjoBpiUQYnPgv6OUxjM
         DqbVqJAsPDX3z3pJnmykkXGWnIM9tc5E4SuiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343338; x=1742948138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=anIbcMp6TAkTmq4rBKX1MDVVkbsM5R9OTnLaAG8epX7wl95c6xCMTisZO0X48Llm02
         mfJIIel8jaa4XZlbge9n7QO2nvMYnrbAsi+/G/LbgCWLJ539S9D7no8kXtKaLqttRkZ5
         FzIA1k9/ook/JNS/qwMXCam0+IXGX6AgDQH709hc/8q9Lqj6q6fPqcXuBnbqN2LSouXc
         13tGr//SSZ99XqdR6HZWixe5RrZhZyhhnr3I11jbsj18VdHyxwAr8qeUn8kBAKBqXfbg
         duVlSVmE2oHnIYP+yHaKAoBl7EDqO15Iv9tpmIOsV4NaKO5Mfr5p70DHOnE3Km6az37p
         NtVQ==
X-Gm-Message-State: AOJu0YwhQGXHhpgIBfebEsgZwS4NNfdyLsmigYYC/QHJ90NEZfbX6YUC
	NftoTr+yoNN1qzDVZEOC1pIevj3xjjSJo7t+0ea4f3TS7MfchdTbJXSJrDBZ7uE=
X-Gm-Gg: ASbGncvAH2+76NCYXArF1STUEr0tGiR+/TQMlUwjVzN0UXm61LMoSBsgM3WHnwRcdDm
	+VMfuMv1K1Fuhhdg4fgv/vWM3riOCx5eaZmRKLPB1lhlac4yG0vp+CSZlcmVFncL9Rs4J9fxUr0
	fRA6f+oZ85cz6IXMYHpC/T6S2CjEeZNAyqDwWzdLDbeVeZBan8itnM5Od6ZTYYC3v3PYES3x5sm
	DLZE9G7c5cP3V6nCPXFYKpX/aZ8EC2d7XeKBZ9bhz6fGKB9Xrxevi3Nt5UgXppLFjtE5KZtlpUs
	XRrIDjeP/eUtrWa0TaFCzdQPrxcguuElXvG540ycJRDuRjGyRidRWgN6wqtIcqA=
X-Google-Smtp-Source: AGHT+IHkLC7P0qxfNOZ7am8oGQAhk+QCLx5pooxaYbMLyunCN1d9iFhe6ACMIi4+onLyvuY52I93jw==
X-Received: by 2002:a17:90b:17c5:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-301be205cfamr891476a91.29.1742343337829;
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 01/10] splice: Add ubuf_info to prepare for ZC
Date: Wed, 19 Mar 2025 00:15:12 +0000
Message-ID: <20250319001521.53249-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update struct splice_desc to include ubuf_info to prepare splice for
zero copy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/splice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d09f..7477df3916e2 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -10,6 +10,7 @@
 #define SPLICE_H
 
 #include <linux/pipe_fs_i.h>
+#include <linux/skbuff.h>
 
 /*
  * Flags passed in from splice/tee/vmsplice
@@ -43,6 +44,7 @@ struct splice_desc {
 	loff_t *opos;			/* sendfile: output position */
 	size_t num_spliced;		/* number of bytes already spliced */
 	bool need_wakeup;		/* need to wake up writer */
+	struct ubuf_info *ubuf_info;    /* zerocopy infrastructure */
 };
 
 struct partial_page {
-- 
2.43.0


