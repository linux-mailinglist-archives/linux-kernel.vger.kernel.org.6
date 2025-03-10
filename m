Return-Path: <linux-kernel+bounces-554139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36DA59365
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EE91890DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10C221726;
	Mon, 10 Mar 2025 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="X8XMfwpK"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE49221733
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608278; cv=none; b=YmiEyvc8YFsro59t0v4j8SJKpCmmMFkRGVQNsCE0LqBJjHvRnaYjlwdFByTepOeN8L/DTnvxI2uSJe1yvc5m3zFOCq5q+y7I+AOgCgWjedsqXa3T+N2spF4b3uI0OwZ0HkVmu5ezonwTvWrIAULLeS7Ezg8ohRywXRE+I0ysvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608278; c=relaxed/simple;
	bh=Npn4X6d6WGu5s6M3va8+mm8EMB42OwT4Yrz2X7vo9ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4gxrQUKPMYd+UmhzNjU+Fqi86uhmQSwmh1XmAtn6fsXqfNc1fY1CaN6NeM4EZEVvyvz7/osyRA2l1hCyQGYJeuibQ+3wVZsBPsUWa42azb9s+n20GHgfqpTmc4YRwDZWLHx4HZUhJmz4AqTcUCDK0oYeutq+PlTJfKja9fNthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=X8XMfwpK; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EB62A60EA5;
	Mon, 10 Mar 2025 15:04:14 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-4JGepy3f;
	Mon, 10 Mar 2025 15:04:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608254;
	bh=x8DAP9eUkaG75fkMO+dR1XpuCnXAgRk3qwZNeEbFzSE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=X8XMfwpKpDu3TGM8eK67J+BXWD2pI0JbT66tVSPMZZ0DiCY2JiXh7/uXc320kZaMU
	 IJHEWFV9cPloQKHvb18wQ0KuvOvE+q0ePmRIbCRYatLzo/haokQJ41l3Mfs/0sOpwX
	 2f3uIuhOrLk7paFJV3a+Y4xsnqPm9YHI58QoRTVk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 6/7] kexec, kstate: save kstate data before kexec'ing
Date: Mon, 10 Mar 2025 13:03:17 +0100
Message-ID: <20250310120318.2124-7-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
References: <20250310120318.2124-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kstate_save_state() to serialize all the required data
into the kstate data stream.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/kexec_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5d001b7a9e44..7dcdaee14bfa 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1017,11 +1017,14 @@ int kernel_kexec(void)
 		error = -EINVAL;
 		goto Unlock;
 	}
+	error = kstate_save_state();
+	if (error)
+		goto Unlock;
 
 	if (kexec_late_load(kexec_image)) {
 		error = kexec_file_load_segments(kexec_image);
 		if (error)
-			goto Unlock;
+			goto Free_kstate;
 	}
 
 #ifdef CONFIG_KEXEC_JUMP
@@ -1104,6 +1107,8 @@ int kernel_kexec(void)
 	}
 #endif
 
+ Free_kstate:
+	free_kstate_stream();
  Unlock:
 	kexec_unlock();
 	return error;
-- 
2.45.3


