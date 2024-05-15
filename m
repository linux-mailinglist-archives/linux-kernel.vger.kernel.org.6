Return-Path: <linux-kernel+bounces-179988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F28C6881
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDF51C2102D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204513FD9E;
	Wed, 15 May 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVnfRoUs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB813FD75
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782945; cv=none; b=M9/qUhaD8LLGfPlARasvO/9oqYbch2cdJ3q+Ifa8ackCqC3Vfd1YG2TryILSRtf6/3k6fuTNtjecKevGUmp8HYkMZ0cNHAL4Xy1lcb3qysqoBljbHpvIKWnhBM6xDAMRZII24v8Y6K1/AQ6TotTFizPYlUWHwgaWnD79oICrCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782945; c=relaxed/simple;
	bh=NxGDLbAcKdwbtB6J8mw2EZXSli0OWp4mkgAH1PlvTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qWkOVaYBPPSOVU3LRS0BnwiEcRY+2JFGs4yS/2f5/Oq3CtEHWFBf5Br4GFt/JfvIltXkuSj4lcMd9OHOi39jUnuCeJHuUPk3kH2wT5BDKpzbFkndldYpeqewl+oAaTK+0KLYbhWGP0GlNI6OhrqVlIAOkbkvijt6L7xIsPlYsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVnfRoUs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715782943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QlQKAhS3Nec4t63RXRL98E390ZIIDklcYvobV4PMdfI=;
	b=IVnfRoUsjbtDZJAVmXtQn+TRP4akjJkZKGtJ+e2qK3IefjL6M/b9ObSF/CEAoYjyDUNq8l
	zv0Ly2U+HXR/+JcO+OIMCSPK32McqdIGR8w4ukDonSHw3Lu43Pd3DtCgnGTbvoPA0O4tuq
	XkZ4XG4KHvv4Um/18NgcUFdsybUAq6E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-w8YsbS0INcuFErP9kKATHg-1; Wed,
 15 May 2024 10:22:18 -0400
X-MC-Unique: w8YsbS0INcuFErP9kKATHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFF523C0E642;
	Wed, 15 May 2024 14:22:17 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.16.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 460B51C22B67;
	Wed, 15 May 2024 14:22:09 +0000 (UTC)
From: Karthik Sundaravel <ksundara@redhat.com>
To: jesse.brandeburg@intel.com,
	wojciech.drewek@intel.com,
	sumang@marvell.com,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH iwl-next v9] ice: Add get/set hw address for VFs using devlink commands 
Date: Wed, 15 May 2024 19:52:06 +0530
Message-Id: <20240515142207.27369-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Dear Maintainers,
    Thanks for the review and suggestions for my patch.

v8 -> v9
--------
- Rebasing against dev-queue branch of next-queue tree

v7 -> v8
--------
- Added const keyword for the parameter ``mac`` in ice_set_vf_fn_mac()

v6 -> v7
--------
- Addressed Smatch and checkpatch issues

v5 -> v6
--------
- Changed data type of vf_id to u16
- Used container_of(port, struct ice_vf, devlink_port) to
  get the vf instead of ice_get_vf_by_id()/ice_put_vf()

v4 -> v5
--------
- Cloned ice_set_vf_mac() to ice_set_vf_fn_mac() so that the
  parameter ice_pf is used instead of net_device of vf
- removed redundant error handling

v3 -> v4
--------
- Released the vf device by calling ice_put_vf()

v2 -> v3
--------
- Fill the extack message instead of dev_err()

v1 -> v2
--------
- called ice_set_vf_mac() directly from the devlink port function
  handlers.

RFC -> v1
---------
- Add the function handlers to set and get the HW address for the
  VF representor ports.


