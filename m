Return-Path: <linux-kernel+bounces-257733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE65937E35
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32FF2825D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5B14B09C;
	Fri, 19 Jul 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEdMJcA3"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C614B963
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433088; cv=none; b=cy/ebKceY0jtjO5MX360EQjCTOYnlShQdzVxQUSUwcxhQa+1DZiTi2+6YhkYNr/BriwpruwHK7vFGqYyZV0cAQ7JCXHjJVssCmxgXMGqvzKqyW4vDnSaUOBRrSWhKSCCNJd8Iju+h+V9BMItPV3ZL6hzdKsOW0IdUrAm235kmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433088; c=relaxed/simple;
	bh=koF0ilUHAjbeODWkxNP1nhd3CUNaryDa0xwHrMXzgqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JoHPDilgJ1CEh1MvhKVTpnsMqO2QbjRgBiCE2uAj3R+RfNhxVQLG+8bGyssJ08YU3v7Kv6lQ3xeNqQsUwTFep4OBdHiSkyJvEGAv65MNCfqfrOILtox6IcP+s/LscTU4muCL7Ks/Wx0j3KwclAa08p0VMwg1qFA2YprFPZFzIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEdMJcA3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7623e193d89so2309189a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433087; x=1722037887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8Sk1Boj3nBGrPa6ow6mxcb0YRG2ZhhxIoTDChRs8X2U=;
        b=UEdMJcA3b4AFw8eYBudHXNKiUiUaVAYX4Fol+5+jc4okUfbiTZUO7vrs5itHHIucEp
         pcqd97LvKFOlPhls0z72K2oPac9x0XtJRtnlP1/Klmae3nM5VpyaHQRFdVrMCBnVgb3k
         /vgA+MOTq08XTIXnRkd2WSy7JWMCFOiqTeoFhYdYCKCMq3TQhs5F15CXhtaNl1kwVgwc
         BEp3Y86QwTWmUqp9pZrjhIYWnqkAfaJ7eT1RUhkoAhgB05cRsX3amnxWDLGKr9nBayqL
         4ZKb4+0hdt111qBC+riDjKcjpoScSvM5hnueozuhQ600Ckk3J3tTm/d+MeSKBQNJ7nrY
         tY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433087; x=1722037887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Sk1Boj3nBGrPa6ow6mxcb0YRG2ZhhxIoTDChRs8X2U=;
        b=Vxf9N1C06NbyTG6TdjGdn6Ct5rdC7YQ78QLKdaw8yStCpSHhTbn2BoRnu4f3TZo1Xz
         zTNjRmOXq1tLSdjHRXrHp3vnSEMRtFZFpcTbBtvBM+hjI8T4s7oOTdZE13E8uO6rYJlp
         KSSS4lEyjzJrID3U6X27nVjHGi3WjtiPkGOUcHgcsGCb6aCars1fzv3t0glEPOwFetJ+
         vPpc1/1HN3wwr74JI8AjgaCu/Wxly0rTZ12T1n1e6qKOvbMXYiy/uZicS7dBvYBZ7zrg
         WoDl3LE5eYxKN6LtyytItIbD/PUdHhLMmsPqjnhO/B9IFhy03C212mHWXykT07hUNYfh
         6x8g==
X-Forwarded-Encrypted: i=1; AJvYcCXJqbTN4Yq5RcPcU5nWVw9nOpXBAXKLMMPRUgIUqtH2P7FJiUvnzOh2BTS7E6RlDAQzvkG3MBqPoCB6TmuXQ6SoPY0sOc+c20SArDcH
X-Gm-Message-State: AOJu0YwCIVDilgAIBGM0g5mi68jJ/wdqqXLAa3uXYCYM27xIBPnq7OCK
	OBCPs7aVWW66OYiqa+VnLP+CxOuY6i2nNOP+A/GvR+G59D1aP8kewBR1h/S+tGy/UnB2pEDFfVw
	y7A==
X-Google-Smtp-Source: AGHT+IHS2YxJ7KX/UH9tkB2CnA3jvZqUjqWzd4OIqvGM0Un8cvSzhcEo9bYt2q8f59pE8zSx6ZQrF8NDDIc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:191a:0:b0:6e5:62bf:f905 with SMTP id
 41be03b00d2f7-79fa29df2a0mr2918a12.10.1721433087010; Fri, 19 Jul 2024
 16:51:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:51:06 -0700
In-Reply-To: <20240719235107.3023592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719235107.3023592-10-seanjc@google.com>
Subject: [PATCH v2 09/10] KVM: selftests: Verify the guest can read back the
 x2APIC ICR it wrote
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Now that the BUSY bit mess is gone (for x2APIC), verify that the *guest*
can read back the ICR value that it wrote.  Due to the divergent
behavior between AMD and Intel with respect to the backing storage of the
ICR in the vAPIC page, emulating a seemingly simple MSR write is quite
complex.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/xapic_state_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index d701fe9dd686..a940adf429ef 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -45,10 +45,12 @@ static void x2apic_guest_code(void)
 		uint64_t val = x2apic_read_reg(APIC_IRR) |
 			       x2apic_read_reg(APIC_IRR + 0x10) << 32;
 
-		if (val & X2APIC_RSVD_BITS_MASK)
+		if (val & X2APIC_RSVD_BITS_MASK) {
 			x2apic_write_reg_fault(APIC_ICR, val);
-		else
+		} else {
 			x2apic_write_reg(APIC_ICR, val);
+			GUEST_ASSERT_EQ(x2apic_read_reg(APIC_ICR), val);
+		}
 		GUEST_SYNC(val);
 	} while (1);
 }
-- 
2.45.2.1089.g2a221341d9-goog


