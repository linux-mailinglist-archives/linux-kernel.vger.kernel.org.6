Return-Path: <linux-kernel+bounces-544840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E522A4E6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988498C164D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E4290BC1;
	Tue,  4 Mar 2025 15:59:30 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A728FFEE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103969; cv=fail; b=SaGhp/3LuWse56BbBwNTbEdr599B6dvZxowFQZ5iGojxQYURcMlb3wuILgyDBv7KRPMi+S8AFW4gT18qKDVNptsFiuyH+FYaS9UgoKMp+pv0crN194vglJVwFvxGSR66LxOp03LFijKAemmCrEEmQ1pseH+yh11LYtgMCPZyWig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103969; c=relaxed/simple;
	bh=D28MMNWE+45cppScAZmaj/qD9R8U6JIhVyN64bYc/w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5KDXh+xQjaXZiMqIcU0J8zep0zMFDJ/hGxwMwCpeTWAI9QDhWw+5Lt0nkevzih3iyQ1UcXhV3CbIZdfkD5658ENWFf4uuxZiNQeGC0wh20WJNri5Ba7PmLiv5WJbDs3+bUHigPCZDBKkwUK0fRNiOuGHHGNyzQnPgfxCcCzs1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=114.242.206.163; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id E14A740D046E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:59:22 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gLb5rXdzG1R9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:57:43 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 3C49C42760; Tue,  4 Mar 2025 18:57:31 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541347-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id A3D2643482
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:16:09 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7BB382DCEB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:16:09 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652AA18936BB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3D1F2C3B;
	Mon,  3 Mar 2025 10:15:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F81EE7DC;
	Mon,  3 Mar 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996943; cv=none; b=HDTGW9+oVPTXaRwJvnPCzrB0iLgEHIZn9ilyYwi/9OKnvaDzUGpyo3z9SJW/rzwADQsHUg0mCAzPS86R6T4xmZLvwQj8wS2HIEoHXVeHa60+L88mp4m0dBEnYdwximP22sksShZjyJZcMwVCUu+iUvjdAjZFkDGNmJGT14wbRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996943; c=relaxed/simple;
	bh=eg16nEOWpbtYg7w3qAHk9L3ekwHdkL5U1EQOqfl89Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZlPF4aYxZ5NdbRkGt6IN7DHgLE1728e4cw7BI1EyvtNaso1rC3i/TWRc7SuA8CcegMOx2bx6nGJ5e8e4DiTjFBLRADJPKiweRH/r82LIBLUOpEMQmd0Llms/ewqNaanJsinU2+Ovli34Ri/QgEwca2kaYDLHJtu7GfwkGAcDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8Ax3eJMgcVnOROJAA--.64036S3;
	Mon, 03 Mar 2025 18:15:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMCxLcVIgcVn0pYzAA--.57593S3;
	Mon, 03 Mar 2025 18:15:38 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	corbet@lwn.net,
	alexs@kernel.org,
	si.yanteng@linux.dev,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	peterz@infradead.org,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	maobibo@loongson.cn,
	siyanteng@cqsoftware.com.cn,
	gaosong@loongson.cn,
	yangtiezhu@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH 1/2] Docs/LoongArch: Add Advanced Extended-Redirect IRQ model description
Date: Mon,  3 Mar 2025 18:15:32 +0800
Message-Id: <20250303101533.31462-2-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250303101533.31462-1-zhangtianyang@loongson.cn>
References: <20250303101533.31462-1-zhangtianyang@loongson.cn>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
X-CM-TRANSID:qMiowMCxLcVIgcVn0pYzAA--.57593S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487M2AExVAIFx02aVAFz4v204v7Mc
	804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY
	67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcxkI7VAKI48JM4kE6I8I3I0E14AKx2xKxVC2ax8xMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_Jr0_Jr4lx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gLb5rXdzG1R9
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708698.10042@J6Xq09ScF5+BMxGKFqbj0g
X-ITU-MailScanner-SpamCheck: not spam

Introduce the Redirect interrupt controllers.When the redirected interrup=
t
controller is enabled, the routing target of MSI interrupts is no longer =
a
specific CPU and vector number, but a specific redirected entry. The actu=
al
CPU and vector number used are described by the redirected entry.

Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 .../arch/loongarch/irq-chip-model.rst         | 38 +++++++++++++++++++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   | 37 ++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentat=
ion/arch/loongarch/irq-chip-model.rst
index a7ecce11e445..45cba22ff181 100644
--- a/Documentation/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/arch/loongarch/irq-chip-model.rst
@@ -181,6 +181,44 @@ go to PCH-PIC/PCH-LPC and gathered by EIOINTC, and t=
hen go to CPUINTC directly::
              | Devices |
              +---------+
=20
+Advanced Extended-Redirect IRQ model
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer inter=
rupt go
+to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, PCH-MSI interru=
pts go
+to REDIRECT for remapping it to AVEC, and then go to CPUINTC directly, w=
hile all
+other devices interrupts go to PCH-PIC/PCH-LPC and gathered by EIOINTC, =
and then
+go to CPUINTC directly::
+
+ +-----+     +-----------------------+     +-------+
+ | IPI | --> |        CPUINTC        | <-- | Timer |
+ +-----+     +-----------------------+     +-------+
+              ^          ^          ^
+              |          |          |
+       +---------+ +----------+ +---------+     +-------+
+       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
+       +---------+ +----------+ +---------+     +-------+
+            ^            ^
+            |            |
+            |      +----------+
+            |      | REDIRECT |
+            |      +----------+
+            |            ^
+            |            |
+       +---------+  +---------+
+       | PCH-PIC |  | PCH-MSI |
+       +---------+  +---------+
+         ^     ^           ^
+         |     |           |
+ +---------+ +---------+ +---------+
+ | Devices | | PCH-LPC | | Devices |
+ +---------+ +---------+ +---------+
+                  ^
+                  |
+             +---------+
+             | Devices |
+             +---------+
+
 ACPI-related definitions
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-mod=
el.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.r=
st
index d4ff80de47b6..d935da47ce3b 100644
--- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
@@ -174,6 +174,43 @@ CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=AD=
=E6=96=AD=E5=8F=91=E9=80=81=E5=88=B0LIOINTC=EF=BC=8CPCH-MSI=E4=B8=AD=E6=96=
=AD=E5=8F=91=E9=80=81=E5=88=B0AVECINTC=EF=BC=8C
              | Devices |
              +---------+
=20
+=E9=AB=98=E7=BA=A7=E6=89=A9=E5=B1=95-=E9=87=8D=E5=AE=9A=E5=90=91IRQ=E6=A8=
=A1=E5=9E=8B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2=EF=BC=8C=
IPI=EF=BC=88Inter-Processor Interrupt=EF=BC=89=E5=92=8CCPU=E6=9C=AC=E5=9C=
=B0=E6=97=B6=E9=92=9F=E4=B8=AD=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=80=81=
=E5=88=B0CPUINTC=EF=BC=8C
+CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=AD=E6=96=AD=E5=8F=91=E9=
=80=81=E5=88=B0LIOINTC=EF=BC=8CPCH-MSI=E4=B8=AD=E6=96=AD=E9=A6=96=E5=85=88=
=E5=8F=91=E9=80=81=E5=88=B0REDIRECT=E6=A8=A1=E5=9D=97,=E5=AE=8C=E6=88=90=E9=
=87=8D=E5=AE=9A=E5=90=91=E5=90=8E=E5=8F=91
+=E9=80=81=E5=88=B0AVECINTC=EF=BC=8C=E8=80=8C=E5=90=8E=E9=80=9A=E8=BF=87A=
VECINTC=E7=9B=B4=E6=8E=A5=E9=80=81=E8=BE=BECPUINTC=EF=BC=8C=E8=80=8C=E5=85=
=B6=E4=BB=96=E6=89=80=E6=9C=89=E8=AE=BE=E5=A4=87=E7=9A=84=E4=B8=AD=E6=96=AD=
=E5=88=99=E5=88=86=E5=88=AB=E5=8F=91=E9=80=81=E5=88=B0=E6=89=80=E8=BF=9E
+=E6=8E=A5=E7=9A=84PCH-PIC/PCH-LPC=EF=BC=8C=E7=84=B6=E5=90=8E=E7=94=B1EIO=
INTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=
=A5=E5=88=B0=E8=BE=BECPUINTC::
+
+ +-----+     +-----------------------+     +-------+
+ | IPI | --> |        CPUINTC        | <-- | Timer |
+ +-----+     +-----------------------+     +-------+
+              ^          ^          ^
+              |          |          |
+       +---------+ +----------+ +---------+     +-------+
+       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
+       +---------+ +----------+ +---------+     +-------+
+            ^            ^
+            |            |
+            |      +----------+
+            |      | REDIRECT |
+            |      +----------+
+            |            ^
+            |            |
+       +---------+  +---------+
+       | PCH-PIC |  | PCH-MSI |
+       +---------+  +---------+
+         ^     ^           ^
+         |     |           |
+ +---------+ +---------+ +---------+
+ | Devices | | PCH-LPC | | Devices |
+ +---------+ +---------+ +---------+
+                  ^
+                  |
+             +---------+
+             | Devices |
+             +---------+
+
 ACPI=E7=9B=B8=E5=85=B3=E7=9A=84=E5=AE=9A=E4=B9=89
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.43.0



