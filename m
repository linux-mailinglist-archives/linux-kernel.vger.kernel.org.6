Return-Path: <linux-kernel+bounces-237194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E191ED43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E851F21FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F2C3A260;
	Tue,  2 Jul 2024 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="KvYroCN9"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30B3BBE0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889320; cv=none; b=XnNUdaZyC6z4XIdNOW3kORp/U1ZD6W74KLXGkdERh0varEmXwHwEnBZFSdCl10VwfRIIwsaZALmJAFnSDKIQ/tdOSG0N4gQwaUg7zqGgFiNc71ZXUXv5LZ0xX80SnQP46jSn4KH1WULdfiGQlOYuLkJXyOPCcs6cmFOsNSv8Y1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889320; c=relaxed/simple;
	bh=uRis9c+lV+KjT5nqjRmwxBE80zJ+0PYiibFIcTHrRvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2JLkWJAg6kSrGl4dEj2Y80TJ6Bj6zr5unovK19YVKMo15XjOxY2+oYRUFf5hFNGXAd5sug32dbUp85SM9mS9a3H56ENfuVcYTrtVctbAHrVevlzH8T24nWOyklhcXhPwLiV11eLIFJMeqJKpHRDTW+Pa/9YqzbP3498oCzD924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=KvYroCN9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d846f4360cso353388b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719889317; x=1720494117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUAtUfsl0CXkKYEgFlq233RO29hJRLPHCOz3KSrrbb8=;
        b=KvYroCN9/kO4AxHitthuoauC2Lzy/EMNieCZbWAfwkuBLtHvIzugioPdvKV4xZI83z
         SRLV84jtBBGDazGWEYdITHSXGMhXSAOwcXw6orekGtTBkBE5JEHKHGf3jO2+jInM9PGw
         vcyYfsI5bjmpXyTvdNkmPDRbbqRi3l83jXF/Rz0BmXR4oows+uIwD0/FvFUYEkzrBGAT
         wDYqSHYzQhLBf+42VILVtRb+YMc5Shn82yoT0zSFGk3LMc7PFsW+okqhrGNCKut9e471
         xDWCbrCPbKDe//ULV1AZj7GyDE7+9KZEy565E0mc9bt8rupjAmk+830acxrauVGWAjyy
         Z3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719889317; x=1720494117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUAtUfsl0CXkKYEgFlq233RO29hJRLPHCOz3KSrrbb8=;
        b=VJ1o+RH0JJAlw9DWfxdmg+CA+32QwerwgbFX7S+cDbPT8cblP6PGqCp5XsX8GY2Xjm
         CRFObWHZaVG6E3RXvr4Hw9v6HtsTJKJ4QpHqzGmVUp/uizeWaYQg5/IsparGSp2x0OPG
         rh+qCnj0nbr5FOGNR2ykrsPr1cn2A7p3ZHm5PLRshkIjyXX2Df3dmY/Xj+0s2UWKRhce
         Tqk1ulV2OMufAbgyLkwIrcCbgO4hWR917sFtkkXYbmj/AChfNpgj3+OLBTm91P5Sturp
         2KUKcNGL9NjTCCU4o4D/NTTad4LgiIe32GR5GDU0cBmf5DvsmuIewV8MejFctIaubRkN
         XQKg==
X-Forwarded-Encrypted: i=1; AJvYcCWhGnrfA0XoBB4oauzFWv4BeYYQJwiFXId7kZRXDMZNpyF5Irqg+uKktUEGMPcZlJVpB8/XGQUm8XuM7n9zj+Tu3LVUuSpmZurJx/fG
X-Gm-Message-State: AOJu0Yw/p9yXiFqn3+8W80TKjANXwylanb8fx67gmK+WgpXO4eezis2f
	dW7U+4rJvF44HNaVklT+MYx4jN0RJG/hab+fctSyO7ofduUVBZmfP6Yk6mGG3P4=
X-Google-Smtp-Source: AGHT+IHHUUaB6s0Oi9ST9tgc7dW515vCFgkHaAq1noINZIzQYhSZdfTlyGbd5oTc5vZ1rx/1sn2OKg==
X-Received: by 2002:a05:6808:2011:b0:3d2:cba0:f902 with SMTP id 5614622812f47-3d6b35ca4d5mr11712690b6e.25.1719889317231;
        Mon, 01 Jul 2024 20:01:57 -0700 (PDT)
Received: from fedora.smartx.com ([103.172.41.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm4792904a12.31.2024.07.01.20.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 20:01:56 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: Christoph Hellwig <hch@infradead.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: fengli@smartx.com
Subject: [PATCH 0/3] scsi: disable discard when set target full provisioning
Date: Mon,  1 Jul 2024 23:01:13 -0400
Message-ID: <20240702030118.2198570-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

this series has a few fixes for the scsi discard mode changes.
The first disable the disacrd when set the target lun full
provisioning, the reset have some cleanups.

The series based on ("scsi: sd: Keep the discard mode stable"):
https://lore.kernel.org/all/20240619071412.140100-1-fengli@smartx.com

Haoqian He (3):
  scsi: sd: disable discard when set target full provisioning
  scsi: sd: remove scsi_disk field lbpvpd
  scsi: sd: remove some redundant initialization code

 drivers/scsi/sd.c | 34 ++++++++++++++++++----------------
 drivers/scsi/sd.h |  1 -
 2 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.44.0


