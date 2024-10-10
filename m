Return-Path: <linux-kernel+bounces-358422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A12D997F23
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB6F284D16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7421CCB49;
	Thu, 10 Oct 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZph+C6z"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412C1CC8BB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544233; cv=none; b=CaspZSlaQtb/7uoBAS4kYBYJV8Sv863nDtXt1i8B+A4e/5c0ICpDHnfe+7IcZY309sQM43l6P0hkDd5JR1NTt8pp7geBjEHk1ytoLWn381lclRFijEaCawwqOuDsgC8NGGSDfUcawb34b/EmSmzEOfWsi/8dHJjagsrCUaj/R0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544233; c=relaxed/simple;
	bh=iZ3IhJ5tMaYuF0yyk6sZjV/JNSFJpA0g13gCFsFuQtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjZLBF/aaQD8d8BwCL2AcHJIBtK1N7Qbn0Iq7pjllenv67F5FiRS72U4RADI7kS0H3vjtMrnKJhmvpf1oddXQuMiEWJq74NGdk8/9WwCRWqzj9/jLL/kdG86YYzNsv4X26owJSsjAdir60lzRG8NscpDNKwp80zezj5aNwn44jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZph+C6z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d447de11dso335854f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728544229; x=1729149029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9jmVLUXRVf806B6FYn+c4ecCza8JDrVkTIkL6Vlzw0=;
        b=kZph+C6zbGxneoorbTsDbEXj40FKUzc+6MdZuZCrIndvImwLmB1P2jsVoU2XdRITeQ
         HKQ1PD+wY1ze14XlZCz06RiR90ya/SNjdvCNs5kGiY/hkdO2TLmqtRAUD897KYC3Euv7
         PUVdu5OaD/bEM6Y5Sy6u+0nBg0dJBrLSRXSKtOIvqIQnNKJs8WxrBsFa3QbXhOqaKs2r
         6TiKi6LDgDzNC3hayaLV4KlOwCiIK7ojM0UzB7ykQ9CDk9xWLI2mKimnfmRlmUgcTfxP
         Fj3Tb3mMgk2/SSze6wl+bRziyRAD3w8k9q2kz81mStyBc/eoghLRT8ManGSdzhBQ2a73
         9tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728544229; x=1729149029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9jmVLUXRVf806B6FYn+c4ecCza8JDrVkTIkL6Vlzw0=;
        b=Wz6bwSc3B4Vq+lg5vd7bjuYkmnuJYI9b7Mb195MbeVIiQDImWoxModCVrRJAx0rYUk
         AZV6SybJUJdc9u+BmT26qtBXzOPm9nEL3r01QyncooOZFgytLJyrwk9H4lKacgj3ZXfd
         Qhbbz2QHnx948qUerpTiqNa7bS6u0dJNwuim5YfrJjHFwLfjZQ0bnzP3inC49dZvtPNw
         RRM9kI7kjUJKisgcslWaFCTzk7siU+HNhmS5fbWaTbazH/l+EMBchIeDUgEzvRrTw3Ag
         7rwHIAdKI3WK4jkpWg5+pKJrmZy/S4dgMjkpaNIM2kfULO9A3E9zFhbefU/VNdbD658j
         rXYg==
X-Gm-Message-State: AOJu0YzcXJTZ8jlk0lPqP9bq4VX5Wlx/9XuWcWMePyIG5dve0U+LFUBN
	nS1VpK5x5UScPsbrETdHqiRIbrGm5IAD1doL5fA/LgvbBtJhLuwMRcgbjiBm
X-Google-Smtp-Source: AGHT+IE2hiiukpD/5ISNnmrcxcAZXmGjgKpZd58RV3mCbFOLzGR1EwWJJyrEPr/i7fpSX1X4SHCW8w==
X-Received: by 2002:a5d:5745:0:b0:37d:3742:a5a7 with SMTP id ffacd0b85a97d-37d3aa31aecmr3586805f8f.33.1728544228983;
        Thu, 10 Oct 2024 00:10:28 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d78dcsm7011115e9.5.2024.10.10.00.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:10:27 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/2] futex: Use atomic64_try_cmpxchg_relaxed() in get_inode_sequence_number()
Date: Thu, 10 Oct 2024 09:10:05 +0200
Message-ID: <20241010071023.21913-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010071023.21913-1-ubizjak@gmail.com>
References: <20241010071023.21913-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Optimize get_inode_sequence_number() to use simpler and faster:

  !atomic64_try_cmpxchg_relaxed(*ptr, &old, new)

instead of:

  atomic64_cmpxchg relaxed(*ptr, old, new) != old

The x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg. The generated
code improves from:

 3da:	31 c0                	xor    %eax,%eax
 3dc:	f0 48 0f b1 8a 38 01 	lock cmpxchg %rcx,0x138(%rdx)
 3e3:	00 00
 3e5:	48 85 c0             	test   %rax,%rax
 3e8:	48 0f 44 c1          	cmove  %rcx,%rax

to:

 3da:	31 c0                	xor    %eax,%eax
 3dc:	f0 48 0f b1 8a 38 01 	lock cmpxchg %rcx,0x138(%rdx)
 3e3:	00 00
 3e5:	48 0f 44 c1          	cmove  %rcx,%rax

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
 kernel/futex/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3146730e55f7..11795439efb7 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -185,8 +185,9 @@ static u64 get_inode_sequence_number(struct inode *inode)
 		if (WARN_ON_ONCE(!new))
 			continue;
 
-		old = atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
-		if (old)
+		old = 0;
+		if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence,
+						  &old, new))
 			return old;
 		return new;
 	}
-- 
2.46.2


