Return-Path: <linux-kernel+bounces-204307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322798FE6FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954D1283409
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30D195B1F;
	Thu,  6 Jun 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k3FKzFlQ"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DB1E868
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678872; cv=none; b=J3bOVxqctgpg1UnxAVOEUxRIZksAlyIYJKyHfEHg03rGXJSu6UxaFy1oc0fUSg96sLrMPNyO8OoQqy0k9d8cbnushEuJA33y6odqYgayOw7xxPDBOlKk5kr0bTw9LiFilRGUypj+QwIK5xjpSkMyWGDVTxhg8iuYq2eDhr0U220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678872; c=relaxed/simple;
	bh=JuUsKChiLT+vfrAvapauPrs05KYeEB5xAXVHns6YIng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZM1P/rYvYOb4ORcAsKuVU7uqUVqEJ4HgIuHoGEVETUVdkKZtNvT1+YXIt7EguCCU/KyzvFqfD+KUx6l3nuVaBLrWISCU1jd5Za+9qjvm4Z6/au6lfSYY3H1NBty2nBPusFXSYIVN3MjaWJgF06HRjr3dOU0q7TdS4gvC2t+l9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k3FKzFlQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ae60725ea1so5275326d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717678869; x=1718283669; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+/smkBmATmw+XKww99raJg0ggR9T5aTjmAVyB+/Cqc=;
        b=k3FKzFlQkT4qoDF1MvnbQBlwu4mdk3vAeS7I0HAqYXVlV3/T7VBvEAkp+OP9DDDfUP
         yhf04BuTLkeyjtWQcGDA/2wRKXUK4/PaRWmoy2RoWqwQls8dJMCAkZnYnXmj/It8N7fk
         hZWfg/fTVqzP1mwHEEk1nVMqiC+sIsiE9yvEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717678869; x=1718283669;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+/smkBmATmw+XKww99raJg0ggR9T5aTjmAVyB+/Cqc=;
        b=OL4NlWgR6l9XgRupDUzEi4MBknF1P7FcL7uNyAyLHxqEH/oKyrjRiL1dj3pTubjK5+
         8FFYua5kxq7ymWYnrtvxkG95PChuH5ExbpGeZFMhBniy7PzVOCg2nMIzC7Robp2nu4Ob
         5evcPHPI99chnJ39Q9v82ZrqgxNY6ZyxC/NjiMRFpof5RuPxZfmeFqcKPKC284tbgpT9
         oyNwvV4NsdflJdWYaEaHU4IIsD+rW2ZqeqZiQ06ZV6Rp8P2b7TGMFLTaKGjC4MWfQtEK
         S5h6f5GDZkRdy2uVKwIIw/ZzBbhcFexpBcguNwy13s8+rcv9o0/FFln4oBKWTi3jC7+h
         N6gw==
X-Forwarded-Encrypted: i=1; AJvYcCXpCnC56UzFN7bAwBTr2PpcVrM7A0Y2POJcYG2ZG79i1w73xAXYyNIc3Ilk7FkYCdc5Ff7HeW6Rjn5TBRL/D1Si3hZQ7Dn7RMzve5c0
X-Gm-Message-State: AOJu0YylCz1hUpV7kQKOOcWRslppHUXijy7wI/TnV2AvT2ZZG6mFZERR
	Aa/jzyrDwHGmQ6/gb0Q//qXaggRiEEn+4LW8og3BP3l15omjavqntPXDHZ5cBQ==
X-Google-Smtp-Source: AGHT+IH6JUdnRck7CPLLbnhrGIHcZXdHdRadjMOXloMShAFg/P7yO2dY07pA9eCBWDpCwxUBYv7E1A==
X-Received: by 2002:a05:6214:5d8b:b0:6ab:83a5:195 with SMTP id 6a1803df08f44-6b030a96731mr59407256d6.41.1717678869377;
        Thu, 06 Jun 2024 06:01:09 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6c4022sm5998646d6.51.2024.06.06.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:01:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:01:07 +0000
Subject: [PATCH] media: c8sectpfe: Add missing parameter names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-c8sectpfe-v1-1-c4b18f38295d@chromium.org>
X-B4-Tracking: v=1; b=H4sIABKzYWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMz3WSL4tTkkoK0VF3TNAODJEsLM/M0YzMloPqCotS0zAqwWdGxtbU
 Au5rR9VsAAAA=
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 kernel test robot <lkp@intel.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

clang 19 complains about the missing parameter name. Let's add it.

drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h:19:62: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406050908.1kL1C69p-lkp@intel.com/
Fixes: e22b4973ee20 ("media: c8sectpfe: Do not depend on DEBUG_FS")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h
index 8e1bfd860524..3fe177b59b16 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h
@@ -16,8 +16,8 @@
 void c8sectpfe_debugfs_init(struct c8sectpfei *);
 void c8sectpfe_debugfs_exit(struct c8sectpfei *);
 #else
-static inline void c8sectpfe_debugfs_init(struct c8sectpfei *) {};
-static inline void c8sectpfe_debugfs_exit(struct c8sectpfei *) {};
+static inline void c8sectpfe_debugfs_init(struct c8sectpfei *fei) {};
+static inline void c8sectpfe_debugfs_exit(struct c8sectpfei *fei) {};
 #endif
 
 #endif /* __C8SECTPFE_DEBUG_H */

---
base-commit: 1aea3d1d4a21e3e7895663b848ffae79ee82e065
change-id: 20240606-c8sectpfe-5f00b9867f36

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


