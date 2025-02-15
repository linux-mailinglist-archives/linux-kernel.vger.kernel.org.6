Return-Path: <linux-kernel+bounces-515933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD6A36A8E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549C67A18BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9DB13B5B6;
	Sat, 15 Feb 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Om+ngLa3"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67141C92
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581575; cv=none; b=sPj8Wim9q3fndDVohZ8FpkeLitfpbtrtKxrXE0/qunboiWbZYHslo/y0DVXIhlI1WJHKtoXhkJz3T2Dj7VNkL99vKdgKo9J5J5v9uO7mT7W7alA4l0Gl+KiKI3K7a6cRIdWaHGWPVB/gqJu+EkzPQT2raos4+Qm6Ac50ImcjOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581575; c=relaxed/simple;
	bh=5wliXWDYsrFCwme0bU8BDoFYLmTGBwCFoyuhP4vduys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IJVXOdN51ntcMwgH/Mm9TZYwgTPoLZNWRGO7qClS8cKBOPOP8ZhwBKBbK2F4+FcNW0nnQMqQhUt2sgIDLk7H+9izYYeUpFOsIFQQDoCTDil9nt/taxjJGKathIv7j3auzzrWTsWRZegRIPc7W1e1N0HeFiJ7AQUbVLrjnsuLW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Om+ngLa3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220fb031245so18000225ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739581573; x=1740186373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gnHrxG87g2zrpNznbUWyypfRtpr7va7BhlbJAw1+aOQ=;
        b=Om+ngLa3jxTKgaX7Canh3KrefjMF9f9R+pxKqw1qMdfYuVfPoVaPM6YaDh8Hyb5iDM
         UhN03+GRWOS7q/aDkQFRHaXpeN86Zxzjvb344yehazSmn/YkJlIWFil2ZbBa+x6iGhCw
         Qm0nNnmuh3citPrsn6yhuwaP+HMBObp3hUmSnmziF+NfXviXyislWG9G19A+amZLwpQO
         0iucd3nGaBBK6jxkc736S3WhXBbZTV2mq0oJEYM69AFY6YCWUap4ZeGLrumthlZ30e5q
         7T/+dtdwWBxu5xOQa3teEMxF/mt/PSb7F6x0aptw8JM2hb36QSM5oiCBjyXBCguTPWqj
         PDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581573; x=1740186373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnHrxG87g2zrpNznbUWyypfRtpr7va7BhlbJAw1+aOQ=;
        b=OaGTF5GOZ/a+4EVj9CylsCcXN4YBZPfV+HSLmvDtk5oBxCd45Bzn3YXAKQmWH7o+Y9
         k8gd5VhR7WQrntctFXP2G6MrX0jPbT0BP2WJhz/pjZOj1V4gJ6/ZXo+S1aIehS7nk2hp
         m5b9vNpLwOA8LTYgbN8TO/L0GTwVNF4sqtumpxpa0vk26XcYJZ7cSaF6UiPMn0i0/NGZ
         7xdik/w8ZhGvCWLvv4pBjTi4BBaWlWwFYXXwGl74ISJSqBLk0MqWkLyCQRCDGKaBquQp
         tZzvjhS9UiJjehqJiAUQKjYLZdA8lw59PVS4rb8iii7FzY0LPIqt2XUSsRljol5rg/Vc
         3fHA==
X-Forwarded-Encrypted: i=1; AJvYcCVA98+3DQAH6ZWPRH+Nw94ZxMGGhgQsLTmL7Y44sP8PDwPke72VcMXB60YCGDi/dbuASkHQxFrRG8qWCyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxld5Wlb/xKaTe4ywZlL0v47CblD+SvNBCDdUrQOBxxc1L9vuOG
	PwSWaUJvCvqjla5MmHa9BIG6jEo8UvilFSxKxErMKsVaF525Wv8y1wbNvdN5vQiFGy/TpdwsySt
	bQQ==
X-Google-Smtp-Source: AGHT+IFqpbcx0eksJgzswjg2oejQ8+iZ+7K9CjQZzR/co/7jmMUA3+1XjLY7h+QZJ+aWbZridj68BiDJaJg=
X-Received: from pjbpd11.prod.google.com ([2002:a17:90b:1dcb:b0:2fa:27e2:a64d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac5:b0:216:7ee9:2227
 with SMTP id d9443c01a7336-221040a8e62mr21822595ad.36.1739581573052; Fri, 14
 Feb 2025 17:06:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:06:08 -0800
In-Reply-To: <20250215010609.1199982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215010609.1199982-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215010609.1199982-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Don't inject PV async #PF if SEND_ALWAYS=0 and
 guest state is protected
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't inject PV async #PFs into guests with protected register state, i.e.
SEV-ES and SEV-SNP guests, unless the guest has opted-in to receiving #PFs
at CPL0.  For protected guests, the actual CPL of the guest is unknown.

Note, no sane CoCo guest should enable PV async #PF, but the current state
of Linux-as-a-CoCo-guest isn't entirely sane.

Fixes: add5e2f04541 ("KVM: SVM: Add support for the SEV-ES VMSA")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58b82d6fd77c..3b67425c3e3d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13395,7 +13395,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
 		return false;
 
 	if (vcpu->arch.apf.send_user_only &&
-	    kvm_x86_call(get_cpl)(vcpu) == 0)
+	    (vcpu->arch.guest_state_protected || !kvm_x86_call(get_cpl)(vcpu)))
 		return false;
 
 	if (is_guest_mode(vcpu)) {
-- 
2.48.1.601.g30ceb7b040-goog


