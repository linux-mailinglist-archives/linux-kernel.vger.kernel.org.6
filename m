Return-Path: <linux-kernel+bounces-424471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AEA9DB4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A11B21748
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46651990DE;
	Thu, 28 Nov 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M05kyuFI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3119415D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786090; cv=none; b=lOJSboYTLLHez6EhPbVk0fDxFLyXlfnjEX0IV4FVZRKbwk78mjhX2rjEiGr0etkUrHwGce4EJR025rfw0286aqQvVGPWKNMaUMzRfXGntFo/+Y+At3KToJhvTx4KW/BTcDGSfCMdI/FjA4CQvmkmxc1QVKvOQMC4WsWSy0tx6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786090; c=relaxed/simple;
	bh=JuPwY2gAqqhqdGZbJm6EVlqc8orysFV9Bi6yHM6dzlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwstuCroR3UTPD2a+Zjjddwxp8ZX34HV/c68vm0W/0c+baWdvgFrOAiyWQE7eZ7XrHiS49Bj3QbVIeah//iFBhsAOPDQyO/znsYfKAkzO4iagS76QxzrcnKfD/zg97We1BVD825gMcvN1Rf1I8ajJ873bUevT30YW1cZ2sqU80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M05kyuFI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a1639637so5386385e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786087; x=1733390887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsDFxn7301RDaNGp7P8YsoLSZ4PS+XlO69NVe0RTAME=;
        b=M05kyuFI0i0uHqSIYxYzvo+itazAJaG7EjiWGkvf984Cv2vNfuS0kyjh0yfIGgahYz
         Gfaf4KI0ulm0rRUayrI54AeU7k7pJ/m5vji0/SdkyQHtMqv2SOkteHw7bCVxlhWH0J9Q
         Vw6yrCcJ4klMv1HeB2bm7pQM4W2pVsCPCYB1NWZGFJ5xLKBNpYQryROUATjTOqqbelvk
         x6p5LL7KlkNljVF8SoYEMDrFEmpIeo7pClWEYahs3xxEEFcfhLpuPF3XEOKYfinIUV/a
         HQNkB55MK/ZcD5rmhAx1xA7dSk9BAm2fChtzs0TS5Eb1fj5HI65lHSO1sybx82ZQ5Vs8
         fAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786087; x=1733390887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsDFxn7301RDaNGp7P8YsoLSZ4PS+XlO69NVe0RTAME=;
        b=iojwBqXh5E5riUhaPCm2SzuzO+6dypj3uE96PfBXCgG5ux7iCPaKMbAFSQbTtDIReC
         6eYv6UbHfYoHP48Y/Mie92PaGBxzEkfmOCnwBU1CLOsXgmV5BnfnU1zxOCFIjKBte0Rw
         v56Bde+ikFJKkdKMyaI4ecNZBPnRISY3DUO5P74X5/+6quTjyHM7qNOUzWSWIZjTX/6w
         Qcivm0PF72GWQm3qXAHuxjfo50AlSnGCqtrsct2vrE5O8t8Y8PgAfstc8XBpXl9oSxLU
         32BWQeXXQA6reMAjuQZXYEyCB5BcWSIXU1sfwey3AshhwBHs5KWbRrIzhy0ZAiDmT3R8
         ksPg==
X-Forwarded-Encrypted: i=1; AJvYcCWY0vP3PnhAjAu0hR9aAzZCFCLDbeI25p1S76klC9hipu1WHrkSQjnqRmz5HeSBURm7pQCoiwVk4CT5kE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LYvOE9EPC6PeDm3Kfo2vCz8Gykkwg3YnpgjFhTHJwqoee7ob
	llfQgIyTNILX+6r90+BGWhQT2Tl/XspI4Emf6sSZAhAgJFRSO/ostJeQ2a0wpt0=
X-Gm-Gg: ASbGncvKAcsTGSi/1Ff2BaVFVoYkdMLNtC8Vyn75sQ0LMdUa/jF5q3vhG3FfXapK6qD
	e4E1x6XlKjUTM4XqAbyZsAgvab7+6XqAsb5pvRVewg3PprEr0/jq0o4Hiv7cRCNc35x8f2aEeNi
	53G2r6lcHLJQsPJaRGtGUPqP7U+qIZNtdInRSK+pUq9xnybxmHCRUB2Pyy+gZ13PfMReOdqxwIx
	8WsvCXkWh2TT27Ex/ERGu1Y6WOzthkJP9sn3/pDtQnmf2PFK6JHoDo8ZFg=
X-Google-Smtp-Source: AGHT+IEO0/4AaHypX2r4gi9zIhtlVSw3hN1ccYm5g9jBfiRqvJ9+sKDOMYQCIGhR+W2SP8GZT6CTAA==
X-Received: by 2002:a05:600c:4686:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-434a9dbf4a1mr54944585e9.11.1732786086854;
        Thu, 28 Nov 2024 01:28:06 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:28:06 -0800 (PST)
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
Subject: [PATCH 8/9] sched/fair: Fix sched_can_stop_tick() for fair tasks
Date: Thu, 28 Nov 2024 10:27:49 +0100
Message-ID: <20241128092750.2541735-9-vincent.guittot@linaro.org>
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

We can't stop the tick of a rq if there are at least 2 tasks enqueued in
the whole hierarchy and not only at the root cfs rq.

rq->cfs.nr_running tracks the number of sched_entity at one level
whereas rq->cfs.h_nr_enqueued tracks all enqueued tasks in the
hierarchy.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daaa20f01ad4..263e0b9bb7d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1341,7 +1341,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.nr_enqueued > 1)
+	if (rq->cfs.h_nr_enqueued > 1)
 		return false;
 
 	/*
-- 
2.43.0


