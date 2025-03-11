Return-Path: <linux-kernel+bounces-556144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF3A5C168
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F086162A98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA325A2DB;
	Tue, 11 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q8NXow3A"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32A258CF8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696625; cv=none; b=V3fL97aa4Qy8VbQBc8OKHuo2gYOUJPA+8fCR8U9l6sCbkh7g8Q6rO6X2+HB4eWkNJHwyx/Nlk1E1HSO9DDlOkX/w8GjaqDIDm+uLtNQwb2tegrpeot/RD3OKQfWhn7nTdIZQHe0JwVeeIODgYQCvJMsWNHjb9YKFoymslEk1wKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696625; c=relaxed/simple;
	bh=MqY2KO9WFCYLClgF1yhx+Km7fVQosUJ2IZ/gkLOrhQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVD9KLom1lVmdKBP/XOZNPrhr+eNMwy7p0CIA2cxNK7mZi+U/RgFcg4oaRwA0Qqodq2JJn29pUSPDUp3WiD6ByroDAUoC+kNem6sK2QfMzsQVU9SS0bwCC08U5zxlZBOKS+wM1T2a9AI60sKtAYKaelR/g4Uo+rbml/BFiMSLyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q8NXow3A; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394036c0efso31951385e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696622; x=1742301422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmehWFdzIB0bfRGHhBlCvzGcb5DNPkGCVygY64B4O+Y=;
        b=Q8NXow3AVH47SlOlfAmZSBtlXy6x9jvtXwJVTpUFiBBJ3wxPBHdp/AWXnF+gbWsev7
         TYekw+ZjGQ97eWdnD7d833+u3vQQTANkSwAq9mREgxq9tr6oBrqjNwapa0pj63/+A8Ot
         hMYlcLmnBlDH+rlYDu0rrcI3hrny3yYOpU2Cr05+7127MT3mTtO1HWnq/kktA/Nkn9dj
         OFRy8F+lqFU9SrMEiA/AVpk2OwH3iR1lEw24FrQ8vw8ytmYIVj+1lV1f9XTQCnoZrfKL
         pf6Ach7/zwYwwJ7jtFuLuMbeyog9E8JD1cLpEjmfAYuwaE7wkhfWZmSvh8JSbVV0iXlQ
         ekSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696622; x=1742301422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmehWFdzIB0bfRGHhBlCvzGcb5DNPkGCVygY64B4O+Y=;
        b=AOMehJXwPpHhJf4sNm5NZZ+sYBRWSt41Vypk/h9WJ3L5KwNlMVSOyI7cxXpoWMopU+
         rgRNqtYyRUlu8RfJUsPaGppslbziXSfO4NpvwFV25Ky8VBt5AtS0K7PKq+agcmEbM2ef
         darTR1jNFIeWyL8jdUL+htYC46gpJ3TKOBEeG8+05YO5E5A2Jl9kdgnRuGBL0ekqud+f
         WMRAK8ZqdoGzC/GFBxKEkDf0B5iKSXU5U2jQyU5afiboliRrAaYFQapqU3CEme9vFwHI
         2Y030k8EhKcFLyb6ykBbzsTRua0Sy27cdew2vP1z0aqc3r8NW6ktwnLZkg/AIwpvKHVo
         bT/w==
X-Forwarded-Encrypted: i=1; AJvYcCViKIbU6KWqgxpeK2xSFU5acpoqzVN+ZzrRQ7xPoW1yqrafh9W63RiOhbSVy4qqEtfViBtXonluuy9HGe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdmqea4Mg8LWM5GNIFGcyyF2X+G+bJi0nWKPGKM5LG7HuhCFyF
	ex0C2QveE34bfnkEANQe3aPRH9Ad//NcceCmUYbsa2+KB+eJRAu9GyLVt1fKn0Y=
X-Gm-Gg: ASbGncuJ+zAMGEoyVw5Lxzl+nQ5LVFnNUW2pOT/XZUynwpUilBIT+e7r467SkV9A5Z+
	vvljr75urS+QSzcrewZNfKcA3O0WeCvH9jLdKKr8fAO0FmmiBj0H/LLu4uPNiLvITko95ysbOTs
	T7al/PvIyQnX9HKTMbtaVNuUF01FW796VV8t/RhPUQRF+yhlZL7xlJE9kKLpcEW2Cj6gHqUHP/g
	hH0+0pAmX2F954gGp+C6AUsagpVoW2P6Y3Rh9FGqALzl+ICF9uyV6w+PLfLTF/8T7uvJCfDOO2N
	5s5GC9PJAKqAtIMQycG33gPU+pz0ePqDHjSO4IaBgmbOqhs=
X-Google-Smtp-Source: AGHT+IFyEdeBz1Rifp6cQSjWl1jGeQOUXsDtQFNdmUPRDmr3dzDqr692D54ub6bRfUME40ARS9pcrA==
X-Received: by 2002:a05:600c:5251:b0:43c:fc04:6d34 with SMTP id 5b1f17b1804b1-43cfc046e90mr65471275e9.20.1741696621937;
        Tue, 11 Mar 2025 05:37:01 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:01 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 07/11] RFC cgroup/cpuset-v1: Add deprecation messages to sched_relax_domain_level
Date: Tue, 11 Mar 2025 13:36:24 +0100
Message-ID: <20250311123640.530377-8-mkoutny@suse.com>
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

This is not a properly hierarchical resource, it might be better
implemented based on a sched_attr.

Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 7c37fabcf0ba8..5516df307d520 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -175,6 +175,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 
 	switch (type) {
 	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
+		pr_info_once("cpuset.%s is deprecated\n", cft->name);
 		retval = update_relax_domain_level(cs, val);
 		break;
 	default:
-- 
2.48.1


