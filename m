Return-Path: <linux-kernel+bounces-365925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF33299EDFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1897C1C20B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7B189F30;
	Tue, 15 Oct 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUsng3fw"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912301FC7C9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999540; cv=none; b=USIO3XeT7iS9qGrRWfbFa0s3m4d6njVnob9A5nUi+qu+GsfaK386PB+e/FBX+ELaUJYJR4AMD9ZkHzlN6Xd+v0He4ExRjDbATNlmjd6R5Nh6ON190sZlaxAKHmDiVTUQfc77UrEzHfma771k1WNWTXMUeZCfA4Sk0FrEW2O6uso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999540; c=relaxed/simple;
	bh=F6n9LnqTiY69io5LQchJRcKHF39dZOCzXFmPz+zoN5I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hHDeIdBMJXL3Ayb7FPq4Ml4BTKYULwSfMgsBEYCOiwTvLx26IRwH2HJ/kN4MpFu12PHYNYbQ4/Cr3TijaLeON6Cn6+EougR7XdvEGV7xOwet9xx24+3OMZsb4wadmBtaNys8ygToW+ePNeUr4c3sQIrmW79T1AAy8g97MS1fFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUsng3fw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e31af47681so2316910a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728999539; x=1729604339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twpocm5DdoKcJURHMgXbW8+anaFe1LW3AHN9h1TpCLE=;
        b=IUsng3fw+qycss4GzIEfKd8a8snyfUnpKUQlAnjuKTX2Dwx/oaQV73/6hgICot9fEm
         NJumgTDei43Vo4fbykcp653gIYIaEjdV5VXIVIG1nXwV8zS4Rd1Jm6unI/Os0BUyPxNv
         gVQ1tov8OPYhotl3izIiSGihd1XGdBTjpvC/hwxjuahVEp0mysJUAxS3JA7PWh/LxKzk
         vNP6pdTvIWZkI9NOqySFNeqBY2Q0PtKOcad7Bl0G3ee+2fc7uhAjob9QnWVlk6/k5Ho3
         FtartdWaH8SCiY+p63GjG6MT8yQ6OH/b4vFi7oH8Un0CZ4limw6weO7qJ6jIxlJIQpji
         F5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728999539; x=1729604339;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=twpocm5DdoKcJURHMgXbW8+anaFe1LW3AHN9h1TpCLE=;
        b=paOVJZuImdpguiepL9z0/2qZtPmRDmQUKopJ5qcbzivYwPYPgEsBYaI/fy7F/Rw/Gz
         jLB21+b36sZdS4PVHhZ0nrJNYQzW47kqhB78XCPFGptR7WYqxnQ/BTzNEtmBUgoVhVR9
         kzfnEs2BkoYFAyufcrt3+UIL/j7tARlTXjt5VY8ffbp06ikVVNrZ6KFBTBnQyomi3DcJ
         qKndbm3jlU5Y4sX2aL4UB+Y0dPfoI7g9XzgJMeOEVtv3Ed5IzEQoYSNXXRjxeCXPUf8K
         uaZn7htaN6Y9U1t26mysuoqNbdZZnRDRTSJyBaMgRZRAARHuSfUrags/tw5whXHCil2B
         Zpfw==
X-Forwarded-Encrypted: i=1; AJvYcCXLUt0fWfzAt965wSZ6b7ameNvBYObTReHNi2fLfJ/POc/sjuw1JAGWlaS7eCefXcXG5X2Vsj0fErTbFCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLY7lq9GZhLStxQbc6oVyBRtPr5rlO2mNHWvck/9mx+Y9LBdW5
	1qKodY6jqbWpaPjYbQfqDGjVPws//C96NUCHmTADD5xVV7Mlcrz2
X-Google-Smtp-Source: AGHT+IGm3VTWLTV0f20VdBsTS9/hhjSaEgkhZlijcXoALytlEXfNENBfxIMjfJQgc9jkgQtIZe77aQ==
X-Received: by 2002:a17:90a:c902:b0:2e2:cd80:4d44 with SMTP id 98e67ed59e1d1-2e2f0d923bemr15677704a91.28.1728999538796;
        Tue, 15 Oct 2024 06:38:58 -0700 (PDT)
Received: from [192.168.1.4] ([139.226.29.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f73b7fsm1722835a91.48.2024.10.15.06.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 06:38:58 -0700 (PDT)
Message-ID: <c94702d2-c5db-42b3-9ff8-746be98ec2a7@gmail.com>
Date: Tue, 15 Oct 2024 21:38:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benjamin Tang <tangsong8264@gmail.com>
Subject: [PATCH] sched: Remove unused parameter from update_deadline()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


After commit 85e511df3cec ("sched/eevdf: Allow shorter slices
to wakeup-preempt"), the 'cfs_rq' argument is no longer used
in update_deadline(). Remove it.

Signed-off-by: Benjamin Tang <tangsong8264@gmail.com>
---
  kernel/sched/fair.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d9c33f6c1d54..882802d79720 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1004,7 +1004,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, 
struct sched_entity *se);
   * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
   * this is probably good enough.
   */
-static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static bool update_deadline(struct sched_entity *se)
  {
     if ((s64)(se->vruntime - se->deadline) < 0)
         return false;
@@ -1228,7 +1228,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
         return;

     curr->vruntime += calc_delta_fair(delta_exec, curr);
-   resched = update_deadline(cfs_rq, curr);
+   resched = update_deadline(curr);
     update_min_vruntime(cfs_rq);

     if (entity_is_task(curr)) {
--
2.11.0

