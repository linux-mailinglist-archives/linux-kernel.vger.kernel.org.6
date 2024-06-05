Return-Path: <linux-kernel+bounces-202925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD88FD30E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275BFB24384
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070FF15666F;
	Wed,  5 Jun 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3lWvqRP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L8CqZ/SL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248C2837A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605678; cv=fail; b=hdPWohF53Nr8+gKY6qFZ5GKwbrYLx55XuHhWWJBjGXtCxTB81lv30RHEo/gmwSg2FVAXROtOMx3VFiewVfcPFfTAG03GKnlkEMbydFdHW56hSzKEHB5Gy3zZ4iRcM9LUZ2Sg8HHSvKwJiD15hI/xT/fGiNeEWxPf4KqmeuzmVp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605678; c=relaxed/simple;
	bh=t3K0zhauDKazEN3aCZF5DRp+BpQUqYQTv6d1egVj9LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUnWerdoR03s9Ab9cx+cixYPs7evCE4rEllaBO1M80Jyxwq5/1+Fkm7REQpVXEd91LrR2f/cT4XA9sBz454PWM7FvYsaNepJlzajRl1ZrsScVOo3vKxrKzS9BDgLuA8qauB1A9DDXGATRfU9Wm8SOYZf9DEn/gayV3jMkg4MY3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N3lWvqRP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L8CqZ/SL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455Bne1C029133;
	Wed, 5 Jun 2024 16:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : in-reply-to : message-id : mime-version : references :
 subject : to; s=corp-2023-11-20;
 bh=K1c2YCu9eMNbxgkskwi8l3u9ikG+LH8CcdTL4KLH5P0=;
 b=N3lWvqRPMLP92x5wS8Uh8+wwypSHjCQ/DkxbwZotZo4ZYXgWU/9E/Gykqo5Klu3Ezh3g
 RksUu3uET9XfrCl10nVZXJfbZvIdh0Z+yBsbufnf5Bcupe3IQtpwcKf3pRbSoLNt+iOD
 kDu7p9SOiSqUHIUwMuvknzBnkCLgkmkZwf5JQ1SX3mDchU5+qc0k0Z9LR3Fcfuj6KTU+
 84HD6Gjhk/I/+vvXXJedhHLyHlgSFrOr7fYK+ccxo72WR4Eom3yTgFqns64JH5bTKvw6
 hDKz7ea3I6Bi2iNF3lC4/5XBcPjBgTewz96Nwfew6MqOffUhSAMIvSdzy9olgdXbGkrl xQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbusssjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 16:41:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455GPw5E025130;
	Wed, 5 Jun 2024 16:41:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtaa2mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 16:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agwQve3OnockIXCZbtZz/NNH5VqevOf3BK6vBqadYA1Fbvci/4eMwagXZmtzVO4wOTi0DZWJ4T68MYQ2qxo2pfPjLnswztJ65LUthvLDdn6qjySakX4M9HkfzaiD4cKVamhD9k3FUsT794D/GiPA2uwfLH7w6/WFVeia1pTyWrR1raW+jLso7Ce0iGQjITJXSpw6sgos0zm593wXx6QRqXI/Nw/LFHhnLVKp6RbXT3jHa3cgAXZN6zkUyRikx0br74zi4/PIw41eyhc/o2uo2GyPzglSHK18ltPz75PYjPOwhg9e6kjQHV57/XCxO8xBn0mpmInRTbklFo1IgxGQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1c2YCu9eMNbxgkskwi8l3u9ikG+LH8CcdTL4KLH5P0=;
 b=BWe/G+NTVZCd3izPNVm5/cw+uQn3U88u4RboPTe0bQsEtb2hwurWPymJUa4tRGJPluOoTlQ4aJgIorXF5i2pG7zwBJekMEH2JTL+3DBjUTvN9ebtbNNTiENHYZwHjAPdSg2eRVD55v/bc9PL2/oDDuG2kfEVsJpwSQEOzZGJqa6rkbyrRS0nXXB1n3s+gsr5f1OCgGlZItoILUfkME2hbOYPCBgEThHTHAui9SuipegZ0wa7Km0a8zXVPBBXOykF6RK5eiooZ9sw7LZFLZNz85Mxjxv2m2HeH4z1y3kmoYbK5YrN15RNDGkW2i7LG/NdNUzrhYLYo0a77ryvm5o7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1c2YCu9eMNbxgkskwi8l3u9ikG+LH8CcdTL4KLH5P0=;
 b=L8CqZ/SL+wvZT+0zaRVz0zD556dd7MbVI0EY/LwNxvcDvTfiFFaxcFSC6/4pKIP4e8SV0DZiF/jr/7uH7aF+I4Vy1AtsipdoYXNQozqFzufQeN5F3ERtNrh7WaZKhkoeLVb864gkVsK9gGZoDAcQJeuelWSmAuZe9g82r+hnccI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB6148.namprd10.prod.outlook.com (2603:10b6:208:3a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 16:40:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 16:40:57 +0000
Date: Wed, 5 Jun 2024 12:40:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jung-JaeJoon <rgbi3307@gmail.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] maple_tree: modified return type of
 mas_wr_store_entry()
Message-ID: <52hpolyqyyytkn4pjpuphfqdl7atb4woqaagdx365irpe2xhor@otb5znes4w65>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jung-JaeJoon <rgbi3307@gmail.com>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20240604150629.30536-1-rgbi3307@naver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604150629.30536-1-rgbi3307@naver.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e698941-381b-420a-e82c-08dc857e4661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZrIw+17oVFADlqbccgkXncIt9vh/YurM5EFJFMP63Cfsv65Fejg85oBgZYBH?=
 =?us-ascii?Q?qDUnI8tALv8coOqPsCdc45pNxTuTSUme9OFuI9/gL16lzfI1DJpbD0qiB/ty?=
 =?us-ascii?Q?isz6OtdU07SqdQWEqbk1p+2Zfru+d4lTBfMal6ivWZbYMKI6Dny5bktbEr4c?=
 =?us-ascii?Q?pF5oOfiaLT68QYIi2YRFYtkof9IRSXmyZP6G+Dqs2xNbB5pdGMY4HhPk14uv?=
 =?us-ascii?Q?mC03+W9tDog8l16bDXvOHCog6UNwMBW3XB3WjF5yhCmIexDaIEdi48kiYxUu?=
 =?us-ascii?Q?cNMnT4IAMKr2pt+bqS0vZ26VjHy2TzAPdknVwNcMMSYJ6gh03C7vP+XYz835?=
 =?us-ascii?Q?liV0bd3XOYgYLN52+GQSt/1VQqXK0ESin489O0wQ5ayG3/ikDy+SU0GI61Hr?=
 =?us-ascii?Q?q9Jfy3CMimFpiZZ3GTK21+XadyfZIrWqAhLVYVhO3OGqfRXXknxUkbp12qjH?=
 =?us-ascii?Q?bH2aso8/ko39PSL+7Q9yxIQrfJIcD/xYwU/zr+5sywSFPKk+6r41uABHO+iu?=
 =?us-ascii?Q?uAFUHcCoWm9L8XigloSOyQD7Rqs66eNt9pBa/d1agZnvcEnqK+8rksLijwPV?=
 =?us-ascii?Q?tbYTPHhlmXdsZUviELi+1r3nnavBAg47I1c8hFZRKZnvqh1OreWic/brPR5M?=
 =?us-ascii?Q?GaAANxbgQDyYpH0HSz5Qx0ePj3C8hJR7F3F7+rOHY49VDKugW6Q1oYPxQKTD?=
 =?us-ascii?Q?uKPSqJmp06bXFboiiXrV77ObTeSapLWNiltepaOtxHGfPso0em7IikWT/qLe?=
 =?us-ascii?Q?zW7dK433SnxlayQpuO7kSqlB1lJ4tr9JQHpGQRjoUfFpb2MgcyLlqU6zY6WN?=
 =?us-ascii?Q?IqIvV0dEpKHX7vuAVG7lvSb6rdewvXXwiqFQabHWq3GlM8MMAnpEzltY8ZNB?=
 =?us-ascii?Q?2Kzq/dN4mPgE/Uozjd8jzRLx320jJXYLAJTcVRcHHdVwzrR3mveK1zhZRsx6?=
 =?us-ascii?Q?2+ss1EQzTPcxBnqpsE5oZX0B+9beme3tt97CQK4sGLONAJdU+wV6AIrxH+Kf?=
 =?us-ascii?Q?NEma2eEuWbjdlMTPFyV5S3RgGQNC4+xm4aJpLB89hHC0Fus+4EhFv2aRAIOw?=
 =?us-ascii?Q?ZCuSPwdoD+xNkY+830YVY5BAPQ6Esaq6bhJe86FRx8tlvuwGapp5iuJ62UAM?=
 =?us-ascii?Q?x0WiMLw4PP9xpX2HKlApa+2NzvzrpiZyOQxYnh71tbC43qZ0sDRBFvIumRBF?=
 =?us-ascii?Q?oIoXGhndGqOHepjLA8ju5EMUt7xR8uLPPetjdGvRbVmdeLsZLJC+56ay0CzF?=
 =?us-ascii?Q?Twds7X+sNSKB/klk5EFwMOZ9XwoU/zyFjc/0YHJwdQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Kqr2hsHmQbegovY13GZJ6eNsCpjyxFsVpIG5vorbaMuZ/yXs/gP791mbYkoD?=
 =?us-ascii?Q?aKhyDMyV2EAPudr2jTrH/mu/+j6j4oDUotFVkn1LgV/YH3WXVe7zQr/jakEN?=
 =?us-ascii?Q?Ar6uBnrUygQtGWHu4o7WxsoEkhBmNgEsP2IpCaitSe8pNkIR3gzgE2WmDw56?=
 =?us-ascii?Q?Azq+Na69wNRVSWGTgNJjNjOdXQy43/92uPW+xa391gmEq4XAIF5OnfXY8+Ec?=
 =?us-ascii?Q?64kI7hdqwD+DDHO0iRBOH6sHH1blvPIorh9o7P06/sHa7vfCrNJYT6k5c25Q?=
 =?us-ascii?Q?OS7tyn3VDDTlaz0fswXv3vEkhwRRuRcuCgiiAdYCOAVsmFPT8x4rHucrHV6o?=
 =?us-ascii?Q?LPG9XMhUWxPDWX9Y02hqkICtDI07Cz8pvb4LmeUSSAdJBB3acuaCha/4PyYG?=
 =?us-ascii?Q?xdiCI6H+ykmYMnjvexi4J2PRVEII7pG/MdR+B3275MfPXhiekseaX+KpWsGL?=
 =?us-ascii?Q?TKcD6mg0jfMJW17b204vjWc0bJMN+vwN8kzVM2NzFGyeOiMDbcnXrujc4a02?=
 =?us-ascii?Q?QN0uMSyj9MY95eVaPJx2N2q947cauVeH144OgjehSTv2qi4POUhMBe0f0YDl?=
 =?us-ascii?Q?xXt1cGCBFltUtr/4cbJ3bEA6NPLYwRR1cDgaIcHCyaJA7mqD2XmwozvcKehl?=
 =?us-ascii?Q?wYbKBpreymRKIsiKwP1X4Arr2XwNqiM04XRrDwmuPcEKb3ZyQoOK6ZH/nfG9?=
 =?us-ascii?Q?WYtHOfXa63GENpho4PqDR8ZONjcBF65a0EtUCSVcwkb5E3vAaHZYcENbsxuX?=
 =?us-ascii?Q?p2HdCoewo+AzVvloKnkDpeWlAWCPAX7+688K7IlQybvdBkj19HvTNedlBokq?=
 =?us-ascii?Q?EFVzNNxUEofXtBxFtIE+xoclx3Y8TX4Yj6qIjdpRntPHd15xwS/9niZBmCCt?=
 =?us-ascii?Q?L828GQnQK5Kd8MaFZ3iPQbkg+mTCa6MJie6X29GwbCBdHXhuudCia+fLTK/w?=
 =?us-ascii?Q?X7xe3raXWXQNuWgZHFFqElgGSfasHW6RjuW/t1rBS/CX/qJhsw376g6Foz1p?=
 =?us-ascii?Q?r1Oh+X6himoheJYJLxoQ1c8FFsSPP0PQhHMg6a4XON+cag/Wh+mGHZFYbGRU?=
 =?us-ascii?Q?LoF590hzy570dB+i4rUZmIX8C8rWG/cpkHDtqiM+9vGWSiJmIbd/MDlCGzQP?=
 =?us-ascii?Q?Ja0lB/SZ0MljN+AZhoPlkxegGhc+qr7vBqbTbvmAYtLAaIM51L5K0gPZpt/V?=
 =?us-ascii?Q?lZwKIq/hB/WcI3ZN1jxfry6TCG7v7CqSaECsUtVqfIqWKy4cStkqe02xyzMp?=
 =?us-ascii?Q?BLuINwhymgNt58apiYca26I7HPi33/R9isvu7yQ/Q2iIVWdCPAJdOORDPW9T?=
 =?us-ascii?Q?ljscrN6r2aibdzljmX+JeTLB99wlnDQpifjgu8V2GkE6yZm5kOs7n9KKWBH3?=
 =?us-ascii?Q?RclaWU6/VQe5zKS93qjhd0LEQ9xB0/CszINyvT60GSOvzlM6/RmNIGGn30Ap?=
 =?us-ascii?Q?QOSejkhf3apOWSaDr3Td3/DjlEu9xPIMdrBnPPrELgu4nhiDKFdadaaGyw2L?=
 =?us-ascii?Q?seRKywO07/ZQPQWrGZMsdXNsvFMcc8FwhfAnaZEVpHxsMhxIDS2V+evuUUzJ?=
 =?us-ascii?Q?7zIwIONhoSSVyXBs5wnguVH6+IfNb6yeGALj08kI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7ZWkD5GjSBdXCqHCsMcxpvZSQuHkXGq3dNfMDqBNHLWpiwQ/eHF5IZqJPw8FLDHtG60D66HrJ1uiUNJ2R4VxSmpMq2bIROG+Z8UG7OHq+rLLp9Z/z9VOsJothDNB30+UwKHVYmZPd0aQs5Gs1HiZDmo70x2CQYCDig1bIEYAJ2e5K8I+M6Ubg9wyHvCQLUi03jgO5GcyTn19zBmrZWwnQp0UvU1J1baC4GDZqs4xYi/LMj5RRzPQxye/UYWSiPt5BgAKmB1o57vQl5/SFgkzkobcuywIWjTRsQAjQfOl2rFdqs9D8gpJfRZRrZWHuFF+E4isV4S0mPRWFmFZtn13zb1rAvCdoH2suB8eHI3Pss0YNJAPN/KS8JaUPNw5D2UhQTsYIGHHB4tOmmn3G67gDfXnSELM/bT9Scq1pORCxO/P0+JvW/KGBJyZEG5UrGNDPwc9JVYvVZh9ltiGAn5gORBocZg1dEm8FytYjIADGxu0tmmkQ3Z7DD29FQKQUleeQJXC+4h/NclCbtdEZmSnPYuH1+JmsgUbAGmS4Yr9zOif8PXXmXFc0TTnJ9EhocUto7wRXPlO4ZQCAgCp+tDPk7V3SNuRUKmXpH2aRP3eRwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e698941-381b-420a-e82c-08dc857e4661
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:40:57.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHY3t9EV6pUO5DwS+kR2yZK010VJ7oaKw8X/uyXNcygKoyeLorQsUV/U6o2frIYXymQUy5Qwl1iSG8N6Co/PRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050125
X-Proofpoint-ORIG-GUID: trAq4_wUas8Ca9d8rRNciMQUnVAvRKEE
X-Proofpoint-GUID: trAq4_wUas8Ca9d8rRNciMQUnVAvRKEE

* Jung-JaeJoon <rgbi3307@gmail.com> [240604 11:07]:
> From: Jung-JaeJoon <rgbi3307@gmail.com>
> 
> Since the return value of mas_wr_store_entry() is not used,
> the return type can be changed to void
> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> ---
>  lib/maple_tree.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 2d7d27e6ae3c..da30977aab0f 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4203,31 +4203,28 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>   *
>   * Return: The contents that was stored at the index.
>   */
> -static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
> +static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  
>  	wr_mas->content = mas_start(mas);
>  	if (mas_is_none(mas) || mas_is_ptr(mas)) {
>  		mas_store_root(mas, wr_mas->entry);
> -		return wr_mas->content;
> +		return;
>  	}
>  
>  	if (unlikely(!mas_wr_walk(wr_mas))) {
>  		mas_wr_spanning_store(wr_mas);
> -		return wr_mas->content;
> +		return;
>  	}
>  
>  	/* At this point, we are at the leaf node that needs to be altered. */
>  	mas_wr_end_piv(wr_mas);
>  	/* New root for a single pointer */
> -	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
> +	if (unlikely(!mas->index && mas->last == ULONG_MAX))
>  		mas_new_root(mas, wr_mas->entry);
> -		return wr_mas->content;
> -	}
> -
> -	mas_wr_modify(wr_mas);
> -	return wr_mas->content;
> +        else
> +	        mas_wr_modify(wr_mas);

These two lines have whitespace errors, you should be using tabs.
Please use scripts/checkpatch.pl to detect formatting issues like this.

>  }
>  
>  /**
> -- 
> 2.17.1
> 

