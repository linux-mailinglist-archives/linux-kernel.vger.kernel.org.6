Return-Path: <linux-kernel+bounces-569825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C2A6A7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EDC7A7873
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263402222B5;
	Thu, 20 Mar 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="On/C8O9r"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F56EEBA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479690; cv=none; b=RobkEvXzwcheCaBXoYjlI++xprubi91s9Ek07V5S2yjDYTRPBr/7Pad2eXwU6qep6KFh7osjdkc6ptt4HBMuFvTqvpnbS57IspkLp8vRgPuDXjQ0oGxh8X49XRYQtzGXucvx50IGOFbc7mxu8YvlIvOs08zy7hzqaUqrEjmyMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479690; c=relaxed/simple;
	bh=L0Ns8xc3Q3br2dzt9w3k8ad2LcmDXSY7pM/vbS+5JgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihl6zHnYhr8x2yvcjnibi0rXtCSv5i6wNNajW6srG0BJonk7iIUN/tqRL6++L4DyVJuK0vDXX3g7rUWyL6xP2/lPbkCe4ffgPtpOZWgVRToE8C4pudBlvjkaVyOqAdfO2nPVgn4XOuwKINMYYVSA89kZmG7oz7wBbRSeqBBNjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=On/C8O9r; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549b12ad16eso948353e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479685; x=1743084485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GW+AIfrfnZlEZ1i2OuNqT9lfOEs4AghqG0/GPy1/W3c=;
        b=On/C8O9rXttjcYWYlOWQy4uTRiUWM0xg4khUKT1PVzl9wCvMe9bj/y9u0NcPEM9t3R
         AGes0+esE1XGt1N+lpskxCKptKiPLWCrdED4dPXwpty+E2ihF1FjpMzytzq0oY2z0CSD
         khOYQW3nMnfKbyF+VBdK29DN23yo8+YSV24KD9Np9QAt7R7GJeGlZTDtsQ/Gw3/HUQag
         bd5SIvmTpjCzTfmQnRVy4RMHe8I6XFpz7YvLpVcao/UCxFaMpksC6qU49h/l0RjbXgHk
         EqtO9QEceXf60YVqMpyFmI3ZiUQD9G8jLWp5zHq2a9jP3u3hQXYgOAzPAVMSGwiOhSHb
         hwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479685; x=1743084485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW+AIfrfnZlEZ1i2OuNqT9lfOEs4AghqG0/GPy1/W3c=;
        b=pmq/eCikpkAVoXAIJL9HsuUUMooz9Mui6zkQ2IpcdogId5nT++GCmKkWHkuKNn+hQW
         FRGNzu57OYe5/IPuiWetEVYcuWIVzUdmnTAnon8HR9D4Fm3JdHCy2Qsp44FBltwRJQoG
         JFZq/CprvvKKSOsKH1WAqPScP5AkuDT/0a6eXY16FwdifmQz4hD9V9a/MdN5usaEdPjl
         SsWKVQjHRCpFu9XBEhkUGFSacsbB7hpmx6FERQMLzJqe5XZbFqsglKbYzIYyEh8cOHRg
         s+F2UojxwC+lRSgZidiYg+EYHQy2+gnl6A6g1aQdchwbvYLNr/QNtUwkrSaKZEVmFXv8
         kXng==
X-Forwarded-Encrypted: i=1; AJvYcCXa8cNfEk7V0ETI0JLYmhgK4aiZ0p38g6C9GN6UlYJ/a+muDj5nQRYbi+xDl0OkQauUQVhGYadzjaShGZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNMRrrq0wpbdKQi1hbrviPp1GS9Qg853LwrHdSnkk4yEU5tbH
	LQsZcxqLTqvbCBvLFEOddeC8j/zYZQP4R5gGpRtuhzl054WeRtaPgLP3avJaHDWQ6OdbUYXsVv8
	q9HCS9iVYsk9JOmSKuuif61t1jBxCq1j+ZNjigg==
X-Gm-Gg: ASbGnctnb7kcA0CDbYJnombKc1Y4HsntzUsbw8dfUFCKFuJHF45a2pBOYpbyq/rxHrY
	2AyDF+I2VSpZPixkG1vOIUWj0hZ3Wjsl/hS40d21Mm0FbP+fZ3mE4K8s8Dd5HrYN8Z0qPYJjIcN
	EWARjhcXXTTNT4V3MlYLCoYB4Fqv+bDxs=
X-Google-Smtp-Source: AGHT+IE0nZc36emahZKbVDAnCMDyH/ywSdu+VkMSO0TuJrJF/3VJxt+BWvKKWZTm/hV640C6sCQwdH4kYd9L7GQ0dLg=
X-Received: by 2002:a05:6512:238f:b0:549:b0f3:439b with SMTP id
 2adb3069b0e04-54ad062afbbmr1432242e87.16.1742479684999; Thu, 20 Mar 2025
 07:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315101032.5152-1-zhangfei.gao@linaro.org> <20250317011352.5806-1-zhangfei.gao@linaro.org>
In-Reply-To: <20250317011352.5806-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 20 Mar 2025 22:07:52 +0800
X-Gm-Features: AQ5f1JpZtpDjBufurDoU0Dm8aec8lXWg1YWzfL8ksZ4Km8I3bD8mNe2JhE6E6Y0
Message-ID: <CABQgh9H3POdKGsphA42C+i2_z9xCHHfSm4ULkMVmFyKBm9bWtA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
To: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Joerg

On Mon, 17 Mar 2025 at 09:14, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> probe path") fixed the iommu_probe_device() flow to correctly initialize
> firmware operations, allowing arm_smmu_probe_device() to be invoked
> earlier. This changes the invocation timing of arm_smmu_probe_device
> from the final fixup phase to the header fixup phase.
>
> pci_iov_add_virtfn
>     pci_device_add
>       pci_fixup_device(pci_fixup_header)      <--
>       device_add
>         bus_notify
>           iommu_bus_notifier
>   +         iommu_probe_device
>   +           arm_smmu_probe_device
>     pci_bus_add_device
>       pci_fixup_device(pci_fixup_final)       <--
>       device_attach
>         driver_probe_device
>           really_probe
>             pci_dma_configure
>               acpi_dma_configure_id
>   -             iommu_probe_device
>   -               arm_smmu_probe_device
>
> This is the pci_iov_add_virtfn().  The non-SR-IOV case is similar in
> that pci_device_add() is called from pci_scan_single_device() in the
> generic enumeration path, and pci_bus_add_device() is called later,
> after all a host bridge has been enumerated.
>
> Declare the fixup as pci_fixup_header to ensure the configuration
> happens before arm_smmu_probe_device.
>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Would you mind take a look at this patch

Bjorn suggested
"I think there's some value in keeping fixes close to whatever needs to
be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
to merge the fix the same way."

Thanks


> ---
> v3: modify commit msg, add Acked-by
> v2: modify commit msg
>
>  drivers/pci/quirks.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f840d611c450..a9759889ff5e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1991,12 +1991,12 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>             device_create_managed_software_node(&pdev->dev, properties, NULL))
>                 pci_warn(pdev, "could not add stall property");
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
>
>  /*
>   * It's possible for the MSI to get corrupted if SHPC and ACPI are used
> --
> 2.25.1
>

