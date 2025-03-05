Return-Path: <linux-kernel+bounces-547646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D81A50BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE0A3AA4A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBEA2561CE;
	Wed,  5 Mar 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QfImgVfV"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42428255E33;
	Wed,  5 Mar 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204228; cv=fail; b=sHSTEOV5qtAa4GjVi8gn5TUZB7AF6yMU9Cmyy9MvDSeKr+sHLeM2e+AenZDqhk975TR6KPgdesVXUNEMh14lIMgFuW8SgiZtKbASPLvK6459FW8mcvJhQRZNRuhKm20kbUAl6BgHMc9gf8xkDmgTjZpYWUQdN4VBCWlNLD0I7rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204228; c=relaxed/simple;
	bh=TJ0+C/YXG7SC9b/FJWLJR09RvMPpcS74miGgaMFYlaM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X6d0d9zRxYk73bDyh0LiYE/D5Zm0DONwmatb3gSLgbhDDlVGzSe4G5pBZWsBtrpjG0ZLYZfroFiGF7G70lZ3eW8ojY1v2iNWuNCXAij4bW/LvnstXV0s9rK/Qia3I11wTI0FvCBcnVkvSTl3SeklaCQxZJJ/cOC0Mc+eWb+B4Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QfImgVfV; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkPUNoERhqfGw//edPM8MLdC1oSXSErPRsZUAdKINOQ8qpALS2M9erT+KymxY2vjm7d74Hbkx8B3VzlzNCFj8+qjkZQSSNXZ+zCb1kyufLNeb4hseFTadNhLDYgfYVsA7A7RSHJMwBooQpzfiJ/P1xxhyun1H0TM5hPL2zbW78GgO8k6h4Uh8AZYcnwr3+hWXBKvt6u3P9col2N+74+wbGROW9wG/TEkQA0F9VsDslNKWkWodf4AcwYIUmWpoQJWTLZBbA2EDnG92rR9eOmFcRL4t5q6DXcQeAIN62NEXx/8azV2Kk1WOWXbb5DrIH6jXqcT3JPL3jo7Ypf5//X3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLIqUnM1d5R1SZwMBIfH5F/gCjNRhttfPiX7jYH9jqE=;
 b=CHPAr74Nous6RWDXSeScgtdJAdDWMe+K9HC4whG59rVQcsbqt2lLaSKDBRgBFc079GRabT0RnEZQYiezlFQKRRGOjQIw9sjk+VZexH5IOEkX/OAB5Uep7j2YYqgjOZ6iSZd7u95L0T3MmpZsxw1GNCD6IDXDncIn52WQUGw5COUyY0qd3TNZ68PL4EvGo3Q3XcV5FqwHrmu1Fu2Dliec4DrCCVCacaNZz7vGK7lDamaQrFRHvCCDC0n2wdZe4OOUyQXlkXl5mNlAMcT2l8RECv3R4J8C2BC/kHzG+mHJxPdSuKHLAmKavaY3zINbQX3o9E4AHy3AqWnS9GyImgfZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLIqUnM1d5R1SZwMBIfH5F/gCjNRhttfPiX7jYH9jqE=;
 b=QfImgVfVS6F9c3zfH2Cci9pV1U+qT2ByXhypmrxrYUXDgXsyaeBs81Px8NlE5ZU05AHeNiNrSfxXMShKl6OovDF1Qf5NF/fKVfbjw544g0M7Acz2QCTsdYIKfjM+wfiQHLJzNe9xQvehLbjy0GhEJhrnwHxwsl+vwxGrEqH6S/2GZECc7dP+o7RwV769Dnq/qxMedtZqCyFK7mErxTOJTa9lP+WVcz4pW4EgfCQmDf76MH2xVNr2Bwoxgznfr48RF2bE3d79xfDPAZvjv2WuSg6k309nEvrZRUo8KMclZH1iwosaH9sOGb4JcfjiQWQV7lWjwz6piCjumEDXWfr/RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH7PR03MB6972.namprd03.prod.outlook.com (2603:10b6:510:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 19:50:20 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 19:50:13 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 0/2] Add bindings and DTS for the Agilex7 M-Series SoCDK
Date: Wed,  5 Mar 2025 11:49:49 -0800
Message-Id: <20250305194951.7226-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH7PR03MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca68f43-7399-4b0d-5bd5-08dd5c1ef1dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kca1jLs2ZFYpt8+RInlHj4r/O82ZY17mrs0sLTWfXNdbD2bGsouCxRVIUZW5?=
 =?us-ascii?Q?keq1AcdY3eDqwEmaW9DFx9YCiJdi4FEQcFKhdsnUBO0h2sDiNcKZPNqY8mEe?=
 =?us-ascii?Q?CLkRm0n1P7OceNeZNFv4cz1Ww9hD2YxuVKHze4aR+QB/fUFa9A4gcey6rfhK?=
 =?us-ascii?Q?qGzUpRj5CI3jRYL1BAox3/hvF/qi7FnH5gah+gc/gigi3IikPqV+1ia2Ss7l?=
 =?us-ascii?Q?1jMD0VNgcD+CEwOrOD/3MzBXFfBJI9lSYKoBLaHxMSfgunUhgm0kuaZA53E5?=
 =?us-ascii?Q?wbFrlW524GJICDFglJPAnI2mzMTraVwzqEp5a4xbX/o2gcyw1T+hD7c+KhKB?=
 =?us-ascii?Q?IE0/Y+diooEBm4DgBl6/VBYEr9tnfGAyHH+12uzQtpw7okq3Ck7SnqEcQJy8?=
 =?us-ascii?Q?4X3ToELWyB6g8Iy8P1POTmCeA+iXTb+b4kq2vBk7rQGsiSSggDVAQ0n5TY7B?=
 =?us-ascii?Q?FKyBpw4+nut6+ySTspPxeWr5axaZb1uxVT4Y6rZJEIX3jMjeczMB23wKGQEp?=
 =?us-ascii?Q?zJPC8Klcob5BWbvCE2OZ+8yvR5FtgyknHhPJbO3fsGwAC5N3dIhFXV3OLlui?=
 =?us-ascii?Q?CBccu+qYA9MhtBXZepBWge6WBgbUfNA+d5pZt7G1zF+54aiS240hsKrshTfm?=
 =?us-ascii?Q?+fN7X65IOiH0h8a3vHId254pJ5aj/Nrwe1j2QiL4DMfErPX1i1gjlf8J0e+D?=
 =?us-ascii?Q?zEeMRReWr05OAMg1AJwm0l4WHJIjHib98WwB0Vt0UnXSziBu36J+IQWWljFz?=
 =?us-ascii?Q?e2sn97ZeU3J46XM+FeaeD+x/LBLKZucSPFX5jjx0pFYftmyOMsGQtCCwflhx?=
 =?us-ascii?Q?Ipt71xpr5/r4uHGCEZktwrcasSPGlc6vN96bjvRWMcW9N22qaOK9z5E+c7Ir?=
 =?us-ascii?Q?aPldrQAv+edrjg7cIpSCd3oNmwKofoX2Y1k804Ksi9/xMQ4J2SmT/8J9u6ip?=
 =?us-ascii?Q?ykuM/JvCvE09Pxe2kAKYvCsvPbHOr4eKqjJIzVxDN3YUhzTBNbFApq1PdpEh?=
 =?us-ascii?Q?w9NQ+z7dl5Zx/iL5tJrK3YSpKjlnOmOBzf4xZ2oKjpbAsBkiBtwHEDbEGpVF?=
 =?us-ascii?Q?G5KpT3l7LNsny2LOUJx9qhl822NKOESZwNg/u9x2wlEuCSo/xqdPswRM/jZk?=
 =?us-ascii?Q?KWfl9MMGWoFM6NGiatirCi0tmvV1RtVBuyrpCJineIRhGIT2KFqi0oF3im4k?=
 =?us-ascii?Q?+rqH6E4gmAkDpQQP0aiq75qCTI13YLe4HScSh3fRyteJBFxLc2LVPdS9dOzl?=
 =?us-ascii?Q?GvaVoCk8LXltwUaZwVMf/qzrpJ1sUeRSYN7nJyDOYFj5ljkog1QKn8y/Vhh/?=
 =?us-ascii?Q?triXFEDRMEUAeSy8Ci0Jx/67N8SW4LnAjqyHiA/0t4z56tTQ2xTOClQTKLfr?=
 =?us-ascii?Q?YfYbqV913LdZRHgY8Ym7GkQqKvX+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VyMjl1TxJ04/luJDNzw63BVvs1RsAtckMmnQJEBTcScXyP8JA0yQ1Q8zLcFT?=
 =?us-ascii?Q?FSvqOKR7msq7z9jOv8xjzueETB7O5/4bjqLiJsN9DISp3xENvXQTWytNfg9R?=
 =?us-ascii?Q?g4Ufu85t5DiI2JPvyZXTZwGCkV7ufbtNDH2367+shosYlQmaCaBQP50qxyVT?=
 =?us-ascii?Q?CF68GEbJZrwHEa8f+z7lDnDasBiHk5hwA4iTukIHu/VbvlBuYcbztTzfQdUf?=
 =?us-ascii?Q?yb528dP4y8LkiEtbQFlP02S4GbF16SF/zIMS/D/WK1Fb+mYuwDNxYewe4JYy?=
 =?us-ascii?Q?D8XcdLEEH5hDxi9fSBTDCBlRaXANnhKfSMNtvvjsFe90FgTw3eGB1zE/MXEM?=
 =?us-ascii?Q?dklKkEpeX42hcvhM/tpuB0JVmT3PFFcwQF1DN5+gwBvoYWXIZyA8r16B7u21?=
 =?us-ascii?Q?FthNdEsNt2wbul8HsyB7tC0WYYf6xsm4wF+lI+6gbGw26EEtjcklWwCjd5Hp?=
 =?us-ascii?Q?uHZeBJU1XvoVd7XCsSgc1ArdeDE/WPKMdl+zmFz4n7ZEeym4DOaqKo0NMojN?=
 =?us-ascii?Q?zQIPhaGsqv0v/irqAl+zp7mVJOAKaoh6jIy20q/RNCzd2W5YzoHSEXfoU1GD?=
 =?us-ascii?Q?2VeVtFYI6NuZxaPQDEhx2Ym/C6adx0TlADZ6WaIOW4XEAxkvQJWB5DgbXkjK?=
 =?us-ascii?Q?LJKjRuPAqlvv6HjxJXh59/V1m5GFYoUOZmARFhJ7Bpp/i65eJYykPx50drkW?=
 =?us-ascii?Q?spZw95VKvIn9PDMGbxh/uIrsfplCzqRDNaEPUnTLFlUUYGDPNKMgqNP10593?=
 =?us-ascii?Q?YQs14pliYtEU0Ti4BhYmJIZiNq5wkL5mdnMbJVcUom9LexnTFJMX3KwW8tlc?=
 =?us-ascii?Q?gy6Vz36iwchQawqo6wqJ/uywhZAD9MSFSaTSwB4rqPrXYqDMa165uoo1YlZB?=
 =?us-ascii?Q?6ahxbiKMdSPq0hJy6FiCgMIYzJCEDmgJLMmC/W+mcD0aqeTuMMAfmFX0vIe+?=
 =?us-ascii?Q?pnYuLiIe+7VV29k63WlOu508OmIyQgMbJ3/HBoqJEiikEYVE5BSsP6ku3wSM?=
 =?us-ascii?Q?+cHMtDT9lxU2ijqYpcQyT9wq95jFji8EtaF+BrdHddlDtIR7oqsSbXca1oqO?=
 =?us-ascii?Q?ct18wHIKOi8JLVcuW5nSLVxvMg6jctZKt+HPJU/KS1JwDOaAa+5gmH/+zp+J?=
 =?us-ascii?Q?BgCFHA46QcQDVtSZ8Lsq/djJ4d85rXtnQmBtUEFkujPSD3MpsnCMns0IxQ6M?=
 =?us-ascii?Q?GIwHnAE/I7l7dzZRRWtnPeO6REsbbj9VzQALFc6TOhz/+PqVTPecvo3xcSGC?=
 =?us-ascii?Q?ze10e5Y5VB0uoNz7zmlNGs/ibb9OzSSOIypezrDrXmsr1XechvjBbzLyUwlx?=
 =?us-ascii?Q?3nXIWvXnT0fxJwsLBAs/MRHO1/Uc/af6/i5q5kUef9sSNch8UpXfMgosCWtG?=
 =?us-ascii?Q?kCnPK16mJUR4kaq7aPHQBqQpkhDzDVKaZ+tt9ED0Jpqg15i84YomoTpJ8W2n?=
 =?us-ascii?Q?4UW8Q6II30POWfq5eSRdKPTA9VOjXhTYedXa/GHDkcD621O1OTAVRf1m0zYA?=
 =?us-ascii?Q?jWsUocVCQjFGq0v7AfDQdMfG5v94AC1QCJ9mt0WiyRHLthLoDkQG0HOj1WgQ?=
 =?us-ascii?Q?MVm9Gt5vcSgGsPABaFCG8f9oRy8XcnK7orT5aadjXK6th+AoVdi52uoh3YPp?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca68f43-7399-4b0d-5bd5-08dd5c1ef1dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:50:13.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAqs9ehUnGadfnm2jnQzbGjfTzdI2wnwxyHU3Qh8WhLgxdzWp2iThd1L68Ea3d1s8VGmki+ynW73bqKYcdg3hHXRgfeKHIKpPJVgYrpRC5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6972

This patch set adds device tree bindings and a DTS for the Intel Agilex7
M-Series SoC Development Kit:
https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agm039.html

Patch 1:
  Define the device tree binding for the Agilex7 M-Series SoCDK.

Patch 2:
  Add the DTS for the Agilex7 M-Series SoCDK.

Matthew Gerlach (2):
  dt-bindings: intel: document Agilex7 M-Series SoCDK
  arm64: dts: socfpga: add Agilex7 M-Series SoCDK

 .../bindings/arm/intel,socfpga.yaml           |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../boot/dts/intel/socfpga_agilex7m_socdk.dts | 108 ++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dts

-- 
2.35.3


