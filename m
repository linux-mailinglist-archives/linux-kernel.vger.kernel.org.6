Return-Path: <linux-kernel+bounces-549285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91623A55050
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E6B16F0C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820421507C;
	Thu,  6 Mar 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5yQUrXa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D22147EB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277444; cv=none; b=csQ+j0Ylw1z5BMYYIyoPCYMHEsIHgFgbtJ0SZlsOGtqiBAoJU+HPRIOAyaok+kZUxD/S1bKQ+fGlIV3hC1HbPwNfkcJUK051hB61tXsjdc/j8EXePtLm5cAtn1IMJ/yfWUpSAIBZWs11IhnZdgfi+XCmr7DViALu9AuUz2Yv4xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277444; c=relaxed/simple;
	bh=0hhfLP3N8asA/s0wef0L8K3outHWOZC2tvRGZLxMAa8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uvHWeClPiQky+2jIDuYUa1gk9WicPwbn/tN0uHyXis8NUo5Z4vJcYs0cFKYGZJ/yKTf7gtPE9VLQOfqMMDL4e+fDqcin1FXyrmCPR5x5mdjJwl2Yl1BH0KyVBqA/bM2lck7uv1V+xNmqjPLmudXtmb+4ru/BtHHFpmndKEdP1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5yQUrXa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h9R6KO2tPUArbtew5KJP6KvYe+R1MIMLdE3yjt20XBE=;
	b=f5yQUrXaX+TV5z7syLQuS/CBpPxqj5+SwuDyLuHtoysf8duTNWAWRe2CNGDj9HiF39W7oL
	YSaSTyi8trkKAwOGt+kj1eAycnvZv+pK+9MfUGytSihSvkTV/KiRSIWOLf085Ua+aovXuO
	lK5hznPLuBjewTm8yZpdaAbxVb5pGzI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-3wMQYfiaMV2fX6mWfZGlUA-1; Thu, 06 Mar 2025 11:10:35 -0500
X-MC-Unique: 3wMQYfiaMV2fX6mWfZGlUA-1
X-Mimecast-MFC-AGG-ID: 3wMQYfiaMV2fX6mWfZGlUA_1741277434
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912a0439afso344368f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277434; x=1741882234;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9R6KO2tPUArbtew5KJP6KvYe+R1MIMLdE3yjt20XBE=;
        b=lOGlturjhQMqYk+cBWJEf0wQXHU/dA7ed/yuLoGxdu0LrWnx31SouHzeT7FkXwkVin
         sE5y5s+EFZz8kCLQbmkQOMYYIWonCuRlICDijCkAgBkmR60MeWG/gRWSOyXf2ek8REhE
         d3CA09YeoM7QeiX058c3MKKIrMwbh5pxyhRHJmTiujQzFc4KvS+tSW83lWhEwrmdgZkn
         lx09dK5KztvPlgHhMHth5zmfkh5pQgOlQsBLXuL57XtpeVsQ4FbFSeUCKsPgKu/zmTIo
         bbKJkuWNGYkn39Y3DXwOIu+nS8xkNMmYNTHP2dU3pPeXjwkldn2ORS1IM9nThYoG36d9
         dZ4g==
X-Forwarded-Encrypted: i=1; AJvYcCW01olnsn5yHj7UgTlT+W2LD33KA5SOFzareg4Rnofpbn/ebTO/DP84l5zKcF9utTKfndotVVLHwTCoZU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GgqI9Z/GU4nLJzRHn8NDPmrgBFiVeSnwwlY2Skrh7NzKx0rL
	83yzTQho1nT6HVbktAY33vQ+/DjfU8xt0mvlAUxqhWqa1hHBwQeypAsMOQoNHXXf5CBKgZcw7V6
	K7UePUpGYCl1p7ef7GyvLG9jYt4UvQ2oq9e+9c8UFZoWxfHNGzVTpVjrMbMU14Y+OGv4+c08EOJ
	BTYQvCA3Qm23jFzz399h3c9ANfLSSswdCPw8bNaheMDF5HHg==
X-Gm-Gg: ASbGncvjVZz4KmWawf1Kmc04ObLwGu5tAcn7fjmv6MtOzw3GbFU5FOpZU+5juxz5z4W
	6RylfnZBZMfMkMuJEZdjXl62vSx4zX5GqgmtrbgTsomw2YO4jMoC5jBgeR+0PwdGc2tpZvCaQe4
	8ktd58cTl4HlRMvx4t8v5VJbAW3CS1cIHtl8Uhsi2I1XAudYBKpenX620SGb19z4gyQLF/URoGX
	AcKzSRP74hVRBbA6OwzLcx7drloPon54mrxKpP0LczkaOevy4/3ATgMKiRE50qiSEoPCCVOIqGO
	AySXpWCFTNYtNBTDsOXT0uRzuqCVxpFqC8uE8YaK0Tfo
X-Received: by 2002:a05:6000:188d:b0:391:21e2:ec60 with SMTP id ffacd0b85a97d-39121e2f137mr6709205f8f.13.1741277432164;
        Thu, 06 Mar 2025 08:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5FYdKhrDKr9VvnLfqFE2SB8FkjwaLOL6xy8j1ciLMt8nkQQ/xfgfFd014KVDm0o+whtJTTg==
X-Received: by 2002:a05:6000:188d:b0:391:21e2:ec60 with SMTP id ffacd0b85a97d-39121e2f137mr6708970f8f.13.1741277429756;
        Thu, 06 Mar 2025 08:10:29 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm2477950f8f.52.2025.03.06.08.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:10:29 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next 0/2] vsock/test: check for null-ptr-deref when
 transport changes
Date: Thu, 06 Mar 2025 17:09:31 +0100
Message-Id: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALvIyWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMz3ZLU4pL4suL85Gxd41Rz80TLZPNEIxNTJaCGgqLUtMwKsGHRSnm
 pJbp5qRUlSrG1tQDg1LkFZgAAAA==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

This series introduces a new test that checks for a null pointer 
dereference that may happen when there is a transport change[1]. This 
bug was fixed in [2]

First commit introduces a new utility function that checks whether a 
timeout has expired or not without exiting the test. This is required in 
the test because timeout expiration does not mean that the test failed.

Second commit is the test itself. Note that this test *cannot* fail, it 
hangs if it triggers a kernel oops. The intended use-case is to run it 
and then check if there is any oops in the dmesg.

This test is based on Michal's python reproducer[3].

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
[3]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      vsock/test: Add new function to check for timeout
      vsock/test: Add test for null ptr deref when transport changes

 tools/testing/vsock/Makefile     |  1 +
 tools/testing/vsock/timeout.c    |  7 +++-
 tools/testing/vsock/timeout.h    |  3 ++
 tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)
---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


