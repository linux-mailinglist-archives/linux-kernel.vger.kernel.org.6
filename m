Return-Path: <linux-kernel+bounces-547105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B2DA50312
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91321677A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9B24E4A0;
	Wed,  5 Mar 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PwhFruKd"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D79221F29
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186782; cv=none; b=LT3JLRtgz8i4tDUdESzAQiurxtKeenW6uYYF7HgdiiYQ3jsVDHP315kDSWMrC7Ns2FYpxleA4xOYymSGNnSKp/9nrIDJtWJpPjqp3T0FTToZLGF4fQYPf1YsXo0C0grbP5sl+5UtPXJLVoiiF0PIxTmYOp8Kz+Jla5UhhnOjSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186782; c=relaxed/simple;
	bh=UlHxI0GLM+MucAlMjbb8mi/mWOr+BHb4r/ki3qFFvGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CZd9PzMxHPRI5qJ7ggYRiFrnBmoB2T0sqsq2pbiYoo2n8p7Suf/D+ulphAVwCNywdSMBLjOl0hp+xltZ7Uzvmmjb/d4Hn3H3cQMWrJ7x25/+6y+jPI5Sy/cJGh2J3PH/hd1GHAPO3ldP8Xz5OcdoST15lfi2ry32MNYLRBOXu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PwhFruKd; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-390dd3403fdso5894514f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741186778; x=1741791578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPsHEh/NrQR2RMMobt6Nu3tWFHwHhhyGMgaAaqgXc7U=;
        b=PwhFruKdaWn+y+MnuDa1rhe2FzB3ibyi0UaiRiiZKhO9h3Nq2LIqdQYynmRPk6jmHI
         S3HdJlNi3o3S9yVBZIffqV25FP7COHI/twCZCZuXtKQbzH1FLVjpqftwb5OKcT6gRrut
         rXrsm1otT7uwrOOJoQSB4t/uSTUVVhUpDksDotuzptw9l6duCkdIly1ecxVKp9he+6TK
         eKfNTc59zS2/MAs5FpE2z+6f3k7pDFs1LFY+MIaxo1v9e6wsPRHtYr0AV5k5laYLXZs2
         3gcmVO25mg9VBDbScyu0FarXNrEJpmzfOgNUrWrbA9DzWsNJ3t9Rs+D5PdUnhEWOXkcP
         zdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186778; x=1741791578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPsHEh/NrQR2RMMobt6Nu3tWFHwHhhyGMgaAaqgXc7U=;
        b=e54AEtn1x0oN3b6DRthf8AxqMlziHiR53RHNM41QEElNvwnpvmBP7sBXoVpn4QdhNC
         z1kdqfjE/Kbk7jxkYvBA1+RXN3trMRT6c+WTXvDFlNpg1nxBa9gbhFNUGceSbcJqz/qP
         HwtDPKQGsAYKvMTZ7HxR5T3hO8H8+6YCDCzlSyQV2Bber7R+GvN13jzcaWfn5shwRPk4
         7bNjX5BPSctbEqm57eRXUlOB3fZkm5tULdyU+39QF1BxvuzFgs9vd5aWsbazyIPO/fU+
         stDD5cBId6F/PvO/Q2mzFdly6FxcekiRZUByN4sxLd3weELZhwRe1HL/47ABSFTHHudm
         o98w==
X-Forwarded-Encrypted: i=1; AJvYcCWBrDGU9h8s5JBYnh6N69RYAvGfaonrQIceZpjRm3CKPu70Js6FiO5KsPWyUyD2hHlkYvfm6ukiYiQn9uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTeD7q42yMi2bKxuoEttzC/ZsMth0tqLqiF9PNJnP3q82I/qW
	M7Iz+Cv5rRmUdDsb5mYijLChM8yUHeFd49UJpeCjSKYBZeuiLqUewq97c8hZ+bK7m8KMU5sNkbn
	WjaUbbg==
X-Gm-Gg: ASbGncsp+T2nZUlo7ZJIJ7oHf3qY/XYs0c+UrV9njkLkQqw/8Rfj2CLCKQY94jimxVQ
	PXpE+yobPB9z1lM4MghaUWqIbZ+Jw12MZw9+4Ys7zUk67D1FpVpQicyATyHXv7RItvAFVLcBATe
	JW4xhAPr5yVjCS9WcnCOW965D6+uWP4siD1aG1DbcI3rv6M+dCFRLRRTVDXiUKVi0jyCpWlA5Pg
	hlMjsh07o/lvyx2v5ZJat+2JrNI9p1YrqsopzMoOpznbijgYVj0bumqohJMwvq5JUMUQIDfgJYl
	klo3M+zCPViVPiVk2aSxjRG2SnELL0JzXkmG7Y0KDR4rfM4=
X-Google-Smtp-Source: AGHT+IHB6GyywhrgQ56YWawycgsn/CJT7lerxxfaKzX88S/TWipFnbD7TokNq4VvuAv7ie0NH429ow==
X-Received: by 2002:a5d:6d87:0:b0:391:952:c758 with SMTP id ffacd0b85a97d-3911f7272dfmr2815656f8f.6.1741186778254;
        Wed, 05 Mar 2025 06:59:38 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a66adsm21058750f8f.25.2025.03.05.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:59:38 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org
Cc: Joel Granados <joel.granados@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Wei Liu <wei.liu@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH] pid: Do not set pid_max in new pid namespaces
Date: Wed,  5 Mar 2025 15:58:49 +0100
Message-ID: <20250305145849.55491-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is already difficult for users to troubleshoot which of multiple pid
limits restricts their workload. The per-(hierarchical-)NS pid_max would
contribute to the confusion.
Also, the implementation copies the limit upon creation from
parent, this pattern showed cumbersome with some attributes in legacy
cgroup controllers -- it's subject to race condition between parent's
limit modification and children creation and once copied it must be
changed in the descendant.

Let's do what other places do (ucounts or cgroup limits) -- create new
pid namespaces without any limit at all. The global limit (actually any
ancestor's limit) is still effectively in place, we avoid the
set/unshare race and bumps of global (ancestral) limit have the desired
effect on pid namespace that do not care.

Link: https://lore.kernel.org/r/20240408145819.8787-1-mkoutny@suse.com/
Link: https://lore.kernel.org/r/20250221170249.890014-1-mkoutny@suse.com/
Fixes: 7863dcc72d0f4 ("pid: allow pid_max to be set per pid namespace")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/pid_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 8f6cfec87555a..7098ed44e717d 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -107,7 +107,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 		goto out_free_idr;
 	ns->ns.ops = &pidns_operations;
 
-	ns->pid_max = parent_pid_ns->pid_max;
+	ns->pid_max = PID_MAX_LIMIT;
 	err = register_pidns_sysctls(ns);
 	if (err)
 		goto out_free_inum;

base-commit: 48a5eed9ad584315c30ed35204510536235ce402
-- 
2.48.1


