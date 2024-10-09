Return-Path: <linux-kernel+bounces-357429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F114997121
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2987E282395
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98461EABA2;
	Wed,  9 Oct 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TY62f18l"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE31E32AD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490153; cv=none; b=R+f5hYf914gSGuDeZl/QVdqgp2RsdIzDit+wp8mIVjyvXLAmPE8j2rK3B2f2hkcMb2lbgOXZ2apEmStDob8svPWo1VZ1/D39CVydQK5n/5z/wjjf1Y3MMUPqvhJlRcJ/TBNugTmAb9hBPrwyyp4pQgn7dHsewEoOpuxIa6QXuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490153; c=relaxed/simple;
	bh=PSXPNvRpGkOAPBFmE9Lw9VEE3YdfkqX94PI8zXrXzjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gA83d8AAo101WGfI4IoLg+nwaItK6191r/RH8ab6JbOuqNUrHWCgf6mAxVj92aZhnCrOYK3QYrbyBPPMnbIS9nrrdPALESo94no+pIQeLOM4dz4aoOygrGyrx+5QsENNUokx9RiQQdbeFMBs6Z1WG7fV8S2LrG45FAio2GcvMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TY62f18l; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2e5e376fcso335397b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728490151; x=1729094951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J4+JRDfPTu3i9TGQoGrO88TmpFKth6/64PHl7TNFJEg=;
        b=TY62f18lYFHqsSi/rvQhJJeowMIxYPxbcp6p64oStl5WKFlYP9lMuZe4xp8exBlKyB
         YeDnM+1u0e35LJ5rFfrdTEMeGchUKcnFt9GK8SN4FcjIO9JUTh2DIX5Zci/cv+qLwJzm
         OwALaiw6aIh5531YUOrns1KYVcudaPdmtxFJ1Qurcc503CIKdaBFncrlkESwAxAvf5Va
         52G0t9pkFc/Q+H82CmXZWgXV2hcejTOX6ysPaHFId4DlyxLW9CLRVkTIoVGXB8P+c+02
         3sw9jyxonlxg+DB/2DLi/Vw0Pf2jRirIqzdIc7+7T22XjhAoooxCnpstz1BphLnpL4qv
         t+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490151; x=1729094951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4+JRDfPTu3i9TGQoGrO88TmpFKth6/64PHl7TNFJEg=;
        b=FD5FHCYyG8hyFu0mNFwBTjwvQqTmXXlFhw/dvIa6w4l6f8B3pT/7r8eiEA2/vzR3EE
         rcywID5gBut8PnzeJiiPeo+ffIMAJHdAvC6IjhaCzkO0mQ67eLOR/Z0rjvZuTNJRJubQ
         WNNUvJPcqrWr9TJJePobYHEEP8vkz+Brz7CrUdadqLTnR6HpUNtCCmdX+bOT5O3endXw
         nOjXzQ8IrNbCr8sZBMvtubFuxMyTZKxBrrULjJc9+bFc6d+pIk3U1qF/tM/sXoSlw/bg
         Qn70iVOyp03rgc7My6rAdDh0lD0xBiX0XO5Zrqis/pFkYYRPEXrSZf3Uvkc8CAjjYu5E
         a2dw==
X-Gm-Message-State: AOJu0Yz9f6CVzodvYTI3w8rX58fvZuAzsSZ6xzmjFhygdVAVUq/toKvr
	agFnN3hB5G0bQJ55rh72ViYqeApAYYhup3eiRxQaMVFEX1w5OBEavsV+TpRZye2huyMDZR91fUj
	nx67bWY/NX2Qe3CY2j9o6SKG4q6esC255kaRUj3jSRZgp8VfEYGo3ZFkyb4VTVbO9MHCVJi6nN4
	+sMSm6K0Mu6vehMbPtq7e27DHwiL58EQ==
X-Google-Smtp-Source: AGHT+IHh/v1gqKUGM1BBNWYUx+HRB+/b48NbVa7MzzwrUC5bvv7YGG3nH+h3kZviumtVaikoqrrnQUYJ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:6206:b0:6dd:fda3:6568 with SMTP id
 00721157ae682-6e322466d9cmr656517b3.3.1728490150649; Wed, 09 Oct 2024
 09:09:10 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:04:42 +0200
In-Reply-To: <20241009160438.3884381-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009160438.3884381-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=ardb@kernel.org;
 h=from:subject; bh=+Q7W1GiOJkPeWPDKOBo9uqagjD9LHIgeoC2Mxh5XnwY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t5Wzjs1ffPY46eO1bpusehTCZdacXZnoeNXOLyWxmX
 DlH7szhjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRbdaMDEdb5ytZOn3ZKLTX
 pfp7dSXXttVy8e9+vy+Nfj5V1CyCNYrhv6uByoSdnzjS98bXX9fpSBD+LWc9+VSxb4XCOdMJ2zc 7cQAA
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009160438.3884381-10-ardb+git@google.com>
Subject: [PATCH v3 3/5] x86/pvh: Omit needless clearing of phys_base
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  d9ec1158056b ("x86/boot/64: Use RIP_REL_REF() to assign 'phys_base'")

phys_base is assigned directly rather than added to, so it is no longer
necessary to clear it after use.

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 5a196fb3ebd8..7ca51a4da217 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -180,13 +180,6 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	ANNOTATE_RETPOLINE_SAFE
 	call *%rax
 
-	/*
-	 * Clear phys_base.  __startup_64 will *add* to its value,
-	 * so reset to 0.
-	 */
-	xor  %rbx, %rbx
-	movq %rbx, phys_base(%rip)
-
 	/* startup_64 expects boot_params in %rsi. */
 	lea pvh_bootparams(%rip), %rsi
 	jmp startup_64
-- 
2.47.0.rc0.187.ge670bccf7e-goog


