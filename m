Return-Path: <linux-kernel+bounces-559110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0197A5EFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CE517A1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADA264A7B;
	Thu, 13 Mar 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnlykSsG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96C2641DE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858646; cv=none; b=sXzvk3zeMnjdlVNxiTEkYWaMvmId6OXpqlbjqgdnsEFvQcpFsIn/m+QEfX2aH8ogvynSLMeYH+TefbES0IeL+dudbC/7r0GkW+nkPpaakz1Y4uSI5K8/E4XzMSxq/ltTIoiA22Oo9+PASA25fPtAUDR8WsNtl4+kXoOp6bzWq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858646; c=relaxed/simple;
	bh=0O9+tvS721NPS5SfhMQUQOXZjZEeYgWVPm6bA9exrc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKGPQuwKHaUWa2tOd926KIWyutQQ/+s7xfVjosRJeq1vX49ITgJ8bNjUxHztzbSV5PbOFWYfNi3LEHa0+ZpnLrEGQKBpUafAWHdwT5wSxq0NTKPG55x0EM7TRy+JQybTF4bYpVmXBGVRIYNFHanoB+Lf2X8Qn7ydnL7MfiaHpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnlykSsG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741858643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TkMmQDKhA8euP7OgbcejyvBbDNEneAYENQsYyU/R2lQ=;
	b=HnlykSsGr88XHoI0UfhMORZGg9f9NWOMmKEPcoa+OsAVd824jiqXG+z5daT1qTTI1VEssV
	HjBsKOgBftQIu5iegcYadiyvn63Nd3KfYsQgsJI0MPSwMq6dpYlOhQIfqpik9NXhMfVFf7
	uZ5uRkOG61D3f02ICwj5WUwOjXsuC5g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-i0oZ1z9tPd6bAgvVvTjkPA-1; Thu, 13 Mar 2025 05:37:21 -0400
X-MC-Unique: i0oZ1z9tPd6bAgvVvTjkPA-1
X-Mimecast-MFC-AGG-ID: i0oZ1z9tPd6bAgvVvTjkPA_1741858640
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913f97d115so367919f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858640; x=1742463440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkMmQDKhA8euP7OgbcejyvBbDNEneAYENQsYyU/R2lQ=;
        b=p/UerHVB00xcuOCpLDatDwuluSe9RqdZNWo/EClVlkW9CMF4uDwUrTZfCsPAoAuqG3
         FvAiGXgG4PjtcFySRyws9Aca4lJhMf+VGDPAoBRDvkReEvMWqDlQ+o35abp43LqYkDyN
         7oeZn0M73djesg1Ux3OhtSnTe2XKZY6U7XoZ/irDDzEtrj+pSC4pFerPDRGbXolb+Gzk
         ewIwhG29BJx45iY8Kn+Fiun/AyoJCcU4dW7kk0P1NLbfIuPnWXFGxHtrI5bn8Ag7g9xa
         abJCrJKPoJCQe/3idj2g0Ejp3tTAy5Lj4wupy3tC0oHWtI2ftMDU1Ndra+5jQuwLAPCn
         OTJA==
X-Forwarded-Encrypted: i=1; AJvYcCW6akvvsA0dz3uX5GqFMF5dOyWZji5aSMHLafXqZgm8FoB/vZFeeHIE02jYVfqDzqMCka3qo+GLntvtd6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDf9UUirPkYxXzxysp3fg6jbQedFpNuHB2cFUdSO/58Oxc2pEX
	UyK8XC5uBsQi6BvBk5Ma8ld/kWk43ewokXNhfyNoykRUdLha6iCfYn+0IeqGwJ0/V8QhsUE5+pg
	/nRh3IElFLxmHkCME0Hkpj20J093j3+wMSUJP7v8SmdQiKHyVQKg1Q4gOxn6EwQ==
X-Gm-Gg: ASbGncsaedcjiyMOgWqHMeH4ZdxP0SaT7KBt7q9O1tUtUISPDV0evl2AF/tlRbkCcnV
	hqrD4lMH3SFB8GZYLHeWnOI4zI7kcsAi5SNK7itW4lChA6wD0cON9Pv3I/gRXX2UEDtsD2pFVcb
	R19jU11cBVwNJ3W+sH8cRaQRyyGPEyTlHK5pXe5Xxh1Hq3Xrl4fYKQnO1RNPtPgxnP3oAJbf1qC
	rXrBcumK7/4zhW/POJvVUTb6vhvSM1E0esv89v7EmqquBwnM0uF6s7Zf1yFd38xPjPUMj15BQBk
	/TBuzRTkpTWkxqdJkpux2zTBEX1vPFoWrCZknB9kEuGs6qhsUQqizpHyTm1+o7TCtA==
X-Received: by 2002:a05:6000:402c:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-395b830da39mr1197681f8f.21.1741858640550;
        Thu, 13 Mar 2025 02:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHvIc+eTQqAlF1+2P3Z2fgggj2iNqsracn6CCyYCJT454xBxSLuaRc9Q7eu4Ab6lnc9ZGgWw==
X-Received: by 2002:a05:6000:402c:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-395b830da39mr1197645f8f.21.1741858640065;
        Thu, 13 Mar 2025 02:37:20 -0700 (PDT)
Received: from stex1.redhat.com (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975d1dsm1531444f8f.50.2025.03.13.02.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:37:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] tpm/tpm_ftpm_tee: fix struct ftpm_tee_private documentation
Date: Thu, 13 Mar 2025 10:37:17 +0100
Message-ID: <20250313093717.69270-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `state` member in `struct ftpm_tee_private` is in the documentation,
but it has never been in the implementation since the commit 09e574831b27
("tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE") that
introduced it.

Remove it to have a match between documentation and implementation.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/char/tpm/tpm_ftpm_tee.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
index f98daa7bf68c..e39903b7ea07 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.h
+++ b/drivers/char/tpm/tpm_ftpm_tee.h
@@ -21,7 +21,6 @@
 /**
  * struct ftpm_tee_private - fTPM's private data
  * @chip:     struct tpm_chip instance registered with tpm framework.
- * @state:    internal state
  * @session:  fTPM TA session identifier.
  * @resp_len: cached response buffer length.
  * @resp_buf: cached response buffer.
-- 
2.48.1


