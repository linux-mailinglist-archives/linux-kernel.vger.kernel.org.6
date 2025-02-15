Return-Path: <linux-kernel+bounces-516377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA1A37057
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339283B0B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097BB1FC7CD;
	Sat, 15 Feb 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLYosHhf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BBF1624D3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739646277; cv=none; b=C2BAH4MrE91dcellcHgxOLrtFQUkwOuRNJB8PzfIs51jF+sF9ZytVyPUg4DfC/DRupDzh+eC4BsJX3PtsRvjJSQMd5cXuakI6ULHPogaCvNW0glZOhLYxBCBoDno67fvGxV0JutWxb5NyPGCVOAI8cP1LnmzdQU42b3KM3OMGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739646277; c=relaxed/simple;
	bh=BNwVKSMVB4ei85gF14ckQDuvQMzrZYstkUE4Z/f3cpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkWkZ00CT/Cx0onh8/m7c4U1jv7HcCNGcLr2eW4itNn78hgKMaoAtEq7J1nMEcDMV4l8A8xic/sP3By7ZFR7ixMwjfC989iTvvrA4sZLbbBeTt6NENzQz2H3khXNa/FGKEv6koFaVeiBDqkZ/YLsCxzs9o1WO4b88kAbhNbZUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLYosHhf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4396424d173so29335585e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 11:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739646273; x=1740251073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KlKFAiXF1vqmNku37ywbRPDu9DnnoONEYBqGIA8J8Tc=;
        b=ZLYosHhfHWElzpfE+f4yQA4bhWZ5DmcbKUloUHhb8FzE42abI99OuHen7hu3qRr4b1
         fjxHVCvIzf01QNRp+e6e2CNpynAMCEhXlpys2KwC0tzLzRhf8qhBTGhQ/DHjFBZDvO7Q
         e8+f+NuaewpGNNPd5HHkVzdtpTkcsDpsLpw5EUe+Nq7SiMZp+pY/xhs/PkKwgaJ/tE4Q
         kR2K+2q+eUg9+UPY8dK9ktrWhmNzy2skwL9GHJOeBIR+a2Bw9JLBa4Z7IhYCrhmjbG4s
         SbBw/jufphLyWmVDQit5rBEX7FvmIOsCXymn3AXiOzezScLjwfb9JkLZ2aD4jIvZYIHk
         GCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739646273; x=1740251073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlKFAiXF1vqmNku37ywbRPDu9DnnoONEYBqGIA8J8Tc=;
        b=cAeFhd/9/URAvQc7LiFT9MBqSwfmEMBPStEbgCga6/pGuogZJh3KzHegirNj3I4v7s
         VP/C57H/tGkR8U8bVASxrKpxPuPs9YBNnhRaz0DhDQ8pcSkv5ZxZBzyIH8wqgLgC2a4L
         MdP1EzliNdR6/DRpOOOLG0DXjoVtw+K4WcuiFsbLQZd/T1m0N21GZvELQ8JdNSsYs5yx
         Bp8W2CfGRChZ/ZFHbLssPoU36hHG19xmbEXLP7CeNIhlgr2ndhFZ7MBOZsmjBGWO1TZb
         dmFTqiHuzwEdvOnZ4R4dtxcxtWd8qFsdlsbsH2r834dMFhrN5eWye0rl71u+HZv4PyNs
         ttwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2n3BegrCzniJYFWnKX9UlFMc/mlyzGrZe72U1zjzndlv5slkcPj9x5o/sCHLTN4eKn0i1HfZOmQ1m4Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmb7z7x8W3W+kxz00GiJ5pFb0hpMginh/FSakmYk0LNpqDOumr
	tOxl5GyDhFyDiF3yTpsSCcA1pjPDc2twuh3Ga9Gnctx9Q+H5GXRhLSGtK8r8vbRWpwBtGz2rNVE
	0C60cBjihRSim6wVCeYfaVKYWcbs=
X-Gm-Gg: ASbGnctJlgckc2u2Lipgv6gXI2qTvV7FdWAfULwwN4aDLAw8t2oAPm+LsWIeaAJTNwT
	mYmazVP4tXJ111f4VIFAPJ4xYcmDGVDJWf7Xe/yOClqNMvSbKhlLq36GzgItKQWRMxdEJg49q
X-Google-Smtp-Source: AGHT+IEocBWSCkH48AST7THBakDBtI1P2cdLUqJH6P86HXBwtD0EzH2fLPQKQwSVk/LyuSbjXvQi9m7uLUhUvVcdzzs=
X-Received: by 2002:adf:f6c6:0:b0:38d:d371:e01d with SMTP id
 ffacd0b85a97d-38f33f565c1mr3601951f8f.49.1739646272570; Sat, 15 Feb 2025
 11:04:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211143910.16775-1-sebott@redhat.com> <20250211143910.16775-2-sebott@redhat.com>
 <Z7BoydkyT_h0gwOV@linux.dev> <CAE2XoE_8ihJZQF856w-_F+cgJW7fLWGz7M7Ztoxzw2vE51_m1A@mail.gmail.com>
 <87v7tb17os.wl-maz@kernel.org>
In-Reply-To: <87v7tb17os.wl-maz@kernel.org>
Reply-To: luoyonggang@gmail.com
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 16 Feb 2025 03:04:20 +0800
X-Gm-Features: AWEUYZmlz4_KXFrAI2Ba46wtyq_RK2-V1RipaueUyL2YXpkrSGw8aW2NemzLpwc
Message-ID: <CAE2XoE9=hjP+qpsy+FcYcSDectDajiXjtcMCVpacSo4cFOo=tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: arm64: Allow userspace to change MIDR_EL1
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Sebastian Ott <sebott@redhat.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> How do you determine that MIDR isn't updated? How do you update the
> userspace view?
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

The testing code is at
https://github.com/lygstate/arm64-kvm-hello-world/tree/midr/bare-metal-aarc=
h32-qemu
qemu changes:
```
From 543f2f656952ab01509025b79d0198736ef68231 Mon Sep 17 00:00:00 2001
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sun, 16 Feb 2025 02:57:44 +0800
Subject: [PATCH] Add support midr options for arm virt machine

---
 hw/arm/virt.c         | 20 ++++++++++++++++++++
 include/hw/arm/virt.h |  1 +
 target/arm/kvm.c      | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a5a9666e9..5ba690a70d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2236,6 +2236,10 @@ static void machvirt_init(MachineState *machine)
         object_property_set_int(cpuobj, "mp-affinity",
                                 possible_cpus->cpus[n].arch_id, NULL);

+        if (vms->midr) {
+            object_property_set_int(cpuobj, "midr", vms->midr, NULL);
+        }
+
         cs =3D CPU(cpuobj);
         cs->cpu_index =3D n;

@@ -3348,6 +3352,17 @@ static const TypeInfo virt_machine_info =3D {
     },
 };

+static char * virt_get_midr(Object *obj, Error **errp)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(obj);
+    return g_strdup_printf("0x%08x", vms->midr);
+}
+static void virt_set_midr(Object *obj, const char *value, Error **errp)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(obj);
+    vms->midr =3D strtoul(value, 0, 0);
+}
+
 static void machvirt_machine_init(void)
 {
     type_register_static(&virt_machine_info);
@@ -3356,6 +3371,11 @@ type_init(machvirt_machine_init);

 static void virt_machine_10_0_options(MachineClass *mc)
 {
+    ObjectClass *oc =3D &mc->parent_class;
+    object_class_property_add_str(oc, "midr", virt_get_midr,
+        virt_set_midr);
+    object_class_property_set_description(oc, "midr",
+                "Set MDIR value for VIRT machine");
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(10, 0)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aed..fe200b0d76 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -179,6 +179,7 @@ struct VirtMachineState {
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
+    uint32_t midr;
     bool ns_el2_virt_timer_irq;
 };

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb23..577eaee505 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1873,6 +1873,7 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 }

 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
+#define ARM_CPU_ID_MIDR_EL1    3, 0, 0, 0, 0

 int kvm_arch_init_vcpu(CPUState *cs)
 {
@@ -1920,6 +1921,26 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }

+    {
+        uint64_t midr =3D cpu->midr;
+        ret =3D kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MIDR_EL1), &m=
idr);
+        if (ret) {
+            return ret;
+        }
+        printf("Get MIDR EL1 origin:0x%08x\n", (uint32_t)midr);
+        midr =3D cpu->midr;
+        ret =3D kvm_set_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MIDR_EL1), &m=
idr);
+        printf("Set MIDR EL1:0x%08x\n", (uint32_t)midr);
+        if (ret) {
+            return ret;
+        }
+        ret =3D kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MIDR_EL1), &m=
idr);
+        printf("Get MIDR EL1:0x%08x\n", (uint32_t)midr);
+        if (ret) {
+            return ret;
+        }
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret =3D kvm_arm_sve_set_vls(cpu);
         if (ret) {
--=20
2.47.1.windows.1

```
The TCG running result:
```
/home/lygstate/work/qemu/build:/usr/local/sbin:/usr/local/bin:/usr/sbin:/us=
r/bin:/sbin:/bin
/home/lygstate/work/qemu/build/qemu-system-aarch64
+ qemu-system-aarch64 -cpu cortex-a15 -accel tcg,thread=3Dmulti -m 1024M
-smp 1 -M virt,gic-version=3D3,midr=3D0x412fd050 -nographic -monitor none
-serial stdio -kernel
/home/lygstate/work/debian/arm64-kvm-hello-world/bare-metal-aarch32-qemu/he=
llo_world.elf
Hello World midr:0x412fd050
```
The KVM running result:
```
/home/lygstate/work/qemu/build:/usr/local/sbin:/usr/local/bin:/usr/sbin:/us=
r/bin:/sbin:/bin
/home/lygstate/work/qemu/build/qemu-system-aarch64
+ qemu-system-aarch64 -cpu host,aarch64=3Doff -accel kvm -m 1024M -smp 1
-M virt,gic-version=3D3,midr=3D0x412fd050 -nographic -monitor none -serial
stdio -kernel /home/lygstate/work/debian/arm64-kvm-hello-world/bare-metal-a=
arch32-qemu/hello_world.elf
Get MIDR EL1 origin:0x410fd083
Set MIDR EL1:0x412fd050
Get MIDR EL1:0x412fd050
Hello World midr:0x410fd083
```

According to this, the MIDR EL1 is updated properly, but the MIDR for
aarch32 is not updated, and I don't know how to hook the update for
MIDR for aarch32
--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

