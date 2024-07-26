Return-Path: <linux-kernel+bounces-263639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8793D88D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A54286130
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FCE446AC;
	Fri, 26 Jul 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U6KzIy/A"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15033CC4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019756; cv=none; b=DnEE5Qy6zJB+lOfugPUuTSBOWBPVsEFWiQmHu+MKhwfwKjP0jya4PJL9ItVcRX+PhpKV32FP4c3VVVnVeMHpHU2D2RV2+fdJ6otyF6IbL3PCGDWgnq0AwEybRtseeiyDxM6Ek2aXJQ1OIdB8Skv+kEcTkG8d+6AQ8ODDTwRBCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019756; c=relaxed/simple;
	bh=rJT+2RXiOIACYPnpmYqep6RPxcQ8+lwK/J+Sl6kgKbM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=L01HpuFylVL8iQiiEmWUP/5FgXxoHk8Ja3UuYbmB9mUwKm04MRsvktez5jEGgY09rrhFfWAcLCPRANUufPEa8CB6BnpwsNnQ0sx5j/lhW8qf0tvz27jbqN0hm4ubHwvBB+oAbIfHffcTBqQ6YeFFMkSsSWmYZve6SIzj0Jf1Uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U6KzIy/A; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc52394c92so9489245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722019754; x=1722624554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TyyLiY8on/nX+zSo6X6ltjiyPizeUUW7zJGnozG/PPc=;
        b=U6KzIy/A/0y3pPnFcnTyFqlU8oEZQ/UZ4Z3AczPrMPJxCPS1UehnI8cqvwf8pKxjP5
         taw8w6+yc9VlK5LOqIKfOMm0ZQtdSAYAF91JJvXCFEzdn55q9SjFSdiBVm3E4ZzDA1Q4
         yC3fPsvrdwljcbQ7qymnuqhaE0GrFsDbZExPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019754; x=1722624554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyyLiY8on/nX+zSo6X6ltjiyPizeUUW7zJGnozG/PPc=;
        b=vZYwaoU22sg/pqm5GCkOcr26FiJ5QwSpt3cnbSa9JRNsSfdUqpUHFDzGhg/9nbioGS
         iNCh4yMRRM1JVQaEQasD+MYx6NsA3dSYu7n5BrS6/7Oqq+kVepy8XHPqQo7hNBvN0Rgl
         gcVnp5mmE5XlSHhbchq9MVjPNWGP9uCWLOMDLu6FnHpQ8EG/gAUHurYOrVMexh6JVWJ7
         oqzS56W3X2wRXlSuSQstF/VITiPlOs2zlhQJFKQteDOPY4AQyVmfg4aX6fj3HnBCs5M4
         iMQWEyVSGD52cK5k7J/CKJNLqPYshkcXqfoRbU27t6kL2R+UvkHMYA7tPAV3yUY6eUdU
         PbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPtW2lGBAQhDr0u0eRq5ItN4SLKLJdCnEDROWjZ7Px3JFkOu0ztWt5JLty35hCO7n0jevXmjaSsX6hDbmjv5r0tJUMDcHJI/9MWINo
X-Gm-Message-State: AOJu0Yx9wNnsPxmhybCQicF8bf7Sc6H9DSqc+vdXRn9sjKGia1RTU37G
	ZyB0LVEOoRTNpHxTgr9x7uXvUJHdrI4Of6JptE0SA79Ook1JZaNBqOY3D7PfUg==
X-Google-Smtp-Source: AGHT+IEe/GXCjaZeMJ7CY6MD82mYGLTfebQ/ql8mw+rh6V2dg4j2flKyEoVmRkELRDQrUqwpRFdxew==
X-Received: by 2002:a17:903:22c2:b0:1fb:6663:b647 with SMTP id d9443c01a7336-1ff047e4486mr9277595ad.3.1722019753694;
        Fri, 26 Jul 2024 11:49:13 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8494sm36285245ad.159.2024.07.26.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:49:13 -0700 (PDT)
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>,
	Tim Merrifield <tim.merrifield@broadcom.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev,
	alex.james@broadcom.com,
	doug.covelli@broadcom.com,
	jeffrey.sheldon@broadcom.com,
	kevin.christopher@broadcom.com,
	aravind-as.srinivasan@broadcom.com,
	ravindra.kumar@broadcom.com
Subject: [PATCH v2 0/2] Support userspace hypercalls for TDX
Date: Fri, 26 Jul 2024 18:57:59 +0000
Message-Id: <cover.1722019360.git.tim.merrifield@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hypercall instructions like VMCALL and VMMCALL are not restricted to CPL 0.
This allows userspace software like open-vm-tools to communicate directly
with the VMM.

For TDX VMs, this communication may violate the security model. Today,
VMCALLs are not forwarded to the host VMM, which breaks open-vm-tools
and any other userspace software that uses VMCALL.

But if userspace is aware of the risks and has been hardened to
address any known violations of the security model, then it seems
reasonable to allow hypercalls from this process to proceed.

This patchset introduces a new x86 process control flag to address this
concern. By setting the MM_CONTEXT_COCO_USER_HCALL flag, the process opts
in to user-level hypercalls. When TDX is enabled, the VMCALL will #VE and
control will be transferred to a hypervisor-specific hypercall handler
(similar to how things work today for SEV with
sev_es_hcall_prepare/sev_es_hcall_finish). The flag has no effect on
non-TDX VMs. Other confidential computing technologies could use this flag
to provide limited access to user-level hypercalls.

v1->v2 changes:
- Updated coverletter to get to the point a little faster.
- Patch 1: Changed to use a per-process flag rather than a per-thread
flag, based on feedback from Kirill Shutemov. I believe this also addresses
the issue of inheritance raised by Dave Hansen.
- Patch 1: Refactored the logic in tdx.c to be made more clear. Also,
tdx_hcall now returns an error code. Both suggested by Kirill.
- Patch 2: We now zero tdx_module_args to prevent data leakage to the VMM,
pointed out by Kirill.

Tim Merrifield (2):
  Add prctl to allow userlevel TDX hypercalls
  x86/vmware: VMware support for TDX userspace hypercalls

 arch/x86/coco/tdx/tdx.c           | 23 ++++++++++++++
 arch/x86/include/asm/mmu.h        |  2 ++
 arch/x86/include/asm/x86_init.h   |  1 +
 arch/x86/include/uapi/asm/prctl.h |  3 ++
 arch/x86/kernel/cpu/vmware.c      | 51 ++++++++++++++++++++++++-------
 arch/x86/kernel/process.c         | 22 +++++++++++++
 6 files changed, 91 insertions(+), 11 deletions(-)

-- 
2.40.1


