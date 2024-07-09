Return-Path: <linux-kernel+bounces-246682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBF92C52A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282F3B21D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C5C185625;
	Tue,  9 Jul 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF5N3Xh3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE618560A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559409; cv=none; b=XNZXPN0afn9QQweLo3EkxrZQBUDr/7+yPp4WIrkmEhft9aFZGaNXTAcUHjeCmG1D69BfjbFKGIZsmz0g3ALbMA21XIodEUhYkWvQb42BGqzLqAeJJomfpdWVioT/Z3HIVTopGJJZUMw4QftCLbdywxHgRg6rsWeNaG3JBsFk6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559409; c=relaxed/simple;
	bh=p3D+YYIBhZMl0KHbIiV2WnqcwM7wCCxOcRk9UL85e8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnIc6BoPHmlzuyF26vE8ygm6fwx+LeSZ06Y6h2RhSUHmRGxCHQ02j2LS4jSrtIbDLOZ7Vx7zcV7F341p4pmdszkuIkD8Pp5hRoIxlrmqd19nW7iI5eEmZ80WnM8ufGucocYo94SyV8OEjtNIPQh4xLM+esOw0Y+wRigxU6/HavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF5N3Xh3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so37835435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720559407; x=1721164207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lhVn+Ku7OQEDXxxMU9b9vNeQGhvJasTHjIewL8mjYK0=;
        b=WF5N3Xh3Wo/criWUlf5t3HXNU25I7pzklLZs5/e4eP7riUWiRnoGlgpAs77eImHi6T
         UTfKQNVi0PJAl/RlfY/4kX/nf2Fuq/ibtJYS+KgG8Oau9J3e5XctDUB/8D+io7AIImCd
         FodRDPzAWzCH6hplu84UDutTn4/tC+tctIks36HsAsVXCyP0CFiCpc1zsap7PYUqKO2Z
         euwUE5tX2vaFb0jRoEjqT6dKR7T7zoaEyt5E03vmUVSrbDFIMQcBnrt1sPGvqLhZk8eJ
         HpDOI+xVhO1N9AFJB8Al0gfa54JPnzcn6SzGH+4JgckOuMjrC9z8gDfnZAC5N+gONvxe
         7O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559407; x=1721164207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhVn+Ku7OQEDXxxMU9b9vNeQGhvJasTHjIewL8mjYK0=;
        b=Brx09rpxFm+8M948q1fOxRks+Sf9LreLaIuPvA7vXVRv15kWiF8ohCgPXfN4W4a56z
         HUVkvWbK0cwUZuoXx19Za6+NkqGGbwg0cgB/IjXD6P1KZ82aPlRzgsRkNEZ6bMZfSSiT
         wy5seHQoyxYZqgZtrB7M/e6wWn/xEEosSISvAhosEAq9wobjs6VwiAA73VD55uOsEUw8
         V6NKo8Ys5n6XVSCddB6UNppmckJWGmE4d/uXTjhfy7sJ832gFoA+K3I3dNAmoFlFZ/0p
         nsaXZpoTh8tc7k2BnvB7Q/1vrvY5AbUqoWTr7DyzfVF90JLnm79ghL19vuKBWeSZroHX
         kErA==
X-Gm-Message-State: AOJu0YzlYd7BTuXI2W08rehvOLaWjLwSh3oVI4uLVvLLiYlHEdVdwpD6
	YmGcDWw3smGMlYPrBoqCkMwfuKvxgJryIXNITAYGCi1pFeGsPFgHixC6vg==
X-Google-Smtp-Source: AGHT+IG7ceVmjhDGGvB2y9Rwwl8RPAi9Vh/TaLRAmMWs4JbmUEdS0dW8D93yOOlf2aBfha7YTVjtSA==
X-Received: by 2002:a17:902:f645:b0:1f6:fcd9:5b86 with SMTP id d9443c01a7336-1fbb6ce51e0mr32638935ad.12.1720559407094;
        Tue, 09 Jul 2024 14:10:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2acbasm20521565ad.81.2024.07.09.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:10:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com
Subject: [PATCHSET sched_ext/for-6.11] sched_ext: Fix scx_bpf_reenqueue_local()
Date: Tue,  9 Jul 2024 11:09:41 -1000
Message-ID: <20240709211001.1198145-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix scx_bpf_reenqueue_local()'s misbehaviors in two cases:

- when SCX_ENQ_HEAD is used to dispatch a re-enqueued task back to the same
  local DSQ.

- when the CPU is being preempted by stop_task for task migration.

This patchset contains the following two patches:

 0001-sched_ext-Reimplement-scx_bpf_reenqueue_local.patch
 0002-sched_ext-Make-scx_bpf_reenqueue_local-skip-tasks-th.patch

and is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-fix-reenqueue_local

diffstat follows. Thanks.

 kernel/sched/ext.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

--
tejun


