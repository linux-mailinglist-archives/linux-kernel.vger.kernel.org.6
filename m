Return-Path: <linux-kernel+bounces-519567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA5CA39E32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C703AA3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528D171A7;
	Tue, 18 Feb 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLicXgCJ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A427269AE6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887174; cv=none; b=FtLhDHNoHm5aGD6eMufrknKppsxpcpKYEb7OQwMrpvP/vR88S9GsS3nBKc4R5b3seCcTx/BrnyRBaFsuRRF5ZKYPWkOdmI4RmBwwZ7fipUmVUo71L/MMpXqfFA6Y8UY5vGrLkFPF5Jl4bk+iSwA1n4li0kPqTl5KWdpdz560ey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887174; c=relaxed/simple;
	bh=8FbOJ0YuzWNREmtL/U0Q5q34IXWjIrhlLf+96xzPrx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type; b=toKvVzPNooaFfI0ZhsAcdgqZjy96vemfQl+yYE2/NkqyKuYGJPVw/BV4vV4lezq1WtYLJSCmxS2CzHnxdKqQqAVP5YuWgPHiXIz1H3F1UdxypggcSO3J9yO9O/GmdhvIiPdIsbF9759rznTGgcbYYGalNendxLspxtA8E8RDcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLicXgCJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so4561664276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887171; x=1740491971; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBTitMHW10mShDDuvyybiVh0MUPGAff1nlPO1Ig+Pnc=;
        b=kLicXgCJV8NiTMGPe9pxIuZSsNBlSNZjati/XDLJa5OEP0aEmCwa/kk+Sb7Nbu0aFI
         nKkUXSkf6XnyVgADffuRPsVCo6Ca5IuOhkZNmL+6GvzWffMBVN5JoVNwvEXMaM7m+zXa
         PXxDEZ0+LvsiNRuFxjP61KCrr8VlHotmsQXUEMBPaEyurcvzC7hDq31xxeq/LHGsRBRm
         Jj15jXv/EqpkyQL/Za01fwLHdPS9/0Dk5o7pK+c4QUyveFul//4u4YGMcB8gfaDohYxm
         km+2VCSOJPodUXfGLLXBXn+BcUIXrO6h6rHSAJLwe4Qm8SG4mpIbNDh+WYknQGCYtTFm
         FDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887171; x=1740491971;
        h=content-transfer-encoding:from:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBTitMHW10mShDDuvyybiVh0MUPGAff1nlPO1Ig+Pnc=;
        b=Bpv+e/PxAidxOxLz5gAPKhfeO0lLyt/VGjVCLHd72WVRiCTIRyZIr29RpC3D1GvgrP
         oyLS/V1qrGNILrClIIOZC8HEnxV3JLDlriYe9Cy2PdhxzeF+zaK2VuxGDp+sg3bsBwgW
         3h8xfU6QzbZbUQgyVp5LLCx0FH6RrxGs12bOrzn3F4pbcLnbbHiFEMuvCqV8i0rvCAQ2
         1/z4+wUoY7QNq5zrF87r6m0MPPQfSlUoLztVyfWjBis/FecgmrSCbWPUJrgRzHvO7cDi
         K8MnNdS17wkQgRTSCGE58mbdvwL4vCFrxikpj7cU5PNLpL13kxJaC5FhiH0gLdka5vuA
         K+gA==
X-Forwarded-Encrypted: i=1; AJvYcCWALdCmz8vLMLg++i5eqjefrhE5dRG3jTd5vurWLZ2fO+w2uZljs0ZDCV0ucvBiW10VD8W0iEb3NaF14B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JccTvXVvNLpeQo55Bn/epbs6l8iXQfvNXpY5essUTx3R2k6b
	luQIaJT7f/p4kwk+K00UQP9EqW7x2hkJK9UInB0sPLpQNbLTuA5d
X-Gm-Gg: ASbGncvMnL6sihMR9ze4Z5dGqZMlp/FuH91/iChjYrbAXoRYgROjG8hUZb5UdOtqF6x
	j0zqqT6G+U63Rwo0kNS8wVAoywBFRqMHA6WpA5xPJpVRbcby1GD0n4lbR5/rFrY0k/ojvtvIxh8
	1KKexAyZ+BpJl2p3BLccalbVJWjjjPYY0DGvetzraElyYkefAy/qdqzfTBRZbU1meGz1Dw8TL62
	Q+RI3aMrTpz40yonFCesgRMh7CHTMQL/XgQyOBUNx6y/fChj+fOz0tpwZjyJ58Dh3Ie5pbuFvcG
	F9RGxjj85siCL3zx6UVIMmFFOEx+HCvFK2BWHGK+0Q==
X-Google-Smtp-Source: AGHT+IGr/7yCTqFWAoZsEW/RB9JqyxCCCoN2i9ai0N6qMixFJeolznestAOTxgZkSj8FZSpKdp3qAg==
X-Received: by 2002:a05:6902:f84:b0:e5d:cbad:c961 with SMTP id 3f1490d57ef6-e5dcbadcc01mr7758222276.22.1739887171310;
        Tue, 18 Feb 2025 05:59:31 -0800 (PST)
Received: from ?IPV6:2600:1702:2480:14d0::48? ([2600:1702:2480:14d0::48])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0d9aadsm3067538276.35.2025.02.18.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:59:30 -0800 (PST)
Message-ID: <381a838c-bb8a-8e95-c35a-343601cbe8e3@gmail.com>
Date: Tue, 18 Feb 2025 08:59:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH] nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
Content-Language: en-US
To: "christopherericlentocha@gmail.com" <christopherericlentocha@gmail.com>,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


In order for two Acer FA100 SSDs to work in one PC (in the case of
myself, a Lenovo Legion T5 28IMB05), and not show one drive and not
the other, and sometimes mix up what drive shows up (randomly), these
two lines of code need to be added, and then both of the SSDs will
show up and not conflict when booting off of one of them. If you boot
up your computer with both SSDs installed without this patch, you may
also randomly get into a kernel panic (if the initrd is not set up) or
stuck in the initrd "/init" process, it is set up, however, if you do
apply this patch, there should not be problems with booting or seeing
both contents of the drive. Tested with the btrfs filesystem with a
RAID configuration of having the root drive '/' combined to make two
256GB Acer FA100 SSDs become 512GB in total storage.

Kernel Logs with patch applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: Ignoring bogus Namespace Identifiers
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers
nvme0n1: p1 p2
...
```

Kernel Logs with patch not applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: globally duplicate IDs for nsid 1
nvme nvme1: VID:DID 1dbe:5216 model:Acer SSD FA100 256GB firmware:1.Z.J.2X
nvme0n1: p1 p2
...
```

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
---
  drivers/nvme/host/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9197a5b17..950289405 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3706,6 +3706,8 @@ static const struct pci_device_id nvme_id_table[] = {
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.38.1


