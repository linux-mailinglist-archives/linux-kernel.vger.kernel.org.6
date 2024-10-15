Return-Path: <linux-kernel+bounces-365868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9A99ECA6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BD11C23546
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D266E229111;
	Tue, 15 Oct 2024 13:16:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C51D5ABD;
	Tue, 15 Oct 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998205; cv=none; b=q35dp3vDB+R7zzFoUeo9HS8hgX6pBkm5Yonnmk/ROSwdyl70TkHvtFF4S87bwb+ez4hAY0ZHSOCK6qNbAT7jtJ7WeFdrNVMJ4PuGdCgNcl4d3vy0TL9a/UEnCH4ma57ixI/SmAkny6TSDpbJk3kNUwTT1cspaYiaY8nB0uVd+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998205; c=relaxed/simple;
	bh=kdc5SQVe1Mq5zl/eblfY8hX7dcxSLTCRqR5Rwq6O0U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9QZzgdE46WzfbEjx8W0d021maM2v7BYC+n8UA547jgla/7V5PyvUsexHnTDwl1PwLVnMgqTOgeSmFCu+hu7nlK7XkELb/xjhAMWguUJ5JrYdtztUhNX0KucenTYq6agyAztPslKV53e72rwjzfh2lbu1vfU45e6yQ5e/UcsbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF883FEC;
	Tue, 15 Oct 2024 06:17:12 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 354843F51B;
	Tue, 15 Oct 2024 06:16:41 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infreadead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	justin.chen@broadcom.com,
	opendmb@gmail.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] firmware: arm_scmi: Give SMC transport precedence over mailbox
Date: Tue, 15 Oct 2024 14:16:34 +0100
Message-Id: <172899815900.948565.3328227114725674760.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007235413.507860-1-florian.fainelli@broadcom.com>
References: <20241007235413.507860-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 07 Oct 2024 16:54:13 -0700, Florian Fainelli wrote:
> Broadcom STB platforms have for historical reasons included both
> "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
> string, in that order.
> 
> After the commit cited in the Fixes tag and with a kernel configuration
> that enables both the SMC and the Mailbox transports, we would probe
> the mailbox transport, but fail to complete since we would not have a
> mailbox driver available. With each SCMI transport being a platform
> driver with its own set of compatible strings to match, rather than an
> unique platform driver entry point, we no longer match from most
> specific to least specific. There is also no simple way for the mailbox
> driver to return -ENODEV and let another platform driver attempt
> probing. This leads to a platform with no SCMI provider, therefore all
> drivers depending upon SCMI resources are put on deferred probe forever.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Give SMC transport precedence over mailbox
      https://git.kernel.org/sudeep.holla/c/db8f0b808886
--
Regards,
Sudeep


