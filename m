Return-Path: <linux-kernel+bounces-412570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8219D0AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267AE2822C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA3155322;
	Mon, 18 Nov 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZU5o1jXk"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC391DFED
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918237; cv=none; b=R1ARLXbIEtbiBd65BqY60pKkb97xans74LxeObfR+8+JXM0Y+9JRPUCwTdHRbO+OkaLs62dgEFSRvcVc22IddlVkh5Dg3lOAI3Zii9YIXTDJvRoU2XJnjW40R6NFuMC2H5W7VhQrFeX7NMCDdHHl0WLuBx6oOH7ATr9SJ83kdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918237; c=relaxed/simple;
	bh=UCqjZDeI9FpJ7I3dSZ3gFuZ2wbdMuuE/PwssuNWZGzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lKEw3pDKP+XueaZlzQkwBHq2/BI7m9UDfiX0QXM1IumCfpmtZsqHB4fFNFJt7WMGIcqvvVFLaTnkLWFpk4XcAP3rCBM29deT7AGZmcP/qgKp9KnrZ9Ar5PvHtL+iwAh2V2oNOsAi6dNLJtJEKFPO36dG5Qkwxf76uK6u/iwS3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZU5o1jXk; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebc52deca0so836327eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731918235; x=1732523035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCbk4TlfvzPjOdLFFqTGjXfKYNxdwV9cR55qDByjVYA=;
        b=ZU5o1jXk5NLjXIi2XWPtmo0oVyxuUMRnwyu6b8eAeqSbq7hMeJ+mYT0mHFLtqz00i9
         osUkpzXa8PwpMY3aV9Ie2SfksNLFJ3eRGjBGE/KgI4u3qHz3iMFoZAeqoCkJY8u1W+W2
         i2F9tnErGk9sMcBaTEcbjcFa2JSbVyK8gkqA16Q0v+vmTctRYsHLqCcM6YHDRNq3CMDH
         YVfbiUp9vXikxA274BoBLhW40+7umrY+c3HRM0n0B1mMrhIAAfapdba1/E/snIYn390y
         L11NEALRMgOA1kwuxh3T/fakqDe6V/+BVlcGZjiPNQ+Ir5xBnlXUh8PtxMfjR2SwN5ka
         92uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918235; x=1732523035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCbk4TlfvzPjOdLFFqTGjXfKYNxdwV9cR55qDByjVYA=;
        b=pTKSvY+TGOGqDbtN+4LiF3cUUc9P1pAXHY/oYDybEdS3+3QFs+BGw5D6fBxr7k9DU5
         HDXZJfzFhx4j+TikDRxvB5mCBM8b5Y2bWNT1d1ddJlgk2qjJVvhVPYAe2IyVGRSIJ4Gy
         sQ6hHD3pIMhJl9cgddU8QhbFXua6CTw9sspxQ43M6OxRGHyxM5k5avWY8MioPVcSBVMT
         T4o6xQ/rnQnT8cmtxaCG0Bxq/CrpucdPiooCPW60u2FrRBMGbomUCqykdoKEFVfxJQOE
         uXYTiygl+nAbUzWz4M+4y0OaSHeP8xWQHJAZG2MJRfPZKe3qCGAfZvL7s+v/7jG6Jr+s
         Rg8g==
X-Forwarded-Encrypted: i=1; AJvYcCU8/hgPBlIeTeZ3IwSkY7pbxN+LTRHPdwuXxwYguoD7NrctTXnhSvVaf6YIwvPP/ybJCwMNoJkbpQfzpo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywga6udng+rsoqUdldm96GpvbFT5a6XuZ0lWqvEQNsYcAdpTqes
	2zshMes96CjVCGufyV5aPsjtZChwxOrJk6TFlg1ZwzSPI/wWR7ARX4VCc9Iifg==
X-Google-Smtp-Source: AGHT+IHPwdoIIv20ZBrWH7DKZTnWpFwfY9K/rbsdLP8Ornpdb2oaHhsxCXEpXC4AlEb+sqMy9L4wzg==
X-Received: by 2002:a05:6830:4708:b0:717:d5c6:d593 with SMTP id 46e09a7af769-71a779ce2e0mr9736978a34.21.1731918235394;
        Mon, 18 Nov 2024 00:23:55 -0800 (PST)
Received: from localhost.localdomain ([117.193.212.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dac1f1sm5350101a12.68.2024.11.18.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:23:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
Date: Mon, 18 Nov 2024 13:53:44 +0530
Message-Id: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI core allows users to configure the D3Cold state for each PCI device
through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
to allow/disallow the PCI devices to enter D3Cold during system suspend.

So make use of this flag in the NVMe driver to shutdown the NVMe device
during system suspend if the user has allowed D3Cold for the device.
Existing checks in the NVMe driver decide whether to shut down the device
(based on platform/device limitations), so use this flag as the last resort
to keep the existing behavior.

The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
D3Cold and the users can disallow it through sysfs if they want.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a..a4d4687854bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
+	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
+	    pdev->d3cold_allowed)
 		return nvme_disable_prepare_reset(ndev, true);
 
 	nvme_start_freeze(ctrl);
-- 
2.25.1


