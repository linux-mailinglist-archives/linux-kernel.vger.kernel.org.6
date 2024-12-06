Return-Path: <linux-kernel+bounces-435758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4283D9E7BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E7916B1C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44B212FAD;
	Fri,  6 Dec 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UeZWq2x8"
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D981DF743
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525222; cv=none; b=KeMwH/K86I0ik1ZaOd3pONHVDjpi2XPSWVQx7rRkkDDVveG+eLhs7KoIeRVxOStC9i0+FCwe9yha5kPwJX5JURh5Sxcn8Nx6+XyiQLDL+513maFPpNWkRBKAZ2WIfXIHN+Z0MT3rUMuv/HF+F4cYsaDX3jq466xggABy4tUeNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525222; c=relaxed/simple;
	bh=iITAE1Ks58yzjB7pv45kbC7F7m3AmF+RtaX7q902Uf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbVBz++S2S67ADxTzfxXCoHhTPUvLxG3dMArDp5CeCeu9qJc1lPtxbXpXa6bRQJWM18HbNz3hdBBQ2klZD0B4RORhluLCPYYU/ZlWfUsgtk0lYngzvGEfubCyg7GYG3JdZ9qh/98po4vXPoLc6EvQfjO0zjteSCpF3LjymlCvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UeZWq2x8; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-515d5bd3a96so502122e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525219; x=1734130019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xOebWP/M8X2cP/fdZF9vXfDo8byCjFk2C5X5FbCC10=;
        b=UeZWq2x8T1e3RuJxryf1R9hW2RwLmEkMrt3ufE+U20FGxTLb8Ugy4tn9n4jVUpbpQ5
         5PeMMpUTNjgPZx4RIqy7Hw6qiw0R2b3pctMJiogjpYF+D+o5kaysTfRx5aBoagIDo7b+
         qVXEB7Q6xcBigTmB5vq8dtVX+seSb3ZIIr47FPPyNUu4NJr4vjyZRyCveEC4pX+VNTYz
         DyeO/O3yVBq7QGzeMUMBf6K7UYvYhf6s8EKqSvohOWYVNFDhUcB0XHN+6BcIg4kjN2F4
         anEWfTIlDraCHiRaJ3q20SWA9KkfjktCuHhgUeUmOt4RvYXNNomgk3CofeJOc0A5DWsK
         iw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525219; x=1734130019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xOebWP/M8X2cP/fdZF9vXfDo8byCjFk2C5X5FbCC10=;
        b=LhF46SaJ2yrZsrOfT1JPooGvSFcbHkp8RSgU5uJCUhdjPdnzeZwdsW5TLBftsy2zqw
         BguQdih4G1dmztS1QEwT2XmzRzb+PcznM5ejiqo5EXG9EpSmFxWq8tOj5ecivf5ctB1x
         00l9u1HQ+w3eOACMaGIn+lvzTr81x/Yns8ykAO2cfZ7oW+P7ZJNFBUd2TiuJ5By+RF7e
         iJfHDNUO9WmkC8zIhzIuIpUE3qe/T2gcvHwgpM3rM9vfDSyaRduPep0zsoWeCia7lpvr
         Cxm2QO96K7C5v65o+Br9Q8lnghJa/z10ml9a/auJRgu49jwFSgnJbeY3RjJWf1pXxQcl
         Yw4w==
X-Forwarded-Encrypted: i=1; AJvYcCVQPFMB5Offq+9e9LOHddGKnh1zOODTnokyKZ8zdVG1IQ5cxBOuc35m19Ypmn9yYAn/k3DUQfFKWR0V8uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCK/rMGYO1HNmuob1EYLmNfLLiPakWnV37IAeVM4l9NLVFYkU
	NrLRHI8u6A56Pgwz8hONm1iHlCxaIMMS+I/0BQbeADv3KcQ4P5u/mSQF4vMD731AS5ON/TbrBWP
	nYR22P7V62DjHJchfZQ==
X-Google-Smtp-Source: AGHT+IFWYRH0ZDfG1SCEobsGl/BiWTfQRI31egCmHBP1UIFLmQh8g16wMoeT9PBzM1Kkhhw9DuLZq6uIHa5tY1W0
X-Received: from vkbes1.prod.google.com ([2002:a05:6122:1b81:b0:50d:806e:dfd0])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:1da1:b0:50b:e9a5:cd7b with SMTP id 71dfb90a1353d-515fcae70a3mr5700023e0c.9.1733525219486;
 Fri, 06 Dec 2024 14:46:59 -0800 (PST)
Date: Fri,  6 Dec 2024 22:46:58 +0000
In-Reply-To: <202412052133.pTg3UAQm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202412052133.pTg3UAQm-lkp@intel.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206224658.2833655-1-jthoughton@google.com>
Subject: Re: [PATCH v1 01/13] KVM: Add KVM_MEM_USERFAULT memslot flag and bitmap
From: James Houghton <jthoughton@google.com>
To: lkp@intel.com
Cc: amoorthy@google.com, corbet@lwn.net, dmatlack@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org, 
	oe-kbuild-all@lists.linux.dev, oliver.upton@linux.dev, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, seanjc@google.com, wei.w.wang@intel.com, 
	yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

>    arch/x86/kvm/../../../virt/kvm/kvm_main.c: In function '__kvm_set_memory_region':
> >> arch/x86/kvm/../../../virt/kvm/kvm_main.c:2049:41: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     2049 |                 new->userfault_bitmap = (unsigned long *)mem->userfault_bitmap;
>          |                                         ^

I realize that, not only have I done this cast slightly wrong, I'm
missing a few checks on userfault_bitmap that I should have. Applying
this diff, or at least something like it, to fix it:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b552cdef2850..30f09141df64 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1977,6 +1977,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	if ((mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
 		return -EINVAL;
+	if (mem->flags & KVM_MEM_USERFAULT &&
+	    ((mem->userfault_bitmap != untagged_addr(mem->userfault_bitmap)) ||
+	     !access_ok((void __user *)(unsigned long)mem->userfault_bitmap,
+			DIV_ROUND_UP(mem->memory_size >> PAGE_SHIFT, BITS_PER_LONG)
+			 * sizeof(long))))
+		return -EINVAL;
 
 	slots = __kvm_memslots(kvm, as_id);
 
@@ -2053,7 +2059,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 			goto out;
 	}
 	if (mem->flags & KVM_MEM_USERFAULT)
-		new->userfault_bitmap = (unsigned long *)mem->userfault_bitmap;
+		new->userfault_bitmap =
+		  (unsigned long __user *)(unsigned long)mem->userfault_bitmap;
 
 	r = kvm_set_memslot(kvm, old, new, change);
 	if (r)

