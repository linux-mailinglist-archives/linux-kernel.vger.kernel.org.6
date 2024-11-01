Return-Path: <linux-kernel+bounces-392913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B612D9B9997
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65EA1C216AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0C1DDC10;
	Fri,  1 Nov 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="MgVFTrxO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EB168DA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493753; cv=none; b=GkMjUkST34suZSZXOYSw/sDWtxWabXqikKAOaZiedM8zyCYs986Yh31yz3aDY/ZttwWwDfTzfUdkTv+rOpaYuBdiDUTV2zvOty9ebbO+HMkC+iWMwuK77v868jqkZzhVgssUhALmVbkDS7VNrP+UkHQrxE2/xkAMt1tDKEmsgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493753; c=relaxed/simple;
	bh=kGTmaZ8VYBva1ZK8P0FOfYrulH2hJ40jqcGH9FPdzKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwfrsVUkCNcraJHQYCNpPybG0YlvP4zxdKOL6rp90l7xq6rAJcK59bF4QkLCXE52NLZ6cyP41rGh1sXQsBkP76R9cxSYkVoVXzG5W9hvfaoQwknM2csJ/39zmkK8dZnCmSnfJ/FvKd2yahwQRPJt1gRlqh63p+Khkabi4cCLXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=MgVFTrxO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43155afca99so20660645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730493750; x=1731098550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGTmaZ8VYBva1ZK8P0FOfYrulH2hJ40jqcGH9FPdzKw=;
        b=MgVFTrxO0jdnA4qPbaTUI60B2/3o4nFRIXdYQ93khw02qFjg8dcVuPREoMimHBZLlZ
         nfgdLWW8tEJeOeveoHFHN7t7pzZLodyLqc5vojc/N5s+GINniba17Qx0FxUifQYatQKI
         hrpN5Fg4ROTDpJNKh4KvkQDt+YVPRgQFTDj1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730493750; x=1731098550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGTmaZ8VYBva1ZK8P0FOfYrulH2hJ40jqcGH9FPdzKw=;
        b=nO63E2wk1sWMRh/1UfQOfIkYIO7/1wmXpgFu9YsNqRdfiaWm+1cixsRtJwV53xThSr
         AF+OxsK1rZSVmDdB6lQP1Zf3PS3z/FeipfykwS1KcikQbxoLfsYW+1isLIJ5Jg4rUhqE
         iZtDPmGiFQUPyrPOgch1QLwU2sZJgrZN1GT6keyjPHJEzqWUKiuff5B00LqMDDb+hSJU
         uEfcT6lHytb43oZI9RzUkEFdcEa2JjG98ZANxkyHcqaRaccTfbmrJzs3hjy70cQzb54u
         A0ncNc72BoQnEjyNMXdm5IV5wzyGjKrDQ/waRshjJvrCKdPceX3PcGfCQyFWyknycsmQ
         r+yw==
X-Forwarded-Encrypted: i=1; AJvYcCWBoD/y0nG3XQl2dQP3XaLgzY2p6SbLAgLYWJOFNIL6clKcZLxtKIeP6/l2adn0i01izvXvnNis1P0g7W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oi3jDBugPkmZxJZxcSm855kx2DRsW40afZEW2RomWR4/fVvw
	QjcYBa3fCC0LeeDMaLXFu4+zp+fc2/JXUIldjxyk4laO7eMzub/w5b0ppyvqnWSp7Zm7M5P9rH3
	xSavkAQ==
X-Google-Smtp-Source: AGHT+IG4YReyiic/m8tENyXAEwrMNkq2OLZQ8QQm5oE4rkpnsmxNvEgR400p0RVB+YD5mceFaOgWZQ==
X-Received: by 2002:a5d:584f:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-381c7a1c51bmr3994044f8f.28.1730493749725;
        Fri, 01 Nov 2024 13:42:29 -0700 (PDT)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edb4csm25014455ad.58.2024.11.01.13.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:42:29 -0700 (PDT)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org
Subject: [PATCH 0/2] EDAC/igen6: Avoid segmentation fault and add polling support
Date: Fri,  1 Nov 2024 20:41:12 +0000
Message-ID: <20241101204211.414664-1-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello. This is Orange from Aiven Australia. I want to propose two patches to fix
a bug that affects my machine with Intel N100.

Patch 1: Avoid segmentation fault during rmmod
Patch 2: Add polling support

The detailed reproduce steps has been documented in kernel bugzilla 219360.
Summary below

I have a PC with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4 in
igen6_edac.c) with a BIOS/UEFI that allows me to enable IBECC and error
injection.

Interrupt seems not working in Linux, but it seems able to detect the error when
"modprobe igen6_edac". I am not sure if this is a BIOS bug or not, but I have no
access to BIOS source code. So I tried to implement polling, and it seems to
work. My proposal in patch 2.

Also "rmmod igen6_edac" can trigger segmentation fault. It seems caused by
double kfree on the same memory address. I tried to fix it in patch 1.

Thanks for considering this. I am new to this area so I could be wrong, and I
might need extra help and guidance.


