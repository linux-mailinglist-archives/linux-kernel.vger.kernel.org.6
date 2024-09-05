Return-Path: <linux-kernel+bounces-316195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801A096CC74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED69B2364D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC012E5D;
	Thu,  5 Sep 2024 02:01:42 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73B125D6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501701; cv=fail; b=JBQnKwg2Uzr2dJiucefGPEU19FoCTkTbO8T1/8vfoZLcduMayXaiH2nf6QEHyEs+/Dm+kpoj93mXOGQmVMcA7H24Q1zAi/0h5mssELsXI9JpKdLrwTFQYTXhzGuYl982MvhojvVrPPvcOTkNTAP5XsbEa4JIqbxzrYhDUfCPgno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501701; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dnS7vZtPhD9F282RsxygTQrbkTeW6TxDrhZg5bd7XZ9TOyTZ8LzZMAFldenX+MKV2A+toZINsF2SXXRITpwYnPSoUGnZenBJONkNMR2g+eRn81y+f9c0FtF3S8FSA+Jvh47MNX3vFBqgxWh4Uql8wRUiAZk/7DpBVBS4luWsoy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4851i334005971
	for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2024 19:01:39 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41edursawa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXZ7TgC2LDhhf0Qo2taW9dls8Talm1KR0Cv6ntciwq058L5Dr/QRSjf14yGPYQ4MmwJ65MTgoA4FrcTmyLxROALaUvksps+ZUThiaqU6uHKa4xPveYuXp9Ep0j5IfEglDndEWgAChxuVLa/hsYD7Zk9IjaEUgMAxX1mYGVAIbJ0C8Gh7ERNhU0I2lodbyKDCcNarKze6yeY+G9jQZ/5xI4D6MkYqXUc098F6bVbgwcaZVhei6/CwZUhvOs4T2Kz5yKHWluXHBmFHFeAWwJZyxcZ6rOs393z1f0pkfX7rGe8svIy/t2X5/1aiSo0k3dhhP3AaKRDoCuCatvJ2U0RmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=jI2pCfQigM83kmMULdPcv5ECnlCiW44BdAYAqo5OXV9vSdJLmUskK5HF5dEpbCSLuIXseq/sABdVd8xeZ24Td5kxSELqqEOdb8XkiAu+rRbfrnMPSP4iP3orY/GZiExyV8DSfFh/kgFZ7aK+qAkrx44fcLpg8HtEkM0JaTPG5Aa7plfxf9RyPNx1W219pvJ3HTk71gPzMgU77MOj2V+w0DNngMiJPP/kLjE2j4Coxh7afGLbGbMLI4CaZa0F5lRzvH+mytFGdgz9+d9aIHb3Dbs2ciXj4UAIuK0Enk1A0S8lC6wXp3TGHyR5mJ5BKC9qFttrQjGZz8IlJ6Psx2BsYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) by
 PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 02:01:34 +0000
Received: from DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::2155:376e:163:d377]) by DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::2155:376e:163:d377%4]) with mapi id 15.20.7897.021; Thu, 5 Sep 2024
 02:01:34 +0000
From: "Chen, Libo (CN)" <Libo.Chen.CN@windriver.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: unsubscribe
Thread-Topic: unsubscribe
Thread-Index: Adr/N4rAYamHnY+rQC2zjRHtq7138g==
Date: Thu, 5 Sep 2024 02:01:34 +0000
Message-ID:
 <DM3PR11MB87589FA6224933BB5A534880DE9D2@DM3PR11MB8758.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8758:EE_|PH0PR11MB5925:EE_
x-ms-office365-filtering-correlation-id: 7b8320ae-16ef-414a-ff62-08dccd4eab57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zcYRXi7YRmTayFltK5MzD7k/cRnqoYv7ggGPNmmmWZnQ76JyGn9UgqMSynyO?=
 =?us-ascii?Q?Kab18aN3y/kl9ryq5GL4EW69+naeuakGwXXa8M9WG8qsLDFQzhzpNHiogMga?=
 =?us-ascii?Q?EvysTpBYzWOF0hqERs3MiNw4SYGPULXVUtt3bcd0CrBUrkL6yS7t9PaxRKFB?=
 =?us-ascii?Q?wKwOfp6gYFrtdyg2DQCU8MCXMEs8QmJxpi4lN2z14/9u7AIER2mvrRnkV/9d?=
 =?us-ascii?Q?PBG1ZMn3sGrMidDT9nnG5+WLJglWgHa8O/oPCYjXtbDdmVGla2xKOVt71xtr?=
 =?us-ascii?Q?AGv9QjjJWF2VPHMS96wEa7D5EH8CHOKMLUSQc2oWVoUTIKCGYm2Nb9PLuANi?=
 =?us-ascii?Q?m+9KRr7h4WdsXpN6Prej2Nm3zPhORosgnQMX/xjZIOAo7h0o38Nw5kHS96Gf?=
 =?us-ascii?Q?kEokgkLHAEI4YyeJpmYJ08IPp07FEvw0ENyVOA24Ykx6kVsVnjSDisnqpZh5?=
 =?us-ascii?Q?nVPmzp7ZGkHaAR5YBcgy4KSZVB1WpuN4fDQWeSwnJ7Aa4OeahdGiyCwh7hmI?=
 =?us-ascii?Q?aj2YEM44KPW7b/nzFFuWfBOCjtZPREXhCV8WbaxhSBSEz4GhwnnRIHVro+FJ?=
 =?us-ascii?Q?FiXMW5/mIFISDslAQDjos0Q7DMtrfG9OgaTKWlG32FiBtSkHVrUAN7JGbWhe?=
 =?us-ascii?Q?i09x40f76k3qCTiwjrxyn6tWEUYzjGpcJrMInUfR0Yy3hF5pQva3G0g8pv7U?=
 =?us-ascii?Q?rITaa+zsYx5VkvcVBSv+Nf6LUPYiT3fkgQCAnlC2SL9NVY9ZUk5y7nmoreJ5?=
 =?us-ascii?Q?EbqwWZNPw2gWFG2JpAnUMjSBqJ0dbGqQwmUTZ/3OM7AfTEBTBm6+Zld8BM4g?=
 =?us-ascii?Q?Yms4qfc5CQNm0nYikmFcmNE4grkk1UCuDY01l+HgR/vw/lr/jqiSPy4fkS9c?=
 =?us-ascii?Q?gAWHJC0BgDAialR/seIoJsQ2zrsUm8WR8bHtnI+laKJpPCBWmaY0TlfwQePZ?=
 =?us-ascii?Q?j3jlzGUdj0BSA/+wVz7xGDOh8UKWs5f07dtYQuu8yCCesveasYKGfte9/0qd?=
 =?us-ascii?Q?WpSx8ep09TRfrmUGW2gAVZtA7alxcy8V2uuJNfXWb+daKiFHc0hz8/bseS5w?=
 =?us-ascii?Q?FllhzcvgRuk/duzmiePHGipY67Co/fJ1h/6dm5StOIgBfn9OPLFpyYWL15ns?=
 =?us-ascii?Q?gygKXWcWyFOa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/sUUwC32r58RBLmpjBqvy4lurvwelwyYqv/cj7v0xin0TJEb6asf2TRsu8RF?=
 =?us-ascii?Q?/C5dlnbEDbWDZ1hAnW0DTSiW8tJelgJdCLfgd+12vIR440k+zCyOJwXE1+aY?=
 =?us-ascii?Q?iNBZ+tyhxtqDf/pLZshj8XVC7YncmqJFNwFSP/Ayj0eLbIdVzTAecB1baPM0?=
 =?us-ascii?Q?09uVbFfyvJOpfW2o4QbH1MXF1135YwSf5BWCcyL5cgUQ+AhYHkutCfOwydCK?=
 =?us-ascii?Q?G7X290n+5CF8bq13i4PCD9hMkgzotyG7PDff3Gzmc7zUIlDTdQWewWBVSzXq?=
 =?us-ascii?Q?ic7Jo91B8DJ5iMc+e1xn4doHoUIs1CzX60BJ0jeOrywShYI03dHb+akfJ8u/?=
 =?us-ascii?Q?tXZsRF1VgfMT+XBfFgIR6nwDowmRE5sAbogI5wkR4xYDvcIBTDkHbGWzFxXa?=
 =?us-ascii?Q?oa/lJWkbtouj6wVHRJV/1hDQ1HOsFSjMpT9Y62xiR96EH2Wx8tH7hxovbgPV?=
 =?us-ascii?Q?E9DbMo1djQ1zV213CKf+rwFzUfjeLU7UDHTvyqrbA95VqY7KrNmweDF1CtIa?=
 =?us-ascii?Q?hIQ9BG5QFF+KEeTMLMwDAr5Qb6tMSmche/KGCLo3ApWJL4+xZPsnNfTq0Qg6?=
 =?us-ascii?Q?qihdHxzNZ7JFgYZu4UvYMoMmrU57/7mxhUupcZtodG8pVCSHphP7d5JrlFxS?=
 =?us-ascii?Q?FuEh/+5jH5hV9RJBv9h1++cQI77X2KdHozwVGyrzNGmjG6ZkmYoFpKvPFI03?=
 =?us-ascii?Q?FSN3UvpdN6T+7IpYjy5xNLthWVFAqFJNz0tfzfAlCRShbsNSDpHo5xYQwfw+?=
 =?us-ascii?Q?gyd5JqIhsjNU2dgW25tCHfRJp2dK1SUSRCmgc2VuH8XeGAK344DW7n5Zr1Uj?=
 =?us-ascii?Q?GIK9Ct3hfZf5KgGqKolUuA2YFT0P8QOFKVY4k+rykXvAW/QO0lBOdFpUhdg/?=
 =?us-ascii?Q?Ebx6RwNJJ4SsoB/6uvXL2LAQf0YdbGGLNAPVrZvnzU10a3mBg7jEW57hpjcF?=
 =?us-ascii?Q?Jy5SBjL/toaliJ5sq4EL31kupUGWX8qfFv6jZ2NWA5W44sCQD5dWgVQomsM6?=
 =?us-ascii?Q?tSM5f+Hdxxt6HrVkYPt+sY+M6t7QKkOAMHItZADaiX4Vs5o4QL0aaLRE11Ts?=
 =?us-ascii?Q?qadr9dIlQunC2XbQ069gp/nGqxiKeeNSkP6kTrwL/LAREj4BvwhaBDRNTiwG?=
 =?us-ascii?Q?QC5/u2PNaTOh/ukklutDKK3EME9ZWOnxYGnKZ7sMsUAp23vaCnFqWJVvh3SI?=
 =?us-ascii?Q?IH98pV0S3trY+sJEWTPqMJKoaTdzwUkntzeC/p29s6Rpdo1GoyMho1oeQHAO?=
 =?us-ascii?Q?XUwbjTyfD6ISmLBpCyANEWWC8NIucW0C5t1jsFXARovem7gI9TpBTsk/SJqY?=
 =?us-ascii?Q?IITUA1AX2FuvXP46FNdPgJmQf8+Rm7mcJ1efHqFGseYEdoaZvb4yiNQoUdmH?=
 =?us-ascii?Q?t5g12B/6OeIWgOAdGGrxLyvjyg0gwKP0L9Zgvzxmz+3gYJEviWdI6zB2Xh4D?=
 =?us-ascii?Q?+pU26OjP7T2/bme7Yzvt+T8Y0a6S8DJX2kdus9el155DFRI3OvVZEHXWUOwv?=
 =?us-ascii?Q?NikMGf7ZDF5IpyHYU1NoEUCH177aV+ubCe/rFEDpOGkGTtsC3rVolA+WpvYd?=
 =?us-ascii?Q?m09z5aM9fjc25fZrYAQfln4nxE53loSj2/JT+2zx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8320ae-16ef-414a-ff62-08dccd4eab57
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 02:01:34.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50xVUgJKnCJZ1iKOsshI5jijD4M8grwKv5OHGo9Ye+HZqPWRpRFx6h937fU2Vk6fGz1wY6NO2g1On7PNUIinJ+jrdlkDFbRJBla8hrW73AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-Proofpoint-GUID: qmx4d-DMyxOWARdAESlCfY9jxv9oPZdl
X-Proofpoint-ORIG-GUID: qmx4d-DMyxOWARdAESlCfY9jxv9oPZdl
X-Authority-Analysis: v=2.4 cv=FbFlx4+6 c=1 sm=1 tr=0 ts=66d91103 cx=c_pps a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=tclcd6dtLQvEqt9_mmAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_01,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 mlxlogscore=440 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2409050014



