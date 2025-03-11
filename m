Return-Path: <linux-kernel+bounces-556201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C620A5C259
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5BD16ED38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6262580E0;
	Tue, 11 Mar 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVRagUag"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C1257AEC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699124; cv=none; b=AyYYk6ePDHzx+q4shUtMyTbUwwCr9cjsKYiwUof50cUlV4YGMmeyKw53zPBFj43fz9a6HVVwg2c+KAAQaWjmrCNavL+f5K5g0CdVdYgCjh9P/on+3n21ykZpYPM2a2JLWsIGY5bIAQ0RugF7vursPWKhumDxPCAJMtlKBEiXipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699124; c=relaxed/simple;
	bh=cpB8G5qu+8qB5CaAmCrhUFZfkRWT/4ipT85Ja0ySsMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gCxwGFDtYCqMTK7OFWyfUU1PHoXF6rpSIrWGcEJq1SxM1kZY2IqR1OwnHDaIPEfjU+1a1SGWU35JN7R/+7YcvZsJSQ+tmfZE5yMLDaj/6CVq49S+7rKU0SAZWcJZv+YLescEjVTxrZ3GDwMCgdjNXqFolCoJ6ZVtluT0fCfU2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVRagUag; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso26256015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699120; x=1742303920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AK0S7bcFsX0odpC5RGhRJMkWaOy0j3srCbmbQDGiiBc=;
        b=RVRagUag7pOLcuZaLduo9a8ik0O+cCOy+ksP98v6w3foNhEejsY7lomibuB1dOzPOv
         B/2agTO6Xv4f1UceU8u22GOEDCt/Su0ToFd7fmHZyF3Nou/aO8TLUBG0X36O4LsyBEwD
         W7IuGpdsAqr3L9LIQMBlQbZcnS9Kn4RjO9Fu/aosnt4oxl0rZN3Tko99wdB9hCnO+2nF
         lqYq1Ep96mzpxVctBwGmPrCkM9RjlWIb9IA4JjE1jOGMi5Z1WXqy6ky54EYv/3aaCIJe
         Jy1XItIpCxdFSnyHE0XAPHLlRRTQ9YA0B1r3cViip5l73r0lYlwHO8Vkm4zhp9sy9lnd
         P7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699120; x=1742303920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK0S7bcFsX0odpC5RGhRJMkWaOy0j3srCbmbQDGiiBc=;
        b=JQBvWX7BPQbsGP0vfYmhbCShk1Ff9pBcEPwdbGIKblNpjnAgbaGyIx0Ppfu71Q+ZCw
         OSf96uzmA59ewftPd7uChbjhnFH9XrNOOYRK54UxtjZxC27rV0R1C9T1fREYhZ97qI5U
         tf5ibc/qLtk0uNrQAgVGrEyTbSC7foM32qSfB55sVIhcbN3Q2sxhfmZPxtg7TNYnBG20
         1IOzpCetZUbLdzUI7z+Nphjw7NoR4rwjsD8wbylzEFkN0pwS1SibaW7mU6acb75F+NF0
         UwbUwia14QaJRZNZ/I5O76in0Kx0wX/ecqPFRfheg5/C/Yq8Z7uPzXZIqLajjD7/RlEr
         E/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Pc/FF/62VAjEfHLZM3ex5nkzqED9b0BZa4y042OS0ygD+hspCcZIJEIGhD9MHS7nbZBqvUsaoOtVHIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOm5CwiPc8ldATJp5ur/+Dq14w60IXKtAjmnjbjCmWCzILa/d/
	W6UKn4KU8zH21IvulTZIDWB7IQqR3GIO/DCj9qifTHp6827Sie7ySuUiZCScKc4VQL3By8gGW0V
	3Aa9XD0aOXQ==
X-Google-Smtp-Source: AGHT+IFnEky9E+WTZ67n4oDhD85FHBGvf1ZaUlsC4CSzVhw94LW+c4vdMdF17ZTVjJHaNu8o0hoGt9vNnRMLVA==
X-Received: from wmpz18.prod.google.com ([2002:a05:600c:a12:b0:43c:ebbe:4bce])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444d:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-43cfe154379mr72788015e9.15.1741699119995;
 Tue, 11 Mar 2025 06:18:39 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:22 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-11-dec210a658f5@google.com>
Subject: [PATCH v4 11/12] selftests/mm: Skip mlock tests if nobody user can't
 read it
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

If running from a directory that can't be read by unprivileged users,
executing on-fault-test via the nobody user will fail.

The kselftest build does give the file the correct permissions, but
after being installed it might be in a directory without global execute
permissions.

Since the script can't safely fix that, just skip if it happens. Note
that the stderr of the `ls` command is unfiltered meaning the user sees
a "permission denied" error that can help inform them why the test was
skipped.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index e86ef8cb37d00e572be8cf0ea9cc8246d4eecd7e..1467594b594c4fb1dceae875fe7616ecc3cd9382 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -337,7 +337,7 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 CATEGORY="compaction" run_test ./compaction_test
 
-if command -v sudo &> /dev/null;
+if command -v sudo &> /dev/null && sudo -u nobody ls ./on-fault-limit >/dev/null;
 then
 	CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
 else

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


