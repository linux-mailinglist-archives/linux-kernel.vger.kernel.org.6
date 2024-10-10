Return-Path: <linux-kernel+bounces-359781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB49990AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343651C24A01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065671FF7CD;
	Thu, 10 Oct 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwMYhkdO"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5941FEFC4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584766; cv=none; b=onOcQGuJfaZ9UXHR7cbSa2y/+NPwKENey+b9s2461o7OFJSK77jXtbF2LvNBXySSho7AnlsbsdcxQqxIhvssTc8mfoUL0bVv+Q32GuanYeU0yelQrmGiNd6Na8gmRNMC9gy0S/hKKSFnFcYhC2aeL6jGAjddSuuRc01sH9fYpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584766; c=relaxed/simple;
	bh=+qwur9UMvfPsT7xhW5+1hFXGI3F0T2CjnbFVAQFEZ9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WqH6qKiJAFf5MWctb9YvE0igLP9Vz06ur6r7jH7lpgm0knMuNh4NieQegdmejwd1W1Q9BC1JfWphkm1ngHNwiFxHXaAIYUh7UI33tcM11Ckn0rL18ZIEsSu+IX7qYmZCcR+31Icf+aS0aCrVeB3LDv8qa2e4S7DHdKIbsO+ykKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwMYhkdO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71df051770aso1193819b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584763; x=1729189563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3u38MFKj4Hgu0NiviVwRjtFpk/ioMNBGBDQlt4DAgY=;
        b=qwMYhkdO+k0O3GAu86CC0Oovaqx2YjaPKBv6LeLzcOh3PtNiOaQrcv5HBilI8icD9g
         y0Ltij7dFk7sin4usHA+6Wv1hFiwFPtq5Ajocz2SMLSw7EHhQ24kqq+Bt+H2kyBdKaty
         qPo1gORXTlpg4cwuwI2/Xd/UCp8kWbToIyady8yUqr5BbwLt+Kkm56JwyHrVdgysxAdq
         eCA0ipk6bTZMsprIdAiZDgjFHxpqT0t6hWRsy+Feo3csNnBxmMja133Zk9XVBeicQl/q
         2iXz1SFCo5UtodgUyE2QoPpXLNLLkpEupG73DPzHBSBkCdaePTQJNXxdK3uBHhhZG/wU
         Akeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584763; x=1729189563;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3u38MFKj4Hgu0NiviVwRjtFpk/ioMNBGBDQlt4DAgY=;
        b=uqXh5Lo9mOWD4CTlGRE3DhjFQt74dwz2M3Va21H6W7RCMeJwFNrdyEn2Mcbp88Chjn
         +uvEhF1WcoFjHxGm6fcezjm2ZDRLxmuiIRg/b6UbhtO6R8URkR4RxAwdt0HjdxjVZanX
         FKrQ0krMMYQ5IBIZiLdq/O0VL+YpBaiSEw/kg2yWuncDxkUWs7MDZB7p225Bk4/xCr/v
         fJ5tGjg1ni/VPBRCwUfwd1JqTW5AnSgUizJG8TGvNjq+tF4gMVFSGH42wIg7A9P0Hj2D
         BGzJbSzt2RnuDs1N34IFBZ3tmiopvTXmcSo3AMzncagiAooydRO9N9QbJcW2t95oRej9
         Re8w==
X-Forwarded-Encrypted: i=1; AJvYcCXOW4FTEygub3LDFCGTa+vWKsM2GYscIsjes4aK/5FZx7a6qmJGHJ3Vt6t29R4w/mIC+Aqm+gZHN6ACC2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQVbRbkNuGkg0LSbZcav3Vb9Xp2dBma+Eddv7Hl1v6PzX1n+8
	cfVzIcZG9nAoVtx/OlwYqMcNc2i+GzQfR8LiC41gCEhczqKL6SXZL7cXAglKQ01vyReM2jBehVW
	gHA==
X-Google-Smtp-Source: AGHT+IHthU1bxxWE76UmRU/cmSB/2b+tJYVulTyd1SGmZGLYBHQFEbukUNmDJAlwNs2CFth+SfvGFADhDCI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2f51:b0:71e:dd:8f9b with SMTP id
 d2e1a72fcca58-71e1dbe8750mr6976b3a.5.1728584762866; Thu, 10 Oct 2024 11:26:02
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:36 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-35-seanjc@google.com>
Subject: [PATCH v13 34/85] KVM: Get writable mapping for __kvm_vcpu_map() only
 when necessary
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

When creating a memory map for read, don't request a writable pfn from the
primary MMU.  While creating read-only mappings can be theoretically slower=
,
as they don't play nice with fast GUP due to the need to break CoW before
mapping the underlying PFN, practically speaking, creating a mapping isn't
a super hot path, and getting a writable mapping for reading is weird and
confusing.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 080740f65061..b845e9252633 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3122,7 +3122,7 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, =
struct kvm_host_map *map,
 	struct kvm_follow_pfn kfp =3D {
 		.slot =3D gfn_to_memslot(vcpu->kvm, gfn),
 		.gfn =3D gfn,
-		.flags =3D FOLL_WRITE,
+		.flags =3D writable ? FOLL_WRITE : 0,
 		.refcounted_page =3D &map->pinned_page,
 		.pin =3D true,
 	};
--=20
2.47.0.rc1.288.g06298d1525-goog


