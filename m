Return-Path: <linux-kernel+bounces-406829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2709C64C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52530283836
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813E21A71D;
	Tue, 12 Nov 2024 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FjulBd/e"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7A21C16A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452539; cv=none; b=lCVu/unEDRLKKTINY4LJeYj+SqoKnny3fBqJEGgvmOV8zU7nx+Dfvt58toxr3c8+qajLMqut3dVbJEkxr2UFyZllCzS6hwozPZp7W3qPRMkgQG4WXzKsGlFNTFpv9fix1Z8mRScYUxJnQW+eS9qjpPEmxHJvfQCUqfa8iOy15kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452539; c=relaxed/simple;
	bh=+/h/OVIt1xMoc+y3f5DsdExA+tfWxuS4CcvyCfSCZyk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=m5HMYx350CnutBv1/pQ7Npaz2PRLqHjYYA5rEeymG3o2v9c/PVvm7vZxTeszC1L7heWWker4bl5TqqpGW2Xc/0qdH4XHtC1gPMgUP4BNXdvbAgGtPn2YY+NvKcYBW0oGdHNgrLY6d75IAJV0oar73TpxhFBIqnITpV7GohgCUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FjulBd/e; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b155da5b0cso440412385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731452536; x=1732057336; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WUshJXvcMUR3pZ9oCVittkBd+qFJCly4hVcX+M04OM=;
        b=FjulBd/e/iUdQxvtWNmVy3oYDDIa7XxN9BavvfaUO/kJKADSL+/HU3yfw6s4u3+6+y
         7GcPeDDtrS/K54hIK7+XOi5/za40P3tRHZpNIdiwO0fkfRjLwtJ6RFyfeX7waIRFz/25
         qAXVG9pzstwSPS+EcFiflW96q0/UD/SvgcZGIAeOkDeUVzLcL2iX5QV3/k+BPCmM1Dqu
         oO+2m2ZfU1GZBrwiKBhG4hZMFeEAaBbknJdYR5vkRlq8x/rULE9Dj6L1jBmTxZhz/tdv
         hQm3UJbaJtGSyhO1a+qZwzmhlwU5guYVNP+kw/caD92M3sSmSEC9Hm+XlqTe5N86Xnvk
         XH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452536; x=1732057336;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WUshJXvcMUR3pZ9oCVittkBd+qFJCly4hVcX+M04OM=;
        b=C2+qKlysZMO0tsE2FiK+R7j4HqWzB8ripsPl9CxATymWdsr0lMSPeYbl+rjC8JH8fV
         obZemfTeSvuzud/XvlboHMl02EO/Cf01HW7JhBuUGhuxMIjtwPTpp4NJoME7rGVebr0b
         GLQcwK/Ly5LNTAXi7t71IGJ6LfQpPfCHh5Ie0xwVBFG3UQT05EN5b260AUG8ay6yxH6p
         ltQm3qvmFD3XDvM3jdYDf72yi9HYuNbep09hDajZkTecuK9XCG0vVMbyh1r0Kosq8kYZ
         mr6iI3pvlTrHays3FcN92J/7xWng0AJtIxXMDBFhaQhiwI235vDJk8Sj73qthTw0RRkp
         HTdw==
X-Forwarded-Encrypted: i=1; AJvYcCV9C1Qohnr67fteV8D+mx2coGes4lUbBIt3FaN006X7mwXr/X4uRqr92yS7/Nfbojs7IvoHKq84mtiP5cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqELp9ga9ZjCBbzPxDDn1ZuAfRP4NVEp0PLAU4xfM/DEgAWre
	rLxRMx0Wgz8l2d7dT3d6w0uhOPpZxeEEJwmScHNPfSIbLd0n1kvgP3sGkP8u1g9GAR1A0k+UYmA
	=
X-Google-Smtp-Source: AGHT+IGmWV3BewoUGuZMjs2WfRC7N+PQJpHK1EgVdEb9hnOhW8uzO6oU4NQKg/X+r21KgPFHAYvNmg==
X-Received: by 2002:a05:620a:4502:b0:7ac:c348:6a52 with SMTP id af79cd13be357-7b34bb56079mr527666085a.34.1731452535892;
        Tue, 12 Nov 2024 15:02:15 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acb2bc1sm636804985a.91.2024.11.12.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:02:15 -0800 (PST)
Date: Tue, 12 Nov 2024 18:02:14 -0500
Message-ID: <90954b9699f3d9f2a185f0b97ec2119a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20241112
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

I'm expecting to have spotty network access later this week and early
into next so I'm sending my v6.13 merge window pull requests a bit
earlier than normal.  While the LSM pull request is composed of thirteen
patches, they all focused on moving away from the current "secid" LSM
identifier to a richer "lsm_prop" structure.  This move will help reduce
the translation that is necessary in many LSMs, offering better
performance, and make it easier to support different LSMs in the future.

-Paul

--
The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20241112

for you to fetch changes up to 8afd8c8faa24249e48f5007aee46209299377588:

  lsm: remove lsm_prop scaffolding (2024-10-11 14:34:16 -0400)

----------------------------------------------------------------
lsm/stable-6.13 PR 20241112
----------------------------------------------------------------

Casey Schaufler (13):
      lsm: add the lsm_prop data structure
      lsm: use lsm_prop in security_audit_rule_match
      lsm: add lsmprop_to_secctx hook
      audit: maintain an lsm_prop in audit_context
      lsm: use lsm_prop in security_ipc_getsecid
      audit: update shutdown LSM data
      lsm: use lsm_prop in security_current_getsecid
      lsm: use lsm_prop in security_inode_getsecid
      audit: use an lsm_prop in audit_names
      lsm: create new security_cred_getlsmprop LSM hook
      audit: change context data from secid to lsm_prop
      netlabel,smack: use lsm_prop for audit data
      lsm: remove lsm_prop scaffolding

 MAINTAINERS                           |    1 
 include/linux/lsm/apparmor.h          |   17 ++++
 include/linux/lsm/bpf.h               |   16 ++++
 include/linux/lsm/selinux.h           |   16 ++++
 include/linux/lsm/smack.h             |   17 ++++
 include/linux/lsm_hook_defs.h         |   20 +++--
 include/linux/security.h              |   98 +++++++++++++++++++++-----
 include/net/netlabel.h                |    2 
 kernel/audit.c                        |   21 ++---
 kernel/audit.h                        |    7 +
 kernel/auditfilter.c                  |    9 +-
 kernel/auditsc.c                      |   61 +++++++---------
 net/netlabel/netlabel_unlabeled.c     |    2 
 net/netlabel/netlabel_user.c          |    7 -
 net/netlabel/netlabel_user.h          |    2 
 security/apparmor/audit.c             |    4 -
 security/apparmor/include/audit.h     |    2 
 security/apparmor/include/secid.h     |    2 
 security/apparmor/lsm.c               |   17 ++--
 security/apparmor/secid.c             |   21 +++++
 security/integrity/ima/ima.h          |    8 +-
 security/integrity/ima/ima_api.c      |    6 -
 security/integrity/ima/ima_appraise.c |    6 -
 security/integrity/ima/ima_main.c     |   60 +++++++--------
 security/integrity/ima/ima_policy.c   |   20 ++---
 security/security.c                   |   96 +++++++++++++++++--------
 security/selinux/hooks.c              |   49 ++++++++-----
 security/selinux/include/audit.h      |    5 -
 security/selinux/ss/services.c        |    6 -
 security/smack/smack_lsm.c            |   96 ++++++++++++++++---------
 security/smack/smackfs.c              |    4 -
 31 files changed, 470 insertions(+), 228 deletions(-)

--
paul-moore.com

