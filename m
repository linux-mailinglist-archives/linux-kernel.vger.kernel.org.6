Return-Path: <linux-kernel+bounces-558481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE4A5E684
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89687188AB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68411F1303;
	Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vmL06F9F"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDB1F03EF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814581; cv=none; b=UK+iMwznytzGY0HBu3V41LtSiKyVVfhWKYNw5uqDyKyvRSaqF8bMSJcJ9hpvD9HcnXw3pse7AZ2xH5eoWLq3XfxLwKUFHCZ4hIhTSCIdj3/fucLh1JUW3AXY0JD18TabLuvDLf+Jl+GEIA+EpCwDrkw1iVBQi6OMOg59MjRqV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814581; c=relaxed/simple;
	bh=YKJUOhSAlbceCTtQeFmVs8IFwOcyWaVLfzVCuOajKmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibndG6pcnqLfcTJg6GV3DkzhFAbIPx3mGBg4BCxzZ3sa2Ek7RPOCXFsriAT+vzcWwpEdEvplT74HhrD/h8IkUaeKZK01tIOcTa1R/Gc5ljTv9PgssQi2D85HZ6c4WGnzqXuyVSS7FwxBJoWUVo6RYOi0R23xXdsppHA2IjC0h5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vmL06F9F; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 49BD33F72F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814570;
	bh=bQ5ilq+qjctbW08HSKcwKvLmj0dzCcpGagg2F3uVrL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=vmL06F9FBtpJLaaYr55tRaWWAuRysWlSghmlHws+4ccfGIOKu/r09XtkJ0t2XeANd
	 i6mp2xCB2TcwZfGBQQko9G7AptQBV6tAVGPPt+Ny/IdmUxR3AsLJcRYT2JF93t6Tbr
	 KPIAH1xPhRWNs9Yaat8RznLCojnUFhn1uD77B3EU+nWlfhWXPS9b7txWNmiy7XJQSN
	 VEq4ftfPlpUlroju6uaPfkAmUVq4lAYrho/T2qX/+pcv+/MHxlKcIfnPIKu7pMUieM
	 I0sgw/skR3jkjn7NgU72gDmhz8J2SOkyySW3W8l80To2O+b7ga9qDH1LkXYoZkSmiq
	 C1faCZS04BR3A==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-301192d5d75so804185a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814568; x=1742419368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQ5ilq+qjctbW08HSKcwKvLmj0dzCcpGagg2F3uVrL4=;
        b=cyLJ3LXVnZ3s+ZUBqfMYH7ZodnAugXitJYzj8aFPCC9XGRC4SeMZo8PzXP68rw6KnQ
         HrNEl/6jb3QUeizflXKGbWSRIedQQQrP43cH2HnkVGDdPvmkUELm6O11U6IRgAMgZIIP
         VfNs5HlhTis7VgNghE/hlYyg5ick7S7+J2m6k3c0otk6mMeyyAjY2+Xkv7zb9D5Qq/QS
         GWFAATjm6/lvWAzknbp2trhoctcoubl1FVAX9j2P9PmXp5u/ZtR39IW3w0qb5yNwJNKq
         lh+JMymE3Hszq8UUArz/z057D4M7m6PIJmguQNjbJjXZGfLK5Yt43j7rEdmfc4VbDDXs
         pb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyMwZNbbo8oHlip4brwWigMZ4+xDOdhvZm+FYFQit+c1lI9c5dymPOwSOP/iVVWhrIsVP/3BWd9P02RH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9/MdX8CHDVBclF/H3oLcDdas9a8L6v7yggO5MlGa4nIC9Nm2
	+lRNliRniMo9ci95W9emJFpBrmDvS+rjIFDpOZKA8Ckfj0gUr62Bi3JNDicTSwBKwaETrD1FArB
	Dv2Cgm+3dI8TujnJT1qwCbiOQH4qhUqdU2MMkqTuvCZPuel7yjsMMmVQZ8lJxpIdBZojtCy7wDA
	Rx2w==
X-Gm-Gg: ASbGnculUTHp23xx4tMIYb1FTLNxBfijcWOuZQagtGzmyDo3egE7EjGjoTfv11eodq0
	vpVwjkko0TmHbun7tdNaLQHfn8jsNC+IUHO+RspjfBMGBf73zmOG85FvI0bY6U/LTnDB7227NVJ
	ZFK1TCj+HSuqQyMrtsY6cCrrnon6+NGl5HBXUXBSiuXIyQZC1Ft7BSqj4WJt7YcPE6Mj7u2xKu3
	/mlT64wbv1KKh84BCZT5lL5vdGpZ0Zm4NYxm0gfAGmfn5bAJiC3vdr57fK2qnqKv8l7IUspe9TS
	545MuuWnRC6po0qJm720Qnp1gsVQRNkO09M//VTlc+1J+zaV04ycvQnkVFxOz0WXUbNrelY=
X-Received: by 2002:a17:90b:38c8:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2ff7ce84c7bmr34243258a91.20.1741814568678;
        Wed, 12 Mar 2025 14:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6kNFGkR2Ar2yfV2Wm7/OWkigwZeggzkNDef+VFj2HbCWbxEzVxXle+EcNd+qkPs6JAUusng==
X-Received: by 2002:a17:90b:38c8:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2ff7ce84c7bmr34243239a91.20.1741814568350;
        Wed, 12 Mar 2025 14:22:48 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:47 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 3/6] landlock: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:43 -0700
Message-ID: <20250312212148.274205-4-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Landlock currently does not have handling of O_PATH fds. Now that they
are being passed to the file_open hook, explicitly skip mediation of
them until we can handle them.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/landlock/fs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0804f76a67be..37b2167bf4c6 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1522,6 +1522,14 @@ static int hook_file_open(struct file *const file)
 	if (!dom)
 		return 0;
 
+	/*
+	 * Preserve the behavior of O_PATH fd creation not being mediated, for
+	 * now.  Remove this when the comment below about handling O_PATH fds
+	 * is resolved.
+	 */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	/*
 	 * Because a file may be opened with O_PATH, get_required_file_open_access()
 	 * may return 0.  This case will be handled with a future Landlock
-- 
2.43.0

base-kernel: v6.14-rc6

