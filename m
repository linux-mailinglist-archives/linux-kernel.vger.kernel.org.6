Return-Path: <linux-kernel+bounces-237794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43672923E2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9992B2355C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416F16D4CE;
	Tue,  2 Jul 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2/F+RmQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407A1448E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924957; cv=none; b=PKeNP381B0TqEvJAoIc6laDnRSia+TTVodQZkEP0YU7gXedKNoPKw0x2C/SszWmNmjnpDHUwolEScgCC7vszD+5WNElJytfNeEoSSO3HmIKiuZOw1o/Wl2HlavjbWgSo33X7VGY9Yipx/tKHCSMs2Ae+HuYLwqDd9V9c5MsdmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924957; c=relaxed/simple;
	bh=U6P7eVCzJoZzuJy/y8BdW7LZwuVI4OUl7YOCmqw2RZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MN33VSYM3LPPjm9rl3VsTFTZLkPKN2w98UlNNqPltzz8PFdcwDq5FN9+2oI8k6o3vrwlAKHDGCBG8gjeYJ5NN24NWawF0PELGfsVQxC1R28jHQv1l8HghUINdwkMHpkavIuvH7IF3LhVn4lekNwuSDZBnUPKRDHZOapLpIW/9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2/F+RmQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719924954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EkI6WIyKHOIUgF7Gkeaz7pP1bO8F3B8gLjy573v/fkE=;
	b=N2/F+RmQUTvDmkhYiQFcEU7Qfkhsll8KQj5UfKc81r4PFIPHnBm3StNuccFYwCxYF5TAKx
	4rwSbImSQzmcWdf3tgFl+K2Eu8RFpcO12vm7fnM2FQKmI/75GecxcU62Uo4BUPY6y2/Iw6
	DHkbaR8kXYixtkJ4QkYKPnm97fZW1iU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-kD7lF_IfMSiA8WIKJOk85w-1; Tue,
 02 Jul 2024 08:55:49 -0400
X-MC-Unique: kD7lF_IfMSiA8WIKJOk85w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C906B1944D1D;
	Tue,  2 Jul 2024 12:55:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.34.168])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 240143000B5E;
	Tue,  2 Jul 2024 12:55:46 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: kunit-dev@googlegroups.com
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	npache@redhat.com,
	raquini@redhat.com
Subject: [PATCH] Disable Clk-gate_tests for s390
Date: Tue,  2 Jul 2024 08:55:39 -0400
Message-ID: <20240702125539.524489-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently clk-gate tests for s390 fail as the tests create a pretend
clk-gate and use a "fake_reg" to emulate the expected behavior of the
clk_gate->reg. I added some debug statements to the driver and noticed
that the reg changes after initialization to -1, which is coming from
an error coming from zpci_load(). This is likely because the test is
using fake iomem and the s390 architecture likely isn't designed to
handle that. Turn off the clk-gate tests for s390 for now as there is
no clear work around for this problem as discussed in upstream
conversation [1].

[1] https://lore.kernel.org/all/301cd41e6283c12ac67fb8c0f8d5c929.sboyd@kernel.org/T/#t

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3e9099504fad..3c3e0b969020 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -514,6 +514,7 @@ config CLK_KUNIT_TEST
 config CLK_GATE_KUNIT_TEST
 	tristate "Basic gate type Kunit test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	depends on !S390
 	default KUNIT_ALL_TESTS
 	help
 	  Kunit test for the basic clk gate type.
-- 
2.44.0


