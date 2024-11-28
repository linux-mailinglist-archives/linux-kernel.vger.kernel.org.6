Return-Path: <linux-kernel+bounces-424472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508919DB4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDD516793A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D519415D;
	Thu, 28 Nov 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqPI81E7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D11991D8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786093; cv=none; b=EUuxlv/IrNxKY6PsYrVu2g5bkUJppkITnPIF6Sdh6CPMg98k6JMvXCYoZZpxyw2kFyRRp9vp2PGc/3Ox9XnH2mzNb11W2GEglxLK7ELHr1Yl3yxgrDmIlyXI6SJIl+iCmZ9yWSRyE59sj+TFKYlO4XdFC76OtFUFM1f4AjaPutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786093; c=relaxed/simple;
	bh=MalSzRdhHnNIgF7qDomQeNjDhQnIZpEr/y0LcGSav28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwvJShPvniRDchhMzXMN3c7jYlDFEBEKBKND+kSsxeEZtuCJAyr1/N0QnJcl4YB9df1T34i5DHKCXI2ubn94DWY/NznTA1oaSQ1CizDI7MLA0pw8pDOBikkaZ9cD0SRTBV6JWbC+sU306EUIobqZdREAWzqQ5WkGoXy2GMuXIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EqPI81E7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso513037e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786089; x=1733390889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEypF55ds3j9wOzmWAD3rv+tXWcjl55SaLnSdcxNZ9c=;
        b=EqPI81E7DnAeQiU59mkBHbDtVpTOWbr5RENRbLuZK5SY2+fg4sMHm5hjSxQt+G4JVK
         V0LCOYItbd4e7mrDnnmWM1luy6nV/dtUwA0xA/hE9Y31V/YdMR17jTMnDBUV7p6dRzbk
         4ROLgabHLEeFaf3VvBGtGJ2Doz3jvdiGu1GIxIcloLzkAyhv7UcqH7j/r1rPsR3GYqme
         +HxbpgPytsLmDwp7/2yNwxAI5q6Ns/QCKjE9uh+40dGWCqUHUUSWiO717LmA/8SLOyFL
         ba3VVk5iV+aTEfn6BOOjpAXVgrVo+nRTGjUQ9G23PDU7xhPDyhzD+UIOcEU77Jt0rBfj
         MrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786089; x=1733390889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEypF55ds3j9wOzmWAD3rv+tXWcjl55SaLnSdcxNZ9c=;
        b=R1cKecAGwbBWnkXTjjpA9uMyQORs1oD3JXrHPeyViHz/yLx0btWu1xDmA1dGsiw1zf
         KdWVSVj+HyQsKNnL48Sz7oJz6vcyzauuxOPIIful+U6SZb3rB6LQU2uPZWpXQpn0xuqr
         73VZ2nV5wl0YwXVJZqiCE/HdN7cxYDRpm+bqjFqiR53PTpOPF5nLiKlLiHM5BP0F1AqP
         nzeFwEV7smXEsT7A+gaYwpSxYwAtfpeIAwDUg4A1I0pSO+cLbi+gFmWu5wExpargpT6/
         ZZygVrd4LPt8JOCBLfXzvAbChHfnsS2v0OBpC1PmhMKxITxiWx55KyPkMcZxWcHkh8+3
         gCag==
X-Forwarded-Encrypted: i=1; AJvYcCXQUXFs8U7uovIWJQloN19rwhlp7iL5pH9EnQiKW/hH/BVhsUT3SuAMzMvw54UKOTyWXMzKBLOmEFGjd5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+Mlav7E2KCqXc2qnpAM4UimHeXmQmzVvWRVMYCC8G6OXu4p8
	tzkcdB+RsVbk0R2r7UKru5enVPrA9CUYRhOqANsnAiEBtvoK9DBIvaWKKpSxVjE=
X-Gm-Gg: ASbGncvU8z1S2ioZR9Y/O/VHIxBCSAjSDJv8nbsVdkj9WYCU0r+omGXA0XhH3s7Rqjx
	XUIdVdng90ZfO0Gn/qOmlIenkXNvFqahGtRf3ixqfiIJZNEga39lXlxRFNy3ahVngUnkcqVkRcw
	8illJQcPIjRPdYBNt2QyaSOnBQRdtXy56cEVk7C8NWZ3Q68DFfmZ3QQ10lyekHUUpXRRKBktvTP
	l9j3DtJdyOPlSdvUpLIShCkYP258Iy2TRCIO4labh3ZK6PQychrrRvFsJQ=
X-Google-Smtp-Source: AGHT+IGOUyYRWfkeWgbwmxJcXBx+7esuhZ99GFV3NPzvQkdwUeRiEJlB4qVMDGTEuiYfV2DackqQFA==
X-Received: by 2002:a05:6512:3d8b:b0:53d:d957:9f93 with SMTP id 2adb3069b0e04-53df001e8d1mr3345550e87.0.1732786088078;
        Thu, 28 Nov 2024 01:28:08 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:28:07 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 9/9] sched/fair: Fix variable declaration position
Date: Thu, 28 Nov 2024 10:27:50 +0100
Message-ID: <20241128092750.2541735-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128092750.2541735-1-vincent.guittot@linaro.org>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move variable declaration at the beginning of the function

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d80f3a61082..47faaed3ad92 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5632,6 +5632,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se;
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
@@ -5642,7 +5643,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 		return cfs_rq->next;
 	}
 
-	struct sched_entity *se = pick_eevdf(cfs_rq);
+	se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
-- 
2.43.0


