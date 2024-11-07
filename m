Return-Path: <linux-kernel+bounces-400795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760579C127B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97F4B2196F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EB21FDBA;
	Thu,  7 Nov 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lztmseW3"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B221FD9A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022147; cv=none; b=p9CuIe7gIIrKDvXJe8+xGKpoT1aOnEoi5Tr/UfYWJH72jBsnjAVAYbrSKivrPSiYe02H7fwBbcFrapb2VHPq3cI8d3ftHKZ1tUXiCK+wAZUcr/bYUEGfqZc6KIrmHHNFsdNlCGPvSQLyEMzsFsJVwXz0U5hMrmT1tJvnUHMbTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022147; c=relaxed/simple;
	bh=oDf5npMGctxHpj3CKUaehkTMFi9Hydj7j17liXjYHhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JaQKnFeypQyab/mneEqzvSfWUw2EWOuTUYqZtQhnMorqp2gA4LVgAt+C+SmYrZfb/73IGhZ9jg8KTpgAyNDCyttabadpw8Y6daP9MENS5Trj3IUlyITlQdboaIhzjUxPL6KqdQUa97oGsLgrkAp3p5ZsHye7Z+Xnk3K42kHwID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lztmseW3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293150c2c6so3145520276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731022145; x=1731626945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4EqUUsFU0J919p2J42QwMUZuZnKtrumICd6dLkgNZs=;
        b=lztmseW3v4NV8M40L8TXDId30L5uTXMtKkJTJsPaVGqh0i7hb8DSLwPaKUHhcysbM4
         JG8picOmuQZHHYtfNrsm/Izm+xO0Au9dsuWGvMB5omHTtm4JcLQpA+dlGS+4AicwKXK4
         3F2zqeYZwaV5IJ+nGem4Hu5H8x71IRWiHOdZop7FJX4SKEi3Jdmglio6SMApLodSIO+S
         naQlYbB2t4zd6wMUZgwL2qYTITNkdkGCfidmvIACUciqqUqLNI66INETKiV+ifxseT5I
         xQ9Xy+hOBJxFY0f6M1v3GQIZq5ysp4D0KGXjVWPMaMgTHsy7vrO0z3OPLZs1cd2e+qUP
         mb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022145; x=1731626945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4EqUUsFU0J919p2J42QwMUZuZnKtrumICd6dLkgNZs=;
        b=MZ/hyKURjbMb0rGbzCO2aaNyRxbtYDAoLzTzu+Q9YoA8MjrCwoEoxWkp4fAs6mjhFy
         fcWdG0NsezU/8W7Tul4YACR28X996s9mbBqoszJOV1GDGR/mBuOTfE285+NA8iRTGHpB
         dE7e4l+FxArMpA7rDvraJVbPhp62ztXG0LqRrh8j4SdyBtGaFdf06ZqVfaj5lrJLBXnC
         kzGvZ2oNc3EH9UnfK1z8Wk0zEQwd5MTQMK19+ZPf+VJYY4GpeZES8JC2BUJyDWQPxdwg
         QUVmxImVWqyCf1hU9OkNXHYyEsmgOyGd+OkCq9fFf5hur2Yrd4F2W+QCj+SJtJxVH2MA
         8aSg==
X-Gm-Message-State: AOJu0Yy6EKyqiaOCMmSy985JE2YVzS3V4M+JLqAAGbOLsm1QVFkbtYA6
	wlBXOJREyg/e2+ExzxL2d95N1MTT76ylQdd1rxRHvk6V3oAM0XFv+IAO1GbzdB9y5zvb1SR5uau
	UHReQVcyk4xqYJXhkqhExVmIs82yuCs/eXAdtBBJd+VxUnHVM3YMmLe8RYaIjJ352cXTzMePBmX
	LDoh4GLRJ5sPjN8PAuODe7ln/rEmx7Kt5RNDy2IuaksCu+aBYUS0yKOLd5cSkxH4jLvzA=
X-Google-Smtp-Source: AGHT+IGrBfMJ43qCU7+eNDzkJD2pCLgwnrrbQ3tGEDXhIoI6iYi0P5BCV+iCp8PyeRrxNd5WKW1AEJAk1vzAol0aBw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a25:add3:0:b0:e30:c43a:d36b with SMTP
 id 3f1490d57ef6-e337f8ed8b0mr579276.10.1731022144758; Thu, 07 Nov 2024
 15:29:04 -0800 (PST)
Date: Thu,  7 Nov 2024 23:24:50 +0000
In-Reply-To: <20241107232457.4059785-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107232457.4059785-11-dionnaglaze@google.com>
Subject: [PATCH v5 10/10] KVM: SVM: Delay legacy platform initialization on SNP
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Michael Roth <michael.roth@amd.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When no SEV or SEV-ES guests are active, then the firmware can be
updated while (SEV-SNP) VM guests are active.

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

Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d7cef84750b33..0d57a0a6b30fc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -444,7 +444,11 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	if (ret)
 		goto e_no_asid;
 
-	init_args.probe = false;
+	/*
+	 * Probe will skip SEV/SEV-ES platform initialization in order for
+	 * SNP firmware hotloading to be available when SEV-SNP VMs are running.
+	 */
+	init_args.probe = vm_type != KVM_X86_SEV_VM && vm_type != KVM_X86_SEV_ES_VM;
 	ret = sev_platform_init(&init_args);
 	if (ret)
 		goto e_free;
-- 
2.47.0.277.g8800431eea-goog


