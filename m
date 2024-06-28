Return-Path: <linux-kernel+bounces-234142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8F91C2BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1AB1C2176D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971E1C2325;
	Fri, 28 Jun 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Yp5d38kj"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713C17C66
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589091; cv=none; b=O3YE2tjr14zJy6MyUt5hy7QcQcscL+pcD0WgluAEZIZFTTfbrJNw4KT+NIA5UYFRdfidB3HuvAWRRbXY5YndOdeyqgUY44nJvawupoiyARWfYYYuw21EF7pTCjMAYMUx9pUf2GqlmvTGRyFa+dntR9M1pmHEm6Ptd6+eboEP3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589091; c=relaxed/simple;
	bh=eJoAuJ6GL8stuFTFAGUqcwHeS8evgdssb5cWYJUx3rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkdr1W95Y+vvJ+cBvzjDkqvXflR4og6CqCblRyN3atueOpDM308V94PCIwngaZY+vf7G8SeB34+KEkXcjW9SKCXIUsfUELAeo7bcFCr3n6idsybOqECXbBC9j9VHrRin0sQ8TrkTAZ4q6LT72avbCN7iWdpGqiryx5wKVFDXrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Yp5d38kj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D8E8D3F738
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719589084;
	bh=MsEnv/M0byq8XC93iPUcxrjaR6EQLTcXh9kYUPdB+BE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Yp5d38kjpQd5pAo1xbSlPXG8vrMRg0VsDt6ZM+nXAOzib84eouWq5yTHliH5lfaKD
	 g4Aj3HiR1H+8D6lzsRDDSK8BAYwMUDloI2qByLQN31tDW/D2hPMUlmzVBcX2nZnPLW
	 /4D5/YjaJrVCg7mewNexXGHYq1LiCMO3oAhvdNjDiH3AjLOgIMxWNtAWiOuc5+dY68
	 ded3dAx1OqHYHsjfT2LmtHmAMXxtAVkmX67B16OkV6uuFkL8iSkeVJKg5sj+BZekV7
	 rbhwQ8bPiDTMF2F3NpsL9Gh0YWvil5JHB6bHDc1mwmFq+HMh4w6C30on7tP9C1745b
	 Hnj9Mxh3EFhtA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57d27d8f691so264208a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719589084; x=1720193884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsEnv/M0byq8XC93iPUcxrjaR6EQLTcXh9kYUPdB+BE=;
        b=P3G4T78fsQ/jmVBW+fsdmQmi219WgsQQoQeXvvsppirVKrzwfaGb+ZW7lAsyI19WIi
         MK07HYJMiVP+hDopJSkN6SGCqa/IOZuBazayZtFq0rmiFb5zYn6ASazZBznAlLAEsrMq
         we5MSv4I1Sj5gWiOFs9EPFEzPt1UFYVYF0uGbRdJHY5A3bmNq3SAK7ltECE+wqnrYUyh
         NsM5rTygX89+aGkWbO0iSCSykpuQikLLOrXcsVBYwQS06DMUEHq1oP6K2cWLvIBcT6yO
         7JkfNt662vAYRH/N8C31TbeDudnYV9Qj1eVJIgaOhxxKLashAJTO9ly0ckBQmM+KuSnD
         38CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwz5afE8a987/H78h9pC2ZD7D9tkbkzDCNWTz9KuhSiWwsqQkxwGFlMFsdNWGKqrt+DuFln/xlLjpvBJOtWYQNe1GOQ1ynStDn7zua
X-Gm-Message-State: AOJu0Yw9rN3SzdbG++5ysNS3hFwoQnsVT0oh+vDzHVGDBCK/BW0Wo7Oc
	bXlXaPiFfyNfnT6llfym5OsQO5LHpPTb5wavipTco6UR5wyTpDwczIYkSmC7jdSnDOTcXz/3X8M
	s3nl+M1KX+IQ6CjD+ja5qIyQ8vyE1owIsFbmhkGHyFgH1ysAK4rjngE6Rxp6fpfpJwwnbBrt1rR
	FjzrecRm0E1g==
X-Received: by 2002:a50:9ea6:0:b0:582:6eb6:2526 with SMTP id 4fb4d7f45d1cf-5826eb6b1edmr10770155a12.27.1719589084180;
        Fri, 28 Jun 2024 08:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcMeBrqelm0UsCNdD0vrQxedxQWDUu+xpgEbL98RcEO1wN4zX2klzsubVREOWWNGw8QAgCTw==
X-Received: by 2002:a50:9ea6:0:b0:582:6eb6:2526 with SMTP id 4fb4d7f45d1cf-5826eb6b1edmr10770133a12.27.1719589083838;
        Fri, 28 Jun 2024 08:38:03 -0700 (PDT)
Received: from localhost.localdomain ([91.64.91.101])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d50593sm1164329a12.60.2024.06.28.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:38:03 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: john.johansen@canonical.com
Cc: stgraber@stgraber.org,
	brauner@kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH] apparmor: take nosymfollow flag into account
Date: Fri, 28 Jun 2024 17:37:12 +0200
Message-Id: <20240628153712.288166-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "nosymfollow" flag was added in commit
dab741e0e02b ("Add a "nosymfollow" mount option.")

While we don't need to implement any special logic on
the AppArmor kernel side to handle it, we should provide
user with a correct list of mount flags in audit logs.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 security/apparmor/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 49fe8da6fea4..bf8863253e07 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -44,6 +44,8 @@ static void audit_mnt_flags(struct audit_buffer *ab, unsigned long flags)
 		audit_log_format(ab, ", mand");
 	if (flags & MS_DIRSYNC)
 		audit_log_format(ab, ", dirsync");
+	if (flags & MS_NOSYMFOLLOW)
+		audit_log_format(ab, ", nosymfollow");
 	if (flags & MS_NOATIME)
 		audit_log_format(ab, ", noatime");
 	if (flags & MS_NODIRATIME)
-- 
2.34.1


