Return-Path: <linux-kernel+bounces-274428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61589477FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70161C213A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D414B965;
	Mon,  5 Aug 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hufp3lUd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5F148311
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848950; cv=none; b=sFEqY2kg5/LD69UtiNc/4DkAgtCpYYxhFi2w1jFZOf8n3fv424ODS2Oeqh2gK/vHDZxxkYo68l5xqtuTaIznnYqX6J/4gCRarj4Utc7zn46RVM9WO0W3wLrSK9NGoGq/UuY9B+qC094CWn4kN1RKMqcar5op+s1bxxtO8R4zykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848950; c=relaxed/simple;
	bh=PebdPvGqrmzS5oe05OjC+jip+HwRntEzpx7DBbsHDXk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mWeHvBcBkuFJ8dhDT1dxNZW3Nb+vRNOtGx7BWIMrHfKLoD73ZQIvxeXh0YHrMgIaAEjU4caHRAeN5p346fi3Gfmuuk/ef7qbSvPxVtHV2qitMSbLdomq9new03NpMJ6Dp21uRRTqMlrjfUW/NpGThQM1p4A+39C/rUetMm5kTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hufp3lUd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-692aa9db2d5so16945497b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722848948; x=1723453748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5FVNLoC/hnhitK4NzfaIQHLLqsNbJYgmmmWn9laeoQ=;
        b=hufp3lUdTY2ooKIIDckmPjbuRM1SvY/1tfR1WvB+0c3DKpQWQ/peYe44RjLm3v7LMO
         fvzZm1QUsGDwWzIbTS1uyUXhiTOEuBc2HM6VVkF9hy3W1p1vWJ2BO9I5HQkIjXKLxGj4
         NbIlzh4Bmlr4QZDxTo7+Rw/laeTlN1JlNzsHjgQCo47K4gBGa2MDg/6Ec0TlmyqzNKdh
         cQMSTvOwr/1z/bmDyn8ZSeHTL529LAZ+64EcCY5lc/jsfon09h4GJtaov1EHIRTzeecd
         RIX7pGkBaHqv4TXPVVqu4sXs4L7etOL+kLPgsvxJc2dZhO3gr1S7jCBUQAaj8CJR56zA
         tUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722848948; x=1723453748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5FVNLoC/hnhitK4NzfaIQHLLqsNbJYgmmmWn9laeoQ=;
        b=CUlgEux/mjncakZy7xobEvBYCYuK2vL7eZTmg4O9el1RnhCBh/quAPDNCA7MwJD6JI
         dkMMZu5KkdbUT90+46xSyIKGqR9eJZCdBlY8Dczp/x2npwX0G95Sy1Yi1qwhCIotj3Bv
         IWJ/Qhn67aeIQ9udUb636WM38T74d9j5+gtG+Bk6+CH3szm+S1xV2tpCzfwTmu6zgnfB
         rD/85/zdZv/Llk5nKNC5JzT27qZwWcThvvCkWG5GJUIdwXllwG85ROYrrOq11bLvpd+H
         z9pes+Hh51Bnc2Do2FVWBjVQIO1Z0sbZSLylqOeHNSOtHKlzNNwZLgjQ/gGnZliiSVT+
         4+gQ==
X-Gm-Message-State: AOJu0Yy4ODQcHb9xc6wEz7aAOKYqitoy3XDSBOMgTGTa6tFAnRqemi5w
	SWXfCFB0BXYmJX14hFv7fQZXhJr8Kg/uAZQDOOjtjU4FO5fJoTm2aWtoWwuHTiwdUZZrKdXZugz
	UXVRa4VGfCNaOO5dHIEoMa9nV2PS5kqUZHj4Y9GV9o/Dcdk6g2yFLHlNz14Ps/u3i0dc5n6mj+S
	dk7e8SRFXtGkwV5AKxVnXHfZFVMU/Aklepz+sbPrT71pMcIU8cL2Q=
X-Google-Smtp-Source: AGHT+IEwAhgF2udfnLqsvv93LRdzFVrtiNG9qx2cXCE6kbHr9BUUPYhcAbFcgzd61y3Vrca/HAJCV1rvuRiSZw==
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:209:1e03:18ea:47b:ae79])
 (user=gprocida job=sendgmr) by 2002:a05:690c:d8b:b0:691:3acc:eb2d with SMTP
 id 00721157ae682-6913accf3a3mr401937b3.4.1722848947744; Mon, 05 Aug 2024
 02:09:07 -0700 (PDT)
Date: Mon,  5 Aug 2024 10:09:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805090901.53986-1-gprocida@google.com>
Subject: [PATCH REPOST] lib/build_OID_registry: do not embed full $0
From: Giuliano Procida <gprocida@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, kernel-team@android.com, elsk@google.com, 
	Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

Using $0 makes the output of this file sensitive to the Linux build
directory path. This is problematic for reproducible builds as it can
affect vmlinux's .debug_lines' section and vmlinux's build ID.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 lib/build_OID_registry | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/build_OID_registry b/lib/build_OID_registry
index d7fc32ea8ac2..06f242202036 100755
--- a/lib/build_OID_registry
+++ b/lib/build_OID_registry
@@ -35,7 +35,7 @@ close IN_FILE || die;
 #
 open C_FILE, ">$ARGV[1]" or die;
 print C_FILE "/*\n";
-print C_FILE " * Automatically generated by ", $0, ".  Do not edit\n";
+print C_FILE " * Automatically generated by build_OID_registry.  Do not edit\n";
 print C_FILE " */\n";
 
 #
-- 
2.45.2.741.gdbec12cfda-goog


