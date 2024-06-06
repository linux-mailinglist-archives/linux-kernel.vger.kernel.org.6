Return-Path: <linux-kernel+bounces-204879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612528FF49C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBB71F278A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521819939E;
	Thu,  6 Jun 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XOJVSsdk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a+faXysZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F890FC02;
	Thu,  6 Jun 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698422; cv=fail; b=nA0C5fwU8HkyM+LeIQAiM5vFlbjW/p6M5BdIHsdIwQ4NzLmYThb0rJ3/qQGdg/58Y02A83GIJHuip2z+An8WAbvWPAXzrCpVxQyn414cZww+vY+X5GVAkt1ga2ki9KZIEAjsjbK4qEEGJHze/RXwN5m28hQZE7Xew4L7BZn5uTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698422; c=relaxed/simple;
	bh=+i0H9JeHNJJmdB8SsQfTwWCndVnoAnhdrJGp7rTK4n0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sK5mcMjzPRMwD0aH5FSTRg4NYMMxY9EnCml/ajvFOUMx419eXGvtC7IuxptxIsOo07vrDNMnUKcdIzBHVZdBD+ubOPqd0M9jmxyK67ruVtnKNsU4MQes+zfbmMLNlyyjV6XnC0P4GIpHwcKYdbc4FfPs8uBkULCUxpyEKMPLlLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XOJVSsdk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a+faXysZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456Hx8Pl029594;
	Thu, 6 Jun 2024 18:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=J+A0OlQp5Gt0iuZq7n9cxUkA6iE0iKjcY+A5FHhTpNQ=;
 b=XOJVSsdkswC6bXfVnz5j1AHdzJgQvrg/nDL6b+EYB2pV/phjFcybfHShjOCDbG7dohjJ
 J39S7A2XQQoh43ic40E08nstyDIsIkOopu1V7JYq5YhI4TOfsFBPQNnQuL0E67dLrW0O
 OkIXu9wA+LjqrgDRBVoZZcZAg7ZwmrsNLVIozFVSC/jO8nGGIdyAOiUErhWVPcNYdgU0
 zd+N5uzD6pGinM/cWRtkwy6hvIefs3FdDhMYt0o6bfSFgomBRBE4h7YN7nj9jG8s2NtF
 UTyKy2+OMGEn8AzhvpSfdoyEFAF1F4Z225J6WmQyfFmyGTZI6xSTlZxMeeDfEgJcVOMa hA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwc4re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:26:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456GuqXA020559;
	Thu, 6 Jun 2024 18:26:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj5hg0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9T1VfBRIrdIlfYCMpWgYTHQBo7tHyQkl5n89X2f38kH/7b2MpmSMl+f0Jaboy/Aqt9OKZrYOpY9Kt+rC/ES7AWRDYzQqHf7svwRAchhOzYQ71BDmSMEUjzZsGnJSMnXCZ+V3VoeqFzO+2MxJrn0xl2yFYcA2crnJ4kjNTXOAtbC+AkwupsnoBlgQyVJ5r7NQTZ9xDDJl+DuxcsFGuSSfY8agezDjqTUZsvnTxmdW6El2muCPXO4dO5u+Um3uN3tS3t+Fj7QC22Sy+WC7bFjuYo+ri+v1v3SV1TY+eUpiYeaPke6H3mTabMxGbQKZS/1kbLfTv8nrHIBdWkWQeqCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+A0OlQp5Gt0iuZq7n9cxUkA6iE0iKjcY+A5FHhTpNQ=;
 b=fAZvkp0lb4kv8yeZ0fSMYz6/13d3ePQxY1QYyUCfA3/nhZbHZFysmEntG9VPFjEFxSgLVDX6doXeUBnDBsFrkhN5zObp+gJZIAZnymiaQ4meEEpdKu/ghRdgqzvl7XSbdUTnf/No58afX6vrPZmB9XwU3hu8hRku1p+dZwnuzW+PZqpr9DohqiZKnFHG0Cf/AElquXZf7141auZP1pFynxmxgccyiwZd7JD9m5YcG8HpR/FKNvD6sHP32aKkDaApjBkojWRYjFEm207Jen7Shp2w5fYBeI1Do3yTyR+SAvQwmh6/0mV/qPyTFXOpkeFIANPX2zyn2v/VzmOwBUqmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+A0OlQp5Gt0iuZq7n9cxUkA6iE0iKjcY+A5FHhTpNQ=;
 b=a+faXysZjHKP6sfEaVCQdz6xubcPtwquahAecMWLxpW7jpfhIxIoYnliZt2+gzH+P3OAcO65Dv/aOb02XOnmPInjpYv+nuXINS8O1W/WnKsCXLvjNr1d0JQ8d3OXMcUjG3njg78pFUQGeM+rTUPnm/HF5h46UwKDRbqLhk2uZXA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB6377.namprd10.prod.outlook.com (2603:10b6:510:1a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 18:26:31 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 18:26:31 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Omar Sandoval <osandov@osandov.com>, Hao Ge <gehao@kylinos.cn>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
        linux-debuggers@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2] mm: convert page type macros to enum
Date: Thu,  6 Jun 2024 11:26:29 -0700
Message-ID: <20240606182630.851750-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ea7795-6b30-4ccc-eba0-08dc8656302d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HpwGjfkHxmtgJWUSRiTfOnpsh3ECqkYJqYuGr8Xb/OFTMbtOu8DPp+41gtF1?=
 =?us-ascii?Q?bQzZMFbV4uVSurAWSEJJG2EGEl/cEClbd30+EAHFE24iGcEnQk8TqeYffVJi?=
 =?us-ascii?Q?yXX7Bv9NVPB7goNk9udQ2dAXh0YPMjqsizqlgM4YfR4/EzCeW6hbnJo6CMp7?=
 =?us-ascii?Q?HhWqZB97qAVCxKa2C5TdJXTixz1eaJqqBFkOXEVTkfOFyxr+3D1Gbz8Z8YIb?=
 =?us-ascii?Q?TXopCq1FvXG+Np+dntG+1mxfSS/3DzcjtzbjjsrF7iZRgKzyVodgTVi1ducp?=
 =?us-ascii?Q?xeL46wtGeOq0OB8sJ8r9Ia1YsM0DE/TbzxJ1IeuGk2JUTjPvF9UL4+3pMIci?=
 =?us-ascii?Q?16m9UWJv9MjKj+jPh1uCLTw5gVH+T8mFvPEIfrgiKWrTkIub7TUDKCrYVzkD?=
 =?us-ascii?Q?EEKROdFQBvV5rGtrkwmp2NKkcr1aXTphcpgKhPF2h/gKsWNdckpTeLfGzCJL?=
 =?us-ascii?Q?Qf/qlZHg6SNO0tqDNx2DysPDWC6SbQ/sojWAaeBnU0//a6lZFQ0nVifHOfWI?=
 =?us-ascii?Q?xLO5hg+MGknr31mHtZ16MR9zNq2xnnefyrtoH2lTf2XYg05RTklAs730GpZl?=
 =?us-ascii?Q?d+HuSpsmIS+dz+Lu3M/6kAHKWAT6ea6mB/ax6OKr/HgFHPQwgoJg7XmkpRlz?=
 =?us-ascii?Q?1HJV13DPQfi4nar2jUrEHo81Wj31EmV8thzwRjsUBX+Ck5jwDyDHoYPWupgz?=
 =?us-ascii?Q?y+wM/p1fVO+bQpfmnbhqKvXDXVxPUbz8tl/5LRJMEEF/7iJ2nv/BNEJUklFj?=
 =?us-ascii?Q?BFPZJ7SI1ALRsAOyTQrgM+AqVR62ovuqf1VKh+KmN7RZoIxGUJQ6YibswdaL?=
 =?us-ascii?Q?fla9qGve/X3GDdhMqTSGHn/URhWIiI67xa8YWH5Pk9+XD5edsq1TBOYWaCQa?=
 =?us-ascii?Q?0iK4xUKBXctXvAIo4ibKDPsQ+9+oIodBYAXxzsNGShrKJT2nzj5JtMPOYoZp?=
 =?us-ascii?Q?gpJcIMUGjV2XEmTc5zNjKbXxblNUxHgjV03SoXvWGQmPd3l9f1lu2J/tyu2a?=
 =?us-ascii?Q?XpWThp2hEoNpTTJoH21bcGeiL4c+ikm7A+20P2O4A1LVEZK5Yh7cp6m9IoTI?=
 =?us-ascii?Q?ypSBUAYACoe/4JRvHr5yf9HGGDOSvPvPpjDBg4eohADr0H9EbILG5ywq6fER?=
 =?us-ascii?Q?dioTC3xsQqS9e/Xsw0Ecbau9SRL+lmziXucOCR+caI/f262oIJZvDDCMivQT?=
 =?us-ascii?Q?jZFdOmsjXXXYYNwGnmvpROb+G01iEGeDqi7vivV1hSx8HY1d/7FntxprV01z?=
 =?us-ascii?Q?fzQm2smonCh2HZbhbJHwI5VCa3E9eB2pVuS07dJfQI/Lqt1dslgLTY8ClNjY?=
 =?us-ascii?Q?uu2+v3Tzeh3dcDl+RopM1pO/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rA5wtCEDWMO0K7YJTZiMyCCuowJLuyYyRZw8S52BWuVmHR2/xao/k+a3i43W?=
 =?us-ascii?Q?o/Ot6jTb/mOkK6p3EunASEHFyC3REMc7OF9nM197XyUdXhFEGM6VermPfLxR?=
 =?us-ascii?Q?ZEtZj7oWemsaXrPTmMv6R2V44FQIx7B6rOfdUM3c5+ZxSUv+B25nrD7ijJCa?=
 =?us-ascii?Q?FES8iG3FT3smVhRPGSNwbWULGbnPzpAVmlVDI+8lOwcdnbE7C2Ijb9k8uR+a?=
 =?us-ascii?Q?1vWAmIakagw+gzfWrwWRMYsxYZySG6PN5uu4UdVxSdbzyGUqLhJ75QReV0OU?=
 =?us-ascii?Q?Ja5UpZX2LCdxKT2DSO+ILpSojHvi9JTKD0woyn3fk0ULEcuViP42Si+h91pf?=
 =?us-ascii?Q?HcrhlJ3Xs7V039JiemozaHd/2+UTmuA7gnMfoyL6RCznNntNLcfyuaLoczqh?=
 =?us-ascii?Q?HxhT0QpOblNj24YCZiBCWEgHGgcsXbOV0NfT5WPrXfeNw68WybSvERO5fCde?=
 =?us-ascii?Q?lYddXyZaCVdyO1Z6BmfU7iTuXeRHTSiGkRCsCw86z1kAmt2aYCIhDEGaT8d+?=
 =?us-ascii?Q?/ox76JD1hTBi4KJCke7kLN0FZadfAH4fN46hEcPIp6mIzIgAOAZB+AGmpPDD?=
 =?us-ascii?Q?XKoe7tgzPBqjJ7kNKa6HJA1+07AMvXrrjRSZtQY8VKKdyBbFJ3MQv4a9yAJT?=
 =?us-ascii?Q?F3U8fRyRlGZQZl/0vJT3DlJmSTNxohDFirOVXw5NHPBdxS+mtr2+w6gqsU8q?=
 =?us-ascii?Q?j2/3LF24SS/nxSnus8k7fKGrbN7HB2aXxDAcn+5EF/i3ifk8whrRE9kO9TaX?=
 =?us-ascii?Q?MMGFps7s9g84zSLeg14sC8isGyiM8OrKtGURkRtSpbioLZSg3Mp69KJdqgl2?=
 =?us-ascii?Q?x2xHqh/dALpOXilLuz20WggNEsblCL3Pd+iwRAwN7lO+tLLptQfsMplZEk5K?=
 =?us-ascii?Q?Hoa0gp5OqbMVWQQpepNFfCNRTykk7c/6H5JZc+pMKCsBBwoY7QEiVQBIc02Q?=
 =?us-ascii?Q?Mim90z3KZMh/VU9MLlfyq2LILb8gDc8Cjp1+IKruYtTCucq9ZgGh+XzA2OuY?=
 =?us-ascii?Q?RYadXbvWxaNfuBIFRwhSvJUQuKe3MWrqC5UyC4tyL1F/fJdiCFNka/JLDgn6?=
 =?us-ascii?Q?TJWrC9xC9uSNSMBAVwt0Z/LFGJLQsZQdUZgQwBp544TTwvISojTVDaCF7Iyj?=
 =?us-ascii?Q?JDpsMOtTZIYZEqY5n25ES9aFG5JqjbcReGVvPme1Odos+XA4oksQPTDvaXWN?=
 =?us-ascii?Q?OAA/DRAVnjNlx+BZPqUcxhpupcAQ02Q7S1WKlsmpfMwHzWeJtOritj1+nGuS?=
 =?us-ascii?Q?nQ3swBZevvqZ/kJdbXueEBX3+sZJRKww3Xrv552apyj5Bduo/ezuJsDrCSFu?=
 =?us-ascii?Q?h8J3LlobYz+v1JMke06CU7MX32mAFtOh8JBM0UQxyifdKCo432Op59uvNU+U?=
 =?us-ascii?Q?5eqCSLnuNWMJmIesdEs8lvx8xYkMkGdSw/Wc2VtHeTdyTM9N/38Hi8zJ7o2a?=
 =?us-ascii?Q?ZdZ6RO0GKS7vAL1a1+kwIhQYcWEOXh5ndfPh2If9vjBSNaZfwHwabqA+flqU?=
 =?us-ascii?Q?fbdIKyez/fFWOH+/QrF7eRPGvl8VRKugq5FHrHVJxueKk9GN6EtjcJHIQ+Pl?=
 =?us-ascii?Q?oDMVudell0KIT+hy/Gn1/3f2rdgT48KCsdVdly2vh71rIvheJ9viMFk/vVyN?=
 =?us-ascii?Q?xqx/C2aSnoys0K9YosIj155hPhMl3H1oy+odZqMiakPgsCBHkk8GYjhfeGeX?=
 =?us-ascii?Q?rPsZZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c6UJDxgNnRCwbG0qrVuCLZjj89Isl5saZ8Q2Ml+jFo+VFapc3/wKlA1KhblZIUW2DWbVpUnHuZEg0tFoSQxpE8iGlE4NKuLt+F6colZkjT6Lkc60/ydP86zSatuhLRY2gRBf7uP21d0ARpWLjSzRjn0afG5/89fWXUzm1GjBr5jonkXJp4RzY2XOSRc+bLsib6/S8h+dAMmTMUtDnhJaJxVhAqJg1MbkgnM1Vk/aIpNHP5DutPCWej76jc1kF+eDpyWGmMxyhTMaEFGWRDNnDJ6Jzxmh76W+PYrq5BwsWb2BaLbA8uS8KneL/BciCEWTnt3wmyIvdJoBsNyV58Cj7CzGbIWv6PvgYSI0RkX9C6id+a61g7KjMIV7uabaonqiVh8uaQeKX3RfKt5huxOQTJzH6I7dI5mafiVdVw65CZpQJBcfUbgFw8HBfLj2L94uHWKAU1hwMKLiCeHN+MJG4A0rLBFZWhQL2qP4X2vqREZ0ffVOvVRxOjODy6mM7jgWWUBTRIfCNGOrp0i+rCCLuAeZxgAtmyH3AUQwtX38v5yUFlmIx3b2slwspYGg6zYdidKTnJsYe/alhwnddd6gKipRAUem0q+mCOyTKEkdklw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ea7795-6b30-4ccc-eba0-08dc8656302d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:26:31.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7x5MQRVNL+WHCeRVCRst6NBX/lRS4/iTrWyclRxIiX4/CUDIstAzyaoDvz4U/YEUWOyxbctFR+58YT75a0ZD0R5FAQLB5YXBdUtZJny1Zxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060128
X-Proofpoint-GUID: rMQd8P1Sj1RAKIIUlpl36nBqcCYutOml
X-Proofpoint-ORIG-GUID: rMQd8P1Sj1RAKIIUlpl36nBqcCYutOml

Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
("mm: free up PG_slab") in has the unintended consequence of removing
the PG_slab constant from kernel debuginfo. The commit does add the
value to the vmcoreinfo note, which allows debuggers to find the value
without hardcoding it. However it's most flexible to continue
representing the constant with an enum. To that end, convert the page
type fields into an enum. Debuggers will now be able to detect that
PG_slab's type has changed from enum pageflags to enum page_type.

Fixes: 46df8e73a4a3 ("mm: free up PG_slab")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
v1 -> v2: include PAGE_TYPE_BASE and PAGE_MAPCOUNT_RESERVE

 include/linux/page-flags.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 104078afe0b16..74ffdacd3a134 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -944,15 +944,19 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
  * mistaken for a page type value.
  */
 
-#define PAGE_TYPE_BASE	0xf0000000
-/* Reserve		0x0000007f to catch underflows of _mapcount */
-#define PAGE_MAPCOUNT_RESERVE	-128
-#define PG_buddy	0x00000080
-#define PG_offline	0x00000100
-#define PG_table	0x00000200
-#define PG_guard	0x00000400
-#define PG_hugetlb	0x00000800
-#define PG_slab		0x00001000
+enum page_type {
+	PG_buddy	= 0x00000080,
+	PG_offline	= 0x00000100,
+	PG_table	= 0x00000200,
+	PG_guard	= 0x00000400,
+	PG_hugetlb	= 0x00000800,
+	PG_slab		= 0x00001000,
+
+	PAGE_TYPE_BASE	= 0xf0000000,
+
+	/* Reserve	0x0000007f to catch underflows of _mapcount */
+	PAGE_MAPCOUNT_RESERVE	= -128,
+};
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.43.0


