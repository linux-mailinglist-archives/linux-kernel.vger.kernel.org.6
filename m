Return-Path: <linux-kernel+bounces-347557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E998D4C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572911C211C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC721D040E;
	Wed,  2 Oct 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iLtS6L8O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kw41pUSX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E211CF28B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875427; cv=fail; b=AZOPegrRStHW7K4R0RlTf5N8DzXO184h6kWLjhvFI2l8NadVFebzZ3WCdm7gB55XpUSm2JlDcSB8OEbl4XdNLnQBnRmRpytQnoYfVMGrIYIZd1aFp5+uhgpyyDGPlOdygQI9Sn0KtvMDO7fN+AR663GNnipC7Ns2hmH0r5Qwsvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875427; c=relaxed/simple;
	bh=EfWWYjML9QEc8oH709azgxJAGnn1OVBeXhggUOz0upc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TF70Q5MhOo5Yudjc/l0twHlZjkvb3wbwP0z3mfGA81QDtRp3RPeaPEDmR/TQ5lUT9JKfUt2KECSFBJ1/jqNb7qG1e0j2j4ahAnLOy9oIdYlK0SAavLxkhxaldN3lNPgfSC38AXOfZ5dUrLNrGMwIv8yVeFQ58DWKohtLEj10hMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iLtS6L8O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kw41pUSX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492CcsPL019276;
	Wed, 2 Oct 2024 13:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=eMuHgeTT+IuOE/2
	PwMsmEVq90MJaDXW/90tLOvSSclI=; b=iLtS6L8OU73tQfa13RTmACJTeG7Zt3A
	bPfdhBqnvZYEdRPGtAqe3IZWVDPBa1NESn048LtHuZHtDxTs7h5t/aZGPmHNSAuN
	M2QMQFl7ajiOUZALr/qVGBD4Rk3CWT+dn6YRqNR/YjOjLOcNS0mPTHvDr00UAI+s
	w9tpFHC5HJHS+eVJvURLEfSExCHq+3QPX4qSdbhak4xq5y8IqdCIQ0kAwN6LxjQZ
	nsa/6+XKPV1Cb4CgMJv6PScfAVzauzgcQawfG9WvI+R2u5UpudtQvy8Th/1ARA/x
	4nZPx9r0XdhMzjfIrIXlp1fJXVSEK2iHT0ckK8O0nxThfzU8fv5uRMw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9rudq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 13:23:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cs0Ek039278;
	Wed, 2 Oct 2024 13:23:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x888vtm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 13:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvkzXSsL8n4OsdseaF73K8nr02VmrP3emGScs9W0+SssjoZ6so61i0tA92JcZFuqckXtW0JvN6/mIUJL+/6z4hWpV+dnYLpDNnkt/pbg6NMMnHudtoxJ3AxxiO5VsCcfvz7LS03lEhXQ/gi68FdFoTCodk4GzPhgt9TliUZGDHD9wzPA50xsXMuZDt83TDrMkZphpjdy2VqsdNV98S1uI197onLydjLqV1uNNp2OJV8zYtb1mmTT17NNqDFUSKQRyf7vUxMPuwtVWT8mEuENY1iR2TnL10Ftz2mwy97oGEHPRKoBdAXNFkSA9kQc9ryzk5ifg34Wnco2dC1b8wJ53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMuHgeTT+IuOE/2PwMsmEVq90MJaDXW/90tLOvSSclI=;
 b=MB8MO8uD+1EYfTsofqmuvUbHXgbsp18GuqDQgDa9IGP7xuFTemk23cXGOyHidfQEdagcmRe9I0hZTkhz4aDkm86ZVhGmjYjo9jJLekNt07Ig0GZ1yAYLDWBzMKfDmMY0pI7/jFu86qmiBcfeeyMAnu2nhv9Z/6kPAqoA6gy2G7ZkiDqW6hJOgWNbt0JhAefWJcH2/Yv26DSwsQduSKdQABo/EBQyMj2qa95z7BwVnKXC+xYFngXddhF+jM8eXszxN5CHoXzKWc9VzD+WIzVM6OACoRhg8ndX9cy2vX9Iy0RKcg5+5jQNl1Stsanem0NNng8B1qWsewdX0xL0pzrcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMuHgeTT+IuOE/2PwMsmEVq90MJaDXW/90tLOvSSclI=;
 b=Kw41pUSXsVSj5yxQ8+aIHAN/IEC5gZaa4VrJ4x9hbG0NGlrnChW91pXPzOawg9J2640xgsCQ7pn+iNCXLTNueoBt8OoQLpmbI82mPKN7SVrERql4ag8um2d9v+ZVQBfAafnxjyK0CxWqKbwhAs1xAxhgc4JQbRfFZYsgsbhiYNM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 13:23:15 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 13:23:15 +0000
Date: Wed, 2 Oct 2024 14:23:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
X-ClientProxiedBy: LO4P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: e524fac3-fb65-4eab-469f-08dce2e55f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwiKUi92qDBnp/R7BPzxXT7t4IITqHpaaxa+GolNsvxoTFfghUHIyQgEFiwF?=
 =?us-ascii?Q?6yvtgJAwJMJ3EjF/9gT5IJ+OtFBvZxK7MB5VzA8D3m7dQmQTZk8IOownlhHD?=
 =?us-ascii?Q?Cphvg+6e6QdfLfDIRE06SNR0e3pbh75hXkHDYyklhmelbywWjrhvaQ8lpy5x?=
 =?us-ascii?Q?xHk4XA0mCWXpFMAuxcBT5Hrq9Ryf9NWial4azwqrLP6XPEoQuwy/hOl0TxWE?=
 =?us-ascii?Q?UMBa8B/PHrqWRWWJq0SPPk9bjtm9/2O4/MlE9QCwyF6Qibcna+OajwfX2NhE?=
 =?us-ascii?Q?/LkwvYYoPMJ0GBOOSmYSKXWhFaW3SH4qI5PsrrK0xlP96qxV4BwcJxMhRzW3?=
 =?us-ascii?Q?pCQIvmC+xZnyTPMw/2wGEAHfHqq+FYSwjz1t09ZKKMTdw3IoEQVx1wKw8EmM?=
 =?us-ascii?Q?SzpIqWXhkEIsV1kBUJiGYQnBF8+0PdykWu98DKLTIeCHZzJZGymepTeLH3KU?=
 =?us-ascii?Q?Dvh6z3SOc8m4gL0uUXi6cMtmIw+R4KuRWqaGTRRSrTFkWIurLcgs92TyH6Fu?=
 =?us-ascii?Q?2rcJsUAgnet8FloNW/uzDJ+TjU+bj6g4xr++sWY1opLZa2PSO6MYxf8Ogy8u?=
 =?us-ascii?Q?SCqgX+7SN/ZfXnFO+9Rwqz5LqgDMH3+xF2zqvnMlFV+P+/fyLQoWR/39//oa?=
 =?us-ascii?Q?HH+V4xrHfEWv5WiYF0YzbwV6XRpNWcMmxYGMjRAY0mAPzZFhylKd5vzI1uNx?=
 =?us-ascii?Q?IQRS1Vc6qocyQNvTi2ZCi9rgI3msh4cnNyiQDt5fxYkja1EStumO8TqeGFjg?=
 =?us-ascii?Q?ILURtpRRQkvc3OEDPK2h00LqFyWAfjmXaYtfgzaK1+YLcqn1eQQbc5PR4MA1?=
 =?us-ascii?Q?7TvKFsIuwuc4u7Xd9TdZEH5tdw6J5P2F8Hmq4sUacX1TkECJBi/XBPew4u+5?=
 =?us-ascii?Q?PYoKIamBpUGA/kYJ0G9KGCDGsVXM9p5Whnv+GMJW2CagIfIGXewZ/7hrG36l?=
 =?us-ascii?Q?/88dsNproNEWS6VsOEqWI6kXtQ1XOR2f7fMlssKmbG/PhNZyB+tUDJIbv2ZH?=
 =?us-ascii?Q?s7Zst1unlts73po2ueJMHFfQqUv7Xr1a0wOEmh+2gv+kNd7WBWCicrxLiy8H?=
 =?us-ascii?Q?faT7oPjHNcJP16XtKhBjDO9LS1Eb6z2fdXcgCGnprCQHx7+4cdTiqMFbf5kH?=
 =?us-ascii?Q?3bMoEz20WWQQQ1czQnwarS2HxMtSjoocRG6x6Y4rA5GNsM4eajlhcEZFktkN?=
 =?us-ascii?Q?pom2ePir2GTMIQ7/BSEYvRRETSvtRNj4oHpivuhrlLqVoP43N2tzyHQw5fl/?=
 =?us-ascii?Q?Mikjh1SRNO295bhvfrn6aVEuc1HEUjXoPi59yTGq4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dI+WH3HFj4zDKedup3/Hdf/aHJqWp4ZrrFHpDt8osZVRGK0Mp85lFwJf5Yvd?=
 =?us-ascii?Q?Bm+GktHopYArM1uOhP9Q6OwcmJcoYC38Hrf882ZiabTd+gp2BnBdcLeSj1yw?=
 =?us-ascii?Q?q8qC46aYaKk9KTPezT7OHMpaQJtYruBIdwVWl+jUAmQWTqOKe/4GMMwElpkL?=
 =?us-ascii?Q?DeqT+fb+OmOYNPjWTp2cUbn6WJVhkeFMEc5j2wxTcloSHRSiKcpBA08/4cIF?=
 =?us-ascii?Q?POm2hp9GRNeWbWv3PAxr2ee/cfGsQNcEubOJ8mI7OUnK68336tukAfzzHfGQ?=
 =?us-ascii?Q?aF6UlW92N1LX86Ue9xXUCQjpjdb92AGpQyFA69jNdeqIyrnhnGq6qeRFuG8y?=
 =?us-ascii?Q?AOUvnwERja7rjTEMcS259YJdHW63LDZklKd/I1wgxb74zwK7lVc0BkDT7BCz?=
 =?us-ascii?Q?ckWl1BuUlb89xe7MVPCeXzPmoJ30n/ZtcsnsBkqkjEo/6J97d6B8c1jI1oQv?=
 =?us-ascii?Q?gcc2exyNJgRLaeT1Ey9145y95wBfX5SmvJv+lVNwefqKbLyByrEB9TDLy3P+?=
 =?us-ascii?Q?1k/rANQGjUtocre/uQ7wePQqMXg9fHyOq/xrFISmN1TJmUoOghyZetpIMJqE?=
 =?us-ascii?Q?0NX+HWkqi+Zr86Tglnc5FZ+KDZKi6S9YDaBkVvVvfhnTQS01cLqT4iIoBfIV?=
 =?us-ascii?Q?tFU4ADMpciyKNzScKMDVfO3TtxlulF8qLx6reGHvbtvHnvp/fLlmsTPpcW9u?=
 =?us-ascii?Q?WLuGgblimfax8YDFmFUemtEqL+hSbPLPswIH52kryYacdJnW4tm+U7pyjCqX?=
 =?us-ascii?Q?/fBNEEEesCWSw2u+6B+j0hw+R8Rn3h9jt3XgpGvDBaw/y6NG2owqfx+KvCk7?=
 =?us-ascii?Q?O8ADrA/IOEJ7gOgbinTbGJBfSbWVyQR6LTkwh/gN0MoAVcbwfGri6TfkADzf?=
 =?us-ascii?Q?vDDGMhWN+To+MP3OtdsXrzsQt2V+Zxc6/+4ocGw7ilPPEW3Ilr24H7lxxh2a?=
 =?us-ascii?Q?FNmEmPmplhQ5mZR2EG44OUeCgEuElJsiY6Ilqh0+YSde6C2eiQqhmBZ5Ah9Y?=
 =?us-ascii?Q?KLPDqugloK304Y0rf2I2zFcFgfjtNohsgF70cB6xjH1sAYoe8CYoYtQ5r4m/?=
 =?us-ascii?Q?btpHzWH4pBYuaIJVyZVbRKQzuq84Sm7E8Az/c6oCqJ8Qf8v6VOu5+BnRIHtf?=
 =?us-ascii?Q?GkN0/DS3e5AxkdhBWgqD+tRoFqab9kjs2qTG0IiDbYV7w0sRtgCVIv1n0pPs?=
 =?us-ascii?Q?kkmIUPEr7rIH9LKJTGwcKl6qr5/bYGlWN9jL2hj+vB7StMfGbpvON4KK9yb2?=
 =?us-ascii?Q?pVbIMvC/sD6wALlgnInoU33rX/555Bx0g/jkIx0wD/Ch/g+TxXgSOKpasPdT?=
 =?us-ascii?Q?FhI0rBPVPNd2XMMTltAQASRV+Zc0OjUtwILvCpztjUlwzFMtaH42KNecn0qk?=
 =?us-ascii?Q?DH9cYLfqmZJl/X63ATb13/H9pzfWw1FanSayQQIuTJZQQpQJ9DsBjkwk/VuT?=
 =?us-ascii?Q?oN+Yia5ZJsWvXHLGUHmeMs8FvnhPjDcDegxCH/ugijuvafSDxRgvnlUu1lrS?=
 =?us-ascii?Q?f/MntxxvWcsk6SVFUTh+8/ono+X5G7UA3rSikUBRH9maKJNcaM1/T4kAz43e?=
 =?us-ascii?Q?2T/pu+IqwLwkWO/7v3/aIyxBe4Er3lydK6gFSE6HtI7wEm5HbVe/gjNNWOYt?=
 =?us-ascii?Q?PoKIICWbvVmrW2ivA35yPTfi1WBi84r4uPz+36M7akzJXju3zYqdaqiJrhQO?=
 =?us-ascii?Q?449HbA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQNoa/LzXEsXs2MYFiCJmpzTgHZF8NXNZBJDBtYM9oESkjoPM6ttIpt9vtwzTDLM3BVu9cTkUlGIYXaSGOZp9IjzNJM/+vMaFA4HTZeHAP/1/nL58D7ffz5VC7wFJEDi3mvTt0S16Vjp7URGuYUuo1yrqEQesboJ9mNTG6vz8jDe6LnYZ5WGTp7xx2BTBtSQqCJgOOWiEN1Bgkc5QOfHu7R0O06u2w4xLjdWUAKSIt9LAr2Kd9YOBAhiA3zrfMibryoRCE3xH9dj84dxamsOJTs0L2F4d98pKW0W8Ra8+raZh7dLA7FQrERx6WYBpYfqZJr8e53naAIx5qxwIOb6iFiH+Xgsh3EuCmz2I/G2sBejKLv7itIj4FEuBXM1XcRDuktGGP3s7/F5lIE+WSG1kVg7/EJlicsnyPyoGt08QWUXrjetVi1Sx872+PZ2YAqLkhfumpWSRdnVmYuESJzKYOXcgQsTePvCu2VPqwqi7Ya9tFpBs9DYVZGiUWQRuUYDsr1cTFFOb2MSKZDlXLIvfpH8Y5tK0KhmQ1WIV2GrBpqR+Nk1Ir6VKssKkTGSxX3TFpzYxfOJROxvpsqzieH7V9uTuOdM8VSzt6VjbYU/s6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e524fac3-fb65-4eab-469f-08dce2e55f13
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 13:23:15.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olwegoL6CpEbiJovnApzqK8CmI00G5vANRWBTB+L3HNrUO6IIQPmhn0f1O/kyOVt6zADqdZcHmMWocD3dipdkXgCxbAcCfiordt0ullqKY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020098
X-Proofpoint-ORIG-GUID: nPwniD7YsjHTWhKN5mLLRrCu7YjKqHHt
X-Proofpoint-GUID: nPwniD7YsjHTWhKN5mLLRrCu7YjKqHHt

On Wed, Oct 02, 2024 at 01:13:16PM GMT, Lorenzo Stoakes wrote:
> On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> > I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch
> > (commit f8d112a4e657 in linux-next tree) leads to a severe memory corruption
> > error under these (rather rare) circumstances:
> > 1. Start a 32bit windows game via steam (which uses proton, steam's version of wine)
> > 2. When starting the game you the proton version used has to be updated
> >
> > The effect is the following: The updating process of proton hangs and the game does
> > not start and even after an exit from steam two processes remain, one of them at
> > 100% CPU:
> > $ ps aux | grep rundll
> > bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> > bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> >
> > When trying to kill those processes with "killall rundll32.exe", these error happen:
>
> [snip]
>
> Starting a new thread because lei is totally breaking with all these dmesg
> logs and I'm struggling to be able to reply correctly.
>
> Sorry to make it hard to follow everyone but there we go.
>
> I have tried to recreate the exact series of anon mappings and it is not
> triggering for me, so unfortunately I'm going to have to ask you to try
> something else.
>
> This does sort of hint at it being maybe an unusual code path with a file
> set (possibly...) - could you try the below patch on fresh next 1st oct?
>
> You can grep the dmesg for 'LJS' and just provide that if it triggers,
> mostly I want to see if this (unusual) code path triggers. There shouldn't
> be any spamming.
>
> Thanks!
>

[snip]

Ugh trying this locally and trying to repro now (and not succeeding
unfortunately), and I realise that _does_ spam because apparently it's very
common with steam to be call_mmap()'ing things into VM_PFNMAP (who knew).

Can you try this instead? Thanks!

----8<----
From e69b8c05daa20921bd86ef604982297bd2ced663 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 13:04:55 +0100
Subject: [PATCH] ljs: add hacky log output

---
 mm/mmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..e513eb3721a3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1463,11 +1463,18 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			unsigned long ljs_start = vma->vm_start;
+			unsigned long ljs_end = vma->vm_end;
+
 			vmg.flags = vma->vm_flags;
+
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);

 			if (merge) {
+				pr_err("LJS: HIT CASE [%lx, %lx) -> [%lx, %lx) orig flags=[%lu] flags=[%lu]\n",
+				       ljs_start, ljs_end, vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags);
+
 				/*
 				 * ->mmap() can change vma->vm_file and fput
 				 * the original file. So fput the vma->vm_file
--
2.46.2

