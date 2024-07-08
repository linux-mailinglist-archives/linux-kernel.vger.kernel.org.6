Return-Path: <linux-kernel+bounces-244661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261492A788
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09591F216A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8614659F;
	Mon,  8 Jul 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2bYR8Qx"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E813E41F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457033; cv=none; b=p35xQjo0p53o5a+Cqc3wWXk/o5DQ8xXjhaQQ3G/GCiMW+/2PrU9HZNjtBvv2C4CO4oSKpDkfB4Pjx00ExB4HC4nycZjGgf6/kiqA/xzK1oYzhMTjV3jQ1lYHPUUKigoJ8bPmHY3a49z8oC3WB3j6rMqbgHmkBMN/4a1bz0gmNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457033; c=relaxed/simple;
	bh=kKHIBXppE9qYJGu1+k6WzmdWhAFi7fTswCz+BXo1rFA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EXGjkXJmt/6lfjoGnYCDdRV4AxfhoXJfTBcQ0PFjz78gfr2cCdbwEgUtJkgi/usKqI8NsZvh8njPQA6Vrr7jaPOqCsX9NpEX3XFdwybT8YRmP3IxKp1Rtj2ew5kMWgK+3lFOXpOY2qQRB7M9cK0bEQQcg/DVmuAS84rrJT/1uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2bYR8Qx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af58f79d1so2732875b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720457031; x=1721061831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXNOCthqLJQnortAeUZNxjzSWuT7RLWdamWwh+6vmjM=;
        b=s2bYR8QxhR0GlIqdl4SOfE5umxm22pa6wLitOzVB+UjnX4FPdp2o1filRBO0T4Pv5h
         6T0bxJpkCSAfecZZkHsfFsX1fK+jBana2Db/jMdYIrDvDQL4wBdCPUcjF8UrQPL3Wjzi
         I3NCiT1F9d0GiH/rSga49blTWr9N2OGeuNBiAmTMLffoNeU5CbDf29Q7rnfnDEoWt1CM
         luOFgANVri2B/7UfKE0ehkof17eqP+NXW300qKAmZ7x7P58hnDAS/eycTuhWrtulrOIp
         a6hL0Fkve0C9QKaWbUYPS3bvckeCGmbom2T72yXog4AlAZbuOlGRORgwg5bU6vOAblww
         zMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457031; x=1721061831;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXNOCthqLJQnortAeUZNxjzSWuT7RLWdamWwh+6vmjM=;
        b=i+youL3QmGMoT1VJRMMhIX80dcrik0O71Y0r0ze2DKMVDSLn3eDZe8jCuHg11J6m6U
         xkwAOKDFLgOdT1JiS/8bDn5s9LvKupo3m9YdPtLH5Ym8ny+bkQkRAmO9WB1xM7A7Nvth
         Qt0VWMfd2KLa+XQDZmv2xzh39/djjgdivIzYhe1eHaQ7480jVJcTaJnp0FSBnYmRlOB0
         B+Z0yyV6mcTPNKaOv6kdE5OaFoNJPygpyRGl7FugNtyXd/7Q74wGkHfTNVrxCI8Kl7Ga
         YB38pYS0NvJNj+R9ySML3Ane19f7wyGUwbrLDow0uDDcpRF5pGoR4AzM8pMIwuG4wHa3
         IaSg==
X-Forwarded-Encrypted: i=1; AJvYcCXJrjK6rvtrhHE+DngLN9bbwHTXXM7fC/SDfH7kGRTN0d7u294veMESSOMa8TzVntZ6AKOLLYArxF0npV04i0SGhvBrV28SBRnjwD05
X-Gm-Message-State: AOJu0Yzqq4apih2nJOsoNiYOUM2D8uj3SzwUn+0rmXt+sz3Ydyc1thA4
	z6plcys9FW6+Mm9f4M81BH2NkQOVC2TUX4odRy3UAoUvPgMWNtEgrVSSk2dDH2PmRBDiU1ulWLH
	wmYCsEyhDig==
X-Google-Smtp-Source: AGHT+IGrXhwTR/D8bXTm4IJ9bVwt+ESYqbPcMEF9fZLPk3rs+FACAv0NYnr6s2EuvrKTjSkCwWY4ocFsdKvHrw==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:124f:b0:704:338b:d556 with SMTP
 id d2e1a72fcca58-70b4365a95emr5818b3a.3.1720457030957; Mon, 08 Jul 2024
 09:43:50 -0700 (PDT)
Date: Mon,  8 Jul 2024 09:43:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240708164319.3801778-1-jmattson@google.com>
Subject: [PATCH 5.10] x86/retpoline: Move a NOENDBR annotation to the SRSO
 dummy return thunk
From: Jim Mattson <jmattson@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

The linux-5.10-y backport of commit b377c66ae350 ("x86/retpoline: Add
NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
NOENDBR annotation, repeating the annotation on __x86_return_thunk,
rather than adding the annotation to the !CONFIG_CPU_SRSO version of
srso_alias_untrain_ret, as intended.

Move the annotation to the right place.

Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/lib/retpoline.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ab9b047790dd..d1902213a0d6 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -105,6 +105,7 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 /* dummy definition for alternatives */
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
@@ -258,7 +259,6 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
-	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
-- 
2.45.2.803.g4e1b14247a-goog


