Return-Path: <linux-kernel+bounces-250372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0F92F70F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A391C21E94
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C0814265C;
	Fri, 12 Jul 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iuSXPwCb"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0E13D605
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773539; cv=none; b=S1w84akWUZPofiVnf5syO33kXmlrvjykZDft2KL6GrygnVCpuIRrhRu0Xp+p6SGJsB6bnwgfvIXCYGA86Ze/W+xdQI3x5eGme5GGbSrtDFtjtGi6xPGkpHflpo31kxnr/0wv/ovhFtjG+i0i0uwMc7/2TqyW/IARbaGeg9qFJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773539; c=relaxed/simple;
	bh=p0YPeLldSmFXlOz/UYd09N6YYmnib6LFMAhTZFsCrdA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CCpTX2Qe6ukwRaZfjs/ebGRjB7zMeVg6chPmGSXdTvtIhGMuDSlio8NmnyCdH6c/xaw641VYpzrLeBRFX1g3FsX3AI7FiXwSSImU2j62TLANpGxTP6T0KCpp0PQ8Edga7tGlkWfOQRYQoRm6TRgw7HRzcYYngxmhNh7zSPEbQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iuSXPwCb; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f6338a4so842935fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1720773535; x=1721378335; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVjihtKXNEFz1TbYcKMwCmFBpXSQ+a7jrSn4uniS5ZY=;
        b=iuSXPwCbjrs4Z8di/wn/tj+jHGosrspZPIPn5fsomRc8+W0S5wMcS61kxOE9Z5P/lF
         aIwb1uLnsb108oT3kholMIGzde5Bxg3JVde7ZD1Kt643wUNQ4aobrxUQIyE5j6+2/nyt
         2gfB5HBLIssKhCqVj0n6oESP1Lo0fKBBIeOSJH6uWQJMs5D46dfCh+Qu5LHt5sLAIwu9
         qVeEU9EX/kOrhzhcTlMur+YnvKqUTu67rp2+/KHYjiJX+NNaTLl/wz7g+BhlLhhTLPNa
         8jl6GGOAGqxw+TCCZfZ8qawrvjLhL7jiMj/GOeYCh+26tE5qaNF8nfmJzKRVeQp3DJai
         iHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720773535; x=1721378335;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVjihtKXNEFz1TbYcKMwCmFBpXSQ+a7jrSn4uniS5ZY=;
        b=oH9EqM0M41i2EX/ulW9WBEc7SZCvHireMaMU3egD6cUe77f68EulS8+leDRRhAdbau
         tJDw81xkutPmnBlCw+p0BDf9VDnNOsf9+zaHcRIB3E4ffV4Vw1OFi1pNYSxRuYXvxccL
         1N12AdzKtw+E+jBJoIYlhoFBMYgHD5ucFMzpwJXvK4bGynI/LzSCavvPkDlu82bQKVKz
         s0pCiNCJfIjjYiJedDe5RPN5qO1BacInaJg35xtDS7iQK/9NLUR8hw9Dvuf7b88I47Xu
         Nsczd7Q0SNdHyi36mFn7CaWH5R7NCLJV5AJD/ZXZ4wDNoIZFJWX1eSMoCCC1yjTR1Do0
         xOow==
X-Gm-Message-State: AOJu0Yxt8IgR5aToxHMSHmixwRLZtSp+XfBDFXKFXnx94ffxHiYHrLsW
	SkvA0boDozz1d5B9oLrQLNkeA4pgR52/9Xg//hEW2hOcZokkRBetaT3zvGZgt3YX/NOjeRHB52c
	JBGrP6ZeMl7McAqcAMtyaE04RHe0Ut2esTCgSK9SAxIX3IchhK/B5LhzkfFvV8qf+BlU72fQdXh
	jjKpa8lBDo0M8GxHX3ZzYfH4vCoTyHK7omeIN0eqd+JxZlwdrYWqggUg==
X-Google-Smtp-Source: AGHT+IFJUspheJ7QGL8PM/A2EZFrZ3yO7Wj/mP366SeQSTErineZNs3lMKWyMy76zRvXD1h+6aLA1Q==
X-Received: by 2002:a05:6870:64a2:b0:25e:3b8b:6985 with SMTP id 586e51a60fabf-25eae8b61e5mr8815792fac.35.1720773535508;
        Fri, 12 Jul 2024 01:38:55 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c7099sm6894194b3a.84.2024.07.12.01.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:38:55 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v7 0/4] Add Svade and Svadu Extensions Support
Date: Fri, 12 Jul 2024 16:38:44 +0800
Message-Id: <20240712083850.4242-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Svade and Svadu extensions represent two schemes for managing the PTE A/D
bit. When the PTE A/D bits need to be set, Svade extension intdicates that
a related page fault will be raised. In contrast, the Svadu extension
supports hardware updating of PTE A/D bits. This series enables Svade and
Svadu extensions for both host and guest OS.

Regrading the mailing thread[1], we have 4 possible combinations of
these extensions in the device tree, the default hardware behavior for
these possibilities are:
1) Neither Svade nor Svadu present in DT => It is technically
   unknown whether the platform uses Svade or Svadu. Supervisor
   software should be prepared to handle either hardware updating
   of the PTE A/D bits or page faults when they need updated.
2) Only Svade present in DT => Supervisor must assume Svade to be
   always enabled.
3) Only Svadu present in DT => Supervisor must assume Svadu to be
   always enabled.
4) Both Svade and Svadu present in DT => Supervisor must assume
   Svadu turned-off at boot time. To use Svadu, supervisor must
   explicitly enable it using the SBI FWFT extension.

The Svade extension is mandatory and the Svadu extension is optional in
RVA23 profile. Platforms want to take the advantage of Svadu can choose
3. Those are aware of the profile can choose 4, and Linux won't get the
benefit of svadu until the SBI FWFT extension is available.

[1] https://lore.kernel.org/linux-kernel/20240527-e9845c06619bca5cd285098c@orel/T/#m29644eb88e241ec282df4ccd5199514e913b06ee

---
v7:
- fix alignment in PATCH1
- update the dtbinding in PATCH2 (Conor, Jessica)

v6:
- reflect the platform's behavior by riscv_isa_extension_available() and
  update the the arch_has_hw_pte_young() in PATCH1 (Conor, Andrew)
- update the dtbinding in PATCH2 (Alexandre, Andrew, Anup, Conor)
- update the henvcfg condition in PATCH3 (Andrew)
- check if Svade is allowed to disabled based on arch_has_hw_pte_young()
  in PATCH3

v5:
- remove all Acked-by and Reviewed-by (Conor, Andrew)
- add Svade support
- update the arch_has_hw_pte_young() in PATCH1
- update the dtbinding in PATCH2 (Alexandre, Andrew)
- check the availibility of Svadu for Guest/VM based on
  arch_has_hw_pte_young() in PATCH3

v4:
- fix 32bit kernel build error in PATCH1 (Conor)
- update the status of Svadu extension to ratified in PATCH2
- add the PATCH4 to suporrt SBI_FWFT_PTE_AD_HW_UPDATING for guest OS
- update the PATCH1 and PATCH3 to integrate with FWFT extension
- rebase PATCH5 on the lastest get-reg-list test (Andrew)

v3:
- fix the control bit name to ADUE in PATCH1 and PATCH3
- update get-reg-list in PATCH4

v2:
- add Co-developed-by: in PATCH1
- use riscv_has_extension_unlikely() to runtime patch the branch in PATCH1
- update dt-binding

Yong-Xuan Wang (4):
  RISC-V: Add Svade and Svadu Extensions Support
  dt-bindings: riscv: Add Svade and Svadu Entries
  RISC-V: KVM: Add Svade and Svadu Extensions Support for Guest/VM
  KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list
    test

 .../devicetree/bindings/riscv/extensions.yaml | 28 ++++++++++++++++
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/csr.h                  |  1 +
 arch/riscv/include/asm/hwcap.h                |  2 ++
 arch/riscv/include/asm/pgtable.h              | 13 +++++++-
 arch/riscv/include/uapi/asm/kvm.h             |  2 ++
 arch/riscv/kernel/cpufeature.c                | 32 +++++++++++++++++++
 arch/riscv/kvm/vcpu.c                         |  3 ++
 arch/riscv/kvm/vcpu_onereg.c                  | 15 +++++++++
 .../selftests/kvm/riscv/get-reg-list.c        |  8 +++++
 10 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.17.1


