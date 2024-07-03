Return-Path: <linux-kernel+bounces-240344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21774926C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DDC1F23556
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62111194A6D;
	Wed,  3 Jul 2024 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GmjxaF7I"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729C17838D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049316; cv=none; b=K8l0EaR2Gtu7ULnARxFx7IeRX0jHRHB6E6f2cbkyZNvaMWcecEcK7v/F+rcUkm5vQH15IU4forZDO/UUk5Rj8r0/jY9dSNBFZfs0AuD6L/fKZLMiNqsPOVf89+XGu2M5U2ZmRfmpkv2NdNQ9vVk0ixpAauuSBtDb/RdnapWnI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049316; c=relaxed/simple;
	bh=K7emvDdPnxid5SAyFTESF/lQg364GGuWtvnljTHbOh4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FAema8vofaS9VYnoHN2W0tzOJaQN5BAFMFa+IoB3L/CFDf6/3xZSbHXdXbcRmf07XIRP/ZAVi46sQfrwEoi6IY3dEjYomHG7FYjryOnJpLsyHONUuCYa2DZTiy72sClkPQPHsi3HU4TyupQpFmDAihfMH6qa1Sl+6d/Loj7eXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GmjxaF7I; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c8911c84daso63981a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720049313; x=1720654113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwsbtQMOS4k6+Oss7Cpgl4Cpjs6vMsFQ0jCc9Uz8oAs=;
        b=GmjxaF7IoKg8hhN2Aq8bb91z9i39/C8tp9q/eqN0aqHNFdc4fIs7r3pSQ6UJBH2yt8
         d8LrP/cKXMsCXc8MUpbtkDwPgSug2DhZuiNRrnono1+1tRFQeNVEZWHDucnhZlgiosyq
         Wio4iTs56XPRLArBVJBDFwygIx9ifprMl3ui0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720049313; x=1720654113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwsbtQMOS4k6+Oss7Cpgl4Cpjs6vMsFQ0jCc9Uz8oAs=;
        b=jEN6MyAN3oGU4Oz37k8JxSO6KLwmatTb7nmtD88ZRDwIAKOiAIoMH0cGvZDmnRydnC
         l+RI3+KeyTBB5uJO5/sPxoFW85JdbgEX8PlNu+GtBTRzefxqatMaLetb5/zHBtPN/2xu
         BcZKTu/+hlU3VV8zMnVZAYlilexEuJI6PwtqgHZet8ybdSXEYt3q+6rlYwVxwXtGIg2E
         zTcSNQBC6SZB2/BUTuHx+UZ6IwWXMXunl35WIuoH399ewOF0OhII8QjfxjmgYWPXDePr
         Uq5v5em/n8svDKWNun/va/ALkMc67ChlTFndify1Mio1MYgLc5UeQC0YV9NQ0nRkfXvI
         Etiw==
X-Forwarded-Encrypted: i=1; AJvYcCVEn8UTloA/6XINSQCsyo3ItfHjENJIpkzVDe94khEzR7+C51Y8eN6bg8LMz7IJeVs7d7HP0SQeyErYhbAhePndXM5Tk8+195zYvQAK
X-Gm-Message-State: AOJu0YyxGnd+aTojeWpBWx7Lp7PrFYSabhBR36r6kt7bNS9zlgehq1Af
	Ro6TeE16CygqrCVrnnVPJvy+uIf91v5/QdvCWkygyRff8KQX8JC99YUR+k4tUw==
X-Google-Smtp-Source: AGHT+IFDXbgaXSaqqMX6UdrgdU2QN/tX+qwOwKdsBmygBlfpugT7eTTkgzvnHrtjv7YtX8LnCJTHNQ==
X-Received: by 2002:a17:90a:d142:b0:2c8:431e:4105 with SMTP id 98e67ed59e1d1-2c93d7215c1mr11055885a91.26.1720049313293;
        Wed, 03 Jul 2024 16:28:33 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a946fb2sm83793a91.3.2024.07.03.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 16:28:33 -0700 (PDT)
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
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev,
	alex.james@broadcom.com,
	doug.covelli@broadcom.com,
	jeffrey.sheldon@broadcom.com
Subject: [PATCH 0/2] Support userspace hypercalls for TDX
Date: Wed,  3 Jul 2024 23:35:59 +0000
Message-Id: <cover.1720046911.git.tim.merrifield@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMCALL and VMMCALL instructions are used by x86 guests to request services
from the host VMM. Both VMCALL and VMMCALL are not restricted to CPL 0.
This allows userspace software like open-vm-tools to communicate directly
with the VMM.

In the context of confidential VMs, direct communication with the host may
violate the security model. Existing binaries that make use of hypercalls
and are not hardened against malicious hypervisors can become a possible
attack surface. For this reason, user-level VMCALLs are not currently
forwarded to the host on TDX VMs. This breaks any user-level software that
use these instructions.

But if user-level software is aware of the risks and has been hardened to
address any known violations of the security model, then it seems
reasonable to allow hypercalls from this process to proceed.

This patchset introduces a new x86 process control flag to address this
concern. By setting the TIF_COCO_USER_HCALL thread information flag, the
process opts in to user-level hypercalls. When TDX is enabled, the VMCALL
will #VE and control will be transferred to a hypervisor-specific
hypercall handler (similar to how things work today for SEV with
sev_es_hcall_prepare/sev_es_hcall_finish). The flag has no effect on
non-TDX VMs. Other confidential computing technologies could use this flag
to provide limited access to user-level hypercalls.

Tim Merrifield (2):
  x86/tdx: Add prctl to allow userlevel TDX hypercalls
  x86/vmware: VMware support for TDX userspace hypercalls

 arch/x86/coco/tdx/tdx.c            | 18 +++++++++++
 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/include/asm/x86_init.h    |  1 +
 arch/x86/include/uapi/asm/prctl.h  |  3 ++
 arch/x86/kernel/cpu/vmware.c       | 51 +++++++++++++++++++++++-------
 arch/x86/kernel/process.c          | 20 ++++++++++++
 6 files changed, 84 insertions(+), 11 deletions(-)

-- 
2.40.1


