Return-Path: <linux-kernel+bounces-571990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8128EA6C512
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC7F189CF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8622DF8B;
	Fri, 21 Mar 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ERwGx4w/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QKL5aI0C"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8B230BF8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592268; cv=fail; b=lMpx5K+W623wvmdY8ODXzg6ml92EIoOhM2JP7Nskie347Re5L4U0E6D3S27D5MbxY0tXWuO8mqWZf7qO7yVMvTtm9HvlfXkOVpGzNzADO/yqCYIGn3vu9mpy2vaOZ1QbsbZNz1BLDmmzAbqNI+4mMtAeWvHX3c0OnZXfuYj3wJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592268; c=relaxed/simple;
	bh=CuVSFsfcAAWzYhPeJmpx2HylmaLxLhtKSkyCoPiw5mY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GsbvV/S8T/AMDURacPZ1TGpbXP8aFpte8bLrPP+NKw63p6NrydZH2opG6HbJwd+8xj/+bBustFQAuLxLXFsPHEHrNdAMydI5pOO/xAg0jrfJBxwS6vz+B5daXNvIk8VF2oa2ZEGNgej9qkk7KHAwJRcm5RhWFQOf5XDdXB1Wg10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ERwGx4w/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QKL5aI0C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKftEu031810;
	Fri, 21 Mar 2025 21:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jCOVVDLMrEXDTBuvzK
	Xhd8WDrP6EOfHwwB1wN2AgPTI=; b=ERwGx4w/wSLpGST+DWc2YJgXYqRw8EENVE
	V24OdRTt1SVQ0C4xZQ0Sq8T0zVpEmNeq8PCMHszXAZc9udP5Dr0dMSwfu+zWU1Do
	XY/gbm5z0dB3h6flK9b+WCpDSPOXF9DDZ16JbS3UOENPtfwargc+LcqXnTi9gtqx
	1DoDSXc/BY9E0TgLVP7nT8ZtlrLRhpK0ee4G/wM2Ir7EV5NA10zpHnn4Nmo/Elcx
	SN4M/RZqaBwBHVdc2FxZrj1CAzVkuF76EaVrcPduxKr9h3lh5I79/XAciKTVwjcy
	hp9J8Lxp4M01e/Lw0F2EMnPNEiZ5EPy/qqtpCqiHCuQObePLDF0A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbhw9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:24:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKFplM009749;
	Fri, 21 Mar 2025 21:24:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm4mxwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezDXMTzZtUdeJisBR9fpif7A2KyABIW/m83p5tYYXKbUYf4ASoIy504HtzNytLGLPpQZNLdzOp/sjsRcaqvwKet0kc7TA++3wwm1P7GzVhl5szD12Wtr46CzFiwk1ao/qoF5w3K9nqNwV3tQCNr/RR4KMl0LcJ9t5IR0kQoPl/fV/is82biDn20bdlqkbPd5gk+Yqcne98KPKBQAICRWeBMQb0JAxnzX8hgISFE0/II840mPYHLUDWpMw0YQ71wKQI3wKNuxbWypNAwdmPaL/zE4k+YbRHXLlFmpGgy1C/XF1WdqDmbGcYlYaIIkILtsZ2upm1oJ16+b6rLiTJIv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCOVVDLMrEXDTBuvzKXhd8WDrP6EOfHwwB1wN2AgPTI=;
 b=DsbKRtxb1kCVInqTlSP6+d488F2M+k6+uE2vLamfgsMyT8hcFPtWQ6xLpzImAosFwUQI6KOjF1W00Ve6Ys3AXNheDf8eagVKVTK7SbjwOnI3aiturjIlKtlBY/yru+gfhnXKhqMC4C84F+0FI6TI+ocIIamOnwCdTi0zJwAGS3xBKBIJaDfFvHmXjvTvzPDY0zF1akB+zWd6j//pfD6hFs1W0YxDByEXBeq8lOfPyaBl3bCtK3tcx28/dSME8gs8uZuA2vsN04jPT22fPUNh4uORffJv05MU68Dw953N2RFJkFpCbt6lfu4VTA48YxaQSwFm/p5TxqweB7j690NsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCOVVDLMrEXDTBuvzKXhd8WDrP6EOfHwwB1wN2AgPTI=;
 b=QKL5aI0C2vKgXCwMM9PJ249fhneqYT1u8FX7W6OGsM3Wg/TKa+XWjM+5jKC5BFVGi3mO1fX6RGwTNl8UlYa0R2NKmwERKEtZtO5jB8wW6+oWXsn48xAdsGN5M8Lj3o8NNsAGzIS4vTKCPLtVbMnV1s4l1Ue1vR14cYwSdmV3Ha8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6254.namprd10.prod.outlook.com (2603:10b6:8:8f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Fri, 21 Mar 2025 21:24:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:24:07 +0000
Date: Fri, 21 Mar 2025 21:24:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge,
 use in uffd release
Message-ID: <9d81832d-5acd-42fe-ad16-2799d1b715b7@lucifer.local>
References: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
 <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
 <owmqbntgrnwzbjuyzq7r2it7isqjvskq5svvdiosfd6mjpiowx@gm2lu3gol34x>
 <494b3b71-4331-4365-838c-84974bbed32f@lucifer.local>
 <uqfhdwbk7rm7p4m2iozi2vbnkqrmi45qyup67eopnt5klszjq4@4ccmlhjha6t4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uqfhdwbk7rm7p4m2iozi2vbnkqrmi45qyup67eopnt5klszjq4@4ccmlhjha6t4>
X-ClientProxiedBy: LO4P302CA0030.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe98505-3722-483b-3ab9-08dd68beb6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4AsJmrWZLLoXG/CzMyyKWhmMpZq0qzDqX5BbPVUSM0HO6+mbuyeOeSG+or7k?=
 =?us-ascii?Q?frj+Hf41lg85ATMFIwqdO/hRpoe//ABSRNb/j3yV36x/nXR5PcRP2Oew1gvi?=
 =?us-ascii?Q?8YEDd2lRQYcYyGZVdqmMA5RcrMgLniYKDiCCJCNVNGb2LSDYkWXmg91a5apQ?=
 =?us-ascii?Q?MyzYkugHQ3MVFsk26S0N3RuzJAF6OgNLgWxxW/sNWR4/yMI0ma5BUI+bOxvn?=
 =?us-ascii?Q?CAoWJvPSp/dv7OGJilxyfhd2oonFhZl9I2JiQ7yVQAeWtRoEYy+TubAVRL3A?=
 =?us-ascii?Q?tWB3LslX2jsfA7KoSLeHHM9q1LxdvTNcWx2RGGlgL35OWwN2TZyKfJKDC1NK?=
 =?us-ascii?Q?VKxFwCqec/6tfDnWRkwg9+scy2M1iCJsbUEFIVZsEbzsH0SW8Vwr4K1ZUxdI?=
 =?us-ascii?Q?Qrp9Uz8Ekdu82Swmyowefsy7N9pxVZz7WI+qoEKlxXrH34Yx1Qf3mtIVPztq?=
 =?us-ascii?Q?ZzuArztJ9cDTacRKgrcclL/Jd5ZapuhTMW1exULXCr4OlSZ1yXQ6YvKfo8v1?=
 =?us-ascii?Q?aRiNlTf+DLc6+PtLtd3yJcgugqzZvJ4uVdlpXfKe7xeABN0oXA8I5bYPgati?=
 =?us-ascii?Q?jxM8+GFF3gn/vxqr5wioAlvnnQ0I7gst1xCd1EKTfUYss8dXP3wOUbvnNQhb?=
 =?us-ascii?Q?39ebmBnZrFBK6Renbc7ltTXPGU94gTo0XEMxeA2R5qtGVrS1f2TJICr+8qPe?=
 =?us-ascii?Q?4XPM+Wf8In+ORPzuq5QdH1aWoPpJIrN1nbktsYM5hYJCEBVC5KfdivM3aLcR?=
 =?us-ascii?Q?g70B0DTXFT+T/xltSg4EdA1WxsfcgYmfyPoVkB7dl9qtCdD93cpXQrB68aJs?=
 =?us-ascii?Q?EP+PSdDdJpJ+e/mEUpiFL5JZwz5zpMoiCmWxpWZKePTRIPBvh4hcVZ8Ll09y?=
 =?us-ascii?Q?uTUdtEpQ1F0bEh8DoyZ/yVZUnYWQTiaQH5HFU+tyYQ5v5lIAl/09sDBFDdrL?=
 =?us-ascii?Q?3SIADxlhTGqswzUGESkXtiPjWY9och/EzCDINZ5NlyOfNtuejxTGN0uroJFl?=
 =?us-ascii?Q?hhELStLT9ZOEqMPCXLYQEziz70B8oILTYEOWgsRD2NdEPM3umejU2kE0t9CE?=
 =?us-ascii?Q?rUOQsVvXSxhuSwtWwtDVqejxhRM0P5KaFFFkzp4ZNuSziwhmk55FufsS8pgp?=
 =?us-ascii?Q?dG0Ix9WOCghFUDUIF2jw0VgqY547xaZq7Cbom9gakNymeyPE1Ji5S1GnXQZO?=
 =?us-ascii?Q?oYO5mp7KARTjdujpIMckNuwD3BlNHDG71K4v3VVdSVRtnlotR5iRZelKez4q?=
 =?us-ascii?Q?8CEWKuyzR2MlTztR4qfYs+vw+xhzUSnupbwH/i9ngQs1le4LtRyga6HorZrj?=
 =?us-ascii?Q?1mnppy1+K0FwlXFB9AkOSSS/1i7TrPUJLZZB57S256e90C3ZmdihvI4I0yCB?=
 =?us-ascii?Q?3agwPDIaWXbgTqVwVKnNUfSA157V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M4NWCa9YO8goQA1IQD+kwZQFPyVnKogvL8TefJ5Pu+k4yZ19VfTRTIe2j+dg?=
 =?us-ascii?Q?Rv1Gz8iw74IF//pau9cb0UzA9mj51GLu5id6z4D8UAHMwv0zZHicolpGX/xD?=
 =?us-ascii?Q?o2r6YnoxYmN4QeRz0GdJZDSNzj1ARgjB/52Lthc7wbEV8RK4M40gz0//xUkv?=
 =?us-ascii?Q?92IUhvQroYbGuuK4HWDjYnfSf3pIHGRnS+/E73NY+y8AAFAYtKlZ9OmvRKMO?=
 =?us-ascii?Q?94781yfCBbs131jFKhsT5XzD3xb0FajR319CAsh2KQaiRn60o/6RpB5oc84P?=
 =?us-ascii?Q?IiIiYnDcX+af6cbsEKI4kO4SWoqMlBxW5wejtBkB4oWtlwFluyjodDPgxG5O?=
 =?us-ascii?Q?7LYfu4ylRrpHfkvxRZnqBE6bzwaSCVXM5xA8+3vtjtHFUt2aaXDwdXwlXPvP?=
 =?us-ascii?Q?r4khx9AMF+ZtVTNI4zEAd/lC0eeMETW9J6b1ne1IdpdHE3FauMnmmjdp/EvR?=
 =?us-ascii?Q?0U71xh40cwxokKFWHEVlDV66ExlwYk3Yp6E9I6WpCl30bzFWAKNqu05I+v1e?=
 =?us-ascii?Q?PZrlOm5gtM8h/wgzbFKhSxLAUPxcjRVCTTRlDMrwfcKLFCEWxbFxwqO5JG1a?=
 =?us-ascii?Q?xvjtGB8ycz0SsgOB8ZQKyi9AG7+VtsJB7YX7RHSEVbtZU/ncTe/pHNWSYDL4?=
 =?us-ascii?Q?46uLdS+udhIeCLTrgHJuzAosjlVXYnU4qs+39dNksehZxGY3libtbUAxLcNg?=
 =?us-ascii?Q?479LA1NpuEpyfhLro6Z38Ez7k9rG+QbdY1rhgkd8AN7bVV/sSeddVasX7wOd?=
 =?us-ascii?Q?H0zcc1vZwAhW1uz/FOdBrS8Ptfz71fVsVU25tu54FuIDRbaM65+MQ7BJ5x0k?=
 =?us-ascii?Q?4xrOsFvqtuvGgfRUSwZp610M0mEfzJ/PVKyDuaPOipfOkH2mgV79rXm4rwJd?=
 =?us-ascii?Q?WQWyAk7wQHpGStgTeRbA3j0HLAjj6V8oa/LoRxUDJ/oPILLxPAOrxrmaauvM?=
 =?us-ascii?Q?nHOZ9ZV108Sk8PMGa5gqZHqtLr/l8gkaNCd8beSSZawpb83RZr2h07cUxUIM?=
 =?us-ascii?Q?qXcXks1de7/LlIlFJuCt9Lhbz1W2D3QYxH6iT1fX6XKJA2XOyqylxIiep98d?=
 =?us-ascii?Q?DS7Y5zAGGFmzD1nyPtLrwpT79GhSRhYWRopH+AZSeg/xPRDq9aawt5r6XC01?=
 =?us-ascii?Q?CDZW0Znk3NJpIEXv5/T2j6zCrG6L2v5JwunqLnAuGxZSqqcdyF5L/K3jZJ7u?=
 =?us-ascii?Q?V75uVvL2AHZuqpx4tDB89+isd0cFRZMRUlW1kduKDe7RDX7nC0HoZd/LE9Hq?=
 =?us-ascii?Q?wkJFlsm/35YpZWr2hKWY+8BYKYfS0DImfeFeD+LzphgQf86LA3UiY3qGlvlr?=
 =?us-ascii?Q?Opvypjofl5Vr0C8GL9JbRh1LEzP87mCDvuEk0IKxOoTgBXaLI05FIEzN0mfu?=
 =?us-ascii?Q?PaAWu59I0yiY5AZ9LTpihcLUYf0AOoBi48Ia2lAOAn45YOgB41jrgHYgzoOn?=
 =?us-ascii?Q?WbF/4YvOXie0lVcfvjjxDyd1EN5/8gIlKlPFZNYO/GREhnwLwUD/jl3h/2cx?=
 =?us-ascii?Q?E93/zSk3BtTKPolpjb0xahvA9nUjgEgZGsFuhH93iyhDSAGhYLCV1qCMuMWb?=
 =?us-ascii?Q?PvBz2DY+Vtp6soT9JWLkq/0iGT2pUG8yYB8ugjF2qRIa6vh03lPlPzv5rER5?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	93in4Fg6oQHayfp5tS4bQPhVMhuv74n3HhsIBAHHKrRUs33nm12vfTWUxMpHbZzF3oPk9JRk2m+X0ADGF6afvwCXvsyll/6xNNlgt0AZPml3Ttz/YyXiFLePKQGZJuZOwkhI0OnN3VroirRVpSh38tXP9SD3WtFWGMO9d1ywuUCkOdkApRbACedrPV51AWRpO+/ckrhjaAHMDk6PSBNLSLnpPtFoo3/uIuQt2ZQgyhBFyKGQuOdYnuPH6xz+PYFzGxXGQxA4GVs52ljQHj46jo6+aWPsPKKwKbVmkodjqu/YjWaAeombBvEjqupLPZ/+ahjxGBecjKy+V5ewA3gxNgff8RpQFMOFHDEM66eY5FiWVnUDz3VddUd2ncy9fYfjHIWoskSEASrCiJ2K0C8CLRVpHXTHEOX+WSjdh873iaxTv66oS42cquh8Cpulep5f93gYXBe4WVU85InbGcQCAgVuoM04crmkrXQAUfT+0nnkm+N4cD9D6sQbolQCr1xElPMP/pasbz9+KPTrbProMsmmALDPWVccI694aINajfdIjyGLqadeyFySWmjd9nEPFckPH49jeqI1P7m+DoKmLNQOZ7jtZx2xJRQUem6kBv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe98505-3722-483b-3ab9-08dd68beb6cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:24:07.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjS4bEn7iPpNU0WcTYj+5K6cF9pJlHcumZNQ21jrNw/3u64Zf/anRF2r+ICOUasONW5BTkMpfnrNlTZQVDiFJbwu0zA0xjhXftMovejUqXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210156
X-Proofpoint-GUID: 6IrZN5yFjYKxdd4t9XrBO2OMzUm60eyR
X-Proofpoint-ORIG-GUID: 6IrZN5yFjYKxdd4t9XrBO2OMzUm60eyR

On Fri, Mar 21, 2025 at 02:11:06PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250321 13:16]:
> > On Fri, Mar 21, 2025 at 11:27:34AM -0400, Liam R. Howlett wrote:
> > > +cc Peter due to uffd interests
> >
> > Gentle nudge for Peter to make himself uffd maintainer :) I am not a fan of
> > this 'happen to know person X often touches Y' stuff, this is what
> > MAINTAINERS is for. If you're not there, good chance I won't cc you...
> >
> > I also strongly feel we need somebody to take overall responsibility for
> > uffd at this point.
>
> Yes, uffd isn't well represented today and Peter seems to be doing the
> work of R:, if not M:.
>
> ...
>
> >
> > >
> > > We are essentially avoiding the compiler from catching the error for us
> > > by returning that ERR_PTR(), which (keeping with the theme of my email)
> > > I hate.  It's fine for little functions but we've made a mess of it too
> > > often.
> > >
> > > Reality will probably not align with the realistic view and people will
> > > just copy/paste from wherever they saw it called... so we should think
> > > twice about the failure scenarios on code review and I think a flag
> > > (or a function name change?) might make this more obvious.
> >
> > OK so what I think we have have is a break in abstraction, where we are
> > trying to do an 'iteration through VMAs where it's convenient to keep track
> > of prev' and then people duplicating the code, making subtly false
> > assumptions (yes pointer being returned with the obnoxious ERR_PTR() stuff
> > possible and -god knows what happens to the state if not present-) and
> > etc. etc.
> >
> > Don't we just need a new kind of vma iterator that handles the prev bits
> > for us that can just do away with this crap?
>
> I've been thinking about the iterator and the prev/next stuff for a
> while.
>
> I am not entirely sure on pulling it into the iterator.  My hesitation
> is that a lot of the time we don't really care about prev, except
> merging.  Merging only matters if the vma is touching the start of the
> vma being modified, and if that's the case then we are very likely to be
> in the same maple tree node and the previous slot.  This should be in
> the cpu cache, almost always.
>
> So I'm wondering if we want to have an iterator do some fancy "this is
> prev" or just ask "what's the previous slot?" - aka mas_peek_prev() or
> something (that doesn't exist today).
>
> We also have the users of contiguous iterations which wants to fail if
> there is a gap anywhere before the end, and detect that error after the
> iterator too.. ie, did we reach the end (or is the end a gap?), or did
> we find an intermediate gap?
>
> So there are a few common scenarios, and maybe we are getting to the
> point of having a clear view of specific users for each that would
> result in less bugs with common patterns?
>
> The patters are also not entirely clear as the regular number of vmas
> iterated - many are written this way to work on many vmas, but in
> practice there is only one vma checked the majority of the time.  So we
> may be over-complicating things by keeping prev around and up to date in
> the first place.  Perhaps clever iterator coding could avoid this as
> well.

I will look at actually analysing this stuff.

I absolutely HATE having vmg->prev, next etc.

Anyway tomorrow (Heathrow cooperating) we'll be co-located so maybe a light
night beer and discussion tomorrow night eh? ;)

>
> Thanks,
> Liam

