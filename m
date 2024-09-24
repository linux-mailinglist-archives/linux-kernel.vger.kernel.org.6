Return-Path: <linux-kernel+bounces-337346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE669848EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF51B22596
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911D1ABEAD;
	Tue, 24 Sep 2024 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UN+7c5fU"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7C1AB6D3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193436; cv=none; b=Nan5v0eEexuE2iwRVlAFHErlbYQXI2YOtUara2A8/0FMG/sBUDA7w8GC9nYPuvtK1FpA4fL0EZDdBRoAIXmWCIhYjyuS/zMSTRTX5voEukordDzCZDDVJfcucAXkKMkbmkAGMCZ1kauwn0jlhnVqtcS/XQhfmimwdDZWiHYL7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193436; c=relaxed/simple;
	bh=lXbxjZ+ouwu3WVA+0m4+uIw+G7oJZMsuRpVOioaQla4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rowUzOpVX3OcZPHt2pt9Rn2JyawUQ6HEqhhvNEBE2DcL/GYH2Mq5CP0o9MnIp1PHSFMBa0oRRmywvTgyb9OipyRZBSpABv1pIg3fVTevUdn0SyGTKG2HWshSm2RYoXqre7RmqPP2/h8wcIwgiYkfmUzUCTlnErNWsMC4RjENxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UN+7c5fU; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso294851439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727193433; x=1727798233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoBLYc/BQM+75Z1j2IpEGmI44ylTgvAEahoMtAvQpbo=;
        b=UN+7c5fUk1Lv6DP3UjquXzkW7k0U+6v33K/p03N64baxWBNEyCZZ1zi2MaLeZSidzt
         UQ+B4FNz+MP1Gk3weqTO8GlG6VuqBnKeHiEnrAsRnmQKPF6EmcfMXyDSL6ZygEmCY7T1
         5NPLpayv4/2D9lF2KrfkAob5D2MBSNdTDRXQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193433; x=1727798233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoBLYc/BQM+75Z1j2IpEGmI44ylTgvAEahoMtAvQpbo=;
        b=ERyMD/+CDrZi1Uf5pU2zujGJ3OHH0kULV+9JF7J8/JFoWC7jwcGOklxXcfxYLsaUW6
         mElUoiVZwB3JxfW8QQMgcm/noWFqpc/lg0FhI7jvRND9TrqIcAdfzy+rPpjPkQuVl2S+
         7SVuiwx9TGlSqPrs90fPuKwfQajyEQ/fjkKfhMVvoDqKnq0Sy49uxy4F5haoZ9pb0SkW
         oXMfEbExVc+5GY5KARkTMRk2dS+l8T4FH92dudSpTWq2xTL5N62x/Iv4WWxJQLDBnTUJ
         ilXi+IYQPxTPX2KhN0nJyNC1T5Ds5V7yh/4Tu0Vf+KX5g/UP5jKHJ0VSWB3YEvFRiPmA
         qRPw==
X-Forwarded-Encrypted: i=1; AJvYcCXPlPyrCc1UNSbSaKF56UPbfMnAsA06010LSvYb3d1G2rX8SHJlBw9nzoShtsXA9dHxKqnne0gG/KRPfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBZQQjeeOrsLyB92lhKuKqVkLpEqv+AVQ3nptwmcljcdV1ILR
	WT07zL0VOApCMWz0pN5D1KfvFll+0+zl2R6zPJxkllcTfLPOkz2Iyw029LkPwrI=
X-Google-Smtp-Source: AGHT+IFcqBry3uguUOUjwwPSHKY/lNeTCQaBHBGKJIYpreu2Ms1ak2blPjgKbu0F8CAIifxnwdGmOQ==
X-Received: by 2002:a05:6e02:194d:b0:3a0:c820:c5f0 with SMTP id e9e14a558f8ab-3a0c9d90ba0mr145029575ab.24.1727193433191;
        Tue, 24 Sep 2024 08:57:13 -0700 (PDT)
Received: from localhost.localdomain ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713b64sm4492035ab.58.2024.09.24.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:57:12 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests:timers: posix_timers: Fix warn_unused_result in __fatal_error()
Date: Tue, 24 Sep 2024 09:56:46 -0600
Message-Id: <4f3a0acd903aeee52fb71acaec1106d513a2e88b.1727191485.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727191485.git.skhan@linuxfoundation.org>
References: <cover.1727191485.git.skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__fatal_error routine doesn't check strerror_r() return value,
which results in the following compile time warning:

posix_timers.c: In function ‘__fatal_error’:
posix_timers.c:31:9: warning: ignoring return value of ‘strerror_r’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   31 |         strerror_r(errno, buf, sizeof(buf));

Fix this by adding a check for return value and error handling appropriate
for the GNU-specific strerror_r() in use in __fatal_error(). Check if
return string is null and handle accordingly.

From Linux strerror_r() manual page:

"The GNU-specific strerror_r() returns a pointer to a string containing
the error message. This may be either a pointer to a string that the
function stores in buf, or a pointer to some (immutable) static string
(in which case buf is unused). If the function stores a string in buf,
then at most buflen bytes are stored (the string may be truncated if
buflen is too small and errnum is unknown). The string always includes
a terminating null byte."

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/timers/posix_timers.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 16bd49492efa..ddb1cebc844e 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -26,13 +26,17 @@
 static void __fatal_error(const char *test, const char *name, const char *what)
 {
 	char buf[64];
+	char *ret_str = NULL;
 
-	strerror_r(errno, buf, sizeof(buf));
+	ret_str = strerror_r(errno, buf, sizeof(buf));
 
-	if (name && strlen(name))
-		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
+	if (name && strlen(name) && ret_str)
+		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, ret_str);
+	else if (ret_str)
+		ksft_exit_fail_msg("%s %s %s\n", test, what, ret_str);
 	else
-		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
+		ksft_exit_fail_msg("%s %s\n", test, what);
+
 }
 
 #define fatal_error(name, what)	__fatal_error(__func__, name, what)
-- 
2.40.1


