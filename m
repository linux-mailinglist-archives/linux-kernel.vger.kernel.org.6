Return-Path: <linux-kernel+bounces-577066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A317BA717F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B4416F356
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0A1EFF98;
	Wed, 26 Mar 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lYID8CcS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PLPwwzys"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD7189919
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997528; cv=fail; b=kYbqXf1/KCBikO06dh+umj0FQovfJDEoeC0InLbIXxkm5OLlad+NGPB2Kx19pN29C3zDKSrvP24ankTOWfRxKwC7oqmQ8h9LydDnkqxV3+OVUDzQjUNqkMpPISUkvH0W0ZhBuXfU3Ngh0K/EtqvvQS5REf4pNoKxPtFCXSd+pY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997528; c=relaxed/simple;
	bh=CqWljl5aEJCEtvmTzuf1oizNORSodxGA8c6U0ePHB10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F6hiHt0RQ/1YLgTQqy/AxNcGAubmobf1mfj7rRJHr6lo0/4QUJqsseb/V9j+glW2yIyUVG7fYMowDN7j7UOuXWUVz/8SXVN4QXlEzwpf9kn68mhmPl5ZrwqypY+GDeU8CS/a1Y0flJ7oFG9IDioyZHCPB+yGjJMm+dp9q5/oBL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lYID8CcS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PLPwwzys; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QD27xk018781;
	Wed, 26 Mar 2025 13:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zeQtBpvJcEwIqQ5PgP
	dg4L69HHSJIccCQ97J2nsidh8=; b=lYID8CcSYmy+/Nz0fvgSPoJpWuYl3AoFdK
	Roa3zLRDheEicMM9ohuJb8twRsxwCxVMYwPtLBg99GQgzozKzXncJbJ6E5xjeEvs
	h42WfB9OsZNHrjzaFkkAguzxw3gqKljFsqQ3H69SgpwubX6WQvbSgTmU3feLzITJ
	4Yfqq9KJYQ6IkFrW2uzNZlQrwrQ16HtUQWN9Ir+qWJfOw5MunqEc9gg1zxGNqtf5
	McQtVdIMJ9a2UIiRgVxOBpGjtm1LgKAK5h5hK/pjz+0wnJv++oInbxUCw5glr8p1
	oSLmCpCivKnguI80PGY9IbBm71Nhqeoik8PwxJOWLj8zVBhmEljA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn871cbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:58:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QDWRUZ029934;
	Wed, 26 Mar 2025 13:58:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc2d3wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsCFmdUJR+IzU2bddfzu3K9VtthJKMGFUejrd19y3p+4pzWfMTChd1yCHHXDiQ2eUj18lAtC4kXTXl3BrwKRW3/Aa5r/BOwT6yifLNyoHKBgjTEk7jn+z0yte79dwnhRLZpXPON2TA7HOAzmsg+GmztyzADDegy/MHksTX0GSRcJabDCyg4y944GTLT68utUaxUiDETuwGfI9j92cXyh493nGdNayW7VgjwUbxOzwYkI6ZZ2iIDVidofwecrLurYYPqOXyR9R6L65iRVpWBkDD1xfxdH4VUBqhDI7V5NswSEHpiznjFvZf1/2uU9lNzL4WjKgq5ZkU636iaF+TeTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeQtBpvJcEwIqQ5PgPdg4L69HHSJIccCQ97J2nsidh8=;
 b=MVt8+uXuV7Vx6rYu0+CG8BEogi9TY3lwkOuoRrFGL8cz36Mb9Rdu0Mir82ro0xdchQKJ5Yy3UTOQsnlE6tBBt+NjoN9dlucZRBMK8RnhaYavvNf1knILyj7D8Op0NHHzOxo/qnpxyg1h4zAH6QDDiDaZXAa0BnoW50PZGM4f0g++f3Il7ulFASv+z75JDQ+1xXVdKsNf0hqFhqz2yZ85TwucOEvRlJeIiGw1+k3evI6YxnN3Ed69t3KawcUDjncn9soN0RjRtnJ5LRPNtqA2DeZo0AAKdblEhGqFJcWwM2bXE+L2QcScz4my2Fiwcg4Bwo/Zq1u1FGMe8lFBrWbUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeQtBpvJcEwIqQ5PgPdg4L69HHSJIccCQ97J2nsidh8=;
 b=PLPwwzysvbjpEUr6jZr20+7t8PPErGzy7dgAVhFwuLCtXzUsYPNfms50rf0D/sAi9IzeVmPnH6W8VWtm+ETITEohgid71i9/rvIq+MbTy1mIMnoPby3ZwoQ2WL/302C72uaF1DXLl65eDpwuhiIjVPgBnRhMByQIThkl/4ds1ZM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8189.namprd10.prod.outlook.com (2603:10b6:208:4f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:58:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:58:29 +0000
Date: Wed, 26 Mar 2025 09:58:24 -0400
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+93107467480b9f9ed726@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KCSAN: data-race in try_to_migrate_one /
 vms_clear_ptes (2)
Message-ID: <900c5035-865d-40b7-8d55-0cbbbc059294@lucifer.local>
References: <67e3390c.050a0220.1ec46.0001.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e3390c.050a0220.1ec46.0001.GAE@google.com>
X-ClientProxiedBy: YQXP288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: c0576df0-5ded-4d8a-40fd-08dd6c6e499d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MtAI076PkCQlY0ImDBYLh7zVVxEKQpTKN7SL8oUPLnUbISte6w44pYzGjUZq?=
 =?us-ascii?Q?TN3FZ43lUTx16Mr6Y36Lfd5DiGReIoCKKdMaLYIskyTPBi2G42QlPpGuR9G+?=
 =?us-ascii?Q?2433kpbttC8crzNs8DTsnOSZInRu08NzYQ81yzkL1VQRK9OLJkoEBKt/heCC?=
 =?us-ascii?Q?ro6vh7V+SjByZsMuFJjhp2/odHGGoHaH+NJfGoLibdD15mZQv5uO/RPAXRwJ?=
 =?us-ascii?Q?kPH71+K6t5AVW4z7dRlqxgHjoyQWkfpDYn3cAcVFSVTUUyYQgnu5+u5eDbd3?=
 =?us-ascii?Q?itSiWT3ovuxhu46kDEPTo1bjF2ZrVT4mNxfP9jVF0ImMqSiKtjdZIgT7OyUD?=
 =?us-ascii?Q?0okwor/q2bkpaZjvTM+3Y86ntLAoniHAVGajvbJ88Dc0CwlqX5mI6ygFMOFB?=
 =?us-ascii?Q?SkydRG4dizinNs/EETV6edH1ka9PcODysEHQURQR44JwTFcjqmQg1NBFNFhX?=
 =?us-ascii?Q?hXaleuB9fH3OBKbJwiKslCuF+jLTyCWp0XQ91lX5HJCZmjp+eXjgaO55Xldh?=
 =?us-ascii?Q?7hOvSontzXJAQbPyPa77JS+i9W8mJokTFgPXM3ogw//x9Jydqs0GV5Yx1vTg?=
 =?us-ascii?Q?xjWQLI3eTlsG6Y9k4umPa8rpJ8EX44LyUDYGWNGSohhIv36eLwXtf0dLM9H7?=
 =?us-ascii?Q?TSlzDOczmJtFTohDezdVrStneyOMhdIfPq+01L6ph2OyIa5OavuVf7aobBn+?=
 =?us-ascii?Q?6lC5LwskON8GfheCD+/HCXjemBU6UqqAarHW4ahjzJUB/BSdtT2Ff6WPb+xA?=
 =?us-ascii?Q?1jSY9GkvpK8sTWBQ8CrSAk90H6Gs450XiGD5Db2PxyYr3ji971ga0MaQ4UYT?=
 =?us-ascii?Q?HGKE3ctbtthBY3iz3RtR/BOPdvFB5NptuJtfnsSjRIBmyrKYCvcGNR2te+Ph?=
 =?us-ascii?Q?zJYMyDiX5cKqqyCR7RtX/z5rQb6JO1wsBxk/anSEWWseYQIOW84ADLgO8HMb?=
 =?us-ascii?Q?0fnYqWziszAseOby1JQX5egk6mOxbnI3hs0haJOJGsZuTCrwi4tlu/nHrt3R?=
 =?us-ascii?Q?2xORm40L4ojhN1mz3d/IuyH8jQwIj2yi8ooaI7JbgxUl/xHqu9OGekkx5znw?=
 =?us-ascii?Q?WlDHX9J39/c+PV++eYUkI2S+eHCc6x4SRLD284LuNu+XovzZAtiBDAOIZgOa?=
 =?us-ascii?Q?lymGNRHy/t3rZySyPWXadoH358jPDoGQMpILdxP7YOrKdQKWv/ROWjP5ldIG?=
 =?us-ascii?Q?0Il2U6c2/2X5wmN3uCOVzmicP1J5hSimoPbSD2z7ocHXVMCtr0esTzdJpQEm?=
 =?us-ascii?Q?kpLFMmBDE4NF77TQOZk6oPD/GHpJ3n9yVTQ16PQlHxlODmiwxFC0fTza0UJO?=
 =?us-ascii?Q?TPEEsJ5U264Z1ojOvC+bhIY/Y/WPxncUb3EVgtIlWcWFi+pZ+IDmRhq+qOAH?=
 =?us-ascii?Q?lXhb1ipmCvtIoDBhgD4ElLMKyd+q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OIEvjTZs9HusM2OzlFLfUPtPOQyvaX3ECZBOKg/caTiU4UhM5HuEmz4T0JFB?=
 =?us-ascii?Q?mHG35zaWxkrrwuAgWd7+hoq0yMa1hqK1kDq7azsh2Mwxmlv3142cPzVAgSga?=
 =?us-ascii?Q?9n3iXbsc1yGHA7JUdZQ57wpiaAF4MO9jmL651H/TvGtD3W8soN94mK+qnFay?=
 =?us-ascii?Q?JQbusgPb+lPcXY7GGmchZd7b44X93neI1t33yKzsZ7AaPZZYE742EivuFoKx?=
 =?us-ascii?Q?DMXsMziihqzwiHg8kzRwWr0cMRlIH9qk1y8ihgO+q7TTlZv5F3gvA3zs2QMp?=
 =?us-ascii?Q?PJI6iAYvgWslAEBUoowaffaNBvSsTuP9Jb/wRl8nSsXZDzE+fxP5Xk9bJ+Op?=
 =?us-ascii?Q?wOdn2CGBl3JiIOfKaajTnQBwh1MMFUqhmJ7YtUrq6ntF4Rd9sANJ43yhdHGU?=
 =?us-ascii?Q?AN7te5PYSA4xUQrD45qc0A4OhXfCzqOKlocZI4qSxEHdyKG3xM215nUTXy/z?=
 =?us-ascii?Q?Qz5Q8JB0DtzdT2TJqBpzXIkkXi1vSoTbz53ewlVt+wgvBFR0lyT2oZU0HEJ/?=
 =?us-ascii?Q?pC7oDZ/rPEpQSpoAxmHLbQ1Wx9ZVOlqTyi617lN56NU/wcudaL+p4jtsPgAd?=
 =?us-ascii?Q?QXZnnxmalISFoh+mdOo05OPXfgWhjEEtfefidN6NlwZ9q9iKciLSzTpqGe9Z?=
 =?us-ascii?Q?CL59wXaaJFLuax+iEVVER9BXVfJTuf9Oe+EIMC1zqWbggLQDCOHyc5KwNFC8?=
 =?us-ascii?Q?CbeAoBXbmCqh+RwyhdZ+eenIMMG1lmZSa5mYjxJyeAytaBmR3UHXSDy2AsuB?=
 =?us-ascii?Q?IBqABF/vEXVCsK2mAIHJIfW+wl5qmi+jwsDkxej3mntXnKgporYH4n5Nnvxo?=
 =?us-ascii?Q?/v6GjVmvg84pY696az3NnScWOe6vsvYzXlHJOh/KctxXTK2Orxt/EHPnaxZ8?=
 =?us-ascii?Q?dKprPSTtY8GL1lzJB5WZ411OxmvKRQZqYiu30JZT6CSZcNEuBzFTDPwr+Pmh?=
 =?us-ascii?Q?ox715TctPtYvCidP68pHrpTcjKonss549DuJBvYN+IofPFjuh9ZcyRpVGkoy?=
 =?us-ascii?Q?unaHBR7pm836efGhCpqxcP/pkpUOMQRsyJPZDoSg42FlZX2+S0AxrcUTKetc?=
 =?us-ascii?Q?Znawe+qGvPu+5vqAKT+IIcFQIQexqmohx5c56hPIlKDyQVGb6CQkrflQVlh1?=
 =?us-ascii?Q?Oc5pFC4vCL+94cEY4WmURC2OROxTM/O3xh3Y/32KM/88ZoVNMHCVGlKYYi+8?=
 =?us-ascii?Q?tVbnrmNE1GG6Z3pH1IykMQpWgBmK8drbT+1/jRWLQXzZcpOPXAgWkFRZBhV5?=
 =?us-ascii?Q?SdRHqDTHnmC2euJZmtEZYS2K0drjFFqP+R9XbF/hE8Pe3vEGsJLO1rQBieiU?=
 =?us-ascii?Q?dEk0KQjIMeR2QuzLww/wuwQ218v854TDoImK1/2rNv069nREoCGHikLD85ow?=
 =?us-ascii?Q?d3cwZYaQzEgQmTo1ETn5qzEI1zJN/0wLksU4lxPobjeX0RZtQ8wEUz4XfAVu?=
 =?us-ascii?Q?xsjsBVAvxf+U2+PmBX49TUHGyM4BljD1aOsnBYo3l8I50/FeQ54sL9EhHlOZ?=
 =?us-ascii?Q?PB9jygS2/QAu4uaWuh4uGV82ZGeHVvxBHMf65zoeHi3KOHAbPX2p83KTx3+0?=
 =?us-ascii?Q?l69Zs3p8qXCXhvEnti2aSqn0fIK6EjwU+jwTI6YFxSu11ig5P44+uBSvya2R?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	enIBdgJpnWLcoDh1P8xkzIY5O+0bfT2CEboL/cq0GU1VYkU6S0Dj4NOBeFyCDCMyw0/sDYgbmBPXCvca7ZzX9qW/2uwXVtsQs0yLlwjTZOeWh2GreT0PMd95w/SMpXstrPyqRSWtFM/o4gBrVQ+nXlY8hqj9TfygA1W53wB9z1pbFbIz1SOPwaNv05YuLhL+jz1YivTAERhvZems6evtcVUpYHpwDqd16TN06vI+a3OzeDhcXt8BO3Rs5nWPTjCDIo6W9M+j1yp6VfqejMkq2ckmZxhi5RpbWD+yFbsgVBKyaAND64xh5geJDEWtiKq/z0QkWVQOok8E+I9eYm5ijcD7RAZUn11RiUADcZJbRSWd971bYp+Dc/jb7Ox9bdegvkPPvuZG/m+HN9GibVXklIqqtsnzuNH4u0RAxEKdz3edhjEzH7BtdvX/9fcV75k2HFVC8xBAkxTPAfZi3G6JB8NBtIQOgEg6UF9DuJo553T63ztnTF03oUSa3NgU0X2WcrMWhTDFwpxV+w212qZ6mXPlAylagBIEBzmO2mbvlNAj5FgnyVGtaqaRbkRQYrPZclteVMINflGTovFES5HM3Iek/fGnBEaOICptcIf0ses=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0576df0-5ded-4d8a-40fd-08dd6c6e499d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:58:29.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 167mnapHXeNSw7H/8+7zD2GcHnxO5jOEiOipEHCGMYsHqnjq27IGqiW5k/v0KJrpqFZvscLwm5WrIMDktZ1u8zIKVj3e0NaWgxhhlN1hkLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260085
X-Proofpoint-GUID: SAbXOyZ7YPaN9OYhHvnmtsx2v5elB5o1
X-Proofpoint-ORIG-GUID: SAbXOyZ7YPaN9OYhHvnmtsx2v5elB5o1

On Tue, Mar 25, 2025 at 04:15:24PM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3ba7dfb8da62 Merge tag 'rcu-next-v6.15' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14254198580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79f1cf4142160c34
> dashboard link: https://syzkaller.appspot.com/bug?extid=93107467480b9f9ed726
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/dd40b872cca9/disk-3ba7dfb8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/86a3a241fb7d/vmlinux-3ba7dfb8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1ce46917915c/bzImage-3ba7dfb8.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+93107467480b9f9ed726@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in try_to_migrate_one / vms_clear_ptes
>

This is another classic rmap lock vs. mmap/vma lock scenario, but it seems
pretty benign.

try_to_migrate_one() is under rmap lock, vms_clear_ptes() under mmap/vma.

It's an unfortunate race, but we'd probably prefer not to slow down this
code. We might want to tag it data_race() though?

> write to 0xffff88810005d8f8 of 8 bytes by task 8860 on cpu 1:
>  update_hiwater_rss include/linux/mm.h:2675 [inline]

This is:

static inline void update_hiwater_rss(struct mm_struct *mm)
{
	unsigned long _rss = get_mm_rss(mm);

	if ((mm)->hiwater_rss < _rss)
		(mm)->hiwater_rss = _rss; <---- here.
}

>  vms_clear_ptes+0x1a2/0x300 mm/vma.c:1136
>  vms_complete_munmap_vmas+0x17b/0x480 mm/vma.c:1186
>  do_vmi_align_munmap+0x344/0x390 mm/vma.c:1445
>  do_vmi_munmap+0x1eb/0x230 mm/vma.c:1493
>  __vm_munmap+0x19a/0x280 mm/vma.c:2956
>  __do_sys_munmap mm/mmap.c:1084 [inline]
>  __se_sys_munmap mm/mmap.c:1081 [inline]
>  __x64_sys_munmap+0x36/0x40 mm/mmap.c:1081
>  x64_sys_call+0xe1b/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:12
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88810005d8f8 of 8 bytes by task 8858 on cpu 0:
>  update_hiwater_rss include/linux/mm.h:2674 [inline]
>  try_to_migrate_one+0x775/0x12e0 mm/rmap.c:2183
>  rmap_walk_anon+0x28f/0x440 mm/rmap.c:2646
>  try_to_migrate+0x11f/0x150
>  migrate_folio_unmap mm/migrate.c:1318 [inline]
>  migrate_pages_batch+0x786/0x1930 mm/migrate.c:1864
>  migrate_pages_sync mm/migrate.c:1987 [inline]
>  migrate_pages+0xf02/0x1840 mm/migrate.c:2096
>  do_mbind mm/mempolicy.c:1425 [inline]
>  kernel_mbind mm/mempolicy.c:1568 [inline]
>  __do_sys_mbind mm/mempolicy.c:1642 [inline]
>  __se_sys_mbind+0xfd1/0x11c0 mm/mempolicy.c:1638
>  __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1638
>  x64_sys_call+0x13be/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:238
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x0000000000001f8f -> 0x000000000000262f
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 8858 Comm: syz.2.1483 Tainted: G        W          6.14.0-syzkaller-00685-g3ba7dfb8da62 #0
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

