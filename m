Return-Path: <linux-kernel+bounces-523993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123BA3DDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286F3422552
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886F1FFC5D;
	Thu, 20 Feb 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mczp2c5g"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03F1FFC4B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063828; cv=none; b=oHLPtmEKfssOadj7KtCzcWd3MfQzD80KII/auITy4xvgDlWsQYIc+S0MV7NASTjrI+55PGsuW1Et3iq/mcrehwHJwW20xcR6FGfU3KHPJtAcgDCOJLCB5JiHmH0C+LSax+70Llbzh9rlmNbJZ/GIsL5uOVGjMLh0nrHi0VPZQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063828; c=relaxed/simple;
	bh=9/O8tij2wirjK4B8U/5x/9fVjzo452E6485tV+fUgJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRMBEno9wBDeoiS5Y7dzzBwvds79FSOAeGUW2XKn2iWxI43IbECiNc3JwJEf7UVFecVVdlfi6H6JVthMlp2zbekkSW9n/2ao4OeXg/QxTe9s8aJJMv82AA1/aFdCymEkGIBwzorKdV/xmqN/NBuKGcb/hysK1T8kbTVPEL5Jdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mczp2c5g; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f39352f1dso391014f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063825; x=1740668625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnk8jRZQRXvEGJgMo7kX45MXuk74eHKcJOVD1/hcv8=;
        b=Mczp2c5gq4YUVpPbkFVijBQFGvOx33gKT8cYp+BPPXb1kY90V90DJkvU0ftxA4ECy4
         djgXKcMO/CtK7m5c4chK/Ri5hiZn2qRTLsfPxzN1UpeLosy5mDA9aaJ1QT//4/yYY/Gm
         HQgfaeMIo0vSjYSuCaHhMvCmICaxe+GtRrwUdUXO8ilF8wZa1VE3XsRbCqah5rr198IS
         TZTQyIDrqglfCYwZkRw2MrfwxfJxYdGAMWeNkvGJ6h7xDzciLGwxrAd/WDjz2WfhNVZR
         Zi6fz8Txt9USUJRU9hyFFza/DfJT1BflfjgDCNJMKMSZqhp+Ys8V+kOHxm/2P4/cmsFJ
         gUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063825; x=1740668625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnk8jRZQRXvEGJgMo7kX45MXuk74eHKcJOVD1/hcv8=;
        b=u7hFreBdFf0R1GxN2X0U5jnYSfD6axQ186JV7TbpOiyTcEm7Ca1G+x4gnw1S4BKkmr
         p3Ln3yOTEWXzbUTxXZmuyipDrpbIdKEYufEIflJtmDDJkiFlawu2CHbcVPY8IRmINMjD
         dbwgF/ZSPN5obhu7TehfZWlnaaL494kvbaTCV+/NVFvga/yns65pzTdsBvgndoZ3+TRM
         +lg3ms3gpxSONsOOfBJVOer8Wh0uC/Iq9c5OTDEU+PhjxUnyw4gee+A3z1GmtBpTTat5
         +Mc2x2hfm75K3yIVzh5dPuQPjgXmlhtWYtLFCH7Io6MtVIf+R5/FV46aIHcBJp2uCMKp
         MVog==
X-Forwarded-Encrypted: i=1; AJvYcCXpvdDyYTxkxEV3slU4+Kyny0AJuk0YSLqQy0ZF0c0RWGeIh1W4riCGeg00jz9/mYg1j0p5H0cCyQjSAGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWTO6mzl5twKo1Dyl4jzMgM1+0Xhe6JA57gz8dSCN6PcqKfhT
	jzuKj79or2etproNPhpziDTw0HU6btfKIqItpwCybG58Pi/q9tv3NOkJqPANUicng3L6+kCAefd
	9pIvI0ycDPg==
X-Google-Smtp-Source: AGHT+IEZkoGqvABvYTvvXiRtV+S/mpL0J7HYkw5xP36OjVJpS+4DgqAiy+8j1WNNFXzaMG5CNB+I1Lj8O+cs0A==
X-Received: from wrbfu21.prod.google.com ([2002:a05:6000:25f5:b0:38f:3cf0:aac7])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c6:b0:38f:3344:361e with SMTP id ffacd0b85a97d-38f33f2e954mr20711279f8f.23.1740063824704;
 Thu, 20 Feb 2025 07:03:44 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:15 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-3-9bbf57d64463@google.com>
Subject: [PATCH 3/6] selftests/mm: Skip uffd-stress if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's pretty obvious that the test wouldn't work if you don't have the
feature enabled. But, it's still useful to SKIP instead of failing so
the reader can immediately tell that this is the reason why.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index a4b83280998ab7ce8d31e91d8f9fbb47ef11d742..db5366b4766e5bfa2d1150d2f3c2d32469a6e28b 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -411,8 +411,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	if (uffd_get_features(&features))
-		err("failed to get available features");
+	if (uffd_get_features(&features) && errno == ENOENT)
+		ksft_exit_skip("failed to get avialable features (%d)\n", errno);
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);

-- 
2.48.1.601.g30ceb7b040-goog


