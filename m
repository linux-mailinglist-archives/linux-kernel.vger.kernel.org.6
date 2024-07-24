Return-Path: <linux-kernel+bounces-261239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FFC93B495
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D376B21702
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783915ECC3;
	Wed, 24 Jul 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sp+bP9ub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CB15E5CE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837437; cv=none; b=rIN0zCTcEsb5uwZtRDZJxvqP65mdpgFzdLKg1yHOkzHPMo9f+xQUW1Iy7Rv/uMNUX8y4AnhusRbSpK4WCqVRfQ1e7bupgnVuzz28UzFMUtuNVpIdGqW2Etfc8uQPx5Goe45IX7aYzYkqxoPk4ZuuKoD9q2eFTq5/pr6gpfYig38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837437; c=relaxed/simple;
	bh=xKuqmp5MN+0/pHZT6ZnqgPkG42DPVLE76u7nFnI4lRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1mvBpK2TuUTjMLeHMqhS8wR1Xts7z3vjpDIl88EFMB0INigcebSN+WjAuj5u7r6l1FGdukmo2mXxuF9N5U8ThcHPEbdHfdUBG0G4iLyii7h0OjC7+Af8+dwni8Snc2bhmuicT+D47zNvspgsiYfiJT2WGk3vOEu6vrQagGpybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sp+bP9ub; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721837434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRTjK/ZIhXoCrM7SewCkp9GyuhD3ieaXklrRHxctI+8=;
	b=Sp+bP9ubfa7k9GbH9X4k90+47IdHg5407j1eKRm4PzvaF28mMKTLGccJ9Q26keACjqp5GO
	zTmt5pDpRyaBazuURddpEFwG2QvRsEnH67gAwUOrhJreQm14EQwvJVqVdATq88nrJ8l0ef
	JR7pM6a9Iss8qq+LA8KnjEaTirIBllQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-7nXhFaTXN8Kz79bQcBuyvw-1; Wed,
 24 Jul 2024 12:10:30 -0400
X-MC-Unique: 7nXhFaTXN8Kz79bQcBuyvw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3563019560AD;
	Wed, 24 Jul 2024 16:10:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C62C61955F40;
	Wed, 24 Jul 2024 16:10:22 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jtornosm@redhat.com
Cc: UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	lucas.demarchi@intel.com,
	mcgrof@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy module
Date: Wed, 24 Jul 2024 18:10:19 +0200
Message-ID: <20240724161020.442958-1-jtornosm@redhat.com>
In-Reply-To: <20240724145458.440023-1-jtornosm@redhat.com>
References: <20240724145458.440023-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Florian,

> What is the difference with the existing MODULE_SOFTDEP() which has pre 
> and post qualifiers and seems just as fit?
MODULE_SOFTDEP (with pre and/or post qualifiers as you say) causes the
modules to be directly loaded.

MODULES_WEAKDEP doesn't cause the modules to be loaded. 
The load will be done later, if necessary, by other mechanisms in the kernel.
For example for the commented case, the associated phy is read using mdio bus
and then the associated phy module is loaded during runtime  by means of the
function phy_request_driver_module.
It is just informing to user applications, like dracut, about this in order to
be able to prepare the complete and correct initramfs. 
Keep in mind that these applications have no way of knowing about this situation
and if the phy is not included in this case, the driver will not work at
initramfs stage.
If we used MODULE_SOFTDEP the modules would be loaded in advance even if they
were not necessary.
For the commented case, I have included only one phy because it is the hardware
that I have, but other phy devices (modules) are possible and they can be some.

Thanks 

Best regards
José Ignacio


