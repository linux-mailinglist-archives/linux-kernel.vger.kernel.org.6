Return-Path: <linux-kernel+bounces-448063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA99F3A91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D075E188AF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D51D5165;
	Mon, 16 Dec 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MFGdYbBB"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216A1CDFDE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379997; cv=none; b=qOccw1elBH34iUJ8WqXHj4o76xCwSHkO/x+nWMOgut2DxvOmWYagaiypDmELWEdS8kReQ0pEBt2qvD5/eSWJ7eLmfCAVTcQbQZRJByL30EUPdgZGhulahjKNWdLN037pnUb0InAUb5+OM1Z4boUkLZOm96MfRBs0wkhZJfkXWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379997; c=relaxed/simple;
	bh=MemPLMXdk3uWnJs6gP0DQZ23rUlRf5oFXli2ZPMpwBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9mBomOhg52hDy0VI3s6q1G3/itppz5iZy5rR8M68Fk/THFMjYnctsaZM99iROtBghIVd+nDUAm+NeT85PLUTnE1M46GF4G/zIW9UferonooJnemtimdxBYOSPV30j2Fnb3/VNCSHwirpDJBeonMfkjCOWfeT5PBJ1Ir66Ycus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MFGdYbBB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e87b25f0so3661876f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379994; x=1734984794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykUk1nCLfLYbgO6G1uURbaiHMeIrcr+xR9t27WM8uH0=;
        b=MFGdYbBBrxlathNLnbnI3sDz4DiLXLnavDBvvwYiL5NXgLpIUbRtPqJj2xcrdCSAzY
         4eA9PxlEO8lEC9Hy4K9/XdI+acNos5dbVzyxnUi80guhC6/Qv/s3iuszMrUCRnmYiMoO
         vHhrswPCeflHTzH5NW2CDF9HgQeRwVR+qn/v9gIH4KeW3btv4zd02n07xKpO1l24jL10
         TqcOGcoqGcXiI5Oo8EYoWkCIa0efcELv/C3a2YBvCaOhk2KGTMMJAmI+nwF19R7/rqtO
         j+QeEuvy7Vua0p2j0uZCAAdFByOhPYKHb/WuqHBSUgUGv0OnQTvnMNPKFS5SKsU+s0aL
         RPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379994; x=1734984794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykUk1nCLfLYbgO6G1uURbaiHMeIrcr+xR9t27WM8uH0=;
        b=AeqOsRJ34q82G4DJ/6AjIy9WWuEq4tqs1RJrouSZkoFX4777Rn5N0cRCcGfbm7747m
         GBz16apb4hOUAlQo2MXllWcXg/AeNI/b/go+e3cPRBND5yzwcaqbDh7ib/7AxqqgW5m4
         8E7xhh7+m4lCexq3Tl2o5qf1vNMkZMHWElA1CP436xkwkvPCD8vGt0s7LpdXUu9CKPd2
         k6Jsz54aluty1ZCPN8y7vcN7YKd041OUOZdaJuFwfodh9twFx+q8Nz6DFViVUrMBR4oJ
         Qw2gphiOEjBI9zsVKoNqzXIXPyUDLdBQZBKFVrubz67mcQzsvf8YFIILDyfaVVjH2MFO
         Rj5w==
X-Forwarded-Encrypted: i=1; AJvYcCWBUiPbqH3RZuvpRPNClp4F8jQ8jQssdzS9LC2NjblE4q+jDcj4dHVK3kwKFhETYaJ5qSRNgZgl1VC3QEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcEfDz+oc/5/IFpxC4LGLPIO7SFG0KuCxelHV7yAdoh8EgTl1
	uC2E7tHzlfJodcSfG22xojVeW0YVRjJ2w2CCoo57ZaB4wyaEExWMlPC2JuIaCVY=
X-Gm-Gg: ASbGnct7z0WjPduWRZ/+U0gbPso9az0J9gn3AQ23Yz7FyildZ6boQqgMNUUYbT2Na6Y
	QF/EV8WtLNcW6Kg1FdCYHAs7KeLtBAfy5xyt0f6MDUEYSN/Jmq6E/gso7lvLzk/Pr8/2PT4ifhJ
	hj0b5CXZ1+o0HnuuSzaJSb1RPzWU59j6zrWEYau0FzG8YN6LIJe6NFtEBM8RhEXD0MTyWhFxCFy
	kzcaymiP2fDCeR14eY5BYdPBCXCbxfb2iYQD+oKCq91QvmP4eaE1+gaYQ==
X-Google-Smtp-Source: AGHT+IEkYdyHI1WGeTQVT3vTd9OrSkaJ/xGHM0dboeckZ2SBEOCxX/VzsSBkp7vOrSwHHiSIivFM1w==
X-Received: by 2002:a5d:584a:0:b0:385:f892:c8be with SMTP id ffacd0b85a97d-388db27533bmr583056f8f.23.1734379994063;
        Mon, 16 Dec 2024 12:13:14 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:13 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 2/9] sched: Remove unneeed macro wrap
Date: Mon, 16 Dec 2024 21:12:58 +0100
Message-ID: <20241216201305.19761-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rt_entity_is_task has split definitions based on CONFIG_RT_GROUP_SCHED,
therefore we can use it always. No functional change intended.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6ea46c7219634..1940301c40f7d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1257,11 +1257,9 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 static inline struct sched_statistics *
 __schedstats_from_rt_se(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	/* schedstats is not supported for rt group. */
 	if (!rt_entity_is_task(rt_se))
 		return NULL;
-#endif
 
 	return &rt_task_of(rt_se)->stats;
 }
-- 
2.47.1


