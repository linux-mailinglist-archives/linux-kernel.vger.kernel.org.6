Return-Path: <linux-kernel+bounces-370384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E19A2BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365541C23045
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5C1E04B6;
	Thu, 17 Oct 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cw10VNS9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6231E00B3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188627; cv=none; b=AkI4dtSW/5VBR4jfrV8aeQJJPNzNJtQ2OElZM3UBN0b46Bn0ntZT/xpFHhveBIVmdwhYk72SBHEbJCvxdpHEKhX3UThKhL0JCwJ4tO52LlxJR31ifOEqPSLyby+k5qDfB45yZqDhUnnWdAnPFgS11XlVmJ+Kan1tuUBV2b5AwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188627; c=relaxed/simple;
	bh=mLSjiTOUh+E9CxgYwi1U1f5AhkZN84D58GBwPA5jKvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWyEjG0UJ4qsuJtDft4w2YIIyjWFth0Gy6v568lwLTeqbYaijnIPJlVZa3WywvoQeUhaDSeoKunVIRuKP8/58pDfoMWiJxG0QOrMDB3AgmS2JER2Euprzmpx+XTVGEFlRRuN35AndJRbGH11DQHxRo7PbIBJdm3yP+D4L4pdCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cw10VNS9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729188624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mLSjiTOUh+E9CxgYwi1U1f5AhkZN84D58GBwPA5jKvA=;
	b=cw10VNS9wM0RuHYgerg0dXOicQrl1I2L6qNSJVHzRFCvR2Ql47PnL4suSbywNOiB4hhldR
	hO8K0KIyrXvMmpzxvO1PwLNx9LggIeAKSZuO20QA63bvQ+KtHSUhXFatUIe/iXtH7bQn8X
	3F8tuS4JKOAcdoGCkb7CntPcAIheE/Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-Ehjx0aHHPMOzPn1gosugIw-1; Thu,
 17 Oct 2024 14:10:21 -0400
X-MC-Unique: Ehjx0aHHPMOzPn1gosugIw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17D1019560A3;
	Thu, 17 Oct 2024 18:10:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.106])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D73E1956086;
	Thu, 17 Oct 2024 18:10:17 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com
Subject: [PATCH v4 0/2] wifi: ath12k: fix issues when unbinding
Date: Thu, 17 Oct 2024 20:07:30 +0200
Message-ID: <20241017181004.199589-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

wifi: ath12k: fix issues when unbinding

Currently, ath12k driver is not working from VMs but it cannot be unbinded
either from there. I would like to send these patches to fix the issues that
I have found in order to get the unbind operation working there, at least to
fix the errors found during the process when the initial error is detected.

Just FYI and out of the scope of these patches, I am unbinding and binding
to apply a workaround with an extra module to fix the MSI addressing by
means of kprobes to be able to work with this device from VMs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>


