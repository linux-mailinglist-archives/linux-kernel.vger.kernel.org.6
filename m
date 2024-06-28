Return-Path: <linux-kernel+bounces-233259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900EC91B4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167931F225FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077A417BD2;
	Fri, 28 Jun 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y76JuATT"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59718028
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540619; cv=none; b=nNifR0HN2N30xWfxIdbPi0q7KT73a906wuA7S504stLl5VMYayfZUZpfeSSQq76IxNmLklHwLQEgUZuL2oSEehxFFKczqzviJGOJcr0gO83QfoVD4/xnMP5N3Wn0/Vi6uw4YZdy9ANlQ7KT9rx2cw0F3BXvAH097/M/Ih6CkkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540619; c=relaxed/simple;
	bh=KwfHzd2ldFxaypFOroC+XdF2BelSNa6KiFWOGRPVBHs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J97RW5AdzbTpULilstgw8EUaExK6FOXjCqAwAmbzbgGFTUQDv7hSh5dzTfD9iFN3K0HB65fG1edxfEc2oyZyGIadtiuu2yG9usqKqa/QIuXyLjTpls3Q9nddpG8/Ah9amH1GnsK9tM4dDcuPngIs0ByR3r/JLKsF9AnuS/BV6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y76JuATT; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-375c390cedeso2073585ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719540617; x=1720145417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJVD1kO2ZVSodffyKuYzZBZLupRO0YSdINaUO14q6ys=;
        b=y76JuATT+DPDpeiBQsedL/pSb+byga5TRNtH+c8+2dEaTFKjSpepnCAaxMljUvN6hn
         cv8x2CKtKbdMcUQwqyxKumlSS+iizRjvMwdDW9fWD5xkKBo6MM0yk+QLbJyCCeOXJkG2
         ynoBbtFUd9yKPPyK4h/Adq/ZL4g6WzW54netsSetU59iVHnuDJZ15c81yNUamgq/KteX
         uPVXu093Ws06e6074Hjm47UsNFOYx5EDe+CHFKyUU9wm5OaqdrdhqwviBeg6gU5RAXLz
         Y62PJqy/esI3sZsR/MCtQblYpwq8EuyMXhEILf5LJpSQ2M3blIhnyM+qcJoo7qPCoFlS
         0zJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719540617; x=1720145417;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJVD1kO2ZVSodffyKuYzZBZLupRO0YSdINaUO14q6ys=;
        b=vBJkExK4D/l2U+0+2k2DH5il/Qsqsa66BrjjENoJFngZoJv7bdrontyRZrArMMdNPB
         iowHU4CAodnFCGoxw4Tc8qRxKAHeO9XIJU9Ah7DhOrH/AsOY6Xw1tcBpyDnxPjIEfGm7
         rEw4ejbIm5LnByksT+Nzcsmm/mN74EilTsJR4bBWWSj/LdbGPGnvfDsyVq0k4U69o7IC
         AsZGk61KZSs1QbO26ko2phN2JQuTA6BSFtgXpGca+rG7UtDgbr4f4dPx1RfCUN6Bcvx1
         V86IblvSkw8xiUFydPfWKHKImaVwo3PY+nLOBmH6+F3K9vPh/KXeUZ3a//hZCkY3weJf
         D1/w==
X-Gm-Message-State: AOJu0YyCIzfuncQCIBSY3bJYhvyIAm4MVHjP5ObUuTQRzzQqNdCI8Rlw
	hROJ7DJ5x9DTdMHAjt3wwLscRI0mcEUBuxjM73mSgvzE9NejFsBCtwBGQETFIwgGZKEQQGJzSZB
	zCA==
X-Google-Smtp-Source: AGHT+IHp6BLEbHfaOCc2EizlV1RQzISTP/mr1WjZWk+vFNQbyVIzr2lS9Lb0vbaWpcUYu60NYcJOIHYgJVo=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6e02:158a:b0:376:4049:69e4 with SMTP id
 e9e14a558f8ab-37640496befmr15052435ab.5.1719540617067; Thu, 27 Jun 2024
 19:10:17 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:10:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628021014.231976-1-avagin@google.com>
Subject: [PATCH 0/4 v3] seccomp: improve handling of SECCOMP_IOCTL_NOTIF_RECV
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch set addresses two problems with the SECCOMP_IOCTL_NOTIF_RECV
ioctl:
* it doesn't return when the seccomp filter becomes unused (all tasks
  have exited).
* EPOLLHUP is triggered not when a task exits, but rather when its zombie
  is collected.

v2: - Remove unnecessary checks of PF_EXITING.
    - Take siglock with disabling irqs.
    Thanks to Oleg for the review and the help with the first version.
v3: - a few fixes suggested by Kees.
    - add a test to ensure that a dead thread leader doesn't prevent
      installing new filters with SECCOMP_FILTER_FLAG_TSYNC.

Andrei Vagin (3):
  seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all users have exited
  seccomp: release task filters when the task exits
  selftests/seccomp: add test for NOTIF_RECV and unused filters
  selftests/seccomp: check that a zombie leader doesn't affect others

 kernel/exit.c                                 |   3 +-
 kernel/seccomp.c                              |  30 +++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 131 ++++++++++++++++++
 3 files changed, 157 insertions(+), 7 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


