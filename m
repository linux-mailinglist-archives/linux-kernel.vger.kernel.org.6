Return-Path: <linux-kernel+bounces-438650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214649EA3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37A9286483
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C1226EF3;
	Tue, 10 Dec 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZjcYahN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA9226195;
	Tue, 10 Dec 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791732; cv=none; b=N88bfg8LeeEO5YkIX7seRKJmo+CU1DcedLh4sjJMRd1ISFuhcoQeI5BILkx2tCv5/5BL5AHdlaFXUpimGGpJel0RGrsNiwrIWOJ+fQAMJB8K1Rwqlr23/i0oFAjsYcsRckJXIkZfesvbs6RrLWRjaL0UVLWWp21JOjZHr7T1LPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791732; c=relaxed/simple;
	bh=kfu6C0SYQzrE02TTUxcV+ExCr0Z5wpO62XbaFtIPi00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4C048g2zN9RsUWX3AdNYXuR5eTSQTioovgNKP9cXURoCRVkcRHarKi6g6hieuXJklXGnRRAOYR7hgq8GbvzP/WBpJHod17VSCFS1CaQB4dWzesf1mEtS4m7e0gumMwcxfUvZYJ1AwzC3jinzaMjUy6iYDjMibi7w3Ao7plR0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZjcYahN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733791731; x=1765327731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kfu6C0SYQzrE02TTUxcV+ExCr0Z5wpO62XbaFtIPi00=;
  b=lZjcYahNrDCYwem7KYxcjZoSbQ0UD1rje6B8xRqtemwVadQHGNTI2Wdc
   K19WXy/GaKbL0G2C3/3R5nS/QrEnGfoAmFf9J724WVaHjTe9QnV1YKP/7
   c+BFPA0J3rn37tZiMYyqM5dhucaYY24cUjoTCUC9KWvTAc7Kj9XED+kt1
   QGMLDCiT8lmX0Slkc6MEuGzDCViXVG6aBVp3+bbg64bWZLi0YGqTHT8Vl
   h5zZko8i3HugtGkafpfMnkNLUO4FzXCOzL2uJFBIbAcYef2AJsP7vs0z+
   67ZLwymfjFSa6U69Fsvu7hJ1ctfjU/SZjL/2JTNAot9rw03irybkFj0Xa
   w==;
X-CSE-ConnectionGUID: IguIgon4QHGjOZAHjGBg5Q==
X-CSE-MsgGUID: zdpRGAaBRq2Hs8HMZgf4pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44793795"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44793795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:48:51 -0800
X-CSE-ConnectionGUID: XJb69Tf9T1+UYNO2sQYqWg==
X-CSE-MsgGUID: t1pYN42hTly3om0OgkVXaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="96033116"
Received: from litbin-desktop.sh.intel.com ([10.239.156.93])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:48:47 -0800
From: Binbin Wu <binbin.wu@linux.intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kai.huang@intel.com,
	adrian.hunter@intel.com,
	reinette.chatre@intel.com,
	xiaoyao.li@intel.com,
	tony.lindgren@linux.intel.com,
	isaku.yamahata@intel.com,
	yan.y.zhao@intel.com,
	chao.gao@intel.com,
	linux-kernel@vger.kernel.org,
	binbin.wu@linux.intel.com
Subject: [PATCH 17/18] KVM: TDX: Make TDX VM type supported
Date: Tue, 10 Dec 2024 08:49:43 +0800
Message-ID: <20241210004946.3718496-18-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241210004946.3718496-1-binbin.wu@linux.intel.com>
References: <20241210004946.3718496-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaku Yamahata <isaku.yamahata@intel.com>

Now all the necessary code for TDX is in place, it's ready to run TDX
guest.  Advertise the VM type of KVM_X86_TDX_VM so that the user space
VMM like QEMU can start to use it.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
TDX "the rest" breakout:
- Move down to the end of patch series.
---
 arch/x86/kvm/vmx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 81b9d2379a74..d1f58f9552ea 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1060,6 +1060,7 @@ static int __init vt_init(void)
 				sizeof(struct vcpu_tdx));
 		vcpu_align = max_t(unsigned, vcpu_align,
 				__alignof__(struct vcpu_tdx));
+		kvm_caps.supported_vm_types |= BIT(KVM_X86_TDX_VM);
 	}
 
 	/*
-- 
2.46.0


