Return-Path: <linux-kernel+bounces-570330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF60A6AEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B490D1891303
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6722A1D5;
	Thu, 20 Mar 2025 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJym8Us/"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B5229B23
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500994; cv=none; b=VLKTvb8/uINFDlJYtA7Zzi/wz895ZiIdpl+hTVebJrI3j8eDFhWmktkxERpw2yBDFtmuJ1Ago2w9yhgTzYgBzH123wHG3SNa0tFkXsoRG7ugY4btm3bZYKMog6iAmEEMGDHfA6CL+5yNoczwfkB02RipHbUOgIxFl/PDnVgkUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500994; c=relaxed/simple;
	bh=tTxylqVTcwCy2pyXn0rUGN38RFfZhUBOEvnkcrpCNSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KhV2NnZ+VC41BhZsRkJaubajPymFRfHo1aWyqD0xmEKatoyE0hqmvnOOtbrKNYCViQlAc6Zyw6rbgGvcX9KBjWCJH2fMXNCMud/Hj4k/BImrWE52SfDRNS/Ax+1gb4OEzLeADqv4z5BMCjNwjtRdCOuENZY2WNiwxZBPAuD2PS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJym8Us/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224191d9228so22626405ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742500992; x=1743105792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=15shGMlHMpFSN9hvjBCgOAgN8Cwgr8g8LYNCb4v7WJc=;
        b=QJym8Us/psSO6Ry0VcqWaSpoOdLvIjn/sX6wQnKhA1toqBBwIoJQGLDTWPaHXZHTT7
         us9fwzw3ENZi4A7CMYheYBKi2hogXXmvoILhnto9QQHa7KxFWvOYX3O3vdQreRYLDd5p
         t0JAJy7SkFgb2f84c2TcC0dRyftQhVJVXthz9LVyK79DuB6dzLXz5xH3R7eC18FvKTjx
         Fi3fCkuuN5SkEH6/HP4UQ+JVffJHmC+Sx9gXIEOJrH0Gi4xuj19YC7OjumE9DBBf4zWM
         ARrl3YomWVsk6N8pay+iooLnKWkzg+I+TfyMyqXAT2LfCG9So4GilgmKP/PK1i2dik5A
         PoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500992; x=1743105792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15shGMlHMpFSN9hvjBCgOAgN8Cwgr8g8LYNCb4v7WJc=;
        b=bgwsrcVhpBAq8BetnmgbsSsHGzG53FdWY9Xh3VHELgBaSQJ0a6+xDDqu/DN0+sHl9a
         y/rJHmwLlPlcPN2xO0o3AwK0IF5GCUF3wZKRUqu4cn8pgrPsM1MJNDu5wR/kffMvKOeF
         3alsRVY1oFrOsaO+zTGe13tXTTarrR1wQ+n1+dcGtIz1S/y7xeO9iDcS6gwx3TnIymfE
         zUBue8pFgjY9u6BEK4dbvGajp08uPtUtYcnQoQZ0BRkTGArrGxqkzpYl/QXOJj2fVAIW
         lFNEhnYtVli7gjiRZHENF4yTW+O/SDjNaDgtd3TqbWA+xDV2wcwCH89ue2Q4SStm4vgB
         MV0Q==
X-Gm-Message-State: AOJu0Yzh9QD77eZMo1icrenzYjjC1Lycko5/qfJIvuqtVKpuyV9w1t8K
	PHaOSGuywpxF1chzWvVnmHa3t3mBiMK4xFR2u/evOcJW+vG6HW4nocUwigRXAPpF4NiX9upt1F7
	HWxnn2tFYV1J5nFJDvUzq21c+B36G1zh7Q6JRM9p8nYQ3F/V32+4zz1t5LZCb6csZcISHdkOZER
	11pwFa3UMQTb9B/4n7DydEh0Y/t20YWWrJK8QPn04X/hbx
X-Google-Smtp-Source: AGHT+IH14RrilTASqypK+L82ZC1gr9MGNXnC+OCPQR6Zx/BHge9JdQ1cImsPAWCfCv3LOIo/9qHlPHTOjAgx
X-Received: from plfh3.prod.google.com ([2002:a17:902:f543:b0:220:e7dc:350d])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64a:b0:223:28a8:6101
 with SMTP id d9443c01a7336-22780d96e57mr11843895ad.29.1742500992126; Thu, 20
 Mar 2025 13:03:12 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:03:01 -0700
In-Reply-To: <20250320200306.1712599-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320200306.1712599-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320200306.1712599-2-jstultz@google.com>
Subject: [PATCH v2 2/2] selftests/timers: Improve skew_consistency by testing
 with other clockids
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"

Lei Chen reported a bug with CLOCK_MONOTONIC_COARSE having
inconsistencies when NTP is adjusting the clock frequency.

This has gone seemingly undetected for ~15 years, illustrating a
clear gap in our testing.

The skew_consistency test is intended to catch this sort of
problem, but was focused on only evaluating CLOCK_MONOTONIC, and
thus missed the problem on CLOCK_MONOTONIC_COARSE.

So adjust the test to run with all clockids for 60 seconds each
instead of 10 minutes with just CLOCK_MONOTONIC.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kernel-team@android.com
Cc: Lei Chen <lei.chen@smartx.com>
Reported-by: Lei Chen <lei.chen@smartx.com>
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
Signed-off-by: John Stultz <jstultz@google.com>
---
 tools/testing/selftests/timers/skew_consistency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 83450145fe657..46c391d7f45dc 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -47,7 +47,7 @@ int main(int argc, char **argv)
 
 	pid = fork();
 	if (!pid)
-		return system("./inconsistency-check -c 1 -t 600");
+		return system("./inconsistency-check -t 60");
 
 	ppm = 500;
 	ret = 0;
-- 
2.49.0.395.g12beb8f557-goog


