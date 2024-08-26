Return-Path: <linux-kernel+bounces-300666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA995E6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C0D1F218ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A722071;
	Mon, 26 Aug 2024 02:47:15 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9416FB0;
	Mon, 26 Aug 2024 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640434; cv=none; b=UW+T3S2hwC4UuhbhIW3Dd+BtQ3T7UxYJBP5lX2i2nNKn1cwjvM67iWf3ClD7duuNfw7JFX9UOsD1dbCbvMFS7LY5YKOBE6L20WecVxn5ouu7VXkjNYZrfn20WvsGjYkBScF9B/bP5/+qjNxe7Zw973C9Su8M/5POuPXfvsoQiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640434; c=relaxed/simple;
	bh=MgKNoOsItwBg8uZfUHaYvQHRAnqBPJW6SrDoMunkHsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nh63Os8nXq2HsoM4Fm2FPnJxJ7H6+YqKTTjNCb+JKlsuvPiVao1cSALhbenLrBc9GqJNZS3kJPdLZaFnyQa3sd9gs6H3+DgyqAu4F1LUQ4yVqp57k/px+7Rg0M4l5Ct7vv596DLVm+7MKf3fv7E0JC6pvIDHVj9UGZFpEmy/uV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8Axipqs7Mtm1vofAA--.29260S3;
	Mon, 26 Aug 2024 10:47:08 +0800 (CST)
Received: from haword-linux.loongson.cn (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMCxC2er7MtmDH4iAA--.51899S2;
	Mon, 26 Aug 2024 10:47:08 +0800 (CST)
From: zhenghaowei@loongson.cn
To: zhenghaowei@loongson.cn,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v3 0/3] uart: Introduce uart driver for the Loongson family chips
Date: Mon, 26 Aug 2024 10:47:02 +0800
Message-ID: <20240826024705.55474-1-zhenghaowei@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxC2er7MtmDH4iAA--.51899S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAQEBBGbLHfYEKgAAst
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr4xGF1xuFW8ArWktr18WFX_yoWkCrc_Ca
	s29as7Gwn7GF13tay7Xr17CrW3Za1UZ3Zaka40q34rXa9Ivws8JFyqv34DGF4IgrWDuFs5
	Ar4xGr10vrnrXosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbT8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
	bckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxUcVbyDUUUU

From: Haowei Zheng <zhenghaowei@loongson.cn>

Hi all:

This patchset introduce a generic UART framework driver for Loongson family.
It can be found on Loongson3 series cpus, Loongson-2K series cpus and Loongson 
LS7A bridge chips.

Thanks.

Haowei Zheng (3):
  dt-bindings: serial: Add Loongson UART controller
  tty: serial: 8250: Add loongson uart driver support
  LoongArch: Update dts to support Loongson UART driver.

 .../bindings/serial/loongson,uart.yaml        |  63 +++++
 MAINTAINERS                                   |   7 +
 arch/loongarch/boot/dts/loongson-2k0500.dtsi  |   2 +-
 arch/loongarch/boot/dts/loongson-2k1000.dtsi  |   2 +-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi  |   2 +-
 drivers/tty/serial/8250/8250_loongson.c       | 228 ++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c           |   8 +
 drivers/tty/serial/8250/Kconfig               |   9 +
 drivers/tty/serial/8250/Makefile              |   1 +
 include/uapi/linux/serial_core.h              |   1 +
 10 files changed, 320 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/loongson,uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_loongson.c

-- 
2.43.0


