Return-Path: <linux-kernel+bounces-184054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629D8CA1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399891C2151E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD3136E3C;
	Mon, 20 May 2024 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K18ukLBQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="trnL5Bpl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072511184
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228972; cv=fail; b=K7q96z4NlpwSuy268LVmDGUI7Dpe778xn4DkFVkt4KK+7bV52u0MpCeOgUp/0j3bKRV17kcAs4dBW8YXNvhVKESO0h7Sib8vbXzDkJ+MEocWELD/vawWFVvzoT+XOJJhcVaWWK799Y5bF/cE8GeJPHqZ9+Y33qLQlymPESe/VCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228972; c=relaxed/simple;
	bh=rQTOzBZxFvWqMLPxnvwKqmjLqnJgZifPYqJLN/jtNi4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lPHQAbApymZ/zFiBD98FGBQf/UF8PyCuum/Ap7qVxYf+nOoVLK3IIh5sT/vcIOPCNfaNW5Gp2f1G6HPhmDkf6RN+9vM8pMhs1kr9n6ZyEIj2kDrgI6137dmvN6xtpIk9lJEFK6QPjwGTiW6hMgTlSHtSmrFqQ3jn2mU6r9l7gvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K18ukLBQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=trnL5Bpl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KH4bPx013169;
	Mon, 20 May 2024 18:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bPjX9IjJudyJmUBwZ+9licsLwN0xUHkXUBjm9pfGMCE=;
 b=K18ukLBQk/gUzjkyA27PEvMkpobrCjBmu3Rsfc/RsFt+CNWL/f5Wm8ItAKwcnU8xCNtL
 kiVAdNfAXeHIJI+Mh6lHUYsmekGNeKUs9b/9IHc+ycDhS7e3/60oQH6qVOCCEzM4JpY+
 bt8LvII+POU271j9RDBWqIBfIFHn/8sPijvJlfQqialG5AELCRBSi7C6N0+HWvcG+1bo
 GbjRCyQauniNJwqkjwx1l8kIo6adf8o2UnxeiuPSXhpzhPXT5fE5nfBq7ljd3yzRPOlA
 wmh79Zec6rquTTjgnoIq8GVKuufODCxqA3Qsm6vTMps2ZiCwB1ZSMoLguVVjmUj7OmWH OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k463bp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:15:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KHJq8C004962;
	Mon, 20 May 2024 18:15:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6rw4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFOVxbiBZc9BLjVqS01n9Tq31vo0Ezl4NnivS2LVoEwvI7oBTWYU3qCTQuPzO5OmcXiw+aM73zg/CGg2x0HKqTsw9wCoc7bHmNZ/b6j1f1ze0lBqrPYqXzUbvGnQ219Ors9Fri791NZWSZhbeNf9YbTpmVr9A25ocvx29d1RSxEtL/l9sB8e1MzD6b0kyYc9edrS7xWq9V2gnK7I+aXwVTWaqbq16jMic9JK4JaCcdikBhzk3FIOChavdVXzvWjWB5TzntHDmZ5okiiUWaWXn9w0KsoTmA0ag0FjLCpdZP7bVUqdWu/DKBNejcNW89k4bVcgiGv18QdWe9NETGX2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPjX9IjJudyJmUBwZ+9licsLwN0xUHkXUBjm9pfGMCE=;
 b=FMFCvaFVBn3Ceb+/VHIJnntSzRsJ0EwGw7yTOlciBiU3a8Yv8L+37KNdd8p5xaytMnG/ZKqtERVpyrnrbaVyAcpIqHdq5gz9NA6kU6y9vRQNRWjpZ55iObSdslNWGebzUtb2D5vvkRzRPK6O34ONPDE8LekGEhd11LwzRHUEnPNMJEvWFgJ21F40sWoWWSGA7Vw1TIW88kPLGicYGa7TYExH6y/USVNgWoTIz4VTw0r/b89YYHwYEA6SErqzvoT9TvhaFDdiA7XweaOCFzwXE4VliEfRmqiJjv+IvH67PBJHtXYKVw6Mab6bWtb25/hG5mo2kDeea3Ld4dAbTi4Wng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPjX9IjJudyJmUBwZ+9licsLwN0xUHkXUBjm9pfGMCE=;
 b=trnL5BplB+Y2zbjMHlLscD23yDPtuBRWNndCcPyvXWq5UJOOT+JD/aFby/t82zGJAxFm3Y5UEXj63RFQypZMcXVzL5UZEXEbhF8scalk+JnyvblbNaD/kd2oBEJtLHzEYGRl/OnBBz/YMmYU8JeHyfQfi6HL6D35T1qzAjHWtM8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM4PR10MB6182.namprd10.prod.outlook.com (2603:10b6:8:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 18:15:53 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 18:15:53 +0000
Message-ID: <632479f9-1abd-4c92-86e4-92d08a9b5b2a@oracle.com>
Date: Mon, 20 May 2024 11:15:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm/memory-failure: move hwpoison_filter() higher
 up
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-5-jane.chu@oracle.com>
 <329c33ce-3fb8-436c-2ceb-e6520f0a973a@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <329c33ce-3fb8-436c-2ceb-e6520f0a973a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0037.prod.exchangelabs.com
 (2603:10b6:208:25::14) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|DM4PR10MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2f755a-700b-48c8-fd99-08dc78f8e2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RktSUC9QZDhZbXplemJ5d1BnNmtJT0pTc2p4YkE1ZG4wQVFFcnYzNktkVUk5?=
 =?utf-8?B?SE1sank3WkMrbWRWTHNVNkphTzYySllpK3hGTCtBSVNoMzB0TGM1NDdoUnA1?=
 =?utf-8?B?aW9LZ1g0WFI2eVc0RXlDQ3plRFpRckVsSUtVZ2R1QWlob1JlQ1pvcU13MTU2?=
 =?utf-8?B?Vk9qU3A3dU5SRHZMRU51R1pTR2N2Q0ZSQlE0bkZYTHRDSDNkaE9xWVhCaUdi?=
 =?utf-8?B?cjhkOFA4VHJ6eFpUU3Bpd21ldXZ4Y3VJUHlJcytoZmVKTkl6LzUwTUlvOEtr?=
 =?utf-8?B?VTN3ckJjTThqL2kyQ2l3TTlNMGNjT001S0w1U3ZjNU5xV2RsN3NqMVVUMDhE?=
 =?utf-8?B?N1NRS1N4WVlOZVRmMTFCZDJZZ3VNUHpYVDJ4UjVCcE5UTTI4TmkwcnFiVGth?=
 =?utf-8?B?Qi9xZHAwNG02bWgxajJMSTlzTE5KeHZIT2VHYmxWR3c4aXNuODBGTWhzZ3Q2?=
 =?utf-8?B?MGZFL01JQUVmeTcvNkdHVTlnempUZ29IbTdMNHcwVGZFN1lYVWc3WGJaZS9J?=
 =?utf-8?B?N0Y1Q2VKZk5HQzlSV0lSV0YrK0ZmWnRoRFd3cWZweW5KRFFFSVRtaG54OUdR?=
 =?utf-8?B?V0g0eGtmT0NtUFBsRHRPZ0t6WmwwVnhMT2dnbzRVYXpJeU9EWm05cTZPZWla?=
 =?utf-8?B?d0hQZUtGRjY3eEJUeHd6K1pwZmZjckpPYnJrWDJ2UkZyV2xkbGt0a3lYVkdG?=
 =?utf-8?B?OHg0RDlIdWp4VkQ0dDNlQmkzQjhNQUd5REdlWk8wd3BkQlcvbnB6cHpvckxU?=
 =?utf-8?B?Yi83WEticG5BZ1MrU3JHbExVV2tacjdCRmpFaTRzVExTcVJmclNtMlJmT1A5?=
 =?utf-8?B?TzN2allmWC9hbmVGTlAvZzhQQUIrZ0IrRmF4S25oWWhQSVlsQ3JnQXpCL2pW?=
 =?utf-8?B?ZXo1dlh3cEZ2WXdLNm1SVms1UldzczNLTGU4eVNnVjlhRjl2NmJPWlNlUnpk?=
 =?utf-8?B?K2tQMUcvNnQ5b1FzdXJSUm5WbDNtMVczYm00QkFhTVovK0IwVmcrUlVMc2R1?=
 =?utf-8?B?Zjd0V2Ftc05Tc0c3VHc0MlpteDYvZ0hDOFdISElEZUZmbFE3LzNjOVZHZGxY?=
 =?utf-8?B?UVNMZmdnb0JZaCt2Sm5JR2x2QndGckZycy9Nb0hZcEJpM1p4Y1FNQ3MzejVw?=
 =?utf-8?B?ZUU4VS8vR1NrQkJYbE5WOUVuYjJoWHdHS1ljeXpvTExJNXpzSG5OTklqbW5r?=
 =?utf-8?B?T0tMek12UUNJUU1RUUp1K0FLWTcvRFo0WnV2Y3V0NHBPcmRtS3FIMFYzUC94?=
 =?utf-8?B?OW8zM1g5SkROeE9BUytyMzhFbCtpMk1FSkxYQUQzQ3ZqWWtKeENaS1NhTlE5?=
 =?utf-8?B?YlJVV0pxMWZUdE8zTXZhVFg0eEN6cG5PWjZxa1NnT2pvaXFoU1Z2Rzk2aWVJ?=
 =?utf-8?B?dHNoemQ4RnlIQkZWZlV4VE9USXhDVjBjbmZJV2FYV1NGUURCNllMM2pyTjdD?=
 =?utf-8?B?eGhpWkRzNGVFMHdua1dYT2tJNGhFNUxoRDhrTGlvMW52cjB4SittRHJOK1F0?=
 =?utf-8?B?NXl1b1M2MnBPRm1DMjlDTlhIbFpvZy9yTHQ5dVhjRWx6U0xPcU5pUjZRWk9I?=
 =?utf-8?B?Ujd2TW5VMnh3Qi9YUVh5L2hXdTExK3BxQjBYdk9Ed2IrQUh2alJTcVpNV2Jo?=
 =?utf-8?B?YlZjMS9VQVpudkdRaHo5c3BUcXIvNEJIRFcxT1V0Y2p1dVMzdHVlSXdyS2F6?=
 =?utf-8?B?TmNhTHZ0ZWVna05BQ0NWU2ZpaGs2dEFUNkRmaUV0dnBvcWxxT1M1endBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEg2ZGwrckFaNmZLNFB1d0JFV0ZWb2pyYWNoZWRkWW45Sm9zOStkRjJWdksy?=
 =?utf-8?B?RDFHamxNV3lFSE1UVGIraWRvSHVGa0ZmNllJRjh6SlpURmxYZ3JJUDRkdk1l?=
 =?utf-8?B?MFNrYXhTcjhLNSs0VmdpU0o3RG84K00wNHZHVVdHNFpmQXJGd05tMTJ3Tmdo?=
 =?utf-8?B?L0RqWi9SR2I3R3A0K1hZenF3S1ovdTNRRDZTRFlVQWliRXdpaDdSOHl3bkFV?=
 =?utf-8?B?bzFnalkrMmFpVWo0SFlOQXQ2UkZMSzMrdVVtMFN0VWNFbXZXNjZ1cnQxMUhn?=
 =?utf-8?B?TWhlVVo2MXI3QWlyMk5WeTB4ZUF5YmkxNEdqazdnT01BQytXV1BYSEFTc1hM?=
 =?utf-8?B?Rjdpc1JzK3NMTGhjTTA0VEZERTZpRTVlNlVEdCtoMHhwY3Foc1FnZGg0Ums0?=
 =?utf-8?B?eHZKQkRBYXZXOC9ZOEI4dWxBb2xIdk9FV1ZYVmJrd2pqZXVxUlJ0TC9IWEVX?=
 =?utf-8?B?TFE0VytKT0pJLzlEWjVGVzcrTUtla2w5WndGam5TWVBSU1N6ZTVuSW9hR0c3?=
 =?utf-8?B?NlpqS0ExVG9meWpXbDNyMW41WFY5VUV4czlvSlFZY1Z6YzVRbXFOWkJzdFFs?=
 =?utf-8?B?R0FYYmsybEM3U0xpeG9jWXJnbTk1MFZjcW5LR1VoL3hUQ0FueERnQVJ2cHBT?=
 =?utf-8?B?UXF5QkREb1VZM1VmMXhOWDVibHFBY2NoMWxyNmtXMjlKTGpsUEtpTmxWZHVx?=
 =?utf-8?B?TWczbGw0dGRvcXdPOUorZ2M3THhuRGkwK1p4R2dEYXVLUU9GeDlacVEwT2hn?=
 =?utf-8?B?QUszemJUdFNGSjdwRUdodjhRMG4zLy9zWE9kQmg5THoxSkNQNWFBQUdPU1Ny?=
 =?utf-8?B?dHBweWsrbkFVbEhrdU42SWVjeW1wdElKNFFVSjdHS1dYNU5qcCtudlZ6cStw?=
 =?utf-8?B?MXJ1UFVpRTU5OWNIZ3pudVBFYzAvT0xBajQ0K2hiQ3RJY2VWdjl0U1Y0d2ZW?=
 =?utf-8?B?YUE1ODR1RVJBWFdDOWdlUDBqc2dCaTBnc2V2SmVNV1VXYW9NTmlJMUVLcHNi?=
 =?utf-8?B?NXJKK0pRb2lzbS9HRUJQbkl6YVkyVHVSRVppK2JZMlZUb0tHcHA4Y3ZCUEV1?=
 =?utf-8?B?cHhrOGdRTTFzSDRnZmt5WVlYclppbEd6WEk2Zy81aUlOVmFGMWtwVWRmbE9r?=
 =?utf-8?B?aGllSDFEOUhvWld5dDZUN0Q0bUxaeWhqUk9uNkdMUW1ZdTMzcm8rTXFBS1FC?=
 =?utf-8?B?d3FYSk1oUURmWTZLZmpIWFpiby9PVjF3UjJHNno3ckJ1SGNUVG9mbGgxZk1Q?=
 =?utf-8?B?ME1GVzRwZ2sySU0yYWlHU1ZQell1TUtDczB5RmFNSTR1RHh0VEl3NWV1ckVF?=
 =?utf-8?B?MXF1TDlkM0MrejZrcnhtODlNekdNUEpqWFZmVTJ2WkQ2alU5NDVQaFkwd3dY?=
 =?utf-8?B?WTFsaVRCWExhaENUOUhkMUd4UDArMEgwQk1hWG1WYldEV28wSis4Z0g0dGVN?=
 =?utf-8?B?SnM3TEV4V0tQbmhSUEYxYUZOdkRUV3dqMHVEMCtGN1NGd1pTRmVpSnVubjhC?=
 =?utf-8?B?RG82Tk1wdy9NNXYrWFltNFI1em04WlNka3ZTMzRicUVoSURobDAzRkpOOUo5?=
 =?utf-8?B?TTFUaktKTmNiK0wwb1RqNWJJeVJSOThWbUV4cHdiOXIzbFNBaWRFdUJvcUdW?=
 =?utf-8?B?SnZKcnhEdmdlQTk3c3FsT1d3WnZmTy9FaHUzSXRjcXkvMWdURmRQSDBaOS9s?=
 =?utf-8?B?QkcrYVBGendCTzJhdDNJeEFEU1JmTTE3dWdqamNHQ0JZcEk1b1J0a0NJQVBn?=
 =?utf-8?B?V0ZCdlFwaWVaandGa3AvcndBODVjMHRFTXY1VzNES0g4TXF5Wmg1aExKckRQ?=
 =?utf-8?B?dU4xUkFlcHFJMktEN01uYWxya1pMVXRteGUrV09WZFZiclNjK2tuUklvWkNI?=
 =?utf-8?B?TDhVemp4R2cyNnNKUFZXVG9xMW5VU09XMEhKd09XNmI0cGZpSGxCUmVhT0lQ?=
 =?utf-8?B?eE5XSkJ1UzNPTnRXdTNYSWFWazFBZUFDV2NoNlhRUENRSmNHTFRhcDRxcTVy?=
 =?utf-8?B?NDVCU3ErNUlQZmhlZVkvRG0xYkJNdUFoc29qWGtkOGJkeitkQlEwRTliU2FE?=
 =?utf-8?B?QWxrdnI2OUl4My9LZEhCcEtQbGlpK1oraGIrQlNUNkJBTHBKUmxNQ1F4c2Ir?=
 =?utf-8?Q?OMxQPy2R43HPTUabaN4quRhyD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BtTNkP4J4vrDxy/yizzU8sJY3+Zzhj4C9b1bQicdtFxwCGxkcURHvoTzUsVq+tNlpWrENV3o1Ve2UXVEs+efHJq/QKAfTpcuAN3pSR4QXYtdMwYYALzqwWvEcM6q0ZNmrwntdYhrAZvdZuee3xvhegt0fwvXjsEx9phN1e67VoYj/kVNh8ABx26mpy8rYMNYHFcmPAXgRH1HB23MewR2SFP6kHs3S3KkuqcanT3GbyqeAK/n06RIr5oo3YAg5SKgnPvOHPw8QJ18qH+qb8E1gXTN2zHCy4n9IWbcx9nxStHGQyCm74PcHRiXnnrpWldr2QbjIwVZZ4v+UEQ5wsHcwn+TnX/Tmdbov4xeT45O6w9N9L2VfogbDDQI020WHCiYGIRaVcIAsZXeWFnyWEubCnK0LAC3j+PGGQGISI+k9gWBe40LFcBOXtz733d37qkSKoPqxwVOrSGttG9NLOaMrkvNO0uKtX/TWmGhkXm2HBRcPmdSOjEN6OrN4zVV/Vcxq6+sKNimhkBuN07HAYsPE0Tn+DiuzFp8bKq/VyJlw7OmnXIuGWgnoW9FZPBD+vBLsx8YGXs3lH8czimd0ex6IJQaXtiZ6gpqOqL8X4b3F9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2f755a-700b-48c8-fd99-08dc78f8e2b6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:15:53.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+/zs2XtEPGShhI6HhI7HrNzjnKuXN2Il9NSC6kSvyevyXcC9+kkeGogidilsdRjrrK0A5wXhiZ7w7TMzNZarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200145
X-Proofpoint-ORIG-GUID: 7bNCTu2iCBgayjgq6-64XlTqDofveJ-1
X-Proofpoint-GUID: 7bNCTu2iCBgayjgq6-64XlTqDofveJ-1

On 5/11/2024 1:29 AM, Miaohe Lin wrote:

> On 2024/5/10 14:26, Jane Chu wrote:
>> Move hwpoison_filter() higher up as there is no need to spend a lot
>> cycles only to find out later that the page is supposed to be skipped
>> for hwpoison handling.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   mm/memory-failure.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 62133c10fb51..2fa884d8b5a3 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2236,6 +2236,13 @@ int memory_failure(unsigned long pfn, int flags)
>>   		goto unlock_mutex;
>>   	}
>>   
>> +	if (hwpoison_filter(p)) {
>> +		if (flags & MF_COUNT_INCREASED)
>> +			put_page(p);
>> +		res = -EOPNOTSUPP;
>> +		goto unlock_mutex;
>> +	}
> It might not be a good idea to do hwpoison_filter() here. We don't hold extra page refcnt
> yet, so the page state will be really unstable. Or am I miss something?

I agree with you.

It  looks like hwpoison_filter_flags() in particular needs a stable page 
in order to retrieve

a wholesome KPF_ flags set that at any time, although the flags could 
change immediately

afterwards, they won't be torn flags. For that, it looks like the folio 
should be locked as well.

thanks!

-jane

> Thanks.
> .

