Return-Path: <linux-kernel+bounces-515770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F1DA368BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C462A3B1DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702C1FC7E8;
	Fri, 14 Feb 2025 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="k7ff5Ytd"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F31C84AC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573631; cv=fail; b=scQexUOlcAOeoaJ/aU+SvWS64RlRtGOpX7RUXDzCgpQZZDu00UxYKtDK4+XfEGyHJQatNJEWUWb8kZv2CCUpzaq4h6ApB1jnFYFJlNp7V/4jAfWcwMX4keOCLjGCPJMywzEl81CAgHSxqIS9m8H391SPSSq8op8VUUSRr9cuJ+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573631; c=relaxed/simple;
	bh=uw5is/zNEJSgGNs8456aKjshyiRMTuGeQUnuCB1ZN2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHrNCtpqQrXDUOXb66o+w8WmK2I+OOZMF/7L5GaMJrOYaqCxRAMy3J80TrNfls9aIyAh/WOeqxlGwp6qghWw3HLYqkaAH7fkWwFeoySqBVic8FvjwKQkdJlWlTKScskk3wYGODrC0b4i+/4gopqgJUGQpTtKYzjjRZuqurF2dYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=k7ff5Ytd; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvLUOkrCCHTXKw4InYMQhVYO5DYUGKTbCn3W9DnIJDUzSihh2Va0uHMyHdq+TvvXCTfA6uyrrmoCtg+lOltpI+uPOhSTGfit14IadRmsPYVmmmdgHIdmiiD4Y6R0Wpkh5HDoSkaEfqAHhkay9aH5twlYuy+lVIlNjoHQ1HMBkbfzSAuHycZqQIOTZ3FmuCXIOirFHqGjJTXZ43QaxEVkCHcVSYMk/VsdmrDIQpupLY5/CmxM5n/YwD9BFawWZk8a9f6GUyINH6ldMrxZutaJ5WGka8cVJur7svttajbYQUG3L950y5WKjGlAQKDIgt5sR7hvy8gWznGrRBX9hY4oSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2/7jkhX0yX9Cku/lBbzH7KzubfSpnlERMDaNZVhiJ4=;
 b=rGJaxmtGfQd3/HMZZt6P81M+tvaDaNxIww2bk2iSeVyMUQTubnzvg+dQBt3rvqXKnVGnKXO/9ypB42kNlvEqAW+hPStSi+uBmtN93qAVX1ykzbEu6iYebvdstQMFOwZWNSxjaEdVMbRVQ9EtJjV7rdBK4fmaBgdDFMonqstcdrew6FJpOI/R0qhO5rr+mbDcGbzJyl6oKLBSz1gY7tFk5WiZcB1Qh9+btnSUBWpWM4BW83TYHOJZKpCEalBKatkukWJlfkCha36PUXIPcHXTM6BoDeRiCbvm9qlPcVb3LkSrS7fTAEqWCrwTcsJnyba8Sgii0wQpbdmnov6C8hNa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2/7jkhX0yX9Cku/lBbzH7KzubfSpnlERMDaNZVhiJ4=;
 b=k7ff5Ytdagfyk9pca4ZFmSRf7L70dnJaiDYtM+GHK1SMCfzuaGbYGgNIhCvPXb5/w79z+5AIj/eV1a5KF8ki3z9cFzGPyrq0V1eBB4xz3quKTC1xHuytemYfUBiD8bpohCBKgf/HxvTa07doB7yEuP/0wbJPh010fTsOT0aVm8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 SA1PR01MB6639.prod.exchangelabs.com (2603:10b6:806:189::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.9; Fri, 14 Feb 2025 22:53:42 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%4]) with mapi id 15.20.8466.007; Fri, 14 Feb 2025
 22:53:42 +0000
Message-ID: <6f110208-eca3-42fa-aa7b-7d93f61ef750@os.amperecomputing.com>
Date: Fri, 14 Feb 2025 14:53:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /dev/zero: make private mapping full anonymous mapping
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 willy@infradead.org, liushixin2@huawei.com, akpm@linux-foundation.org,
 linux-mm@kvack.org
References: <202501281038.617c6b60-lkp@intel.com>
 <01b5c112-480f-40dd-892f-5eb7c53e2f68@os.amperecomputing.com>
 <Z6RshwXCWhAGoMOK@xsang-OptiPlex-9020>
 <eb5896c7-c269-42a8-8fa9-e5e7c23812c4@os.amperecomputing.com>
 <Z61TL9jivJ5U1Ek3@xsang-OptiPlex-9020>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Z61TL9jivJ5U1Ek3@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:930:4a::25) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|SA1PR01MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: cc51dd1c-7a5f-422d-bb51-08dd4d4a6dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmJwMDRHMWt2MVE4UFpRV3dmT3V1QnBnczRmdnRSalQwek9pOW01aDlPM21q?=
 =?utf-8?B?REpXdHdWbGE3eklMTEdjRzR2bUx0dUZnb0NVYmJ4QVdZeVp1d3FHYTgzUklE?=
 =?utf-8?B?SVBGeVgrOE5TZ0hNQmhJRW9nbzExNEJaQ0E2N0xlUHdyN2QwcldzQjQ3Qk1F?=
 =?utf-8?B?cHpyRjlqcjI0Q1pYVlpVNEl6RUFOWUdtd2ZMTGlldWY1K21QNFIrWFRDMmFJ?=
 =?utf-8?B?enJPRGRXd2dPdjlXSE4rWTcwQW1CaUxzckZ1ZzBiTUtKbE9XL2FxaWxsQXdG?=
 =?utf-8?B?MzNlSUdNeWRoSzN0aWlQN3BYKy9MdUJ6NkZCZmhsWjFIQVRqKzYxN2tlNEtG?=
 =?utf-8?B?V3cwU2x3MEErUkpBZGQyMVlWblNhN0c5NkdydHF6cHNDdXJwcTFEbzljeVBi?=
 =?utf-8?B?cFBjMStYR1pPQzJ3RDU5eGhpUTU3VUd1aVhMS09ZeVcxeHNDSzBpSWZsbGNn?=
 =?utf-8?B?NGtFMGJPUFlvaG9zQmV0dXduemhndVlkOXdNdThBSGtqZlNhSU1zU0ZnWVlL?=
 =?utf-8?B?SkFkSDRPclFaSWpQc0hpdlN4Nzl4VXorc0VveFdBV0twWVBncUR5ODIwTm1G?=
 =?utf-8?B?N1g2b3U1TzFISXQ3S0ZhUXlnNjV1b3J3bWYrT25lRmFERWZwUlNwTXV1ak9t?=
 =?utf-8?B?aWN4MXA3UzIwN3lVenkzK0Z1N2drOVZqZmIrS2s4bm9xUnUranRGMytpc3Bt?=
 =?utf-8?B?V2hmcWNwSXZPSTBVWG54RndyUVk2SDZVeGJUaUVUMWpKcWZhWTJ0eFhMUFha?=
 =?utf-8?B?bDBvSVh2dDlDQ1hSUHlRNlk4b1k4MXVZWVRTQzBRdSt1ZXRZampwYklXeGVO?=
 =?utf-8?B?MlhhREpsUjM2dG5JNlU3enY1VUFlTjkya3lZMm1sM2hzVFVVUTB0WVpnbERU?=
 =?utf-8?B?OTlHM3lNNENCYnpNQjNySnVIWHYvRUZSSkJOMlIycHlUWTVha2ZReUFEdDc5?=
 =?utf-8?B?SlNNV1V1V29WNE5kS0ZCdXIyNUIwdlQxdDV2MUZ5d21JdGVRN3o0d3Q2L2d3?=
 =?utf-8?B?b1p3TVNRVFVlZ1V6MHRYWlRPYStzeFpnMmNGKzg2b01wUnpOUXZORkxPZkh1?=
 =?utf-8?B?cElVTTdQcFJVV2svbmJveXd3a1hZb3Z0eTA0bTAvUUlXVHhuWlRxcjZ1Mk93?=
 =?utf-8?B?dmtCT3ZabUlEVUVuZ2R4OVRkL21CZEhYK1dTaUVFcFF6VG5BK1VWRW1hd0Zs?=
 =?utf-8?B?a1ZvWkErMDh3RjhCYVZZR3FHaklqaWhSaGtXeGQ1Y2xyVnVTeTlIUWlYVG1E?=
 =?utf-8?B?TUNJanROenlGQUtrMWtGUGYya0g5cDY5SjlZMVV1ZDRlN0YzS3dSdU5CK3RV?=
 =?utf-8?B?MnpNMFFqYVYyWkNBbTluNDNPNkg3M3lZR1EvQmJoaXFPdDNTdDBoKzF5N3ZQ?=
 =?utf-8?B?Mkx4YWhZMEtTaWRqR0Q1SG5MUmNYMzA1SHhodjg1NVNqS3FubHFMdmI1eDVt?=
 =?utf-8?B?bXQvWGVQS0JoMkpCY3p1K3hwNmoxMzVNOHova2NuVjNmRkNFY0llZjR1MDQ3?=
 =?utf-8?B?MUh5TGRqc3EvNkRnZW81MXdyQlVQdS9oOWtlNC9GSGJlTm1YUFZ1QkNNbHhO?=
 =?utf-8?B?RW54aTVpOStoWFEzTFRiRExxcEx6bDBuRHlXUVg5bEcvUTB1V3k5WEI4cWVM?=
 =?utf-8?B?VFFlZXdCWGM5WGYrMDhRMGlIL2tLM2tsK09TM3FmWFBvMFFaZEdIQUxqbVVP?=
 =?utf-8?B?cmpON1NEcHhWeG4vMWZoMXlEdUU3NFhEYU1BZUFabTVZaEVKcEE1QjhpNlJi?=
 =?utf-8?B?bnFVWU5ieURUVFpTYkgrUzFBcWRBSU4rb091L3h4TXpqYXliamxlMkhGTTFp?=
 =?utf-8?B?cEVqOE50V052VUljWGxvTHNJbzgyUjlucjZaNTZhWnRvNDI3OFg5MDlTSHFU?=
 =?utf-8?Q?2jIgeCmPau32h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a01KZ01TWS8yMUp5c200WUdOOWxBWTJEMHBNRFA3WVkxTHNIbldGelZpN1Y3?=
 =?utf-8?B?dU5UQkJ1Uk1pNTNGb0UyOUJaTGZlUWdwdkpGRDdNVGZQVWdyZGxMYWQ4bWts?=
 =?utf-8?B?WmFHWi9ueGZHa2hKMENvbjhUZHhteU9sQUh2ZDVTYmo4MXF0cVpweUllaW5P?=
 =?utf-8?B?MjdZRnJZUmR6UjNqREVYdEFtb3c5QjZUZjJQYTdpdTRjclRjTUJMbW11OUZH?=
 =?utf-8?B?ZU5pMlozODNlbERrdHc3UXJ2SlVrYkJGa3hqaGZKWnRZUHJzVU4xaG5JM2VP?=
 =?utf-8?B?WEk2Q0lqZ2pQcGdzSDM5bjAvdXFaN2VtdjJtbnprbGFzQzA2VzdOYi9aTXIx?=
 =?utf-8?B?eHdZY2lWajZhdWloSER2V1pBSkRrdEhraGh3NGtKSWV1VnBtUm9OVWVoejNW?=
 =?utf-8?B?TGxjZXlRTGZESVZjcSs1QVkwdjVLOUtXQ1dIZEg5SE5UcFZHNGxyWU5RYWx1?=
 =?utf-8?B?YzdycVJ0WkNuc3dYc082NE5pbzJRWGNDTEw4V1gvVEc3MndHeHJBQ2NGTTVV?=
 =?utf-8?B?b3A0WmdZN1VNektaajVRRnpQa2hQZUZiRUlPQ2FpSEpZUGRITUdCUW85ZlQw?=
 =?utf-8?B?Ti8zcStCWVVUYUE3RUpFbnRuaDQ4TjV0UXZYNUsyZGorSjVhRXNVb2p2dW4v?=
 =?utf-8?B?bk82Z1ZBamFENzNaY1V0alcrbWhjVmQ1SXRkUEIwOG9aSGh4alFsZE44Mkky?=
 =?utf-8?B?eGdua3BUSmdNZkttbW9zZ09aRy9zSXR5ZTA5a000cjZjTUtiRDFvMVpLeHNO?=
 =?utf-8?B?ODhDdXk0R1Q4Unc5ell6bXcrS1J4anl6Z1BWNEVGYWdKTzEyaE4zck0rVXhE?=
 =?utf-8?B?bTNEdko3NTZaNjBDaEZRdEFvL1ZuZWJIbGVzbURzOEx3aHFBUzExWWp2eGE4?=
 =?utf-8?B?L3g4TTBiWTVsdmo5M0U0eHMyRDNJQ01yV2NqQzVyQUxQYXQ3dnpVZnVZakdN?=
 =?utf-8?B?RU9qQjZvaHNkeGdIS0ttalZUQ2MrL2dJV1YyK3ZDRzRuUHhFNFljOUFwcWVh?=
 =?utf-8?B?Q1hGNjBMYW9PMXIwUEdqMHc0WnZBQ0ZKckM5cWNPNXNjQUFaMnoxK2ZuY3pZ?=
 =?utf-8?B?TCtiRWh5K05OMGJQMER2QW9NT3NndEUrcVRadGhrQjZJVHhJZG1uTEdVL2E2?=
 =?utf-8?B?OXlUOXFIM05ZTVViU29jeW9JZWpVakRIcE95VU92Qk9JbktqcDhMSG9nSEE1?=
 =?utf-8?B?aGorUlBEZGUyOUlNcFh4WWNMQi9UUmtVcnB3bDlSNjZvaWc2ekdWSnVYWkNu?=
 =?utf-8?B?WUVMOVNhdzIzbmMvN0ZQKzZMWng0N3dhQkVhUjZxQmhKVFkxV0dJVzhZOVhC?=
 =?utf-8?B?bmxLYzl5R1EvZnF3S2RqcGxkejUxMVhGbFNkVU9GQ0V5dGc4ZW5hSjNHcmI0?=
 =?utf-8?B?SFZnaitsVXpqZkVLbCthWnQyZ3ZqaEw1TkFOdFkvQ2pwRmRBWVBPalZSTUJt?=
 =?utf-8?B?Y2RyZklXYjM0WGxTM0pTOFdvemMrY0RObmtpQVpTTVZSamgrVHMwN29OK0Vj?=
 =?utf-8?B?NDNldStVd0YyVTR1bkIwWUVRT0NsTjZySHNnaTNqSmJabmppQXg3N0k1aGpU?=
 =?utf-8?B?RkdBUDVVZlhldHlUakhWWHFmU0RiOUx4ajFuRzk5bUNtK1Yvb1UvV09MU0NR?=
 =?utf-8?B?YXJBL2Y0MzN5MDA1ckRkMkxDVVYrdm84N0wvSkJlbjlKTENxM29Zc2xZU3Qx?=
 =?utf-8?B?R3FweVE2eXdKV3NlL3NlNEVYNko3d2ZERU9waDdKdi8rejJnWUhZNEpsbW5i?=
 =?utf-8?B?K205UnVFMTdNUzAyQ21JVjhvR2VYd0MxMGNtb28zb0ZLaWNRcSs0OTkxYVk0?=
 =?utf-8?B?MjdZcG9ESjAxTTFMdEFqVWgwUmRxQjhXL1BaSlRIU05vQXFKSmt3TXJvMCtS?=
 =?utf-8?B?emhpVldEU2lrNzlXbXJXV2c1U1hMdDZKUEJSa3pXYURydHNmdnFtWjNPSjNL?=
 =?utf-8?B?Qm1temJtRHl2b2h0dnBVUmdFSWdKeWwwVTlodWpQa1pxSlRsWThzcWNGVDlN?=
 =?utf-8?B?ajhkVDA5dWZEb01KYTB4T3lleUVITzVtbGlKT2hWelN5cC9KVmI3TkVVelIx?=
 =?utf-8?B?c003YmU1anVOYStxbE9LZ25IUGZ4eG5pWlJjM3NtQkNVYnVPTkhBUVpETmVR?=
 =?utf-8?B?ekwrdjY0QWdidDlEUUg1d2F5Q0tXVXJ2c0RlcVJyQm0wOFFTdVBHUWtIbU5J?=
 =?utf-8?Q?RtDPwoaqhuTujF7vlCf5jOk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc51dd1c-7a5f-422d-bb51-08dd4d4a6dc4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 22:53:42.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mSnLONjVHYft5lz48bjs0YQ5rWzcSTOevBK5bkkV/1c5yyhKPKwjIIfPz1ViWZ8qQF2qXMgjFaOOOlV6SARQJUnhmQbn7L723UfSMq0HaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6639




On 2/12/25 6:04 PM, Oliver Sang wrote:
> hi, Yang Shi,
>
> On Fri, Feb 07, 2025 at 10:10:37AM -0800, Yang Shi wrote:
>> On 2/6/25 12:02 AM, Oliver Sang wrote:
> [...]
>
>>> since we applied your "/dev/zero: make private mapping full anonymous mapping"
>>> patch upon a68d3cbfad like below:
>>>
>>> * 7143ee2391f1e /dev/zero: make private mapping full anonymous mapping
>>> * a68d3cbfade64 memstick: core: fix kernel-doc notation
>>>
>>> so I applied below patch also upon a68d3cbfad.
>>>
>>> we saw big improvement but not that big.
>>>
>>> =========================================================================================
>>> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>>     gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/small-allocs/vm-scalability
>>>
>>> commit:
>>>     a68d3cbfad ("memstick: core: fix kernel-doc notation")
>>>     52ec85cb99  <--- your patch
>>>
>>>
>>> a68d3cbfade64392 52ec85cb99e9b31dc304eae965a
>>> ---------------- ---------------------------
>>>            %stddev     %change         %stddev
>>>                \          |                \
>>>     14364828 ±  4%    +410.6%   73349239 ±  3%  vm-scalability.throughput
>>>
>>> full comparison as below [1] just FYI.
>> Thanks for the update. I stared at the profiling report for a whole day, but
>> I didn't figure out where that 400% lost. I just saw the number of page
>> faults was fewer. And it seems like the reduction of page faults match the
>> 400% loss. So I did more trace and profiling.
>>
>> The test case did the below stuff in a tight loop:
>>    mmap 40K memory from /dev/zero (read only)
>>    read the area
>>
>> So two major factors to the performance: mmap and page fault. The
>> alternative patch did reduce the overhead of mmap to the same level as the
>> original patch.
>>
>> The further perf profiling showed the cost of page fault is higher than the
>> original patch. But the profiling of page fault was interesting:
>>
>> -   44.87%     0.01%  usemem [kernel.kallsyms]                   [k]
>> do_translation_fault
>>     - 44.86% do_translation_fault
>>        - 44.83% do_page_fault
>>           - 44.53% handle_mm_fault
>>                9.04% __handle_mm_fault
>>
>> Page fault consumed 40% of cpu time in handle_mm_fault, but
>> __handle_mm_fault just consumed 9%, I expected it should be the major
>> consumer.
>>
>> So I annotated handle_mm_fault, then found the most time was consumed by
>> lru_gen_enter_fault() -> vma_has_recency() (my kernel has multi-gen LRU
>> enabled):
>>
>>        │     if (vma->vm_file && (vma->vm_file->f_mode & FMODE_NOREUSE))
>>         │     ↓ cbz     x1, b4
>>    0.00 │       ldr     w0, [x1, #12]
>>   99.59 │       eor     x0, x0, #0x800000
>>    0.00 │       ubfx    w0, w0, #23, #1
>>         │     current->in_lru_fault = vma_has_recency(vma);
>>    0.00 │ b4:   ldrh    w1, [x2, #1992]
>>    0.01 │       bfi     w1, w0, #5, #1
>>    0.00 │       strh    w1, [x2, #1992]
>>
>>
>> vma_has_recency() read vma->vm_file->f_mode if vma->vm_file is not NULL. But
>> that load took a long time. So I inspected struct file and saw:
>>
>> struct file {
>>      file_ref_t            f_ref;
>>      spinlock_t            f_lock;
>>      fmode_t                f_mode;
>>      const struct file_operations    *f_op;
>>      ...
>> }
>>
>> The f_mode is in the same cache line with f_ref (my kernel does NOT have
>> spin lock debug enabled). The test case mmap /dev/zero in a tight loop, so
>> the refcount is modified (fget/fput) very frequently, this resulted in
>> somehow false sharing.
>>
>> So I tried the below patch on top of the alternative patch:
>>
>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
>> index f9157a0c42a5..ba11dc0b1c7c 100644
>> --- a/include/linux/mm_inline.h
>> +++ b/include/linux/mm_inline.h
>> @@ -608,6 +608,9 @@ static inline bool vma_has_recency(struct vm_area_struct
>> *vma)
>>          if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
>>                  return false;
>>
>> +       if (vma_is_anonymous(vma))
>> +               return true;
>> +
>>          if (vma->vm_file && (vma->vm_file->f_mode & FMODE_NOREUSE))
>>                  return false;
>>
>> This made the profiling of page fault look normal:
>>
>>                          - 1.90% do_translation_fault
>>                             - 1.87% do_page_fault
>>                                - 1.49% handle_mm_fault
>>                                   - 1.36% __handle_mm_fault
>>
>> Please try this in your test.
>>
>> But AFAICT I have never seen performance issue reported due to the false
>> sharing of refcount and other fields in struct file. This benchmark stressed
>> this quite badly.
> I applied your above patch upon alternative patch last time, then saw more
> improvement (+445.2% vs a68d3cbfad), but still not that big as in our original
> report.

Thanks for the update. It looks like the problem is still in page 
faults. I did my test on arm64 machine. I also noticed struct file has 
"__randomize_layout", so it may have different layout on x86 than arm64?

The page fault handler may also access other fields of struct file that 
may cause false sharing, for example, accessing f_mapping to read gfp 
flags. This may not be a problem on my machine, but may be more costly 
on yours depending on the real layout of struct file on the machines,

Can you please try the below patch on top of the current patches? Thank 
you so much for your patience.

diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..1fa9dbce0f66 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3214,6 +3214,9 @@ static gfp_t __get_fault_gfp_mask(struct 
vm_area_struct *vma)
  {
         struct file *vm_file = vma->vm_file;

+       if (vma_is_anonymous(vma))
+               return GFP_KERNEL;
+
         if (vm_file)
                 return mapping_gfp_mask(vm_file->f_mapping) | __GFP_FS 
| __GFP_IO;

>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/small-allocs/vm-scalability
>
> commit:
>    a68d3cbfad ("memstick: core: fix kernel-doc notation")
>    52ec85cb99  <--- a68d3cbfad + alternative
>    d4a204fefe  <--- a68d3cbfad + alternative + new patch in vma_has_recency()
>
> a68d3cbfade64392 52ec85cb99e9b31dc304eae965a d4a204fefec91546a317e52ae19
> ---------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \
>    14364828 ±  4%    +410.6%   73349239 ±  3%    +445.2%   78318730 ±  4%  vm-scalability.throughput
>
>
> full comparison is as below:
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
>    gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/small-allocs/vm-scalability
>
> commit:
>    a68d3cbfad ("memstick: core: fix kernel-doc notation")
>    52ec85cb99  <--- a68d3cbfad + alternative
>    d4a204fefe  <--- a68d3cbfad + alternative + new patch in vma_has_recency()
>
> a68d3cbfade64392 52ec85cb99e9b31dc304eae965a d4a204fefec91546a317e52ae19
> ---------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \
>   5.262e+09 ±  3%     -45.0%  2.896e+09 ±  6%     +10.0%  5.791e+09 ±126%  cpuidle..time
>     7924008 ±  3%     -79.3%    1643339 ± 11%     -77.4%    1791703 ± 12%  cpuidle..usage
>     1871164 ±  4%     -22.4%    1452554 ± 12%     -20.9%    1479724 ± 13%  numa-numastat.node3.local_node
>     1952164 ±  3%     -20.1%    1560294 ± 12%     -19.1%    1580192 ± 12%  numa-numastat.node3.numa_hit
>      399.52           -68.2%     126.86           -65.9%     136.26 ± 23%  uptime.boot
>       14507           -15.7%      12232            +5.2%      15256 ± 48%  uptime.idle
>        6.99 ±  3%    +147.9%      17.34 ±  4%    +249.9%      24.47 ± 62%  vmstat.cpu.id
>        1.71          +473.6%       9.79 ±  2%    +437.6%       9.18 ± 19%  vmstat.cpu.us
>       34204 ±  5%     -72.9%       9272 ±  7%     -73.5%       9074 ± 16%  vmstat.system.cs
>      266575           -21.2%     210191           -26.9%     194776 ± 20%  vmstat.system.in
>        3408 ±  5%     -99.8%       8.38 ± 48%     -99.6%      13.38 ± 68%  perf-c2c.DRAM.local
>       18076 ±  3%     -99.8%      32.25 ± 27%     -99.7%      54.12 ± 35%  perf-c2c.DRAM.remote
>        8082 ±  5%     -99.8%      15.50 ± 64%     -99.7%      26.38 ± 52%  perf-c2c.HITM.local
>        6544 ±  6%     -99.8%      13.62 ± 51%     -99.7%      19.25 ± 43%  perf-c2c.HITM.remote
>       14627 ±  4%     -99.8%      29.12 ± 53%     -99.7%      45.62 ± 43%  perf-c2c.HITM.total
>        6.49 ±  3%      +8.8       15.24 ±  5%     +15.9       22.44 ± 71%  mpstat.cpu.all.idle%
>        0.63            -0.3        0.32 ±  4%      -0.3        0.31 ± 22%  mpstat.cpu.all.irq%
>        0.03 ±  2%      +0.2        0.26 ±  2%      +0.2        0.25 ± 20%  mpstat.cpu.all.soft%
>       91.17           -17.0       74.15           -23.6       67.58 ± 20%  mpstat.cpu.all.sys%
>        1.68 ±  2%      +8.3       10.03 ±  2%      +7.7        9.42 ± 19%  mpstat.cpu.all.usr%
>      337.33           -97.4%       8.88 ± 75%     -98.2%       6.00 ± 88%  mpstat.max_utilization.seconds
>      352.76           -77.3%      79.95 ±  2%     -78.5%      75.89 ±  3%  time.elapsed_time
>      352.76           -77.3%      79.95 ±  2%     -78.5%      75.89 ±  3%  time.elapsed_time.max
>      225965 ±  7%     -16.0%     189844 ±  6%     -20.6%     179334 ±  3%  time.involuntary_context_switches
>   9.592e+08 ±  4%     +11.9%  1.074e+09           +11.9%  1.074e+09        time.minor_page_faults
>       20852            -8.8%      19012            -9.8%      18815        time.percent_of_cpu_this_job_got
>       72302           -81.4%      13425 ±  3%     -82.6%      12566 ±  4%  time.system_time
>        1260 ±  3%     +41.0%       1777           +36.2%       1716        time.user_time
>     5393707 ±  5%     -98.4%      86880 ± 17%     -98.2%      96659 ± 22%  time.voluntary_context_switches
>     1609925           -50.3%     800493           -51.0%     788816 ±  2%  meminfo.Active
>     1609925           -50.3%     800493           -51.0%     788816 ±  2%  meminfo.Active(anon)
>      160837 ± 33%     -63.9%      58119 ± 13%     -65.9%      54899 ± 31%  meminfo.AnonHugePages
>     4435665           -18.5%    3614714           -18.7%    3604829        meminfo.Cached
>     1775547           -43.8%     998415           -44.8%     980447 ±  3%  meminfo.Committed_AS
>      148539           -43.7%      83699 ±  4%     -46.1%      80050 ±  2%  meminfo.Mapped
>     4245538 ±  4%     -20.9%    3356561           -28.0%    3056817 ± 20%  meminfo.PageTables
>    14166291 ±  4%      -9.6%   12806082           -15.9%   11919101 ± 19%  meminfo.SUnreclaim
>      929777           -88.2%     109274 ±  3%     -89.4%      98935 ± 15%  meminfo.Shmem
>    14315492 ±  4%      -9.6%   12947821           -15.7%   12061412 ± 19%  meminfo.Slab
>    25676018 ±  3%     +10.9%   28487403           +16.3%   29863951 ±  8%  meminfo.max_used_kB
>       64129 ±  4%    +418.9%     332751 ±  3%    +453.6%     355040 ±  4%  vm-scalability.median
>       45.40 ±  5%   +1961.8        2007 ±  8%   +2094.7        2140 ± 11%  vm-scalability.stddev%
>    14364828 ±  4%    +410.6%   73349239 ±  3%    +445.2%   78318730 ±  4%  vm-scalability.throughput
>      352.76           -77.3%      79.95 ±  2%     -78.5%      75.89 ±  3%  vm-scalability.time.elapsed_time
>      352.76           -77.3%      79.95 ±  2%     -78.5%      75.89 ±  3%  vm-scalability.time.elapsed_time.max
>      225965 ±  7%     -16.0%     189844 ±  6%     -20.6%     179334 ±  3%  vm-scalability.time.involuntary_context_switches
>   9.592e+08 ±  4%     +11.9%  1.074e+09           +11.9%  1.074e+09        vm-scalability.time.minor_page_faults
>       20852            -8.8%      19012            -9.8%      18815        vm-scalability.time.percent_of_cpu_this_job_got
>       72302           -81.4%      13425 ±  3%     -82.6%      12566 ±  4%  vm-scalability.time.system_time
>        1260 ±  3%     +41.0%       1777           +36.2%       1716        vm-scalability.time.user_time
>     5393707 ±  5%     -98.4%      86880 ± 17%     -98.2%      96659 ± 22%  vm-scalability.time.voluntary_context_switches
>   4.316e+09 ±  4%     +11.9%  4.832e+09           +11.9%  4.832e+09        vm-scalability.workload
>      265763 ±  4%     -20.5%     211398 ±  4%     -28.7%     189557 ± 22%  numa-vmstat.node0.nr_page_table_pages
>       31364 ±106%     -85.0%       4690 ±169%     -66.5%      10503 ±106%  numa-vmstat.node0.nr_shmem
>      891094 ±  4%      -8.0%     819697 ±  3%     -17.0%     739565 ± 21%  numa-vmstat.node0.nr_slab_unreclaimable
>       12205 ± 67%     -74.1%       3161 ±199%     -30.0%       8543 ± 98%  numa-vmstat.node1.nr_mapped
>      265546 ±  4%     -21.8%     207742 ±  4%     -27.1%     193704 ± 22%  numa-vmstat.node1.nr_page_table_pages
>       44052 ± 71%     -86.0%       6163 ±161%     -92.9%       3126 ±239%  numa-vmstat.node1.nr_shmem
>      885590 ±  4%      -9.9%     797649 ±  4%     -15.0%     752585 ± 21%  numa-vmstat.node1.nr_slab_unreclaimable
>      264589 ±  4%     -21.2%     208598 ±  4%     -28.0%     190497 ± 20%  numa-vmstat.node2.nr_page_table_pages
>      881598 ±  4%     -10.0%     793829 ±  4%     -15.3%     747142 ± 19%  numa-vmstat.node2.nr_slab_unreclaimable
>      192683 ± 30%     -61.0%      75078 ± 70%     -90.4%      18510 ±122%  numa-vmstat.node3.nr_active_anon
>      286819 ±108%     -93.0%      19993 ± 39%     -88.8%      32096 ± 44%  numa-vmstat.node3.nr_file_pages
>       13124 ± 49%     -92.3%       1006 ± 57%     -96.1%     510.58 ± 55%  numa-vmstat.node3.nr_mapped
>      264499 ±  4%     -22.1%     206135 ±  2%     -30.9%     182777 ± 21%  numa-vmstat.node3.nr_page_table_pages
>      139810 ± 14%     -90.5%      13229 ± 89%     -99.4%     844.61 ± 73%  numa-vmstat.node3.nr_shmem
>      880199 ±  4%     -11.8%     776210 ±  5%     -18.3%     718982 ± 21%  numa-vmstat.node3.nr_slab_unreclaimable
>      192683 ± 30%     -61.0%      75077 ± 70%     -90.4%      18510 ±122%  numa-vmstat.node3.nr_zone_active_anon
>     1951359 ±  3%     -20.1%    1558936 ± 12%     -19.1%    1578968 ± 12%  numa-vmstat.node3.numa_hit
>     1870359 ±  4%     -22.4%    1451195 ± 12%     -21.0%    1478500 ± 13%  numa-vmstat.node3.numa_local
>      402515           -50.3%     200150           -51.0%     197173 ±  2%  proc-vmstat.nr_active_anon
>      170568            +1.9%     173746            +1.7%     173416        proc-vmstat.nr_anon_pages
>     4257257            +0.9%    4296664            +1.7%    4330365        proc-vmstat.nr_dirty_background_threshold
>     8524925            +0.9%    8603835            +1.7%    8671318        proc-vmstat.nr_dirty_threshold
>     1109246           -18.5%     903959           -18.7%     901412        proc-vmstat.nr_file_pages
>    42815276            +0.9%   43210344            +1.7%   43547728        proc-vmstat.nr_free_pages
>       37525           -43.6%      21164 ±  4%     -46.1%      20229 ±  2%  proc-vmstat.nr_mapped
>     1059932 ±  4%     -21.1%     836810           -28.3%     760302 ± 20%  proc-vmstat.nr_page_table_pages
>      232507           -88.2%      27341 ±  3%     -89.4%      24701 ± 15%  proc-vmstat.nr_shmem
>       37297            -5.0%      35436            -4.6%      35576        proc-vmstat.nr_slab_reclaimable
>     3537843 ±  4%      -9.8%    3192506           -16.1%    2966663 ± 20%  proc-vmstat.nr_slab_unreclaimable
>      402515           -50.3%     200150           -51.0%     197173 ±  2%  proc-vmstat.nr_zone_active_anon
>       61931 ±  8%     -83.8%      10023 ± 45%     -76.8%      14345 ± 33%  proc-vmstat.numa_hint_faults
>       15755 ± 21%     -87.1%       2039 ± 97%     -79.9%       3159 ± 84%  proc-vmstat.numa_hint_faults_local
>     6916516 ±  3%      -7.1%    6425430            -7.0%    6429349        proc-vmstat.numa_hit
>     6568542 ±  3%      -7.5%    6077764            -7.4%    6081764        proc-vmstat.numa_local
>      293942 ±  3%     -69.6%      89435 ± 49%     -68.7%      92135 ± 33%  proc-vmstat.numa_pte_updates
>   9.608e+08 ±  4%     +11.8%  1.074e+09           +11.8%  1.074e+09        proc-vmstat.pgfault
>       55981 ±  2%     -63.1%      20641 ±  2%     -61.6%      21497 ± 15%  proc-vmstat.pgreuse
>     1063552 ±  4%     -20.3%     847673 ±  4%     -28.4%     761616 ± 21%  numa-meminfo.node0.PageTables
>     3565610 ±  4%      -8.0%    3279375 ±  3%     -16.8%    2967130 ± 20%  numa-meminfo.node0.SUnreclaim
>      125455 ±106%     -85.2%      18620 ±168%     -66.2%      42381 ±106%  numa-meminfo.node0.Shmem
>     3592377 ±  4%      -7.1%    3336072 ±  4%     -16.2%    3011209 ± 20%  numa-meminfo.node0.Slab
>       48482 ± 67%     -74.3%      12475 ±199%     -30.6%      33629 ± 99%  numa-meminfo.node1.Mapped
>     1062709 ±  4%     -21.7%     831966 ±  4%     -26.7%     778849 ± 22%  numa-meminfo.node1.PageTables
>     3543793 ±  4%     -10.0%    3189589 ±  4%     -14.8%    3018852 ± 21%  numa-meminfo.node1.SUnreclaim
>      176171 ± 71%     -86.0%      24677 ±161%     -92.9%      12510 ±239%  numa-meminfo.node1.Shmem
>     3593431 ±  4%     -10.4%    3220352 ±  4%     -14.6%    3069779 ± 21%  numa-meminfo.node1.Slab
>     1058901 ±  4%     -21.3%     833124 ±  4%     -27.7%     766065 ± 19%  numa-meminfo.node2.PageTables
>     3527862 ±  4%     -10.2%    3168666 ±  5%     -15.0%    2999540 ± 19%  numa-meminfo.node2.SUnreclaim
>     3565750 ±  4%     -10.3%    3200248 ±  5%     -15.2%    3022861 ± 19%  numa-meminfo.node2.Slab
>      770405 ± 30%     -61.0%     300435 ± 70%     -90.4%      74044 ±122%  numa-meminfo.node3.Active
>      770405 ± 30%     -61.0%     300435 ± 70%     -90.4%      74044 ±122%  numa-meminfo.node3.Active(anon)
>      380096 ± 50%     -32.8%     255397 ± 73%     -78.2%      82996 ±115%  numa-meminfo.node3.AnonPages.max
>     1146977 ±108%     -93.0%      80110 ± 40%     -88.8%     128436 ± 44%  numa-meminfo.node3.FilePages
>       52663 ± 47%     -91.6%       4397 ± 56%     -96.0%       2104 ± 52%  numa-meminfo.node3.Mapped
>     6368902 ± 20%     -21.2%    5021246 ±  2%     -27.8%    4597733 ± 18%  numa-meminfo.node3.MemUsed
>     1058539 ±  4%     -22.2%     823061 ±  3%     -30.6%     734757 ± 20%  numa-meminfo.node3.PageTables
>     3522496 ±  4%     -12.1%    3096728 ±  6%     -18.1%    2885117 ± 21%  numa-meminfo.node3.SUnreclaim
>      558943 ± 14%     -90.5%      53054 ± 89%     -99.4%       3423 ± 71%  numa-meminfo.node3.Shmem
>     3557392 ±  4%     -12.3%    3119454 ±  6%     -18.2%    2909118 ± 20%  numa-meminfo.node3.Slab
>        0.82 ±  4%     -39.7%       0.50 ± 12%     -28.2%       0.59 ± 34%  perf-stat.i.MPKI
>   2.714e+10 ±  2%    +185.7%  7.755e+10 ±  6%    +174.8%  7.457e+10 ± 27%  perf-stat.i.branch-instructions
>        0.11 ±  3%      +0.1        0.20 ±  5%      +0.3        0.40 ±121%  perf-stat.i.branch-miss-rate%
>    24932893          +156.6%   63980942 ±  5%    +150.2%   62383567 ± 25%  perf-stat.i.branch-misses
>       64.93           -10.1       54.87 ±  2%     -13.6       51.34 ± 20%  perf-stat.i.cache-miss-rate%
>       34508 ±  4%     -61.4%      13315 ± 10%     -64.1%      12391 ± 25%  perf-stat.i.context-switches
>        7.67           -63.7%       2.79 ±  6%     -67.4%       2.50 ± 14%  perf-stat.i.cpi
>      224605           +10.8%     248972 ±  4%     +11.8%     251127 ±  4%  perf-stat.i.cpu-clock
>      696.35 ±  2%     -57.4%     296.79 ±  3%     -59.8%     279.73 ±  5%  perf-stat.i.cpu-migrations
>       10834 ±  4%     -12.5%       9483 ± 20%     -20.2%       8648 ± 28%  perf-stat.i.cycles-between-cache-misses
>   1.102e+11          +128.5%  2.518e+11 ±  6%    +119.9%  2.423e+11 ± 27%  perf-stat.i.instructions
>        0.14          +198.2%       0.42 ±  5%    +239.7%       0.48 ± 21%  perf-stat.i.ipc
>       24.25 ±  3%    +375.8%     115.36 ±  3%    +353.8%     110.03 ± 26%  perf-stat.i.metric.K/sec
>     2722043 ±  3%    +439.7%   14690226 ±  6%    +418.1%   14103930 ± 27%  perf-stat.i.minor-faults
>     2722043 ±  3%    +439.7%   14690226 ±  6%    +418.1%   14103929 ± 27%  perf-stat.i.page-faults
>      224605           +10.8%     248972 ±  4%     +11.8%     251127 ±  4%  perf-stat.i.task-clock
>        0.81 ±  3%     -52.5%       0.39 ± 14%     -59.6%       0.33 ± 38%  perf-stat.overall.MPKI
>        0.09            -0.0        0.08 ±  2%      -0.0        0.07 ± 37%  perf-stat.overall.branch-miss-rate%
>       64.81            -6.4       58.40           -13.3       51.49 ± 37%  perf-stat.overall.cache-miss-rate%
>        7.24           -56.3%       3.17 ±  3%     -63.8%       2.62 ± 38%  perf-stat.overall.cpi
>        8933 ±  4%      -6.0%       8401 ± 16%     -21.3%       7029 ± 38%  perf-stat.overall.cycles-between-cache-misses
>        0.14          +129.0%       0.32 ±  3%    +112.0%       0.29 ± 38%  perf-stat.overall.ipc
>        9012 ±  2%     -57.5%       3827           -62.8%       3349 ± 37%  perf-stat.overall.path-length
>   2.701e+10 ±  2%    +159.6%  7.012e+10 ±  2%    +117.1%  5.863e+10 ± 43%  perf-stat.ps.branch-instructions
>    24708939          +119.2%   54173035           +81.0%   44726149 ± 43%  perf-stat.ps.branch-misses
>       34266 ±  5%     -73.9%       8949 ±  7%     -77.8%       7599 ± 41%  perf-stat.ps.context-switches
>   7.941e+11            -9.1%  7.219e+11           -27.9%  5.729e+11 ± 44%  perf-stat.ps.cpu-cycles
>      693.54 ±  2%     -68.6%     217.73 ±  5%     -74.1%     179.66 ± 38%  perf-stat.ps.cpu-migrations
>   1.097e+11          +108.1%  2.282e+11 ±  2%     +73.9%  1.907e+11 ± 43%  perf-stat.ps.instructions
>     2710577 ±  3%    +388.7%   13246535 ±  2%    +308.6%   11076222 ± 44%  perf-stat.ps.minor-faults
>     2710577 ±  3%    +388.7%   13246536 ±  2%    +308.6%   11076222 ± 44%  perf-stat.ps.page-faults
>   3.886e+13 ±  2%     -52.4%  1.849e+13           -58.3%  1.619e+13 ± 37%  perf-stat.total.instructions
>    64052898 ±  5%     -96.2%    2460331 ±166%     -93.1%    4432025 ±129%  sched_debug.cfs_rq:/.avg_vruntime.avg
>    95701822 ±  7%     -85.1%   14268127 ±116%     -60.2%   38124846 ±118%  sched_debug.cfs_rq:/.avg_vruntime.max
>    43098762 ±  6%     -96.0%    1715136 ±173%     -93.3%    2867368 ±131%  sched_debug.cfs_rq:/.avg_vruntime.min
>     9223270 ±  9%     -84.2%    1457904 ±122%     -61.0%    3595639 ±113%  sched_debug.cfs_rq:/.avg_vruntime.stddev
>        0.00 ± 22%     -80.1%       0.00 ±185%     -86.8%       0.00 ±173%  sched_debug.cfs_rq:/.h_nr_delayed.avg
>        0.69 ±  8%     -73.0%       0.19 ±185%     -82.0%       0.12 ±173%  sched_debug.cfs_rq:/.h_nr_delayed.max
>        0.05 ± 12%     -76.3%       0.01 ±185%     -84.2%       0.01 ±173%  sched_debug.cfs_rq:/.h_nr_delayed.stddev
>        0.78 ±  2%     -77.0%       0.18 ±130%     -71.9%       0.22 ±107%  sched_debug.cfs_rq:/.h_nr_running.avg
>    43049468 ± 22%     -89.3%    4590302 ±180%     -89.0%    4726833 ±129%  sched_debug.cfs_rq:/.left_deadline.max
>     3836405 ± 37%     -85.6%     550773 ±176%     -77.5%     864733 ±132%  sched_debug.cfs_rq:/.left_deadline.stddev
>    43049467 ± 22%     -89.3%    4590279 ±180%     -89.0%    4726820 ±129%  sched_debug.cfs_rq:/.left_vruntime.max
>     3836405 ± 37%     -85.6%     550772 ±176%     -77.5%     862614 ±132%  sched_debug.cfs_rq:/.left_vruntime.stddev
>    64052901 ±  5%     -96.2%    2460341 ±166%     -93.1%    4432036 ±129%  sched_debug.cfs_rq:/.min_vruntime.avg
>    95701822 ±  7%     -85.1%   14268127 ±116%     -60.2%   38124846 ±118%  sched_debug.cfs_rq:/.min_vruntime.max
>    43098762 ±  6%     -96.0%    1715136 ±173%     -93.3%    2867368 ±131%  sched_debug.cfs_rq:/.min_vruntime.min
>     9223270 ±  9%     -84.2%    1457902 ±122%     -61.0%    3595638 ±113%  sched_debug.cfs_rq:/.min_vruntime.stddev
>        0.77 ±  2%     -77.4%       0.17 ±128%     -72.3%       0.21 ±107%  sched_debug.cfs_rq:/.nr_running.avg
>        1.61 ± 24%    +396.0%       7.96 ± 62%    +355.1%       7.31 ± 52%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>       86.69          +424.4%     454.62 ± 24%    +400.6%     433.98 ± 26%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>       11.14 ± 13%    +409.8%      56.79 ± 35%    +373.6%      52.77 ± 34%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>        1.61 ± 24%    +396.0%       7.96 ± 62%    +355.1%       7.31 ± 52%  sched_debug.cfs_rq:/.removed.util_avg.avg
>       86.69          +424.4%     454.62 ± 24%    +400.6%     433.98 ± 26%  sched_debug.cfs_rq:/.removed.util_avg.max
>       11.14 ± 13%    +409.8%      56.79 ± 35%    +373.6%      52.77 ± 34%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>    43049467 ± 22%     -89.3%    4590282 ±180%     -89.0%    4726821 ±129%  sched_debug.cfs_rq:/.right_vruntime.max
>     3836405 ± 37%     -85.6%     550772 ±176%     -77.5%     862614 ±132%  sched_debug.cfs_rq:/.right_vruntime.stddev
>      286633 ± 43%    +262.3%    1038592 ± 36%    +188.3%     826260 ± 58%  sched_debug.cfs_rq:/.runnable_avg.avg
>    34728895 ± 30%    +349.2%   1.56e+08 ± 26%    +293.3%  1.366e+08 ± 60%  sched_debug.cfs_rq:/.runnable_avg.max
>     2845573 ± 30%    +325.9%   12119045 ± 26%    +251.3%    9995202 ± 55%  sched_debug.cfs_rq:/.runnable_avg.stddev
>      769.03           -69.9%     231.86 ± 84%     -66.3%     259.37 ± 72%  sched_debug.cfs_rq:/.util_avg.avg
>        1621 ±  5%     -31.5%       1111 ±  8%     -35.4%       1048 ±  8%  sched_debug.cfs_rq:/.util_avg.max
>      159.12 ±  8%     +22.3%     194.66 ± 12%     +35.0%     214.82 ± 14%  sched_debug.cfs_rq:/.util_avg.stddev
>      724.17 ±  2%     -89.6%      75.66 ±147%     -88.3%      84.74 ±123%  sched_debug.cfs_rq:/.util_est.avg
>        1360 ± 15%     -39.2%     826.88 ± 37%     -29.0%     965.90 ± 48%  sched_debug.cfs_rq:/.util_est.max
>      766944 ±  3%     +18.1%     905901           +21.7%     933047 ±  2%  sched_debug.cpu.avg_idle.avg
>     1067639 ±  5%     +30.0%    1387534 ± 16%     +38.2%    1475131 ± 15%  sched_debug.cpu.avg_idle.max
>      321459 ±  2%     -35.6%     207172 ± 10%     -33.5%     213764 ± 15%  sched_debug.cpu.avg_idle.stddev
>      195573           -72.7%      53401 ± 24%     -68.5%      61507 ± 35%  sched_debug.cpu.clock.avg
>      195596           -72.7%      53442 ± 24%     -68.5%      61565 ± 35%  sched_debug.cpu.clock.max
>      195548           -72.7%      53352 ± 24%     -68.6%      61431 ± 35%  sched_debug.cpu.clock.min
>      194424           -72.6%      53229 ± 24%     -68.5%      61304 ± 35%  sched_debug.cpu.clock_task.avg
>      194608           -72.6%      53383 ± 24%     -68.4%      61478 ± 34%  sched_debug.cpu.clock_task.max
>      181834           -77.5%      40964 ± 31%     -73.0%      49012 ± 43%  sched_debug.cpu.clock_task.min
>        4241 ±  2%     -80.6%     821.65 ±142%     -77.1%     971.85 ±116%  sched_debug.cpu.curr->pid.avg
>        9799 ±  2%     -55.4%       4365 ± 17%     -51.6%       4747 ± 22%  sched_debug.cpu.curr->pid.max
>        1365 ± 10%     -48.0%     709.44 ±  5%     -39.9%     820.19 ± 24%  sched_debug.cpu.curr->pid.stddev
>      537665 ±  4%     +31.2%     705318 ± 14%     +44.0%     774261 ± 15%  sched_debug.cpu.max_idle_balance_cost.max
>        3119 ± 56%    +579.1%      21184 ± 39%   +1048.3%      35821 ± 65%  sched_debug.cpu.max_idle_balance_cost.stddev
>        0.78 ±  2%     -76.3%       0.18 ±135%     -72.0%       0.22 ±114%  sched_debug.cpu.nr_running.avg
>       25773 ±  5%     -96.1%       1007 ± 41%     -95.2%       1246 ± 53%  sched_debug.cpu.nr_switches.avg
>       48669 ± 10%     -76.5%      11448 ± 13%     -66.5%      16288 ± 70%  sched_debug.cpu.nr_switches.max
>       19006 ±  7%     -98.6%     258.81 ± 64%     -98.4%     311.75 ± 58%  sched_debug.cpu.nr_switches.min
>        4142 ±  8%     -66.3%       1396 ± 17%     -58.3%       1726 ± 51%  sched_debug.cpu.nr_switches.stddev
>        0.07 ± 23%     -92.9%       0.01 ± 41%     -94.3%       0.00 ± 46%  sched_debug.cpu.nr_uninterruptible.avg
>      240.19 ± 16%     -82.1%      42.94 ± 41%     -84.0%      38.50 ± 19%  sched_debug.cpu.nr_uninterruptible.max
>      -77.92           -88.1%      -9.25           -84.9%     -11.77        sched_debug.cpu.nr_uninterruptible.min
>       37.87 ±  5%     -85.8%       5.36 ± 13%     -85.3%       5.57 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
>      195549           -72.7%      53356 ± 24%     -68.6%      61438 ± 35%  sched_debug.cpu_clk
>      194699           -73.0%      52506 ± 25%     -68.9%      60588 ± 35%  sched_debug.ktime
>        0.00          -100.0%       0.00           -62.5%       0.00 ±264%  sched_debug.rt_rq:.rt_nr_running.avg
>        0.17          -100.0%       0.00           -62.5%       0.06 ±264%  sched_debug.rt_rq:.rt_nr_running.max
>        0.01          -100.0%       0.00           -62.5%       0.00 ±264%  sched_debug.rt_rq:.rt_nr_running.stddev
>      196368           -72.4%      54191 ± 24%     -68.3%      62327 ± 34%  sched_debug.sched_clk
>        0.17 ±142%    -100.0%       0.00           -97.8%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
>        0.19 ± 34%     -51.3%       0.09 ± 37%     -76.7%       0.04 ±110%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>        0.14 ± 55%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>        0.14 ± 73%     -82.5%       0.03 ±168%     -64.1%       0.05 ±177%  perf-sched.sch_delay.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
>        0.11 ± 59%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
>        0.04 ±132%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>        0.02 ± 31%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>        0.00 ±223%  +51950.0%       0.26 ±212%   +6325.0%       0.03 ±124%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>        0.25 ± 59%    -100.0%       0.00           -64.9%       0.09 ±253%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>        0.12 ±145%     -99.1%       0.00 ±141%     -99.5%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>        0.04 ± 55%     +99.5%       0.08 ±254%     -92.0%       0.00 ±103%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        0.25 ± 41%     -81.6%       0.05 ± 69%     -94.4%       0.01 ± 69%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
>        0.11 ± 59%     -87.1%       0.01 ±198%     -96.2%       0.00 ±128%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>        0.40 ± 50%     -97.8%       0.01 ± 30%     -97.2%       0.01 ± 45%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>        2.25 ±138%     -99.6%       0.01 ±  7%     -63.9%       0.81 ±261%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>        0.32 ±104%     -97.3%       0.01 ± 38%     -97.7%       0.01 ± 61%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>        0.12 ± 21%     -61.6%       0.04 ±233%     -85.7%       0.02 ±190%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.01 ± 12%     -34.9%       0.01 ± 18%    +722.2%       0.07 ±251%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>        0.01 ± 42%     -41.4%       0.00 ± 72%     -76.6%       0.00 ± 77%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
>        0.01 ± 20%    -100.0%       0.00           -96.4%       0.00 ±264%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
>        0.19 ±185%     -95.6%       0.01 ± 44%    +266.3%       0.70 ±261%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>        0.07 ± 20%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
>        0.26 ± 17%     -98.8%       0.00 ± 10%     -98.9%       0.00 ± 39%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>        0.03 ± 51%     -69.7%       0.01 ± 67%     -83.7%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>        0.01 ± 55%    +721.9%       0.10 ± 29%   +1608.3%       0.20 ±227%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>        0.01 ±128%     -83.6%       0.00 ± 20%     -86.2%       0.00 ± 43%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>        0.06 ± 31%   +1921.5%       1.23 ±165%  +13539.3%       8.30 ±201%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>        1.00 ±151%    -100.0%       0.00           -99.6%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
>       25.45 ± 94%     -98.6%       0.36 ± 61%     -99.4%       0.15 ±143%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>        4.56 ± 67%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>        3.55 ± 97%     -98.9%       0.04 ±189%     -98.5%       0.05 ±177%  perf-sched.sch_delay.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
>        2.13 ± 67%     -77.2%       0.49 ± 56%     -88.8%       0.24 ±147%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
>        3.16 ± 78%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
>        0.30 ±159%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>        1.61 ±100%     -76.7%       0.38 ± 72%     -91.7%       0.13 ±145%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>        0.03 ± 86%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>        0.00 ±223%  +3.2e+06%      15.79 ±259%  +44450.0%       0.22 ±132%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>        3.09 ± 45%    -100.0%       0.00           -94.6%       0.17 ±259%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>        3.51 ± 21%     -86.1%       0.49 ± 72%     -90.7%       0.33 ±127%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
>        0.83 ±160%     -99.7%       0.00 ±141%     -99.9%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>        0.09 ± 31%    +179.7%       0.25 ±258%     -91.5%       0.01 ±132%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        3.59 ± 11%     -92.0%       0.29 ±165%     -99.2%       0.03 ±118%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
>        1.60 ± 69%     -95.7%       0.07 ±243%     -99.0%       0.02 ±210%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>        0.81 ± 43%     -98.5%       0.01 ± 43%     -98.3%       0.01 ± 41%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>        1.02 ± 88%     -98.1%       0.02 ± 47%     -98.7%       0.01 ± 71%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>        9.68 ± 32%     -92.2%       0.76 ± 72%     -78.1%       2.12 ±187%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
>        0.01 ± 49%     -51.9%       0.00 ± 72%     -80.8%       0.00 ± 77%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
>       12.26 ±109%     -92.9%       0.87 ±101%     -86.9%       1.61 ±225%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>        5.60 ±139%     -97.6%       0.13 ±132%     -99.3%       0.04 ±255%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
>        0.03 ±106%    -100.0%       0.00           -99.1%       0.00 ±264%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
>        2.11 ± 61%     -85.5%       0.31 ± 85%     -96.0%       0.08 ±124%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
>       37.84 ± 47%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
>        4.68 ± 36%     -99.8%       0.01 ± 65%     -99.8%       0.01 ± 77%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>        7.56 ± 74%     -51.5%       3.67 ±147%     -99.8%       0.02 ± 54%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>        0.36 ±186%     -96.3%       0.01 ± 90%     -97.9%       0.01 ± 59%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>       97903 ±  4%     -38.3%      60433 ± 29%     -71.4%      27976 ±109%  perf-sched.total_wait_and_delay.count.ms
>        3.97 ±  6%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>      302.41 ±  5%     -27.4%     219.54 ± 14%     -10.8%     269.81 ± 60%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>        1.48 ±  6%     -90.9%       0.14 ± 79%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
>      327.16 ±  9%     -46.6%     174.81 ± 24%     -38.4%     201.64 ± 71%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
>      369.37 ±  2%     -75.3%      91.05 ± 35%     -77.7%      82.29 ±119%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>        0.96 ±  6%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
>      187.66          +120.6%     413.97 ± 14%    +116.9%     407.06 ± 43%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        1831 ±  9%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>        6.17 ± 45%     -79.7%       1.25 ±142%     -91.9%       0.50 ±264%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       14.33 ±  5%     +13.4%      16.25 ± 23%     -58.1%       6.00 ± 66%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>      810.00 ± 10%     -38.0%     502.25 ± 92%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
>       40.50 ±  8%    +245.7%     140.00 ± 23%     +72.5%      69.88 ± 91%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
>       13.17 ±  2%    +624.4%      95.38 ± 19%    +347.2%      58.88 ± 78%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       73021 ±  3%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
>       11323 ±  3%     -75.9%       2725 ± 28%     -86.4%       1536 ± 34%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        1887 ± 45%     -96.1%      73.88 ± 78%     -98.5%      28.75 ±120%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>        1238           -34.5%     811.25 ± 13%     -58.6%     512.62 ± 49%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       35.19 ± 57%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>       20.79 ± 19%     -95.9%       0.84 ± 93%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
>        1240 ± 20%     -14.4%       1062 ± 10%     -25.2%     928.21 ± 40%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
>      500.34           +31.2%     656.38 ± 39%     -15.0%     425.46 ± 61%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       58.83 ± 39%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
>        1237 ± 34%    +151.7%       3114 ± 25%     +51.6%       1876 ± 64%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       49.27 ±119%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
>       58.17 ±187%    -100.0%       0.00          -100.0%       0.00 ±264%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
>        3.78 ±  5%     -97.6%       0.09 ± 37%     -98.8%       0.04 ±111%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>        2.99 ±  4%     +15.4%       3.45 ± 10%     +28.8%       3.85 ± 54%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>        3.92 ±  5%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>        4.71 ±  8%     -99.5%       0.02 ±170%     -98.9%       0.05 ±177%  perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
>        1.67 ± 20%     -92.7%       0.12 ± 30%     -96.8%       0.05 ±130%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
>        2.10 ± 27%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
>        0.01 ± 44%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>        1.67 ± 21%     -94.3%       0.10 ± 35%     -97.0%       0.05 ±137%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>        0.04 ±133%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>       67.14 ± 73%     +75.6%     117.89 ±108%     -92.8%       4.82 ±259%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>        1.65 ± 67%     -95.8%       0.07 ±128%     -99.2%       0.01 ±175%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
>        2.30 ± 14%     -95.5%       0.10 ± 42%     -96.4%       0.08 ±108%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
>        2.00 ± 74%   +2917.4%      60.44 ± 33%   +1369.3%      29.43 ± 74%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       29.19 ±  5%     -38.5%      17.96 ± 28%     -49.0%      14.89 ± 54%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
>        0.37 ± 30%   +5524.5%      20.95 ± 30%   +2028.0%       7.93 ±117%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      302.40 ±  5%     -27.4%     219.53 ± 14%     -10.8%     269.75 ± 60%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>        1.40 ±  6%     -92.7%       0.10 ± 18%     -95.4%       0.06 ±109%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
>        0.72 ±220%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
>      326.84 ±  9%     -46.6%     174.54 ± 24%     -38.6%     200.64 ± 72%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
>      369.18 ±  2%     -75.3%      91.04 ± 35%     -74.2%      95.16 ± 98%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>        0.89 ±  6%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
>      187.58          +120.6%     413.77 ± 14%    +116.9%     406.79 ± 43%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        2.36 ± 29%   +1759.6%      43.80 ± 33%   +3763.5%      90.99 ±115%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>        0.01 ±156%     -97.9%       0.00 ±264%     -98.9%       0.00 ±264%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>      750.01           -14.5%     641.50 ± 14%     -41.1%     442.13 ± 58%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>      340.69 ±135%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
>      535.09 ±128%    -100.0%       0.00          -100.0%       0.00 ±264%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
>       22.04 ± 32%     -98.4%       0.36 ± 61%     -99.3%       0.15 ±143%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>       13.57 ± 17%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>       13.54 ± 10%     -99.7%       0.04 ±189%     -99.6%       0.05 ±177%  perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
>       10.17 ± 19%     -95.2%       0.49 ± 56%     -97.7%       0.24 ±147%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
>       11.35 ± 25%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
>        0.01 ± 32%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>       10.62 ±  9%     -96.5%       0.38 ± 72%     -98.7%       0.13 ±145%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>        0.20 ±199%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>        1559 ± 64%     -92.3%     120.30 ±109%     -99.4%       9.63 ±259%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>        6.93 ± 53%     -98.1%       0.13 ± 99%     -99.8%       0.01 ±175%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
>       14.42 ± 22%     -96.6%       0.49 ± 72%     -97.7%       0.33 ±127%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
>        4.00 ± 74%  +19182.5%     772.23 ± 40%   +7266.0%     295.00 ± 92%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       10.75 ± 98%   +6512.2%     710.88 ± 56%   +2526.4%     282.37 ±130%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       15.80 ±  8%     -95.2%       0.76 ± 72%     -86.6%       2.12 ±187%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
>       11.64 ± 61%     -98.9%       0.13 ±132%     -99.7%       0.04 ±255%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
>        2.94 ±213%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
>      175.70 ±210%     -64.6%      62.26 ±263%     -99.8%       0.31 ±116%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
>        1240 ± 20%     -14.3%       1062 ± 10%     -25.2%     928.20 ± 40%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
>      500.11           +31.2%     656.37 ± 39%      -2.4%     487.96 ± 41%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       32.65 ± 33%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
>        1237 ± 34%    +151.6%       3113 ± 25%     +49.0%       1844 ± 63%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        0.36 ±190%     -97.2%       0.01 ±127%     -98.5%       0.01 ± 88%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>       95.59           -95.6        0.00           -95.6        0.00        perf-profile.calltrace.cycles-pp.__mmap
>       95.54           -95.5        0.00           -95.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       95.54           -95.5        0.00           -95.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>       94.54           -94.5        0.00           -94.5        0.00        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       94.46           -94.0        0.41 ±138%     -93.9        0.57 ±103%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       94.14           -93.7        0.40 ±136%     -93.6        0.50 ± 79%  perf-profile.calltrace.cycles-pp.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
>       93.79           -93.5        0.31 ±134%     -93.2        0.58 ±111%  perf-profile.calltrace.cycles-pp.vma_link_file.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff
>       93.40           -93.4        0.00           -93.4        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_link_file.__mmap_new_vma.__mmap_region
>       93.33           -93.3        0.00           -93.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_link_file.__mmap_new_vma
>       93.44           -93.3        0.14 ±264%     -93.4        0.00        perf-profile.calltrace.cycles-pp.down_write.vma_link_file.__mmap_new_vma.__mmap_region.do_mmap
>       94.45           -93.0        1.42 ± 60%     -92.9        1.51 ± 51%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       94.25           -92.9        1.33 ± 61%     -92.8        1.43 ± 57%  perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>       92.89           -92.9        0.00           -92.9        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_link_file
>        0.00            +0.3        0.29 ±129%      +1.1        1.10 ± 27%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>        0.00            +0.3        0.32 ±129%      +1.7        1.70 ± 39%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>        0.00            +0.3        0.32 ±129%      +1.7        1.74 ± 40%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
>        0.00            +0.5        0.49 ± 78%      +1.7        1.74 ± 40%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>        0.00            +1.1        1.09 ± 33%      +0.4        0.44 ±177%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
>        0.00            +1.3        1.32 ± 54%      +1.4        1.36 ± 33%  perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.do_exit.do_group_exit.get_signal
>        0.00            +1.3        1.32 ± 54%      +1.4        1.36 ± 33%  perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>        0.00            +1.4        1.37 ± 49%      +1.8        1.77 ± 50%  perf-profile.calltrace.cycles-pp.setlocale
>        0.00            +1.4        1.39 ± 70%      +1.8        1.80 ± 48%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +1.4        1.39 ± 70%      +1.8        1.80 ± 48%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
>        0.00            +1.5        1.55 ± 63%      +1.6        1.62 ± 37%  perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>        0.00            +1.6        1.60 ± 57%      +1.6        1.63 ± 87%  perf-profile.calltrace.cycles-pp.swevent_hlist_put_cpu.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
>        0.00            +1.6        1.64 ± 47%      +0.9        0.90 ±101%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
>        0.00            +1.6        1.64 ± 47%      +1.0        1.02 ± 83%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry
>        0.00            +1.6        1.65 ± 43%      +1.1        1.15 ± 76%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +1.8        1.76 ± 44%      +1.1        1.15 ± 76%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +1.9        1.93 ± 26%      +1.1        1.11 ±127%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
>        0.00            +2.0        2.04 ± 66%      +3.6        3.65 ± 42%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>        0.00            +2.1        2.12 ± 58%      +3.6        3.65 ± 42%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>        0.00            +2.1        2.12 ± 58%      +3.6        3.65 ± 42%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>        0.00            +2.1        2.12 ± 58%      +3.7        3.71 ± 40%  perf-profile.calltrace.cycles-pp.open64
>        0.00            +2.2        2.16 ± 44%      +1.6        1.62 ± 37%  perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>        0.00            +2.2        2.20 ± 74%      +3.6        3.65 ± 42%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>        0.00            +2.2        2.23 ± 33%      +1.4        1.40 ± 99%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +2.3        2.34 ±103%      +5.1        5.09 ± 64%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.perf_c2c__record.run_builtin.handle_internal_command
>        0.00            +2.3        2.34 ±103%      +5.1        5.09 ± 64%  perf-profile.calltrace.cycles-pp.cmd_record.perf_c2c__record.run_builtin.handle_internal_command.main
>        0.00            +2.3        2.34 ±103%      +5.1        5.09 ± 64%  perf-profile.calltrace.cycles-pp.perf_c2c__record.run_builtin.handle_internal_command.main
>        0.00            +2.4        2.37 ± 36%      +1.9        1.93 ± 35%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>        0.00            +2.5        2.48 ± 32%      +2.4        2.45 ± 60%  perf-profile.calltrace.cycles-pp.get_cpu_sleep_time_us.get_idle_time.uptime_proc_show.seq_read_iter.vfs_read
>        0.00            +2.5        2.50 ± 45%      +1.2        1.21 ± 73%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>        0.00            +2.5        2.54 ± 47%      +1.3        1.28 ± 61%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
>        0.00            +2.5        2.54 ± 47%      +1.3        1.28 ± 61%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
>        0.00            +2.6        2.62 ± 35%      +1.6        1.57 ± 91%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
>        0.00            +2.6        2.62 ± 35%      +1.6        1.57 ± 91%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
>        0.00            +2.6        2.62 ± 35%      +1.6        1.57 ± 91%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
>        0.00            +2.6        2.62 ± 35%      +1.6        1.57 ± 91%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
>        0.00            +2.7        2.67 ± 54%      +2.6        2.59 ± 40%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
>        0.00            +2.7        2.68 ± 35%      +3.0        3.02 ± 45%  perf-profile.calltrace.cycles-pp.get_idle_time.uptime_proc_show.seq_read_iter.vfs_read.ksys_read
>        0.00            +2.8        2.77 ± 33%      +4.2        4.17 ± 35%  perf-profile.calltrace.cycles-pp.uptime_proc_show.seq_read_iter.vfs_read.ksys_read.do_syscall_64
>        0.00            +2.8        2.82 ± 32%      +1.8        1.83 ± 85%  perf-profile.calltrace.cycles-pp._Fork
>        0.00            +2.8        2.83 ± 48%      +2.6        2.59 ± 40%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
>        0.00            +2.8        2.83 ± 48%      +2.7        2.68 ± 42%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
>        0.00            +2.8        2.84 ± 45%      +1.2        1.21 ± 73%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>        0.00            +2.8        2.84 ± 45%      +1.2        1.21 ± 73%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>        0.00            +2.9        2.89 ± 39%      +3.1        3.14 ± 39%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
>        0.00            +2.9        2.89 ± 39%      +3.1        3.14 ± 39%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
>        0.00            +3.1        3.10 ± 64%      +0.9        0.91 ±264%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.1        3.10 ± 64%      +0.9        0.91 ±264%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
>        0.00            +3.1        3.13 ± 33%      +1.7        1.68 ± 77%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>        0.00            +3.2        3.18 ± 37%      +4.3        4.31 ± 34%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.2        3.20 ± 28%      +3.0        3.02 ± 73%  perf-profile.calltrace.cycles-pp.mutex_unlock.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
>        0.00            +3.2        3.24 ± 39%      +2.8        2.85 ± 49%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.2        3.24 ± 36%      +2.0        2.00 ± 56%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.2        3.24 ± 36%      +2.0        2.00 ± 56%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
>        0.00            +3.2        3.24 ± 36%      +2.0        2.00 ± 56%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.2        3.24 ± 36%      +2.0        2.00 ± 56%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.8        3.85 ± 39%      +3.3        3.25 ± 47%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>        0.00            +3.8        3.85 ± 39%      +3.3        3.25 ± 47%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>        0.00            +3.8        3.85 ± 39%      +3.3        3.25 ± 47%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>        0.00            +3.8        3.85 ± 39%      +3.3        3.25 ± 47%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
>        0.00            +3.8        3.85 ± 39%      +3.3        3.29 ± 47%  perf-profile.calltrace.cycles-pp.execve
>        0.00            +4.0        4.04 ± 43%      +5.2        5.21 ± 49%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +4.0        4.04 ± 43%      +5.2        5.21 ± 49%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
>        0.00            +4.1        4.10 ± 30%      +2.6        2.56 ± 28%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
>        0.00            +4.2        4.18 ± 31%      +2.8        2.82 ± 21%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
>        0.00            +4.2        4.18 ± 31%      +2.8        2.82 ± 21%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>        0.00            +4.2        4.20 ± 28%      +2.7        2.68 ± 34%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
>        0.00            +4.2        4.25 ± 65%      +8.0        7.98 ± 43%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
>        0.00            +4.3        4.27 ± 26%      +3.2        3.23 ± 34%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>        0.00            +4.3        4.30 ± 22%      +3.9        3.95 ± 32%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
>        0.00            +4.3        4.30 ± 22%      +3.9        3.95 ± 32%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>        0.00            +4.5        4.46 ± 59%      +8.1        8.07 ± 42%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +4.6        4.57 ± 58%      +8.1        8.07 ± 42%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
>        0.00            +4.7        4.68 ± 55%      +8.1        8.12 ± 43%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
>        0.00            +4.7        4.68 ± 55%      +8.1        8.12 ± 43%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
>        0.00            +4.7        4.68 ± 55%      +8.2        8.16 ± 44%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
>        0.00            +4.7        4.68 ± 55%      +8.4        8.39 ± 39%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>        0.00            +4.7        4.68 ± 55%      +8.6        8.61 ± 38%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>        0.00            +4.9        4.90 ± 57%     +10.3       10.28 ± 65%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>        0.00            +4.9        4.92 ± 26%      +4.6        4.56 ± 47%  perf-profile.calltrace.cycles-pp.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
>        0.00            +5.0        4.99 ±100%      +2.6        2.64 ±101%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
>        0.00            +5.0        4.99 ±100%      +2.6        2.64 ±101%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>        0.00            +5.1        5.08 ±102%      +2.6        2.64 ±101%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>        0.00            +5.1        5.14 ± 28%      +6.0        6.01 ± 41%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
>        0.00            +5.1        5.14 ± 28%      +6.2        6.16 ± 39%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.handle_internal_command
>        0.00            +5.4        5.43 ± 25%      +5.0        4.97 ± 45%  perf-profile.calltrace.cycles-pp._free_event.perf_event_release_kernel.perf_release.__fput.task_work_run
>        0.00            +5.8        5.82 ± 94%      +4.2        4.21 ± 49%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
>        0.00            +5.8        5.82 ± 94%      +4.3        4.35 ± 53%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry
>        0.00            +6.1        6.07 ± 90%      +4.3        4.32 ± 58%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>        0.00            +6.6        6.62 ± 24%      +7.0        6.99 ± 41%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.handle_internal_command.main
>        0.00            +6.6        6.62 ± 24%      +7.0        6.99 ± 41%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.handle_internal_command.main
>        0.00            +6.8        6.76 ± 18%      +5.2        5.23 ± 25%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
>        0.00            +7.6        7.56 ± 76%      +6.0        5.99 ± 38%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
>        0.00            +8.0        8.03 ± 27%      +7.4        7.37 ± 52%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.00            +8.0        8.03 ± 27%      +7.4        7.37 ± 52%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.00            +8.0        8.05 ± 68%      +6.3        6.27 ± 37%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
>        0.00            +8.1        8.13 ± 28%      +7.4        7.37 ± 52%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.00            +8.1        8.13 ± 28%      +7.4        7.37 ± 52%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>        0.00            +8.1        8.13 ± 28%      +7.4        7.37 ± 52%  perf-profile.calltrace.cycles-pp.read
>        0.00            +9.1        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.calltrace.cycles-pp.handle_internal_command.main
>        0.00            +9.1        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.calltrace.cycles-pp.main
>        0.00            +9.1        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.calltrace.cycles-pp.run_builtin.handle_internal_command.main
>        0.00            +9.3        9.26 ± 30%      +9.0        8.96 ± 31%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
>        0.00            +9.3        9.26 ± 30%      +9.0        8.96 ± 31%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
>        0.00           +10.1       10.14 ± 28%     +10.0       10.04 ± 34%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
>        0.00           +10.2       10.23 ± 27%     +10.7       10.65 ± 35%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>        0.00           +11.0       10.98 ± 55%     +13.0       13.00 ± 27%  perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
>        0.00           +20.6       20.64 ± 30%     +19.5       19.49 ± 43%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00           +20.6       20.64 ± 30%     +19.5       19.49 ± 43%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>        1.21 ±  3%     +36.6       37.80 ± 12%     +34.1       35.32 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>        1.21 ±  3%     +36.6       37.80 ± 12%     +34.4       35.62 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>        1.22 ±  3%     +36.8       38.00 ± 13%     +34.8       36.05 ± 11%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>        1.22 ±  3%     +36.9       38.10 ± 13%     +34.8       36.05 ± 11%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
>        1.22 ±  3%     +36.9       38.10 ± 13%     +34.8       36.05 ± 11%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
>        1.21 ±  3%     +37.2       38.43 ± 11%     +34.2       35.40 ±  8%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>        1.21 ±  3%     +37.2       38.43 ± 11%     +34.2       35.40 ±  8%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>        1.21 ±  3%     +37.3       38.54 ± 12%     +34.7       35.87 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>        1.22 ±  3%     +37.6       38.84 ± 12%     +35.4       36.60 ± 11%  perf-profile.calltrace.cycles-pp.common_startup_64
>        2.19 ±  3%     +53.9       56.10 ± 19%     +48.4       50.63 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
>       95.60           -95.2        0.41 ±138%     -94.9        0.72 ± 95%  perf-profile.children.cycles-pp.__mmap
>       94.14           -93.7        0.49 ±130%     -92.9        1.21 ± 33%  perf-profile.children.cycles-pp.__mmap_new_vma
>       93.79           -93.5        0.31 ±134%     -93.1        0.71 ± 78%  perf-profile.children.cycles-pp.vma_link_file
>       93.40           -93.4        0.00           -93.4        0.00        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>       93.33           -93.3        0.00           -93.3        0.00        perf-profile.children.cycles-pp.rwsem_optimistic_spin
>       94.55           -93.1        1.42 ± 60%     -93.0        1.55 ± 50%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
>       92.91           -92.9        0.00           -92.9        0.00        perf-profile.children.cycles-pp.osq_lock
>       93.44           -92.7        0.75 ±109%     -93.4        0.06 ±264%  perf-profile.children.cycles-pp.down_write
>       94.46           -92.6        1.84 ± 34%     -92.0        2.48 ± 28%  perf-profile.children.cycles-pp.vm_mmap_pgoff
>       94.45           -92.6        1.84 ± 34%     -92.0        2.48 ± 28%  perf-profile.children.cycles-pp.do_mmap
>       94.25           -92.6        1.66 ± 37%     -91.9        2.40 ± 30%  perf-profile.children.cycles-pp.__mmap_region
>       95.58           -44.8       50.78 ± 11%     -42.8       52.76 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       95.58           -44.8       50.78 ± 11%     -42.8       52.76 ± 11%  perf-profile.children.cycles-pp.do_syscall_64
>        0.00            +0.1        0.09 ±264%      +1.0        0.96 ± 46%  perf-profile.children.cycles-pp.kcpustat_cpu_fetch
>        0.25 ±  3%      +0.2        0.45 ±133%      +0.7        0.92 ± 41%  perf-profile.children.cycles-pp.vma_interval_tree_insert
>        0.00            +0.3        0.29 ±129%      +1.2        1.16 ± 26%  perf-profile.children.cycles-pp.do_open
>        0.00            +0.3        0.32 ±129%      +1.8        1.79 ± 43%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
>        0.00            +0.3        0.32 ±129%      +1.8        1.83 ± 44%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
>        0.00            +0.5        0.49 ± 78%      +1.8        1.83 ± 44%  perf-profile.children.cycles-pp.shmem_write_begin
>        0.00            +1.1        1.09 ± 33%      +0.5        0.48 ±160%  perf-profile.children.cycles-pp.dup_mmap
>        0.00            +1.1        1.11 ±106%      +1.6        1.60 ± 54%  perf-profile.children.cycles-pp.__open64_nocancel
>        0.00            +1.1        1.15 ±102%      +1.2        1.16 ± 86%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
>        0.00            +1.3        1.32 ± 54%      +1.4        1.36 ± 33%  perf-profile.children.cycles-pp.filp_close
>        0.00            +1.3        1.32 ± 54%      +1.5        1.47 ± 29%  perf-profile.children.cycles-pp.put_files_struct
>        0.00            +1.4        1.37 ± 49%      +1.8        1.77 ± 50%  perf-profile.children.cycles-pp.setlocale
>        0.00            +1.4        1.39 ± 70%      +1.8        1.80 ± 48%  perf-profile.children.cycles-pp.seq_read
>        0.00            +1.5        1.55 ± 63%      +1.7        1.75 ± 30%  perf-profile.children.cycles-pp.do_read_fault
>        0.00            +1.7        1.66 ± 76%      +0.9        0.91 ± 44%  perf-profile.children.cycles-pp.event_function
>        0.00            +1.7        1.66 ± 76%      +0.9        0.91 ± 44%  perf-profile.children.cycles-pp.remote_function
>        0.00            +1.7        1.70 ± 71%      +1.5        1.53 ± 73%  perf-profile.children.cycles-pp.lookup_fast
>        0.00            +1.7        1.73 ± 53%      +1.4        1.40 ± 77%  perf-profile.children.cycles-pp.swevent_hlist_put_cpu
>        0.04 ± 44%      +1.8        1.83 ± 96%      +2.4        2.47 ± 44%  perf-profile.children.cycles-pp.__schedule
>        0.00            +1.9        1.93 ± 26%      +1.1        1.15 ±120%  perf-profile.children.cycles-pp.dup_mm
>        0.03 ± 70%      +2.0        1.99 ± 36%      +1.2        1.23 ± 81%  perf-profile.children.cycles-pp.handle_softirqs
>        0.00            +2.0        1.99 ± 36%      +1.1        1.13 ± 67%  perf-profile.children.cycles-pp.__irq_exit_rcu
>        0.00            +2.0        2.02 ± 38%      +1.3        1.33 ± 57%  perf-profile.children.cycles-pp.folios_put_refs
>        0.00            +2.1        2.06 ± 52%      +1.4        1.38 ± 77%  perf-profile.children.cycles-pp._raw_spin_lock
>        0.00            +2.1        2.12 ± 58%      +3.7        3.71 ± 40%  perf-profile.children.cycles-pp.open64
>        0.00            +2.2        2.16 ± 44%      +1.7        1.75 ± 30%  perf-profile.children.cycles-pp.do_pte_missing
>        0.00            +2.2        2.21 ± 68%      +2.2        2.18 ± 58%  perf-profile.children.cycles-pp.link_path_walk
>        0.00            +2.2        2.23 ± 33%      +1.4        1.40 ± 99%  perf-profile.children.cycles-pp.copy_process
>        0.00            +2.3        2.30 ± 40%      +1.8        1.78 ± 48%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
>        0.00            +2.3        2.30 ± 40%      +1.8        1.78 ± 48%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
>        0.00            +2.3        2.34 ±103%      +5.1        5.09 ± 64%  perf-profile.children.cycles-pp.perf_c2c__record
>        0.00            +2.3        2.34 ± 46%      +1.5        1.52 ± 99%  perf-profile.children.cycles-pp.walk_component
>        0.00            +2.4        2.37 ± 36%      +2.0        2.04 ± 32%  perf-profile.children.cycles-pp.zap_present_ptes
>        0.00            +2.5        2.48 ± 32%      +2.5        2.51 ± 55%  perf-profile.children.cycles-pp.get_cpu_sleep_time_us
>        0.00            +2.5        2.50 ± 73%      +1.6        1.56 ± 76%  perf-profile.children.cycles-pp.__evlist__enable
>        0.00            +2.6        2.62 ± 35%      +1.6        1.57 ± 91%  perf-profile.children.cycles-pp.__do_sys_clone
>        0.00            +2.6        2.62 ± 35%      +1.6        1.57 ± 91%  perf-profile.children.cycles-pp.kernel_clone
>        0.00            +2.7        2.67 ± 54%      +2.6        2.59 ± 40%  perf-profile.children.cycles-pp.load_elf_binary
>        0.00            +2.7        2.68 ± 35%      +3.0        3.02 ± 45%  perf-profile.children.cycles-pp.get_idle_time
>        0.00            +2.8        2.77 ± 33%      +4.2        4.17 ± 35%  perf-profile.children.cycles-pp.uptime_proc_show
>        0.00            +2.8        2.83 ± 48%      +2.6        2.59 ± 40%  perf-profile.children.cycles-pp.search_binary_handler
>        0.00            +2.8        2.83 ± 48%      +2.7        2.68 ± 42%  perf-profile.children.cycles-pp.exec_binprm
>        0.00            +2.9        2.91 ± 32%      +1.8        1.83 ± 85%  perf-profile.children.cycles-pp._Fork
>        0.00            +3.1        3.10 ± 64%      +0.9        0.95 ±252%  perf-profile.children.cycles-pp.proc_reg_read_iter
>        0.00            +3.2        3.24 ± 39%      +2.8        2.85 ± 49%  perf-profile.children.cycles-pp.bprm_execve
>        0.00            +3.2        3.24 ± 36%      +2.0        2.00 ± 56%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>        0.00            +3.2        3.24 ± 36%      +2.1        2.09 ± 53%  perf-profile.children.cycles-pp.x64_sys_call
>        0.00            +3.8        3.85 ± 39%      +3.3        3.29 ± 47%  perf-profile.children.cycles-pp.execve
>        0.00            +3.8        3.85 ± 39%      +3.3        3.34 ± 49%  perf-profile.children.cycles-pp.__x64_sys_execve
>        0.00            +3.8        3.85 ± 39%      +3.3        3.34 ± 49%  perf-profile.children.cycles-pp.do_execveat_common
>        0.00            +4.0        3.99 ± 38%      +4.1        4.06 ± 54%  perf-profile.children.cycles-pp.mutex_unlock
>        0.00            +4.2        4.19 ± 31%      +3.0        3.02 ± 20%  perf-profile.children.cycles-pp.zap_pte_range
>        0.00            +4.2        4.25 ± 65%      +8.0        7.98 ± 43%  perf-profile.children.cycles-pp.generic_perform_write
>        0.00            +4.3        4.29 ± 29%      +3.0        3.02 ± 20%  perf-profile.children.cycles-pp.unmap_page_range
>        0.00            +4.3        4.29 ± 29%      +3.0        3.02 ± 20%  perf-profile.children.cycles-pp.zap_pmd_range
>        0.00            +4.3        4.31 ± 51%      +5.3        5.31 ± 46%  perf-profile.children.cycles-pp.do_filp_open
>        0.00            +4.3        4.31 ± 51%      +5.3        5.31 ± 46%  perf-profile.children.cycles-pp.path_openat
>        0.19 ± 23%      +4.4        4.60 ± 26%      +3.4        3.54 ± 27%  perf-profile.children.cycles-pp.__handle_mm_fault
>        0.00            +4.5        4.46 ± 59%      +8.1        8.07 ± 42%  perf-profile.children.cycles-pp.shmem_file_write_iter
>        0.00            +4.5        4.55 ± 24%      +4.0        3.97 ± 39%  perf-profile.children.cycles-pp.smp_call_function_single
>        0.00            +4.5        4.55 ± 24%      +4.1        4.06 ± 38%  perf-profile.children.cycles-pp.event_function_call
>        0.00            +4.6        4.58 ± 30%      +3.2        3.19 ± 24%  perf-profile.children.cycles-pp.unmap_vmas
>        0.51 ±  6%      +4.6        5.14 ± 24%      +3.6        4.06 ± 30%  perf-profile.children.cycles-pp.handle_mm_fault
>        0.00            +4.7        4.68 ± 55%      +8.4        8.41 ± 39%  perf-profile.children.cycles-pp.writen
>        0.00            +4.7        4.68 ± 55%      +8.5        8.49 ± 39%  perf-profile.children.cycles-pp.record__pushfn
>        0.00            +4.8        4.80 ± 48%      +6.1        6.15 ± 34%  perf-profile.children.cycles-pp.do_sys_openat2
>        0.77 ±  3%      +4.8        5.59 ± 21%      +4.3        5.07 ± 29%  perf-profile.children.cycles-pp.exc_page_fault
>        0.76 ±  3%      +4.8        5.59 ± 21%      +4.3        5.07 ± 29%  perf-profile.children.cycles-pp.do_user_addr_fault
>        0.00            +4.9        4.90 ± 57%     +10.3       10.28 ± 65%  perf-profile.children.cycles-pp.vfs_write
>        0.00            +4.9        4.90 ± 57%     +10.4       10.41 ± 63%  perf-profile.children.cycles-pp.ksys_write
>        0.00            +4.9        4.90 ± 48%      +6.1        6.15 ± 34%  perf-profile.children.cycles-pp.__x64_sys_openat
>        0.00            +4.9        4.92 ± 26%      +4.7        4.66 ± 47%  perf-profile.children.cycles-pp.sw_perf_event_destroy
>        0.00            +5.0        4.99 ±100%      +2.6        2.64 ±101%  perf-profile.children.cycles-pp.perf_rotate_context
>        0.00            +5.0        5.01 ± 54%     +10.9       10.87 ± 59%  perf-profile.children.cycles-pp.write
>        0.00            +5.1        5.09 ±102%      +2.7        2.74 ± 94%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>        0.00            +5.4        5.43 ± 25%      +5.0        4.97 ± 45%  perf-profile.children.cycles-pp._free_event
>        1.18            +5.6        6.78 ± 20%      +5.5        6.71 ± 24%  perf-profile.children.cycles-pp.asm_exc_page_fault
>        0.46            +5.6        6.07 ± 90%      +4.1        4.54 ± 53%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>        0.00            +5.7        5.75 ± 39%     +10.2       10.22 ± 24%  perf-profile.children.cycles-pp.perf_mmap__push
>        0.00            +5.7        5.75 ± 39%     +10.4       10.38 ± 23%  perf-profile.children.cycles-pp.record__mmap_read_evlist
>        0.53            +5.8        6.28 ± 89%      +4.4        4.91 ± 50%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>        0.53            +5.8        6.28 ± 89%      +4.4        4.91 ± 50%  perf-profile.children.cycles-pp.hrtimer_interrupt
>        0.00            +6.6        6.65 ± 77%      +3.3        3.32 ± 91%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>        0.00            +6.8        6.85 ± 20%      +5.2        5.23 ± 25%  perf-profile.children.cycles-pp.exit_mm
>        0.58 ±  2%      +7.6        8.14 ± 75%      +6.0        6.55 ± 38%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>        0.00            +7.7        7.67 ± 23%      +6.1        6.14 ± 15%  perf-profile.children.cycles-pp.exit_mmap
>        0.00            +7.7        7.67 ± 30%      +7.0        7.05 ± 50%  perf-profile.children.cycles-pp.seq_read_iter
>        0.00            +7.7        7.72 ± 80%      +8.2        8.15 ± 51%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
>        0.00            +7.8        7.75 ± 23%      +6.1        6.14 ± 15%  perf-profile.children.cycles-pp.__mmput
>        0.00            +8.0        8.03 ± 27%      +7.4        7.37 ± 52%  perf-profile.children.cycles-pp.ksys_read
>        0.00            +8.0        8.03 ± 27%      +7.4        7.37 ± 52%  perf-profile.children.cycles-pp.vfs_read
>        0.00            +8.1        8.13 ± 28%      +7.4        7.37 ± 52%  perf-profile.children.cycles-pp.read
>        0.02 ±141%      +9.0        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.children.cycles-pp.__cmd_record
>        0.02 ±141%      +9.0        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.children.cycles-pp.cmd_record
>        0.02 ±141%      +9.0        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.children.cycles-pp.handle_internal_command
>        0.02 ±141%      +9.0        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.children.cycles-pp.main
>        0.02 ±141%      +9.0        9.05 ± 35%     +13.9       13.88 ± 19%  perf-profile.children.cycles-pp.run_builtin
>        0.00            +9.3        9.26 ± 30%      +9.0        8.96 ± 31%  perf-profile.children.cycles-pp.perf_event_release_kernel
>        0.00            +9.3        9.26 ± 30%      +9.0        8.96 ± 31%  perf-profile.children.cycles-pp.perf_release
>        1.02 ±  4%      +9.3       10.33 ± 27%      +9.8       10.80 ± 35%  perf-profile.children.cycles-pp.task_work_run
>        0.00           +11.0       11.05 ± 28%     +10.4       10.37 ± 32%  perf-profile.children.cycles-pp.__fput
>        0.00           +15.8       15.85 ± 25%     +16.1       16.11 ± 29%  perf-profile.children.cycles-pp.get_signal
>        0.00           +15.8       15.85 ± 25%     +16.2       16.17 ± 29%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>        0.00           +19.1       19.09 ± 19%     +18.1       18.06 ± 29%  perf-profile.children.cycles-pp.do_exit
>        0.00           +19.1       19.09 ± 19%     +18.1       18.06 ± 29%  perf-profile.children.cycles-pp.do_group_exit
>        1.70 ±  2%     +30.7       32.41 ± 21%     +27.2       28.87 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>        1.22 ±  3%     +36.9       38.10 ± 13%     +34.8       36.05 ± 11%  perf-profile.children.cycles-pp.start_secondary
>        1.21 ±  3%     +37.2       38.43 ± 11%     +34.2       35.40 ±  8%  perf-profile.children.cycles-pp.acpi_idle_do_entry
>        1.21 ±  3%     +37.2       38.43 ± 11%     +34.2       35.40 ±  8%  perf-profile.children.cycles-pp.acpi_idle_enter
>        1.21 ±  3%     +37.2       38.43 ± 11%     +34.2       35.40 ±  8%  perf-profile.children.cycles-pp.acpi_safe_halt
>        1.22 ±  3%     +37.3       38.54 ± 12%     +35.0       36.18 ± 10%  perf-profile.children.cycles-pp.cpuidle_idle_call
>        1.21 ±  3%     +37.3       38.54 ± 12%     +34.7       35.87 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter
>        1.21 ±  3%     +37.3       38.54 ± 12%     +34.7       35.87 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter_state
>        1.22 ±  3%     +37.6       38.84 ± 12%     +35.4       36.60 ± 11%  perf-profile.children.cycles-pp.common_startup_64
>        1.22 ±  3%     +37.6       38.84 ± 12%     +35.4       36.60 ± 11%  perf-profile.children.cycles-pp.cpu_startup_entry
>        1.22 ±  3%     +37.6       38.84 ± 12%     +35.4       36.60 ± 11%  perf-profile.children.cycles-pp.do_idle
>       92.37           -92.4        0.00           -92.4        0.00        perf-profile.self.cycles-pp.osq_lock
>        0.00            +0.1        0.09 ±264%      +0.8        0.84 ± 51%  perf-profile.self.cycles-pp.kcpustat_cpu_fetch
>        0.00            +2.1        2.06 ± 52%      +1.4        1.38 ± 77%  perf-profile.self.cycles-pp._raw_spin_lock
>        0.00            +2.6        2.61 ± 36%      +2.8        2.75 ± 48%  perf-profile.self.cycles-pp.smp_call_function_single
>        0.00            +3.7        3.68 ± 37%      +3.7        3.70 ± 64%  perf-profile.self.cycles-pp.mutex_unlock
>        0.00            +6.6        6.65 ± 77%      +3.3        3.32 ± 91%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
>        1.19 ±  3%     +29.2       30.38 ± 15%     +27.9       29.13 ± 13%  perf-profile.self.cycles-pp.acpi_safe_halt
>
>


