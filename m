Return-Path: <linux-kernel+bounces-538979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC74A49F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270111894D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7D9277816;
	Fri, 28 Feb 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAHAeie5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D014276055
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761703; cv=none; b=p0JSRTV41qPIm1qk6vJFCkKdJH6LB0AjEpW82N8GmrDnIhXB2w5jVkDQCZ8f89gFdEtKdH9CjTGuIsFKuYb1TaQrngM9SDBJBGQ/nRWzRHLpmuKLKPzo0N5qAtBtzG9+HwIF/IePh6bFRCgIeqcb6lwyjmWyuJEerhl52bIgd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761703; c=relaxed/simple;
	bh=vQSs+Wv2XyuHRXtIYUuvMuXimbQBMJ/md2YsZHKRo2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MM2PB9BGg7SJYCwUcgEa+/0Esx54rcfHNzkB2+a9YqjhZiX9n7lsUo3/zkA04XTqe8oplMYYzQg3dh1TWu7RPLTs2dmUHJ1AGBcAqjo5MNA5HC8DlbBQMur1j7QGA4Q0PtUgg6tL0DvnOuKJD5BtTDKCMEyHq7dOycb07/IKIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAHAeie5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438e180821aso12841785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761699; x=1741366499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBiyc3H23svJ8vFmdmR1EW1tSRVU2LGHBr3dzguiiSU=;
        b=zAHAeie5GUMEe40j+cTcSj0aCC0HWWoB8gDZveuGv1cu5P58RBXVPzX6ahGsVw2n17
         AaEiR5OBhTXXe7JNM9ElEKfcGgS/aJIhaxBMlUOkeCFqZhqa4gUN1RfdmcWQX4JDpSzA
         zEty7EW8w4lulvhuqTX+U9n3FlvwYoDcrqnGEeBDbIV+Dch48S84PtmRgxlNyKATdP7O
         O9SG/mK84COzsRluUJxTRMv8eH50wJm/nX/QfN6RrpSUaT2yJCZP7DSC5z+Npnoh+Isa
         oTuXDs3Jp3MvPr2Uc/UCeWcXPGRo5970iFHo9Ps+zpwjOg5wmI6a0dvlZI09ahb4tG3C
         vqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761699; x=1741366499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBiyc3H23svJ8vFmdmR1EW1tSRVU2LGHBr3dzguiiSU=;
        b=Y7m/dyTyGRf3vGrEW8/eJhSsdtwTaX99OZzSz+AWuk2flIV/1mqeKdMFDO/A17y1WO
         164GCSMVZfKhbmCvFZOktXnxpeJ0hHQ5DgWmezUodTXbna7yfwGpUyX5QmENT6Ckm728
         zYtabons6V8Ojfk+xYPoeyPWGobriXf4RxUStW64wxWhvIVpT0bPrgaJTGbLFEft1Hi+
         2Xul4zXlCR5pu6NLyKJn/NStW21NCxudV23BghbBanPgu2Lvs1DXBfI1IDhcisvNorvx
         g7I3rtb4rGcXEEwigiSn7Us5gw/NaRgPUIpDQ9MNlRRXEreicCJyZv4T6F+EY8YhPtzY
         5fYg==
X-Forwarded-Encrypted: i=1; AJvYcCWeyVroab25nZIQ3s3N1rEX/ujzV5TlCoz0xbeYCIjkpmF21ZFD3bzjSSLBcLAFK7KW0enuVTEe192v4Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwT+S/GQq4JZH/Su8pwEOJLiS+h1s8YJiJjQFQvwdbkwRnAJYT
	X3pfpt88HX5M5RGqwQ6uKf/JFxjuenoIk4lZXz55NPNg70Gz2h9o6TuLK9/JjRJQk0U0NaflN3k
	NWps0kP1sTQ==
X-Google-Smtp-Source: AGHT+IFI4L13fHbxgZZEec4SUfw5Itwe110pr8uhvkmoWV4jeH6QyQe/bJoYmx708YRn7IAUip5ewSWoYEH6mA==
X-Received: from wmbg8.prod.google.com ([2002:a05:600c:a408:b0:439:846f:f9c8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a03:b0:439:9b19:9e2d with SMTP id 5b1f17b1804b1-43ba6702becmr40505965e9.16.1740761699715;
 Fri, 28 Feb 2025 08:54:59 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:50 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-2-958e3b6f0203@google.com>
Subject: [PATCH v3 02/10] selftests/mm: Skip uffd-stress if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
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
index a4b83280998ab7ce8d31e91d8f9fbb47ef11d742..ed68436fac62c76e2ca7060c661487f2f8a6ab45 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -411,8 +411,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	if (uffd_get_features(&features))
-		err("failed to get available features");
+	if (uffd_get_features(&features) && errno == ENOENT)
+		ksft_exit_skip("failed to get available features (%d)\n", errno);
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);

-- 
2.48.1.711.g2feabab25a-goog


