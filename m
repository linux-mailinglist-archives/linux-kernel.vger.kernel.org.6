Return-Path: <linux-kernel+bounces-173500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDA8C0130
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A861F22D58
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1DE127E16;
	Wed,  8 May 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="cMKSFIzL"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D0127B5D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182969; cv=none; b=NCigID/nHoaCDHTEGhBmFoFQrZBGimuS7eAWid6ziHHVw0Plha5dDJLj2WNOcu+5ydfFameRNrWVdjQFpb4xrOVl8lmCIGGwBu01l9aU7kaIW37HnJADUCFBYuNsTivIErChlkkCuaDoF3VL3JeqnwmT4YXRIvbjB3xtHnp6ktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182969; c=relaxed/simple;
	bh=OlmxU97H7fGCE0UDrN/x6E3kBPtO89G0oBV3GNtOmzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clvqdW1wor8L08kwfWIhzm1cVIQrGWM1MZks9QY2bIedLBJGYZ1gfjNwQkC9r1geKT7fQ7JxDfzWPtHfW1kJ1v1cMTklfL7bFaJwUc7VFGh3SD1qO7sU5r/cpfrTt5Y/YID2PdkqKqWG8aUHuYeemgS+EP6P5nzlVhHvJGX1HcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=cMKSFIzL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f60817e34so5407345e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715182966; x=1715787766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaPFvWaBJIQYdhsiHUu9ZSeDo5ibbdNuJXB0qMv6Af4=;
        b=cMKSFIzLDZsR8RP4kermGiWMl/3NkAyQPzpMO3UNHWJHUbdSG+c6poOfxT2CLtXbj1
         yBhdeuGjNNcSUnVaWFNTPpiK06XPAG9jGqjR3Hq8lRZ2XDLnff2WxhtWwLa9f31RCaKw
         Tq85tsTy6giCc322oH90t70AxyNLEwWOfklVfrn5g4e4BCMzbMYq9PFp4Pflhat8j6L7
         LZOIysyg9/hH1XKEuj+SQ8wWM69IXG86PPy0s5VBCbTdUMQOo7yQ2QYljXDxwVlLukJr
         TLeEUrpBd7kn0m6jOKZ98JmaKycWusiwSqMqiJhpXivD++LaI494CdAnHkOVpmXOAiaf
         cjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182966; x=1715787766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaPFvWaBJIQYdhsiHUu9ZSeDo5ibbdNuJXB0qMv6Af4=;
        b=FV7gacsz9N9vcHewqyMLKw+PqSP1a8SMMvY9SlyKXinMZrccbE5J4cUbeR/tQgm426
         Fq8qrCHTwIXYlGrNgI+aTqUtM/lsf05/DIn1kFsdwxESuKT1bfLNv3j6/OacmNoQUCn7
         YRetWgNWgo4JEbpTbkcaTAuBOhgwA/7XEMx2wMFPEUnek7b6WSxdzagLrbdNj0vM0wtC
         NqqwW+ebqAQOyBbqifCeiQ5F9EqiV5w8a6cE9CQzH17+TSHCv09XLvaoNBk82wLnGsSZ
         SIen8/BL6AJl3Jy8WT5jrqNyAmT0snXM8I+EHOTsQv1CfUBuQMOex0ivPAJwE8FVgucr
         JMDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRORgN0wMUklUnu4x9mhuroD3+YfB1auy28tunCqulVN/3jtoFS/JPBSuv8modMYOYvgBt+n5p4OUcSPT6k3zpcb87DZaPo2CFSsc4
X-Gm-Message-State: AOJu0YxDwfTThJUxgVrvCuiahMRdLEwpNXkXriT6o/Ob6QhFHYClubGj
	Tkx4RCFsU8Qnhlqu62iDGNAVoyTm0ucpWiTHes0hSCBb7vstUTFmyBkBvKZgjUM=
X-Google-Smtp-Source: AGHT+IFvnMzXNaVpMpUPr4Gds+/qp1W6EUUg8hJz9POSy51/PtheNcQayb2vKl2m85P3cr8y/b+XHw==
X-Received: by 2002:ac2:42d9:0:b0:51f:2557:2bf9 with SMTP id 2adb3069b0e04-5217cd48d6emr1798701e87.63.1715182965905;
        Wed, 08 May 2024 08:42:45 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id m6-20020a056402510600b005726b58a436sm7696381edd.30.2024.05.08.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:42:45 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: paulmck@kernel.org
Cc: imran.f.khan@oracle.com,
	leobras@redhat.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	riel@surriel.com,
	tglx@linutronix.de,
	thorsten.blum@toblux.com
Subject: [RESEND PATCH v2] smp: Use str_plural() to fix Coccinelle warnings
Date: Wed,  8 May 2024 17:42:26 +0200
Message-ID: <20240508154225.309703-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <4382b62a-7625-438e-8eaf-137bd88a499b@paulmck-laptop>
References: <4382b62a-7625-438e-8eaf-137bd88a499b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
string_choices.cocci:

	opportunity for str_plural(num_cpus)
	opportunity for str_plural(num_nodes)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
Changes in v2:
- Include missing header file
---
 kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..28fee28174e0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
+#include <linux/string_choices.h>
 
 #include <trace/events/ipi.h>
 #define CREATE_TRACE_POINTS
@@ -982,8 +983,8 @@ void __init smp_init(void)
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();
 	pr_info("Brought up %d node%s, %d CPU%s\n",
-		num_nodes, (num_nodes > 1 ? "s" : ""),
-		num_cpus,  (num_cpus  > 1 ? "s" : ""));
+		num_nodes, str_plural(num_nodes),
+		num_cpus,  str_plural(num_cpus));
 
 	/* Any cleanup work */
 	smp_cpus_done(setup_max_cpus);
-- 
2.45.0


