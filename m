Return-Path: <linux-kernel+bounces-400789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E49C126E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656D9283CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04021B43B;
	Thu,  7 Nov 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyP2/V3t"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FA21A712
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022132; cv=none; b=c64vzM4b74Wkb7eoo2OYF9SqpDpcLMU713yaYEqzn+baXKffWQUlRWqfwQMecGhqdp1yC7LDwSS+ftRJD0LgQymrQNRERTkf0v3BPXUsx5nZu0MgqZtmwCiiznR6em3em+ZMuUzprgdWtfo9oyfYvLO5CkBlO7KelcXQoOGuzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022132; c=relaxed/simple;
	bh=lRBqf5twuEZRlunb4SU7u4RsPEMFdFwbD7rStcI1GVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VptRA9vBrJsjruACE/Ixe7BFHGR3KY8Womh5W+v44eqiVT/146xHLg3VOfk9ZqrEvEEmrwF3TPlfp9JdOBWRJWpFXvALq5oLH31Uxgc0mmSeQ5STtHY3B+bUzz53VrRNWc0T7Rp3NJklrcKnL0isyQaSbveIQd5ZnYiliPo6Tq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyP2/V3t; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e3d74e5962so1602220a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731022131; x=1731626931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5GIXxcbWN8I/ZRWs7VNYRYcdtYl9gfySVnkJreof1o=;
        b=MyP2/V3tsnF/kPxEVnh1avO6cI3dTnMi/3iPQQosSPye68UjW0xcfeBL5TczpScKYI
         9awxzn2N2q07iwYRYPsgRPzZwYhce5DxW9MXm7Owo7jBEaOW8q7tQdBBUdqL3k4iP9CB
         DcfCzwZgydhjJE77jj2mrDclB5AxqI9CnRO5cevs83f4Y7n0+AjQeTdjSm5GPcEaKLXe
         BzUCtR2poJzUkuX5Lv6sRD8h0cL4E8V3gs/vcTJNGEQaso2SZ2dxrMD1DpEnuvnbAEAA
         enQefNnA5NpX1txJ/ne2oPxxRilaTXUpPIOZcelAl9nDTpfyDALt01xbWS1jk5IsBwyk
         zTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022131; x=1731626931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5GIXxcbWN8I/ZRWs7VNYRYcdtYl9gfySVnkJreof1o=;
        b=RELc9DRFhLz5rAplajPplkCJadZmO+oduOfz8xpoxdGiAVUAnjSHEMcnnLYEhpVm3o
         qsdcsjwSIqEjNCrph2LXeR5Qn9Ue9rENKK8m4mqju0xMSL+kr85lK6BMAGXZlb8b6LjY
         PkPOjU7aMw8Rems76WXyFZGr1/tzsSVVhnoBRAvyBDzAOh5cucUbTYcn3h21/h/q8jL5
         AyEXUj2NMsKps8nMhy/D5O9YmI91A+HxqHop3OvSdpfhua4m/wDQKlMqQxBFm2IyJgPb
         g7vh5smyyrTWzHAzJACmXykM/twI1m4f7dqA3+kR5Y/jbjc2V1Lr621Ab3irf0LN4/J1
         2MYA==
X-Gm-Message-State: AOJu0YxI1MrHeThV3DQan0IiQr9zpsHMM6tWUrv1LknmSVo8PtPuv/Gn
	IV9rKuIoA0enpptpOlRjHwaM/j7pWdcvUOx2uN3P68BXlVIcrA8G0+QSwnOFdmP5LSbZMILf9iu
	6T1jyEN038z/0ThMaGJmg6zOZVXriFNm5tKhzaVvy7pX5fvbm+H57fI7W5cUTr3KhDLinBHavnp
	kqKyFnVABa4kAtjvRjOCQjAZobgCDGTdXdJknYZo8dIQE+NpZC0x14oD14E5Bf3sIZRR8=
X-Google-Smtp-Source: AGHT+IEwOfZDI4F3jRslzGIEdwn06Xqt2NhOKADKScJCrSFXrWa8oRKCWk++dR3cp8p6tEK54xsId3Hhy6ePNZyFVA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:39c3:b0:2e0:a07d:1e61 with
 SMTP id 98e67ed59e1d1-2e9b16e7a8emr6234a91.2.1731022130343; Thu, 07 Nov 2024
 15:28:50 -0800 (PST)
Date: Thu,  7 Nov 2024 23:24:44 +0000
In-Reply-To: <20241107232457.4059785-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107232457.4059785-5-dionnaglaze@google.com>
Subject: [PATCH v5 04/10] crypto: ccp: Fix uapi definitions of PSP errors
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Michael Roth <michael.roth@amd.com>, 
	Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, stable@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additions to the error enum after the explicit 0x27 setting for
SEV_RET_INVALID_KEY leads to incorrect value assignments.

Use explicit values to match the manufacturer specifications more
clearly.

Fixes: 3a45dc2b419e ("crypto: ccp: Define the SEV-SNP commands")

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ashish Kalra <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: John Allen <john.allen@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>
CC: Michael Roth <michael.roth@amd.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>
CC: stable@vger.kernel.org

From: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 include/uapi/linux/psp-sev.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 832c15d9155bd..eeb20dfb1fdaa 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -73,13 +73,20 @@ typedef enum {
 	SEV_RET_INVALID_PARAM,
 	SEV_RET_RESOURCE_LIMIT,
 	SEV_RET_SECURE_DATA_INVALID,
-	SEV_RET_INVALID_KEY = 0x27,
-	SEV_RET_INVALID_PAGE_SIZE,
-	SEV_RET_INVALID_PAGE_STATE,
-	SEV_RET_INVALID_MDATA_ENTRY,
-	SEV_RET_INVALID_PAGE_OWNER,
-	SEV_RET_INVALID_PAGE_AEAD_OFLOW,
-	SEV_RET_RMP_INIT_REQUIRED,
+	SEV_RET_INVALID_PAGE_SIZE          = 0x0019,
+	SEV_RET_INVALID_PAGE_STATE         = 0x001A,
+	SEV_RET_INVALID_MDATA_ENTRY        = 0x001B,
+	SEV_RET_INVALID_PAGE_OWNER         = 0x001C,
+	SEV_RET_AEAD_OFLOW                 = 0x001D,
+	SEV_RET_EXIT_RING_BUFFER           = 0x001F,
+	SEV_RET_RMP_INIT_REQUIRED          = 0x0020,
+	SEV_RET_BAD_SVN                    = 0x0021,
+	SEV_RET_BAD_VERSION                = 0x0022,
+	SEV_RET_SHUTDOWN_REQUIRED          = 0x0023,
+	SEV_RET_UPDATE_FAILED              = 0x0024,
+	SEV_RET_RESTORE_REQUIRED           = 0x0025,
+	SEV_RET_RMP_INITIALIZATION_FAILED  = 0x0026,
+	SEV_RET_INVALID_KEY                = 0x0027,
 	SEV_RET_MAX,
 } sev_ret_code;
 
-- 
2.47.0.277.g8800431eea-goog


