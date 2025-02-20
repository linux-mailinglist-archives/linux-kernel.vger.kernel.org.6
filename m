Return-Path: <linux-kernel+bounces-523994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98086A3DDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1677AD7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35E2066D7;
	Thu, 20 Feb 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qz2lb2jc"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A9204849
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063830; cv=none; b=CQ3dTb59kpZo11WIGQeFK17YzmsnpopMTcfizN7DVYeKsSvidUIpBOV2bOvqZc0uk9PiHPwIL7WqQhay5/4/5Vbo0ehLGvOL5xdDlpP0f100Chvrmu5kh9AhMJlCsLfYJmqPQTWRmkDgiIjzPvH5GAUXq1Wh0h3FGA7KmwIF0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063830; c=relaxed/simple;
	bh=Se/GydgHH9nLLIGfdGGZR9s2IiE5I/RUbIaLvfmjrag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pis3jzEjofF/354ZXrR/REJ1aX9YwGk2tyFkMaOEO4wlFHw1d1IRXf4U7JCM1mF0ylpU0A0Xkqzt60CaVHcxm7bOj1fe2kYAhHoBwXgf5yppHh3Tt3jfeqyIjaSu42vonQJ/eMhroMPcIe5bxSUoMZogisWJFOKgdj9rtdfWXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qz2lb2jc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso7711175e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063826; x=1740668626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0OlocBh0Rs8sEPgodfZSsh3pCn2jLgGhmAgomJhmE4=;
        b=qz2lb2jcxfwkhdfoOfo9B878dvkifMzWIFPKKRGP8cmDCdnz8WN1DSrdSwM8MEdzXt
         4CTF+SxaF7CpeMY9yolDSYEfH2TY5H0s1QoKk1+roTraYawOhkddRlsmQhYehNfnf0x7
         0pAq/Zi3ltCMA0W+WecLmyQQIjcXIKHY/5cm5Gj94SWVIf+mjIdX7y7+vvWcYlnnT2pu
         gs0w6jdtoU4lvrMrVF4AKHYlrNfLYcStyZM5RnnsAp9D1DLNyPhQ9Vy0s1oGlFR/Vlzr
         l7gdmCE0sKphXNOQXnAQp/E11WLP2/OXfn41kt2Tgaj3AsXQT38wJ9+vebM/IkPEMlQd
         MRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063826; x=1740668626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0OlocBh0Rs8sEPgodfZSsh3pCn2jLgGhmAgomJhmE4=;
        b=h/PxDEI1q4nO6z8IHFSSIt+VpoehEke8fNjQzTn+oHno6jXSQUi2G08m4y9rlCPSHy
         WoBdBZCCIDRkqSdP6PXZn/iw8Bq9HaYsFr5iWOUxMMjml4Ofm9zZ+OT0ZnnT+f9uDycz
         +w+YVnWbF92dAz8+bgP5cIqn+AufV2geCrj92awICmrlLHUh/EHvxG3Lmi51qkmkfn0J
         f83P0PFWDrHKPu2DD9quss/VBNMguspgxSCwzWHKzN5A0Ll/tM2xnHkbx0xeMADPfWnr
         MTcs6Jv/lvigvFI3DXNbfeBGnh0D3IzwMy4r/epFOzgIdpd+BmDh5XDY/LUfetpsT79b
         ZtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmzJTQ3Z+pBkT8co/LwjNj9K7UQ3R6IKyt/9HF2MOgPUuLRmbjiIwC42IXLPg0lrFYvmdJPx0rBWHdr3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6z33TJg9vPth/D+8INInJUt+pAG+jpHOrNaPWWSAcTs6wMUX
	WXvAX4T7ytohESDqaz8p18TZyPoz+ejN9Omv4keXXn6fV4/RM781KyilNrMxrhRn3jYo29aOFyS
	7c/ZK0MPNWw==
X-Google-Smtp-Source: AGHT+IFsGg82gKlzl8tWzntDHJFghDx2t08uXQ7P5idCDRgaVqvqc920eCUSioT9wAdKGGY50Zw9lE7MF0GKww==
X-Received: from wmbez7.prod.google.com ([2002:a05:600c:83c7:b0:439:67c6:5642])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:47a7:0:b0:38f:4b15:32fc with SMTP id ffacd0b85a97d-38f4b153521mr12347926f8f.8.1740063826684;
 Thu, 20 Feb 2025 07:03:46 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:16 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-4-9bbf57d64463@google.com>
Subject: [PATCH 4/6] selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's obvious that this should fail in that case, but still, save the
reader the effort of figuring out that they've run into this by just
SKIPping

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-wp-mremap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 2c4f984bd73caa17e12b9f4a5bb71e7fdf5d8554..c2ba7d46c7b4581a3c32a6b6acd148e3e89c2172 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -182,7 +182,10 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
 
 	/* Register range for uffd-wp. */
 	if (userfaultfd_open(&features)) {
-		ksft_test_result_fail("userfaultfd_open() failed\n");
+		if (errno == ENOENT)
+			ksft_test_result_skip("userfaultfd not available\n");
+		else
+			ksft_test_result_fail("userfaultfd_open() failed\n");
 		goto out;
 	}
 	if (uffd_register(uffd, mem, size, false, true, false)) {

-- 
2.48.1.601.g30ceb7b040-goog


