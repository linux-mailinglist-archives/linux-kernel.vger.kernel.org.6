Return-Path: <linux-kernel+bounces-268867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9717942A77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F93B1F212A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5FD1AB538;
	Wed, 31 Jul 2024 09:28:31 +0000 (UTC)
Received: from smarthost01b.sbp.mail.zen.net.uk (smarthost01b.sbp.mail.zen.net.uk [212.23.1.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9E1AB520
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.1.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418111; cv=none; b=DoHFNXZZW7VIwHXm4gy6nWVQ/PrjSf03YpVjG5pmk8ia+MrqKu9d62Um6HkleX3FuA02lOXvOTFhUpX0kC1FT3ZgB65a7G5G7MflRudwEvyDXWnG7f6PpDmnCAZYPr3BnfOUQ3qrwiUUMo9Nuk/FAu9hF38jBRdR/LB0ex3fOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418111; c=relaxed/simple;
	bh=b4WwrNrAB82w9ZMnVIX1vYwLJA54i1+hcnf2OZkqHeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D2DcpmcjuMMk/Qind6E7sU5a/+kvX1x4sEgLuI7SHlekK7mZ8KfXj0EabbCWLsqURqKWP1icVEK13ggkG+Sc1CEqnAE90vfn54xt189tLy4ROwjUKaIYPTIy8/YARmMEuw6AS/4O7pK0slcZNH2J5RVg/ejXuhCrW1be//yz6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk; spf=pass smtp.mailfrom=dingwall.me.uk; arc=none smtp.client-ip=212.23.1.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dingwall.me.uk
Received: from [217.155.64.189] (helo=mail0.xen.dingwall.me.uk)
	by smarthost01b.sbp.mail.zen.net.uk with esmtpsa  (TLS1.0) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sZ5d4-003RKq-Mp;
	Wed, 31 Jul 2024 09:28:19 +0000
Received: from localhost (localhost [IPv6:::1])
	by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 8C68DA6BB0E;
	Wed, 31 Jul 2024 10:28:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
	by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhfW9aP--uLD; Wed, 31 Jul 2024 10:28:19 +0100 (BST)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2a02:8010:698e:302::c0a8:105])
	by dingwall.me.uk (Postfix) with ESMTP id 56E4EA6BB0B;
	Wed, 31 Jul 2024 10:28:19 +0100 (BST)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
	id 35191D8DEF0; Wed, 31 Jul 2024 10:28:19 +0100 (BST)
Date: Wed, 31 Jul 2024 10:28:19 +0100
From: James Dingwall <james@dingwall.me.uk>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: megaraid_sas "Failed from megasas_init_fw 6539" under Xen
Message-ID: <ZqoDs93/kylOPYWb@dingwall.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-smarthost01b-IP: [217.155.64.189]
Feedback-ID: 217.155.64.189

Hi,

I've been having a problem booting a Dell system with an H355 controller
(megaraid_sas) under Xen, bare metal is fine.  The reported messages on
modprobe are:

    FW now in Ready state
    Failed to set DMA mask
    Failed from megasas_init_fw 6539

I have narrowed the cause down to the conditional behaviour introduced
in ad96ce3252dbab773cb343220662df3d84dd8e80 for default_swiotlb_limit()
to support the CONFIG_SWIOTLB_DYNAMIC option and the change in
05ee774122bd4a2f298668d6d5fc9e7b685a5e31 to use that function for
xen_swiotlb_dma_supported().  It looks like both of these changes were
introduced for v6.6.

If I rebuild the kernel with CONFIG_SWIOTLB_DYNAMIC=n the system will boot
as expected.  (I'm rebuilding an Ubuntu kernel where the default is
CONFIG_SWIOTLB_DYNAMIC=y)

It looks like megaraid_sas does something slightly unusual by using
DMA_BIT_MASK(63) since 894169db12463cea08d0e2a9e35f42b291340e5a but
I don't know if that is related.

Should I expect the system to behave with CONFIG_SWIOTLB_DYNAMIC=y
under Xen?

Thanks,
James

