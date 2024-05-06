Return-Path: <linux-kernel+bounces-170392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABB8BD630
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCADD282C45
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B443A15B54B;
	Mon,  6 May 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCWgsVlT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FdQLHznt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1415B545
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027196; cv=fail; b=Y+9YEjady0DMfzQTG51I9elf1OQ/2SYv/rQIXMsTbK4zaJcpkXqLJhaNnCFx4SNfhgXBkeoo4+toEb8Vk5E9ecr42D67V0N73M7QZoAQX1Ivk85LyKc40i2OPk8lviLDqa8vTmV5w4JFgrBE6vXVJwsIN0ILb3/kpnjWWTFbJ68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027196; c=relaxed/simple;
	bh=sKXrD6L1CtY7fEw06wgLOmVg2Sp0+P4dlRKjWKGfC/Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fMeiagcYseK6F5txIWsRmDx1psW4jrP61cwys47l3VNlT2NDanvrNTvVCym3GncIp+hP+ujaYBROpk1dbl25Yo21fYcZ5bD2ODz085FDMyR9LDjGjqe+YRijAYVsYiMAzVq5bVKGPBtxShUkDCHnYxHGipuolqyha4QnM5tgROw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCWgsVlT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FdQLHznt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IPNr0018813;
	Mon, 6 May 2024 20:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QKTnbeSB2gp1FfE1g+Yv1CNh/CZsijP3qMAid7nbKCo=;
 b=NCWgsVlTGRVa2Dni5VtzBUsHI4SLuPZ+ibaVyKmEGTAlYGaOYKKHUXhYKRoTFTyKe3oq
 /iHjSmub1g3MMXwSxxSo9unqkVXEfFNa5zcbpKW1+aFIzax6oJKhx/eo/dqJ8qlTSPeo
 2aT9HfmE9pLgEGJxn/wjb6Z6bEK1H0p2NFE/Nt84Vfpw/YS+4pjbNA2DXMq2NYfop9CN
 NfDsVyAf+A+MGwoV/AvzWZm+e4HZqOJ5voA+R9vV0hsrabdWsFPr6HrKfU5oX+HHJYlq
 ZhI0gAQQvfkDAG8TdHFSDkKafdpU+8+zX8fL1JQ1YeEHPUe8XrOJHynsMDYKoPgo9gQY sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5khbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 20:26:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446JZuZp027603;
	Mon, 6 May 2024 20:26:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfdbvwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 20:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiM1j7JT8IhRC3bZ2BBWz8HaMm61imagaT6hpnXm+zL13pjI5qjQSddULa2EkNHhNPVk53ySaB/eFQ12mZH7f1fqoQVz3VA5VubeDLugNju+e2/OY4WEqbFMMxglPWmL2Or5Ebey8R4/eNUv0r4bJDZ5L1baFJ7y+wjEV7WcooKbZwJ9+/xEq/nT2+qM12540kQ7ksTF5Ig00fumRCrIopPpIpnst0xfucoo5eMAVgBqO+0VfghhyfAZ3sNEeAD+w/40QCHH9+GKSgv52OvglaviRmlx3IgODUHFgfvllUDHRu+0HnP1u6vVmE77UCucL2+rG/9H9w1huqT7BMXkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKTnbeSB2gp1FfE1g+Yv1CNh/CZsijP3qMAid7nbKCo=;
 b=I55AAmSAPhyUlIafPcxQtqc+VSjJMNT4WT/b50eEwvvakG1Brg3gxfhbhd5L1UtgEfMVcrcVkPkQt12C7KGHkNjAHHmBbm2MaUK5n0UWvmxu+fHW+DFqW3y5RwU8XJFr47AC6/zQMLxPwZyoQEWJk6XBlMo8eeVZ6eaA3TfsowGnHC+35GQUKiJj/GM1DALG0lwXownCvpKR7xCzqfSa8ztEJUPl1ceMVSCeR6t6jeaAOmdj1plJOeDOXqsOmkw+iMkZ54IOhNO7Oe3LP9/gXbwb+yAZxoFugZ5SJAgei4NLqk4Ttrb8QUVnMhWZaMeBbZ2v7g2xtwhAVwkBd8Jn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKTnbeSB2gp1FfE1g+Yv1CNh/CZsijP3qMAid7nbKCo=;
 b=FdQLHzntdCurDauHRDueHMEhcO61h2AcLQDR9/xgSdrX4yFeotOLeDxiR9DRmZ7BDVNKEXUWI/Cw1D26AW/kCEOaB/w/V49AXaTip6v+yWy3QQrQ7Wx9q5koENQBK4VyAS/XjSWYaNaI2ylOHlAZiIihFsl1XyWURprC/Iy5Lo0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ2PR10MB7558.namprd10.prod.outlook.com (2603:10b6:a03:549::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 20:26:21 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:26:21 +0000
Message-ID: <c172fa3d-d4a4-4605-8f39-df0536718bd5@oracle.com>
Date: Mon, 6 May 2024 13:26:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-4-jane.chu@oracle.com>
 <038cffc0-e027-b518-460f-40099819c588@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <038cffc0-e027-b518-460f-40099819c588@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ2PR10MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7c1412-0562-4322-3682-08dc6e0acb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MmxlRUh3UHhUNFhiKzVraFRjZS80ZnhJTHk1YjIyWitOYWg0SDYxdlpsVFNU?=
 =?utf-8?B?RjVGbFFDeVlJYklsQWpldElXZk05a3pPRE1oaGhzbU9heGNrTTZtR3pqcnRk?=
 =?utf-8?B?cUJPZzZiMEVhZkp2ZmVEVk83bW5FejNMZkhBWUtVdi81YkVVcVJtaDFQSkZj?=
 =?utf-8?B?WUswSlZSZmovSGlnRnNMLy9TYzI5TVRickJDL1hwcnN4blkxSDIzMERON1o0?=
 =?utf-8?B?YU5GOEpManRUcjJjSDA3MXpnTEtld1VzVGFlWE51UmVMVmJJRzNGR0FuLzR1?=
 =?utf-8?B?Q2JiTEZ3VFZ4ZG12TE15ajVCbXAzL09BZGpSRHFwQ3ZVaHRVTUFjVlEvVnpt?=
 =?utf-8?B?YmtZZEVxWTJRQXZ2bStNQ056K3dNaEY4TmR4bCtpNFd4OHMyR0JtTlN2VWQz?=
 =?utf-8?B?Vk56WUowVEQxQ3BYc081TGwwM2NaMkJraTF0UXFCT1VKNy9QNkJHeE5GQkJF?=
 =?utf-8?B?QkNVTFkrcjlkWHFsL0F6akM1cE8yeEFoMDBHUmlZd3VDRkV6ajNGeExPcm5p?=
 =?utf-8?B?NURBY1dBSVFVMktLdzJkRUhJK3BVSURyWWJCd2RxSXJ2YzRPbzNLcEY1a2d0?=
 =?utf-8?B?V0Q1NWJTclpTQTFKTFpQWVBZRHlEWFRVVVVaNmo2WVhIRlZHQU9teDhUTjRX?=
 =?utf-8?B?eTVKMVJ6NURvTmpzYXRHK2J5Zy92Y3ZwK3l5VE9IeCtjUHhQYmo4NXRYVko2?=
 =?utf-8?B?VkNiOWFRTUI3WjFYNFYzYW8zb3c4VTA0VDVXOGVjZ01BNnBnYlgwczdPZkhE?=
 =?utf-8?B?eS9aamwvOVBFM01vYzNnTTVZQngrbG9OVkptNHlFaHdibXJrWjlQbzgyMW9q?=
 =?utf-8?B?aFVOUTlaVDFLaDNrenJvM0J4dzliRjY0bzZpRXN0ZmhwTmszNXVyVktEb2J3?=
 =?utf-8?B?d1NrZVVVZE1CQ0llS2dhQmVIRnZPSWplaStQUHBma0VKK3VWQmQ4aS85bWNL?=
 =?utf-8?B?bENaaS82Rkw1RXU5RjJ5R0pKTUx4VUoydVp1Q0hxSjY3U21FZExnNWFmdEo2?=
 =?utf-8?B?VFh5NWY1emF5N2I1TXVEVW9CampuejU4clpTdWQ1T0hZekFqMjdPR2ZkYmhT?=
 =?utf-8?B?UkNFcjNlbEV6eFRVN3BqMUxKQ00vWUpHS3Vsa0xwWlBvOE45Q2NwN3NxV1lO?=
 =?utf-8?B?bE0wdlo0ZFZpbEtKT0hPbjN2ejdJTTlhaU00YUFHZzU4NVJwV1NoeU85dk4v?=
 =?utf-8?B?Q1RXRzNXYlVrYmNNc0hyMXJLVWFjR0JuR09TbjVIU2R2ekFUUnJId2oyOW9q?=
 =?utf-8?B?cXMwb3Y1QWVqRFJQckh0T2hkZzdQMjNUekNYYUczRTIzdmQ3Z2dkdE1Va3d5?=
 =?utf-8?B?R2JvZWlZWlNCTmRWQ216azJLbHAwTmpISG04eWVUc2VDSENxNk04QWJMZk5u?=
 =?utf-8?B?ZkZyanYvQ0IvOTZRZUNWWkJXU1RzNEVySUZqbDJlcUNMVitaWW5BMmQ0Qi9R?=
 =?utf-8?B?WjJXUUxGNkk3SFErZk9icGJNZnV0QjNPRmZRRVFWN1MwK2hGVHphYWN2VERS?=
 =?utf-8?B?MnZkTysvanpVY0NabHdTNklkMGZXVElMSGJFRTJZbDNkMnlWZmxvL0VscFpJ?=
 =?utf-8?B?YUJjcFZ2YmEwcm0rY2tHWDZiaWRUMlZWR1JQcjJVeWcwdlVhRkJJamp1aHVV?=
 =?utf-8?B?ZkxrbzJ0NlcxT3BhZWtXaFBNaGFRNUNHYUxoMnVoNGJqMEtzV3RoYjFmQWpl?=
 =?utf-8?B?NWY0RU5TeGMyR3Ywdlp4djMzSjA5YW1WTzdqRVM4SERlenNFRlRlVHVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZC8xZ3Q5MFFvMlhNclRDYkE5YkErNGNzUXBZV1BWSWlFQi80VlpLSUVONTZi?=
 =?utf-8?B?RE5iR1pPcmFhRjlhend0UVFrdy9Ga0NNSzA1ZVZpSGd3aUltWTU0cFlQTGlP?=
 =?utf-8?B?MlZTUStIMi9jOXMyaFZHMmJwVnJNK2FnMWY0dGt5WGFZMUI5MHY4VG14cFc3?=
 =?utf-8?B?ak5uQUVVRkpBVUJNWTRRU2ZZSlBsNS84dkZNejNtWFNWaUdpcGhnWklYT0NV?=
 =?utf-8?B?VVZUQmdMK2dyWHBtTVByMTd0Y2J4WGZPeUhSdUZ0eVRVTDd4YkNkRlNnY0Fl?=
 =?utf-8?B?T3dXaE5ramY0N3RRWlcyclFnYkxodVl2d2IwUGNIZUJkOUtleFBJUnpJcWZ4?=
 =?utf-8?B?RDJXR0tOa3ZJUW1uNVdnTk84VFoyelNVaEFKZGdFclk3R0kraTJwWDVXOEwx?=
 =?utf-8?B?ZVNzWFRNMDlNb2hNNTcwOHMwMkpyS0RYYWxZb3M2cDdacng5bm5HZE0vYWxO?=
 =?utf-8?B?a014cy9VN2NaanpoWVk1UXJydnIveENNay9iWG9BYjhxNnBuakFUeC84ZFJo?=
 =?utf-8?B?eGhSRnRHRkJIeWUzYWEySm5BbWhXUFo3RjNBU2R5LytVVWhPcjVFWVMyVFBs?=
 =?utf-8?B?NHk5V09hN2x4REFlVFB1Wml1bWUxU0ZaTXBKbnJ6MHpzV0NLNzlxRmtFZmxO?=
 =?utf-8?B?WW5KVEdrQVFJUk1rYSsxdTZMTURsTmJLdTdyZU05R245RHp5NENvN2NQOXVm?=
 =?utf-8?B?NVdZczZIcDg3WC9CMGp5MVNjQm8rTGdQV1pEUnBZYnFGRFdBaHlZRFczWXoy?=
 =?utf-8?B?R3d6eDAwY1o5cmN2WVRWa29vWVBLanZVSGRSVFdTOCswamF1U2NmRXluQ0Zo?=
 =?utf-8?B?VThuUzdETGJLVHBjYmpVRzNkK3JXUEM1eUdKSlJyMnQ0Y3habDROdU9HM1hH?=
 =?utf-8?B?czNheTRRbGlKMStpVU90TUZPemRnbXo2VjJTYmRRckVDSGNHREFIRWN0K0Jy?=
 =?utf-8?B?MTVVUjZmdlNWYndoLzAxL2xXclRzb2J4MkZmNHRlQkxHaW4zYVpZWU53eUNr?=
 =?utf-8?B?eWlJVzlnN0h1bkUvdTdhcXgzNkt1dzBJMlZacVZFamZlcG5GSHZTTlpYeGFK?=
 =?utf-8?B?T2thbFpBaXRISEJ4cUYwcnZrU0d1NVNYMGtVaW5WMlBPMHJMZ1JsMUdjUUdm?=
 =?utf-8?B?T2xVcmp1ZHh1L08veXBVS2JXTnZDMjN5MkhWU2lVMUROTG1Ka1JnR0JZZm9R?=
 =?utf-8?B?aUN0U0VHNVRMNHB5Q1dOYkM5RC9LRWVJa1hkQSt0OTVMbmRPcFJlMVQ5RmNP?=
 =?utf-8?B?NDdlcER1c1dMdW9TbUNMcWlTWFZOUWxvWkkxL3o3R05LdUdYRWlpWllBblZ6?=
 =?utf-8?B?SFhTYy8xTHlmV3dTekFnQkI1T2ZtdlFCQTkxVjBwcXdWQVA1cWNiY3FXSjR5?=
 =?utf-8?B?T1NSdnFSZTRwV280cnFNdk5hYUZTangzUGpLK3ZvNmtzck02WW92WjRlTGYx?=
 =?utf-8?B?ZGpEOUtYeHVXekl4d0ZNNTVKKzVpbzlVb1RreFJzS091T0c3SFZaV2NsRWFK?=
 =?utf-8?B?R05iL0lhMzBCWGREd3BRSExMc0Y2N3A4UFVjWExTdlhZNWFxWlR4WlVoRElK?=
 =?utf-8?B?NktWakYwSDdKRzZCV3VqeG5GSkZra1R0Uk9WbzluNXkydGJldGNnak43bWwy?=
 =?utf-8?B?d2txRWJRelhuSTF5Q2hROVR0bDJlWVRsMFZUdnA2Y3I0ZkZnMjRrVjVLZTBQ?=
 =?utf-8?B?eEh3dGJuSDArY2kxU1FDZ1pNSG5tcUlDMHFaNURWSFNsdEY1RW1aLytoZURp?=
 =?utf-8?B?ZldQSWMyUmtUUTEyQ0N6QVRxTVN5OFBVTDh1blg3S1dXaUtFb1VhUFJQa2w5?=
 =?utf-8?B?K2tUTXowMWJGVmtYeUtWSTh5MnJmczhkck9FbDEyR2hRdXg5RWY2aEZLemtj?=
 =?utf-8?B?Tk9XMU00RElESy93UEFNS3c1VTNVd2d2dXFqd1ZzQTRDSFJRTC91MlRqVGl6?=
 =?utf-8?B?L2xmeWF4WFkydm5Ia0RueXpUV0F4bXNuSXpETDl6WGVHQlhZblJadEtvYjhJ?=
 =?utf-8?B?SHAyQkpCeDN5WHpNblB0dFVpa1Y3MitBdm5zMndaMm1uVjJuU0pIYkhKODAy?=
 =?utf-8?B?VjBod3dDenEzZmtYZlVhNTdnMXo1Tkp6bFhaeFpnODgvNEZjZGp4ODgzUnBW?=
 =?utf-8?Q?Fzdgk+aou9bFPk6eWP/ha4gt5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0Vd6dE9gOq2WbJtv92gd4g1muvbW6OIscKHbQ3TIgWMk3IbBrpJqa96gl8JBS6ugFBbwtYva0ZB7LpTwrqRoFH0/DyO0eiLe8lHGtjAflm7uXEmK18O6XFrpVAufOuNE8JGtFSFoRQLZisvoszAyVuLzPPQt64KdgPtQZXhTOkF3BjwC4Lhz90QbhV0oI1wJner0yjTJJ43a6TzpjWPZb7+sWUy0cdOM+7iTbl6CoEBHnKSTi2UtLHmWcoI1aWWx7AcxKrQRhBh41SE8GeP/hpE9dlSrQwnHNw4kS1z2GkPd0+FsIcFetgKbrrPvpZ5p6IId3ejjxK4Tq5H9al4gNo3rWuwOGw/rMUgNlHEOeHc1TzCgRN8HHbjIKRXwLNMEUDavxF8BcYaYGRpsgUONA6kqGDKR9UBF9XHDW7XeuqtfK+AcG4C6SdZ+IeB2aQVcMCAqRl/kB8aR6xZSkzcpRuBDy5IW6Wot/BaR/N/g1f9sG7ty1rZ7kxSsEdzAVOQ4iyEViWi9eeYK9EmmiZSWNq7bobThT7wLttu1M3HxB9YxpV0QH8f66vN+QpK2j0pEE5p59qZiWEZOsfCYRYrJXl70tFvIWw7bsxrHPXWmsO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7c1412-0562-4322-3682-08dc6e0acb2a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 20:26:21.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9snlki6QegXjN2+j97MQ7Oeb7TpVvhtUwCO7cSItI8LfLpU22RuKZqMfTZf6kVVBpsgL2c8DZ2PtiJJHEWFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060148
X-Proofpoint-GUID: mOhfk-OL8uhytkSDWA9Ij2rxyxJ1k11t
X-Proofpoint-ORIG-GUID: mOhfk-OL8uhytkSDWA9Ij2rxyxJ1k11t

On 5/5/2024 12:00 AM, Miaohe Lin wrote:

> On 2024/5/2 7:24, Jane Chu wrote:
>> When handle hwpoison in a GUP longterm pin'ed thp page,
>> try_to_split_thp_page() will fail. And at this point, there is little else
>> the kernel could do except sending a SIGBUS to the user process, thus
>> give it a chance to recover.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Thanks for your patch. Some comments below.
>
>> ---
>>   mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7fcf182abb96..67f4d24a98e7 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   	return rc;
>>   }
>>   
>> +/*
>> + * The calling condition is as such: thp split failed, page might have
>> + * been GUP longterm pinned, not much can be done for recovery.
>> + * But a SIGBUS should be delivered with vaddr provided so that the user
>> + * application has a chance to recover. Also, application processes'
>> + * election for MCE early killed will be honored.
>> + */
>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>> +			struct page *hpage)
>> +{
>> +	struct folio *folio = page_folio(hpage);
>> +	LIST_HEAD(tokill);
>> +	int res = -EHWPOISON;
>> +
>> +	/* deal with user pages only */
>> +	if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
>> +		res = -EBUSY;
>> +	if (!(PageLRU(hpage) || PageHuge(p)))
>> +		res = -EBUSY;
> Above checks seems unneeded. We already know it's thp?

Agreed.

I  lifted these checks from hwpoison_user_mapping() with a hope to make 
kill_procs_now() more generic,

such as, potentially replacing kill_accessing_processes() for 
re-accessing hwpoisoned page.

But I backed out at last, due to concerns that my tests might not have 
covered sufficient number of scenarios.

>
>> +
>> +	if (res == -EHWPOISON) {
>> +		collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>> +		kill_procs(&tokill, true, pfn, flags);
>> +	}
>> +
>> +	if (flags & MF_COUNT_INCREASED)
>> +		put_page(p);
> This if block is broken. put_page() has been done when try_to_split_thp_page() fails?

put_page() has not been done if try_to_split_thp_page() fails, and I 
think it should.

I will revise the code so that put_page() is called regardless 
MF_ACTION_REQUIRED is set or not.

>
>> +
> action_result is missing?

Indeed,  action_result() isn't always called, referring to the 
re-accessing hwpoison scenarios.

In this case, I think the reason  is that, we just killed the process 
and there is nothing

else to do or to report.

>
>> +	return res;
>> +}
>> +
>>   /**
>>    * memory_failure - Handle memory failure of a page.
>>    * @pfn: Page Number of the corrupted page
>> @@ -2297,6 +2328,11 @@ int memory_failure(unsigned long pfn, int flags)
>>   		 */
>>   		SetPageHasHWPoisoned(hpage);
>>   		if (try_to_split_thp_page(p) < 0) {
> Should hwpoison_filter() be called in this case?
Yes, it should. I will add the hwpoison_filter check.
>
>> +			if (flags & MF_ACTION_REQUIRED) {
>> +				pr_err("%#lx: thp split failed\n", pfn);
>> +				res = kill_procs_now(p, pfn, flags, hpage);
> Can we use hwpoison_user_mappings() directly here?

I thought about using hwpoison_user_mappings() with an extra flag, but 
gave up in the end.

Because most of the code there are not needed, such as the checks you 
mentioned above,

and umapping etc.

thanks!

-jane

>
> Thanks.
> .
>
>> +				goto unlock_mutex;
>> +			}
>>   			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>>   			goto unlock_mutex;
>>   		}
>>

