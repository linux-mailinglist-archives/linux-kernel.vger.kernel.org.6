Return-Path: <linux-kernel+bounces-558477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F5A5E676
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B8D1897E01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A721EF091;
	Wed, 12 Mar 2025 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="R8AMoyi4"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AC1EE00F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814577; cv=none; b=HfK7fjOOq0Ppw1XsQdqA7CRAk5VEEch1mATLceCYHYqTC3fzMG+mvbQejL1F2rJtBkXZmLxRavvHklhbvvwi+UYQTScGbFbvkvjcUReFVyG4x7Qmuam0JUgPqoOdeFc4X9pJDEkQu2o/ES6Elyh0GvKG/eq1PnYgY2Kmr9rqguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814577; c=relaxed/simple;
	bh=b4+VVCuulTVS3lasReYQ2g8sMWbZpqYEurik+q7TDIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIifF+7WhR8o7oz1tGfBnmfMJcLxPkw9cQKbAmdOjkbUOXcwti1XGwD60oNgIPiC04m673S2o/a6caDOy1iODYWwNqycUgsxpp0RuOCJuGh9W0tQ7soH1PHu2CCLEhPBi+xirLp0ahzYuM2hzjRRyh5Cd8UInaE240eXjP7gxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=R8AMoyi4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C46DA3F72D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814569;
	bh=uqtVwBDq5g90YIrppYWGT9PUS27SLEfARyjY6b0CvJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=R8AMoyi4bhODNm305KBDX20h8UhWeJ3MOBSXl7Vq8utyp+yoc/lB1JLqzW2zcWBaJ
	 rzX4UIwFTfFb6Xz5L2xiYdVo/v+U1kBRWz340piaXHpFI+vEILVfL0cTVou9a20QNd
	 czzw7EzuHFSefnl94FjRicY7F+/pJU3Wij9SNEC+pEiqkepelH/0wb6LzD85z4BSG1
	 6aTCA5hlmMY6Zqqi4k+DOdBfGzIC1QL6MStjYgBF33M2XvCCppQ1z+Fp+APzOczUcF
	 AYOD0k5qGvMQUnmry40JSe3VP+1chOyKz+i0DM68aXafx4u3RnsCJd/HdyCVSd/6g9
	 fiPB2w1j63xhA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso734270a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814566; x=1742419366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqtVwBDq5g90YIrppYWGT9PUS27SLEfARyjY6b0CvJw=;
        b=MWsjWyggyE7iYyACmDYFq2CwhDSQIgEFvs8tL1A0hMMmx2Agvu0c1uPx1Ricawpm0B
         7sddaJ9a/XU2YWmTfckN/Di7gqFZZWhB0wusNZdhl32FCW2miDqYs3rwjbPJSM4jMCEj
         99GxSVDjyjKa1oCGhSHU2prhVgeV098Dyxr8ncNfYt29TOKuXUI8+Nvj9M66YrWqJ/vV
         EV250GEZ0k9vwxjC7LfEyJacYSvXjODg6UShmatmE1KeWaA+4+MV4w2aZI2ybkxkBz52
         L7IuDTB4eYbowDgJ5oGFaOJyNwJAILDVqbH2rhFVVEjz3Ktpti6/1d4kC1lJ5ysVLEiT
         cWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE5S5QTYwgtN7/1F04gyjO5HNoCCli/EMrk0KHVSR6yU2mkKfXg380yklffCIv1+GO4q6eJvksCCIzLnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9GGgn/7pCt5eIm9ch2cevd52TbbXC33pMGcavfQ87u1HhPSM
	F4Fsn8Wj8be4ZtA6jlAH1pgMAVh1DFodpgLmCzkchU0DXNP8EL5U/MeWyr+8tJ+sv0OPySwglLs
	Sxo1ueBWgFi8g4BgWnFUZ/0Cj8rt4VBp14/xVxfW+YPevIcREjLMRBsOhQcaNc7a8P0vVZVW1Nd
	Z7ug==
X-Gm-Gg: ASbGncuRrZwSj7HTKPsZHv2RTlNL7Adrw1QIzZvaG7/l52DMfJI/X3mss3VMBigot99
	vIJ2NfU3mn5Kgz+FtuAUUKXd0R9PwZWucJmKM2FMpaORpsL+Zqv03l7/xpCzVjODjvym6BXwYlF
	wL0E6FItCZKb/sycVh6lqxqbrO+K80aLvsuLufBG7H5lbGhXMykNiaW4FyCmmz1+JVCs1P0gh/G
	YOBdQo+FqZZsrHyO7ZYLxNF0ILa50CUVC9+VEDDeh2mgO56RXW6PkHKzyGhgByVRpORSxbK5iFx
	BrRbYt9qOSRi8qEwkVBKsw0sRg/ON87o9SyBvPGGSrkFl+4SQvOvpD48/nfRfXKiHBTnmHw=
X-Received: by 2002:a17:90b:38c7:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-2ff7cf2a4dfmr33760040a91.29.1741814566534;
        Wed, 12 Mar 2025 14:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAh7edf+w4rzXzQLR0fkq9YMtlXCTroL93A1jr+Tsldo2r/RTEDBE9CJvpxWToVeKTIWZWGQ==
X-Received: by 2002:a17:90b:38c7:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-2ff7cf2a4dfmr33760017a91.29.1741814566237;
        Wed, 12 Mar 2025 14:22:46 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:45 -0700 (PDT)
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
Subject: [RFC PATCH 2/6] apparmor: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:42 -0700
Message-ID: <20250312212148.274205-3-ryan.lee@canonical.com>
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

Previously, we saw O_PATH fds only when mediating fd inheritance on exec,
but because they would have no request associated with them, we would
unconditionally let them be inherited. Until we have better handling of
O_PATH fds, preserve the existing behavior of unconditionally allowing
them.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/apparmor/lsm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 11ace667cbbf..2349a1dd41f4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -647,6 +647,16 @@ static int apparmor_file_open(struct file *file)
 		return 0;
 	}
 
+	/*
+	 * Preserve the behavior of O_PATH fd creation not being mediated.
+	 *
+	 * TODO: we weren't handling O_PATH fds in aa_inherit_files anyways
+	 * (all-zero request -> fds unconditionally inherited), so proper
+	 * mediation of those will require changes in multiple places.
+	 */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	label = aa_get_newest_cred_label_condref(file->f_cred, &needput);
 	if (!unconfined(label)) {
 		struct mnt_idmap *idmap = file_mnt_idmap(file);
-- 
2.43.0

base-kernel: v6.14-rc6

