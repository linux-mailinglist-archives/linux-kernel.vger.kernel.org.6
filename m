Return-Path: <linux-kernel+bounces-378038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392269ACA82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748DFB2312C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA71C6F6C;
	Wed, 23 Oct 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkKiP0kF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A361C2DC8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687533; cv=none; b=OkVW3ZwUhaq+pECVpW4eOWi1ykIp7yyqrWLftGBjiRZcxFPtChc88dLNfiWL5YSMaIf5EuT2K1tJZ9T94sUoq9E8GR8PRPaOr267BPcxaR9Gyo59UUn2ESCIeg5RJi56bsRuykVlI0ExjMMoQeYAmw2JY9lXaaK0SKHv37f8SFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687533; c=relaxed/simple;
	bh=OHUadfAY5idEC7TSz4LDwKkmn9fkkEigYvmfBwhKTe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzMvAsGZ2EldFpSP0BqBbiLhanR5iUMLNcciipwLnM4Omfu6v5hjO8TgdEusb/bgMvPn1zhLYh6b6pRO4bYLxAYZqqTae2lGzH+KvemiFCxQS7MEV5NYhs3VYTtn7L7QGiFx03PP6AgTNqDGEg+2nhOAxSvR/BN/OKrg9rlDlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkKiP0kF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729687531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6Ldk9ZxsBI9HLbbe29Tg2hsE9raC94mk4mfGYYnShE=;
	b=dkKiP0kF5i/mCo6hnhATkbyz3oEWH7ESTummg9ZNlhLl3gjkjVa2g64DFWvdQRfnZEJSiX
	U4sTJrxuFM0Vjr61oOg7pH/sbpf2oEDdycgbmC0sqoCES4kLPnWcRDqkm5tseHh7qzy1ik
	QEiS9BzPQOrioOvnLywh6bGcpHr6sHI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-TxqnHhLbPCOq8Oz3xtccPw-1; Wed, 23 Oct 2024 08:45:29 -0400
X-MC-Unique: TxqnHhLbPCOq8Oz3xtccPw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so35601825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687527; x=1730292327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6Ldk9ZxsBI9HLbbe29Tg2hsE9raC94mk4mfGYYnShE=;
        b=siq6M/ssjNa66pyxK6GQEKZwjBgOahW/DumxTsUjtgtz2WnsC+hppSG9Of13LxSOS9
         YCxTRdp9Iub11GETmYF8LD4v7SBuw2dk0E0CYGgn4qa144nRnzKjn47GiB9D7qvHRRdS
         cLq9uBL0iYynpeRtadREgDfzDk4d7a21i18vyWHzwI7bZlkih7UhNSjd+SyEEOveqLry
         lOBrvT8NUxATQ763dx+V/oEnWfPBfSujLoh3ye7m2BWoMsmUVOQeYrK9pCOZ74rlApPE
         XyKtBFyOcAv6lXHJacKKs2K+kxhRTZx83uYjduprXUzC51mTDEKMGXTn9aqHe/6d+dox
         17nA==
X-Gm-Message-State: AOJu0YyKZycd0f+c3kRV/9259dL+KJPf0xpH8kxvkWSNJjyipFdWiitA
	TzpGvJaolmrGluQ0GrSrb+mZLOg1/j3sSdzyhK4cMYIoI3qTYbo5xfsdO9uAMJLtUcuOWZZqZEn
	8YEiDujRzLEPaNvZcnj8T/OpcCa6ZsN3kG1JmJn31Rq61VcbnCbN9i3Fnu8I+/M5J+pO3YAlkct
	O+qxxfqo2PgziUuI4tyaig7KPiiZodk7++ApShC9SrmXfFBObU
X-Received: by 2002:a05:600c:1c03:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-43184189a08mr19760865e9.23.1729687526879;
        Wed, 23 Oct 2024 05:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHymfJH/eWTCYBn2bbQIPQsPXJ5396Qyx8zrR6Gy/0RMkieb8Q1R//90hWs2ZzLK0kBKhgm6w==
X-Received: by 2002:a05:600c:1c03:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-43184189a08mr19760485e9.23.1729687526292;
        Wed, 23 Oct 2024 05:45:26 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4864csm8847991f8f.35.2024.10.23.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:45:25 -0700 (PDT)
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
Subject: [RFC PATCH 4/5] Documentation: kvm: reorganize introduction
Date: Wed, 23 Oct 2024 14:45:06 +0200
Message-ID: <20241023124507.280382-5-pbonzini@redhat.com>
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

Reorganize the text to mention file descriptors as early as possible.
Also mention capabilities early as they are a central part of KVM's
API.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst | 38 ++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 42030227dedd..6619098a8054 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7,8 +7,19 @@ The Definitive KVM (Kernel-based Virtual Machine) API Documentation
 1. General description
 ======================
 
-The kvm API is a set of ioctls that are issued to control various aspects
-of a virtual machine.  The ioctls belong to the following classes:
+The kvm API is centered around different kinds of file descriptors
+and ioctls that can be issued to these file descriptors.  An initial
+open("/dev/kvm") obtains a handle to the kvm subsystem; this handle
+can be used to issue system ioctls.  A KVM_CREATE_VM ioctl on this
+handle will create a VM file descriptor which can be used to issue VM
+ioctls.  A KVM_CREATE_VCPU or KVM_CREATE_DEVICE ioctl on a VM fd will
+create a virtual cpu or device and return a file descriptor pointing to
+the new resource.
+
+In other words, the kvm API is a set of ioctls that are issued to
+different kinds of file descriptor in order to control various aspects of
+a virtual machine.  Depending on the file descriptor that accepts them,
+ioctls belong to the following classes:
 
  - System ioctls: These query and set global attributes which affect the
    whole kvm subsystem.  In addition a system ioctl is used to create
@@ -35,18 +46,19 @@ of a virtual machine.  The ioctls belong to the following classes:
    device ioctls must be issued from the same process (address space) that
    was used to create the VM.
 
-2. File descriptors
-===================
+While most ioctls are specific to one kind of file descriptor, in some
+cases the same ioctl can belong to more than one class.
 
-The kvm API is centered around file descriptors.  An initial
-open("/dev/kvm") obtains a handle to the kvm subsystem; this handle
-can be used to issue system ioctls.  A KVM_CREATE_VM ioctl on this
-handle will create a VM file descriptor which can be used to issue VM
-ioctls.  A KVM_CREATE_VCPU or KVM_CREATE_DEVICE ioctl on a VM fd will
-create a virtual cpu or device and return a file descriptor pointing to
-the new resource.  Finally, ioctls on a vcpu or device fd can be used
-to control the vcpu or device.  For vcpus, this includes the important
-task of actually running guest code.
+The KVM API grew over time.  For this reason, KVM defines many constants
+ of the form ``KVM_CAP_*``, each corresponding to a set of functionality
+provided by one or more ioctls.  Availability of these "capabilities" can
+be checked with :ref:`KVM_CHECK_EXTENSION <KVM_CHECK_EXTENSION>`.  Some
+capabilities also need to be enabled for VMs or VCPUs where their
+functionality is desired (see :ref:`cap_enable` and :ref:`cap_enable_vm`).
+
+
+2. Restrictions
+===============
 
 In general file descriptors can be migrated among processes by means
 of fork() and the SCM_RIGHTS facility of unix domain socket.  These
-- 
2.46.2


