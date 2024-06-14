Return-Path: <linux-kernel+bounces-215361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1762909195
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ED81F229D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132D19EEBD;
	Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YL+iy83j"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C31465A5;
	Fri, 14 Jun 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386374; cv=none; b=CfQdhp80KVJVfoPVQp7+2iV5R6lO94Ipla0LSxwHiPJTmy5KCe4hpWml6LgBFAnkJ4j+K1ktSZyXFtykJJthslWYAGQu0je0JRsIc57b3UP7AdF8zKmhbq1Bh99iVLEFXqqmxS6p7/55c9kaVdtcya7kNKai/3sUlnHHBjBUDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386374; c=relaxed/simple;
	bh=o4UQjypgo9QMgDD5aBAMGyoqUTlXc8SIqGQXNDouQeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UqmlSZW15X+XDbi//8SqMcDFwyQT01cOdHw2/uT25aX/DATBN4McUZt5uK2Fr3AujJ9BiqHHoK3zHdr4664p6DNyaDOTnSZs0N59blxxLkr3PQlmFum4O6meFErczJU4qgF97WNhvPVg39BjVkSyWXw9OAXJozzLdslNRMV4gm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YL+iy83j; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6CE52FF805;
	Fri, 14 Jun 2024 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=67iEUNjiy7HOBuGoqBAJEp5jlBOCrSiBVzovVrhf8kQ=;
	b=YL+iy83jqq9bl02hakJXSOJ8KfKOOy8vAED2NEWLHenMZYkURWV2Ti2k1eK1UpGEgUB56k
	eUwzeRyIWpqAsfRuuYnkGXcMzkqByjT7TGLPBeMqm9tDIKbEDFQW3fffkzZxxUzeCEm45S
	Go4DxkW+5egokQSkV6e29gOj54hKh80CIopS5TDttW5TsaXgGl5mlskYN5HDqM/xapM4kz
	Ziy7Y4EJo4GJVn3VZdFPL5b3Qicvbfe18QZSY/B87DvHQk5kpXUKqkaj+1BxOAipVqb7Fh
	28V2ITL5/G64cE5dY7IDu4JuSnKx6wCwSu/NdS6of2guL6k/bLE1nVEeLcoHiQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 00/23] Introduce irq_domain_instanciate()
Date: Fri, 14 Jun 2024 19:32:01 +0200
Message-ID: <20240614173232.1184015-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

Previously, I sent a series related the support for the LAN966x PCI
device [1] and in particular several patches related irq domain
modifications and the introduction of the Microchip LAN966x OIC driver.

During the review, it was asked to rework the irq domain modification in
order to avoid more wrappers and a new irq_domain_instanciate() function
was proposed [2].

Also a patch [3] sent by Maitti Vaittinen can benefit of this new
irq_domain_instanciate() function. Even if Maitti's use case is not
handle yet in this series, it should not be a big deal add support for
it on top of this current series.

So, this current series introduces this new irq_domain_instanciate()
function and migrate existing wrappers and functions to this new
function (patches 1 to 20).

It then introduces the first driver that uses directly this new function
with the init()/exit() hooks set: the Microchip LAN966x OIC driver
(patches 21 to 23).

Existing irqchip drivers are not converted yet to use this new API
function in the same way as the LAN966x OIC driver does.
I prefer to have this series accepted first to avoid doing and re-doing
several times the same modifications on existing drivers depending on
changes requested on this current series review.

[1] https://lore.kernel.org/lkml/20240527161450.326615-1-herve.codina@bootlin.com/
[2] https://lore.kernel.org/lkml/8734pr5yq1.ffs@tglx/
[3] https://lore.kernel.org/lkml/bbd219c95f4fe88752aee5f21232480fe9b949fb.1717486682.git.mazziesaccount@gmail.com/

Best regards,
Hervé

Herve Codina (23):
  irqdomain: Introduce irq_domain_free()
  irqdomain: Introduce irq_domain_instantiate()
  irqdomain: Fixed unbalanced fwnode get and put
  irqdomain: Constify parameter in is_fwnode_irqchip()
  irqdomain: Use a dedicated function to set the domain name
  irqdomain: Convert __irq_domain_create() to use struct irq_domain_info
  irqdomain: Handle additional domain flags in irq_domain_instantiate()
  irqdomain: Handle domain hierarchy parent in irq_domain_instantiate()
  irqdomain: Use irq_domain_instantiate() for hierarchy domain creation
  irqdomain: Make __irq_domain_create() return an error code
  irqdomain: Handle domain bus token in irq_domain_create()
  irqdomain: Introduce init() and exit() hooks
  genirq/generic_chip: Introduce
    irq_domain_{alloc,remove}_generic_chips()
  genirq/generic_chip: Introduce init() and exit() hooks
  irqdomain: Add support for generic irq chips creation before
    publishing a domain
  irqdomain: Add a resource managed version of irq_domain_instantiate()
  irqdomain: Convert __irq_domain_add() wrappers to
    irq_domain_instantiate()
  irqdomain: Convert domain creation functions to
    irq_domain_instantiate()
  um: virt-pci: Use irq_domain_instantiate()
  irqdomain: Remove __irq_domain_add()
  dt-bindings: interrupt-controller: Add support for Microchip LAN966x
    OIC
  irqchip: Add support for LAN966x OIC
  MAINTAINERS: Add the Microchip LAN966x OIC driver entry

 .../microchip,lan966x-oic.yaml                |  55 ++++
 MAINTAINERS                                   |   6 +
 arch/um/drivers/virt-pci.c                    |  16 +-
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-lan966x-oic.c             | 278 ++++++++++++++++++
 include/linux/irq.h                           |  33 +++
 include/linux/irqdomain.h                     | 116 +++++++-
 kernel/irq/devres.c                           |  41 +++
 kernel/irq/generic-chip.c                     | 111 +++++--
 kernel/irq/irqdomain.c                        | 243 +++++++++------
 11 files changed, 782 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c

-- 
2.45.0


