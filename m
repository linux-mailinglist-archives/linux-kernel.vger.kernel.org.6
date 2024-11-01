Return-Path: <linux-kernel+bounces-392173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF59B909D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D041F228B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD3196D80;
	Fri,  1 Nov 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPAfOum8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158A15359A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461749; cv=none; b=fcdq+rNtimnDmpoVgCAWu1Wqal0mxLI3GLbqpECP7RAlfxFox6I+WkQu+UgzafvQ0bOIz4U5OtnPQj2bdnrUc/XHiIKNBk+tLbSc5CTMUV6hAywZ6i0DJATVed4SEB4fgvTToTk4quhUgGJ9+aED82tRYEF0EUwxlZl6BR6UBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461749; c=relaxed/simple;
	bh=DU5tnh4fKHvyUSqUkm2ijreq/M3qLkyq1dK4k7W971w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEj5jTDeboubNm+BgId+4QKFf7ypOIEARuoZ4cfaap5sorWPUd2ainVVDXPZBRT0tF5idcirxE5kyODzC5UK2f93K9WYPXR3aZ3yMDPgsbzzaIn4KXhG2siEQeIOR8tGA/GE2dmwnWC7MNL8VoqxgT6d2tlerKh1i6FSbMI/8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPAfOum8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20e6981ca77so21263665ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730461747; x=1731066547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjJyrr7Ri//jIrpJtpeB/KnPwSgtUsj0MTLSIwGzd9E=;
        b=VPAfOum8hnVhsGmobEGnFtHDPE7HmCdTQj+4IS+ql1GOp0NBFTQk1ka0tJINyxm8lH
         pLp9gEjwTcVFbl1YzS+i4/w9nOFjHl9vKXWxfjdFdFazO0wLI3xKxE9JXYsUAEB05XYP
         pYRznEG8CAXpVZ903pTkEGfYn9xy8bSclYpuIQ24WD1Pp6Tt3j6j4qY+7ShetUnsP2WD
         ydHDv80jRLhN7IWn7gYBc0ov3Zd28fRBPzsJ+UrB64y7ufwnJDSpn9VfCtXCakLDjiKH
         sIVsSVxZAlH3KOzyJKonVBMZLlOvIu13bBVxF/BuJDQd5LLVj3LHedLw0aA3FLvMEbmx
         ZWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461747; x=1731066547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjJyrr7Ri//jIrpJtpeB/KnPwSgtUsj0MTLSIwGzd9E=;
        b=GDiEZDsAXc2A1BvTNBC0xBwRci8e9dCnE9ayPexDyyQMSvFLlae6RUXwDd4Mt/3b+S
         96N4iWUFXFj73vLuZzmCnKARvFPAHGBe7YKkBjyGT4ZXG4RV0R2tNbqe2p88yCuyqbrm
         6VnNOAe93gixc+zFzFZNaFRtm+Re9zIaDtl/lcpvuhr0fku9Vy66kJ1JNntdj8JHYQ6b
         khT7W0r4mbElVl6/bgXyS8+zcCrKosoOQbXknGNkNP3ZafmO5l4vzkwaEWVWOg7z9n/F
         XMHnxQMvP57QMGU5BsnFUmWUAm8uHpSz/C7NzWNn9nhuaO6uDZ77eZBwjUQF5zyKsHMl
         DyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvyr/42GlUvhgOqeu4veBHQmzT1P0oqGAGy4b04UY/9SXzZRn81iNU+SDIhslU36oxdiMEozlc0+2V8oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUPScttfhz0t/SyQgobELvVnKhigybCz6KFF773kMEF3f84bK
	WhApPfzCYx/+YmlTsnjVNuvgDQnPSTaCX3cMUZ3UYf4dVqq7zvOb
X-Google-Smtp-Source: AGHT+IF5Mz+chfdy3uKnsnM3ZOYAgO9h4uTte1UI1Z+NWRE821Lf9toSSYcxLNtgd6qkNtIoM3E4jg==
X-Received: by 2002:a17:903:22ce:b0:20b:9379:f1f7 with SMTP id d9443c01a7336-21103c59efdmr93506395ad.40.1730461746977;
        Fri, 01 Nov 2024 04:49:06 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.134.20.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eda5fsm20498225ad.7.2024.11.01.04.48.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Nov 2024 04:49:06 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ioworker0@gmail.com,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	cunhuang@tencent.com,
	david@redhat.com,
	dj456119@gmail.com,
	j.granados@samsung.com,
	joel.granados@kernel.org,
	jsiddle@redhat.com,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	libang.li@antgroup.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux@weissschuh.net,
	mingzhe.yang@ly.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com
Subject: Re: [PATCH v2 1/2] hung_task: add detect count for hung tasks
Date: Fri,  1 Nov 2024 19:48:33 +0800
Message-ID: <20241101114833.8377-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241027120747.42833-2-ioworker0@gmail.com>
References: <20241027120747.42833-2-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Sorry, I made a stupid mistake :(

sysctl_hung_task_detect_count is defined as an unsigned long, so we need
to use proc_doulongvec_minmax instead of proc_dointvec to handle it
correctly. Could you please fold the following changes into this patch?

---
 kernel/hung_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 229ff3d4e501..c18717189f32 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -330,7 +330,7 @@ static struct ctl_table hung_task_sysctls[] = {
 		.data		= &sysctl_hung_task_detect_count,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_doulongvec_minmax,
 	},
 };
 
-- 

Thanks,
Lance


