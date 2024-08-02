Return-Path: <linux-kernel+bounces-272959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D39462C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E4CB230A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58256165F04;
	Fri,  2 Aug 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCxLJ50q"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB9165EF3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621483; cv=none; b=hplGIw3mxXDnbHdbzg13xFFAe9/ZCnIXG3iMi65IDQBBr8ZwTs92s+O1bWZjI9F8fIw6F+V0+hlKSY7qspA1TF21szYsunz4RTIghegxCWIDipJVgOPUS07J7PYztLuiVF3E+MS19d9o2U+SqVvvzASEdeS+yggTG+uOfRUlElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621483; c=relaxed/simple;
	bh=xsZIBRfdsZwDqoPiwS7SDtWvcLSCMiwnHEu6ibn+8V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCS4KHyPZs+QHBgM7lmkIOdc+TdmngIBIOhhq/ajQdQhzSDeyEnwzZpRkVHiAmv/bQVXQZhXStcleXxPVHQ+bcXuqEAiDnkt6NvfVPhgp65b5lNOalW0/yV0WkV9MglfhLLkr1g6FsBUVZ/R6jtUytbE+QenV7wsGdrzhRYj/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCxLJ50q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc692abba4so64571745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722621481; x=1723226281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz3mcqbqEF89T2wEr0EL29fSOL/K4I+O/30wFmlGKkw=;
        b=PCxLJ50q09DedYMR0TALS8gu56WUUFFh0fUdwyR8Pb4iEbDoFo1sBJWjN3dNJ55/4h
         BO6JU3K5LRXipXdEqO7a4Wjzkv7MfnNzpuwJZVpqHmOiesDCkIP/6MXb5VRWzT+s+sjm
         2DJayLx0W633nO3XSy5v3wSJXAbLqvirYCS2ZNBbdw8K0DFzuYKAo2gvxX5pwKkqEUuZ
         m7cZIP78mfEFCtHtC//K5OG365GReHo5RUZBoctVbDSA8+NiwAqqa2P0hfZXABqCOF+D
         ZUfEsZ9LMGiHwFMHW9aSDWVEVUsC8sEw6EFfLLHN4V23y4++iuL6ZWV6/0IKiYcSBx1B
         bDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621481; x=1723226281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz3mcqbqEF89T2wEr0EL29fSOL/K4I+O/30wFmlGKkw=;
        b=Y3BGvsE7rXiCfG6kAkEdDqF9sOtegbMQbgrw86n2/Lp5y/YR6Ccon/4k7PY3j8aLNW
         bnCzEfPZLurGYihp099SyoyuGrM3BvbEspLq1Rkpeyy1TBwivY8MmTdmjsfreHUFMCqj
         tOdjBpgHmv3QyVVWgMACG34ot0mkJkH9VTFt+1ScoEyASqD8viN4aABiwh+6xulVfbwx
         MByjJ13O+4uielupHbwN+8sZoAVjOb2r5Zo5mHzazLtSqvYLku/G6zfls8SSmXAcNkKq
         nLUNX0z68jmGdPphd8a1qTTiJx3qQcnvbkn4hLWDTpoUEt+PHyUehmcDRbmkihiHZwCV
         dn4A==
X-Gm-Message-State: AOJu0YzWaBUw2slrF0KBvpPdKJFofPgBvlOBckNkMmkEnfv+v54sYE7L
	sAEdAfdIOLGHCFyO58enMNhPi3D5PkMXE0/bQztCRtdf0/bnpfphYfQzfFVg
X-Google-Smtp-Source: AGHT+IHKdC6LauYcl8QZrVe4wBPVqUBNUSNn4meiFx20A9CAPS09TbVGsmONzm5xMU5wHvWmdHTKZQ==
X-Received: by 2002:a17:902:ecc9:b0:1fd:a769:fcaf with SMTP id d9443c01a7336-1ff574dfdcbmr65575795ad.61.1722621481422;
        Fri, 02 Aug 2024 10:58:01 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5713fsm20113945ad.95.2024.08.02.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 10:58:01 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 2/2] sched/topology: optimize topology_span_sane()
Date: Fri,  2 Aug 2024 10:57:43 -0700
Message-ID: <20240802175750.1152788-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802175750.1152788-1-yury.norov@gmail.com>
References: <20240802175750.1152788-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
even when cpu != i. In such case, cpumask_equal() would always return
true, and we can proceed to the next iteration immediately.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 754ad5fa3c99..571759606954 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2368,6 +2368,8 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	 */
 	for_each_cpu_from(i, cpu_map) {
 		mi = tl->mask(i);
+		if (mi == mc)
+			continue;
 
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
-- 
2.43.0


