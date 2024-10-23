Return-Path: <linux-kernel+bounces-378036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796ED9ACA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0101C23AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16731BE86E;
	Wed, 23 Oct 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJpUXazb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09631BBBDD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687525; cv=none; b=fy2/M1X0s8citE2ZT3z0Du9jZ+Y/cg9APiZ3OnFwyLEhvQK1dVV5Fp6T+pkhoCIhkOu365LGLnrMXdcxtOg4Gco+8WRfNkRu3HQFnImuFs3Z0OSmzXWpH03+5WPmgG9LIu5bZ5JABrRr72xsVW0IkF8XW9GNoTIDP0Ai7S/oB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687525; c=relaxed/simple;
	bh=n6JPq6feOOxq4qvR2QYPYddN4qFZswV+XGRZJmKdXtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfX5iFa64RDN313GWpQpVh42gl9F6OAEGoXVIhgdbFUX/0tB5beXAv8D+44N/6ZzgVPqP3eSWxcZ7SJ6WQQJuPxqZ3OHRQyxTve/teJy21T60j6tye7bD7S884zpHqY7YkNgKvEOdOYXSkXq0SpzpERs7VxnW2OFC4xOOXXwRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJpUXazb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729687522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2ui8XgastR4FaJaNRkMjtjACkKRZ87hrIJU0Aq8EZo=;
	b=jJpUXazbPAzqHuNPifza6FGVhUDRlJ0t73I0MS8yWcv0ruhH7lNFOALN0+VHFTYMIQIvW8
	x0derHnHdPiY2EaWjzBdFkFLqny0iDwFf7mR+Z+KBaz/4TKLBLMH9S8apzQnYDXZKyrNk4
	FZbec1enGt4eSWSpLJYW04kZO61ZD4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-UWwkFVq7M4e-LY2_AHKZUQ-1; Wed, 23 Oct 2024 08:45:21 -0400
X-MC-Unique: UWwkFVq7M4e-LY2_AHKZUQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d59ad50f3so2988113f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687519; x=1730292319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2ui8XgastR4FaJaNRkMjtjACkKRZ87hrIJU0Aq8EZo=;
        b=sub+CgWJla5slnCzkQ6cBiGd2KxIu0xY06zglJgYAE8e9P5oiG8efJK9M8cpOMCbyx
         jMt15FbSgYffHYj1vx+2/oHKlrBYJ3WhFoWByLvFKHx0A35+pikT3wi/zHcwAKyreyRW
         XyiS+u786hd+Z0UdcaQza3EG80rrU8sHxs/DkgK+AjYYDHgLTocwOBkc+Xkj1bBj++il
         /Lzky4hZqftk4WrwFJZNdZTzgIE5xjbqvXxds6FfONUFAtfd6UEv6FW/PtzLnEgOQEwD
         JexjP78/3yhYYyh1NTI71GrhLvaainFzbwLvTOv7RJsABSgBw7vAkgARDfQthdA6t2Zp
         LGYg==
X-Gm-Message-State: AOJu0Ywum1tCE8OvYkavSgwNiysR40Gg544ikNu+mfx5opWIEyzTQtu5
	AOMQbuxI+tWvOX2BdM70pPN6XeZz6FLPlOZoyGrPUvxbVPR5haCy60OXYcPPs9EAX7JONUDhOEC
	c+NhWIvJSMpNo4AdS3O3ylTmMeEqnzoGGWh/fEvtjVo5IKRVYnTCKcK9IW0Cx7PXlAws81EMxOw
	RR425Btm3a3q+88ZnN9BYpk37Os7YG9KDIQ4LIGYRiFIZkBZpP
X-Received: by 2002:a05:600c:524a:b0:431:12d0:746b with SMTP id 5b1f17b1804b1-431841af63amr16478095e9.35.1729687518703;
        Wed, 23 Oct 2024 05:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0y1BXfPNku3lR35r76dw3XeTpiKZ5deNjUOi+WQ7BpuyYKJNKoHPylKmCWZZUAZbM7FLXSA==
X-Received: by 2002:a05:600c:524a:b0:431:12d0:746b with SMTP id 5b1f17b1804b1-431841af63amr16477735e9.35.1729687518246;
        Wed, 23 Oct 2024 05:45:18 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c3a5b4sm15391805e9.38.2024.10.23.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:45:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: roy.hopkins@suse.com,
	seanjc@google.com,
	michael.roth@amd.com,
	ashish.kalra@amd.com,
	jroedel@suse.de,
	thomas.lendacky@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	oliver.upton@linux.dev,
	isaku.yamahata@intel.com,
	maz@kernel.org,
	steven.price@arm.com,
	kai.huang@intel.com,
	rick.p.edgecombe@intel.com,
	James.Bottomley@HansenPartnership.com
Subject: [RFC PATCH 2/5] Documentation: kvm: fix a few mistakes
Date: Wed, 23 Oct 2024 14:45:04 +0200
Message-ID: <20241023124507.280382-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023124507.280382-1-pbonzini@redhat.com>
References: <20241023124507.280382-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only occurrence "Capability: none" actually meant the same as "basic".
Fix that and a few more aesthetic or content issues in the document.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 85dc04bfad3b..480ab8174e56 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -96,12 +96,9 @@ description:
   Capability:
       which KVM extension provides this ioctl.  Can be 'basic',
       which means that is will be provided by any kernel that supports
-      API version 12 (see section 4.1), a KVM_CAP_xyz constant, which
+      API version 12 (see section 4.1), or a KVM_CAP_xyz constant, which
       means availability needs to be checked with KVM_CHECK_EXTENSION
-      (see section 4.4), or 'none' which means that while not all kernels
-      support this ioctl, there's no capability bit to check its
-      availability: for kernels that don't support the ioctl,
-      the ioctl returns -ENOTTY.
+      (see section 4.4).
 
   Architectures:
       which instruction set architectures provide this ioctl.
@@ -338,8 +335,8 @@ KVM_S390_SIE_PAGE_OFFSET in order to obtain a memory map of the virtual
 cpu's hardware control block.
 
 
-4.8 KVM_GET_DIRTY_LOG (vm ioctl)
---------------------------------
+4.8 KVM_GET_DIRTY_LOG
+---------------------
 
 :Capability: basic
 :Architectures: all
@@ -1298,7 +1295,7 @@ See KVM_GET_VCPU_EVENTS for the data structure.
 
 :Capability: KVM_CAP_DEBUGREGS
 :Architectures: x86
-:Type: vm ioctl
+:Type: vcpu ioctl
 :Parameters: struct kvm_debugregs (out)
 :Returns: 0 on success, -1 on error
 
@@ -1320,7 +1317,7 @@ Reads debug registers from the vcpu.
 
 :Capability: KVM_CAP_DEBUGREGS
 :Architectures: x86
-:Type: vm ioctl
+:Type: vcpu ioctl
 :Parameters: struct kvm_debugregs (in)
 :Returns: 0 on success, -1 on error
 
@@ -2116,8 +2113,8 @@ TLB, prior to calling KVM_RUN on the associated vcpu.
 
 The "bitmap" field is the userspace address of an array.  This array
 consists of a number of bits, equal to the total number of TLB entries as
-determined by the last successful call to KVM_CONFIG_TLB, rounded up to the
-nearest multiple of 64.
+determined by the last successful call to ``KVM_ENABLE_CAP(KVM_CAP_SW_TLB)``,
+rounded up to the nearest multiple of 64.
 
 Each bit corresponds to one TLB entry, ordered the same as in the shared TLB
 array.
@@ -3554,6 +3551,27 @@ Errors:
 This ioctl returns the guest registers that are supported for the
 KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
 
+Note that s390 does not support KVM_GET_REG_LIST for historical reasons
+(read: nobody cared).  The set of registers in kernels 4.x and newer is:
+
+- KVM_REG_S390_TODPR
+
+- KVM_REG_S390_EPOCHDIFF
+
+- KVM_REG_S390_CPU_TIMER
+
+- KVM_REG_S390_CLOCK_COMP
+
+- KVM_REG_S390_PFTOKEN
+
+- KVM_REG_S390_PFCOMPARE
+
+- KVM_REG_S390_PFSELECT
+
+- KVM_REG_S390_PP
+
+- KVM_REG_S390_GBEA
+
 
 4.85 KVM_ARM_SET_DEVICE_ADDR (deprecated)
 -----------------------------------------
@@ -4902,8 +4899,8 @@ Coalesced pio is based on coalesced mmio. There is little difference
 between coalesced mmio and pio except that coalesced pio records accesses
 to I/O ports.
 
-4.117 KVM_CLEAR_DIRTY_LOG (vm ioctl)
-------------------------------------
+4.117 KVM_CLEAR_DIRTY_LOG
+-------------------------
 
 :Capability: KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2
 :Architectures: x86, arm64, mips
@@ -5212,7 +5209,7 @@ the cpu reset definition in the POP (Principles Of Operation).
 4.123 KVM_S390_INITIAL_RESET
 ----------------------------
 
-:Capability: none
+:Capability: basic
 :Architectures: s390
 :Type: vcpu ioctl
 :Parameters: none
@@ -6151,7 +6148,7 @@ applied.
 .. _KVM_ARM_GET_REG_WRITABLE_MASKS:
 
 4.139 KVM_ARM_GET_REG_WRITABLE_MASKS
--------------------------------------------
+------------------------------------
 
 :Capability: KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES
 :Architectures: arm64
-- 
2.46.2


