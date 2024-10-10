Return-Path: <linux-kernel+bounces-359671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49D998F01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487A1B28EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE231CDA3C;
	Thu, 10 Oct 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0gxGgft"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC61CDA05
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582688; cv=none; b=mnMA0PNAg/1Gv+bEUwrINioj+PHiNfmqowrbauq4LCePXu+3+Z4yt1oI75cSFwx5Np6aIlviKxHEzHUgLqizy+sx21joB0ZjQPKusPW77G8zs+vNz92hSlQWofvp3Rzm6qNqoWCzyGhURTq9WuB6VtlzPhQ9ZV/E5gWioEckSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582688; c=relaxed/simple;
	bh=mLSjiTOUh+E9CxgYwi1U1f5AhkZN84D58GBwPA5jKvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5nSN6UYU93Qgss+HGGFpOHF9Pn7ENLGCF4rz0WeHIhOdIX4ZXuWBlNiLfn+bFJQ/4NjEolf9lv5cxP6gkDZJQ+wPKj4MHK480I/Gfk18+5gzduqHK842XvkMyZMIeQu1LJGETY8TH/7RGmg4YZBuBtYgfAUXj5cR3u+wXgST8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0gxGgft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728582686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mLSjiTOUh+E9CxgYwi1U1f5AhkZN84D58GBwPA5jKvA=;
	b=Y0gxGgft4AAnDeQdvPfG0/xX8xtyHOvF1zZzdBNufp+lds9jbUoma+4XpoDv0mL4AUlDKb
	idAZqrPFEvkDRttaOq/RibpngJz9Od7vuksln9ElOfHPBh6NF0DFhfrK/pCU5wXxG9r+dC
	8y0U5DpcchzkMSTvIgEnYP5tIFzAyyo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-YefpJFcHO92pOnqSvKAYyw-1; Thu,
 10 Oct 2024 13:51:21 -0400
X-MC-Unique: YefpJFcHO92pOnqSvKAYyw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D38BA1955D42;
	Thu, 10 Oct 2024 17:51:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.239])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FE8919560A2;
	Thu, 10 Oct 2024 17:51:16 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com
Subject: [PATCH 0/2] wifi: ath12k: fix issues when unbinding
Date: Thu, 10 Oct 2024 19:48:57 +0200
Message-ID: <20241010175102.207324-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

wifi: ath12k: fix issues when unbinding

Currently, ath12k driver is not working from VMs but it cannot be unbinded
either from there. I would like to send these patches to fix the issues that
I have found in order to get the unbind operation working there, at least to
fix the errors found during the process when the initial error is detected.

Just FYI and out of the scope of these patches, I am unbinding and binding
to apply a workaround with an extra module to fix the MSI addressing by
means of kprobes to be able to work with this device from VMs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>


