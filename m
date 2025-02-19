Return-Path: <linux-kernel+bounces-522075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F80A3C591
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3833ADBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2C214221;
	Wed, 19 Feb 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwqqkrAg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v2BQzubI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42A1DA3D;
	Wed, 19 Feb 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984436; cv=fail; b=Q52ax9oPkhosAO1gl+Y9Rh2CrdaITpZjqWjXYPjsFRhdq3dyYuMpKe0tFDZznY9iQR74FfzYnEkdSodi4hFPk9l8erQUnfzgUF3ipUTprY7NtHCstIK3Pv3e2rmo8Hwyd+CKWoy9fTbT89M3+cG5cBdVizhop2VEuN05V5JGHh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984436; c=relaxed/simple;
	bh=yrMLp7xnrUJw//1or0p5OcQ6sPcYkTTZ1HP4eJNmnPA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=BtnvhmpVsOyy3VuyLuvgzgxSMbZQD27/PurFiPjMwxHJeijXvia42xtDNvBj4ZqQRBj4qQhBHc03HwLU5rsJqgUS8mcQftwaiLdh3NdXTcWQIbHHXlcx0lvofwVD169sDVsGXtLowqFgrXMOT+Fr5wRDuB3RGF68LFtuCeT4pD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwqqkrAg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v2BQzubI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEBc2D019222;
	Wed, 19 Feb 2025 17:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kfikKt17DnHdbH9ZgL
	3HImARdcDw0lM91p2ZeuZWaXc=; b=WwqqkrAgHfK9eKLTiC3YA4pCRXeZoLo0Xq
	VhimzZ1GEkg14daMNvYVy/5Kl/2KioMLcWmziNkbFw56k27GF3R0dFqHZaeWuRGE
	J/NKAnECpv7ubi+oPKu5D0j9xKiolZdod+2F7JUx9HaLDGJXzNoTVD+FWiS56pwS
	mKoolOMmko5GiGPkhG9VLFyn5bCgdV+wTRc/uPkFCg5saHdjAKpbwSJV8J3gCr7Y
	NizdBhFVuvt21UJqoHDDBmVx1QJMTD9Z4i7biNKVkPCoJiRbHTnGS648ZZu+FbLv
	Me1V3d0t/Iu1N/8TltRJcjvRFgl8svCbAy2UtuZV3GbmWJTXDgCQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nj5br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 17:00:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGp9ZG010581;
	Wed, 19 Feb 2025 17:00:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07dsbq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 17:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEz/5l5orTXB4ENbZQc3XIsBHozfqLdfwFcQhYJ7lxIAEWDRy1KpQ6mgFqNXgjYzEHhiVEWAArl+vuNqLqPZPsv7PahhTonaYNqEKru51USvk9P4CrKCKJlpl78BHm9tsriVaOcde0LtEnub4AsdqV8zDvWFNJJuKD7GGeOFEu3BjBLl4/bijmU08dj2yiWFMfDStci0k6OnOBGOE1mgvpeuTIjPync7/tK2bDyATFjqiKleM/0+uzdfUFS/+GVXq1PzDXd6vzKjUneB1tgr1zvIpGecnusbSTIWfuqUYanho3xJopNFKzgYpoQEIqiz03WJz/2O6ribHQwPjtOvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfikKt17DnHdbH9ZgL3HImARdcDw0lM91p2ZeuZWaXc=;
 b=YON6R2XoaspKxd3868OO6Om6LcXxztfPsWgDHbmOITn72wlmTsd3VYZwqpM6eAUiW7V/p1d9qD4KyUmO9clI8bYc75Tnsx2jBQrhia59VwONZtKVSIBF9fx98Q22+MmVwYKYWk6RR50TkJsJzaAwhfESUczZfVU5ECQzS0j5ljint9k5chWUdL0RmfMe6ixbFvXyf8/K8fJa7DSCmJ/7l54M52xkANE1uaaC8ZM8FXBkZiU3qwLBfMr0N8vhcYT/wQqIeYosEXFx+wgfBBzSFIXOwJZlYwq5spLz8N5HX6fZtjwsJyQ7+gRYM+Lpyn7xNGWNm9z4G4kHlLjuyWi2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfikKt17DnHdbH9ZgL3HImARdcDw0lM91p2ZeuZWaXc=;
 b=v2BQzubIDMortb0KlUzooKhNzBvwMGqsJ9bqSyBToylU38dBj9wEqPa8GlA0ZA88Jmnm+W8C/pz4CrGV6Q6MZsLl7jbti7Qc4A5zDvO5bIlkeiaV5TdwTqI6rc+4ojhXPwzjN87BwtGWTLPs+JiQDQNEdn741Shzsd1LmJOuoM8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM6PR10MB4124.namprd10.prod.outlook.com (2603:10b6:5:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 17:00:21 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:00:21 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Carpenter
 <dan.carpenter@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rust-for-linux
 <rust-for-linux@vger.kernel.org>,
        Linus Torvalds
 <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        <linux-kernel@vger.kernel.org>, <ksummit@lists.linux.dev>
Subject: Re: Rust kernel policy
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
	(James Bottomley's message of "Wed, 19 Feb 2025 10:15:00 -0500")
Organization: Oracle Corporation
Message-ID: <yq1bjuxncf5.fsf@ca-mkp.ca.oracle.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
	<2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
	<yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
	<c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
Date: Wed, 19 Feb 2025 12:00:19 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:408:ee::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM6PR10MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 61579b94-8533-484e-4930-08dd5106e4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MBICSf7f/paQycTfhY5zmRbNuz7VlTmPXUY7sUO5svXuZMVbCuFOLDlVRYbr?=
 =?us-ascii?Q?y/EFCDPoW+zO1gk2d9cPVERoPyCJgqG5rnCn8XsbY6iPiKCsSfA59eU4Wt1H?=
 =?us-ascii?Q?wdO0kKoLRHFsxl+b8ijVcrKwwNhkt+oZLk1nwnfU7ukNflwW6XR7Ia37Dpxf?=
 =?us-ascii?Q?O/iv1v6iGRhfr+G3+vMpxryu0ixc0JJjMalPmviLeJnKbng0zF/akj/iFqlf?=
 =?us-ascii?Q?fVUkjz3W7DD/u38YxlCmjFelL5WyhmNsBE4+q+uDbvw0skLcrt4QJOV4Q6V5?=
 =?us-ascii?Q?qiA2JIUg2apdNL4Ta7j2Dz5tzy5Wxd6XRqr0RiKaP/yUt5h7yoIAWJXlySKw?=
 =?us-ascii?Q?rPoklIXh4B2CpR6nP7KIDO7sXq37jGNG9euEtriLWHvGMO/53mEW/yFrhtnB?=
 =?us-ascii?Q?F5I8TFNfb8HqgldZRQxRboRKjREbUleMP55VA+5S1S9EAvrYlkCFpUBIKl+V?=
 =?us-ascii?Q?SQJM6O+QQkkNxCbZ2tKUtzJuF1fs/53aAKVB3wnH9M4UL/W7VKU65bZkfMa7?=
 =?us-ascii?Q?GQ1CduYjpZg/SIpQB941+JW/u5/5Ya1wTXq2uwIexz8mYZd4gVlOcCx7kAsY?=
 =?us-ascii?Q?QwslDO7cT3OT3yZ7Plp+a1IoIz8y9yBzJoo36drmXkSL0nXERMz1qve7WdwW?=
 =?us-ascii?Q?SIC2Q/oqU619iBTSLpUL5Wy0MvMorqqRDZktZknXoI7RU8HH9lWni0P19iBC?=
 =?us-ascii?Q?f4eCbhR57Dzu3RPRiZubUA9ZpjDUGdfxlXSb9AvTg2Cv78w/o+ZOJZg/KX0B?=
 =?us-ascii?Q?Kq/MaIJkVoYohtmMisMHWnhm58xBpxzj3aULlK55g4cfdrhdHRh5zCXKR0sN?=
 =?us-ascii?Q?1s6YwQRQLsaLxlGf3fuO2dspdOCb42OGuSqHov4YMeQHDaL5yPK4eCIVNCJG?=
 =?us-ascii?Q?W0EAR9vP2zCviGCkZ44Rj/SisVp1OvPwFdohwoimmCJErznV4RnRHxuplPba?=
 =?us-ascii?Q?wWbXl/ZX/rw1qyXNnV5F2Vdm1tMkrrLTz9MQyQoVCB63nw9CEMT2FF97cbCb?=
 =?us-ascii?Q?Ee10BQGWjGNvCr30Hh2Fk8KnFah+haGaBPX25XKlBl+PMicEHO95G07fMScT?=
 =?us-ascii?Q?hKDCvUBm95ukBzWPCJ5EgZ5IbHD7BZxS2UpUHFSJEgpsGduC6ap1J//gt3wh?=
 =?us-ascii?Q?dk1SnIXPBWmePKy6ACUwsj1aB6hYdXe3dtL88W3i5heN5+Fq9vQPIr3bQrFA?=
 =?us-ascii?Q?GXXD1SviaCvxLC1sPQps3+QVGvzP2K6fjX2DzLwRIxd2EsOmO5hG7aNn7yB0?=
 =?us-ascii?Q?NN3mG4DWoQmBnOd/zkhYrYzF9+W3Yf0ME7KodCAU+FX5anUpq+0+BYDUm7fJ?=
 =?us-ascii?Q?LjUYFMIIwir+ipvD1JSy4zi8UrsDvmMEh5Z/viVFlWY1Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DInwG4PuQMZP8jMDIv0wJ1+iK5+T/hpMurhqF47x4jVjHgbZceyC7WhZ2snO?=
 =?us-ascii?Q?Ks69xmvBxzgM1kgKrNNfOlc7JQFBxk1YssrZmxGiTs08HapRj91KVLl9QoOC?=
 =?us-ascii?Q?UDnsX6uJ/W6O0an+u6iqO2X/2hQQph/UPGpJ0MzJH4Eqnz0e0JUeYLk3rtr1?=
 =?us-ascii?Q?mxPvEPl/rXH+UCZip1dMPByPXAVdov2j02w69h9J5loD7lLpIkCj2O0R8MCc?=
 =?us-ascii?Q?I36b/Hp/J6d79Ob1XkeshfKwe0JDXgaxnWZS91P+b4AXiANLRNkmZgV1pI0+?=
 =?us-ascii?Q?gOoHQPj/JL0J6HxE63lW7gcbn2OUUEaqkDxwq40kvuTXp9xyUc+jS4P3fIX1?=
 =?us-ascii?Q?Yh5KjEbfewXSvo889Xng+bt//UUBSjh8gwQcqoLtwfw84Zp/NfgVC1oPzH5p?=
 =?us-ascii?Q?aEoFFU/kI86+rs6H11j1hTzphUtgwgbXp+3D0zbFkXNargPo0njKqMM6qFfy?=
 =?us-ascii?Q?gFuYd0oqlTit1aFF5DzBvnxGttE2iRjAsbgfvmyJ707Rn6MjcBv2GcCjiCuX?=
 =?us-ascii?Q?dnUKyi0tiiaRrIvys+E4NRw1i4VLkf1WUW32DUbZsQu62U2da5pmBV12mQmT?=
 =?us-ascii?Q?JxdEqzJ+12lg5TuNOpCrH+O9DmAdtR3Gf9k5srhhHvVcpxxrc1zBTXnCMOgq?=
 =?us-ascii?Q?NBGp7maJPXDcVf13R8bcyY1YRIS7FqfEyrhSXXShWcTXuNgYxCBupiMJfJnz?=
 =?us-ascii?Q?OA6xspBcJnEcy51qzUVEpWT1W9fBhYxw0oOgma2661NV7370cdxXCAr3xGIj?=
 =?us-ascii?Q?eiVeRvgLpt6fpCFPdf/0GRwHBylQOX2BDLW88QptAOWhN7sEDIW9mBRbF3TZ?=
 =?us-ascii?Q?Si+b2OfNR2mHVO75oC0Int14y8cXxj980uNbj18GGZlWB4mcOlYsm1Ex9sZB?=
 =?us-ascii?Q?KDyno7VjObjjQS4A72o0BiLNQ1GUUIFqKEWnb+YtDEWtPNvKKQndBC5D4Q8B?=
 =?us-ascii?Q?wHfJvLQgQdU+K7b4iyxACtLiGOl+q2KfRlksjH5+5pVdB9nfnSURHc+y5az9?=
 =?us-ascii?Q?TLZfu5iNBBin7o/A7aPkbdwZCFHKxtCD79ITGZyZuOjYj+uWrCmTX68HlqBt?=
 =?us-ascii?Q?KHPtI9bUes096+BdT/T88uqSuHLfFvJGsMIL5KE/V9X6VqouvOqaGxLt8z8D?=
 =?us-ascii?Q?XDdR4MK/QSj05NJ2a025EJ+V4AjkV3m38LDOWwnZrFc0tYZeNSefWSC0KdYT?=
 =?us-ascii?Q?YoUi5qlZLYmapoIUoFHDxcDtKaQfPqMQ5TWhZMj31JRrOzCtdMJvejgBUgk1?=
 =?us-ascii?Q?5D8COdrAcgQfTOFY1KJo60oPvNh98eEgqO23iQ96AQQBhcO/DewEPLVoE2MS?=
 =?us-ascii?Q?RrXGffHwNnLir5qnEmZlEnEUc/rxpI8wT869ZQXd3iXxmobu5cLq0pQBHFtS?=
 =?us-ascii?Q?2SnGGiTjjvo+nTpNLm0tvryyroK963zUEzw9FNFEJtcjTN8Jo9Pi2DiuU1cs?=
 =?us-ascii?Q?XfLjXFP2+kawfHDN7TVJVr321wT6a0oZb7YaHrwqevadCkh0irLPFxbTYMRi?=
 =?us-ascii?Q?WDB+/q1pjBUOFR/F+tv5kHO6ZIcCHyJDDrymcIz6SyBPxNCxJVyEOXV1I23L?=
 =?us-ascii?Q?2QEoG55xVPk5m/HsjS9qRSM1du41bQDnoFSTTG+Zc3Wo1qOCRhUYec9rw+sB?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DfxfzZCL31K879PlFaqPgO97QcSQEdusMX0HCfBp4dm0re9VIR0w/xC2bW4HijyaalDz//j5OVbRa9WvOwTAlVdXNh854VpAt3rgMXU8N7ksINCpfZ2ntqkjkjYEOB73OgjkD37OCKEa8BEbvhTcKaCUs2P4KmGxED3fMxwpAbG0I1ooOtm0AiJ90IRQ+EuoQr197ES3vcvtPx2+RNk0yn2fGMv/AHOCu6SRICI0+8D9yVgNlwFaKbUxqt/SK51Wm85tVcXjeHku37GWoKzwn5bAk7W7KZCtIhlU427M8ihUFWDFKpPRUYVCCvtAAlDzIy1Y+9a71ipOul/7Od1/mlj/Gm2clxANC9t0bEpbEi0Z7UDdFwALagYgapIJNL7svBbAObAM+D/4U40g8z8p0q4XjQbgjHDQ4risjZzG59Kt/iFCcuZPVME70vkUxgcTc2payrxz8Y5gxczKy2irOimQvbz6bXuuvzmXUKpRDcQYdhdiBzYeZKkI+k6y/2jHL10lDQlwsYwplylXATOt48xgsW+nXB/MsGG3faGGGHDxBEmNi4CGk4kirvaBv+QLiRryD6VGXWGxLha2L8UdW3HqHwsyzd742mSc4Fic4PM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61579b94-8533-484e-4930-08dd5106e4f2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:00:21.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P1sdCg51HR4ZjxsjdQZS64n4nGli+KtJswJNOLvqRlfOU9eTeqBTAcxkhE+IkMCGy4aSKHNL09l3WHqE6yut4brJnvmCxUlTmRhZXiEQfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=760 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190131
X-Proofpoint-GUID: MuFp0PdMup6i7Bfy5uJVmxUh9knv2Vuc
X-Proofpoint-ORIG-GUID: MuFp0PdMup6i7Bfy5uJVmxUh9knv2Vuc


James,

>> I like using cleanup attributes for some error handling. However, I'm
>> finding that in many cases I want to do a bit more than a simple
>> kfree(). And at that point things get syntactically messy in the
>> variable declarations and harder to read than just doing a classic
>> goto style unwind.
>
> So the way systemd solves this is that they define a whole bunch of
> _cleanup_<type>_ annotations which encode the additional logic.  It
> does mean you need a globally defined function for each cleanup type,
> but judicious use of cleanup types seems to mean they only have a few
> dozen of these.

Yep, I'm just observing that - at least for the project where I most
recently used this - the attribute boilerplate stuff got in the way of
the code being readable.

In addition, the most common cleanup scenario for me has been "twiddle
something and then free" for a series of one-off local variables for
which it makes no sense to have a type-specific definition.

The proposed "defer" approach is a bit more flexible:

  https://gustedt.wordpress.com/2025/01/06/simple-defer-ready-to-use/

I have experimented at length with __attribute__(__cleanup__) and defer.
I am sympathetic to the idea, but none of the approaches I tried lead to
code that was particularly pleasing to my eyes.

I find that mixing regular code flow and error handling by interleaving
defer statements throughout the function often makes the regular code
path harder to follow. Once a cleanup becomes more than a simple free()
in the variable declaration, the mixing of happy and unhappy code can
make things quite muddy.

Note that none of this should be seen as opposition to using cleanup or
defer. I use them both where applicable. I am just saying I was more
enthusiastic until I actually started using them. After converting a
fairly large code base, I ended up reverting to a classic unroll in
several places because I found it was much clearer.

-- 
Martin K. Petersen	Oracle Linux Engineering

