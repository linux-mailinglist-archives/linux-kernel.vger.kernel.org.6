Return-Path: <linux-kernel+bounces-281504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCD94D791
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666ABB210D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA216DED8;
	Fri,  9 Aug 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4cGYP35V"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539D16D9DF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232632; cv=none; b=ZsjsEVGDM78oknZ/Tn7K9YRTbDmTz+ddJQ1whfqG46UgQSE4irSHK/S2+tXRaZ599QhlAWlbpa3XNgFtLe0CG22ufYMwduyXIYsd5lWpn4yzB5+nj42bL3INKq07KLL03g/2fajf7uo/cT3dsJl0j9Zo8r3np93sySfRDtkCB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232632; c=relaxed/simple;
	bh=WEKb1xlIGs0k4iOZ5Yx5UQ9S4hkU1zI6zoLoK8JwUP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4SEkU2EXqiIURcNgxbx8OXoaKI4IjW/ZIo9P65b/wc0ttbFowRIorbZF81K+kF1Nxv0cEPf0QW0sgwxCWKjZqCYyaIy9C02PJO0yl5kD63RZ27+DyqE4GUCHWdKIO1ug8FyG0j2To8IwNg8wYkOwFC+qFRyyXGycILcpBNcG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4cGYP35V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-79028eac001so2560129a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232630; x=1723837430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qOWEA+gf18ibEg+1IgBuUDOlia9YtX+EopmbGWf1wCE=;
        b=4cGYP35V9J9edTKAVY6ReehrY14PvgOdHA6GXtdUdpGI4d4RmtIWAj6+uHnGIZnNl4
         7WlH1DZd57Ia6pMgOrgJsgmvjsDijx6MwJR33tcIT98ZwOz9W0qkao+m2DuwYoAQdMwu
         WgpJe9kKQMm9Kmcz2gfjfXPRXJsgZ1Gk7K5LWurw9AQHRck7waZVmWxw4/JuQQWVYhec
         XdLoc/hIYfcPNQkrHjks3Rrgsp1suuE2ez8Lhxvd2bddXJumBvVSeFS8FzQtFb5S3LaP
         P6kPeeZ2eGN0Ten0EpFhF/PqrPiubwOg73pyOPANOwCkuh6otJXQOUoKzhu/QMWm+nh4
         oW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232630; x=1723837430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOWEA+gf18ibEg+1IgBuUDOlia9YtX+EopmbGWf1wCE=;
        b=Ho9po2GhnO4zKWSOI4GFTuy2pKG2egMJewg+kpQ73mIxOg1JFH6qb+wdns0rs8iflP
         /dCPqh0JE0Sm3JfH6UZ/Xkgh14mjvs6TKcgyH2GBrWntQ0jjzbPpsedm3B23O4lTfHeV
         1wMPCAGcyCnskgOINxyRHUVx0a+deCUnSkdnyj3bBM5p0hFmEIOmhi6YFSNLN/B6yUA+
         O+gcQDMooqyF8HY2cROtRG9gVhO296MpFyq4ukPDJupTXltkPBJsw7JUlEQXPHHZQv3x
         9i+gAwu3JpHlPQRPTVLlG1sXQ1u1MBtZ8bHba4q7yY+i3ZlaFyZBnX71oiKAMu10mZw/
         XUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIOSdDePhpHGfWlZrqPNjxOYiZ9aj45wyADADTl8FH5cSqvbJ4MFr9xmM5/Fb2wPtkf9Xp0FXLBR85ssUF0EmY1uEj+PP79fZX9AXs
X-Gm-Message-State: AOJu0YwUUU/f4S28a6zaIUtNfiBOdbY1q7paHoewOnbkb/E6Mwev/N2R
	SQ2buTb6iPCunwFKFde/zvbxBI+9iGqK86z0MUu3rW3VjmSzI+NOGKa0+PFettvuNiKqqKgBbD8
	ncw==
X-Google-Smtp-Source: AGHT+IEN/4gRYyT6fFtEw5/PSlX3VvEJMGy4wvRZ57TDQ5LWVk26M6iloQiU8f0vV2+Ypg0y5mNrr4U+8Bc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6f49:0:b0:6e6:a607:19d4 with SMTP id
 41be03b00d2f7-7c3d2c7fa08mr4698a12.9.1723232630436; Fri, 09 Aug 2024 12:43:50
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:18 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-7-seanjc@google.com>
Subject: [PATCH 06/22] KVM: selftests: Use vcpu_arch_put_guest() in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Use vcpu_arch_put_guest() to write memory from the guest in
mmu_stress_test as an easy way to provide a bit of extra coverage.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 5467b12f5903..80863e8290db 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -22,7 +22,7 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 
 	for (;;) {
 		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
-			*((volatile uint64_t *)gpa) = gpa;
+			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
 		GUEST_SYNC(0);
 	}
 }
-- 
2.46.0.76.ge559c4bf1a-goog


