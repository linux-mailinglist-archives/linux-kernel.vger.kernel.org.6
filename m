Return-Path: <linux-kernel+bounces-378472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B829AD117
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80EF2831EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0601CB334;
	Wed, 23 Oct 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dPoV5+ep";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h9dHkWuu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEC1B4F10
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701352; cv=fail; b=ZaLSzEb5G2rjgdhawEsSVxSnplUtNBNeWOXz2VF+xF9AUSSv7G4qW/EEzjjEO8XE5CRb/ZjlZs3tb6CTt+lLsUso64UcDVJ//XROdw0AwChsG8NX8z/qo5WtKEv0wLVv4941mvGH3ina3JooOjW9b+MxUmR9l0gJQqCWG900Uhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701352; c=relaxed/simple;
	bh=ClVU7VJ8aHXqtNmDa19NSJ+TppFb0HBnnaBqxmfM/kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f8cCoP7DYDfYFz4BEfJRIslPw/3dva/nDy4oWHCTeVS5KV9+F//nFF3lT4fRM6gcLbB+U+QQPu1RAXujVHndFGaPsMgMqwE/AuxhekX5qjoo/Lx4b7eIfB92qxHBms/1Vtb1B68SPnCpN4+QZEri/EJVXrcVefWEY1T2oiqgSSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dPoV5+ep; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h9dHkWuu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfakY004637;
	Wed, 23 Oct 2024 16:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kEhD/3i4tSKHGRFyHFH7mPtg+W3vu06JEOCOTGrrkQ8=; b=
	dPoV5+epai292mcXwlGQDQAaVeuOeYvQSWMNMkp3exjdPG6/trrbxARWLthv348c
	uLjqw0nXNufTT2WKQqb105POy2m3votv0XnJ0pwCd+y0Lz0Bu5OEtMFDTSw+hq2I
	QzdYrtZ8qY6WQQyKMRlhT5AQJ5foi/PEdXWAqgqXdVkkGqbN9Mv1nJnRxuWKUdvd
	r3+s4zdjuKrl/vRTgr9L96YuwbyWK/Sjy+UbIy1A4En4RDUM7iHpyB0OHtjUjze2
	ZPGRYOomwwofy43dUYDaoq2zUxN14crHUQWtqG3PBE1aFNIfAwgxjzuG+PZdzpIV
	KM+cOiNkmfzXcorGhDJetw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5458qdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:35:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NGJ3sL035737;
	Wed, 23 Oct 2024 16:35:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2rrpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLyAhbxL23Ue6hN/znyAy6x3uV0v4ibuzxSlNCRMHAWe/9v0FZ6cdvOItCkwmKIz1WeTZ64Af6pKx48gLQu0cCTf1wIPjc6QloUSNwjP0qh9OHCAReARyttiA33nO5QaJzXNORxN9eiRqTGMTD9iK+sPoYsT92++lgn63bb0RjomLSJJdf23Nry8nE7nzWtXiS5VtY4kC29EkQdKsyLvGzLC4K2zgOcapVg7nRnrSud3qwUURcOeBNaml0zsj2vFZtEuauGvG4r1sfY3buvSATuUPvKcpe05CMVS6GCSZyrYF4ngrBeQm53Wjo5nYtul05/j05v1iSnGyOF73T9vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEhD/3i4tSKHGRFyHFH7mPtg+W3vu06JEOCOTGrrkQ8=;
 b=gTTQoV7dEes+0Qkxl6tB8i3E3eGsIy0Gx8i4sHC+Av7YF+uZIaK7uCDiyU9+GW4DUCU15Fe/c/ueY/eS+uwSG4MDAYc7UZeAC6rRzBCNkp2mKU/uz+AfyGmYW47jpWZQjEohWz7KZCA7kFG0hCl6QFBqNoK8zD0pFklnW3nfcToZrXl6KToVc4bnYQW+bBUF3xroeZ8YQCOfVZC5x2ad/dJ2Lr8WH5JCYzSHkXGrhcaDN/Fbyt+dReI7CFPq6VfBBiCzffvcbjyAUAU7yK8outx65F05BpPkXHjikeM+CLLCjgU8A5nsANxwVhaAMYsEM6HgGIVbA0I7neZdlzOiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEhD/3i4tSKHGRFyHFH7mPtg+W3vu06JEOCOTGrrkQ8=;
 b=h9dHkWuu83F0eccX8AJBmy2osL422Meo7YtGiLyWeWL08MDjtsdus/PilndN3O5toxXkgW9IjuuiPnPvzNu87NjDJZuZK5sIt00F1Mz/sJM1pQnrZAS+Afxe9+mjq52vVg+lpGuyzjmPAap4mx++p/SQBBIbJTyWuDSf6YvRQFY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7454.namprd10.prod.outlook.com (2603:10b6:8:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 16:35:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:35:36 +0000
Date: Wed, 23 Oct 2024 17:35:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 3/8] mm: refactor map_deny_write_exec()
Message-ID: <135f7b3f-cd54-40bb-9ea8-cee8b06bb16c@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
 <CAG48ez0oqGgfF-UTOc9eWC_TrZ-pF1Ek_cUjzArxHEsM_TT2gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0oqGgfF-UTOc9eWC_TrZ-pF1Ek_cUjzArxHEsM_TT2gg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 1606dcae-3a9d-4986-6c73-08dcf380b8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGl0TFRyV1VoMGdXOHVPYzE0NXFodDVxY3FsVGxXSTJSak1NWml2c2w4NUFK?=
 =?utf-8?B?VmhOWnZFUjVKU0grS1NNM2VzZTBrbml5OVpZQUt6Q2JMNEdjMjhRTjVuMFdK?=
 =?utf-8?B?RWdGTjlwdExRUkRTSTBUQ2UyMW9IczVEYlliNU9DSEhnd2V1RTV0V0NzTFJD?=
 =?utf-8?B?YnZnWWcvTERFRVJZMlVoblB4eGpZWkcwY1hXaVdvOTdjOG9vT2s1NkIxUnNC?=
 =?utf-8?B?dldmU3RCbEg0Q0szMFVzaFpjcmhmN2pyamRHOUMzYXRVcytLRTVJRUI4RVZ3?=
 =?utf-8?B?Z0dYdnRyTzkrSUxmeXRSbzYxak52WnZRanZvWGN2REQrUGtrYWw2R2pFcU1O?=
 =?utf-8?B?cnBMalpuUzR5UXc5bm9PVlRhRDFzRUNuM3lQQmFLVTk1ZWVNKzN2ZkM2a2NS?=
 =?utf-8?B?Y2ZjVXg5STZMa3p2QUh4NjZWTk42U1VFYXJQR3VYUmlnR3VKREM3WmJpUjJJ?=
 =?utf-8?B?WG9QNk9KSVQ1b1VjOUlZTVdEVEVIaXNjU2kxWnRNYll2V3FDbHhUUUpPR0dJ?=
 =?utf-8?B?ZGZWUHJHZEZKNERlTmdhN0NJbTlFVUh6Q3FWN0FtQ25sQ3NNV0FQVG0vUlNG?=
 =?utf-8?B?Nm9WZ2pOZlB3cUoyakFBSFBCU2JmWVBHa1FMY0QrR2gvNkRBcytPYWdLR0Fm?=
 =?utf-8?B?Ry9EV2QzZXFQQ3BTMjdmWUZKZnQrUXNTMThEaE5MR3ZWemJVKzdMdjNLQ2lM?=
 =?utf-8?B?Smh2V2s4dXV4NWZ0R2VkWlpyYlViSmFYT0lkWmQ4eHViS01JMFMzbGozSUJJ?=
 =?utf-8?B?WE95TGk4cFVDVlNaeVpCZUhub3dNd1VtL2hPcE0waFZNaFlCaHhXc3ozY2F4?=
 =?utf-8?B?M1ZqTTk5N0NSQ08yajZrMkdFVkhtYmJkNWc0WnZwY01QbXRPdU5TVStWWUps?=
 =?utf-8?B?NVA2Y1RYaFR3MERnOUxCZDM0SjNUeEgwZDdXazNyUUx6UWwzN1RraC9aYW4y?=
 =?utf-8?B?VEdVZ1h3TTVGYVZGMTV4NnFkcEpyTkRSOGxhei96Y0t6aWdHaTF5VDJIeHRq?=
 =?utf-8?B?V210Y2FITDZHTnRnc0N4bWtuRmRabmxkWGMxQ0tVQjVlMHpJejZkSVF3TXM4?=
 =?utf-8?B?ZHNtRzVVeTF3dmNFNDJYOXhjN2R2VjcwdTJHV2ZMOHRZd3J5YllQcURZZjFE?=
 =?utf-8?B?R2JDaENaZ0cvUHd2SXZ6bGM5K0w1UGRjSDgyYlJnL1ByN2dwclVNbnB5WmNY?=
 =?utf-8?B?akRNSStRd0FxaUpvZys4Z0NKeEpJU0cvQ1JEMXBia0tGMDVKbDB6ZzhQdnF3?=
 =?utf-8?B?OUhnYkNvN0VITHE1QjByTmtBbzRTY2lha2V4L0hqMmpMdEtpQW8yOVhycW1k?=
 =?utf-8?B?dG44a3lNSlVmNW9ZRjJQemRDdkEwREZrMlllYkIvVzdxdW9DbWRlVWNkUURy?=
 =?utf-8?B?ejlndGxzNGI1SHBvazVpbFVTNVlRRkdWaUN0c0xCUWpwVTZGRExPeVp4cEhQ?=
 =?utf-8?B?Q0FzR0ZqZ0dsTTRaRVhKczlWNDJwTGYveGZRbmNnaGVMdzM4Q21XTWtES3Bj?=
 =?utf-8?B?QVVRbkdoeE1lb3RUQ1FvMkE4SlNXeGVIREd0NjRDSkc3Ly9tdjh4K0RZZk1Z?=
 =?utf-8?B?Y3Bpa3dsSy9VSGErRnlBcjVUOGpXbmRBS0xoaGwrcTRhdHZtVmh6RWJVRXJs?=
 =?utf-8?B?VVB2K2FNQ21Qek0zNWw0djNlRkxlRjl2ZEdxdDVPbW1taDduYUJzRUV5UU1q?=
 =?utf-8?B?ZVFlUmhkM0tiUDM4THNFTXJ5RFQ4a011a0ZQYkhOUmhvaDloRVZGNitxQ2c5?=
 =?utf-8?Q?UVbRwgsIvRTeeW+le5mKvHbiE4/a8DQpJZmAOAl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDdTK3NPL2xoVDg0V1IyWHl2VUp2VTVRdnNYL20zUVRSbGludGM0YmUxd3Ny?=
 =?utf-8?B?V2QwZXkyU0FYK2haK1dxZ2pVYkxkNWFjVWN6dENDQ0NTUGJSSTkvWnFWK3Mz?=
 =?utf-8?B?czJ2bWJxM2pKbS8rUmVLMEJQN3NZeDdZcFRHWG8vNHdnMGhSNDl6VmtIYTJ5?=
 =?utf-8?B?bDlVNHZLZmxxdHFNVnQ0MDZQeklDRDNRN0xqYVBrQmMxNkhORDJWTmlsRkVo?=
 =?utf-8?B?QjRZamUyWVEzbk1RUEZpYURWcmFDUndYVExiNkI5bTdJR2Fxc1BBM0krcUFl?=
 =?utf-8?B?eDlKYXl1bW4wVnJoeUdHWmlmL2x3T0ZzMGx6NzhiQldZRG9GMjVmS3JvMVJ1?=
 =?utf-8?B?TDc3VkZTdEswRjZMUUtJQ0kycTdvYkxDaHFYRU9HaldzVXJIN0pNRHBWYmZG?=
 =?utf-8?B?S05BNVpVVUN6YXdTQllReFRrMlBpWkpGT0ZHT0M3U3JieVhiRGp6NjZVMGlM?=
 =?utf-8?B?RjU3bjJBQjJ4M3NBeDB4bSsvKzNoNHp2b09NL1FTem5LbFdiK1JKdjBiSVRB?=
 =?utf-8?B?amNhZmU3ZmJRNHQ2OC9KR0NSR1ZUTU5xV0g3RUNJMkhkdDBBdVcrOVQremE2?=
 =?utf-8?B?citnNEVyTEtYZlkzSkNQTWVvZlJ5UnNSY0pmeW9mbWVzNVlJejF5eVQ2bkg3?=
 =?utf-8?B?VU5tR0Z3cVBIK3pLVWFkc3IySWFaTmQvb1JULys3OGNUcjd5cUxDTnZERlB6?=
 =?utf-8?B?Sm9iYXFkQS83S1cvL0FwMVVRYWlhVWFiYjVaaGt2cy9WNFRsRXo2S3lQRWlt?=
 =?utf-8?B?MHRwZm1ENHlBZlFwSmUyK2hvWHVSYkFyU1pxSEFYZTY3MVc1eXNVWWEzRUR4?=
 =?utf-8?B?YkhmS0RFMUZiMlREeUVXVnE5Y21EZDJjeHdYekppRk03RHFsK0dQa0hodWkx?=
 =?utf-8?B?ck5TdytaYkxSTDhZa3BJaFh1aVlidUhkNGJTM2I5LzlTcXJlTXNpOG5SS2xZ?=
 =?utf-8?B?ajdPRUI3TGdpMC84UzVZd1lBd2lZdEc1NkZ6WS9jUFpzNllIRjVzQUdzcDZx?=
 =?utf-8?B?ekRraVMzemxDSmR3SENzTkREWlpCejY4d0ZTVldxa3F5RE9aR1JLWHFLOWQ1?=
 =?utf-8?B?c2ZSbk56Mkl6MmdhNFpFSC96ZlB0d1lQa3pCYW1Ca2QrdExrcFQzTUNINDdU?=
 =?utf-8?B?RXNGZGNDaG56bUZkR1BkVEhqcTVtcU5pV0RMMmxkc1pQVkNoSFhiZWxYU2tq?=
 =?utf-8?B?QTBzb3hQSXVwWHo2dnpYOUxGUE5PdHZJYzFQU3FPRTd5ekwxRWh3dWh6Uno0?=
 =?utf-8?B?dFNVY1F0NGhsM3EwVUlWc1BvaUJXVXE1d2laY0RCSW5aelVUK2JScG5lQlp0?=
 =?utf-8?B?Q3BRV2RnQkwxNCswYkVGSHJ5ODZIR2tFM1I1cGRkNHE2YjhqSW1TK1JuS1ZT?=
 =?utf-8?B?WHpoV3h3OWkrNGRaS2QzbCsxUTlBY0l3VzRreWtERUZBYUJvT0R5dkRZd0dR?=
 =?utf-8?B?dzc2Y2F1bTVxUFBkelBJUzlRU2xVNlB3amMwL1FYbFRuN1hwTTJwMTlMMFZN?=
 =?utf-8?B?WnhHQ01sTHlaUHRNdWoxS1ZSUEcrMGRNQTdjTThvc0pWVmNkOVpGMzFzNklt?=
 =?utf-8?B?bTJNRHd2cW1rMUFwS2V0MXQ2Q1JnNTNNeWFHNDBvV3pQR1AyWnA3NFdmRXVC?=
 =?utf-8?B?YnRXenNrR2d2RDhxRC8ycGVZUHlHZWVsZlJJSUtyMmtqT001OVRvOXJON3Aw?=
 =?utf-8?B?ZS9rN1pTakpBWXBSTzFKbzhxK1pybjBMOHhXN3QxbVVZaUQ5eXcxZStkbmRE?=
 =?utf-8?B?MjJxeUNoUzRBSHRVQlQ2TU4weS9OMjF2Z1Q3dDB2VFlCWXNmVVVjMThJT3R2?=
 =?utf-8?B?RFZXeWZQUkE2ektBNE9WRDM2OEE0ZVdSRk96REw5V1dzbDEzcm5lOUpIWDQz?=
 =?utf-8?B?YXpyRjNiSythdmxLR2pRR3NPZnZIcDl5cXB1UGl1SkM4djhmeU9DZmc2S04v?=
 =?utf-8?B?Z3E3VUFOcTcvaUZKYmZvRzJ1N0RnQzFTNWdQc1FRbXltellweVhpZGpxRENG?=
 =?utf-8?B?cVpEODNSVmFVZGsxdEFDTjZ2R3NwWndVNWNuU1FxZkh1WnBzU0JVSmp5aHJY?=
 =?utf-8?B?K2xzS2kxWVdHZ2ZrekRqclFXME1YSXBYaGYwa3cyL012dk1qbmEzRXV2R2g2?=
 =?utf-8?B?R3QwVjFsU3J6enhmTWtLc2lCK0l5dldWOUtJaGJrZ0F5RWRYdlc1bituSXNK?=
 =?utf-8?B?R1ZWSjY4TThybDZZaGZvVW1MbVR2WFEyTWJLNytiZUx1bnVFZCtnOHBuOGRx?=
 =?utf-8?B?T1NLK2g3V0Y0eC8xMjdYZjVlNFNRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HCe3pDjeXzIVir9otrlRAqtDYdyHvSLYtOov6Yq2NXmjPwQ/bV2Bcm0iAqLKUizY7rVwfPfcF88qhhRxv2jO4GXX9ypYn4eRLkF40T4/rjh12ObKFjIuvMYqSY4JLCH4KoQYwfpkmCp7nu2pHfDT0nx7TYOFlC6e2jMv4M3JJ0o0DEAwgCY0LzjonhTZXdLvXiG67I1ulNDMOkIfpzry+5WN8spjRP5xUGb6ByVG8jwvqZE+1QoqPeExBcywrwkwGVNdoxVT75mqVr8Y4PQX3B2lYJyje0YNFgeog0Bjc7DMNH3tLp5UUKgTFJ/HXfcJIFxMvOp3+XqaYPi+HICedcjaCkyvA0ORF3ASGOHBORbitIMBgnIEdS3sBlQY0c3zofPLKLGv4V3Bt9XECq7MzN8PL1aaRInG4H2YeF+1Fsr0NSyhQZY+36uUxqcD3qBzhbq4MJyKXjo2Z/PbaxJ+3PnmYpI44J8SAgi7HBKgLUafg30rWBVUNSgTs+BcSxDNKbHUkGCSu5c23tpgahPil4+I1Huf1olHL1t5uZc8z51Sorp8sSJYW0lZNqCzg324/Ab1ZXrhUiUfuQ8dXMl6bXLsq3GLHjhRuoyIis/NRnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1606dcae-3a9d-4986-6c73-08dcf380b8f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:35:36.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCSYa/w0sSLgKRSh4a/XOp1C0VfDeJdaglYrB3wGRCCGObE68ej04An8ZJkLCJKEOxuBKbIEBHS9pWepYcN+qKnURK/r8/SUyR4kX+IuFI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230101
X-Proofpoint-ORIG-GUID: 6zDC0YoHWmcEjX7Sd0ZIDOJfNnvv8oVs
X-Proofpoint-GUID: 6zDC0YoHWmcEjX7Sd0ZIDOJfNnvv8oVs

On Tue, Oct 22, 2024 at 11:15:18PM +0200, Jann Horn wrote:
> On Tue, Oct 22, 2024 at 10:41 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> > parameter but rather to accept VMA flags parameters, which allows us to use
> > this function early in mmap_region() in a subsequent commit.
> >
> > While we're here, we refactor the function to be more readable and add some
> > additional documentation.
> >
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks!

>
> [..]
> > -static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
> > +static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
> >  {
> > +       /* If MDWE is disabled, we have nothing to deny. */
> >         if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> >                 return false;
> >
> > -       if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
> > +       /* If the new VMA is not executable, we have nothing to deny. */
> > +       if (!(new & VM_EXEC))
> > +               return false;
> > +
> > +       /* Under MDWE we absolutely do not accept writably executable... */
> > +       if (new & VM_WRITE)
> >                 return true;
> >
> > -       if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
> > +       /* ...nor newly executable VMAs. */
>
> nit: maybe clarify this as "nor existing VMAs newly becoming
> executable" or something like that

Ack

>
>
> > +       if (!(old & VM_EXEC))
> >                 return true;
> >
> >         return false;

