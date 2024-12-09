Return-Path: <linux-kernel+bounces-438162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF89E9DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B5518820EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1A1C5CA7;
	Mon,  9 Dec 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OImG4j0k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7A1B4256
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767086; cv=none; b=f8TY8fiPMZ4a+ZCotzbacSvqJAkx/pkGk0OhAybvxLo8gDfXXvGeaGdw236WYAELsZw/zFnII+osOC+j4iR0dgr3QJ3LnoeLxoJ8e1Zv0ATEtVXnpzpvn26b71YtgH7ETjVNdETGln7Cx7N7z8FK+/flgn8lEsjwFe9z0jnpD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767086; c=relaxed/simple;
	bh=Y0UWrup3k88kt3zxiyLdBAaXUERYXhcmbMd/lY9JbrU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rr36tRb/tWwDVLqaodpNEj6Ch8icmd8mhX8mxTzcBmECeit3jM6xV1mACQ/wu4SI1M8lZ0emYDDzb3q54I9StsvN5V8TSAGfL4yiemOTctJyNm7VWi0blhf5SSu4yZ2wHqmGxG6RvxIQQDZbdey0ihaBm2zw7UWGSa1gTBEOaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OImG4j0k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733767083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QhpxtO/mBMO94vZO3552ZqfP00gjpgAVYCMI7XwChuY=;
	b=OImG4j0kZKglyjfnL18Y0d7I0oEDduuToQLeYKV0PhOKTxtN6qiSn6qqVU3W7K++AwqvaG
	dSWPIdGNUC5VpX/l+VQ/qTza0r3K4Moe/qnVP3SkVCMBI17P2sW8nGDBb7FBuTE4DWWDol
	1NmDDWogaRw/VG+hxBEB4gD+VWYZeA0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-P1HD2u1LMmiYqFjiGeIlYw-1; Mon,
 09 Dec 2024 12:57:58 -0500
X-MC-Unique: P1HD2u1LMmiYqFjiGeIlYw-1
X-Mimecast-MFC-AGG-ID: P1HD2u1LMmiYqFjiGeIlYw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E74691955F43;
	Mon,  9 Dec 2024 17:57:55 +0000 (UTC)
Received: from starship.lan (unknown [10.22.82.46])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E99E195605A;
	Mon,  9 Dec 2024 17:57:51 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Long Li <longli@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 0/2] MANA: Fix few memory leaks in mana_gd_setup_irqs
Date: Mon,  9 Dec 2024 12:57:49 -0500
Message-Id: <20241209175751.287738-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Fix 2 minor memory leaks in the mana driver,=0D
introduced by commit=0D
=0D
8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  net: mana: Fix memory leak in mana_gd_setup_irqs=0D
  net: mana: Fix irq_contexts memory leak in mana_gd_setup_irqs=0D
=0D
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 6 ++++--=0D
 1 file changed, 4 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D


