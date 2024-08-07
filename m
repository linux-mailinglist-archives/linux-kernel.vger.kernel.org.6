Return-Path: <linux-kernel+bounces-277422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE81194A138
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68765285DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232941B86C9;
	Wed,  7 Aug 2024 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWdsHlqE"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57B18EFFF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013936; cv=none; b=sDE6096ZhjzSW4zsaBYyz2rxNzj6ecAmUUuK46AoeQPTOkLSrmRWNXS4p+3SGWglCOt/xa7LF7BFAW4vpz8TBzViwr2IH+4Ch89SpcPnA5Kf/E1pW74Xs2kPdMmQvwWRjuC6C0mGgO0DICj7+27hTB0LpUvAkE+C4yX7OUgOqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013936; c=relaxed/simple;
	bh=LhvFeWoIcgGvevHW+ftioPdfi1lUNTbrRlJ78aN6KPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ux91btNpv+HGniMiHMyb98mmRb6t4cVzuS4qMdMHR3Zn3Dts6OynsSBeID9u3vZ6vavv46QDgsTLgo8l/cUrqenA3Q8CdzET0kkT2OZwC/RfvUNygLXdTSnYLKfv4odiWnHabwhBzkGLVAuwtZcijvtFd1HB9iCJOKVW6U6I2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWdsHlqE; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-49290ce47c4so315927137.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723013934; x=1723618734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvvNjFC162A3uaPqlLDXCXylNQkLLkWnl2yOe9Ohaxw=;
        b=TWdsHlqEzp2SVbzAM0caFvbGLkK62BBs4lXA6Zox7wJ6vEeTu+mXJ3lxRgdPpqSkQM
         ha0WGxfgHJ5dMAYq71m3nbAeJWoSpEU+QP1OAkRrFL6T93nsWIePOAv8YAFJSXpCpwIn
         Mxa/VMiPRu1x9QenmwHl6D5ux9eA0LAmtsWLwBR0vPcZifFKFq36dDGx2YV3KGodGB9T
         tTedo1elzF4wfVhAiZZXXvPiGHlmmorBADELNkgBKCFEra918+MoYRhIYnmOJyoUq9Xd
         FkFbYrv+z174rQXUB5VqG70xTotFIIxQs+Axi//yMUx5zC+rkm54k1IRkPGdzMua7SNr
         gzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013934; x=1723618734;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvvNjFC162A3uaPqlLDXCXylNQkLLkWnl2yOe9Ohaxw=;
        b=vVhLQAQ8KrnWn3pzZ5GBriXCCY5bOaOQQekdYjS3aAr4nH/JbGypUOpjT9SS+pVhZb
         JDUaPR2wFBG/vL5sRvIu5Jc/azQfCyoUNbwh/Eq4ADWjalSjZ33YwpPkxszKZwD5iHOr
         lX+5z31ELMX4d35eybNTnOevgwi2m3pjaRGQ/lLoxRUvbAWG2TBJ3ZDdkmrqAE+PBc6q
         8JB/A9q0kiBDBpbZKAcUke/N3v+jDpDlDx9ch2HOMv+DoY3vsw50DiTS+quQFSISN9fN
         GoDOBBzn54y+w9tGFm7xrSLmU+A66FveBWnZpz5EIDDFs1cJfDLR6JBqVJYH7PkJ/S9i
         EEmQ==
X-Gm-Message-State: AOJu0Yw3t1aI0O/hFNTECA24lyJ8A5yh9DsEIpo910/RKaEFRDbwmI65
	veUD1VPtyiksTzsmmuUu1oBqyGEfEQSNbYamdUTidcI9ijqpp4Bb
X-Google-Smtp-Source: AGHT+IFhQygZ0qV0cIuV9BS5q6P7bfRFkd4kfUItbtG0jem5ecB62SZ/BnZg0Ewdo6z6ioXIHrmduQ==
X-Received: by 2002:a05:6102:26d0:b0:48c:37c1:34a8 with SMTP id ada2fe7eead31-495b8257212mr523509137.7.1723013933540;
        Tue, 06 Aug 2024 23:58:53 -0700 (PDT)
Received: from fedora ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-83c0781a0cesm1529541241.5.2024.08.06.23.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:58:53 -0700 (PDT)
Date: Wed, 7 Aug 2024 01:58:54 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	mgorman@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: Fix lint warnings and errors in deadline.c
Message-ID: <ZrMbLlaFaQ55hO_a@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

- Remove unnecessary 'else' statement following a 'return'
- Correct code indentation to use tabs instead of spaces

This change addresses the following checkpatch warnings and errors:
- WARNING: else is not generally useful after a break or return
- ERROR: code indent should use tabs where possible
- WARNING: please, no spaces at the start of a line

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 kernel/sched/deadline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f59e5c19d944..5b945a64d00f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -158,12 +158,12 @@ static inline unsigned long dl_bw_capacity(int i)
 	if (!sched_asym_cpucap_active() &&
 	    arch_scale_cpu_capacity(i) == SCHED_CAPACITY_SCALE) {
 		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
-	} else {
-		RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
-				 "sched RCU must be held");
-
-		return __dl_bw_capacity(cpu_rq(i)->rd->span);
 	}
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+			 "sched RCU must be held");
+
+	return __dl_bw_capacity(cpu_rq(i)->rd->span);
 }
 
 static inline bool dl_bw_visited(int cpu, u64 gen)
@@ -1321,7 +1321,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 
 static inline void
 update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
-                        int flags);
+			int flags);
 static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	s64 scaled_delta_exec;
-- 
2.45.2


