Return-Path: <linux-kernel+bounces-545182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D70A4EA0B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07E917F296
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3F26E158;
	Tue,  4 Mar 2025 17:29:51 +0000 (UTC)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961026388D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109391; cv=fail; b=VcRrun70fgJMNvXmavn5I9lSU6e1EY382ls+X9MWluRhnA4HvTBeEuSDDqMMYZtZrvDeKI9qnkFfYscmZ7QPaULmMx6N5SwOLHos7LW1vsP3cjGqqKYnedx7FgXWFwOH/dNSfCSTmBN+D4TGhxSu33u7ysjmpMpyf2ivz4gDowg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109391; c=relaxed/simple;
	bh=E84Urg6HnzyhpysANovftsMj58oRhr0zbm3SeFZJpE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HN8Xp92mUJZQYUY/Fj4/ETFEOOOtZvB086y9PwJuc/tYqi6SU4683BQOy2vSbVkgoBoKPX21urtaWMavYod1lm0EmyssKQ8o5dSB/ZvbqoBAvelvtlrs3ITQWxFOUz5UrCK+576THQtWFADKuCX1B4A8ec+JDSCznRtkRS3wAFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=114.242.206.163; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 8D14F4089525
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:29:47 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f710CfczFyJh
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:02:37 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 3A03D42723; Tue,  4 Mar 2025 18:02:26 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541348-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 4B1B242DB6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:16:10 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id D38F22DCEB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:16:09 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125723AB29C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9EF1F2BA7;
	Mon,  3 Mar 2025 10:15:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DD1EC01D;
	Mon,  3 Mar 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996943; cv=none; b=ghxalij1zAMklTQR/8ofmA/AZFDaLGfyE2luEv0OJOeQ1itkAbUfsSHggqNOmO4JXyoKeW9k55a6KDwQviIS9GCi8c+dI/5LGeIxfubgDCoeBwzGs/vvvYqm6UZQXNuFcQ6ve0KJYpa25goJLOjscgUH0Fo9clcRUXwrJPWowLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996943; c=relaxed/simple;
	bh=NwNLeeftCAosTh1XBqMN2QGCBdQLzeL/+hRuhGMchm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMgnnDHsJhV0BP9AaEhLKBInGLFMmFOZd98P70kWAwPay1i+LAHh3BNnTnKPg3dIKrq6pqQAMI+NhxchmSIoNwDNaHFdB+cVI+D9Y6y8APY377th0irp+/MDgILo33zR4JwxReLscDdLwyVaEA8V9OXBpo01+vSNHeRG3QZ+Fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8DxjXJJgcVnLxOJAA--.37676S3;
	Mon, 03 Mar 2025 18:15:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMCxLcVIgcVn0pYzAA--.57593S2;
	Mon, 03 Mar 2025 18:15:36 +0800 (CST)
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
Subject: [PATCH 0/2] Loongarch irq-redirect supprot
Date: Mon,  3 Mar 2025 18:15:31 +0800
Message-Id: <20250303101533.31462-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qMiowMCxLcVIgcVn0pYzAA--.57593S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jry8KrW5Aw1DGFW8KFykJFc_yoWDJrc_u3
	WSq397GrWxWayxJayIvr1fXryjyF40gFnY9Fs0qF4fXa4Fyw15Jr47Z345Zr4jkFyqqFZ5
	CrW0vr1rAw12yosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f710CfczFyJh
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714059.66471@wuiBmUPtt1fdMSGTXkdb7g
X-ITU-MailScanner-SpamCheck: not spam

This series of patches introduces support for interrupt-redirect
controllers, and this hardware feature will be supported on 3C6000
for the first time

Tianyang Zhang (2):
  Docs/LoongArch: Add Advanced Extended-Redirect IRQ model description
  irq/irq-loongarch-ir:Add Redirect irqchip support

 .../arch/loongarch/irq-chip-model.rst         |  38 ++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   |  37 ++
 arch/loongarch/include/asm/cpu-features.h     |   1 +
 arch/loongarch/include/asm/cpu.h              |   2 +
 arch/loongarch/include/asm/loongarch.h        |   7 +
 arch/loongarch/kernel/cpu-probe.c             |   2 +
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-loongarch-avec.c          |  24 +-
 drivers/irqchip/irq-loongarch-ir.c            | 576 ++++++++++++++++++
 drivers/irqchip/irq-loongson.h                |  12 +
 include/linux/cpuhotplug.h                    |   1 +
 11 files changed, 687 insertions(+), 15 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-ir.c

--=20
2.43.0



