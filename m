Return-Path: <linux-kernel+bounces-233692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0391BB97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19575284C74
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D01534E6;
	Fri, 28 Jun 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kYv2Xqod"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84534152783
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567439; cv=none; b=C70Gdh9cfsvlem2HnnHaqCtyU3HsmyGEfNxznbsubkB1Ewjv2YVSRzYMsS6jT6aAMJ+bCKsBZmPReedXpGBuQ+Klt3tdVMdAYq9fw/+EimbI0MGneJAuoA5fnLQnQ2PYKm3ZNaDex2t2UKX+DX2TicerFVCjzKrjxenosZY5fMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567439; c=relaxed/simple;
	bh=ucxeinqz7n0TNihsRKQxcjSWh0oJp4+v1mtowF5/wa4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hOk2GaitbMNNPGPdMDZpXNy3fovA7SNeVUg+w+1Gn9Icuxn/xrtBrLyia4eNDnxQqahtCDJKvKIILmvjldMLrdF8MkPMdgYOJMZMShXUemEWwT6iN6fbO2x5vjF7Juuo4uAHpS0ZjRLJePANcSJGLGeegB8PFkcnL+IusdJb0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kYv2Xqod; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7066c799382so330253b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719567436; x=1720172236; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT4MS8fZiK5+N1QCp5Ev5H4xY+O19Xuog9jiO1hr3ns=;
        b=kYv2Xqod4fLVWFr80iHfPzPYRiME+YCccjDzCfbLe8l+nZ3YVBaASWNnvIfzwDe78+
         J3JQwKtf8QDsI1U90e7Sf0aGmbmSMfvekcUik4qpfH67keQdHDCl3AubhXtT5SuVD3Dw
         YAjRCORgUkDpPdxt/9khAkKHYDMWHio/MdABz+0RlUBZqBlxmWVumCvTJ/d0mQznBjEl
         h2tCrK+i3tyHrnp90egwAE4Wlb+oIgsacUVV/l5gUPm7IZIdTMJDaXUKOm/sxKqQotuE
         JhODhl/AZyqr9K3cC158NRISc+e7JP8/Cp0SD34fTxMrYtCg3gymk2nN5Pw4jjqw2voY
         bnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567436; x=1720172236;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT4MS8fZiK5+N1QCp5Ev5H4xY+O19Xuog9jiO1hr3ns=;
        b=KW3eO7JPCog/Ix6Qr+KdNOuRQytfj/hewt5doJ0EDAd6YtT6xhC4E/JUMVH9LfErM0
         95dPwuWV2NXrEcrLNvkOlbs6mbEGUVO8WLDCiDaekU5W1tf7SQoh8Z9Ap8HResL7xhTQ
         a3LHjzR0QIiC9xW8qPpJwsCzGbzVAKv2iKAsdUOd3KdhmhtBt5UiUJGGP0C0bCTwxvsT
         nqV6xeo7rG+IkuWWGtLap79Nro2gMaCg6AVlqt/npcJFmFFcTt+XJQ9rb1Qafuhvo4wN
         fkM2KVGIeDO3CzbEbdWZFzNiKod5xg79Bp1KDpw0IAnTp7PnWbUdGz3BIEQMoLsBjcqk
         O+7g==
X-Gm-Message-State: AOJu0Yy+rozc2XY+SkYQSndg3qVNIjF+0PzslDEOzR7o4c2V0mocb69M
	OKWBU82Se0F5jJGbePZDZ8CGl1lBpwWlJMCUk5ynxT29Az0D2NdT5jw+eL3Dj4raILlhLPaqBuW
	zrzN0HO2hnpgIrsL2eZUyTcX0RviOXJ5rM7b5dPDeZY5mMkPkYLaAPoE1vd+k918MBJj9pg+WID
	7y5pZAFsfiB/cwkU8G1ngJtHViD01wCVgLk3etF172bz9T1XGdAkY=
X-Google-Smtp-Source: AGHT+IGz1s4UrPEjOUTeURvSc/bsNc9cuyIhSWC3mjXDJgDFtcpe5FBxZlsENps9IITX6WHehehEjQ==
X-Received: by 2002:a05:6a20:3b91:b0:1bd:2a99:2da7 with SMTP id adf61e73a8af0-1bd2a992f06mr7489875637.31.1719567436154;
        Fri, 28 Jun 2024 02:37:16 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c8dsm11087155ad.26.2024.06.28.02.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:37:15 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Add Svade and Svadu Extensions Support
Date: Fri, 28 Jun 2024 17:37:04 +0800
Message-Id: <20240628093711.11716-1-yongxuan.wang@sifive.com>
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
   unknown whether the platform uses Svade or Svadu. Supervisor may
   assume Svade to be present and enabled or it can discover based
   on mvendorid, marchid, and mimpid.
2) Only Svade present in DT => Supervisor must assume Svade to be
   always enabled. (Obvious)
3) Only Svadu present in DT => Supervisor must assume Svadu to be
   always enabled. (Obvious)
4) Both Svade and Svadu present in DT => Supervisor must assume
   Svadu turned-off at boot time. To use Svadu, supervisor must
   explicitly enable it using the SBI FWFT extension.

The Svade extension is mandatory and the Svadu extension is optional in
RVA23 profile. Platforms want to take the advantage of Svadu can choose
3. Those are aware of the profile can choose 4, and Linux won't get the
benefit of svadu until the SBI FWFT extension is available.

[1] https://lore.kernel.org/linux-kernel/20240527-e9845c06619bca5cd285098c@orel/T/#m29644eb88e241ec282df4ccd5199514e913b06ee

---
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


