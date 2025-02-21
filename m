Return-Path: <linux-kernel+bounces-526332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4FA3FD53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C099A188EFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F142505A0;
	Fri, 21 Feb 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sD8XtQWR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CA1DC9B0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158602; cv=none; b=aq3NjLuqsbwb4VY1uulh0k0PHIJDX3lIxOAqdPVxPkDA/2DLSzXo49762WYShxtjoABHfjOvAPkweGitaYCdxmxCcSYKOU556gUpLtYo8H+dy32z9X7p0oIMj0o5l3wRKEyC/OtkMa1Q4oinAngf9NqIgEQMB3X8U+IjUQAC6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158602; c=relaxed/simple;
	bh=v4umuejnk/D3zo0ZfQeNhQtPg7rv/6gl7bzNW+Mvmew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seQdHJMmMc7CkL12VrMvqctL9iCcRHw9IusSg2REBaGlOef2/Z+tq1pZP6eoyg9UMrgvSAwtbHxSC/aMSeGB7Iw97wTffg3nnAv88mBUyP11PFaWlw1rlUARtM6kbCXfjdoaD5DaJHUkQxaghhuqEb+YXy0ekkUnkxGOp0pYoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sD8XtQWR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d601886fso37243435ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740158599; x=1740763399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAC237/i2ojW1+/RqYj3Hliw8hADl+1Y8oHlt264UNY=;
        b=sD8XtQWRDfOG7PdnJ8+GIluw7fyUI/fO7V6CXLU24CAYbsOCRVfHQ4m8iIrwm7zQs5
         jbz+6bzfFi2WwT5vuO3ATpJiiEd0/lsUCR2hfpsPK5y+EBO7qe4HAxuNwALl8Lui4j9N
         pselkXbJC8utrEZWA4aKAGbvTwmyZcDDfo7OIkBlmROyEWTrISKWsFCsPa7e6+tc7DEl
         KXc8HzrhsPx7Y/DNQ/TBrPC55KDNoLYrUdyn5FfDi2v3jzZTuBQU/zwaC/rFUfoSxkvm
         rGIsdprXC4KHZXGL4ci/gy+s2MKGRn9iwmyuBXYKK24ZikY8IBfbsWah/pwquETiM/IC
         vV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158599; x=1740763399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAC237/i2ojW1+/RqYj3Hliw8hADl+1Y8oHlt264UNY=;
        b=XW39eFsm98QkGPXBITWYnhL1gF6FBnugcfuldaaqruMoy6huC1Bccq3WOdS5bCHpFh
         MH2UEiVdBDLd5Amq0XMjH5Q5BdUwtktUgCM0UFLfGOrhOdWP3cDsMp7FyZIyUjKB7nyh
         OyKkzTgHQMQvFJddr2phexTm9wu637OPsiBnCTv6nRYp0wPiqKVBY5AJT6bHvSuujpZV
         wp0knFb4szRc+3MWmVqamxJ3hxxYv1PkE3LD0Z9y3HbPURzr8pP8aqfWMXjoAnTp6NqH
         F5OwxDh9ts4dqVZ6aOqgAY+i5Wv66bFi+ztWx1KrB/iZXSxZFdqtsuMjkp0aZOyJw7rX
         V8LA==
X-Forwarded-Encrypted: i=1; AJvYcCXMZizs+UVy0IG2S9wfBUb+LHwMH5cFYNchpyfzZ8YcusW3dGASxPBKzZ83hdkr2i8dZDCdsrZawPAknUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9XN+TigOe7sCWs57AsHMEW0rGogG2pREi/kiLz0XWtzzU2QK
	ZlB+wWIzD3OmrGkcmtrBFZahittDVHLss+UH945il2yqJ0al0C4MG1CD/bUasg==
X-Gm-Gg: ASbGnctb+dVunPSK5GWaObcLehh05yLZ94IUMn4r6Gny35U8xRmwjaYVys0at4/RzNy
	vo/ACtzVPWwyJ+FRyl9aTRhObfGm6QDwXKdFL/++PdarsIPa8ZbVypYehO9twJ++sWu8SxzIGAs
	VvK0kOAdnOkl9OweLImy3n58Eig+sEQIyWF5/12E7QqoiRGqvHM2MEzOdAP2zoEGWZ064C/S0Pv
	vi41C/WKzU8ShQmJeekSqrvmjdqzIp5V54FRKboN+WAzEOsoPEQXeT8RfqPipQW6GPPtzE/V6Q3
	1mNH4yNpLwnAcBfjkXcwsOjg/ElmVrUPCRh1f6cLCKPVLoXQNFRN
X-Google-Smtp-Source: AGHT+IHRjJdp1yc9JTT15Y3zMSAcEmsTgJkEW6HFHwdSfI5yIExfixz8/4XmLd1XnVTnm6VlmGZZ7Q==
X-Received: by 2002:a17:902:e88f:b0:21c:17b2:d345 with SMTP id d9443c01a7336-2219ff30cb1mr55376785ad.3.1740158598987;
        Fri, 21 Feb 2025 09:23:18 -0800 (PST)
Received: from localhost.localdomain ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm141243405ad.148.2025.02.21.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:23:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dingwei@marvell.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: Add support for handling link down event from host bridge drivers
Date: Fri, 21 Feb 2025 22:53:07 +0530
Message-Id: <20250221172309.120009-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for handling the PCIe link down event from the host
bridge drivers. This series moves the link down event handling to the PCI core
(atleast the generic bits) to prevent the host bridge drivers from retraining
the link on the back of the PCI core as done in [1].

Also, the newly introduced callback 'pci_ops::retrain_link()' could be extended
to recover the bus in the case of errors in the future.

I've implemented the 'pci_ops::retrain_link()' callback in pcie-qcom driver as a
reference.

Testing
=======

This series is tested on Qcom RB5 and SA8775p Ride boards.

[1] https://lore.kernel.org/linux-pci/20241112064813.751736-1-jpatel2@marvell.com

Manivannan Sadhasivam (2):
  PCI: Add pci_host_bridge_handle_link_down() API to handle the PCI link
    down event
  PCI: qcom: Add support for retraining the link due to link down event

 drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++-
 drivers/pci/probe.c                    | 34 ++++++++++
 include/linux/pci.h                    |  2 +
 3 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.25.1


