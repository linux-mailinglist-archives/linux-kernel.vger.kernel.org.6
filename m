Return-Path: <linux-kernel+bounces-349739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D168198FAD0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F52C1C22FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604331D0E34;
	Thu,  3 Oct 2024 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/DfmBlF"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807C1D0B8B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999024; cv=none; b=Cp8UEWcczJFRUMeU/RJqA0S3VeES2yho80ZeGQG9d6z90J1JgeKLsiR2bzrBO4ajOQ+3rqfHZONe7iwHiYOe1b87hhHIfeubzj7x6keIRxzmKdJZTiFlwKh2fVyxGTcCEd48Ondci2Iho2loVO2mZ4jjCMnxO3nP7bvndy7I8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999024; c=relaxed/simple;
	bh=dCT8bXCAqzzFJVCOs7D2QLba2AuX/LxeOumRe2jwP14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cfNusvtWESDnNzpvUSAdvkkztqRB9EngwmnCqekd38SIu7cU/bNqWnqIQ1YcqzjnQbV04tHVs+cML8itdXsLSM2fiw9/A9BVDOUnrqg6atBXGmROJutZve1h3jgVX6OOmSgo9MWdUuWaTeBrED9Jn3M5P1lAYE0g6lgHZqbOnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/DfmBlF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20b6a967007so12296365ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999023; x=1728603823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2q4amWCHB6J/4atN9JkqFjKadmMrC6jiYsYmH9GeA=;
        b=j/DfmBlF0XueeTAUmTobLtoKu+JuPt3/lsv58+IYI2kNwnKRXj85Qmei653K0dtRNf
         colbLIEw0mms1FjK9K/MxrF8oeaHfmvxzUWqwNdJsJLyu0Poff5pgEy6RU5cp/LfKwbi
         qQqDqGIdRmLWlB3OmywPAvK1bYQ0ceKcbI+YwL7iXgrkUGfdps7nCQOcygJw17KNqHnm
         zytZ1H6lhiR4zd7F+Y0WJLorGOjAnX/YQ5ZurmyDC2swCdQAiK++iOuIA5I13ZoKi9Sc
         3GiCpmN0aelB2i4OvVb3Gde2mKCsLejr9dYySL+cpe2OdOYs1sAtkJp4Pm7QHrjwirak
         BbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999023; x=1728603823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6V2q4amWCHB6J/4atN9JkqFjKadmMrC6jiYsYmH9GeA=;
        b=klzfntqx0D3RX5Thk9NOdX/pPGB6naOI6H4covZToO5zOFERtDA2sCfoStcO1WrIDJ
         KJBw1Ib0KqOYX4NV5dyTDSUipa4T1fzRL5DXG7XWo/F+dhzwc7twH1vAcU5C7t/nu8F0
         hzfWGtTa8iKMNe3dmL577xgTd2KTL+gAQAvfsmZ5/BiPd+oQU5rv53wDqlNlgTWFTDjy
         lBbbZ4xiTBi7OHCNlpYSg/DznPLqQ7zc2WL2egVmaxy+yFK0MdJljc8nXfqC/hZwVSRE
         UAgSPV6h9UGmWw6OAWkYjyze7ICBeum4O60Rr7iLs0q/xXiunmEQ3gJxcVON2Sl92Jb2
         fojQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl7QsB94N4vcPlMj72uOTQmntwmIbjy3qZeO3373izQo93ueZVZ2XIRmJUxpPiSVkG7OoOrU5oTxO33W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHOx8dSEH5QBiexEGh4ryjzLlxEC87I5mbxj9/+Ic5Xlh3sbk
	xD6Haym7knX0UE4WVFDKF895RGCT9IlmvACBHghCjc4gGsFFteapqiYwYjsOGhwwBUW4YYCJ+yz
	3KA==
X-Google-Smtp-Source: AGHT+IFaPFq1x4myrDRmgES6KGTmO/IX8Xo50bZDsQhg0x5tM5p7famkM2K8G8qgEWxTrXonLa0y6KUkJmc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80c:b0:20b:9df1:54a3 with SMTP id
 d9443c01a7336-20bff1dfc9fmr8035ad.8.1727999022648; Thu, 03 Oct 2024 16:43:42
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:27 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-2-seanjc@google.com>
Subject: [PATCH 01/11] KVM: selftests: Fix out-of-bounds reads in CPUID test's
 array lookups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

When looking for a "mangled", i.e. dynamic, CPUID entry, terminate the
walk based on the number of array _entries_, not the size in bytes of
the array.  Iterating based on the total size of the array can result in
false passes, e.g. if the random data beyond the array happens to match
a CPUID entry's function and index.

Fixes: fb18d053b7f8 ("selftest: kvm: x86: test KVM_GET_CPUID2 and guest visible CPUIDs against KVM_GET_SUPPORTED_CPUID")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/cpuid_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index 8c579ce714e9..fec03b11b059 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -60,7 +60,7 @@ static bool is_cpuid_mangled(const struct kvm_cpuid_entry2 *entrie)
 {
 	int i;
 
-	for (i = 0; i < sizeof(mangled_cpuids); i++) {
+	for (i = 0; i < ARRAY_SIZE(mangled_cpuids); i++) {
 		if (mangled_cpuids[i].function == entrie->function &&
 		    mangled_cpuids[i].index == entrie->index)
 			return true;
-- 
2.47.0.rc0.187.ge670bccf7e-goog


