Return-Path: <linux-kernel+bounces-257254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8EC93776F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33121F21893
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2778128369;
	Fri, 19 Jul 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqKQMUTT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hiiWClW5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77911E871
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390681; cv=fail; b=Tja/ssSlxEgqhhTqCs1ThXU0KV9l4GA95kHJcaT7r0clv+d6dyDCLyKXYcb5RidWh2jHcYWmQELkxcQFyQZ0CQQybdSlBFu1++OaPARXO/421gO1K6gow07zMO0t1YU9W7bjQx4PURJIt4vhe5kzx1sHxJ55CAMG/0Efe944QhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390681; c=relaxed/simple;
	bh=l/iDgNZVRFEuDoOznk/6ox32JZET6YDggARrVaxTyYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BIuyXykp8naQPKgbUYDZYB9XTAa44jjSGZ/2r0rFWmcJGOHm6FFFqIp8XdoQvBzSXKpCVphOt5LOP0vrYMqGvyYlSCZDEZzksl9b6AJtaa2xn8yb3dtpIPjZ+b7D2UOs/twv01It9RohNFtmjl0zNAQ9UffGMRPwQhGqMkaEUCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqKQMUTT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hiiWClW5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBtKtn025215;
	Fri, 19 Jul 2024 12:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=jHRa+VWYFbwl63CJiZVaO/UtQLYvZQy4VHHIjfri+uc=; b=
	kqKQMUTTMFvhCWMPGLbWkFTTd8Na2/CFJ4Hz9P+Z8c58rLWqLlhwPr8VLwQ+OCax
	kNqts8/KrZV9CTSSLNYwtf+bNNgQAlCD5JilWIZ4P+B4w9+LKhBhmZoOB/jnl3Ms
	3HLhBo8Hkc0VFLp3XMRl7mnAh3cWJ/n4z7bdDtp2AdSBf2j2I9paG2eKydiTl874
	9N13C0hr2yzrI6pTyALc+zfiIE0UDUwBW0yp5JW6zlUkOhnC+R1hoPksV2KilnOV
	SPNfnAHSb5sCRpRbbERXCffhji4r59zJSZZyihh/6QWV0ZzCe0R3wiQzVW0xQmNF
	P6NlfP4BZtN5/7hqWfA1eQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqppg0jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 12:04:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JBpcEn021705;
	Fri, 19 Jul 2024 12:04:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevu88q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 12:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRLdbGxPY2otlP4HRJ2is9CB8Kx8WEE2tCFXMqLRdc3VgdId46lKLDmcB8jmsKWAnMXuYJScIDrZ6ZdHmNO5ZWrH6aB0B6BICHUEpOVm8MJMb0LXsR0qaKiW/AX5AW8VB4Y8wN26GlSrREew8IQ3GVMGJPxAGYGz8FAkghh/vZnBUkMRjPy2MOIdK3MhbYfTmzxgDe3q4qdkmdbLozJj6WBQvuVfS/rnRV6NQvD19quntRu8d2ez2M0ZRIhkDRKvrDnUXPRqwWgVm3nonOfOSJyG5HQQqFQp48GI9EbIhmAOFlKTLxkuUL51vEWG9lcvAyeqGZ54aFkwbIPDhvWb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHRa+VWYFbwl63CJiZVaO/UtQLYvZQy4VHHIjfri+uc=;
 b=v0VBGVL1qLULxI+UaJUBqgqM491JreTt7G8goGc3WkdPI1+OsYyI2SMv8yoplGmS2b7uA8F5PxprYUnGVEZTH9RP13WKQnqspi/IzA/sNxpL/2h7PqTiKnItoO1S0/P/vuuRJI/Qq5Tjyqi/qrgDBgnfi0f3Oxeq6RJDn1ee5d6c1hu3BPccStxxm4ezewQGGExQVZvZv3n5YlQKm6bjzFJOnbR/TPvZ9PFkTLtuaQMA/Jd7n3+TM83jbWYnHewmhRc2vYMELQN79Y88NnBWqZqnitFh+bAmVNVRmPd3Hf//ry0R2ojjSnZD4SN/ldhav27weUAOnBLibALhDpLd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHRa+VWYFbwl63CJiZVaO/UtQLYvZQy4VHHIjfri+uc=;
 b=hiiWClW56ULZ1JNSGXEGezsAXxu71t5Rjm+whtnmqLoCpRmsQCCo/jaeet5k4BDDA+Bqu70aa0H02jTIjzHQSqdYnkd6ocus5UNhp0YVdwmmCmMblUVafAuCcuX04qtXfq1kIsp3DfKC9whsEf/pDYnCebaoybokq9KrVe7vV0Y=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Fri, 19 Jul
 2024 12:04:31 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 12:04:31 +0000
Message-ID: <3bd6b12c-533c-4b6d-bc91-696db8837b3e@oracle.com>
Date: Fri, 19 Jul 2024 17:34:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Bug related with a 6.6.24 platform/x86 commit signed by you -
 Enormous memory leak
To: Max Dubois <makemehappy@rocketmail.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <707784492.392759.1721383145890.ref@mail.yahoo.com>
 <707784492.392759.1721383145890@mail.yahoo.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <707784492.392759.1721383145890@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MN2PR10MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 150d27b2-3c49-46e6-5368-08dca7eaf292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UEpHZnlXSHkwcTNVdEllU0NVYnFFcGlxdE1yTi9uQUtYV29OUUJ1ZXdLcFox?=
 =?utf-8?B?QXIzM1c1RHRGSTZkM3dIQWY4bVgrakxZdG45KzhUTUhZdkJ5REQrMmMyOWhi?=
 =?utf-8?B?M21BV2tJaTNGYlhOeFJRbkNjWm5kR0ZNK3MyN0tXL0k2QlpPcXpmWFRRLzll?=
 =?utf-8?B?TnF3KzNCSnk1bEczQlZvL0hzYTFZTkcxdDB5bWJwQ3ZNbmM4MGt5WWdiRHJJ?=
 =?utf-8?B?VC9jeFRWREpvanRZNnBXU2JMTSt2NEFvUFh5Sm9iUW9rZUMzdWhOWmZFWWpC?=
 =?utf-8?B?YS9zVHkzTE8wZTJqRWREaTI5eXloQUtQbVBxR2E2K0x4OXMxcVZ5UHkzdEY1?=
 =?utf-8?B?YVhuTnRqeGI0U1RPOWtUUVB0WUR1b2tIWnllUElDa0Y1WlI2aW0vN0FNeUJp?=
 =?utf-8?B?cmJUVUVzZGF3MFVUbEZBd2dQRVFBVUVUd0haSkNzRWhlbFA5UkdlU3lyOFBX?=
 =?utf-8?B?M2NsTTNZWmFOaFFzUEViTW11TU03TzRJN0JiQ2J1V3c2c3MrbENBWWUyV3lP?=
 =?utf-8?B?QkJiVjg5azA3WU9VbjRUeEtFd2k2UWhmV2V5aTZZZnA3RXU0WStISnYyV3d6?=
 =?utf-8?B?KzEzL3RsYXBLakxUbnRLYm5WL1U1NGR4d2lPK2NCTHFmQkM2R3BuMk1oRWl0?=
 =?utf-8?B?UmF1ZGZkbmpoNkFXaUdUYUNISEpYNlY5ZEhkdEI4ZDZLQ0pLZmk3RHNoTjh1?=
 =?utf-8?B?V0VhQ3JYMTFZRm80cG1ycVhRSC9ueDRNMFlOTkJmOSttbE9ILzVINzNuZ3Vh?=
 =?utf-8?B?V1pzbHgzTytCUGthRWhJVG5uUDhxWm1FUVhPeGNNQUgxNW5mV0ZmTlYxRHRR?=
 =?utf-8?B?MjZHS3IxUHVncWFUTDJ4bGVDZ3FWSXlibk15Z3lYQjJUUGx6cnB4SVF1eEhE?=
 =?utf-8?B?Slg1Y2ozcU14UjlNSUlMbHNMaytaV2c5YjBtNUd3QytpL3FnNGJpbWgvWFo2?=
 =?utf-8?B?UnVDOExqamt3dFVCa003TUU5T09HanErbkRmSTlFVTBmZGM2SCtZMDN3RjVU?=
 =?utf-8?B?UE40akd4SVFCNFEvd0hwNnAxQm1NelBRSXRNaTNBNWdpVEdkTzlWTFR5d0tk?=
 =?utf-8?B?TkZZZWNvbERJVmdHTy9Ub1VoYU5FSE8wbkMybjJVbXppWmpRM1gvcVlzNnMv?=
 =?utf-8?B?VlVoTVNoellLZEpodUJCNll1ZGxFTktvd245dVZLQkFzQTA3enh6YzhIT01Z?=
 =?utf-8?B?d0poeE5laUJDZ0g1L1I5cU9IMVd4NGlMbDVxeFlDNUorT1NYMkErNHdJeG5h?=
 =?utf-8?B?clhRSDkwcEhTTTFtMlE5VDRIU3FCV2pDN0xneVpvd2dXM3hMTy9RcmRYajA3?=
 =?utf-8?B?VTQ2cDJremY4bjdoWFczaDc4S0V3SWJKQVBzL2dqOHRiaEVzQlNNdzlZbzM5?=
 =?utf-8?B?TmNlQjZ4OG11SkxjT0tVYXY0RHl1NWR4ZklNWmlOM0F4bHlTaGNxZW5QNnhR?=
 =?utf-8?B?ZXMvNUZqejIwQ1J0SXZZMmtYWlhBVk9Iek5lZ000dW5ndDI2blRaSlNhcjk2?=
 =?utf-8?B?SVRPVlphUmV5aW8ycGtVM2x4U0FLaFpyekxmYVIwWEt0dnluY1FuQVd5L2Zq?=
 =?utf-8?B?WmkvV2FObnZCQnlLTWRzaG1RdWdJZWN1RGRPSmExbTkrM1FtUDV1NEJFL1o5?=
 =?utf-8?B?RUh5ak9SRlpTRFJNOXlwQTE5Qy9xWmF0S09kZ0lnSnd3ZGoraGlLRG9RaUxP?=
 =?utf-8?B?cFBabnZFRWlsR0FQcUZSUlp5cjA2TjlYOFB5RTZHM0hkSUhqVXFZVUU2Nnhn?=
 =?utf-8?Q?PIsQZyRI6uMr6jIqsg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGUxWDNLbVlqT3UxaHRUK21weWpuaFRwMmxXMnhsQkZrVHkzNFcyclVhd29q?=
 =?utf-8?B?SldQdkdYT2JUSzBaUlhCdzRnYk01VEFldmJLVmJ2NUIvSG9mWHZRSkdscnFx?=
 =?utf-8?B?a240cWc5cGhmWm9rWm1GdkJiYmk3NWF4SlJLcTU2MUxqYzJlVG9jcDA1SEZR?=
 =?utf-8?B?SzMzek1wZmZYM1hLYzRmZ0k3aTFHK0tUQUlOVUV4RHpmUElWclUveDdaZ2VI?=
 =?utf-8?B?dzByMlFCY0FhOTNybFlCOTZYdGl5YThyMjl6L01lRWp1ejVRZ1M5YWhKa2J0?=
 =?utf-8?B?NlF0N3Zla1RYSS9ZVnAyMU1QRUNLT3RrbndsVWFKY3pHM1NnUjFST1BkbVZs?=
 =?utf-8?B?aDFhWVhzRDR5UDZlVkswdzhNVUZCcm00U3Awa2QzTEpFbnpObWl3UmtjVXJY?=
 =?utf-8?B?VXpEU2VyT05iMGZPcFFKMkIvaFNjTGNja0R4NkhhbXRYRGxCZE1RRmlVeGdy?=
 =?utf-8?B?b0d1VnhEajBrQUVtM1h1RTNGdFdBK2ZwSjBUaS93UzNIVnNaeXd1RXljcFg1?=
 =?utf-8?B?bEhWWEp4SGMwNWhqY1FxZDkvUVdhQkNHRjZCUVBidURNeWN1TUNFc2JjcEtS?=
 =?utf-8?B?c2VONEtreUh2dkY0c2JrcDB5S1MvOUN1R3pwTDRQNkJDTjU4aGdNdVNEZ3VD?=
 =?utf-8?B?T1lYbkkvbnJ2amxTUzVNK2pNOE9QbGFYOWM2cURhb0VRcTFQQy9yU3hQQmZp?=
 =?utf-8?B?SSswT0RyNmUrNkc1SDFrTFFsWmRnOG5UcG15cjdDUGl4RUY1c0JXWWhrT2Uz?=
 =?utf-8?B?ZmRWTGt5d2UzV3A0MThzSkRzQ29oeS9na0NzVWZRT21XVmFUYzhyVjRnSjdk?=
 =?utf-8?B?aHRpWVA1YzZUYldUS0NYeTRhcjhUNitVNXVzY21jK3VaaFpMOGVCWFAzenZV?=
 =?utf-8?B?ZWd6NVhzVElkZTF5bURoQ1M4bjE5cy84NFhURGFZRmlISWZXbmxSWGthMVg3?=
 =?utf-8?B?L1VnMGY4NTVpZFkrM1RkbDcrOUFQWmRYaDRiOHhwekJ5M3RkRmUrV0VSVzVF?=
 =?utf-8?B?ZUVKeDROM3ZKc0ZaejVXdnNJYUc4bDgvU2FLNVk1ZmI3SVJFVGM1Q3piS0ty?=
 =?utf-8?B?bkJwUVFOWTRUUHpmWGJVcmhSdTZBalNPSFJnc2x6M1Yza2NIb1d4aTBOL3RC?=
 =?utf-8?B?MjI3R2d4OG9mcENlS2IrOUcwV2FGR3R6dUh2ZDdpVm53ejFmR2lFK0IyeHdk?=
 =?utf-8?B?dXFUL0Z2bkgzdXd2a2ZlU0lhTTlWMmJNMjB2ZFRiT2tUbjhxSjNBb3dhbm5Q?=
 =?utf-8?B?Z2pKZSswbVk3WkUrM2VRbElhU0Vyc01CZWgzVjk0UTZmNzVmMXRKVkhqY1Zr?=
 =?utf-8?B?OS9YUURybi83RzlKVllORWtwQTlXcDcvTlRlMnhZcWpCQ21yTUlkdjFqaE9o?=
 =?utf-8?B?OGMyNkpIeUJnRUhra0d6LzVON21sbGpiME84blhkS3I1TkQ1NVJGWWNRK3U2?=
 =?utf-8?B?V01mMjJzaFR2RXdLOHY4UzhDbk11QTN6RnQ1bXhVUmRUZ1JyZHdPUWc4czds?=
 =?utf-8?B?bUc3Wk1tS1NSRGtMVFQ1RXJMdlZ6NTdkTjhPbzk0eDE4VVNWbjVuWU0rYU14?=
 =?utf-8?B?eHZIM3JpZzhGSytBd1RMTUdhNmNIVGpTemdtUzJEcWJtQU94Ty8xQVU4NUo2?=
 =?utf-8?B?QVFBOGJoMzRrL1VBSnFGV3d5dGpWZWMzWDJZYld2MW1FWVFneXozL3luSkJL?=
 =?utf-8?B?OEdwQ1dONzBtdkpCSWlTQ1I4ZmdlblJjTUFtK3VPZkk0RDZPeTdxV3paK0dU?=
 =?utf-8?B?L0llYjhaazRnV2lkSUsweHdxaEx0RWVka0NnR052SEhRazZ4NEc1QW14d1BP?=
 =?utf-8?B?SGRUQitGWXhMdXhqK1VNTU42Um40dkxUMWtFL2h6SnV5SFhVS0VpZWtwb2lD?=
 =?utf-8?B?Y0huYk9Gb2syb0xLVVJqQjI1U245cUFtNlVxUE1wTWhGU0MycTRBZEZzdHNJ?=
 =?utf-8?B?UWxZYmozTTU4RkFET01jTjJGQmMyZHV6Z2xNMEpteXF0T1JPQS9BWE1tWTUv?=
 =?utf-8?B?QjQvZ1JnZENva2QrZ2Q2M2ZhT1lycjVOTWNJczBVbXQ3TGsxUldEY0FWRHl6?=
 =?utf-8?B?QTZ0OWRBbGFLTnBySWc2MEhhN3o2RXpqa1VTMGxtVHBSbmNaTjFHZ01CSTMv?=
 =?utf-8?B?MDNsTkhua1U3QXdmdUVDS2xLcjl1bzJZRFk3cWszMzNrdUNScE1OMy9zd0dz?=
 =?utf-8?Q?0XlSOnmoOjl3YUB5L5fcyow=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PRC5S6k9w+FHArklYLp+r7GWu4Fcu3Pqxaz5jU1eALdOLxdeCTZBDvrmA1O4uaNLsIfI7uQXGJCDB5v+xPMFZDp2c5V/6fGCkeFB6wEWorLTqfBOLT3VGjUCAhQjPqMQAGyCXy4sOzIxH51eJ3LAtGGbvJ4fxmbNcRiVAHwXzN7w8MWAJrGSWdBAjP6sOFMI291JSbHW+/F3DYf3UEziSituA38TwBGVt2aYUSQMgUbhY4jPKQtL5GZxFM+qqEEF2MbMjfFizR8xRkCnzPr1OpSoJWjIqa+AwWLy70nv3hIvJHu2xPifvrqqpXy73XS1G4GIyyRFBiXR/X8cJ3UbxuJbLkEedh82GQoeeyaMA0iL4u+F9yGSrpqhnBmI3dviOwMyXClpcp7FADILDBMEL/UR2Lwc0RQ813J8v342PrY8yYip45O+vW6zhOeElDW7PvR+C39N+pgQmsJt5onEG5f6ch050Q2PU+wMeOGgcK+C7PnG8XbksjbMxXnBoAIGZIX5mibdbnN/ljQHkl86pxn+ShuIR56kSHRUkH6QxVEgDh3V5oIvDt1RPf8n70c+hRXUVYTCSwryGRfMQBVFZJtTQUUgd7NKroXVvu38J+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150d27b2-3c49-46e6-5368-08dca7eaf292
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 12:04:31.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9NjgTWCW9Dv1JfVucArH3pS7Y/LlqvJlQTnB1hdvNHnWmUz1NckKyi6B058HYckuVuQhpkLJGKeNiIgXX298mQFkbyZvdTHknTp2MOZGvNzVPnQwyqTe5Kg1YA/ebXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190093
X-Proofpoint-GUID: KytR7cVr_v-rPnrHcVqn1B1-LutodLON
X-Proofpoint-ORIG-GUID: KytR7cVr_v-rPnrHcVqn1B1-LutodLON

Hi Max,


On 19/07/24 15:29, Max Dubois wrote:
> Hello,
> 
> I write to you becouse you signed off this buggy commitment long ago.
> 
> I don't know how to report it. This is a nasty bug and I think it is 
> related to this committed on 6.6.24 and it is still present from that 
> kernel to even 6.6.10 only in 32 Linux machines with over 32 bit kernels 
> (tested by me on virtualbox and Vmware guests, I don't have real 32 bit 
> machines to test it):
> 
> commit 9a98ab01e3acba830cb0917296a13192fd23f305
> Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Date:   Mon Nov 13 12:07:39 2023 -0800
> 
>      platform/x86: hp-bioscfg: Fix error handling in 
> hp_add_other_attributes()
> 
>      commit f40f939917b2b4cbf18450096c0ce1c58ed59fae upstream.
> 
>      'attr_name_kobj' is allocated using kzalloc, but on all the error paths
>      it is not freed, hence we have a memory leak.
> 
>      Fix the error path before kobject_init_and_add() by adding kfree().
> 
>      kobject_put() must be always called after passing the object to
>      kobject_init_and_add(). Only the error path which is immediately next
>      to kobject_init_and_add() calls kobject_put() and not any other error
>      path after it.
> 
>      Fix the error handling after kobject_init_and_add() by moving the
>      kobject_put() into the goto label err_other_attr_init that is already
>      used by all the error paths after kobject_init_and_add().
> 
>      Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
>      Cc: stable@vger.kernel.org # 6.6.x: c5dbf0416000: platform/x86: 
> hp-bioscfg: Simplify return check in hp_add_other_attributes()
>      Cc: stable@vger.kernel.org # 6.6.x: 5736aa9537c9: platform/x86: 
> hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
>      Reported-by: kernel test robot <lkp@intel.com>
>      Reported-by: Dan Carpenter <error27@gmail.com>
>      Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
>      Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>      [ij: Added the stable dep tags]
>      Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      Link: 
> https://lore.kernel.org/r/20231113200742.3593548-3-harshit.m.mogalapalli@oracle.com
>      Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I reported this on Gentoo forums in this discussion:
> 
> https://forums.gentoo.org/viewtopic-p-8834077.html#8834077 
> <https://forums.gentoo.org/viewtopic-p-8834077.html#8834077>
> 
> In this days 32 bit machines are pretty much unused and I think this is 
> the reason becouse no one reported it.
> 
> The bug wasn't present in kernels before 6.6.24 (example: 6.6.23 is ok).
> 

Thanks for reporting and sendine me an email.

The commit you pointed out which is authored by me is in:

v6.6.4   - 9a98ab01e3ac platform/x86: hp-bioscfg: Fix error handling in 
hp_add_other_attributes()

So you should have seen this in 6.6.4 as well ?

 > The bug wasn't present in kernels before 6.6.24 (example: 6.6.23 is ok).

This confused me, as the commit that you pointed out is present since 6.6.4


> I tested it in various VMware and Virtualbox guests and it is very easy 
> to reproduce it.
> 
> You just need a VM with x86 emulated processor, over 1 GB of RAM and run 
> some applications like few terminals, a web browser and audio player.
> 
> In the log you will see a lot of complains related to vmalloc 
> allocations not present on working kernels before 6.6.24 and this 
> commitment.
> 
> Increasing vmalloc like suggested in the log, doesn't help.
> 
> Starting from this point the VM become unresponsive, it close apps, in 
> doesn't open others, terminals can't execute simple commands. Sometimes 
> you are even unable to reboot and sometimes the machines freeze, 
> sometimes they go in total kernel exception.
> 
> This happen 100 per 100 of the time, it is easy to reproduce it 
> everytime on any kernel 6.6.24 or more (6.7, 6.8, 6.9 and 6.10 are all 
> affected).
> 
> Considering the kernel is supposed to support 32 bit I think this is 
> something to fix it then I don't know how and to who point this bug too.
> 

I couldn't quickly reason out how this error handling fix, but I think 
this might be due to another commit as well.

By 6.6.23/24 which branch are you referring to, upstream stable branch 
that Greg maintains correct ?

$ git log --oneline v6.6.23..v6.6.24 drivers/platform/
e8fc78a1c70f platform/x86/intel/tpmi: Change vsec offset to u64

I don't see my above commit in the log between 6.6.23 and 6.6.24

Could you please clarify ?


> 
> Thankx for reading and to help to resolve this really nasty bug!

Thanks,
Harshit

> 
> MD
> 


