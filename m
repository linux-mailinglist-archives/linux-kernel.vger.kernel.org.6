Return-Path: <linux-kernel+bounces-309162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FAD9666E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A8B283CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200A91B9B29;
	Fri, 30 Aug 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQMUxxFq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85D1B5EBF;
	Fri, 30 Aug 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035396; cv=none; b=FpyY8mDmp2G4O/hVcsF6HUdtl/4oGed7ANY1KKYIzYnnPdut98JHJW3ZcY4GaRu5n+V13oEUdOZYBWT2Bfhe6QZ8QC4tvtxQxJdnBT04c6YjAL2XPVTAaME78c/uH1voDI+o4ofjzoxJ5bVZ6aWMPgaoHoFCwZAEjcXgwopoceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035396; c=relaxed/simple;
	bh=H4tEL/wKUTeGTsBkYIbkrgpsvvLWqu/SFnEeGP3qbEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PWqoj6Zs6TbnN+rZe9XuxeaBg7QUcXexzsYcFkx8/B3gzKOgAohDkWNw977ED54MrcAgYsmFSqkxAWJeLINleQMTuPZCyd20diY8bOkBu4gja1uQhjGp+0RCtFs+627U+gTs5XzbbLQUBQKOzrIA4UAclUsMYA68yoEo734apdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQMUxxFq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFwheV013613;
	Fri, 30 Aug 2024 16:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zm2xdyiTIKF7TUHkO8Hw+b
	AMInaS2DNSBUmYzrMY8G0=; b=dQMUxxFqXHq0ltTIoAzyyqRsgDEIMx7GVcAzSV
	YUt9AqwBXdlXomuxyCHj5nCIXjrU0Hs7eTGmB3c2OZvZmMu8g+Af3Q/TMDMAdQZO
	riDrCjF2DDWrES8poyhOMorcvAd8aaumSQqZjBrz4vHkdAsSy5DKmyslu2Pxz2On
	ugk16DqXuMPM9L9LFo391VYXgIGrEvDxLhAJ0izm+W5FLdaMZk2LUUlvFHBFoPiD
	5I4SN41i3+d3wX7HoHORtKORcm9BU94dyUOzl3SfaLR5ukgnBGza76Ej+GW9V/Nl
	1BwykGv8Rwf0dXFWEnZbg3Dk5VCKP49TkS75RvyvAhhk5sMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419px5sdbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:29:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UGTXYA011671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:29:33 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 09:29:30 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>
CC: <andy@black.fi.intel.com>, <aisheng.dong@nxp.com>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>, <hch@lst.de>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>, <klarasmodin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <quic_obabatun@quicinc.com>, <robin.murphy@arm.com>,
        <saravanak@google.com>, <will@kernel.org>
Subject: [PATCH v8 0/2] Dynamic Allocation of the reserved_mem array
Date: Fri, 30 Aug 2024 09:28:55 -0700
Message-ID: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rCTDA-YQlbcHh3Dr9HizDHgOPlKkCOdm
X-Proofpoint-GUID: rCTDA-YQlbcHh3Dr9HizDHgOPlKkCOdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408300126

The reserved_mem array is used to store data for the different
reserved memory regions defined in the DT of a device.  The array
stores information such as region name, node reference, start-address,
and size of the different reserved memory regions.

The array is currently statically allocated with a size of
MAX_RESERVED_REGIONS(64). This means that any system that specifies a
number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
will not have enough space to store the information for all the regions.

This can be fixed by making the reserved_mem array a dynamically sized
array which is allocated using memblock_alloc() based on the exact
number of reserved memory regions defined in the DT.

On architectures such as arm64, memblock allocated memory is not
writable until after the page tables have been setup.
This is an issue because the current implementation initializes the
reserved memory regions and stores their information in the array before
the page tables are setup. Hence, dynamically allocating the
reserved_mem array and attempting to write information to it at this
point will fail.

Therefore, the allocation of the reserved_mem array will need to be done
after the page tables have been setup, which means that the reserved
memory regions will also need to wait until after the page tables have
been setup to be stored in the array.

When processing the reserved memory regions defined in the DT, these
regions are marked as reserved by calling memblock_reserve(base, size).
Where:  base = base address of the reserved region.
	size = the size of the reserved memory region.

Depending on if that region is defined using the "no-map" property,
memblock_mark_nomap(base, size) is also called.

The "no-map" property is used to indicate to the operating system that a
mapping of the specified region must NOT be created. This also means
that no access (including speculative accesses) is allowed on this
region of memory except when it is coming from the device driver that
this region of memory is being reserved for.[1]

Therefore, it is important to call memblock_reserve() and
memblock_mark_nomap() on all the reserved memory regions before the
system sets up the page tables so that the system does not unknowingly
include any of the no-map reserved memory regions in the memory map.

There are two ways to define how/where a reserved memory region is
placed in memory:
i) Statically-placed reserved memory regions
i.e. regions defined with a set start address and size using the
     "reg" property in the DT.
ii) Dynamically-placed reserved memory regions.
i.e. regions defined by specifying a range of addresses where they can
     be placed in memory using the "alloc_ranges" and "size" properties
     in the DT.

The dynamically-placed reserved memory regions get assigned a start
address only at runtime. And this needs to  be done before the page
tables are setup so that memblock_reserve() and memblock_mark_nomap()
can be called on the allocated region as explained above.
Since the dynamically allocated reserved_mem array can only be
available after the page tables have been setup, the information for
the dynamically-placed reserved memory regions needs to be stored
somewhere temporarily until the reserved_mem array is available.

Therefore, this series makes use of a temporary static array to store
the information of the dynamically-placed reserved memory regions until
the reserved_mem array is allocated.
Once the reserved_mem array is available, the information is copied over
from the temporary array into the reserved_mem array, and the memory for
the temporary array is freed back to the system.

The information for the statically-placed reserved memory regions does
not need to be stored in a temporary array because their starting
address is already stored in the devicetree.
Once the reserved_mem array is allocated, the information for the
statically-placed reserved memory regions is added to the array.

Note:
Because of the use of a temporary array to store the information of the
dynamically-placed reserved memory regions, there still exists a
limitation of 64 for this particular kind of reserved memory regions.
From my observation, these regions are typically small in number and
hence I expect this to not be an issue for now.

Patch Versions:
v8:
- Check the value of initial_boot_params in
  fdt_scan_reserved_mem_reg_nodes() to avoid breakage on architectures
  where this is not being used as was found to be the case for x86 in
  the issues reported below:
  https://lore.kernel.org/all/202408192157.8d8fe8a9-oliver.sang@intel.com/
  https://lore.kernel.org/all/ZsN_p9l8Pw2_X3j3@black.fi.intel.com/

v7:
https://lore.kernel.org/all/20240809184814.2703050-1-quic_obabatun@quicinc.com/
- Make changes to initialize the reserved memory regions earlier in
  response to issue reported in v6:
  https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/

- For the reserved regions to be setup properly,
  fdt_init_reserved_mem_node() needs to be called on each of the regions
  before the page tables are setup. Since the function requires a
  refernece to the devicetree node of each region, we are not able to
  use the unflattened_devicetree APIs since they are not available until
  after the page tables have been setup.
  Hence, revert the use of the unflatten_device APIs as a result of this
  limitation which was discovered in v6:
  https://lore.kernel.org/all/986361f4-f000-4129-8214-39f2fb4a90da@gmail.com/
  https://lore.kernel.org/all/DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com/

v6:
https://lore.kernel.org/all/20240528223650.619532-1-quic_obabatun@quicinc.com/
- Rebased patchset on top of v6.10-rc1.
- Addressed comments received in v5 such as:
  1. Switched to using relevant typed functions such as
     of_property_read_u32(), of_property_present(), etc.
  2. Switched to using of_address_to_resource() to read the "reg"
     property of nodes.
  3. Renamed functions using "of_*" naming scheme instead of "dt_*".

v5:
https://lore.kernel.org/all/20240328211543.191876-1-quic_obabatun@quicinc.com/
- Rebased changes on top of v6.9-rc1.
- Addressed minor code comments from v4.

v4:
https://lore.kernel.org/all/20240308191204.819487-2-quic_obabatun@quicinc.com/
- Move fdt_init_reserved_mem() back into the unflatten_device_tree()
  function.
- Fix warnings found by Kernel test robot:
  https://lore.kernel.org/all/202401281219.iIhqs1Si-lkp@intel.com/
  https://lore.kernel.org/all/202401281304.tsu89Kcm-lkp@intel.com/
  https://lore.kernel.org/all/202401291128.e7tdNh5x-lkp@intel.com/

v3:
https://lore.kernel.org/all/20240126235425.12233-1-quic_obabatun@quicinc.com/
- Make use of __initdata to delete the temporary static array after
  dynamically allocating memory for reserved_mem array using memblock.
- Move call to fdt_init_reserved_mem() out of the
  unflatten_device_tree() function and into architecture specific setup
  code.
- Breaking up the changes for the individual architectures into separate
  patches.

v2:
https://lore.kernel.org/all/20231204041339.9902-1-quic_obabatun@quicinc.com/
- Extend changes to all other relevant architectures by moving
  fdt_init_reserved_mem() into the unflatten_device_tree() function.
- Add code to use unflatten devicetree APIs to process the reserved
  memory regions.

v1:
https://lore.kernel.org/all/20231019184825.9712-1-quic_obabatun@quicinc.com/

References:
[1]
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L79

Oreoluwa Babatunde (2):
  of: reserved_mem: Restruture how the reserved memory regions are
    processed
  of: reserved_mem: Add code to dynamically allocate reserved_mem array

 drivers/of/fdt.c             |   5 +-
 drivers/of/of_private.h      |   3 +-
 drivers/of/of_reserved_mem.c | 240 ++++++++++++++++++++++++++++-------
 3 files changed, 197 insertions(+), 51 deletions(-)

-- 
2.34.1


