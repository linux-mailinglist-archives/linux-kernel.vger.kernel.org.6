Return-Path: <linux-kernel+bounces-406857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B659C651E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B49A1F23AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231021F4B6;
	Tue, 12 Nov 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1O9C3TMG"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5D21EBAC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453810; cv=none; b=XbCqL3taUzQzPfcZ2yJaDyyGYGKLpfGEeZ1MK9RPD1SKubgBu9Lre4L2ue+FHFjRpdIMn/cM5Rt/OPJFMGOOoYDGyZr2seGTbKlv9/fBw6D+gMDAGdNHT2QR1Gov5gjIK60p6eSunm4ts5cXstHTyjj27hq5UzVnCWaFDtJWuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453810; c=relaxed/simple;
	bh=YSlU6X6JKLSeLbKMBuH/mDkE4l3HevChh3sRmgLUBXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u0LI4VxH3EPjOqIWRRPQJ3k91axpwodpbxWbJcVqmUBAKJdWpF2KMHLVrRb1yul33s13x29SkzfstjG0RSoGJyTNU7K5szmDrQhK6ZMf9Q1teA4D9Uo7BTQHARMMH9iulzI8X8+NTs0gVKvwFdo4F+Ot3q3KxH4x9dDuJJ3xa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1O9C3TMG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e578061ffso7341124b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731453806; x=1732058606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuDWJG60RHXCqzpUFxAGPdqK8IqvXAJsitjiTXr/4nE=;
        b=1O9C3TMG+iTQoIKcUXKvgnQLeCkN6Oz7UldGVF3DN5ta0TRKP0ukY4L5HYWj4IImgt
         kHquRf26fByKDfTVtJn3i+vrsjKdbtz8i4bnmkmJd26+3FnVa14681KtWbsLyRIXkBpw
         1padD4NhaVsPFNXRQk7XTLWxtSt4uDCoyTa9f8TrDS9uExPvVvTMZmSMh6Vq8InmJ3oZ
         E/MEfbbnlFjQLTp221EwPsoS4ZS2npAZN9ybf+jHVq/UaNgdO6Nc+9YaeacDdICEiC8f
         vAKTUkjIaE5e1GqJ2dQAMaRR6T80wAjjqYXSGtiKQVyFloaF4thBqtwZvFvZ2t0zrFnT
         bcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453806; x=1732058606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuDWJG60RHXCqzpUFxAGPdqK8IqvXAJsitjiTXr/4nE=;
        b=IO3bJnRojvM/61Np8Iup6gCIXWKmIxJ6zr2vL4QXzole6WFWCDVRzg1cwXUTUoPFlw
         djpRGMfxrScaO2Tz7TfpZC6RMX09MfZ0nPmaDp5vw13E0Rt4PyF5zjiE6eNkNQLTszLL
         VNfbfhAXhrsKqGw9m+FMYFxoTzQXg3VgKI1tsqkDdXDNvWvK0Tmfzit6/Qk3yiItSjgB
         RZYZeA85W45lp1SbORsweYdVRI7GAzxbaRoGDhACsM3aKCMIadWk/hnB4F+1QeaqprWv
         Ae5jacafMWGYvkn6o0ElXl1E5OyhOUOmwPSB0Zjx9Fiqn7CIu6V0qecWdKgfkVYXcNIH
         LTww==
X-Gm-Message-State: AOJu0YzSIr5cVoRLt6S/PMzX6maw+ZkMOBbTwVvZ9NQh+uDQmFbVwB/Z
	Ww3s6VQr/+6w2bX8+dSfLN8z34ddESSIYN1njVYn7q4VkSaCvjH3b97qSoqBjcl42Fp+ZW4hOK9
	wmsPPIcL9Gea6YpkRWg75jyLMqBAFMrUTKNnI9Ey2bVeBu+Fu71NfTHWsB4cGMLnvq2TVD0uDIj
	/96wjz5oYIK9avWEVfAn+R84P69hgXsIqq189kN71dDTRkQDilG26MvA3J7OkymOelWrY=
X-Google-Smtp-Source: AGHT+IE6zPnpQVIS7blTj/Vhu9TTjYHNmJoBXH4WGKbfY0DY+2UePrQxclpNCjF7vH3HqWjU/xgzhv/gANZuiZaWCA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a62:ee0d:0:b0:720:2e1a:de with SMTP id
 d2e1a72fcca58-7244a4fcc54mr33020b3a.1.1731453804651; Tue, 12 Nov 2024
 15:23:24 -0800 (PST)
Date: Tue, 12 Nov 2024 23:22:47 +0000
In-Reply-To: <20241112232253.3379178-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112232253.3379178-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112232253.3379178-9-dionnaglaze@google.com>
Subject: [PATCH v6 8/8] KVM: SVM: Delay legacy platform initialization on SNP
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
index 5e6d1f1c14dfd..507ed87749f55 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -444,7 +444,11 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	if (ret)
 		goto e_no_asid;
 
-	init_args.probe = false;
+	/*
+	 * Setting probe will skip SEV/SEV-ES platform initialization for an SEV-SNP guest in order
+	 * for SNP firmware hotloading to be available when only SEV-SNP VMs are running.
+	 */
+	init_args.probe = vm_type != KVM_X86_SEV_VM && vm_type != KVM_X86_SEV_ES_VM;
 	ret = sev_platform_init(&init_args);
 	if (ret)
 		goto e_free;
-- 
2.47.0.277.g8800431eea-goog


