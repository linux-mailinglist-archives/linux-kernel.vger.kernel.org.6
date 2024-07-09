Return-Path: <linux-kernel+bounces-245022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE992AD1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBC1F22132
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B754A0A;
	Tue,  9 Jul 2024 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pP+T8rJs"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2098.outbound.protection.outlook.com [40.107.212.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2B139F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484887; cv=fail; b=M6Z6c6sw1+LjNfp22z7NmAiEcxtbsfBk9GnHMNnG2Oa25O53YbgAFNKu9d5DB9tByqot8MFe5vCNw8guDIvbBJN869mWW65f10uDe/UnKc+i/eJiGphqKF/E/EncIB1a7X57p4ZT4lmdS7IYBvcAMfe1Phv17R1gK43dVCOx8vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484887; c=relaxed/simple;
	bh=TDPKMNf4+fbsZ4OcxWG8OHjtzHfBgqtASDRMSl15C2s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fsdZ4nMgn+pjF+4/W+2Vcgpq1aX+c2IAucv0awkW2mV6nBYJ9yJrPqZ5LRDrPc2uCHvFywG8uAqX8jpzFgeSLsT74zj7usOAQlX+/Dk+5uIgAcQiXgBeHQeafAN3IN2x0CY0mF6mM4jkHN6p84gYitmVh6OIx1YSk3kW/yZfJ+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pP+T8rJs; arc=fail smtp.client-ip=40.107.212.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOnA3o40zg8prF2VuX4KtYcfGTD3Z6n202CvX2ZqHSpJqduOIygRtkYqTvs7xVUTP0tuHufCqw0XpWNlOe9JfMgkVS/b01h18iQ4RWBr7gf62kbKfsjeuyrPP8u/O77HksOgtG0kYNZlFy0o8MX0ZYJlSr1GnGBvkyMLUEbpiYbd1V4jAeMtrcDre9ctqbr2XFVDeGeyY7Nhc71tdbYrjVwfwBQqihH8HZRymrowlbX5KpRHOWIVBl+DwPpo87r1ImjBOcPA4v37ix2FGFuRh2VaFkbJl7+G2sPiBR8a5FV/3KMXJ0kHVynGx8ufhNE/D51OpWVqfxlIQVq0A1+MoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7Aak+D48UnpzWsnhb9d4cGQ6es6fJHU6XxSEuHqzBQ=;
 b=KNdgn94+9jfSFegMyJ0vQlXDvLRcRca8psSAB3qf0iecLULyu9KDW/Cmvek/+Y/6owmadVA/Y3E8jR+Tj4BoFZl/s8t57eJDf5bXg2v0cHQjxTcQ34XiffMTDOoEY1P2DA8oOydsJt8KYViAxFgnl7dzK9KmdANZ3T2GaqCSE+FD+YPk/38DK/d/FBJXl3prhgsJtuQd7FCGh+XgMsyOZNLnbmL0Gylp67/OABxTRI5/QSef0Wt15S6VxEEzN1oy71mDN6qfaR84c/BfmDMUneJ23Q3wH8tFIjDJknVklz7AHfVwoW1l2tPKaE49g20kQnMqZcbXxmIuCqsyimULDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Aak+D48UnpzWsnhb9d4cGQ6es6fJHU6XxSEuHqzBQ=;
 b=pP+T8rJsJVlhYbJxzricib2GHOOivJjHbta7BhjHMLHoM7QdbyYsMnOPP7k3JdB4Emd+jLttvlsijXEmRsyBVp55wunaXN/V98VY7p2MkgDSeTMQASqgyBr7a0pmATbjbDzL1WLMfPxQZf9PwA4raSSpGHOCbZr/+Jd5N7dyh6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 SA3PR01MB7986.prod.exchangelabs.com (2603:10b6:806:319::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 00:28:01 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 00:28:01 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	patches@amperecomputing.com
Subject: [PATCH v2] resource: limit request_free_mem_region based on arch_get_mappable_range
Date: Mon,  8 Jul 2024 17:27:57 -0700
Message-ID: <20240709002757.2431399-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::32) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|SA3PR01MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e520e8f-94a1-474d-e5d0-08dc9fadfdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1A7Tix5Zwve+Zup9/2jFv1R0g8qOpj9njB+S//T+Kktp+5ZjXR/rqSWhnIR+?=
 =?us-ascii?Q?4yCLWWeDHVkZ8OhtmX1E2fLp7UO88pIYgY18v1sFHQQRylMpAM2zjHjoy4aP?=
 =?us-ascii?Q?62uDARsQzw/A805m2EVaU51xgx2iiWayWt8H+f+R/jhquJTuD9Ky9696dcpu?=
 =?us-ascii?Q?HLmo9IrFbUQtKYzhXmhbVx5gbPLdOi2h3q8dNLTBVyVBBnRXrI0aJwTF3j4O?=
 =?us-ascii?Q?dRnehrrrziIDW60+Yd8M9jdHjgTSRkJ4KECXB0AmU/U086799uSdR9JmvDyW?=
 =?us-ascii?Q?xmnPCiTJIo1LGJiJjJbqgyd2KjNXhxFSn9mjfL4URRuNZrdUF0jJ09U3OLYM?=
 =?us-ascii?Q?VedHNzFGhW/PNFkNU+iis+ZLtOcgiL1MvqR5kswmMg3mJHsrYyzZoBOiNvcP?=
 =?us-ascii?Q?34uldrWyIIDvFCBF/ngROdniYvVrHKkxbB5EbOn2L0LzZgQVaOvHwoul0clV?=
 =?us-ascii?Q?N6UZly7Zxq0SY9Cq5vFYJm6NCdcl9rXyEkYs/axrCcIlvA8sILKaUgnu+QU1?=
 =?us-ascii?Q?w0HeWHLwq4DbNvpEjoYEK/zjCJLNqcv4jv9BkeSCxk/KXaBpRFCIir7XY0DZ?=
 =?us-ascii?Q?Pn6IU0uFsJ+whDlJ82fT2ZhLTC4uoMDoJGltv6KzBc5F4wcjWKIwfe7l9o0t?=
 =?us-ascii?Q?+UqQkbNxNbVgiRvUM43eqvRgG1cAcUaJxN3GZq1qq+MFf59lpe0R/4DveAvF?=
 =?us-ascii?Q?AZC7snro+Y+QPkePeK7fFwD3X88XHStycay1Lx0wnZssiU0Y7T9ALl6rsJiZ?=
 =?us-ascii?Q?NUONtIUnorHq62Ekaa7qInS63FkM2jmRSmz1WqJdhG1gGQvf+Vdllsg6cbaC?=
 =?us-ascii?Q?7Foie5L4Nyx2tCqJyUNtje1Hp0YBdqSqdViLcfRsFvoNGVBAkqNOWiaALTxL?=
 =?us-ascii?Q?wKBzHbRy1QGxmOoECCgr1URICWX2PF3ovjNUC/Hv1fVQN8zDI9P93BXNNKkA?=
 =?us-ascii?Q?Yn3RvuVA8uSPCbWdNkGy0ek19A44laSeIZp0wUqHD+ZxYL5Y6L8+hPw8JufV?=
 =?us-ascii?Q?lhn+Fv7+7vEDp1C4ABEr1ykELMEhrf56tg2dNkjljkCS9sy/PP8X8HfmnoQd?=
 =?us-ascii?Q?F9lWIc2Q78e//XstZAJOINN6oXI+llbTwcB4rpMRfXmoD9owT9g5lOLgJ7ev?=
 =?us-ascii?Q?j5pPmBSBPErGQYXlt15/2df96X97elMUoKrdmTYscyptmA2dWaje0bgPweuP?=
 =?us-ascii?Q?1RF6Ohuognici+2X3LTOGRUqLXbNxTSAwXaa5A6TY1rxGPSYHx6iZW7X7DmZ?=
 =?us-ascii?Q?VHK/Ekhh7wCiwdH+s2qQfWQMV4c8fBTt7mJgFH884hmjq7s+yFw2d6L0Ot+S?=
 =?us-ascii?Q?Wv9UkC0kFe79fGFPJkLla2iuNdsGIUpZR55YpVSkj9TCTBYgTSU1/CNsoFbP?=
 =?us-ascii?Q?AQhgB9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUg9bLrI1lzRGXYqqFA6HkEjGFeGJ0o7DoDZw3sZ+1g8RTnefHIiVY71UxY9?=
 =?us-ascii?Q?OZE/mYdYu70Gm/kVf1ruSG3yrpv9RMxYsnfrf0plxtW/zNTr5DFq8sdjvPKc?=
 =?us-ascii?Q?FZ15Gp81i5gmwXrdNxluVtfts/EvGSM7CaR04vkphBUoW961+9CgTPfu6Imw?=
 =?us-ascii?Q?LnJudIwY7OH5rixX/IxDTcLhIiLdo237sK3572SdayoQtR9TRPXkTXNawXwo?=
 =?us-ascii?Q?bFzYAKldQTm69ZLW0BfmXM3x4FmtL7xC+b3KOSOn/Agxkuv1ae0+QPtICqS2?=
 =?us-ascii?Q?OJ0Aq31z5df9hD0GGXXVulWGnezYHyxqjGgjOtq2HB/SoPPuxGS0uiOvKiv+?=
 =?us-ascii?Q?FAnRjQE5Pd0nmlmyLiT2BySGTX4sTnCt64rILNE3BxpkLhDBy21fDiUeyLqD?=
 =?us-ascii?Q?TpDYlAH/uF9sVh40uZTcalJJeWmkJz3XuxR38psM2m21sqz1VkjINdFdzWvc?=
 =?us-ascii?Q?i+aTtfwpIEXPnfgjRiqHgUo+hBiyCgObM0ZhjtlZDEl0DTVWh5UpBU/GA2Hg?=
 =?us-ascii?Q?FKEbhdEyXR7CaubGHSxJ4O/3e6PV5NbsPVN0cOPjDsYd2l8fZhXYD473l5gf?=
 =?us-ascii?Q?CKWpPYmFBB7KPSTuuZ+BcX3zUNb+yEZ69xVBpDdTHDrYIJcU4dg+eKzo20rs?=
 =?us-ascii?Q?M18Ly1q9gNOWnoGJ1pch3ZUNxJTJ5LBzpmBEDFDmzhkv52ClAZEYyV4aCViv?=
 =?us-ascii?Q?xQ7U0Qig3py02VYVrtS3d+xjpFsF0Hgirz+CB0fgWnWMBi7CxEf1VFLEyvnq?=
 =?us-ascii?Q?W+YkeLEvGcZ5Lxhhg4HcaG5Afm8qAGDVwwG9zFNuSqR0f6Yz95UT9GwWqI4M?=
 =?us-ascii?Q?pVAbCxIVt6O3XtjBx1skdlvidNZlVDp6s6362FEYqLSnuh/etkFhHz49ngeN?=
 =?us-ascii?Q?kO49/AMWWuWx0u4m2+GdvZRN54DnsGHYN6jSl/ZQr7AKiD2wF2gNnxmk7xKm?=
 =?us-ascii?Q?Me5kP7C5dfED6vORc7SA0mEgugY/nCHWY70zAlA17dWdRBcebvFb6XgMxjCI?=
 =?us-ascii?Q?sJA81ZpD2pdeOTvJPAfwv1P6PgKFfZw3NT6CY5CmQFEcr5YtgVKKykJGuNmT?=
 =?us-ascii?Q?aPUz9tWNKQWQYkBkCxAKVbexlapj+yO/UJ+5GGtcHzjxImB8w8lEiQN33Zi/?=
 =?us-ascii?Q?1Mef86czTcTGi2ezYcdLUcfbY9g7BS8rlx7PviMJoqg7LqzKdRO3e/8WTtpb?=
 =?us-ascii?Q?2spwmsy4PR9YaofwLmP8KlcSDPSHkuKQdYHs5tRLmq4Wz37vXf/hqHxNLpO4?=
 =?us-ascii?Q?Ya76Fz5ugBmpRCREukGfTvpW/4dcbtDlJCpvlKGuKN/jj5eIC4dxCdTXaW9F?=
 =?us-ascii?Q?PBs8Yo9z5yOMreVe9R1eGT30+oQDx4044S+dORSMI/apr68zdvEQhUPNSwxc?=
 =?us-ascii?Q?fbOGVFQEC4bTld648IjHAwqLHs/AEFHTUARSvmBGCnHUnriBu0i1iXMJgnoA?=
 =?us-ascii?Q?IerVJmre/JF2p3ypga7i22JFnIvd5/wWqkmmWI0lobP8ZBDwaORzfa/9a5JF?=
 =?us-ascii?Q?C5SBYbZKr4IGCDHM0t3QNXZ4ag2fXGw4ObYczCn2y5KheSp1O2cbu2BR/Jqx?=
 =?us-ascii?Q?n2Z7oj3yviNn1dktOmePygpdW6Pqz13sdRTE2YaRX2uEFFJd64fF5vqhUGbm?=
 =?us-ascii?Q?1V+m1gqbuba8RMY/i+g4vA4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e520e8f-94a1-474d-e5d0-08dc9fadfdb7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 00:28:01.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtGTmKBzC/PVvLXuoaVqdtTlEiZP1HTpvh3TjYycCVZ1aMK+MTajqCborqZmwIBYLvgHxue28PP3HdTiBma8nJtCzwoIpP33nbbdnHc2/p6HKIayrj9CNPinug9oyS5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7986

On arm64 prior to commit 32697ff38287 ("arm64: vmemmap: Avoid base2 order
of struct page size to dimension region"), the amdgpu driver could trip
over the warning of:

`WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));`

in vmemmap_populate()[1]. After that commit, it becomes a translation fault
and panic[2].

The cause is that the amdgpu driver allocates some unused space from
iomem_resource and claims it as MEMORY_DEVICE_PRIVATE and
devm_memremap_pages() it. An address above those backed by the arm64
vmemmap is picked.

Limit request_free_mem_region() so that only addresses within the
arch_get_mappable_range() can be chosen as device private addresses.

[1]: Call trace:
      vmemmap_populate+0x30/0x48
      __populate_section_memmap+0x40/0x90
      sparse_add_section+0xfc/0x3e8
      __add_pages+0xb4/0x168
      pagemap_range+0x300/0x410
      memremap_pages+0x184/0x2d8
      devm_memremap_pages+0x30/0x90
      kgd2kfd_init_zone_device+0xe0/0x1f0 [amdgpu]
      amdgpu_device_ip_init+0x674/0x888 [amdgpu]
      amdgpu_device_init+0x7bc/0xed8 [amdgpu]
      amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
      amdgpu_pci_probe+0x194/0x580 [amdgpu]
      local_pci_probe+0x48/0xb8
      work_for_cpu_fn+0x24/0x40
      process_one_work+0x170/0x3e0
      worker_thread+0x2ac/0x3e0
      kthread+0xf4/0x108
      ret_from_fork+0x10/0x20

[2]: Unable to handle kernel paging request at virtual address
             000001ffa6000034
     Mem abort info:
       ESR = 0x0000000096000044
       EC = 0x25: DABT (current EL), IL = 32 bits
       SET = 0, FnV = 0
       EA = 0, S1PTW = 0
       FSC = 0x04: level 0 translation fault
     Data abort info:
       ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
       CM = 0, WnR = 1, TnD = 0, TagAccess = 0
       GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
     user pgtable: 4k pages, 48-bit VAs, pgdp=000008000287c000
     [000001ffa6000034] pgd=0000000000000000, p4d=0000000000000000
     Call trace:
      __init_zone_device_page.constprop.0+0x2c/0xa8
      memmap_init_zone_device+0xf0/0x210
      pagemap_range+0x1e0/0x410
      memremap_pages+0x18c/0x2e0
      devm_memremap_pages+0x30/0x90
      kgd2kfd_init_zone_device+0xf0/0x200 [amdgpu]
      amdgpu_device_ip_init+0x674/0x888 [amdgpu]
      amdgpu_device_init+0x7a4/0xea0 [amdgpu]
      amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
      amdgpu_pci_probe+0x1a0/0x560 [amdgpu]
      local_pci_probe+0x48/0xb8
      work_for_cpu_fn+0x24/0x40
      process_one_work+0x170/0x3e0
      worker_thread+0x2ac/0x3e0
      kthread+0xf4/0x108
      ret_from_fork+0x10/0x20

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
Link to v1: https://lore.kernel.org/all/20240703210707.1986816-1-scott@os.amperecomputing.com/
Changes since v1:
 - Change from fiddling the architecture's MAX_PHYSMEM_BITS to checking
   arch_get_mappable_range().

 kernel/resource.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index fcbca39dbc450..6f256aa0191b4 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1832,25 +1832,28 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
 
-		end = min_t(resource_size_t, base->end,
+		end = min3(base->end, arch_get_mappable_range().end,
 			    (1ULL << MAX_PHYSMEM_BITS) - 1);
 		return end - size + 1;
 	}
 
-	return ALIGN(base->start, align);
+	return ALIGN(max_t(resource_size_t, base->start,
+			   arch_get_mappable_range().start), align);
 }
 
 static bool gfr_continue(struct resource *base, resource_size_t addr,
 			 resource_size_t size, unsigned long flags)
 {
+
 	if (flags & GFR_DESCENDING)
-		return addr > size && addr >= base->start;
+		return addr > size && addr >= base->start &&
+		       addr >= arch_get_mappable_range().start;
 	/*
 	 * In the ascend case be careful that the last increment by
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
+	       addr <= min3(base->end, arch_get_mappable_range().end,
 			     (1ULL << MAX_PHYSMEM_BITS) - 1);
 }
 
-- 
2.45.2


