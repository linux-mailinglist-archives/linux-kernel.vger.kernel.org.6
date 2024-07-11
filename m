Return-Path: <linux-kernel+bounces-248477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD392DDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26CD1F21E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC7C157;
	Thu, 11 Jul 2024 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CygyIftS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7208F68
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660479; cv=none; b=CTD9zIn04dsh+6muZkR6hgHIpQgKFtsnJ0OQbENWl7USVknc0p5yjtfCSnGf7+CacnyBhu2Z0P1iESW5+bJ9ZJ7GNUYJtnJwBC1orkfvnOWRUIsZfKAr4+4JP+sVIk0HpDO/beXOUAzFSlJ60CY1JFb7/P0Ik09B29QjB8VWTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660479; c=relaxed/simple;
	bh=8xKIKwUg7ELTJB8eU77JOuHkoERweNlEfDyTXTbRiYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeitzgm4wmjUrqZp3O41+I4DS+aYkFmfSyj1juk3ffN+cV0ftKNrEIYJFQIDRAUrxiyDAf9dAu1LnU1NnMH+9Ekn951uc3UJ2ygeTtyFLCdK5kQ7CPg3P+mobKnK3xPUlDTuqDrCQzu6KGSWtz0PveUo6+H5Gwy8zOwie/e+bgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CygyIftS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so2262495ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720660477; x=1721265277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=frkY2w6KK9gLgv2/nM9vfFnrqPZfUpj2MlYKBGVsUDs=;
        b=CygyIftSnXAb8APBM9mCydpgXatiBfORK4kfNdfIBn1mg3kEivbztex3urDQ6igZWZ
         k8sUCC+FpuZMgaRGpih1e7MbGbiFz7O8ADChGfeAW4AynAeW6gYLkbXV3wg63To5GAUh
         2IrOzyLsrHQcjjcsHSJMnLreRnz50w3ExIGC+OIJO7sYK5keNA3BYZaLo0uAIvOqZj3F
         Y8JaRM9lB5i9C2yUqsnAZiRgzSloZSPMuSbUnvLbDBT822Utqcs8C+Iw0Qhe9pm4Wedg
         g+9W04kshZgUytW8M+zAHjwJX62ka5+xuPE158qV/RzPzhCktUWUVD5Mq2YjyWTGN5S2
         d3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660477; x=1721265277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frkY2w6KK9gLgv2/nM9vfFnrqPZfUpj2MlYKBGVsUDs=;
        b=qcnbnaWLYjtR3o7N4EXRf0l2+9A3ep6PIgt/DvEHaKEVRJ4tyi4KMZGrih+IlB+oCw
         aiWO/JuZLXKvpMXDmxAH/Q1WFO80PD1HYte53Kn0Y0jANPGpa35qUPBH0LB2cPhmyQjE
         rVmS0EnrxqHzomHNWX/WB1MvU6xAJH39LXUX1A68LMUHOT2CWXwlCZeGj7JlgfddH3wY
         WvEXyk1gaYYMjtk95gRHXS54JAvIDuGokqPrdCg0Ta7G9wdU4Wof5JS4mKvlPSPSV7CB
         JsZXV3pXMHonhN+rqilDIqSEkqlNo8WfpVp0gb3Z8g2zgfw8DKd45wVuqL/9AzUqDUei
         yC2w==
X-Gm-Message-State: AOJu0YzrlTbTDl6NnSl/NjMCbWm1GWz4LOqPun9EM7za9bjrkDGZ1f6O
	/nVylOi230HKSMMQZGa/r+ZoLQBmnpGPKH4xDWhbQsKGhvwVN2br
X-Google-Smtp-Source: AGHT+IE5MPTaKPVJYL4u8jvvbaAdBHVsKw/+DGjVD2IPYk7KD+l7F0iaxdCtKLfMoE/Bd52LAbPMEw==
X-Received: by 2002:a17:902:ea12:b0:1f6:93a0:9a45 with SMTP id d9443c01a7336-1fbb6d64e88mr56257905ad.36.1720660476727;
        Wed, 10 Jul 2024 18:14:36 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf840sm39399375ad.257.2024.07.10.18.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:14:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com
Subject: [PATCHSET v2 sched_ext/for-6.11] sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches
Date: Wed, 10 Jul 2024 15:13:57 -1000
Message-ID: <20240711011434.1421572-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2. Changes from v1:
(http://lkml.kernel.org/r/20240709212137.1199269-1-tj@kernel.org)

- 0003-sched_ext-Make-rf-optional-for-dispatch_to_local_dsq.patch is
  replaced with
  0003-sched_ext-Unpin-and-repin-rq-lock-from-balance_scx.patch.
  balance_scx() now unpins the rq lock and the inner functions don't handle
  rq pinning. This simplifies code quite a bit.

- schedule_deferred() was missing a return after balance_work scheduling.
  Fixed.

- Other misc changes including UP build warning fix.

In ops.dispatch(), SCX_DSQ_LOCAL_ON can be used to dispatch the task to the
local DSQ of any CPU. However, during direct dispatch from ops.select_cpu()
and ops.enqueue(), this isn't allowed. This is because dispatching to the
local DSQ of a remote CPU requires locking both the task's current and new
rq's and such double locking can't be done directly from ops.enqueue(). This
gap in API forces schedulers into work-arounds which are not straightforward
or optimal such as skipping direct dispatches in such cases.

This patchset implements SCX_DSQ_LOCAL_ON support for direct dispatches.

This patchset contains the following patches:

 0001-sched-Move-struct-balance_callback-definition-upward.patch
 0002-sched_ext-Open-code-task_linked_on_dsq.patch
 0003-sched_ext-Unpin-and-repin-rq-lock-from-balance_scx.patch
 0004-sched_ext-s-SCX_RQ_BALANCING-SCX_RQ_IN_BALANCE-and-a.patch
 0005-sched_ext-Allow-SCX_DSQ_LOCAL_ON-for-direct-dispatch.patch
 0006-sched_ext-scx_qmap-Pick-idle-CPU-for-direct-dispatch.patch

While 0001 is a scheduler core change, all it does is moving the definition
of struct balance_callback so that it's visible for struct scx_rq
definition. If there are no objections, it'd make sense to route it through
the sched_ext tree with the rest of the changes.

and is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-ddsp-local-on-v2

diffstat follows. Thanks.

 kernel/sched/ext.c             |  283 +++++++++++++++++++++++++++++++++++++++++++--------------------
 kernel/sched/sched.h           |   19 ++--
 tools/sched_ext/scx_qmap.bpf.c |   39 ++++++--
 tools/sched_ext/scx_qmap.c     |    5 -
 4 files changed, 240 insertions(+), 106 deletions(-)

--
tejun


