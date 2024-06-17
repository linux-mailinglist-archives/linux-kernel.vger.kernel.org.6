Return-Path: <linux-kernel+bounces-218305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469390BC53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370CA1F226FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640518F2E6;
	Mon, 17 Jun 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IXOj/xpT"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875438480
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657277; cv=none; b=ImRezPaadBYrfy5fKlsPbLSsduXqlG/cgqtP3+gXMr4B6cPqEdTKnWKvvtjN4drm6e8Re6t8yl2/RCBK/6xvlUIL8wbjSwKBV0B3QMRIQFaZNoACzs3TnG7hrcw4SvbqX1s3uX1kBXGHuUHP3H5cj/N1/zXtqIlJv6oq6RoTP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657277; c=relaxed/simple;
	bh=9CLcbPxHradhU318O+lke+/HjC2AVt2hnaWNP91vr3Q=;
	h=Date:Message-ID:From:To:Cc:Subject; b=aIDB0mSDotSNlDa03CW0aWy0WrioH8NnpNWxmsu6z/nT40Wk/7yl/EaOFKy6h0N0htqBGje1quCE+qBuBE3E2WAOlA7pLHQh8lRpdJmv8a/8HUFDdR/GQcHnVl87rEUGTmidCos5P88YMUVEmYzu6kCQmZz6qxslBiMkn34sSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IXOj/xpT; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b07308fe6cso20799116d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718657274; x=1719262074; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92sq+GmOYl4GyfOH+/hkMbHR0Ef8PWt4g2QvxUaxZJo=;
        b=IXOj/xpTEQ7PV/rfqFj37fDxIvZgAKtUk9E6uNQjxM/k+6dB/P6JU1W2EridMV1I+n
         GcFHGfX+Lsx+fRLYli0obHGmFsxfb4aHXqUiQfh/XzFQy1iJRtPOISYmSgV4uWlPuGFd
         v7EFEC1RDO1aRkYyAnB/+z90EOakF4vAy5sGHTf1ejLkK768gqF31eGYm/1VgyJWTScc
         VWxTop5/tylphHvOkEesbfPXw98676S776cpbgN3AcfPzee+KmGVGGbleWZJ6hXDuXgr
         hO82YUIkkuiiR/P/iLhmIso0N+xsfl2KsBnIM0IT5McwrUz15zYheWTUJKA8oCfhFIu3
         FoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718657274; x=1719262074;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92sq+GmOYl4GyfOH+/hkMbHR0Ef8PWt4g2QvxUaxZJo=;
        b=Y9arUTu1MPVRDw3w4GQfRk58hEL9Dal+FiGh10WalGFyVKV2KqNusVWBjx2Yncdsjv
         RWi/ePmCFYgho0e0lQHlpAMhVjGFpadmNuEVKCU0UBsOFVBYmGKnt9IDHzYhrHAIQ8lk
         UOT45Cq+ivqhkB6Q8vTorun/8e5sulkVmjBY/SfiFyEH19wkT0DBSnobkc3zY3RlKJX+
         KkeD8u4q7VWqTRrL496/JFkOVUjaPAYHpWQyPQ8pXG5u/uXQ9s1HiadJoM7spPxo0sTu
         QZM74TQP7pGCxPrL39UfSwXnARoutmaWvSkx4q7IMOGhuyb61GjRp4S0rDAp1twcll+V
         AEGg==
X-Forwarded-Encrypted: i=1; AJvYcCWODD012pYHu9sQCaqa3r7PDU1G+aJrJiWlSuvx4hpz/7szDtxSO1vvr7doSgVCiZZH0ksGhhQ/sb74sRdIsR2qCnIE/y++SLRYcbX/
X-Gm-Message-State: AOJu0YynVg1ACVgQqqDcGr4zfSzpuKnwMoPCQEKdftfBZo3hx/0+deNU
	9U9IQ3UVDlio4SDeu+YwXM/FnTyfzgOH367YuUEO3YWiB3cUm1+dI4ju/uyKZyzGAPoLUsGqb+b
	Snw==
X-Google-Smtp-Source: AGHT+IEqO4CUsYZVLJCb/94sp0SvfrmvTrph0QBZoua/4cXKkig5M4a/2XUdeWBnYjxcVSrA7DJsng==
X-Received: by 2002:a05:6214:1652:b0:6b2:b13c:5b12 with SMTP id 6a1803df08f44-6b2b13c5e15mr105415296d6.61.1718657274215;
        Mon, 17 Jun 2024 13:47:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5efc23asm59678836d6.126.2024.06.17.13.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:47:53 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:47:53 -0400
Message-ID: <278d13277e281ab2e358499fce8a849a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240617
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

A single LSM/IMA patch to fix a problem caused by sleeping while
in a RCU critical section, please merge for the next v6.10-rc
release.

-Paul

--
The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240617

for you to fetch changes up to 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34:

  ima: Avoid blocking in RCU read-side critical section
    (2024-06-13 14:26:50 -0400)

----------------------------------------------------------------
lsm/stable-6.10 PR 20240617

----------------------------------------------------------------
GUO Zihua (1):
      ima: Avoid blocking in RCU read-side critical section

 include/linux/lsm_hook_defs.h       |  2 +-
 include/linux/security.h            |  5 +++--
 kernel/auditfilter.c                |  5 +++--
 security/apparmor/audit.c           |  6 +++---
 security/apparmor/include/audit.h   |  2 +-
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_policy.c | 15 +++++++++------
 security/security.c                 |  6 ++++--
 security/selinux/include/audit.h    |  4 +++-
 security/selinux/ss/services.c      |  5 +++--
 security/smack/smack_lsm.c          |  4 +++-
 11 files changed, 34 insertions(+), 22 deletions(-)

--
paul-moore.com

