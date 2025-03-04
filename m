Return-Path: <linux-kernel+bounces-544186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B5A4DE59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4091D7A7528
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DCC202998;
	Tue,  4 Mar 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WkYmpMPD"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869F1FC7FD;
	Tue,  4 Mar 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092731; cv=none; b=pk0mZXd0ajm21Exvc8KPUZlD1KNNoKZ4NYKpA63f969BXoR3kp7M7F9OZo5URCHfnw8k6WQ09HjXVrSvkz4JhNLaqb6Hg59vyPDtqcJArR6xuCQ3bpwYl+E1aGieYmQpR0SAaawErDkjAFEcKEK/u43N2UDmhP9ZMxS0+X6RruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092731; c=relaxed/simple;
	bh=jNXj/hM908lbIGT/rEay9SEHPUga9srW3xe5hIv0S4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2y2qWNgLlvigKBdUDUBcbJbLxTjAc1ewoLUWbQJ50bhh89zIfqngQmH+nxhlvBM8vOXukK2DfDkq3JIxrVMAwkX4t0cmRWgVh2YgtIPecr8258Rz5PjRqlh5FjxCKzkwQLPhr2bi5ZyHZnrhJtN2kF8IkIVB/g14CSYdm4tfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WkYmpMPD; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741092686;
	bh=uqbrItG4RF2iGWowQ1HAIeAWIrLWX/XtAcPaXldbM9U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WkYmpMPDliAQbHjKRg0TBEH9LUROFq9jOJXC3K+edpNJckfhotE7Dzpzk6dQWfE8A
	 prijyE8NeIDj2xnEfpzvFcoygxjespqaU8Ash7Fmo10yvAI6oD2c5ILajs19kMCMwC
	 Jm+qdnJXI3twqbhHKsp2G3xZuZTQzFoFLeKaX74w=
X-QQ-mid: bizesmtpip2t1741092678tcj7lod
X-QQ-Originating-IP: N/MK0n+jARevcIz76CPcyl4YeOuRDsR2KzdfonEkqv8=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Mar 2025 20:51:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9723207296368819461
From: raoxu <raoxu@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	raoxu@uniontech.com
Subject: Re:[PATCH V2] usb: xhci: Add debugfs support for xHCI port bandwidth
Date: Tue,  4 Mar 2025 20:51:15 +0800
Message-Id: <20250304125115.29332-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: OdexiAf7tcY2bVPH384jGr4mGD+SH+WbD52RF935rULBRBGFY/bvH+yw
	6f4Qh57ZwG6nlQrFqSYJrQukcc8pleZbeSqU5DrTSZ1iw0qro+VmX1Vwqoz9YzVj05UMn+N
	xgnBfdFzxmd6HUIW4VwcZlgw0yZpIB0c9NesUleLSI+OKgPaP1fJ8VKNw1nRH6u2Tk8ZJnT
	oInPrfHM3eM2pjhafrSQLLR7CFBhiCQ9e3nLJ+mf93SiI4y+UTEBr8ud6bxLmoXnplMeo46
	1sNxLfOIf7lEP7yr3Wvy7pX/xP4YdEEhL7YZhP3iWo/ptLRP/Q1OAkJnk9tJShEuMGhN/rH
	bWsHNTAg6hprT164nLPPAHM/rRuPJdlzk0h7EvQQcT+Rlnu6znAFmoHgcA2MX+67Umgyksu
	HG72c5vZKCjXSbO945KndyhpHGEigpjegra9AehTg2ex05UIUwCNZnSY9/UKyWWqCHQ3cuv
	ho6gOIMt66JP6I6fAQdGtakeK7lLFYtTochA68JuwlVmytaT1D/5VgIbA4yKWlH9K9ouTFz
	MVFgbTBMNGSK9AF7bsEIU4Jm7AX8jOq4cb/ckUEhp+/PuegfOTbUIRgzseABlsYDl3CrJK8
	k1ED5DBKrH7YxfGrmC0smya/mlm5jZiJZ6I5zirEphd/SH28YtZSJsz8ptGUHZjUv5/3lVq
	ij2G+wXqalNoe1OuyCXj20tZ8hP6GJ3A7YvYeH9mabIS38vKp7Jir4aKFe7qJLLpkmGIQaq
	kKf744STZ6WKjMCkagfozpS68RT5r+g7GkWbCJnJpWmiyGXBlOLRtQ61QshNvYl1hlnh8WH
	p+pB6QG6cTSUOqjbdS1Y0z3XCnrcrUzm5J/hUXhMs0cR6ghqBgR0ABpxn+u+7avtrLuDLdm
	nlLli4gdLaM0lpbVmbmeaKn1YB6r9jCWVk5kZv4h3j/CDd5Y70KQksGjMLvtR/lp7sTZVyU
	g3wK252k9cT7iqFsY01EKc6OcE9HLy5wsh0ji2IaMZsnXfq4RjHGcpVjCB2OfV2HqemMT8y
	5spOEQsvnxvkqYKr2B12NEPYfq0NVvuPDauck+7kzKk2XaRPNpDjb2gTX+kGbI0GJMnHM2z
	TQdEDp8vKY0kCW36RMF2VTTaHPC4BOTfA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On 2025/3/4 20:31, Mathias Nyman  wrote:

>I do however have some larger rework suggestions to this.
>
>Instead of queuing three commands on one file read, parsing and
>copy the content from each context dma into an array on stack, we could
>have separate files in debugfs for each speed, and queue one command
>for each. we could also skip the array on stack and print values from context
>directly.
>
>Something is also very off with the locks in this patch.
>Looks like every lock/unlock got replaced with an unlock

thanks Mathias Nyman,

Thank you for your valuable suggestions.I will separate files in debugfs for each speed.
skipping the array on stack and print values from context directly sounds good. looks is a error and i will fix it.
According to your suggestion i will send patch v3

thanks,

raoxu

