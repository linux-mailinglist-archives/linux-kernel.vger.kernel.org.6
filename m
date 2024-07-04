Return-Path: <linux-kernel+bounces-241603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD91927D07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E68E1C2213B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40475143860;
	Thu,  4 Jul 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OtyaXuK4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C2m1VjA5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40613F432
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117690; cv=fail; b=YjBDH2XKzZyvudmnDr73tuPNWjlH2jw5yvuUWgTpRP/QiQZqWzxAl9lxF1EELbDNEA4dfaJuFv48dD4qlijnMeJHGx27jC1AO6q27XwVfk7DGlZtww2PLyVoPNnyVxEc5mMIvRUGdxnFztADTYuGqvndvzLUdzNn6zowQ2miLfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117690; c=relaxed/simple;
	bh=K34Eix530ATcNp6na3e7VmzDiTBvudYMCZW3OL0+cXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGiYH57FfpahlAw5G3VFtygcJrzi40HrqpUtJLzQF9jXwobdy2nsRrLipNhZcHtpF6hpjAzi8iGX+okAUr7YGPX17AHid/MYkOeOxZC1Ge6B4aieDmPJQENuZ1XV+F9ejgTavfUAdbDpu2Q7lwrc9lm4CcAdifU7CCOZWERab6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OtyaXuK4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C2m1VjA5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DLweW031054;
	Thu, 4 Jul 2024 18:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cbmWb7Ca9QhbidioktTVL2ube+NqVVmgF2/QsnRM2Ls=; b=
	OtyaXuK4A4k1yfwLCxOrsHN1quLSTws/Hqay6NuBYctF0kfm9L1q9Jt+eyTN0QCz
	QyDRXCc15uvO51A686VwBGnPjyqvqAKD8bVIVYdahQcVFVSUITZAo3O73I/VmGFw
	/ahZdF5ClHobJW5gVtKtk3wwRgjCMJUALo/W3f3URXpKhYhmYfG5EzXY1Lih3/MI
	LGVeHKjo16BiNsZ8aj/oGM3uhIqfKhnRx7CqxguanFOEhdRMNMy3q83ELgJMRBFD
	UFYledDSKbvVKZWlSm8n62W1mUIfskXRmtQAlmxo9We6TPZpPuHvXwbWp95pypm4
	cpunknoDuRoFwQjvO4SVtg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacjt0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FoemP023607;
	Thu, 4 Jul 2024 18:27:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11kmr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W753l3eLhyGIokJabDDZPLn0BIeXWziPqzf4UcLjRfjAn1dTRSeDUPiNODJrCMh3jfA83AIPU6ESACNmZHW0qmoi1OVSZ1Wn3Nu5fLjT2VbDXWomcVQ7F4nq+f/uTcCbjq+6CFg5lkcAW914pQI3r4/bfp5VNxjrcuSKBbaSAWMoWYgKKaftxZOrt+nOtvDOz9Rsv5yEKRnGVgfU/1alVdw4cKY+gKtomBXPJJQIe4t5rDpDUbn2x2x0Kl2dZMJIwSHPsTFvPwHOiy5Q7Q22qbKb59SVPBtbl+ffB7Na6vJPYWs8YAe6t2otcJyZCAHgN+570rNIy7xnMNTtU2wAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbmWb7Ca9QhbidioktTVL2ube+NqVVmgF2/QsnRM2Ls=;
 b=m16VBkerahljIur+G3PqqUmbQbELObgMpnc5xX8vvrE0svLog5bhBcCSmGA/amJQ+tdc2XI1I2uhXW7U4IBYVUKmQfzWwF+LFbX25+j9i2t49+iyQAL2yFqFL6t3GeOulb3FDInZGOG2WNDkxwozzy/sB41DnmR8SyTmD6vkdLh0TZC84+EOG4/MeuvnCbcWvtaNsek9itcpOSDTDwTXlMvykWrAMkJCgiVeSnA2d39LIRJKxBX8JtIwvVxsDpcoWMXnF7t3qGBuC0kgxej5b9dEjEYgd5jRF4ST7OHpf936poZ1IsqyjEAEO4RA3LRUBZOwcjVYw+wTc+0XqZ8wQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbmWb7Ca9QhbidioktTVL2ube+NqVVmgF2/QsnRM2Ls=;
 b=C2m1VjA5IC6p93a6IjVLjN4B6YjcO96Cl6lOVKVhWWF2Nv8XMVLEMMqWSzWeqdBXz5BqZw/bcA+U5OsTeT0zu88ILza0gMuWQROlaDqmCTF2UAPsFJznzNHXixqNQugs3ikZeo3KFnXMDoKZoC3d4/qv6JscXA5uEZcvV29QQys=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:49 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:49 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 13/16] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Thu,  4 Jul 2024 14:27:15 -0400
Message-ID: <20240704182718.2653918-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6344b4e9-d6c1-4798-b1ee-08dc9c57027a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sGbxOS4zDIz/P8l3ep74Cjg6csCXlJx5LQwkeezHYE4Pwg4kOnXF0emarQw7?=
 =?us-ascii?Q?/HowM94K8e+SCJFD0Fi/pGdryWddKaPMdi9Ou21pwp6rCQMjMnEPDC2ytfVe?=
 =?us-ascii?Q?kLQDiRpk7TjnSRIbubgmU/sPEOUeyVFCU1d9WY4cE1NxzRxq0ZWuB6Iy/zuw?=
 =?us-ascii?Q?vnkuFqT8GH+elt180YAz7DwSu7rDKv4y7AW/fnvDgwOt8gvRgcWWyJLRDWfL?=
 =?us-ascii?Q?2d4TD6RsjSlhKoU4FHIVyJCH2oBy/6G86zXvlHq+l/KhBq6+qadwzbxzHYEq?=
 =?us-ascii?Q?Nq9fCy+3ZzFLWLeie4R/P0luwEI2woNB3EM3KAQujvWJTk4VKMvntk6/Kz0g?=
 =?us-ascii?Q?kd3XzbtWB4LJvter1Qn4QKVl4jzxEHS3cp36v/llqDDXAVMUxJXDxDVH5drv?=
 =?us-ascii?Q?rQBmmorr3oVy/JJ+iddIIp6Kybq5k37insW1YzjBfZr4KbyJLCm3xYfSY68e?=
 =?us-ascii?Q?mMNwYckPpaaj7Y1iuV8aY0YVpqWj8dtWxZVoW2+xN9+fD+L9vfndqkOOAk6/?=
 =?us-ascii?Q?ruacHqIRCgYaTgS7BjdjtSKjeqvIgV9xHDBqfoNUj+Ic6s8h//xfL8g7rzYU?=
 =?us-ascii?Q?DRLrpv65OOnJGhQodJtVLXOktDoYR//SXCosj9hVQeNmhbh/qLu93vQ5qXfo?=
 =?us-ascii?Q?mT1NkQn/u8VCh90ZDiulgZZjdYGesiychl6vps7QLEujy3FJF3H+mSNuGaeL?=
 =?us-ascii?Q?socxWZJszOQD659o+2KmhSoxOw8/gepUgORN00R3D1NkX9e3db6NwLwWgIHa?=
 =?us-ascii?Q?GtscN5QHZbl532yZt+W1RY7SznRLtdvCanNldKoYr8seQPT4kihx1/uZIXUh?=
 =?us-ascii?Q?wUxqE9XudWif8+T/X5wJUsfUHm4q5XDgUh0Fdl4T7XUi7WbnyEfVnXbjA6r5?=
 =?us-ascii?Q?DW1iWol6SFJK0fHeIuUgbBvWDDaccH1yScHTZVPoGZ3MSM2Q3kptmj8FAexm?=
 =?us-ascii?Q?5E9ZPlP6zZgX/mDY1Hsy8xFrT9922ebvZcgkcSwBmncV/pDmfJx6WHAdA+fV?=
 =?us-ascii?Q?N2geA14lYiYL6ZDKQ0dFLl9l+JvyuqPeGgXaM1IYtdURv16dvxV2Us16RcOF?=
 =?us-ascii?Q?sETtLB4Ju0lRZ10sFWhW2ZemUidyLF2HryR0if6e1yc36J8E1lUA3MP6EpOv?=
 =?us-ascii?Q?JGRbAsfSMIZygTE4lKP3zwlzWgL5ou7SIDQCsbIF6E8eGf/gpo77x9iZTI2u?=
 =?us-ascii?Q?OvBSxt+c6j0ocWR3PIxOGfe9hijI7YmNPJIYx4wwmeAN+Jbb+nItqAk7Ud+t?=
 =?us-ascii?Q?4sPm7Seas+EjhzR5c+2pxkSbPI2WP1LZXLcRsmaEN78/55A8oAzzMMQa+WzW?=
 =?us-ascii?Q?mY6XNE0LyKKQbEBchHbBaSruORGSkhS3QqPImqdTb2tndg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q6SocswB4fkIIFzMcXroW9ZsrGD1ClLP7AbdNeCf/I3OGHMm9Z67inGW8KfE?=
 =?us-ascii?Q?ftNP/mO+jBx/IcK0C/sAblbCXPqxSjNisdiBIeaqsCey7rjkpJKjVDLg8KhJ?=
 =?us-ascii?Q?5zmIMUH+pX8z+ncUpaYrasn/gSQQSXocDqH19HmOP2tIU09Au9Z0Yh7vZXMJ?=
 =?us-ascii?Q?HXFLlRdeDis84wep3UFzz51CN3cJRLJwUek61oW3Wo41NvvZXGGEzdsHflE4?=
 =?us-ascii?Q?PC4CfbkdUEw1r/EgYSF4rl6opbEd+pBEUnQ2M8cDXD6wpMN0DyFyuVhsZbny?=
 =?us-ascii?Q?8+M2kkln9qYsbnDXhkcORsePqXegc1MqQXsg9jXEJWYFsJCue8iMQky7AG6V?=
 =?us-ascii?Q?c8fegP7hT/zrqbVr1qMlB7IdnCaGWUd7awYOWkfZ9C/MDhqaCr2oCLVnZuIH?=
 =?us-ascii?Q?vzAicv5+7iHI3ErMiUDLJ8Tn4KwcmEUSzDJfW/wgZdc3optqkat1Vc1H6gzz?=
 =?us-ascii?Q?jIbrN6deWuoyyhkmOhnw8iYUQQNCH+EosE5M3z4YiEpsCpA6rUQcgLTMBqps?=
 =?us-ascii?Q?AF3ZT4uJIUC5ikoE+ScoDFn3r4Kai7ptRA6Nf6aN8cF3NUWV55gpjbzTJyu2?=
 =?us-ascii?Q?JW8WfK5FK6fbgijjMJATA7Jtm48/DFMfEBSPvFzNeCEuB43leX5cJYGHk9ka?=
 =?us-ascii?Q?RjSD66cReFGUKXgSakmQmokSAzB3v9DeW3J5Oh666ZceWAV8bTBetJPhq6iR?=
 =?us-ascii?Q?vf7gA50xmVaMFWaGSAH0izdLSSHn/eoHj7AhgAU8aNJAvIH0RVH+j2AYIOdl?=
 =?us-ascii?Q?Aopx67ZEEieOk06fp6JWxyzMsxusoM58zh+lrwE3nMOGnWs4sO4bT/7IPEoz?=
 =?us-ascii?Q?3ar02CPAw847bsPDo6Pv9QB1bv1uXKRXi/ny/rzntIIVG+K+a1c2lcgqk3ki?=
 =?us-ascii?Q?edvZHYqryaxY+XJn4PO3d7gGj9r0qvL7DogzrXAUx64XPTF44Ss819MAkNse?=
 =?us-ascii?Q?WHbPvmHON0NRaWvw2E4KvopHfZflyyaboiB/WGrO4bdBzvHID6roo4Y9pIqD?=
 =?us-ascii?Q?Hv8ppVb5LZiq63P/SYTBy3Aox91x/OBBK2Y27JbtDWkK5H8TRKqHsFNKiNit?=
 =?us-ascii?Q?tXm7j82wZzYyr4CBUBbmnzSh9pXuq2KpSbk2RRGodVghDPgz/WGSmMc/HWdu?=
 =?us-ascii?Q?yNLd6aI9XUuNmP353nQI9DNsaaGrOmjEBFpIEC9NOjBZnJLzimdRAasVIrRv?=
 =?us-ascii?Q?DZjAM+ZeAfw+ZqK1v6AOC6QQZAZTsdE8PyS3AGNuS1cNKST3laeYWgdmhUEN?=
 =?us-ascii?Q?QyU25ZOz8TFHUHca7DFPUu0ox+p8AErLmM7DeFx5PYuaI6ti4iyB5levaFDF?=
 =?us-ascii?Q?R7N0r01O6xIDnpXzAp64U0ffl/TWwRaVBMdhHtoep3sFVAkHzcFhFNomsPe1?=
 =?us-ascii?Q?0PUcX43c6YNSDztFLjgzZrZCPQxTWewhybB6knZ/XKl1Nie9MTs7+FrhxKlD?=
 =?us-ascii?Q?/BMWrvcjUKE7OyjTko4DRGAC/MXIxedBpa0Cs3/hrRzdt8IuXCfxUliZ03LE?=
 =?us-ascii?Q?CgU1OQ50IIsLe0ctgj0xaD7o+zymmS1GoQk3PSCqiSELPhUYET5aeTxF9Hfw?=
 =?us-ascii?Q?7Pk4yjzDJQiLAf+FYIW4bGV5fnPsP3W2cGinq+1eOj9FieMUZPUdyGjrWZHF?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6l0In6VKbF6m07eVf+xEqjhD3VSA7HwM1ZRre+kX6PDzO8TfAigI0kf+pc8tDNgy4V1PIfx25+pLZtf5PHVqk6SoL661Vx5lTOn1PWM0tjefE8pw9C6mRdtN/98vUGYLG/ba9ARY2lws0bEQSORIpG2kAh7cqoikJp/j3UVe2nP4R0luaYdeS1N3Tk7pC+j43+8Lv9n9bAda1reTB3s+PPYb3vka4zmXJJnI9c79jNiDO8ILSBOKrNLxG79c9mXUZqtkeqY8QKmD6CePlZ0/e6Z63M9aAplFh2PTVjcdtfQtYfBpajkc1SoBScGVBpS0Cd1jKIXXs/TcP8RQvEtF7ZCHDvSpHJ3p7UC2Vk2Pr9ghE/9VOm6sM2uBEfs6ykGrYTxwHFEtodPp40YFYV1psweWoqOX1syXryOvDb3ywpY+7pU6vbOdlbzeGC9dqZjqfbuRr6TrC1Chm5M18e2zj7nm0r6YUC3GPZLgJbvbvZNU0p1/N7LFAxCDWPaHCSU39SbY8z+0ohY5wViV6ovVziNhS/DJi7FKWf/glAxZdzBPsvlBJPjyx4l/qY5Q1m09eOnHN8/dhAUK9XjzxUC/UMhIccSe4ckjDfJh4a1EMBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6344b4e9-d6c1-4798-b1ee-08dc9c57027a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:49.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOfMaTlvOnxEkasW2Cpcic7YRz7v1SRoUPI713b4OO2mUm4iwB+pvmWSnGUTiqmAhdXaD7CUEcS0oq8YO3XvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: qpCWcEOB7OZ3GNrF1LOKsvGRj35glK6O
X-Proofpoint-ORIG-GUID: qpCWcEOB7OZ3GNrF1LOKsvGRj35glK6O

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

In the case of a driver mapping over existing vmas, the PTEs are cleared
using the helper vms_complete_pte_clear().

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This also drops the validate_mm() call in the vma_expand() function.
It is necessary to drop the validate as it would fail since the mm
map_count would be incorrect during a vma expansion, prior to the
cleanup from vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |  1 +
 mm/mmap.c     | 61 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4c9f06669cc4..fae4a1bba732 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
+	bool cleared_ptes;		/* If the PTE are cleared already */
 };
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
diff --git a/mm/mmap.c b/mm/mmap.c
index 5d458c5f080e..0c334eeae8cd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -401,17 +401,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 }
 
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages = 0;
 
+	*nr_accounted = 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
 		nr_pages += PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted += PHYS_PFN(vm_end - vm_start);
 	}
 
 	return nr_pages;
@@ -522,6 +526,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->cleared_ptes = false;
 }
 
 /*
@@ -730,7 +735,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -2612,6 +2616,9 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
 {
 	struct mmu_gather tlb;
 
+	if (vms->cleared_ptes)
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -2624,6 +2631,7 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
 	mas_set(mas_detach, 1);
 	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->cleared_ptes = true;
 }
 
 /*
@@ -2936,24 +2944,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
 
+	/* Check against address space limit. */
+	/*
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;
@@ -2971,14 +2974,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
 
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
-
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
 		vma = NULL;
 	} else {
+		/* Minimal setup of vms */
+		vms.nr_pages = 0;
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
 		if (prev)
@@ -2990,8 +2991,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
 
@@ -3040,10 +3043,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -3052,6 +3053,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
+		/* call_mmap() map PTE, so ensure there are no existing PTEs */
+		if (vms.nr_pages)
+			vms_complete_pte_clear(&vms, &mas_detach, true);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -3142,6 +3146,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	if (vms.nr_pages)
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -3189,6 +3196,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach);
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


