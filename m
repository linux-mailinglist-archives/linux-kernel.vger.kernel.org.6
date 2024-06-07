Return-Path: <linux-kernel+bounces-206575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E1B900B9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3BBB24549
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56819AD90;
	Fri,  7 Jun 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLCAU4lo"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026319ADAD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783069; cv=none; b=C7UL10CFX8nR9eKG9YAlS83yMmDVgIC089v1bmM5h2VQ+uNuqY77t3+AVpYA2DY7CYaZH5Rqxf9K+TY8ram7+0l2Vvr9kgkbvxI1C3Qn0UYyeoet/F2DB6RGTFtfi7Z5rpqB1/8QkbUR1LLtClORZlXfkIbKA4RgXx6R2vx/9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783069; c=relaxed/simple;
	bh=8M5R5sbddtd+EtOHByWpR1T0myw7qJde+U5UKaenM9s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P+Hbx7WEQ+2dY62BZ11AGDPBDfc9QW+3LrGoL7he5exg0893XnE9d9hhpyFNY1mGBCrRyX98uuwAJjkwnsNozSmnejV2GccxOEafzkpEj90wjd07z/+0+JHaXHYEdEpP5c8Hfi3BZyKGC7ergKMD7povGTfzHECnXCoFqORvBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLCAU4lo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70241b2ffd1so1558106b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717783068; x=1718387868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ESs0u2tV++sCsmPbje03XNCRerEoVavzKTKXXHcLNgU=;
        b=vLCAU4loTbwb70nyZMaWvGFRqe1+GiMoINGXhCprZxg1fnSSuef925PWaHY3D3nia9
         VurQMZl9XGMpnwj+KyzcBESavrTqSvAgGcn+/ituCTOyBr4LS/4aj2ByGyc3totpfZxJ
         f8cx8a19XLMlQNXQd8fRKhReqnMmfNd2wMcoccwy+3zXpVv0inyZFDPM+JulKBE75OQ5
         5VEZOOjiCstWj2EPzmlJeY6uzEdgN9MgNefscGB317a32Weds/vnJ4p1yAn/0D9eL+PM
         5syvzqYAxk09INI5enrGwngnf0QDGC1qJEmgs01Ab3mg8UTPy/7Mj8c/XOV/qFuSCqjh
         P0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783068; x=1718387868;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESs0u2tV++sCsmPbje03XNCRerEoVavzKTKXXHcLNgU=;
        b=iG4RnIaX8Cocd2J4wVIG8BdEr1DnkGAifh7TFN4oS/nK4KyzHG98X6IjjkvgHmI7P+
         U5+ML9/3tUpgh/ID8u7j/rhONSlSAwwjq05vKaZJUDLENSZ1UCLKpZqS02ZC96n6IzZg
         Nip1QOj9niqqZs6YvgcAvNtT90KCU4Cp0uEyTeFpJRIXdSSz8yop+RYlSDuqeNhGr4pN
         LYbqmvBLPNs/1krNWyVbJ+kEHyMQNCjwYLQCLRwfQTyvM0rt8nJ6qd0eGWh1xAkYnqPG
         Bzt5geHmO2JPdptNSXyOyqVPTUxFpQh5RXRKK/0cWkgRwX9SE2HN3KPejwsLUMkAbXLH
         FJmA==
X-Forwarded-Encrypted: i=1; AJvYcCWxjMMPQQkWrfgV3T3DBr6CutB5FuSUxa5xxz113ryIiYcrCxG18AEy4Pw6eFG93gEMn1DHoJGP1mTpQJaWhtONZ+nIktuiBFE61f/c
X-Gm-Message-State: AOJu0YxgKC8A8m5mudTDbtpWL/zSA/5rU9qxHKUtiyQspMT7/8wqI7MV
	KP5GxFcBilHA0UJk5+1lrwsUgG5Sc05y8biV6O9L9QFKNxTxIh/ekNlV9PH3AyJH28u8lxWPt7c
	M6JzazVrabg==
X-Google-Smtp-Source: AGHT+IHrD7lGtUhyWnPgie2iMfmsGFX6Ir3Nqf3BVkCOrhxNuWKJNoWk3xiQ53pt5TEKfPDDHGYsDCIlWh2mng==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:177c])
 (user=tadamsjr job=sendgmr) by 2002:a05:6a00:92a9:b0:6f3:8489:90c4 with SMTP
 id d2e1a72fcca58-7040c741e69mr9712b3a.3.1717783067393; Fri, 07 Jun 2024
 10:57:47 -0700 (PDT)
Date: Fri,  7 Jun 2024 17:57:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607175743.3986625-1-tadamsjr@google.com>
Subject: [RESEND][PATCH 0/3] small pm80xx driver fixes
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

These are 3 small patches to prevent a kernel crash, prevent ncq from
being turned off accidentally, and change some logs' levels. Resending
because I missed some recipients the first time.

Igor Pylypiv (2):
  scsi: pm80xx: Set phy->enable_completion only when we wait for it
  scsi: pm80xx: Do not issue hard reset before NCQ EH

Terrence Adams (1):
  scsi: pm8001: Update log level when reading config table

 drivers/scsi/pm8001/pm8001_hwi.c | 11 +++++++++++
 drivers/scsi/pm8001/pm8001_sas.c |  4 +++-
 drivers/scsi/pm8001/pm80xx_hwi.c |  6 +++---
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.45.2.505.gda0bf45e8d-goog


