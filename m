Return-Path: <linux-kernel+bounces-291789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AA69566EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35CB282C73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812215F40A;
	Mon, 19 Aug 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuIZmxLO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250915F319
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059751; cv=none; b=EtRVsEIOmEgwjmyb7qR0OdwugFUj47K8qNeraleVN/bC06vGK89cXBNFPFYL0sFxrutsoPj95Jc6AKyhwbJkG1TPWxvRwTkchQaoSgesxFV9vwrfsog3TYRmQvlwPvOuG1dpvr5ap3q4GiLvlefZaMhcFLBp446oETUaeCv00Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059751; c=relaxed/simple;
	bh=T28RQRktjxNSpRXzjatTxI5HNr8v0aKmaJkUuNN6u0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/0YPfD/fBkAvr7GTNOB35MPUw9pWaqw8TFxp/Ilgej1vIrzePhSxQd5bCHv9ZhtPjWcwjAnYkESWSPMaDuE8v/4QdFotML67cKPVsEikzi9pJZ/EEvX/jNDsUjOv59+G+OKPPVqV4fC/qnpV6GBaJiYZeuYjAD6pdoge9GghKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuIZmxLO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/kmoYqnstbKFrlYx9VIPQUYp5ncxzSL1je8L9dtZF4=;
	b=OuIZmxLO9+PAnwsEAngqOmrcz+H1ih0rvu6h7YfAFlBXUoWyWc40c/rIihM8ARy6YeRk9Z
	orWWeDQ4DOpZb8dHnYV1j0OyUztKTQzYoeJPH98Wp4zlLazPsBFwAlK9P2wUPm1c7xkWud
	d9lVPjSBtBsl6rSvjwQnxpKkS4KvZXo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-59nOVgyVNDa2gavH-v9Rrw-1; Mon,
 19 Aug 2024 05:29:07 -0400
X-MC-Unique: 59nOVgyVNDa2gavH-v9Rrw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64FA01954206;
	Mon, 19 Aug 2024 09:29:06 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 175AA1956054;
	Mon, 19 Aug 2024 09:29:02 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 1/7] vhost: Add a new module_param for enable kthread
Date: Mon, 19 Aug 2024 17:27:27 +0800
Message-ID: <20240819092851.441670-2-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
References: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add a new module parameter to enable kthread while loading modules.
This parameter will identify if the vhost will use kthread or a task.
The default value will be true.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..da701f6b3f2c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,9 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool use_kthread = true;
+module_param(use_kthread, bool, 0444);
+MODULE_PARM_DESC(use_kthread, "enable vhost to use kthread (default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
-- 
2.45.0


