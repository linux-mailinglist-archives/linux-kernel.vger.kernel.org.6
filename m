Return-Path: <linux-kernel+bounces-393053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F29B9B68
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98469B21C61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB8376F1;
	Sat,  2 Nov 2024 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xB/o17Cm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCF25777
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506120; cv=none; b=uIFKGNPkLb4yDwUCBb9o2kW2/+NViD4odCpQ7P3pZUp5xkSoMr2a/mrO8KMGa6llTj1me1wFgtFenvqK9Q6SJsUOO4J0B//nUIjHdyJz3prGzHK3Ab8dO/0qyjlFsNPZYyOXoGhIWZQVFA/8+pmzWG1Oj2XIS5QlkMlx4irGSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506120; c=relaxed/simple;
	bh=qPFYuz9BrK2CIqbnqSJdveevoaimtQftTkcT6cnXqi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nPRoClL4PgSnXHYLbPNtvXidi9it8BjVadmMlTx11Vv5ZKodwfp2cZFIthFxslnGEUSjcnkYZOfGzxZvNypUc+ngnjBmibj9Eu0Ui6H5n5166QJwrfec0p3jsSUMyzxqYc48PNKTs91zbnSzX2SizkQAFMenboWi+bTRkQzALew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xB/o17Cm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so33017677b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730506118; x=1731110918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMflO0iOxZawpN5ZUgjewO0l15Uk7dsPv9bQCJvRKFM=;
        b=xB/o17CmLkl9MlPv+u2Pt1Kv7k8cFsrSz7uvxSI/Ig46CyXfWtz2tZjIuZY+OFLSUn
         wZJX6MLdakmt48fMizgvjtftRxzSeMVNwvYwCGFs2zXcv/1t3Q+mW4HK1afSH/cGB2vO
         0zwbPgqgLufAA1hF0j7J7yrlHt9k41oDAPv/FoggkVVo9SzKm0TuO51jbgqtBWi6Uxzt
         t4KCWycz/84QaN3P2J+rVSFdxDqfQrSUPz1xW2smntnqU5m34fnY3Pq/aZHS9Rc8BAkW
         k/+3HOs0mw4XTADKMnicVHRis3s15aRclXG8cr/yEh+TdFV+DbSdPfSBbPrCJ9+dF8MD
         50cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506118; x=1731110918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMflO0iOxZawpN5ZUgjewO0l15Uk7dsPv9bQCJvRKFM=;
        b=T63VyZ3qza2IDuY57mBCNYszX7HQFYv69Vbv4r1WZdRUr4iSEK+6vebB421IXacxTs
         5SiDH1a4mLwcHeS/d6QflA2CvOOeDbFT7T7STSdmACxDb9mf99BCdGYv8XraqXHfSWLJ
         fI3Fo7iQVVg9zjd0WyDMl7neAhAGAnraMzrbcdueONI24vsQSEobNVUvE1OaaYWBhUeP
         ucu2zGVeD4yGoZzGvPfh42u/3PbuAq11bXMsITRN8DLnlg+pa9ipEpx0Xo/0MCeWkRFJ
         7L0FG9iwWNwBzZgZF+MLlCcVODzuFghpzBqDHyUb9KrKHU6ff7VyJcS60747aJ1YX+U7
         +wgg==
X-Gm-Message-State: AOJu0Yxa/2AcxhRJ3xK4SCefQanWIA8J9LbBosexUBeNeKTCHNGCSpOo
	4/B+N0+PqP28sTBC5gNz+VDrsuMKozCMCEPNjTp97qKkotJarm0Flc2TfrJVmDPBxkhgwsUNryN
	8BYCCZ6PEidb/M7KARfhvAQ8xnl1g62HcXMVu0qydukuW7C4pwpu4GicGs072ymjbqx0e3zxw76
	TpFjTzg6/M2fBl+JQcSkQws08UlK2ifAHFY2du71AUODYqjvB5NArke16q1TF+8i6Rors=
X-Google-Smtp-Source: AGHT+IGk0DQ4lZzrHSF/msR4LceTfpO9UC2r93MoAUGhrBvpkJQaqubi60bBsN9z/YYJPlV+RQpFn5dca8i1rnQL/g==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:690c:6711:b0:6d9:d865:46c7 with
 SMTP id 00721157ae682-6ea642ec3camr940447b3.2.1730506117249; Fri, 01 Nov 2024
 17:08:37 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:08:14 +0000
In-Reply-To: <20241102000818.2512612-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102000818.2512612-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241102000818.2512612-5-dionnaglaze@google.com>
Subject: [PATCH v3 4/4] KVM: SVM: Delay legacy platform initialization on SNP
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Michael Roth <michael.roth@amd.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org
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
 arch/x86/kvm/svm/sev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f6e96ec0a5caa..8d365e2e3c1b1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -445,6 +445,8 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		goto e_no_asid;
 
 	init_args.probe = false;
+	init_args.supports_download_firmware_ex =
+		vm_type != KVM_X86_SEV_VM && vm_type != KVM_X86_SEV_ES_VM;
 	ret = sev_platform_init(&init_args);
 	if (ret)
 		goto e_free;
-- 
2.47.0.163.g1226f6d8fa-goog


