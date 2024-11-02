Return-Path: <linux-kernel+bounces-393160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA589B9C88
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442361F21F55
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632F13BC39;
	Sat,  2 Nov 2024 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REoosbxb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B713665B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730518045; cv=none; b=Uylum/Og1LlsOIKnPlXJHVJvaUONDxRnkj2hPWlkoXls+8JO6fRGC4P518dhjZ/Iubcw1yYfHYO5Ea1zqVQEo5wCx6SUPHKHRIIqzX4lnYpd1l3xYV8ge4Ls6BiVj4EplPNIzfaEemlHdKxJQ7ly6ofBsW1vwxQAscL0n2dmLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730518045; c=relaxed/simple;
	bh=wOopVkqPDz89zHO/MT7aRO4B5QbAZAlomriP4waWOFI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EE/VOxZM2DGDFe3zhplzC2zgd0zuFF80EyW7h4VLl79FFX7Zgecmt7IpiA+VLXMITuhsgJeAe3Ct/wnvm0P9EhIv0PFP9fgP8DRz6WRSUKG1AwgLg+YHpRvp20U2SqkyFjw7//nsWMp2O1lNNX3e7BbW1l/o22ebZFg038fAhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REoosbxb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730518044; x=1762054044;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wOopVkqPDz89zHO/MT7aRO4B5QbAZAlomriP4waWOFI=;
  b=REoosbxbvQxbxwyUmsXuqfH1Ll/lkicTyStxHM+nbKBocpGgW1SrtJgn
   heZU3yqtpITvtJ33Z+6fai/oiPetghNqRDGJYKsrm2NzXwOS2ho+ySynI
   KY0GlJ33K8D5ag1DoOVliqLFZXw8GJXFZc2vAUkPLj/WZR7zuk/XBWtDy
   XlFSizdu+djbBEW7szc5LCI3VxGvT2EtJEE9oC3KfOc7GKrefgSFrBn0R
   YV3h0kfHtgC6BcD+WX66n9IHwWFg0+NVEGNL44aIEVwvrpdy8u+KUCz9Y
   5non7Y9stpNK5luD5idHFjhStVlBxbzv7R4ISACrWj4qJQMQyd/xXIuzu
   A==;
X-CSE-ConnectionGUID: I+jCCJOpRwCxmA3vQOuP9A==
X-CSE-MsgGUID: Pz6fVZ4GTA6dmcUi/qHkhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="40921804"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="40921804"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 20:27:23 -0700
X-CSE-ConnectionGUID: cddgI1dpSXWJfNMBTxTIaQ==
X-CSE-MsgGUID: k26PeHabSPiRHConRbKTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83241772"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 20:27:20 -0700
Message-ID: <eaea5743-e41a-4055-98e8-5b83e6e3d2dc@linux.intel.com>
Date: Sat, 2 Nov 2024 11:27:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
To: Joel Granados <joel.granados@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Klaus Jensen <its@irrelevant.dk>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/16 5:08, Joel Granados wrote:
> This series makes use of iommufd_hwpt_replace_device to execute
> non-pasid/non-svm user space IOPFs. Our main motivation is to expand or
> facilitate user-space driver driven device verification by enabling IOPF
> without SVM/PASID.
> 
> What?
>    * Enable IO page fault handling in user space for a non-pasid, non-svm
>      and non-virtualised use case.
>    * Move IOMMU_IOPF configuration from INTEL_IOMMU_SVM into INTEL_IOMMU.
>    * Move all page request queue related logic to a new (prq.c) file.
>    * Remove PASID checks from PRQ event handling as well as PRQ
>      initialization.
>    * Allow execution of IOMMU_HWPT_ALLOC with a valid fault id
>      (IOMMU_HWPT_FAULT_ID_VALID)
> 
> Why?
>    The PCI ATS Extended Capability allows peripheral devices to
>    participate in the caching of translations when operating under an
>    IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
>    devices to handle missing mappings. Currently, PRI is mainly used in
>    the context of Shared Virtual Addressing, requiring support for the
>    Process Address Space Identifier (PASID) capability which is not
>    strictly necessary. Relaxing this requirement adds to the
>    possibilities available for user-space driver driver device
>    verification as well as for avoiding pinning.
> 
> Testing?
>    The non-svm IOPF interface is exercised by first initializing an IOPF
>    enabled IOAS and then reading the fault file descriptor. Pseudocode on
>    the IOPF initializing and handling is in [3] and [4] (using libvfn).
> 
>    Supplementary repositories supporting this patchset:
>      1. A user space library libvfn [1] which is used for testing and
>         verification (see examples/iopf.c), and
>      2. Basic emulation of PCIe ATS/PRI and Intel VT-d PRQ in QEMU [2].
> 
> Changes in v4:
> - Include the "trailers" from Kevin that I missed on V3
> - Link to v3:https://lore.kernel.org/r/20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org
> 
> Changes in v3:
> - Adjust wording in cover letter
> - Include "_iommu_" in the prq Intel function names to be more in line
>    with functions in iommu.h file
> - Rebase on top of 6.12-rc2
> - Update my ID in e-mail, git author and my Signed-off-by.
> - Link to v2:https://lore.kernel.org/r/20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com
> 
> Changes in v2:
>    - Remove "nesting" from wording. This wording is left over from initial
>      versions that are now irrelevant.
>    - Dropped "iommu: init pasid array while doing domain_replace and iopf
>      is active" as the initialization of the pasid_array x-array happens
>      automatically when an iopf capable domain is replaced on a device.
>    - Corrected commit message in "iommu/vt-d: Separate page request queue
>      from SVM"
>    - Link to v1:https://lore.kernel.org/r/20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com
> 
> V1:
>    - This is the first version of the series after initial feedback from
>      the RFC [5].
> 
> Comments and feedback are greatly appreciated
> Best
> 
> Joel
> 
> [1]https://github.com/SamsungDS/libvfn/tree/iommufd-fault-queue
> [2]https://gitlab.com/birkelund/qemu/-/tree/pcie-ats-pri
> 
> [3] Initializing
> ```
>    int iopf_init(struct iommu_ioas *ioas, const char *bdf)
>    {
>        // open vfio device from bdf
>        int devfd = open('/dev/vfio/devices/VFIO_DEV', O_RDWR);
> 
>        struct vfio_device_bind_iommufd bind = {
>            .argsz = sizeof(bind),
>            .flags = 0,
>            .iommufd = __iommufd,
>        };
>        ioctl(devfd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> 
>        struct iommu_ioas *ioas = ioas;
>        struct vfio_device_attach_iommufd_pt attach_data = {
>            .argsz = sizeof(attach_data),
>            .flags = 0,
>            .pt_id = ioas->id,
>        };
>        ioctl(devfd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> 
>        struct iommu_fault_alloc fault = {
>            .size = sizeof(fault),
>            .flags = 0,
>        };
>        ioctl(__iommufd, IOMMU_FAULT_QUEUE_ALLOC, &fault);
> 
>        struct iommu_hwpt_alloc fault_cmd = {
>            .size = sizeof(fault_cmd),
>            .flags = IOMMU_HWPT_FAULT_ID_VALID,
>            .dev_id = bind.out_devid,
>            .pt_id = ioas->id,
>            .data_len = 0,
>            .data_uptr = (uint64_t)NULL,
>            .fault_id = fault.out_fault_id,
>            .__reserved = 0,
>            };
>        ioctl(__iommufd, IOMMU_HWPT_ALLOC, &fault_cmd);
> 
>        // This is a re-attach
>        struct vfio_device_attach_iommufd_pt attach = {
>            .argsz = sizeof(attach),
>            .flags = 0,
>            .pt_id = fault_cmd.out_hwpt_id
>        };
>        ioctl(dev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach);
>    }
> ```
> 
> [4] Handling
> ```
>    int handle_iopf(void *vaddr, int len, uint64_t iova) {
>      exec_command(CMD)
> 
>      int iopf_fd = fault_cmd.fault_id;
> 
>      struct iommu_hwpt_pgfault pgfault = {0};
>      if(read(iopf_fd, &pgfault, sizeof(pgfault)) == 0);
>        return; // no page fault
> 
>      ret = iommu_map_vaddr(__iommmufd, vaddr, len, &iova)
>      struct iommu_hwpt_page_response pgfault_response = {
>        .cookie = pgfault.cookie,
>        .code = ret ? IOMMUFD_PAGE_RESP_SUCCESS : IOMMUFD_PAGE_RESP_INVALID,
>      };
> 
>      write(iopf_fd, &pgfault_response, sizeof(pgfault_response));
> 
>      return;
>    }
> ```
> 
> [5]https://lore.kernel.org/20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com
> 
> Signed-off-by: Joel Granados<j.granados@samsung.com>
> ---
> Joel Granados (3):
>        iommu/vt-d: Separate page request queue from SVM
>        iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
>        iommufd: Enable PRI when doing the iommufd_hwpt_alloc
> 
> Klaus Jensen (2):
>        iommu/vt-d: Remove the pasid present check in prq_event_thread
>        iommu/vt-d: drop pasid requirement for prq initialization
> 
>   drivers/iommu/intel/Kconfig          |   2 +-
>   drivers/iommu/intel/Makefile         |   2 +-
>   drivers/iommu/intel/iommu.c          |  31 ++-
>   drivers/iommu/intel/iommu.h          |  14 +-
>   drivers/iommu/intel/prq.c            | 406 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel/svm.c            | 397 ----------------------------------
>   drivers/iommu/iommufd/hw_pagetable.c |   3 +-
>   7 files changed, 428 insertions(+), 427 deletions(-)

With the issue discussed for patch 2/5 addressed by this patch:

Link: 
https://lore.kernel.org/r/20241101045543.70086-1-baolu.lu@linux.intel.com

Queued this series for v6.13. Thank you, Joel.

--
baolu

