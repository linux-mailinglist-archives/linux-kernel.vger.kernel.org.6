Return-Path: <linux-kernel+bounces-237853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26669923EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D55B2358F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC0C1B47A5;
	Tue,  2 Jul 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDxCGrTw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4A2AF16
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926926; cv=none; b=Hp5LnnnGC70FF6PZfBGkT/zMVMsb7PYB3fxQciezpIkMnZ3eH4UyY8kx24zVAMWgoP51qNQUVHqS7DkQKyTFw7+Ylq+XP17X6rl50MtEIJJEfRDgsp5Ssh1P1i29H5fmYrvJ9dNgRpCc8CTCb0VngsQIBMko9O7rs77gGZszeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926926; c=relaxed/simple;
	bh=q4svAmMc1YfDU639c9nrEQ3wazxYZ3hYbGX2/VSIc/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLo0SpCBWri2mSU/WHFvKxVugTUHJkuRO9lte4upAKOcpVaha+U2r4+d553zmFcqROEacpeaw4/LQ7FbWYg/adP89P9fKHl0X4mGo8+NVBk490OsjIXj6KBna0oQAn9MmpN8zcsDDmYghWLj9BlbvZFWRSLaFusahJDqAhueNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDxCGrTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719926922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TZPqfUHHXo3++9COyemfH9RMfBNgVvcEH+ci6+xoSdQ=;
	b=iDxCGrTw1NTszPoal/Yrm0Vbnd1/H5sBMuYgKMj8WuQascfIddnq3wGZ3d7UA6zMD2aiWi
	7aZAndzkbNWafojlPT5n+ibqnU8rFgV0Mib51YT+SrcPFdfv64Jjl1JtYLmNAdzvrH8kcS
	Mo4r5p1B/LF3CqOVE5uXdh1jiuBfOpA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-q5tTnlavPdSRguWfHzVwdQ-1; Tue,
 02 Jul 2024 09:28:40 -0400
X-MC-Unique: q5tTnlavPdSRguWfHzVwdQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82C6C19560A7;
	Tue,  2 Jul 2024 13:28:34 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD56319560A3;
	Tue,  2 Jul 2024 13:28:31 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/3] selftests: openvswitch: Address some flakes in the CI environment
Date: Tue,  2 Jul 2024 09:28:27 -0400
Message-ID: <20240702132830.213384-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

These patches aim to make using the openvswitch testsuite more reliable.
These should address the major sources of flakiness in the openvswitch
test suite allowing the CI infrastructure to exercise the openvswitch
module for patch series.  There should be no change for users who simply
run the tests (except that patch 3/3 does make some of the debugging a bit
easier by making some output more verbose).

Aaron Conole (3):
  selftests: openvswitch: Bump timeout to 15 minutes.
  selftests: openvswitch: Attempt to autoload module.
  selftests: openvswitch: Be more verbose with selftest debugging.

 .../selftests/net/openvswitch/openvswitch.sh  | 23 ++++++++++++-------
 .../selftests/net/openvswitch/settings        |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/openvswitch/settings

-- 
2.45.1


