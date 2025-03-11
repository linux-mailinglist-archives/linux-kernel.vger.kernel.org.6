Return-Path: <linux-kernel+bounces-556146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0AA5C16C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4ACC3A50BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97AC25A65E;
	Tue, 11 Mar 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GTvtN6TW"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D625A320
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696628; cv=none; b=U2R6nA5ezcExuXBrTvQXXyPhSPTNDoFroe2rBLkT6DwojOP9eTVdQ/9UlQsJWy1uCW6KB/pUz6Ud9rL5zD7ErRZePAvacS+CbTimT6waBPWc/1XHZDQKEBStS0u4yYBKdyxZ/KstEIhjjFW9irQM1hlD1iTgB6AWCRXj66rdaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696628; c=relaxed/simple;
	bh=lpN6C3vH3f4PCCjaCmy194/gBX6pshhqP80Aixto8yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6VVG+/8qFS0qnpoPK6zA54Qfpk7sxvWleiF5d8eZxW425q/FqAfogi/42rJNkaNKoZRTdFDYnYsK1RFJx1+C2atEYC4CCRa0uYFqqYsR35xxOKT7Ck/1CbR1L5itmEbLI4REXCvzr2Blda2SoT/zVIEABb2LQlHRJFmF6CdKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GTvtN6TW; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so13033475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696625; x=1742301425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzWC6pSc3pyPRb1xLnLmWP9XGPQURz0PKrv7Tm61llY=;
        b=GTvtN6TWGeCMg1TG4QtCiRJG763QZoZohxp3xAgDtPEEm2ibQro2Ud//c0TC3/Rmmw
         y+fJ9i5EjhYJiIZJYWVsgLJNK3BF5twdnYouPEyct4wuPzaTvemGmZx4mMASLlR2zsSE
         Vu128CFn/DDFb2ifF0sJc35aJ77hw4Fc431+1SyObsH9H2/JF3mm+X9DiFMh6kD/FSRz
         lGXYifBRmfAiWsvXXJEhhpIGNez1jlQuCD7KNifuTXK9LaBes5bquWgGnvRUFAUmbTeS
         magve6K3Y3yVafZvscDxUGTawbSJoMx/PR7GkcJy12RF0212YxMDcnB1d2LiueSeXhhP
         Ic6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696625; x=1742301425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzWC6pSc3pyPRb1xLnLmWP9XGPQURz0PKrv7Tm61llY=;
        b=O/hGyr8SQzHt8xU7rtBtUmuY77gh9kwnrr2gQ0EZr7O5dtZ3oZtzskPrAcVEuZ19Q0
         h2quYmAeud2zoI4kucJQLJAG+apkl5fsTgcAJft16eKEYll4eD7KqL2gbw+Qy868XtC3
         VHoIvlJTWaup2tSEzr6rpx1edyscUMHvELo/09v/RadTPnheoHk/LRaa4/QKcAHfYqKN
         0nHl/4nsjAkULx9jsG3r7u7z0VxNl5q7TI7qiWzJ/ONBfaBg1BzKWUEj6CtGhdQKoeLH
         /TVxvq4YQ7xNlHWrjPrLtGl14Kc367eFJZfU80HjfBIYtjBiDZFn/mPKiBbBz84VRTtI
         /nGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaZVq8PQ7JBdpKvM0fc33sh8E2jFW9nLOKeasKl7nQ6kLmWzjKWVe1SLtGVwNINsXaHUEWbGYLrpuqlFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZtvgVicZmjPJ+8anVGdmF7J+XmoGT80bvTFHcRH/3Vcc5iCr
	+RHXDODGJm0XMA0K/YB4W7SR1g23mnki3yS++QvvosFgG6VV+X+T2mRl5osTQYg=
X-Gm-Gg: ASbGncsLmmjxBxAJpWr/cPj4e4aWBDhktAmkimzpFrqqyXkU9g82c9G9rcwpI/ChSiO
	VYdtSr7Y7U117Mkml2z6871g2PyXNlnE3HrSRo0/hFTOv5hRCrIJrGQQx9EC0eHB4BzxWTMp7mW
	PD4qQdJJ/Tlaigw8J/QukpiUj3CvJhIrOhde8BVBM4fP54bCsRFiO8JCMYHJLTl0QNEZ9HNbVcI
	ZgfGSzxfDMx7rvAsij7q4xAofLPtJWDYFGSeiFvdE/OInifuRdlqjqN7dGcNaaLP8Agr4ekF6tg
	Uf4Nnv/0sLNudnmMSrUJRr0Y82gr0tn9GS1cFP4x8IEBvBU=
X-Google-Smtp-Source: AGHT+IHjGGtwlqaOo23AVRgIZZjsnb2eS9q9J1v0DCucwlPhaecePxi66A9LjOaMhcu9jnvCUdaHIA==
X-Received: by 2002:a5d:6487:0:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-3926bdf5c18mr4141501f8f.1.1741696623166;
        Tue, 11 Mar 2025 05:37:03 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:02 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 08/11] mm: Add transformation message for per-memcg swappiness
Date: Tue, 11 Mar 2025 13:36:25 +0100
Message-ID: <20250311123640.530377-9-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The concept of per-memcg swappiness has never landed well in memcg for
cgroup v2. Add a message to users who use it on v1 hierarchy.
Decreased swappiness transforms to memory.swap.max=0 whereas
increased swappiness transforms into active memory.reclaim operation.

Link: https://lore.kernel.org/r/1577252208-32419-1-git-send-email-teawater@gmail.com/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 1 +
 mm/memcontrol-v1.c                             | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 286d16fc22ebb..02b8206a35941 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -90,6 +90,7 @@ Brief summary of control files.
                                      used.
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
+				     Per memcg knob does not exist in cgroup v2.
  memory.move_charge_at_immigrate     This knob is deprecated.
  memory.oom_control		     set/show oom controls.
                                      This knob is deprecated and shouldn't be
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2be6b9112808c..29ca6489b4ff7 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1855,9 +1855,11 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	if (val > MAX_SWAPPINESS)
 		return -EINVAL;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg)) {
+		pr_info_once("Per memcg swappiness does not exist in cgroup v2. "
+			     "See memory.reclaim or memory.swap.max there\n ")
 		WRITE_ONCE(memcg->swappiness, val);
-	else
+	} else
 		WRITE_ONCE(vm_swappiness, val);
 
 	return 0;
-- 
2.48.1


