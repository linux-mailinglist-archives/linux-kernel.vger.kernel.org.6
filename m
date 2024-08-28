Return-Path: <linux-kernel+bounces-305782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A97963430
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918F228686F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA41AD9D4;
	Wed, 28 Aug 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reRMVEIZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93B1ABEA9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882287; cv=none; b=M6Py4Sl3xcAbtF/P+LxMWbW+Sp4MbQXPqTbw1x/jKBXW1CbhWRZAcL+gFb4AVMtGMeWMgaPdndfhQX9oYCoz6wpD9dQx+3hZD5gHSOStCL8GuvAeGBX3CfR2AU8M63W0JhACzJVg5y0jW8YK9lIBiWQL40sCh908cwkYIydismg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882287; c=relaxed/simple;
	bh=OtyZGFXNJmaTgKJUaWxufZrcoMW8yy457X2gX7so+Y4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cZvojPjce21F7R7oNra1lLy2XFQda/OBLOMSrGHeykyOaJqkhDxLGzpEUUtNBapfI38bEqlLlbwew0mE09lRPXM59zW9++GZowKxVi+VEeT98Tc++TxKA5ePdPFbrw4KYMWbRgOWqMJUfozRsReW8R+Q/caAsUSc5uQnxcdW/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reRMVEIZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e11796af1d0so17233276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724882283; x=1725487083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlgNMKNX5MS0ihntU6nNVvznZe2o+HmoUqQOC60ro98=;
        b=reRMVEIZLIND/yNtWuAe2ivXGA+VH0sroWZVggOMM9WDku5BVbFOARd7plrACpQtLw
         xHRRDE6C4f6X+epDoQRF1NJxP3VrOGEeRxlTGvDN9hoX12jcOHSuJDg4r5Pv9xf4z3Vo
         BH6fmQDHmCBMD7d0/FXPGA07J3WaYp1vLIr3L9ParwHrPquiXzwYsx2BmjWQeNTs4LFq
         a+A8Yl6UeOvp7cJeB8ui0rZdtSKn9ckBHVUpbnBGLbUOqEBqngtn9TduyCvLE5pzO5t5
         dp99bcs43Fz88iMxX4j5cAfTrjolIqFZKD7pSAOQTsj+QCofKPloHMyUaZH3a9vS5S41
         RPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724882283; x=1725487083;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlgNMKNX5MS0ihntU6nNVvznZe2o+HmoUqQOC60ro98=;
        b=jFYWaNBHHnoHjgHLlHgjqaib0GmUkhmsoIDgS0qyuZetrwtk/11ETqgHSIxSWCPa0M
         dAWfZVw88M1ZkCRSh5g4L1J6YHreoILlw6IzBPkxQcGxRoE7g4uQGpPpXZxrWytviOhZ
         3bujsGgQQTHDfi5s7MCt8/hzjYb/jdyb58+mMjqYfjy0lFF0vglGHY63YadO8WGcO4I5
         MijMVv/mIragr3aspnMoeg5kOFqQ20TP0ZonyHq0U89VFbpacyIANJfqDl6Aj9RV3SxQ
         0/5XxIC+17Db4hjUKcNfggQPtUEH0lT4iTNUg2lN91K5qnBV1SULlh8IOuvJKd/QZzlH
         PZCA==
X-Forwarded-Encrypted: i=1; AJvYcCUJrVgG7MJFJpLBk2HVdzl1QhcnXZtAqsKG7t+Y0IvtJzomoBgpVIwMTwj9nO2pht2R9MudQNkoMnH9US8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENZ7TBruOOorEy1Q69Sz3i/OIjKnOuaVvalABHZkHuicNETyW
	st1UShCL1S3g/dxVbvbcdjjVD2ADLOdeQqiZ9Lf49Zv3mN1eXAqHIhwbwy7q0yMZqbBujMMd0lh
	ZXQ==
X-Google-Smtp-Source: AGHT+IFt/U1L3elAJgmabyUwqBFMXxU/9PPvPxX8OhqgwG2AJc39YZ2qQsYr4fivt/vomf8f1YQpHuHB8ng=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c54f:0:b0:e11:5f9f:f069 with SMTP id
 3f1490d57ef6-e1a5adf5550mr1448276.8.1724882282732; Wed, 28 Aug 2024 14:58:02
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Aug 2024 14:58:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828215800.737042-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Explicitly include committed one-off assets
 in .gitignore
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add KVM selftests' one-off assets, e.g. the Makefile, to the .gitignore so
that they are explicitly included.  The justification for omitting the
one-offs was that including them wouldn't help prevent mistakes:

  Deliberately do not include the one-off assets, e.g. config, settings,
  .gitignore itself, etc as Git doesn't ignore files that are already in
  the repository.  Adding the one-off assets won't prevent mistakes where
  developers forget to --force add files that don't match the "allowed".

Turns out that's not the case, as W=1 will generate warnings, and the
amazing-as-always kernel test bot reports new warnings:

   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/kvm/Makefile.kvm: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

Fixes: 43e96957e8b8 ("KVM: selftests: Use pattern matching in .gitignore")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408211818.85zIkDEK-lkp@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 6d9381d60172..7f57abf936e7 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -5,3 +5,7 @@
 !*.h
 !*.S
 !*.sh
+!.gitignore
+!config
+!settings
+!Makefile

base-commit: 15e1c3d65975524c5c792fcd59f7d89f00402261
-- 
2.46.0.295.g3b9ea8a38a-goog


