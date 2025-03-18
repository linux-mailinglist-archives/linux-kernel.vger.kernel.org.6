Return-Path: <linux-kernel+bounces-566300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA32A6760A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3BB7A2E12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551A20E01F;
	Tue, 18 Mar 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hs4Vl4Yt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7020C006
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307148; cv=none; b=HwLwndo/3P3M0dhKSR18otORQS3+AeBYLJwmT06FlmbBmPMaGU2K1rz3D2DAGoymWGhfbE8mXoaYYOSoE75eYx3hcbXgViuG81D85Dt0qH3iyYucI1ttO03wV6dXKoySF8bZ5q4k4LIqwsLb0b6DlZ1h5fBrhyOTeISKKW3cBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307148; c=relaxed/simple;
	bh=WXRwNj05gRvHK/97/bik19XlcKem10UrEpbjnH1iagU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ma12MMHRZDnIdX8s2n8YCyNPBoRtLEEd5ecwKNETTC4rc16wLGuN3ez9drumgXLIsV/SdAlCqva9pNbWoZD2QaacTUyKVG/ZL1WdHNAmNvHzXJ0yPcpZ8Tj6gp9n/hzwBIlek9N7f0SVMcQIVcDjBUacIa6YCmO2/WVMDIqRa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hs4Vl4Yt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742307141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=whzTFkFoGt4dySrIjdeWNfrysVaNhXBD5R5KGeQx39k=;
	b=hs4Vl4YtDPZ1hV/GI+9/ZEc0zog1+s7c6Iw/piZYBlnEY9PyQ16Q5SsPFdVB85fEmWiaY2
	+WfdxgQjEzftEuVYRbskiwGm5QmbvTS40Lwu8bqMcxT/5INYD0oS6FhtA+h6relYgVPDiz
	qBQr7FuvOmDctpsMNA/G1eq+fcP7Th4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687--AZFvQW3Mo6glKO40HMlIg-1; Tue,
 18 Mar 2025 10:12:18 -0400
X-MC-Unique: -AZFvQW3Mo6glKO40HMlIg-1
X-Mimecast-MFC-AGG-ID: -AZFvQW3Mo6glKO40HMlIg_1742307134
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 916E61956087;
	Tue, 18 Mar 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.34.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23D6118001F6;
	Tue, 18 Mar 2025 14:12:09 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Wentong Wu <wentong.wu@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mei: vsc: Fix kernel-crash when build with gcc 15
Date: Tue, 18 Mar 2025 15:12:01 +0100
Message-ID: <20250318141203.94342-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi All,

Here are 2 fixes for the vsc-tp mei code. The first patch fixes
a kernel crash when the kernel is build with gcc 15 and it would be
get to get this upstream ASAP.

The second patch is just a small cleanup of something which I noticed
when working on the fix.

Regards,

Hans


Hans de Goede (2):
  mei: vsc: Fix fortify-panic caused by invalid counted_by() use
  mei: vsc: Use struct vsc_tp_packet as vsc-tp tx_buf and rx_buf type

 drivers/misc/mei/vsc-tp.c | 40 +++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

-- 
2.48.1


