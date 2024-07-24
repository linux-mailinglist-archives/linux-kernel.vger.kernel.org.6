Return-Path: <linux-kernel+bounces-261136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D993B311
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C229281B96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572C916F27A;
	Wed, 24 Jul 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A66C9mZT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002515B133
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832415; cv=none; b=rSIHcFGxp78IzzGj/6Wn4tl1NMh/HgkogPJHUy+s2kMKQ2ysZoLbpxzM+QgVu/2cbzSxnoXYIqtEeDE11I/cEYr9FPdqmocHzUe2pYPeMSsnBYTCec6CIhvbp5BxjM2AH4lnOZSiCJFOikrqJvM+NHE1ar5m31jQTYwxYl8g014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832415; c=relaxed/simple;
	bh=6FewaBjJjpbdVWRUM2owAR3Q2PzvlDTS3+AhZu2c0dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOpL300E+1DyvRj+jdI1XTndWdX4ssFhBS1q3y6g2/VpQhDyGRQ6+ahEU0oiBVHGw3P0/euW1vp7y24MVvZb58phTX8BN4JDiSrQ40Cq/wDmqScj9Q5u2ezj0tLHsPySrqohC0Ij6ZuP0WbNVh1iJXPQZEdamCBaVVy85WDADUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A66C9mZT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FewaBjJjpbdVWRUM2owAR3Q2PzvlDTS3+AhZu2c0dM=;
	b=A66C9mZTpiRCDRA5/RwF5ye5ji/TPivJ1eM+f1dzO+nsiYK3QdQZxh/r06QaVeV0aYAdhY
	vnDFh4Mtea2BcQYNokVhUd4PJA8ILbiY71toSUSOBzKNjZkQ9rxuvCMKsoyVGCv1ycDamK
	uMJOQPcIBkrYZV+nimUfsp8iC6SgYlo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-c5kfv1sCO2GN3gAPhuo-7Q-1; Wed,
 24 Jul 2024 10:46:47 -0400
X-MC-Unique: c5kfv1sCO2GN3gAPhuo-7Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51EB71955BEE;
	Wed, 24 Jul 2024 14:46:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A8231955F39;
	Wed, 24 Jul 2024 14:46:27 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: andrew@lunn.ch,
	gregkh@linuxfoundation.org
Cc: UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy module
Date: Wed, 24 Jul 2024 16:46:20 +0200
Message-ID: <20240724144626.439632-1-jtornosm@redhat.com>
In-Reply-To: <2024072430-scorn-pushover-7d8a@gregkh>
References: <2024072430-scorn-pushover-7d8a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Andrew,

> Is MODULE_WEAKDEP new?
Yes, and it has been merged into torvalds/linux.git from today:
https://git.kernel.org/torvalds/c/f488790059fe7be6b2b059ddee10835b2500b603
Here the commit reference in torvalds/linux.git if you update your repo:
https://github.com/torvalds/linux/commit/61842868de13aa7fd7391c626e889f4d6f1450bf

I will include more references in case you want to get more information:
kmod reference:
https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7
kmod test-suite has also been completed:
https://github.com/kmod-project/kmod/commit/d06712b51404061eef92cb275b8303814fca86ec
dracut patch has also been approved:
https://github.com/dracut-ng/dracut-ng/commit/8517a6be5e20f4a6d87e55fce35ee3e29e2a1150

> It seems like a "Wack a Mole" solution, which is not going to
> scale. Does dracut not have a set of configuration files indicating
> what modules should be included, using wildcards? If you want to have
> NFS root, you need all the network drivers, and so you need all the
> PHY drivers?
The intention is to have a general solution not only related to the
possible phy modules. That is, it is a solution for any module dependencies
that are solved within the kernel but need to be known by user tools to
build initramfs. We could use wildcards for some examples but it is not
always easy to reference them.
In addition, initramfs needs to be as small as possible so we should avoid
wildcards and in this case, include the only possible phy modules (indeed
not all phy's are compatible with a device). In this way, with the default
behavior, initramfs would include only the drivers for the current machine
and the only related phy modules.

Thanks

Best regards
José Ignacio


