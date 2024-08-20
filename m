Return-Path: <linux-kernel+bounces-294339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E49F958C62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BAA1F26ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD891BBBE0;
	Tue, 20 Aug 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="pl/50XDE"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821C1BB6B8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171815; cv=none; b=LsB7lPw2ssgw1qr24VRvQfe69TA0B7oz3yKVy+KAogD1xtopLp5aCpx/k8zFg9vxGTvePCQeFeQyfF+H5dBvUNK2MJNjqqY3Wb+RHBA1CTFBh0YzjiaCb+svPlJHkMR2x1ENcsHZHuyHQSQpyzClW2FxuVs+WJ3zEa2WARAvN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171815; c=relaxed/simple;
	bh=nw2KAMga+N9SBRpuwZhMNhiboc0xudR9Yyh15QBkKfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETU3nbCm3bLaXQhKeJALG0UJw8PnEgb5TKPmKUzrz8phpEAr8psSMJxjMjsGgr8I1Wht7PEXiZfbifubBl3T5c9yhgIOSoCcQpr0wzVlpFlx1Xg1u+3wvieWy087gv3BgdSMBq5eh0pYYfTcoSDZxIjH0CKovAXXA5WcUQTrWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=pl/50XDE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a81bd549eso466830066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171812; x=1724776612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2cahoYdlsFx3NF9sR068SfEnyVTIFV9fZk/j7POxiM=;
        b=pl/50XDENJksbaqzw4PK5B0o7XTiHGuKR+mRP5tKuYaEta1OmQv7i/eD5lK6XkHlDQ
         a/qfJSbzn+aezmGgu3sBOB/ghRpQgJSjHVXk7XrxOWGCHsxT4g7tS0RyKAJh4qfNnDZe
         MrNA2HLqNIk9236txVQ7FNfsYLglwn9dBCOt0xhSRwP02jP7XJZzLfjxPYhqbbUttXdt
         fs61SypRsU8SK/DY47EIbeDI9VXXP3Tj0GH0UdrNKLRgpaneR22f3Sj4BGRC8ahMKkQ1
         PXNEaT3SxDXRqfxmSSiF8oqyCp06nslixr/cvoqlHye8xbUUc+TdxdL2vQRNt7xk+TMG
         r8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171812; x=1724776612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2cahoYdlsFx3NF9sR068SfEnyVTIFV9fZk/j7POxiM=;
        b=mEzptgw3W790Mq+ZjMq0Xy9oBToRhdMYqfJ06aLhKCIP6Xwdi8SgApNOBEQelEgyia
         XYvhOPhF2tSwUMVkinDOkwx1cGuwLtW9M3fESRrUCPHs6BEsfzXTarOaaUFzJU4Sk247
         qRbySit1eyQ0u6Nt7ZkN4TGGs4mfu9gzFm2eiHdixDOJfrL55VtVu6jtre2mKAEDpddF
         K7b99Aw9lUR9uQ1owgbG/y+bvfiEsr7svyhkOXFMQkoYBt9U1XElmAmAwV2AOF4sqkDz
         K5WcJwuuqVg4OXrZ+737mDtQn1ayINeaCncgsXZRjdBYl586fvq8eLOEmyO1J+cGUWc/
         PUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgr2vFwBI/jTHWIHxGAP9s2cYQ8pwEMKWrcScb7hh+II+lFxW9H4fovEhRgExYluQR4LQ8yT0KR5rrkAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/QR4hMtO8Vq6D986mIcs8tndXNk2PLEdm1XMP2hVVG0LVxK4
	AmAp9BoVJljQYsh22pJ02vmYji5ekqCybnIt/Y/pT+7+gbXUE6yJoP44zAaueWE=
X-Google-Smtp-Source: AGHT+IGYJnTxET1FI2CgmIVhGwHAm0Rvsu+OSAWgb5x2sIlIex+roRD/rs+GaRWocmTPkLXygBK5rw==
X-Received: by 2002:a17:907:2d1e:b0:a7a:a557:454b with SMTP id a640c23a62f3a-a8392a47a85mr998867766b.66.1724171811750;
        Tue, 20 Aug 2024 09:36:51 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:51 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 15/16] sched/fair: Enable disabling util_est via rampup_multiplier
Date: Tue, 20 Aug 2024 17:35:11 +0100
Message-Id: <20240820163512.1096301-16-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

util_est is a great feature to enable busy tasks with long sleep time to
maintain their perf level. But it can also be expensive in terms of
power for tasks that have no such perf requirements and just happened to
be busy in the last activation.

If a task sets its rampup_multiplier to 0, then it indicates that it is
happy to glide along with system default response and doesn't require
responsiveness. We can use that to further imply that the task is happy
to decay its util for long sleep too and disable util_est.

XXX: This could be overloading this QoS. We could add a separate more
explicit QoS to disable util_est for tasks that don't care.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8dbba0b755e..ad72db5a266c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4918,6 +4918,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (!sched_feat(UTIL_EST))
 		return;
 
+	/*
+	 * rampup_multiplier = 0 indicates util_est is disabled.
+	 */
+	if (!p->sched_qos.rampup_multiplier) {
+		ewma = 0;
+		goto done;
+	}
+
 	/* Get current estimate of utilization */
 	ewma = READ_ONCE(p->se.avg.util_est);
 
-- 
2.34.1


