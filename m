Return-Path: <linux-kernel+bounces-228753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138B916667
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C251C2878E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5531415624B;
	Tue, 25 Jun 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A63mRVtH"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E71553AF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315796; cv=none; b=HpIOTk6+xRvrLvpj3Z5njbVbqcqq0B1980KsUEmc1gWAYLJY5fZ2f/ZuvGURJGtk0uDSxivEWPVvYYBb/KQug1UFi9RJ7nGWhIv4uxqlur+zovi9oGLw/JBWevkWSJ1trAI2gnGHGjt4WJ32xV6m8wPQRLQlNMJldsIhFeCM0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315796; c=relaxed/simple;
	bh=1eOgL4cfAMljELnjAjinh7SrzTqU4VK/mnGfkMlWVVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIEw/XETyK+glet1EkDeh0PbL+qowKhN3A5VglYCOaxUJTL4pff/xT4N7FQx2UPnIJVw2oy9pUeEkAJcCD7kW225XPizJhQIamkSfVIxYAJiIJzngPOEwmkGTWvELC6CCJNI4eAKLBKMvgHxUYdmCcFArKVAnq7c+IjrqWssZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A63mRVtH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f65a3abd01so43750215ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719315795; x=1719920595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ut/C6qhA9aOwITbcjH8dIajqyGZCkEHhPgDreABlew=;
        b=A63mRVtHCQ+WyZ/fndhX6EdPXZsBzHnowhAu1I0yzU/KIsoDtQji3P+hZ+Jrd5b993
         2nlYAlAkQat+sjh9y/+gix5YLHf3JMKA4e3wDfo477hcST2s/6lqSpby14mC/+CQu2Ab
         4zVLHpDPt16GUhmI37keRMueddOcykotYqYpEN1FEyLQNP4STmIbkOhi1lB5+1wrnsUb
         7PRz2Yahjirgv2GqymZ28c8ezIt94qlEAFw8JZDlsTfCIInQDTAp0dX4xOlEzgTvJsdw
         rvpe3XdSo/AWL7MlT0LIb7FpUp5YsdMQAjSu8kdS4GJjAt0v6MXjcNF4EXhq6SkHUDVM
         9Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719315795; x=1719920595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ut/C6qhA9aOwITbcjH8dIajqyGZCkEHhPgDreABlew=;
        b=Ag/1SQtQMt1M0PzvwVOlVKWRb/e5CTyBVce2Aa1zjbmiVJub4+R7nrrbr5pHKN4Z8M
         L5Cz+x/1cdlicOzOQFi6Sp/NnqUgoMwVQdbSKMaZMPYqfAbDzIwxh3B67WSPomZAyoFi
         E3G6recrVDC8djEsqUksZHMo7bRHnQ9lJHcSEfRnMG29cGXEe1A1xtCc3ldrzGopd/K/
         fpF1m0CH/9bbioAIeAcmRNvUPf4GQsYk3+NUsj30WtIFb7gQLN91O1coQYkSTVWPvdv/
         d6CHlxgvV3oBkJptjGfa2oDCAPckvc4qrM/y4gIwkOWQoYpe/SuAje06f0pteJed1xLL
         OAaA==
X-Forwarded-Encrypted: i=1; AJvYcCUsV042WtqR+ROiGbqV1JGcol2JUTuGoSrJUYuW0rveXuIgWazk/4UqfwdFo61c0NEUC21+3qErVRSrRgminPV/Yh4KqkHgKIE1XDxv
X-Gm-Message-State: AOJu0Yx8w06AF22kw6S+XVKDbHIISS67E3FQ4kilgMPoJJtjEJYugHvw
	q9M3VCVov6PJw+ShkuwxVOlDONMMga/X43sQVZube6Gk+X5qd5qS
X-Google-Smtp-Source: AGHT+IGSAGczVwLSd1GZrjMQPgs8n8ea+P8Fg9++dGsm24hVGUX2QdMSqhOgaBAS+lj6bPr0jrTxIA==
X-Received: by 2002:a17:902:6847:b0:1f7:123e:2c6f with SMTP id d9443c01a7336-1fa23ee5b60mr70122115ad.37.1719315794786;
        Tue, 25 Jun 2024 04:43:14 -0700 (PDT)
Received: from wheely.local0.net (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f028asm79638525ad.3.2024.06.25.04.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:43:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] stop_machine: Add a delay between multi_cpu_stop touching watchdogs
Date: Tue, 25 Jun 2024 21:42:47 +1000
Message-ID: <20240625114249.289014-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625114249.289014-1-npiggin@gmail.com>
References: <20240625114249.289014-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a lot of CPUs call rcu_momentary_dyntick_idle() in a tight loop,
this can cause contention that could slow other CPUs reaching
multi_cpu_stop. Add a 10ms delay between patting the various dogs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/stop_machine.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 1e5c4702e36c..626199b572c6 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -243,8 +243,18 @@ static int multi_cpu_stop(void *data)
 			ack_state(msdata);
 
 		} else {
-			/* No state change, chill out */
-			stop_machine_yield(cpumask);
+			/*
+			 * No state change, chill out. Delay here to prevent
+			 * the watchdogs and RCU being hit too hard by lots
+			 * of CPUs, which can cause contention and slowdowns.
+			 */
+			unsigned long t = jiffies + msecs_to_jiffies(10);
+
+			while (time_before(jiffies, t)) {
+				if (READ_ONCE(msdata->state) != curstate)
+					break;
+				stop_machine_yield(cpumask);
+			}
 			if (curstate > MULTI_STOP_PREPARE) {
 				/*
 				 * At this stage all other CPUs we depend on
-- 
2.45.1


