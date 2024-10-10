Return-Path: <linux-kernel+bounces-359822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C85999133
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CAAB27B41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A621642E;
	Thu, 10 Oct 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuDHV6yB"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47E21263A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584850; cv=none; b=srxyr0byeDEyfFbCi0PrrySwhlcjh6Mg/2uL12cTXc13bTsLxtqLKu9aGX3FuAyTkKzHFQHKz0J4S93xacGDr9taAP2TdlMv2UnNHSH8wwRJtCNmU6+7ftu4jWjgzRn78hgZqYgo+KjNFHuLji4iit5LQM05NYSgSlcO7yygF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584850; c=relaxed/simple;
	bh=hdvy6TBStdDo47jCImbsHkCH8/fTSGPuTNA399ptBEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OFLFupt/j1io6JF+rgrlFaef8OmOg4fhnfXNyODRfr8oFQLv30+evLYwRTnSwHrUfGB3Va5X0whYD0sdzE0W7QRpzDE2b9krh29BR8o7DG6PkFliBBZ7LBqsD8fHFM2g3mjf4/igjLGf/RxlXZ2i7BBUl6vK8SjXrnfO0SXKJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DuDHV6yB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7e6af43d0c5so1109715a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584848; x=1729189648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t4DEWxyHdS8FH8bmPlxV35CavnLWtw4MDWneo+GIfaw=;
        b=DuDHV6yBR6R4IF/Tk4tYF2+2idGq/vVgsnDPd/mRNzisey/lK2BmHd3cUo9vBvOANi
         zkoGepVCuNujuKVT0SvZmDE0XvYHerpurUIIJMAeWc+b57hH47kC0QJ5wHtQEMfJHmPh
         PpaE4aHKRT1h6TbKpgXWXqnsnto2OGNq0fH2Ws2KY8/MbS7jjFY3wbSKnu7MIzTUrs1G
         et9W4d1rTvNIgRtfcukOUMCi85rcuo5kTXGS1TQ9auZ4CcSXEEnywcZI9uI5KSy/FVdZ
         YPQRO6b5YAteoGfO1rbMctMWpre/nlO8BdIZjHegGDTKR2Jshft+Hp1edSWuOGnxTxrC
         JmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584848; x=1729189648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4DEWxyHdS8FH8bmPlxV35CavnLWtw4MDWneo+GIfaw=;
        b=aDqPikrK8p/J414BarPEOPFVzeaDzG7YuVWMp1CaKbWZizpCTZaM3wghzChsseuPF0
         ALpCMCG91d3hHmHiQY9jwpmYpJdnz9RGjNEvIcX32bpz7RHNNlW3Gn3mpOjNH8m8i4bx
         N691VH7nYsd9GjDYUlLkScgT6igS77YFGA56s1wp6CHXd4NgR4QseZPXqrn9mKgWH92R
         lyY7Gnp4baUCd4tdF+dfNdTqbVcT2MKQPDe32YYuPFm6Cf1p20d7fjTGwA5uOoPoRKPs
         +4LQQcnPZEEm+b+i7ZYpvC0XPoZa+qD+ey0YVwpOKH/4rjo31Wccbby0SLBjNB5ku+hE
         c8IA==
X-Forwarded-Encrypted: i=1; AJvYcCXfds0ODhVNhJNrrblzMLwEOYAIbFQx4gY9SgvbByBJQejLEsxXIfyPiURAgvIhG9dmcWRVcEdcRyDaFXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJ45nTpBEyFJvDgqm8CFjKoYn4frdAvmmuYVD4WpDNJJyfo8w
	j+k1IiMqauWq2w5bmi5c2HhQupX92DYBxPmd6k7qMSI9kG+kOVRMgusjEiRZbxqbt4UmxByQ40+
	c8w==
X-Google-Smtp-Source: AGHT+IHU1NaHt28BJAfE9+Eihx21gIRaHWD3wJUzNDiwOfeaS4l1n7K6hdxyKTp49hAFCJqVbhS/fDDFwRQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:2545:0:b0:7e6:b4dd:fc0d with SMTP id
 41be03b00d2f7-7ea535b0baemr20a12.7.1728584846518; Thu, 10 Oct 2024 11:27:26
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:24:15 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-74-seanjc@google.com>
Subject: [PATCH v13 73/85] KVM: PPC: Remove extra get_page() to fix page
 refcount leak
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

Don't manually do get_page() when patching dcbz, as gfn_to_page() gifts
the caller a reference.  I.e. doing get_page() will leak the page due to
not putting all references.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_pr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index d7721297b9b6..cd7ab6d85090 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -652,7 +652,6 @@ static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 	hpage_offset &= ~0xFFFULL;
 	hpage_offset /= 4;
 
-	get_page(hpage);
 	page = kmap_atomic(hpage);
 
 	/* patch dcbz into reserved instruction, so we trap */
-- 
2.47.0.rc1.288.g06298d1525-goog


