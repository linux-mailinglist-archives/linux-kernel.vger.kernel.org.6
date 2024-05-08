Return-Path: <linux-kernel+bounces-173602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F068C02BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96523B23283
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD07E564;
	Wed,  8 May 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+dfqJLu"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302A8828
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188426; cv=none; b=MpZd7ghpA9lgWiiholT2ZSnKPBP+92dmpxQrmhzypscghBFqmgZnkhF+0C66XoHomwgfMbJtsuqn8U4EL+MtMpovDY9MiDYARq9xk6bNM2gISIkx8Mnx/QFTHk7nPgYuXLqzzJrai9vD4Z5FAc8mDnUBAGNfym56iBNHNEDzdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188426; c=relaxed/simple;
	bh=xt9M3exlnZsdvMPnoHPpDqdV0gMIktR34CMLamkUj9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gShuAdREGIa3GrtMamsfgU2iQz7x1yVMjKjP6N/d3dqpITK/fuHULTpd1s2Xx/Eb9QqcZ4nTGfgBhcKJ6g8YwS70hcfi0p2rvilWjVHJX53QygLot7TP1G7zC2FZeqkPgRuJl6rRopdBkOAgfM5zXZhaIjgAOhLLpoZ9uMlemBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C+dfqJLu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b4952a1aecso10434a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715188424; x=1715793224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr+4jFwVlj6YM7AOT9GiLxeZOlIpMfOTLQ368UMxy2U=;
        b=C+dfqJLurzlyBFIrSk2/qmsvx/5mlCVFgibcJDlFD3Jh5wjocvg/tGm4NFmtY05Q+b
         PbMrx+iHE2dVPmlR91Xv7RHsXig5Ui35d9pP6djjioCsdfmAcTqql+iOzkZ4ThuqXlYa
         jpzqhtnWSNf4RJ0RGGC1y+cIiTSlrDACrzlIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188424; x=1715793224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wr+4jFwVlj6YM7AOT9GiLxeZOlIpMfOTLQ368UMxy2U=;
        b=XtSjIPNyjR/VIH0yfRq6ob55i9yxeCTTyVIWBIW6w++RVMZbxN+OfLvU0fTSK+XDow
         D35U6OF/TQkfAnTCfKPLYW+OI9fk7+DhaJ/AHQGdFI3v1URCrm7StZODait8UextZ+Cm
         TENcjsHZwh+c749+UUjPKaKP8G9fd1jlY852iB6/8ZmQ/Bi2H/n58Y9PUCwkMTE745Z2
         eMtUuoxb3oLVsi3k74+PAu0zXRklZjfs6EYrubZ5AoiOwCfIor+7ZK/og1TujdIBNoXA
         Z1xy5CYPzq7+wMGmNrroeGfE4xrAnUtmitEvZ1KYclC1MXhqAXS4LtU6JpyQZW9/Jzo9
         gqtw==
X-Forwarded-Encrypted: i=1; AJvYcCVc2Hen1L1AHRvd453701oVPrcnc3+hyBU2+vvaCM37vO54aysyO2a8H0jNewero2UrN0bqP8YLYOHtw0bxn3+nL7NADObSmFeEZmd2
X-Gm-Message-State: AOJu0Yw7XdUbgIpySDVZrJby9/pCdd1z/sY13hFUrKju0wdnzAzJWaIp
	+6IX9QvKNOBNPlsebdmIKTstoJ7hrDG6831LL/SMH2RtOi5hO5qPlHmRM2asig==
X-Google-Smtp-Source: AGHT+IElHMLH2gY5FLgoW4a5l6UzmjV8pgnTVNST6vObo5KDeJdI638Pp4AbvqdAiKKOYrwRZQbEkw==
X-Received: by 2002:a17:90a:b113:b0:2b1:534f:ea09 with SMTP id 98e67ed59e1d1-2b6166bfd77mr3234945a91.23.1715188423888;
        Wed, 08 May 2024 10:13:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090ab88800b002b2927bf5b6sm1700077pjr.16.2024.05.08.10.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:13:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] seccomp: Constify sysctl subhelpers
Date: Wed,  8 May 2024 10:13:41 -0700
Message-Id: <20240508171337.work.861-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=keescook@chromium.org;
 h=from:subject:message-id; bh=xt9M3exlnZsdvMPnoHPpDqdV0gMIktR34CMLamkUj9A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmO7LFIujxnDntMbKW0xj08ECDVKR8vyk7NTbW5
 Tde5AVib4yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjuyxQAKCRCJcvTf3G3A
 Js8jEACKepRzEgBPhQYGg8NroNabvSKL9S5MqSCDcppWV+F//ZMvC9PBpEfx3ElNUi7eFwsnXbL
 ZykDLc3wU+xR+RtY05rnrsYzc2+oEcGkaBiCH+ek+zBHRZ7pZyz18Ed9r4ky2OLU4L+X2ri2dJN
 flVufs0CN3ZOUeArEJIScDmNECc56mQfNnF2eytbKFzmO6JvWAhSDGlcEAVcCBXr6ELImh4iwuq
 /LLvcYcab6fMoFDnovXTvpfD7JpJHbKFd51B37B8vQ4HRBP/KPn6Pg1n9/3E0IDDx5y9vEpRJM7
 i7+ZNBIVVUKBZZKMn7xZH+N7GAHl7IRLOxJwJOztfCjeQp2PTVYlZetfKnaOndjYVY/zap+l1eP
 pbcYXbuNMC2bCYrnkzfhJjyQn3fCU1icvmdmiiUfIKSekakzrL/v/Rgzqprg2g7gKncKUgRmka6
 ZlJlKBqwn8imytyLoeQNi/10ryLQS5hyyYLyGF4+seT/caFU4Zm1e601GJoAdXbxUiYzEyuIGrj
 8d5JsQctAfmwsLmTe57zpZ1AnkTHCXwKZRR4LSY9KokuenzRASMz5KCq+jHPHWp3xwWjpax6zzd
 YPn2zNnV946IaUcVOWNsvBUYhyKdTZv65c/KVh8ZqkYQ6nBJ7SNpre9tOWDRn/KOPbT1Abaiz9y
 FL1GtUq lRKbmsYQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The read_actions_logged() and write_actions_logged() helpers called by the
sysctl proc handler seccomp_actions_logged_handler() are already expecting
their sysctl table argument to be read-only. Actually mark the argument
as const in preparation[1] for global constification of the sysctl tables.

Suggested-by: "Thomas Weißschuh" <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/ [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "Thomas Weißschuh" <linux@weissschuh.net>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index aca7b437882e..f70e031e06a8 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2334,7 +2334,7 @@ static bool seccomp_actions_logged_from_names(u32 *actions_logged, char *names)
 	return true;
 }
 
-static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int read_actions_logged(const struct ctl_table *ro_table, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	char names[sizeof(seccomp_actions_avail)];
@@ -2352,7 +2352,7 @@ static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
 	return proc_dostring(&table, 0, buffer, lenp, ppos);
 }
 
-static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int write_actions_logged(const struct ctl_table *ro_table, void *buffer,
 				size_t *lenp, loff_t *ppos, u32 *actions_logged)
 {
 	char names[sizeof(seccomp_actions_avail)];
-- 
2.34.1


