Return-Path: <linux-kernel+bounces-387494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DE9B51F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B6A1C22C35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73A207208;
	Tue, 29 Oct 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dwm81zay"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9F20101B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227176; cv=none; b=L/sac6Hsfxs6owR8FumcwdPcg3e4DCU2F2A6gdGN3S14kzymnRLEIXpBKBP1sL6FsoLhciyAV28NkJSd5v3GWH/ys3liNnn5EAjuY1BwxIM1L9oZRJyR5VW+ftnlcOTxT57Ahn/79cFDfc5BniqY73Mtxik2X3lPuxwFaT3a/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227176; c=relaxed/simple;
	bh=vT6UGaJCAHZQdweFlVmqsA0PbWlxvJ3lJa2y/UVhQX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LWGvV1fgJS81fL2k/WlH8V0lJQhSqq88OGxnElk8p8iJzOZvy6LMcIjgX3PNpXhNHrjvvyJTvoWEl2e3RA79gWPU660RfaDw7McDA05G+dykB0xKzQu7rfj0gTtxCbm8zwwbLG95SiUTgiFuxghUZPTRhFBlQ7EITM2r2tc6dhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dwm81zay; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so9581477276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730227174; x=1730831974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nIzbr7zBh90Qk+4L+ha95UM8CI0cs/ioObBQO0IhCVc=;
        b=Dwm81zaycXRQq8ZUe56aUt0w2oAqC5/o0g0Qy4tSUYO0IpxPw/U9NQSzK7OEpqX7Kh
         HRANug3eagNeRfQqcAi23oc+LYOOu7QniXrGDroFq/vFGA05im+SBpwLj68iH6bwOtro
         /iggKnARKWrJitgHfugWNmzBDc0kVzfQerxjBtPBW8c8dcktAKIMgDNHKbrp4nXT94W9
         Apw3F3xkIwz+U1C2QKtqTMV/+HyUo7ahcavHG/ZDuBn4GdgWXq9D/d4Apy8BZPh2W1KO
         4Ph6XoXBT4Rbr5AAHQRDeZvzC6xQjwDkiKlV2mHhj4/kG4+LW8hvCzMYV4Chu+L+BVV3
         YmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227174; x=1730831974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIzbr7zBh90Qk+4L+ha95UM8CI0cs/ioObBQO0IhCVc=;
        b=vcmqs7Xdqk7OHPPPzHBgH9uBDkZTv84KQuTX/1okCfxGxaKhNmx/7ZH+x26UaLWglB
         9l3oUejCRLOvRio7x7sEUI/5S/QkADeQqXedpyXzqGLICJwBHDe6sr9LB4rvNVb16xC6
         g2qywPw2e910011sU+UsMl1swEUUW9/Xl0NGsyNyu0wOuuchmmQN+xjrYkfIcT8kklWE
         nPjsrXdIzge+Ux3b2c3cDFS65+c86XmXs2GCxznGuL4vVLI7iPy0mclxbTB0Db4gz+Nx
         vk9p5KECSMqHyRyZ0MfOUenc+GmOSgsrjBSzNngH0TUY4o/XdoT9ob70n1jLhBQxgIZQ
         b2tQ==
X-Gm-Message-State: AOJu0YxwXFI0THxuu6cnqvp5VJaCuvXU/N0SyZ6GeMOySPkWc2+y5C0X
	m2EEKoosLWQckBiVJ/bAhG5pK7tBNxlzr17M351OVdJPgupHrfQL/CPpNzgdgy92Oil9Gv7czJs
	IUtHlEsrD10fH2ZFBwuBKW/txHv756mMsOkMdIiNZJc5OQFnnBZ3sL2R1VBV7uVRuaheyLNC5RE
	xuum8JFe6xw9sN3rk0Cttw7c7JsqwEvz0N9RyChqmd1+bv1ejvK5lMjHFaxThOtX44ejo=
X-Google-Smtp-Source: AGHT+IHSZ9z1gKFuoLjow1B8gxL4DLpvVpticofCNjquLeMSvisfqXyLo4Rn8guu4cbEwZ/Xr0RyrrNg9xIAoplbLg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a25:18b:0:b0:e20:2502:be14 with SMTP
 id 3f1490d57ef6-e30cf49aefcmr320276.7.1730227173530; Tue, 29 Oct 2024
 11:39:33 -0700 (PDT)
Date: Tue, 29 Oct 2024 18:39:04 +0000
In-Reply-To: <20241029183907.3536683-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029183907.3536683-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029183907.3536683-5-dionnaglaze@google.com>
Subject: [PATCH 4/4] KVM: SVM: Delay legacy platform initialization on SNP
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, Ashish Kalra <ashish.kalra@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When no SEV or SEV-ES guests are active, then the firmware can be
updated while (SEV-SNP) VM guests are active.

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>

Co-authored-by: Ashish Kalra <ashish.kalra@amd.com>
Change-Id: I3efb5fbbd0da05ab29f85504a86693f5cdf49050
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


