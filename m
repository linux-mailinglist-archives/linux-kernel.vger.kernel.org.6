Return-Path: <linux-kernel+bounces-363731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7299C649
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662F92854EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBC154C0F;
	Mon, 14 Oct 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hhCZToAn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q+SOn628"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE121527A7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899226; cv=fail; b=nR67A9GF6K83eVNuMPmekEhPBMrr86diywKRGjXeYAG7Eo3dw1dfkKRJ9FOIfxAj1b/9/WRZ1sP4FqYe5zbVRidu3QWF7WdneMA1z9btOFMIodiK0+Xq1Ff/mvxaSBI4p5/cIsp15p+vJHiuZM6j6EUEyZtQSPoYLOx08ln24sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899226; c=relaxed/simple;
	bh=FJQf94m0IgZ21f1VWWmcxsj41TZz8SZlULocXiGhFQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMK8BN+yal9dH4HNl6KvA6l31LU052OJksEy4Jidx2QagmnLp5KKGqOCFGnNdlANI/egyl7JRd2omCFv+Ws6V0boZvYCpEvn279pjJ/cqzJVV9weojYVw7oXuXOKVqXzt4LGN1JGe3gMQUkqej+/5BwqgYRd7TmNgCzSIxOLfEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hhCZToAn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q+SOn628; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E7faQn017956;
	Mon, 14 Oct 2024 09:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1m9RgbcrFagmSyao6Q
	7rYCOGPK5y7DJdiK+aRzNpWpM=; b=hhCZToAnxQOgdD6uowDUosSywj3lbuh/w9
	HWYSX81L4cbRFDBfSrQwo2fE80A8UUVahcqCMC+WBc8Eyto2g4rofzHiZ3wqkVt1
	OMLb9DxNWznOq7PxPh5/Bdw7kYyu/9ms0Iph1J0HXjdcbNOWFNWW99N1zlYo3fsN
	IirfI7WddubUsTiZp/MVthcscCAyjx0ESe/eMaWYPluiKbT43OA3mLxVjs2vfKUQ
	RK6awBSISkIs482xqDyOQOLIP9nZbls0vd5Iuw7n+nXDki546uUFsKMKgO4isO+z
	MdBNquI4vkias5DrQkbq8KIOopWG3bYgpgiUsT/OC/dQVokybTFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2dyrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 09:46:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E8InXP026232;
	Mon, 14 Oct 2024 09:46:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj5v64a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 09:46:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SabVpBAQiEo6oqpYQVkWlXBKLAEpLveAURrd5ydqeql4dKRsoN630ePPbqIQoIPkQBXR//vPY2Zmerv3OWMgLGJrTfSfc8OuLKan48mkZUo59TBcEz3KK4hChCVXdiCZsn9dTZgkF8qljVeBkZZhyan397iVxRLs8MdjG5M1eATUVAHdEMWikUOVr0kpV4IuP5Z+abam2FXpkAwUahTW1ydotaW+/6gvcV67dsB9xO+MJMKC+xgTZSUdjKIT0cr7VJSXpXlaL5n5b6TjaNbqWE3zzd6QIvtRhjSzfrTpT3tYgDHQxWFdfTCtx+Qaj2XlLg7sgDiJbw9GRptlXaStNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m9RgbcrFagmSyao6Q7rYCOGPK5y7DJdiK+aRzNpWpM=;
 b=sKCADBVPKOyUJyKtfqdy1o3OQCbBsBxqku2bg5TyovruP4m0qag8y3FLvB+CuGC0q1Egrvt9veScyJwZ+SozbGHvFt2raG6Vqtvk5UHtml4a5B7LCOJ11tAJ7qyVsHc5WQiPDzF5/GJQNjTseyBQjCE8CMDBfrzZCf9zocnX5DgRsD0zyEEEPCAXb8+25c1q2jZVQJ+RXjvU+FJgHltfA5t9+xl4wLXN3BZQ3/VdII7/UkNV29a5XHw/NOar6+XEWDz6DJMybrq1Ws0iYpkODEqPn0kN20gC2p1mBrQfxdtu9FqqvoYjEDdjONcczH4j63A8TyzJmdeCt2hLYFIDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m9RgbcrFagmSyao6Q7rYCOGPK5y7DJdiK+aRzNpWpM=;
 b=Q+SOn628cl+f12Jp/KKAsVvSzl0IqTdxIvZ8Ep39MLOJlTAKwydoMCbug2FKt+IKSz9LHSXi7gNnXS8XOVYeyp614RIFG2qpPnF2YPa33/b9/eiuworWJdO0dhTX+ZtTeddoD9/udHNclrspA8gcEMQCsvFO/TCJRQVNJ1PWkQU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7192.namprd10.prod.outlook.com (2603:10b6:8:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 09:46:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:46:54 +0000
Date: Mon, 14 Oct 2024 10:46:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <02217d08-bc08-4ffe-8e63-07878561f9b7@lucifer.local>
References: <20241013223601.3823-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013223601.3823-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0390.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: ca79e471-23d9-4573-9088-08dcec352326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/+wSdwSctmgGEFyvLzYZH7MvNoI0/iQyAPvWccT6QqYK1aiextBz5D2DriW?=
 =?us-ascii?Q?mMobiUSoN3sh0ox6g26EH0GlQUggKKGzwmLjjNJq6ROQ0BZZbXrCBd68gwiM?=
 =?us-ascii?Q?X4BC+GcDMlvhVbKr5mNgHnF5gQ37bwwqh3Y4jPYerIWR31D+O3s/BDnPbMOA?=
 =?us-ascii?Q?HIW7PlAUkKWKISlbhn4+/zSaxQadeFL4lW8v5D0dT/gXTIujVQN+vKaxQVPF?=
 =?us-ascii?Q?t4Z2ozrFSKtP+qxdPP60IBWj0bnPbgT+q6OTofW7y85X9Ys/+73Zh9t9UST9?=
 =?us-ascii?Q?R92PxefWII7XJ72IfnIu7G81KSUpp7aJrtOukVgnV1mZRG1RNknAgARFjfIF?=
 =?us-ascii?Q?RFuGV5qQ04qwMwbQytwmUmTLY3fHCxGdhsixNwNUkH7pxYt9v56M6VUDP9lT?=
 =?us-ascii?Q?2BNp6VpH4L6F110SSS0IjC3h9lsn/6aQM8f5gw75u1fBIlDV35eRUCgXFTK9?=
 =?us-ascii?Q?T5fFFo5vxV4JS59vgYqQr1pntr286+WlPHCxBlmPvP+idBqQx6BS5dBlJLwo?=
 =?us-ascii?Q?2MzsyRuCrQUolL6/KWjYb9Cgpybs6BT8rrAmzLIcF89Fjs4qTA7fLNCfj7zU?=
 =?us-ascii?Q?1H+I/2yj6C4o1qJYtFNu7N3D7EB0cgTjQSTLnOhMSRIQB6rWgWZDUXOhkVwH?=
 =?us-ascii?Q?KQ/PcNO6sne+mn+7yFp0ZWEM3gCrNCLxmEd3lGBStM0V3QHipHySctalLI2N?=
 =?us-ascii?Q?/LmjYyArF6nYZ83MCdoSWbkR5657cmEGJPEj4l1L44MhC/KBdjOfntcDXUAf?=
 =?us-ascii?Q?CGilZYcD9AGLOWpv1LrF4z6LDD2QYGhZsrgnmazt6Yd6Jbj3/DppLDrZHpJj?=
 =?us-ascii?Q?YdbKcT1MDD2ZDP2jeeCmKEJivb+LUfmL+Jb/cLPfXBTqB9YQv6+CNX6dHbWq?=
 =?us-ascii?Q?JxWbs+7+iOIOJoqDLPyCUZicBhe9XraN4g5I3APsYmS3p4AKJw9xirD6NmA0?=
 =?us-ascii?Q?T8TUlWjsA3oYBzIVoV0bSvkK2Uxo+vfRqXweS9rvVa0Mdf+xJ0oDbg/DWIfl?=
 =?us-ascii?Q?Mr9Mex3W2PZTnvDBEdfBRYEeIy83sVVO6q1ccwCLuHtSKkYVI4V3Wf2dVj1I?=
 =?us-ascii?Q?CDASbO8XuapR5TIKIhvijyzx6shNB9wTbzRvie0zvDjXHZ0Aj9u94HpwPQt2?=
 =?us-ascii?Q?+s8+oS/9TwSIC+Z8Uzj4TnazNebRH6g+5i1/wSppPo0Czh/3vdbPrm6NQDLl?=
 =?us-ascii?Q?1lcHoqADLJJtuDLmiD5TNZIqL2zWtmfoGLLFSUG8WFwuHsIrcJ6zxvnJbQLO?=
 =?us-ascii?Q?8R8bRHIhLBtEsaLQ1tMPRXc5NXXvqQym7dkswq3fWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofUdVZhKaLMq3ChBsJGJSimSh+Yi6QjmVZVK4a8mgVhrwZn7UCxpXBoY0TN9?=
 =?us-ascii?Q?WhIW5N7C2XaNG+HqJzm2gHg7RLKU6EqI/lvDQfp8AEqr6ln5k4BAHp3HZPdi?=
 =?us-ascii?Q?VEsxhFR8t8oqs7vrSo5TBz1GetH9gWXIqVGNsuzxSWzzew6Z5uOhEMbUBPh2?=
 =?us-ascii?Q?xiM6D+WrQqL0yCTObuJDZjxDzZ7CBk+MgkY3Hdo/OMw6+FL9fMEb0ts/KFY1?=
 =?us-ascii?Q?3weQExTar7PFKPQDqcTurd7ljLTPCrwuEOL1Pv+tO74lgPm33ikSjo8MIJmX?=
 =?us-ascii?Q?AM+K2ASYhX9/mk3ushd9Y4zJzqxH/IDLPJIHGaMo6zgpDRAUGn48VcqIvmrX?=
 =?us-ascii?Q?u6xSb2qyc/ZLtGo8tr+6QgZG7nYzzwzNrcf9OG9DvRXbGvMqXZk5pA8alQHz?=
 =?us-ascii?Q?rH6GfJ1Duqt6ehTza/8rPl9mNiU2QZIhfD5LidPuW0x95lqIKSNR81quQosy?=
 =?us-ascii?Q?naQG7WQ8xkVGnX36jGhmI0bn1DqXD/+YZHynrM/0Xe89r/7UEe/EBgya1kbX?=
 =?us-ascii?Q?nIAs4xG5oJT2rPZW/ymGHrrFX/ZneiHy/lxTCueXUDY+o7J8FnnZ0RKYN9JC?=
 =?us-ascii?Q?7GLVoZmHoIwMmivrrC1Vk2MdzbIQHMZPZrvbcpXZEHPVbiSInBds0chzkgHN?=
 =?us-ascii?Q?knAZcjRBox3JtavpCjkcKQOpCNd93LNHy9MplKZ5283sfO1llX3MqTax+3SU?=
 =?us-ascii?Q?xDpvcQT8lTt2KgXZEjAXfGvJi8IgEsy40xsrGCks70DglmveIApimMxsjQh8?=
 =?us-ascii?Q?MkFkaVpqzPr/8w/0iAsNc2fB4SYnUlZS4CCHYFOLfw7s+H1dwu39TRy0MtRl?=
 =?us-ascii?Q?FUc2zc10bdpcMk6zDzFLslYwvAef8ajduPD+Tbvl9Gqb4OKcmh9gktC6+7vz?=
 =?us-ascii?Q?MX4nyB6iGLLSFMKd7vZXsr1YaEf+9RsnusOvbtncycPsXQpWYoXN1yHn5zL6?=
 =?us-ascii?Q?IkpjD3s1BQnpfqIV5IU57pBbIftB4FP5fcy/tsVrloxqgNghzjRT+iGgY8kM?=
 =?us-ascii?Q?YGjMVelrFR8kPr7JRRs5wKyWcHy/l1/QLh7gemOX/hHNyonPObATlvr7sAMd?=
 =?us-ascii?Q?9JGuCukxU8ck7KotimFmvk2DBx+5QvkkIH46fyn7DQHkBL/i6pkQGX96YpH3?=
 =?us-ascii?Q?92WOjJsqKU2MOhywZrz4fNAfCyYg1MJ4LiSyU1KCYuaLbEknIPv9ca8SXo8z?=
 =?us-ascii?Q?jrVNghB1jKdL404th6uIkbKULlNx5gRomTi8LuOR6ZtkDPlFjYrAb5PgQ2xm?=
 =?us-ascii?Q?/IpD1+IK8uMobT5VCmmVtZesiasdVF70A8d+Ls00DuCX3AsE2Xu5k023VRd9?=
 =?us-ascii?Q?gCHnQ/E+v17JLnwtikT9qBnaRsDeEcCmGNiYbSETnhJNYSbsubk5oQc3LsBw?=
 =?us-ascii?Q?XtK6WuGqH0/6A2G8nfcuCSBMhjuu41EbyMbxW1rBM4G369MkAbH+kZ5QnmEY?=
 =?us-ascii?Q?ZHloTXNXtC82b8+rXQA5XKsBprsre6OjY30CjWZuYYa+rWIodVvFwpveEFqL?=
 =?us-ascii?Q?tU01SC5jiiO9mgP6A38Ma77bbWPMGvwSUP+ghjm7v6SJHL19ts/UrhsFauAD?=
 =?us-ascii?Q?DpBvyPSHhwfHlqJWd5By2B4c/I/fOB2XWb3h3k8QgnSxYy4TQhNarsGMwvFJ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nNVnVJzEBunjmHj43dgqviBRtWEtMxJiyTqCbbZEfvIZrWtVffv/6rGcvTUPGPPjNOY3wegbMzXZrIJZy0WprufcEvtm9PDH7sxoFjZ68kLcAsrgBPcPAbqyzQhFSygm6Cdfyor4IC3tEeG8DmijcPGz8cHMSTtDqkM/2HA/YYkfAw2BPCIbr0UD9C5jTa3YGt4G67GNtBqVFXnqhLi19UKoJ03OMCbdmAUXtSW0GORS7Vjd7iBUlT7jvISG77aIBzuqQbM+cR2sjfn+Z0qa+IGpmkxL7XTxV6Rn114lNBjPWTDH4CeekdpCQC5ESnaveQRYd++eZG7QOdQfSKnzYLSSBDSajycpdtrLMOx6ZEnTWTJyKYxRTS2O+oAYR0Y6ufn6lAbVs13HjZBDpCrWGdTM5aKvMIbeDlmi8fuaR8b0s4fOAsRVBDUZgKPQaTy2G7wz95TgvDjVidiU0IlcvPaURP0NTbI7w6s6/WhsoQzp6LEeuKZneygR0ndxwwijpTN+1n/F+cv2Zmaha0r/jEI//X/zWqwr3y5DwEPnWXlNXaZL6eS48FNvZhbMMBNDTFd4FMvPQjr9vUmRnGOvsANXnZEJEbM7Fqk6tZDnN6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca79e471-23d9-4573-9088-08dcec352326
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:46:54.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5vlk2+0jCrKgkUeqwXRI3Zh0KSqD6Ejd+7vbnYi7mb78u5+uZjmMw8V2ndFYw6AkHNSzK+XyFjiCcmOVdRDH5GDJsAVon1t8dY53qJReyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_08,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=617 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140071
X-Proofpoint-GUID: YvtSbn6Hx5qlJVBz8DdFMAqMmHDAc-Vg
X-Proofpoint-ORIG-GUID: YvtSbn6Hx5qlJVBz8DdFMAqMmHDAc-Vg

On Mon, Oct 14, 2024 at 12:35:59AM +0200, Bert Karwatzki wrote:
> I created a program which can trigger the bug on newer kernel (after the
> "Avoid zeroing vma tree in mmap_region()" patch and before the fix).
> My original goal was to trigger the bug on older kernels,
> but that does not work, yet.
>
> Bert Karwatzki

Thanks, that's great!

For older kernels the problem should still be present, the fundamental
thing that changed from the point of view of this bug is that merge won't
contribute to the number of VMAs being overwritten at once.

To trigger prior to commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
in mmap_region()") you would need to create a situation where the _clear_
triggers the bug, i.e. you must consistute all the VMAs that are being
overwritten by the store from existing VMAs you are overwriting with a
MAP_FIXED.

So some tweaks should get you there...

>
> #define _GNU_SOURCE
> #include <stdlib.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <errno.h>
> #include <sys/mman.h>
>
> int main()
> {
> 	int ret, prot;
> 	void *addr, *tmp = NULL;
>
> 	// Create a lot of consecutive mappings to create a sufficiently deep maple tree
> 	for (int i = 0; i < 224; i++) {
> 		// We're creating mappings with different PROT_ to
> 		// avoid the vmas getting merged.
> 		if (i % 2)
> 			prot = PROT_READ;
> 		else
> 			prot = PROT_WRITE;
>
> 			// These mappings are all at very low addresses in the virtual address space so
> 			// they are mapped before the text and data sections of the executable and
> 			// the library and stack mappings
> 			tmp = mmap(tmp + 0x100000, 0x100000, prot, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> 	}
>
> 	//
> 	// The maple node we're targetting has the range 0x7800000-0x86fffff (and 15 entries of size 0x100000 each)
> 	//
> 	//    Here is the layout of the tree before the spanning store:
> 	//
>         //                     [0 - ffffffffffffffff]
> 	//			/		\
> 	//		       /		 \
> 	//		[0-86fffff]		[8700000-ffffffffffffffff]
> 	//	       /   |	   \               /         |
> 	//	      /    |	    \		  /          |
> 	//	   ... [6900000-  [7800000-     [8700000-   ...
> 	//	     	77fffff]   86fffff]      87fffff]
> 	//
> 	// Do we always need a spanning_store AND a merge? Yes, and we must be carefull that we do not merge
> 	// with the first vma of the next node.
> 	//
> 	// This gives a spanning_store because the newly created mapping can be merge with
> 	// with the last mapping (0x7700000-0x77fffff) in the previous node as both have PROT_WRITE.
> 	// No corruption here! Why? This merges with the next node, too! (0x8700000-0x87fffff is PROT_WRITE, too)
> 	//addr = mmap((void *) 0x7800000, 0x1000000 - 0x100000, PROT_WRITE, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>
> 	// This give a spanning_store, but no merge as the PROT_ flags do not fit, no maple tree corruption here!
> 	//addr = mmap((void *) 0x7700000, 0x1000000, PROT_NONE, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>
> 	// this give a spanning store, but no merge, no corruption here!
> 	//addr = mmap((void *) 0x7700000, 0x1000000, PROT_WRITE, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>
> 	// This last example give the maple tree corruption and the validate_mm() error:
>
> 	// The mapping from 0x7600000 to 0x7700000 has PROT_READ, so this gives the needed merge
> 	addr = mmap((void *) 0x7700000, 0x1000000, PROT_READ, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>
> 	// Just for waiting (to examine the mappings in /proc/PID/maps)
> 	for (;;) {
> 	}
>
> 	return 0;
> }
>
>
>

