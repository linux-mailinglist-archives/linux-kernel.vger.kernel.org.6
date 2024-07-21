Return-Path: <linux-kernel+bounces-258165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF829384A1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594B2B211A4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58B1581E0;
	Sun, 21 Jul 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LR/wt7hQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF753BE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721566346; cv=none; b=E3tSrtL5ukoW39mBKbNr8FOVfW39xHbptkEd/2SCle81mSylF0+FKfsQAKmXp+Vy3NGHPHasAF8VHTM0NbuJ/uO8hGZrHyg959njsq//nR9ITpK8udpXqix7F9epdzIIx0jAz8Mv/ItuNVmyGPhQwaYKG/wnLBqx7+q9ffwFouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721566346; c=relaxed/simple;
	bh=Y0owIh4uspYI1r7Be8JE+zkgLtS+QdhB4SCLoUXADt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rU78FuXaS1h7HzQC8NsnHfabLOeddHZNNBBhUIk3WlCE/As9pzF/hHFRCeKSLdZyDFADq7eXCRurlD4s78hYFRkR4nQRbsXKuVoioxOoyQQmbatqp/QTcXJ30B9Dp3dINUyc1N/gRHVwjmuvkx4pRPSy3SDhTiTJ47S0K2JGipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LR/wt7hQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd66cddd4dso17993225ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721566343; x=1722171143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3VF3InQVqpVpMwAvoKU2x039TzIXo7AROvGPJw4vbs=;
        b=LR/wt7hQfGX5OGI+FVBvpNVsD4bbxbDEfqaQw4MlFlzfvDhe9aGR/9+A4WDbREudou
         z+L+20YnGQpB81UbFBrovcGgrnDdMOm4AX9b8H8sGDyto+MjcAiEwd0XJ/QWXuoF/427
         S6uN+E6WORMnIxuyw2pSZiY8AxKK+MtollM/ZcJH6EPmfdUm+GQysWiMDW6TpejMM66S
         nVUW46Gi11utMHZLg5VmsozxrnsEDx5gIFGPhOSFDQ0JjTtRhKOk12e+BxAqi2h+XaHh
         XFubIuGTsclhjrsZGDfPw2JQRAoWym9w5ngTNVQGRCFO+sngvhSwQlehZAWbhV+yCdKZ
         3YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721566343; x=1722171143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3VF3InQVqpVpMwAvoKU2x039TzIXo7AROvGPJw4vbs=;
        b=RxzdrA+EUhR4eaKC3djVQuO+cEEMDMW1Aucmr1iOdvpi8t4wPHnTHOSILMj1HuS/YH
         FSB5kJM7BZc5IjYp7tgs9gc4BP835C4jk1B+e5lO9kPvaKxvH0A8bBuccShjaAo30QNm
         Hkamlv4iJpFuGnwfBEc/BqDEcJO8GxVcp8RQJEasm3Nsaz+7Srb+uaFpAa/OHHCNHgWX
         0vCeJApB42yXHgsuXa8U/NqVyLf1WQGphMLNAqNHJxNRD7zMhLUzTLt2sK5Eno9zOhUb
         FdedQRjhHq3cIu+vfboJf21NVw/iOeCG4sMBWaWAhxgyfnJ3WxJCLa/zC8+8QXPTFxsU
         ceDw==
X-Forwarded-Encrypted: i=1; AJvYcCUWmLmeVXCpfLNwOQ7xt/ZGNycgJz74CKXXM8YjAqEJOU/UtQ5z8ZbL5+AX8C75G0kXUx25QRk39g8cMT62tgTF8FX4vLkfqqTf+YDs
X-Gm-Message-State: AOJu0YxEX2nINcMZza94jP8gl9HV4E8nNhKSN3lXdxIw7egt48BvqDsH
	Eq7l5grxvgIys5iWpoSLEVlSC8aIuhr68vuEJnZ0GhadxyBKnT4RwQSnT2gybvM=
X-Google-Smtp-Source: AGHT+IHS9DhWKXiSAiagXP7CpGfk2pT4PylT3txskGJY26Nyqqjh3dpNuEguxI9Qdox5vEgSIueCjw==
X-Received: by 2002:a17:902:f54c:b0:1fd:89c1:49d6 with SMTP id d9443c01a7336-1fd89c16350mr24387705ad.44.1721566343549;
        Sun, 21 Jul 2024 05:52:23 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f472366sm35871525ad.260.2024.07.21.05.52.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jul 2024 05:52:23 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	joshdon@google.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 0/2] minor cpu bandwidth control fix
Date: Sun, 21 Jul 2024 20:52:06 +0800
Message-Id: <20240721125208.5348-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset tries to fix the minor issues in cpu bandwidthe control.

patch#1 tries to fix the inaccurate __cfs_bandwidth_used.
patch#2 tries to reduce the unnecessary overhead in
tg_set_cfs_bandwidth() observed in our production environment.

Please see individual patches for more details, and comments are always
welcome.

Chuyi Zhou (2):
  sched/fair: Decrease cfs bandwidth usage in task_group destruction
  sched/core: Avoid unnecessary update in tg_set_cfs_bandwidth

 kernel/sched/core.c | 2 ++
 kernel/sched/fair.c | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.20.1


