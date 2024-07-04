Return-Path: <linux-kernel+bounces-240476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AB926E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A151F22E32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50A91CA87;
	Thu,  4 Jul 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYt8vntL"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BF200A3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064791; cv=none; b=eVaS69jDOdyvt3nLNNeekHmdhrfQ9W+71gM4MhxJCByN/T6MSCKJhxQD6jAAMb/i+EhBQDNG42TbA74Jexj9ZobfII1wEfX7O6L0qLqNYHF9QxHgJU0pbkkvIAGSRFQErqXEUKk+pqsQXMmj02Q4AJFXqnSCH9XAjZmO9rGeehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064791; c=relaxed/simple;
	bh=0wGH2pPRo7CcCyz+lS+SPCKnAzNn3Ckc8DkMAcgHrwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s9MKwA/8LlwHnYPeKC2EejQn/lfFNCt7phmraFoKloRrf9birlKiyyI8qQCYY24cOC147M6COXqONXaOu4rlh+/AzvIEMPTXqZ7ltwkQhiwxMfKKc1s2k44GWXcLXONMf4JlTvuahtp3Lb+K5E91lwvcgEZhGYEwK9IHg0k1alA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYt8vntL; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e134abf00so61411fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720064788; x=1720669588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GT+empfUleizNV1tLgO8BUPbKyqAAzV+HvCkVGMbF2M=;
        b=UYt8vntLvsa1u/kg5eJn1I01fuQ8OpVabpg2vZ/FE1PkIjcRmxOkH+KMs3Cs7IhlRK
         RMDsrNmGVGSLiiFppDCTxONZBkDS2lYxSXyfTw0znUI+wFdNqzbvBcgo+A7eIw+n3XrF
         m+Xo4b+lm4mdNF9DPZri6+9Eh1Qa/S8lP3AhwWfzVUMzGbhOUiJZkQjXv3SQJYx+F+ct
         6d7n8Ls8T3ArM6+ZkF48HDFWF43nFL26Uu4TqvbExzEZHUYBGVwOL4HAeGi7qb4x/a+a
         dRJof9fnc+PgOqYq7VWNe1LpSJyk6UzHELZj3zZ7E4sfVliXxrcMzIia35VJFqKTfpW9
         TgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064788; x=1720669588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GT+empfUleizNV1tLgO8BUPbKyqAAzV+HvCkVGMbF2M=;
        b=PhsjdICnWydmffiXN9MC7JKkrtBopGSsI6/VKA9WsZCXrDzEkIeHLp43mNOgVYtlXC
         +hv1+LF7DCA6NYgfEkLU10Mzo7HXmqPd2HZEpwwMfa2swGMqasODBRFFr8RR6NiNc2gi
         wTq0rxuI3ITBggt54d2eJT4cVKxFMJguB0PxRe4PglZ5PZRRNHW/ezpo2RG1hQ38iOJK
         qGTg6e5l+cv19hDX+rAwc2n/b1A3Rx9r6CY7dOGGMN/UGAyX38+bvrL5DRvt36FEFysJ
         MwJ65PWmHoc3q1HaNDyQMj0U5hPq/I42ufyd88a42cw+Y+MS5kQ+S4sivlOGw3wgGfd1
         lIVg==
X-Gm-Message-State: AOJu0YwF3tYEZj0CsxP9x+Ri5O0zvLpc9xaJP9cnvi2VcgV/VBRAHFZy
	iyGzjTFawMcHCCE6upWvifJchQklI0TQwUOn0k/9pCwd350ODUOoItRPiQ==
X-Google-Smtp-Source: AGHT+IGGSif+y5xoQ5C8S+RgEGs61zrdI4wMq+pKHasZGGGFJRBIY4VPwP0zSmnq/CuFT5DNj3sKNg==
X-Received: by 2002:a05:6870:a119:b0:259:8cb3:db2e with SMTP id 586e51a60fabf-25e2bea68b9mr434709fac.39.1720064788203;
        Wed, 03 Jul 2024 20:46:28 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205ebbcsm11198914b3a.40.2024.07.03.20.46.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:46:27 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH V2 0/5] workqueue: Make the PWQ allocation and WQ enlistment atomic
Date: Thu,  4 Jul 2024 11:49:09 +0800
Message-Id: <20240704034915.2164-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The PWQ allocation and WQ enlistment are not within the same lock-held
critical section; therefore, their states can become out of sync when
the user modifies the unbound mask or if CPU hotplug events occur in
the interim since those operations only update the WQs that are already
in the list.

Change from v1:
	Init rescuer's affinities as the wq's effective cpumask

Cc: Tejun Heo <tj@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>

V1: https://lore.kernel.org/lkml/20240703033855.3373-1-jiangshanlai@gmail.com/

Lai Jiangshan (5):
  workqueue: Register sysfs after the whole creation of the new wq
  workqueue: Make rescuer initialization as the last step of the
    creation of a new wq
  workqueue: Move kthread_flush_worker() out of alloc_and_link_pwqs()
  workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.
  workqueue: Init rescuer's affinities as the wq's effective cpumask

 kernel/workqueue.c | 87 +++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

-- 
2.19.1.6.gb485710b


