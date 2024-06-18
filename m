Return-Path: <linux-kernel+bounces-219119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E928590CA16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E86428DBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AF1158DBF;
	Tue, 18 Jun 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep49nxxq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17279158DB6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709113; cv=none; b=pQpiZpd9mr2/+QY9+dmYnJNDl76ZSA0DUua/JBAnG56ciubm3SnO0erHiDp37hiFlpEaDJuTVElnIe7O+7Ah4IH79XH0piop+ezvkIzSkjL7QQiEJ7ez/P/LmRHcvd6P+VfqMTPuEy3CkmOHlq2KiiP9CA4ON7tGe49BDAOIY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709113; c=relaxed/simple;
	bh=W1S57mUzwRb0WhvoSUMHaVgIaS/dkU275Ia1XTEzjGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGh7T02aay2koQR2RK/sN0pyiNJ5c0pIqE6o7lahH6RIRw4unaxLJ50eHi86cHnJFV+42hesoSoIBM2gA3VZPzp/kjKbj4LXDsFdPAAiM3rPqhCBXSctcEbOGQ3eo0a39vSb/1l2caRgyhb/V3dx+CzCcvec4UJiSuB8JZZ425A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep49nxxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718709111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6G2IpcL5Lv+pMV37OGTdCWlYqMHUwgyGxJOKzgKAFVA=;
	b=ep49nxxq5if8VFlMa/GSyCwWGmmVSbFIU9uk40ddm7BCVINNvbmbJPRCet+PTDca8F1Yae
	e80FI/Mqqw2mM7WQAs+d0fVLbKXC4uQI+zG66yqd82w6jubgdSuxh555VypPbcAOO5mmUM
	N56gmTdaXqMgr+Z4xKBBQCBUpAPcwKM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-CkCihvA6PTqmXOh9I8Qdmg-1; Tue,
 18 Jun 2024 07:11:49 -0400
X-MC-Unique: CkCihvA6PTqmXOh9I8Qdmg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9DE219560BE;
	Tue, 18 Jun 2024 11:11:46 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.224.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D80711955E74;
	Tue, 18 Jun 2024 11:11:41 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Petr Oros <poros@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] ice: use proper macro for testing bit
Date: Tue, 18 Jun 2024 13:11:19 +0200
Message-ID: <20240618111119.721648-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Do not use _test_bit() macro for testing bit. The proper macro for this
is one without underline.

_test_bit() is what test_bit() was prior to const-optimization. It
directly calls arch_test_bit(), i.e. the arch-specific implementation
(or the generic one). It's strictly _internal_ and shouldn't be used
anywhere outside the actual test_bit() macro.

test_bit() is a wrapper which checks whether the bitmap and the bit
number are compile-time constants and if so, it calls the optimized
function which evaluates this call to a compile-time constant as well.
If either of them is not a compile-time constant, it just calls _test_bit().
test_bit() is the actual function to use anywhere in the kernel.

IOW, calling _test_bit() avoids potential compile-time optimizations.

The sensors is not a compile-time constant, thus most probably there
are no object code changes before and after the patch.
But anyway, we shouldn't call internal wrappers instead of
the actual API.

Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
Acked-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
index e4c2c1bff6c086..b7aa6812510a4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_hwmon.c
+++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
@@ -96,7 +96,7 @@ static bool ice_is_internal_reading_supported(struct ice_pf *pf)
 
 	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
 
-	return _test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
+	return test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
 };
 
 void ice_hwmon_init(struct ice_pf *pf)
-- 
2.44.2


