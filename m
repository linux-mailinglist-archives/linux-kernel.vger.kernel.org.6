Return-Path: <linux-kernel+bounces-246691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AD92C53A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D4B1F2307E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF02180056;
	Tue,  9 Jul 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIGkTrWG"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4D7CF18
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560103; cv=none; b=hlqaXevTb+kEGv15G1PFbM6FqN8Z/s0Fqk2DzcgrCfKzYToh5XQNym992guI3fOd8ObOliVttULAB6NRShYp0GDnJTA72iTJ3UGjLlSyz76rcptF1HXymTvWzmJffSUQ8pX00GCIh5l8sp5fwIt0hb8dEfnqHeDYPiNTGLo7x9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560103; c=relaxed/simple;
	bh=GKwj56NSBNaPoHvzuJ04GZdG/+2wSD8BY+KftGKzKCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrOz4aM4rJV1rvnei8CWK9IJZPoh+hPdMViAmC6/hCCV6bjNfBlqM3yt+bjr+nPsCD0SMOaI6DmPfybLRzH0Yqe6VanUanrhx3yZqaR0gON945jiKXFk8KKZ5C8IW7LbflT8qG8gYl0dkdk9nhAo1aHFzGkx7dPN+O65VeOIc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIGkTrWG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af8128081so3592466b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560101; x=1721164901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rmv1RiefDelszad9VEGELmdVUB091YL9LvJn4OvSU8U=;
        b=mIGkTrWGsQu7INue9hqI+j8dnMXd1DA0liudD6hptrqFWqXPx/Ojb9pLnkQeWahwfL
         erCOyk7imfJfDsdU2SzgTj6M3W1Rjs2rJBUbuQ9ANnOtDBtma5H2oO9h347QorbbF4yD
         ai/0Sq9Zbip5X9zYthOC8wcyDA/RQvamDr1xqmOTvnUc4oLLKhGXCYuDMZbbbsDbHfeV
         roGlyW8L9EoFvnoSHkAccqX81n9bVYKrJr/QvyU+6qtganQZDA6d71LI1P3/j22148BS
         Z5KVMuSKcyMoVmekS0vEz8wFU/qlyh7xdTcJxrvRROAGRgkqtHbcp4/BYumq1RAmqOdG
         33nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560101; x=1721164901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmv1RiefDelszad9VEGELmdVUB091YL9LvJn4OvSU8U=;
        b=B7cysgJExYudfe0IMjrGdJY022W/vkxFi8o4XXoYKUmQKwkVu1vh8/eW6r97wutWBI
         0g0yVdB2dPzLmqGA1fU/W9r2qEe2J0DNyM62o5AUDvVOCsadAQ1/OSptsBpTUlVz1Myp
         bE/kqhGu5cHgpmEIjn0fOhydUKu1lBA8PhS9RwSxRmrUfkh4jysLjr3n3X+rAsHuXNMA
         SAIkPUtHUDfk/5GvZUXkKjwyQ75K9FtbcDG2t4w/6izMNyZm2iYjN2RnL4I/Diwxe5kX
         HMBXI6wgTNWG+KHzhZUk8vB7ssq1okFnDWiGbVv3UDp091J944vKfmfuDe743MkrZWN3
         JPsQ==
X-Gm-Message-State: AOJu0Yy+61J06lugGuHDFyq23yLxjeQEC3GKPNBdL1Zhp8TAvvSKH/un
	M9KrmdRxCpcdELw90ZOdL0ibyUulyg58HJZG1LSDkwNF9Xz3Nrdk
X-Google-Smtp-Source: AGHT+IG7Y4oDlU+jySdENQyJ7O+mpouEn4zT66Mw+y/ge0mR5WVLN74LuYlSgArojo3PSdf1YBTVhA==
X-Received: by 2002:a05:6a21:1a7:b0:1c0:ebca:ead0 with SMTP id adf61e73a8af0-1c2984cf183mr3999841637.47.1720560100868;
        Tue, 09 Jul 2024 14:21:40 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab75b3sm20493575ad.129.2024.07.09.14.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:21:40 -0700 (PDT)
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
Subject: [PATCHSET sched_ext/for-6.11] sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches
Date: Tue,  9 Jul 2024 11:21:06 -1000
Message-ID: <20240709212137.1199269-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

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
 0003-sched_ext-Make-rf-optional-for-dispatch_to_local_dsq.patch
 0004-sched_ext-s-SCX_RQ_BALANCING-SCX_RQ_IN_BALANCE-and-a.patch
 0005-sched_ext-Allow-SCX_DSQ_LOCAL_ON-for-direct-dispatch.patch
 0006-sched_ext-scx_qmap-Pick-idle-CPU-for-direct-dispatch.patch

While 0001 is a scheduler core change, all it does is moving the definition
of struct balance_callback so that it's visible for struct scx_rq
definition. If there are no objections, it'd make sense to route it through
the sched_ext tree with the rest of the changes.

and is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-ddsp-local-on

 kernel/sched/ext.c             |  207 +++++++++++++++++++++++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h           |   19 +++--
 tools/sched_ext/scx_qmap.bpf.c |   39 +++++++++--
 tools/sched_ext/scx_qmap.c     |    5 -
 4 files changed, 215 insertions(+), 55 deletions(-)

--
tejun


