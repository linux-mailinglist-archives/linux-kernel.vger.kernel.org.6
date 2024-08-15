Return-Path: <linux-kernel+bounces-287573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A87952977
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D911C2215B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956DE178376;
	Thu, 15 Aug 2024 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VNdzC0NI"
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FE1448FD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704200; cv=fail; b=uCxFEyPG/jDyLsW/2ehRRIUPAkzNpim+bmny0xxhWdYcJrDelnSFF2Fk6y3zOamLTWclnUAefOyiazP+hHpw8wyr7Nr5SUAmOpiAMI4HqUQgijvX6UTfUWt8nPqHejZ6CWaesRzdWhjvMHoalYqtzJ9saEzbuerQGDoRePh572M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704200; c=relaxed/simple;
	bh=ad4+mii/5ir+FndaxuzZxaZAEzzOTCsFJA1Rtli50Pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B10+ZfvBTF7x/qPXtDAlxFrWMyxscXN6yzce7mtdPwX0s9bYPYzI0ZHdo3/M2GBhLAHrxDwJro5FxLipVD/YwM45GsvR0NTnq6UcHULw3LLLe6arTZ8oNvznwoMdZm67e9ggzfTBrpKQY7/sHC7fHcvatpK7bzTWdZj8igP30qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VNdzC0NI; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1723704198; x=1755240198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ad4+mii/5ir+FndaxuzZxaZAEzzOTCsFJA1Rtli50Pk=;
  b=VNdzC0NIw6n4ngFba/idBnIpj9jyAEUNktbW5h8P9iB9wGsLP0QyQnCK
   0lJ14Dkl8eFQb2Yhln1X0vOlcbMfSvn5Gxx7tUinsOr2BlxGX3+Ew+fdo
   artbKrtZW/TYmjZYU/ZRmr7WqBtYpNtlKHIge6NDYEk4dqYu+s3C1mwyJ
   0J1q5jDQVKxHXEOGt7/Ts7O8O9G5+Ycpay1j62pdWYmMmZlVTM/KVEPfE
   xaQZ0TtoybtU++Mk39a7peMwcFOHQB5zH5gRspfiIYb/KYg2luqWx5qw3
   jxZe4frOZqfcH43zv4dzJhjDUmaOI+QTg54SZab7711/PZJ1uPvw6ADu2
   Q==;
X-CSE-ConnectionGUID: 8rVRgBr0Q1qz3yMx0pzOWQ==
X-CSE-MsgGUID: oPe6zp04Sf+GuHuH5NqdqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="127875156"
X-IronPort-AV: E=Sophos;i="6.10,148,1719846000"; 
   d="scan'208";a="127875156"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 15:43:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L70KwHciiuegh9YT14VDumj2wJANZznPrLteLgz0ioa6qW/qHfNU690rBeS8fWJ1qZMmMafT+KL9hMOsm1eru8vxLrzhyvGmwK+o9t3xwARgRkyWYQLg7q2zhRP1u5janIir7EeZwi1OxXN/T2AauOlijbGc2pnqC2NJmtFDZfQz2wYka35ruO/t4RdfnflUKSrODBSdi1MWJu7oHRVs4EdWYKKesMFz7zIfULtcnk0mmXA+FMQcznXd0bqf626O1h0ChjFcH4dmzihjoh3r0xdUNvHI01+gz+j4vNrf4hPFRnAekW+Vxp9wzQgOknYR9PWCXEVs9kVgZgSk2NCV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APamAw5DlOxcntpqFsOmLpyEu5k+Iwe8adYQEmM8W64=;
 b=aVseKDeOWn8CrpjGLeL6Iru7Z1ZtgSCUL2WcQtz1v4HJoHO3Ue3/n4SM8V1sLtEOYL9Cp3sZxDJq8mVomTJ4T0MGyZcwSAVNZaBAPMSdZ70AivRaYvj2tyD2VtZMklFARHsJgEcj4B5kbTXAmoCg6VzOLlXSJvtx1/0n8L/0iALQZ4JwGkarXwOWWbKdTJLSc3mK05opMGJGfzKeFKArueDZJPm0oyRocj52BqpibB7xk2SPfmPyOfRNJDlBUwa7e3ELQMSbSPFBd0FGjytrNkkMWtdX5KFUHjl1t1xpYn+WEYEd8ZnsLx7ZYhEEj/y5q/bcZpVoCQEsJXrczLGNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB11591.jpnprd01.prod.outlook.com (2603:1096:400:37e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 06:43:01 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 06:43:01 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
Subject: RE: [PATCH v4 17/39] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
Thread-Topic: [PATCH v4 17/39] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
Thread-Index: AQHa5QG/XOtLLVx+d0m4NVODoAsxiLIn7ubA
Date: Thu, 15 Aug 2024 06:43:01 +0000
Message-ID:
 <OSZPR01MB8798549BD48777C0CB9A7B398B802@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-18-james.morse@arm.com>
In-Reply-To: <20240802172853.22529-18-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=eaf37d59-5c3b-4857-90e3-dcd1d4d9acad;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-08-15T06:29:18Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 59cd36a6a63e4a6792a9f32e09d09f1a
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB11591:EE_
x-ms-office365-filtering-correlation-id: ff95fd23-6cb5-49b6-9586-08dcbcf5820e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?WnF1V2FHL3ZMbm01SjB0KzAyVnFOQmxLVWozaFFONHRyelR3UXR4NVhN?=
 =?iso-2022-jp?B?MHVrWUFuWUJidlZ5VGEzSUNlVFc5OXM0VmR6V0YxNXBkQkk0ZnpCVDNK?=
 =?iso-2022-jp?B?dENTOGVmeXZnV1FWR3NlcWR3QmExazAwcGZmQWUxbFBHTGtKQW9LWmdT?=
 =?iso-2022-jp?B?RVpBU1UreXhBc2xheVAyUGFFZm9GbGVtbFlHTUpPQllKTEtlVlNiWGQ0?=
 =?iso-2022-jp?B?VmNwTmRPTjdWMlNvdlh5SHF2VVRMQmNibGpzc1AzNUVsUnFkN1Ywb2V5?=
 =?iso-2022-jp?B?d2JMTVJDd2RzbEh2bkZ1N1NYZ1ZvNnpYMVlIMWRyWk5tNXBoMzR0NkRy?=
 =?iso-2022-jp?B?L0J0WDY0VWlnYk92YkdYcHNJY09nQjlES0Q4ZHErNW1lMVRvOTRmczdk?=
 =?iso-2022-jp?B?UkdmTS8wN1JMeHAzWFFWWWVWdy9HQTlpa1VZUU8wSU5GclR3OWpJM1pk?=
 =?iso-2022-jp?B?cFc4VWVaVXI5TE80VDhaTjFXRGRuR09IeDZSTmFLMUducGNjWFd2dkli?=
 =?iso-2022-jp?B?K0F4TXpuZzEyUGRqVmc5UUMwM0Z4dFRhNGZQRzdyc1c2Q2lQNTJNcGJ3?=
 =?iso-2022-jp?B?N0JKckdnMC9pTy9YOVlTdEhCMWQvVU1QeXhla2lQMmpsZTB2NkRCRHZV?=
 =?iso-2022-jp?B?YzJwdGozUWxJcnM3YlRCbGVVWk12VGh4dmFETWNVOFdxZDdmRjluVjV2?=
 =?iso-2022-jp?B?QVFyK1VqUWFjSXZxUWJ3ZDRseWhpVmRGTG5jZGhwMHlOb1ZsYVVsR0Y0?=
 =?iso-2022-jp?B?SVczOVZXUjRvb3F6d04zWk10YmVHZkhZMUNDNkREYUMzSnFtV3VWNHF3?=
 =?iso-2022-jp?B?Qm9leTU1WXcrcHdraDVFU1V1ZXUzSnJRQmNaOXFWd3puVHV5aEpHVWZD?=
 =?iso-2022-jp?B?UlVxUWx5b0tEQ01TQ04ycjlVN3JKbmVBRWtHUE5laXFENzlIc29DSE5Z?=
 =?iso-2022-jp?B?bGdwenZJSTFQMXpUcXlYckhOQWJMSW1ia1l3NjAvYXNFSUtLUjc2cTRZ?=
 =?iso-2022-jp?B?NGFERUhrSHBoRm1XQTZqT0RoOXVaVkFNN3U2bE9WTVpLUDA5Q3l2Smpl?=
 =?iso-2022-jp?B?dkwrZ2lpTGpvVHluZmdkeXNDcTJnd3VDREJKQlpuWWtpZFoxZTBGdDdm?=
 =?iso-2022-jp?B?RGc0M1FjUlU4eEwrM0JaRnlYc3BhU2gwb2YvMnNPOTYxSFhtRGZsUjA5?=
 =?iso-2022-jp?B?ZFhBc2pNcTVMQkd0NWZoYllVMzE2WURHd2lzSGlTZG5jUWQ4V2dncmtY?=
 =?iso-2022-jp?B?bzFKTXA3QnNYdnhIWnE2cDZmaXUxSG5JU09jRmpTM1dHdXY4VmdGdnNR?=
 =?iso-2022-jp?B?QSttdVNENjgvdHJzZ1E2NEFYZnZnVGJ1V2thbHYvcDhXNGFrWkJwZ1Ns?=
 =?iso-2022-jp?B?eS9LS1d4Z0t1Wm1WbXFzR2FyZzRkWXR6eE05bTQ2QXpiMGw0SXRZTm9R?=
 =?iso-2022-jp?B?WVpWUXJwQW1kNjBuQzJrSUk3eEpSdE1jOGhxRjNiaXVwU1dyMkh3cjk5?=
 =?iso-2022-jp?B?YTd5UGFHWjRVQURMREJjV1JVa2o5RGNWK2Vkcm5NLzJmT2E5YVUyd3R1?=
 =?iso-2022-jp?B?NHdhMGFNeTJzVjdIV3VZSzVFd3JnWTBrTSt4aSsrWkp5d1B1SjBZZVlV?=
 =?iso-2022-jp?B?U3E0VGMrMEJua0tUY1paVFB5RXIvSnJOS0VGK0Q5d1haYitjeHozNy83?=
 =?iso-2022-jp?B?d2dnMU8yS0VzRWdNVXVuMDZ1eGpqK1ZVQytOcHFtaDM5VnFvWStzcEVt?=
 =?iso-2022-jp?B?Q3B6Q2FCVHpRdldsTkZWbHZubzdoQ2Z0cmZuUDRPTFptbDQ2d1lWRkFB?=
 =?iso-2022-jp?B?bHAyRjZ4MlZEdGpJS2pLOFVUdWhOR2Z3cFpWT01ER1R0Ny9zdzFNbExv?=
 =?iso-2022-jp?B?dUtUcTZCcHpVV0lsMnYxMWg3YVI3ZmlYck1tVzFMV0xDbzQ3cDJ3MGVG?=
 =?iso-2022-jp?B?Ry9yaWM3a09yRitzNk0xTkh1MzZhZGMyZGJVaDNKQmtCTEx1a2gzV3FM?=
 =?iso-2022-jp?B?Nk9jSk0wYWpRd1BVTTJBTDg2bEFpTVgyR1RuTVNPTXczZkM5SXFYdXYz?=
 =?iso-2022-jp?B?cFBraHJFbXVOWkFKRWw0Q2pMS3Fmbnc9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bHcxNElmYmxDM1ZSbUZSdTBtQ0lVWDFrN0lTV0lseEdoaVNoUnNYWVEx?=
 =?iso-2022-jp?B?MmU3SjdEL01USHp2elpzcXkzckJtcld6dHZFcVhCeWs3bFVUTVVRbVp6?=
 =?iso-2022-jp?B?TXRzaGE3bVF6MnFldlRhTWhuMTlKYXZNSUduZndzRDh1eEpscTNWOXZD?=
 =?iso-2022-jp?B?eDBveGlSamtaR2liWXdEUW9IeEZQMFF6a09RaGtGWVpVUkhGSThEdDRz?=
 =?iso-2022-jp?B?L0VrNWtiZWoxOFA4bGk0Snd1WDRnM2pNRVlRS1kvZWRZeXg3ZTM4dlVH?=
 =?iso-2022-jp?B?Sk9BWFVTYzlWQXBFK20wbmh5NXBNcjFycWw0Y2VreG9VWFk5Sjh4YTNr?=
 =?iso-2022-jp?B?YmROSGluTlE0QmQzSDI0OERSMkgyZElMWWdwZnNzQ1FOeUZZVkE3Qlc3?=
 =?iso-2022-jp?B?dTBXMVBCRjlYWWExbSt6VmVWcitta1o3YStodGphcnZRaTVoSEQrMlly?=
 =?iso-2022-jp?B?bkJoNHNCMjhWdkNNb0JHZjdhV0JaYTVWUGVhMC95dXhOOVphTlBhUlda?=
 =?iso-2022-jp?B?ZGhkeUh1UUd4RGNVK0toLytSTHJNT092bWV4Z3ZoQW5kbXFkS0hPYjNw?=
 =?iso-2022-jp?B?Rm0vaTFrOU5LUFF3N3FRdzl5NkxFd3BDMXhkZkY5d0d3U0RxMGhnMG51?=
 =?iso-2022-jp?B?b1ZWT1prSVZrd1pSK3U4bWx3Rks1dzRnZUE3YlJzYjZyYUhxMk5tWXRk?=
 =?iso-2022-jp?B?ZklBV0FXSng3aHJMWlEySUhXTk16aDhRRWVlNzNMNnZaNWpwTVRkQUNF?=
 =?iso-2022-jp?B?cGFUNjBBMm1ETkdZa0thZVVnUmNJaTNiUFhDMExXQS9YcHpnYkIyV0tT?=
 =?iso-2022-jp?B?djJqK3dLTXVMcWs5NDA5T0ticXJjbGpwWEc5V1lZRHVxVmpoNTZyY2dK?=
 =?iso-2022-jp?B?MUthME5vOWVTY0xlb3VFNTR4Z1dGMjZmOTExSVFVV0xROEE2Vjg0K2dP?=
 =?iso-2022-jp?B?LzcwVkRhUEZOdEdxOXpnN1h1dmZNSkF0U0N5dXJZMUt1Q1ZqOWFGeXVi?=
 =?iso-2022-jp?B?Wm4rMitwTC9ZSE1GUWhsWnRlWXJvVDZJMEFLdStLeVlwTG9aUkl3T0Rk?=
 =?iso-2022-jp?B?aVk3czk0MHQ4dGI5Yjc4Rk5QRlBjSUZoL1dGZExoaWIwY1E2TFNzeFR6?=
 =?iso-2022-jp?B?NkM2NWZXSVpWWE1RaVpjckllYnNxWXU5ekpRaVd0MnVVVmpmRFY4c01N?=
 =?iso-2022-jp?B?eE83SWF0WE53YW5kNnloRE9SOHQ2c3UzTzB4RGRmZjYxTVJkRVVoUzhM?=
 =?iso-2022-jp?B?OHAwM0NFVDhlUnNId3VNRjIzWmNMbnVtZno0L0RpMTl3Y3pFcmRQcWN5?=
 =?iso-2022-jp?B?ZERhQWJpbEZ0dnpXOUkzanB5VytUbWNxWFltcnFmYmllOEhtcklqd29z?=
 =?iso-2022-jp?B?MFE2eTE4ZkFoNEJNbU1NTUJaaC8zdy9naS9RSERUdjFOdWhndm5HNEFu?=
 =?iso-2022-jp?B?enFoT1ZGVk1ZOWtRei9hck1LYk5DeFNOKzFIRVZOZTRJYnlieEs2WGVQ?=
 =?iso-2022-jp?B?UG9KODFqb3ZoeXJkSXlockpCVG52cjdKYkl2OCtCK0lDdit5dE1RVm5x?=
 =?iso-2022-jp?B?TXljVGwyVzl3dk1IZSt1cEhHNkVWRmJSWmlrdkxaOVdtay9BSnBzcmhX?=
 =?iso-2022-jp?B?VTJYUjRBWWRXS0tXZEc3dGVkdWVJeFNsS3I1RmRrSTYvSlhEcVVDQ1Ju?=
 =?iso-2022-jp?B?czFDaHNOVFNCQXl2SGtsdnRPbXVEMEFuaFF0UmMxWVRZZFQzUlgzczlX?=
 =?iso-2022-jp?B?YWUzK2ZuZVAxdXhNUkpPN3dGUmNNUGRoWTR5MzVqTG55citjOGExSXcy?=
 =?iso-2022-jp?B?eGFmOW5iRlFmSUhNUzhYRDFqREtiZUdNTDM5WkprbjhVdDU3d1ZWdWFm?=
 =?iso-2022-jp?B?UVFCKzZXb3BXY1BMN0gvaDJBdk5zWG5GVXNFNWRwOFpVTW94ZHhXajgy?=
 =?iso-2022-jp?B?T09Ec2xTcFFzQm9tNzlMQVZLUHlhMGhaNWhmV0srQlYzOU5YZmdETXE3?=
 =?iso-2022-jp?B?Z1c5UVc0V3FpaXlLRXJnODE0UEdDK29Kbksyc1dUSzVjTGVYa3daTy9v?=
 =?iso-2022-jp?B?dmdPWFpnT1Mzd3hVNlRubEtacXdLU3QwYURRVmJXejd1bndJRXVSaHc4?=
 =?iso-2022-jp?B?VDlnL3Fwa2JDcDR3R3BtZitYb3cwMlhwT2pzTkIxYmNlT3FqTld0alBR?=
 =?iso-2022-jp?B?ZXR6U0YxbjAwYWY2WGRxaG5SWjRYY25FdjZMdmFEdzlZMUtIc1NPWG81?=
 =?iso-2022-jp?B?U0Vab2thWU9rNzVoUmcyanIvV1NuVm9KTFRYbFRFMk9ldHRsV3RaTEc5?=
 =?iso-2022-jp?B?SjBRSm13Q0pkZXhJb3U3ZDM2aUpNTS9UUkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W2vh4K0QuZp5YrzMeoePhNBZOESvxvtY9I2ADa1nK07TwxmMVOESPYLsn3wdT+VBNee83TcUjuPjegCVtiVwHIFA9O7tW/w3r3Ibe1c1H0qKyM5243dkmhhxrn2Klc/0emz5HAdv+K0aU39qvwibZ7sKdtY2ZdYkwURKD6kWoOLDT5WP1vNBe48StHV2I0w3n6FBZidDpmWKwp79wedAb9kCo4V/A+QV7AmIL7b5pMqP/2F4+Xb/bOLmDeyTM2FJt5fFeIpYuGHefviKKSjgo4WL8FMh1oWnFdvSgqHG0/LhrBzRLPXVJK8xlJmxBjxiaqzpkIbgzO4RXIeBM9bVpKkXA9n/RG9VDbgGdRer/IBmlbQ6fJ5AzycSrysARn4rarQngTHVqlKb7C7sG163hB6URpe/GIxuC10EHbUWrmC3BVHgW0NffWuwmGswil4ntTttpqWycSX2QxOiztedGTsQuPFCLerYJ1Ex9Wg9zanVTwtNkgrfdj0EhURyuzLcMKF/HfK7x+lJAxB+mOQy+AwSnBYoLGRCN4bE1ZyL+/j/m2StfF6DdhUBc46LtXxyDFGaQ0nev1rYJ8cEI/ZuaeGvd5wxrqOraHR6xjZHATpSFedV8EREs35R0/evO2kF
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff95fd23-6cb5-49b6-9586-08dcbcf5820e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 06:43:01.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZDD6TMDB3XJobOooTftcfcaAXaeb6cCjdJdK1iqCODB0OdLr/M3cgvlSfQshfziznM3WtDo+Db7kwaj8tw585wsRFKKK9fhXGu5OJ7XvPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11591

Hello James,

> Subject: [PATCH v4 17/39] x86/resctrl: Rewrite and move the
> for_each_*_rdt_resource() walkers
>=20
> The for_each_*_rdt_resource() helpers walk the architecture's array of
> structures, using the resctrl visible part as an iterator. These became
> over-complex when the structures were split into a filesystem and
> architecture-specific struct. This approach avoided the need to touch eve=
ry call
> site, and was done before there was a helper to retrieve a resource by ri=
d.
>=20
> Once the filesystem parts of resctrl are moved to /fs/, both the architec=
ture's
> resource array, and the definition of those structures is no longer acces=
sible. To
> support resctrl, each architecture would have to provide equally complex
> macros.
>=20
> Rewrite the macro to make use of resctrl_arch_get_resource(), and move th=
ese
> to the core header so existing x86 arch code continues to use them.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * Restructure the existing macros instead of open-coding the for loop.
>=20
> Changes since v1:
>  * [Whitespace only] Fix bogus whitespace introduced in
>    rdtgroup_create_info_dir().
>=20
>  * [Commit message only] Typo fix:
>    s/architectures/architecture's/g
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 29 --------------------------
>  include/linux/resctrl.h                | 18 ++++++++++++++++
>  2 files changed, 18 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 8e52e81a044b..84e0d019423d 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -472,14 +472,6 @@ extern struct rdt_hw_resource rdt_resources_all[];
> extern struct rdtgroup rdtgroup_default;  extern struct dentry
> *debugfs_resctrl;
>=20
> -static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)=
 -{
> -	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(res);
> -
> -	hw_res++;
> -	return &hw_res->r_resctrl;
> -}
> -
>  static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l=
)  {
>  	return rdt_resources_all[l].cdp_enabled; @@ -489,27 +481,6 @@ int
> resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>=20
>  void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domai=
n
> *d);
>=20
> -/*
> - * To return the common struct rdt_resource, which is contained in struc=
t
> - * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> - */
> -#define for_each_rdt_resource(r)
> \
> -	for (r =3D &rdt_resources_all[0].r_resctrl;			      \
> -	     r <=3D &rdt_resources_all[RDT_NUM_RESOURCES - 1].r_resctrl;
> 	      \
> -	     r =3D resctrl_inc(r))
> -
> -#define for_each_capable_rdt_resource(r)
> \
> -	for_each_rdt_resource(r)					      \
> -		if (r->alloc_capable || r->mon_capable)
> -
> -#define for_each_alloc_capable_rdt_resource(r)
> \
> -	for_each_rdt_resource(r)					      \
> -		if (r->alloc_capable)
> -
> -#define for_each_mon_capable_rdt_resource(r)
> \
> -	for_each_rdt_resource(r)					      \
> -		if (r->mon_capable)
> -
>  /* CPUID.(EAX=3D10H, ECX=3DResID=3D1).EAX */
>  union cpuid_0x10_1_eax {
>  	struct {
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> c8cd6dde91ed..04a410a5e739 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -26,6 +26,24 @@ int proc_resctrl_show(struct seq_file *m,
>  /* max value for struct rdt_domain's mbps_val */
>  #define MBA_MAX_MBPS   U32_MAX
>=20
> +/* Walk all possible resources, with variants for only controls or monit=
ors. */
> +#define for_each_rdt_resource(_r)
> 	\
> +	for ((_r) =3D resctrl_arch_get_resource(0);				\
> +	     (_r)->rid < RDT_NUM_RESOURCES - 1;
> 		\
> +	     (_r) =3D resctrl_arch_get_resource((_r)->rid + 1))
> +
> +#define for_each_capable_rdt_resource(r)
> \
> +	for_each_rdt_resource((r))
> \
> +		if ((r)->alloc_capable || (r)->mon_capable)
> +
> +#define for_each_alloc_capable_rdt_resource(r)
> \
> +	for_each_rdt_resource((r))
> \
> +		if ((r)->alloc_capable)
> +
> +#define for_each_mon_capable_rdt_resource(r)
> \
> +	for_each_rdt_resource((r))
> \
> +		if ((r)->mon_capable)
> +

ERROR: Macros with complex values should be enclosed in parentheses

Best regards,
Shaopeng TAN


