Return-Path: <linux-kernel+bounces-359759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B399903D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4197283679
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B790F1EF09E;
	Thu, 10 Oct 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrSuHW3L"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD71EBA06
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584722; cv=none; b=GrTKTMmRjXWviJRqsWoEB1sXlisLtf45tgZVnZQDy5/1PPRwO3UdJn+wA+XL3QGXYJNXPXQwHWUehmklZhROaUBpQYNy+HeFw4i1bBIOPWW3gXgREhlmtxtXn/NvyD/aYsnOaRKQh9CB+XFxU+o4T5piX8CQWzCa4PjwBsBGwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584722; c=relaxed/simple;
	bh=IF5BVNwy5lfsZS2zGuSAAv+TGmQDGgo7CuXbuO4ZMc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OgtgR/nEnrelRHzkHRCS+417MJ3QnWBFr6P/dTedOHes1KXBK/zG/58Vyzm1u7DdZzerEy8IlNCmnOpdfKWlrU4fDTXVX5r/RY/vx9+11AJedIxViCl7WsF05hHmU+X32baX65P8E7HZAylKa0dxGIo3IsC4CT+l7hLiPnKqkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrSuHW3L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e284982a31so22425127b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584719; x=1729189519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0+KYw/6HzWsmGATvSxbQuKdqCcRS3waqcwxHrAen8Y=;
        b=OrSuHW3LuAFGFcLFdBetAruGipimy71Kdd23mnkCvSb3kzL/ihIej8uTFHbxMiLtnA
         6YXSI2J+unla/LKg7JIEqX4mCyvrr3VQ406BwPbBG3PiTMk+2hz8bnoRevRPodlhpmMn
         aYJOYXJWz/3t+SqCWv1rhWrcN4c2Ngbiu7CrMUkXV7A/egH9oRwfDsMuE+3yorA8VAOz
         djCQlkkb9mc9WG+6oBsuPymdYZpYY26x8ENW3hOt+jiqZzezffl3p0vFDG1wHBHrBrbq
         D5swTKZ9IT9IBSz41WC4R7QS/s7rDjGVXDZH7rNvgqH9bS1bMtz43t3X2ef5ejrnse9y
         5+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584719; x=1729189519;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F0+KYw/6HzWsmGATvSxbQuKdqCcRS3waqcwxHrAen8Y=;
        b=SyEyQJU1NrPwfqwD6gxmFsdxq5vbe2F87pCKiKtCtmCzUAN71NfXdjALG1MESOBjA2
         PbyDdPBscnXrIazmhdR5Zw96XSitDZd2uBg2oEF3l4kMOkzXDPVuZ8TUgy6KHA0Qxomt
         ad3P32GznrUYXQ3330Q/ECeGNMKEhmOeMy8XSEzPlCDJuBI+wepn/CksHl7/CpLav6BZ
         JiMLHJFJq7SfUwtEJAjCxcnbipOgNIXFG1szPTDEwqM74KG0XPOQf+4eolpW3xCsR24G
         ns0c1e+99bH+X5q/S/G0ttYns8pqTH8oBlfhGY+47jgtKIPY2tfbGVbc4cawyX2b3hNt
         M3eg==
X-Forwarded-Encrypted: i=1; AJvYcCXIn0FcJfCrXnT1mXEI6GjJL5kZN+67jJzdzuOGy+4n+obF3wwQuGM9D506tvlAyFtyz3jT1K0l+Qjpcyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT7zT5CYWEUMkJCIdZ6bmyzhy+K8DNsjJ2xPNTbD8EQX9dvdmi
	mupaHix8tIOUbQM7vH1A04qU+jWhL1rG7iCrI7L4csiQrO+uctScTZimcQtYgnZGBEjN/RhzmIb
	u+A==
X-Google-Smtp-Source: AGHT+IEeBu92qjGJ6/8zutZUBi8WOanw4UupdtztXpUfLE+vAeLHZHNkVuFOksmpHMU427MoGYN+Q9YZlwU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3204:b0:62c:f976:a763 with SMTP id
 00721157ae682-6e322185b22mr897567b3.1.1728584719334; Thu, 10 Oct 2024
 11:25:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:15 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-14-seanjc@google.com>
Subject: [PATCH v13 13/85] KVM: Annotate that all paths in hva_to_pfn() might sleep
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now that hva_to_pfn() no longer supports being called in atomic context,
move the might_sleep() annotation from hva_to_pfn_slow() to hva_to_pfn().

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0bc077213d3e..17acc75990a5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2804,8 +2804,6 @@ static int hva_to_pfn_slow(unsigned long addr, bool *=
async, bool write_fault,
 	struct page *page;
 	int npages;
=20
-	might_sleep();
-
 	if (writable)
 		*writable =3D write_fault;
=20
@@ -2939,6 +2937,8 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool interru=
ptible, bool *async,
 	kvm_pfn_t pfn;
 	int npages, r;
=20
+	might_sleep();
+
 	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
 		return pfn;
=20
--=20
2.47.0.rc1.288.g06298d1525-goog


