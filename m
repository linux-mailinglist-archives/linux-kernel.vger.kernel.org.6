Return-Path: <linux-kernel+bounces-229379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E31916F10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D972855B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE51176AA7;
	Tue, 25 Jun 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK7okR+J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CB176AD8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336177; cv=none; b=AJvm4pFkIXMryBjKOkolJxy2W2bzBmviXwy2toJrPzV+P1zWZ0yDhXLT+73uw22pSIXajNnFoIJHfkxvBHOJlS4pqyKNldKL4usj+yugdZ0EqBqrMqizimpGlH3X/WXlGaGIpfBnWfTKpsVWHwykxnseKm2GJGJkl9JrUXM5XQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336177; c=relaxed/simple;
	bh=p6Fup42Q2qtmGDl7fmJ+we4o36qNwmbpakx4nDSvKWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBEmboO27vnoHMEJ/BN/JNoLhtr6qFyl9unBDo7ugXVIS1wF2aDo8kb53j0Vf+KTmZE6xMcsc+HMs4pvFzlkK4Mat//9+Y3VXpgJaBh4UYqnFrgyqKjgWj0g8hauvV4Oh5QOmFCxrjEk8GfdM/npVdyYbbX7LNtD3Xa3pJ+oEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK7okR+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719336174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DjjyquavlDzlhiW/KAeFuabyeroRLFzx9MMbHwtfmxM=;
	b=dK7okR+JJhQwkgX8tT1m2kwEL4T5HGocTt3X4MYig/rvnba2JnWO891Q+XLka9HuTfq84t
	7p93Wq3OpGAp1xO0DaAohRP6kDBZDB5loKS06mVd7l1NFhkfdMxywGR50hmLZWijuNMZjT
	g10pHn1uEX5IqqnRNjppejMg0Q9UIPc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-X3Annh6CPbOtGD-gCmp1dg-1; Tue,
 25 Jun 2024 13:22:51 -0400
X-MC-Unique: X3Annh6CPbOtGD-gCmp1dg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1975319560B4;
	Tue, 25 Jun 2024 17:22:49 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A2A819560BF;
	Tue, 25 Jun 2024 17:22:46 +0000 (UTC)
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
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 0/7] selftests: net: Switch pmtu.sh to use the internal ovs script.
Date: Tue, 25 Jun 2024 13:22:38 -0400
Message-ID: <20240625172245.233874-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, if a user wants to run pmtu.sh and cover all the provided test
cases, they need to install the Open vSwitch userspace utilities.  This
dependency is difficult for users as well as CI environments, because the
userspace build and setup may require lots of support and devel packages
to be installed, system setup to be correct, and things like permissions
and selinux policies to be properly configured.

The kernel selftest suite includes an ovs-dpctl.py utility which can
interact with the openvswitch module directly.  This lets developers and
CI environments run without needing too many extra dependencies - just
the pyroute2 python package.

This series enhances the ovs-dpctl utility to provide support for set()
and tunnel() flow specifiers, better ipv6 handling support, and the
ability to add tunnel vports, and LWT interfaces.  Finally, it modifies
the pmtu.sh script to call the ovs-dpctl.py utility rather than the
typical OVS userspace utilities.  The pmtu.sh can still fall back on
the Open vSwitch userspace utilities if the ovs-dpctl.py script can't
be used.

Aaron Conole (7):
  selftests: openvswitch: Support explicit tunnel port creation.
  selftests: openvswitch: Refactor actions parsing.
  selftests: openvswitch: Add set() and set_masked() support.
  selftests: openvswitch: Add support for tunnel() key.
  selftests: openvswitch: Support implicit ipv6 arguments.
  selftests: net: Use the provided dpctl rather than the vswitchd for
    tests.
  selftests: net: add config for openvswitch

 tools/testing/selftests/net/config            |   5 +
 .../selftests/net/openvswitch/ovs-dpctl.py    | 368 +++++++++++++++---
 tools/testing/selftests/net/pmtu.sh           | 145 +++++--
 3 files changed, 451 insertions(+), 67 deletions(-)

-- 
2.45.1


