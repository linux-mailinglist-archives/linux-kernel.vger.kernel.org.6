Return-Path: <linux-kernel+bounces-379218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158D9ADB88
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AD0283363
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717FC165F16;
	Thu, 24 Oct 2024 05:32:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B8C8F0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747960; cv=none; b=idrGGzAbhMvDEBjJbN1szG6uo2FdClTGvgKmLZqRdBOopwBn2CFVznmdov7TNU32iuoipnp1wRt3lv3lLPcahnRzSc3X1UtoIBe4wWjGD0KXoJYKDmXzWQ75dpej2GwOAQwv9PQ+7rZYtdvKMWDOnlo/MbscNjh5G5yuHEwyXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747960; c=relaxed/simple;
	bh=W84A4SU1sumiEa4fDWQR+FiBA3Q2+tkAMGPFD3K0Z5s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X56cP4JQDisGpcanSi1EmfMDZgZSMz1mCxjEeR6TWiMstjr4j9yTBac75d8XmmhAyes78Du+xwlygxYYP2K/SSbVQZ+jPYu5pSWDoAmwVkO7g+Oz4z3D+K2jsy9ew2vHRR6ScJHNMOVpCd+p7aiA9quyTFpzaCkLbYz4NHcWjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43159c9f617so4838895e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729747956; x=1730352756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YH5WAbfffHLe148MN1TUgFq2819BDiCppIOTtAvWGLU=;
        b=DiagOT9N4S7ps+1jaVOEKbuUHg572vQQQ/BD+POklLu0nXqTn3ttTTpV86VJvWLBY/
         sfwoifvdrQeswgdOWGdB7miz05LiwTUATvXzkt9B7exC4QyuaQ7qp7Z3EEusSAzyxx3f
         D31BrL2I9eNNikJQRHMIDSs8lrRNK7dlCjvm0+Unxqt3fmM07y+FsZwg/lMTQhMpGDxo
         coT8nnsc0M+gVkl6en8AfdHE7Jiyj0aqy+qSlu9gbU2KY/+k7d7fItkDjll9Q1eoWkIR
         hjhlukUG1Dbyl7Qj7aXeF9+qM/cg/eMQIoRx7uWQE1puPNr26fer6l8eSD6vaCjMsZ5w
         D8cg==
X-Forwarded-Encrypted: i=1; AJvYcCVe6hxfDjHm+N12x03PwbzKh4CQhWZvjhc0iAD/jI1+8yGnCxhas/wVRqR3BlBfg/Gu5Kb3Oi4cgD3tgOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2AbhRrr7qpcEOlX6uEvKo2/27R6scbBXDLahBPxjAcXw8Irr
	eDttHdeyhqdDNWmqiohhaPDD0hI7i0aUgRbm/wQ9lnXXJtwekwVG
X-Google-Smtp-Source: AGHT+IH0AXB+6Mctvfib66WpI4pXmu5DrtC3WIQfCdAWRVWbg24KBQi+j3ldO7BUXJVeIWUwKJlX4w==
X-Received: by 2002:a05:600c:4e8e:b0:42f:310f:de9 with SMTP id 5b1f17b1804b1-4318c6f4de2mr5275695e9.15.1729747956060;
        Wed, 23 Oct 2024 22:32:36 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd689fsm34612445e9.4.2024.10.23.22.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 22:32:34 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags.sh: add regex to map IDT entries
Date: Thu, 24 Oct 2024 08:32:06 +0300
Message-ID: <20241024053212.2810988-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Source code samples:

DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,       common_interrupt);

DEFINE_IDTENTRY_IRQ(common_interrupt)

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/tags.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 0d01c1cafb70..1f6f4f92f5e6 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -210,6 +210,8 @@ regex_c=(
 	'/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)([[:space:]]*\([[:alnum:]_]\+\)/\4/'
 	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_t/'
 	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
+	'/^\<DECLARE_IDTENTRY[[:alnum:]_]*([^,)]*,[[:space:]]*\([[:alnum:]_]\+\)/\1/'
+	'/^\<DEFINE_IDTENTRY[[:alnum:]_]*([[:space:]]*\([[:alnum:]_]\+\)/\1/'
 )
 regex_kconfig=(
 	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'
-- 
2.47.0


