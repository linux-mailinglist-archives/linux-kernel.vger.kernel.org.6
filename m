Return-Path: <linux-kernel+bounces-538986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64BA49F95
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F7C3BE249
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC72862A7;
	Fri, 28 Feb 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ck08eJuJ"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF227602B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761718; cv=none; b=JqxuV7vZGUczC13qjUAo1Zyh5/XQyTAk+8OQMKxHaJwZ+4HsSvsfDpN/P7OzhO8fxD3yfebcDAqTcnlaHRlhs8K427P621/J2T8Vg8B33krsz1aJFkAIyfVa4bZDiqwhv6HSunV9N8+q/x5x2vj0Dp+XSXhF/Dz7Bg65kqPWNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761718; c=relaxed/simple;
	bh=kw4u2ebla+coKdKT/zjWKswK5RGlmRG7yc4jJXGzJoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZZIDVonTUB7Hmli3ryp4z16eGkMwwf4yp5/Igt4SFA+xQPqpc+jblCQPBPqGCoF3bMoXe5ITDwnICvTIljTUfJL9POhev8zDHCjkk9syY4o/J7b7VuL09R5JMMBLUk1GSkoO+3egvuOU85iDxDHzQO2NB5Xa5KsKlUQVSWCKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ck08eJuJ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38f55ccb04bso1437005f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761714; x=1741366514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fG1J0iA3fwqq4X8OYjBfR+jqU6ued6Ezuk5An36D2os=;
        b=ck08eJuJgvTTmqU/vvEsyKF2NXsn0XkMuz7mH2MfgmCME5WDL/0aR5ExBei4ZZ1Gvv
         n0JTeEwGklH3+Eav+Ou1tAj+9RSv4BUh1PkABdKoBMsjWs5ktePwgy74Eb+MS4D/S3u0
         4Zc8WrW1IvoWAndeh42WfbbaMBYLflIb++eSuKRl359YTBkzOYu1wXQYMzalS/X12piY
         phP0W5FysjNIEBc8O13zXQyenXgQXtYx/WqWjlj32O1uq0pOjoMGdUXmXyQLLJRafcTQ
         Zx3QSih1YY6JJogOSyUhyiyCnIuwRlOZ91EFbDgf2r+mCylZuFq2lBLbUAIHPxWdwdD6
         GoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761714; x=1741366514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG1J0iA3fwqq4X8OYjBfR+jqU6ued6Ezuk5An36D2os=;
        b=U/QZ1ZNWj5AQWPeGK5dEdG5leqJY0NxWei2D1ZcxmPtTv4tVeruCoRKy3kJ0Oz82t5
         IuImxXkXS0Di6MhkTGuyzsRhQsOmGcDCJe7USPH8OyjL954rysYuhBb4ND0INdIDcaNt
         BD+tvObaURriI3VUT8jiQUdCDSMJT1wwnLGXwZHeS6NSPbLTKgpyNqrIsQCfsU/Q5tHf
         VXoDXtOjeLUuZeeiST3T6kLmUY3Av2Erk5YJbJHeyZNg2niDwdBmbDSqrLoejF+4h4MS
         VbTT40qe3ZWKw0u8m7C2kxTGtu/Ka+pDB1fnqo721vdkXW32NdD4gOY9fG+iwoF6FmCy
         BSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt7TmYvmeoS62kKwjolbJcK1N9KkluVOawGUog1tF/WreNHdYoZmKmOmtTpKCXaebRs08aGki62EYwO6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzbGIlfuLm6U7BMqe07imy32vVS9zNXFZfAz6IbF/xuSHMbPK
	vIl1op8D0BzN3UEJhv/Rb0UdT+rHGn5rx+PsEkvkmjUdypeOv7YX93aBZeVI6aisHHC0U/RDgCy
	JDtPB+f6mrw==
X-Google-Smtp-Source: AGHT+IFhLHMyiWVhCEV+u6n15NyZd6uFVbQzk9eeDskhG0wjSB0nxk6Q1iAAywBZ/+yofpbEhpMwmSUf+cMMTQ==
X-Received: from wmbg22.prod.google.com ([2002:a05:600c:a416:b0:439:82a0:5431])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5885:0:b0:390:ec1d:7e4e with SMTP id ffacd0b85a97d-390eca63baemr3464099f8f.49.1740761714665;
 Fri, 28 Feb 2025 08:55:14 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:57 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-9-958e3b6f0203@google.com>
Subject: [PATCH v3 09/10] selftests/mm: Drop unnecessary sudo usage
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This script must be run as root anyway (see all the writing to
privileged files in /proc etc).

Remove the unnecessary use of sudo to avoid breaking on single-user
systems that don't have sudo. This also avoids confusing readers.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index da7e266681031d2772fb0c4139648904a18e0bf9..0f9fe757c3320a6551e39b6d4552fd4874b0bf43 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -386,7 +386,7 @@ CATEGORY="madv_populate" run_test ./madv_populate
 
 if [ -x ./memfd_secret ]
 then
-(echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
+(echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
 CATEGORY="memfd_secret" run_test ./memfd_secret
 fi
 

-- 
2.48.1.711.g2feabab25a-goog


