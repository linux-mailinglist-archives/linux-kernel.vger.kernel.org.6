Return-Path: <linux-kernel+bounces-247657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B288992D2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EDE1C2424E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3B193455;
	Wed, 10 Jul 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="P64SAhye"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D193453
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617613; cv=fail; b=Dd8HvU5xEmqYQqlRjvsV54QWE68r2CGG7NogxDjOfFFOp+9i8r4SlgWt8ZlSHbRZnrvcQTPgHBViQSsF50txXi6NdYwl2Eqxmo72LCUZKSEei86Ho9LyAzTfWb/g4ok6zuKHkGix5mHPLYpM4oLsc1YIYCfiTsbW0ieuGpPBRtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617613; c=relaxed/simple;
	bh=9RIkHXNG+XgTV7aZ1C54KxhDDu2IEw9NMJDYTX6VkLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=eExqMdVWi4slzjWklAj5D3CycmKosOrFAVUB/TsM8vZDpNiAurIdUe56KFcRoIICyOR+S2V0LOWQh8HMMeDrBH9gEhj+fWOnTF36djqUz/l+ZALcv5mM/MaqcUvzR6Ar5AOFR9bh9A3k35AhQJ17ssDrCRyTl0R5PdcG0Y9uETs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=P64SAhye reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7w8hd012511;
	Wed, 10 Jul 2024 06:20:02 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 408ntyqrtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvtv/LRm+ZlVoo9M9AYTXENQkYFMyW2g84DCA0AR//eB81Q6clkeqQPZk1pHPaWR61ZbFOvzd5z7VPmI9IzbvTYv1HQ8zsWj3WtDFAf3/y2d8tJpX26/yLb0yY9zEsl4jiXTblIMWnLiuLz/o3bUw6Y1VvOwrjZp+AcvCbHCS/ejGN5cioIvEoiH0jMoQRguGSNQHZwCwY4ZCVwjUDvXQY4ywLajONRipKeqz5iRFAiHQx8nykOyUnaAKTPHAv8xhqxcKtNGiwri+wd6MQHMybDm4h3UCd2oXdApPZy2RqgHhdqoccf1xyJRiOGc2zApdAB04KER+pstHDfGNkra/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MRyqNU8wq+azwmt2XOH55hgiLE2Us4xVEOh4zf+ISg=;
 b=Flbi3t0zG4t3IQZ60ZELIyqpAU9B9I3P0GDup6+FhQS/t82uRo9ydnZpjOtP3MDSndXRS0uEADKtsbefQkkiC/khiZyc1oqhHKABhai5mj85TZofS+lyoDDVWv550HJ7qsp3nipbncLJ0vo4IinB6gwWc/g1IlCzW+Qov0dT/MhuMsBretUvQW6JgTIFpIDsNx3u2rzZZ9rkNyGs1T/6/AuD0M8HNAQulRto9Xa9bP/ftEJYe0W2gmQDSkpr9n7i1Av3nmMLK4ZAWrNgEph/M8P3SDLpPTRpMWhmaTrpn8j3vmttMAJwikw5STH4LW7GVi2o+xvsjrYuueAoL3lUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MRyqNU8wq+azwmt2XOH55hgiLE2Us4xVEOh4zf+ISg=;
 b=P64SAhye8bKKEvi1SPZ6e7YhMcFhAIm4MTcy8NAirisK8Wedr9TtO8KdkBmqRNCYWr98Nn6wYZCRRSjWkWy0ezRJt6Z9tnu++yKFF2GNEf3YNfMPuv5GrUsCAyTZz+kNc3YzQgX5Qqd1FixwQXyNBNhHePdkuxrxPbSBZnLiNyI=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by LV3PR18MB6259.namprd18.prod.outlook.com (2603:10b6:408:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 13:19:57 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 13:19:56 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHaz7lqd9hdRQGJJUKQ+mbdgUAE1bHv8iaAgAADgvA=
Date: Wed, 10 Jul 2024 13:19:56 +0000
Message-ID: 
 <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
 <2024071026-squirt-trustful-5845@gregkh>
In-Reply-To: <2024071026-squirt-trustful-5845@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|LV3PR18MB6259:EE_
x-ms-office365-filtering-correlation-id: f612c69f-d738-4abb-9db5-08dca0e2fdcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UjVVaHc1WW5yL0dIOHE0TWk2N1lqdW94bWpHZUV3ZmxzOFhiYWlvcmNoS21q?=
 =?utf-8?B?bTJ1V3NLbk8rZDZ4VXE1OHdtZzQ1OTk4V3I3cmg4cVhnVDdTMXNVLzJWUitX?=
 =?utf-8?B?KytENnZmR2pWcGlNbS80a3VTNGExS0ZPWmREMC9vQXhqZ2xZdDBLdklXekh6?=
 =?utf-8?B?alhCbFh0VGlFbnNpUkdON2pXZVVTQ3NyR1dNTlJucklHS2JMWkZLZHhyekFO?=
 =?utf-8?B?QjVKb2RTbGZHRld2NWk0VC9qdmlyS1h6NVF1bzFjcnJCdGYwM0xXaVNTM1pT?=
 =?utf-8?B?djFXc2pqRVF6RGt4VXpiZ2pzTjBxSzNKU1NRZkR6clI3TS95a2pyLzAvc2tR?=
 =?utf-8?B?bzhTZ0dyelhrZUw1VVMraCtRemdkeGZaWXdDdHpTdjZUMEZBSm1EOWhWbmVz?=
 =?utf-8?B?ZENmU1pQVGFZSG13VmVRdUl3di8wbmdWVUNMdTVkTW9Pb3pwZkxneTJyc0sy?=
 =?utf-8?B?M3d2QUg0VXRlSkE1eFU5MzdHeXFleHF6N2RzaDhkVFg0SmhSbE9IaXBRS3Vq?=
 =?utf-8?B?b2Myc1ZLS0tOZFpnZ0ZJMWZveExBYm5pZnRZa2ZtRjk5Nm1PcmlWTWtJNmhH?=
 =?utf-8?B?L0ZFc1hOS1BCNFkrOEQ3RlhQb0hCc05jMzY5bm5jZXhyK2JmMVNLMktVQWZt?=
 =?utf-8?B?MWtIK3VXTVAzaDhxQlFPR3BBT0l0a2JHQWpnMFJCS1pTWWJ1RUx1SDEwMllp?=
 =?utf-8?B?QmlDT3RielNPVXR4WDhWNmRCRGI0ekFCbmZReGlDdkJVQlQwM2k3RnBWclpL?=
 =?utf-8?B?VlpYSzlzOExNZU1QSnpTWWNZeGVsL3U0RzRJVXVNUlVxR2VDdEU0WWd1QnE0?=
 =?utf-8?B?OVFzSEVKVDJxbjgvclJpOUZwZGhTem5Ga2t5aVZMcmVFTUUyWDdIOVdBdCto?=
 =?utf-8?B?ZjdJMFBIMzJja0xnVjFCTVl6NWxLb0VHRmhmcHJnampZTmF1aHQzSjE0L01x?=
 =?utf-8?B?T2ExV3BRSDBHK1hkdW9VcUwwOFFTSEFFdUJOcGhRWGcxRHRtRWIxWmZESHc2?=
 =?utf-8?B?dVJwQ05MVlgzUzBaU1c4SUNhOWY4SGFpRkY5cll6WU5HYWNta1NUSjZsb2ZY?=
 =?utf-8?B?aVFWUi85Wm5Bd2pEUXlxd2dQazR2dTRkZk4zVGdWRlU1ZXpnUGJIQlpoOTVq?=
 =?utf-8?B?UFBoeVNZTTRxRkJGT0pONmlVa0dkQkF4elJxOFlIZFBrQVZVN3JESUJpM3p4?=
 =?utf-8?B?SUxPOGUxMG1ib0wyeit4dmFodm9qZWljWGpmVzI2ZTNxYnpYTHVUbTNyT0xH?=
 =?utf-8?B?bUF0KytNOXVoQW1sbUk4MXdhVFhXYVFsVFJ1dFRycEZPSzBBbnc5MGhOeFV3?=
 =?utf-8?B?R0Y4Rk5LRWNSZDN1U2o0L1J3aWpHeGtmU2x3RHN0UGViT1RXTi82SkM5VHdr?=
 =?utf-8?B?cmJIQ1ovaWVUNW5VTFE2ZzRFenZ6VEpRajlzdnVmazRJN3ZuK1pyeVN6NXJt?=
 =?utf-8?B?LzVvc1dWZnFEckFsRmc4MFlFeTZRVGIraWtSd1BnRk1EdmFNWE9lZk5kT1p6?=
 =?utf-8?B?dDlBZTZmK3ZOWUZKd0p3QWRMUm9SRWVwV1hmRWxhT0NhWE00b2lmZmVSeVdP?=
 =?utf-8?B?WW5SMWtUdlpDbkZBcFRMRzFrOXQxb0hmcGU0Sy9JZ1NYVEoxUldLYnhTSHd0?=
 =?utf-8?B?M2hxYTM4M2l6YjVVMWtnbU9tN3JYZ09EejljSkZjNlRKZS9jTFJPQ255eTJo?=
 =?utf-8?B?alY0bUo3L3dWVTcrWWFZT0ZGV1VxOFBPU0FueTJjSFVGdjZhUDlHL0tjNjVR?=
 =?utf-8?B?WndCTWZzRk43Z0Rxdk9BZWdGWEVRVmJsbjBRUnFBQmZHTDlLbTIyNXF1eEs2?=
 =?utf-8?Q?PQDBPJbvkWVGegWiLYQHB5ng9dLmE1HQvQXb8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NVlzdjFGalFPRlVOSll0dXJMUFMrOEJJUUQra3RHUzhCMWpTVkxhVnFDUDY3?=
 =?utf-8?B?SDNaa3hudE5jS0I5M0kxZTh0cjB2TFpkb0xmQkwxUzUybkhicmV2S0dTS0Zy?=
 =?utf-8?B?S2g3Q0t1RDRydC9VZVpBc0hKNkJmYXFxYW43Rld1LzlHMjRzMENoTXpUY0RP?=
 =?utf-8?B?Ly85SEdjOFFCWHN6YUNnYmFVcnhNSFp2QUxDT0R3TGN4TUlyeEk1RFFPbUxu?=
 =?utf-8?B?ODdCZWVVd0dFMkdsSDJnM3R0anJSQkZxZFdvdnorTVMyTGFrTlBFcmdqVWpS?=
 =?utf-8?B?cmZObDdLLzFsOE1UbW9NcHFsRzhQemRCYWE5TFkrZWEvRkJvbk81WWwrQld2?=
 =?utf-8?B?Z285RWdxSmtldGNRV1pSRW1KV1lWK0JRZFFFQS80eVZoUmdzYnhNMVBFT2JT?=
 =?utf-8?B?TlN5SnhZRHAvNXQ3b2RITjBEZjhrNkx1MEZwRjBGbjhnMVVoWlNmWWRJWGpU?=
 =?utf-8?B?OVltaXNpYzBmRU1UdENCS2piWlgyUTgyTkJOeXNFYnhaU29WUGd6NXYwQk16?=
 =?utf-8?B?T3ZKU0FKdmZQbENmVUo3czNJWS9pcWk3dWRFWWp6NGZlMC93eTVCZlZNQjN4?=
 =?utf-8?B?MVltVzBmSjV3SUhhL2JTTnE5NVZBWC9BSkpVQngwOGZnL0U1SU5HYnJGUFVa?=
 =?utf-8?B?UTJRcGhqZ09BSE9SRlA5d0tOZ2l4REpOaWVUeXZYUnNYOE5mbi9rOWh0U1Za?=
 =?utf-8?B?Ulp5SVNsQXNtQlllSzlrWkIydHdneEJ3OWJDNzgvL3ZtalQzRjV6TUJweGdm?=
 =?utf-8?B?Y2g5ZjM3aWdET2V4Q1VRMzJHbCtwT3ZMWmNKTnFtTUpYdldtdC9OSmwybmU1?=
 =?utf-8?B?RTlDcHNpdkZSaGJaaUdySG5YZUo1YUsrejN3Yys4OGdKZ3pYQ05kUFZUVWtM?=
 =?utf-8?B?eFEwT0tmTVV2UVlDQ3ROR3pUazZrRkpuelhCRmJleE5QbDd4VHRyVVJBU2xm?=
 =?utf-8?B?NVV6TGplbklPTWxkaW5ySlRyc1Bld1VFNTc5akIyYU5KME0zR2xVYzdHM1Yx?=
 =?utf-8?B?b2RvL3pMWjNiWXRIZ3F4bGZqNXljam9FcDlqeUhDdFJYMmxxV2RZRThOTm44?=
 =?utf-8?B?ZjRsS0FNUFhtMm05VHRmWlc2c2g4K0owS0tIWjNpcTBBUHQybDluYVBzWmc0?=
 =?utf-8?B?dTFSSlNtR1doNkZ2TTMyY1VsUFluRi9lZkxUSkZrbkVFYjFabjNyY3U1WnM2?=
 =?utf-8?B?OHI4ZHJhQVZYcUxTYWNvTERTTnJ3cE10OWpUZ1BZVzJZZ04rSTlGcXM2RTVN?=
 =?utf-8?B?N1J2Vm1VcHlTdVBXQ2lXazg0OGNaNDFRWDJzUHhTKzBRNERIa0tnak5WV3Fl?=
 =?utf-8?B?ZGdVeUI3OVZLSFR5d3pKZzEwVHFWUjB2aXJLaTBDbnlQSzdqN0U0SVFWS211?=
 =?utf-8?B?SXJKWUl4cE5iTnZHM0plWlYyN1NxZlpTMjM5eU5jQUZldHcrVGdPMzJhZG9s?=
 =?utf-8?B?K29sYjBYRHlkakdPY3AxeG5LMzZSc2xPS08wcnlKZHFYR0NpenNMODdzcmRH?=
 =?utf-8?B?djV6blVlOUpzR0dJQmd3MG5HOUVvMzF3MWs3SEtuYkJEUGFZeHp3T3ZEVHVS?=
 =?utf-8?B?cDVDWFhBaVpDdHV4VDF4N2xkaWFPNEo1OXZKcC9rU3dHSFBNN2F5T0FDWEx1?=
 =?utf-8?B?R3RxWlp4Nkg3VlM2anlDM2hSR1ZyWGgvTlhBaTRyOXVUUkpjQWV0R3g5Wlkr?=
 =?utf-8?B?a2x0bTBJcmt5Yk8ydE4ycVg5aklRczh4ODlsdnpERWVpY2FZd3FNWm15OTll?=
 =?utf-8?B?aTF1QU55Q3lCamxGOVVRc1NzdEJPa0FLT21RaG1wNkFnRmoxbzNXdzRHYjJS?=
 =?utf-8?B?aGY5WmZLczcyditIWkI1bllJS2VSblJCaktLT3lVRW1abzdoVkJVczZ4ZFNy?=
 =?utf-8?B?TExSeEpvZ2pzY3dsWVNTOTZiRXp2c1U3T09RYlFYeEZYMW0wekkvdjBZcFpn?=
 =?utf-8?B?d2NFMUNxUWZheHBvMmNjbE5wcVhFdDN1Mmh2VW4yMkJ2L3c1MnVUUEVEcnlW?=
 =?utf-8?B?Z3Q1MUpZYjVtWmxjQ3dqKzRNSUVjUkR2cDIyRG1INmhFb1ZRRXczTDZxMDVx?=
 =?utf-8?B?c2VhOXRDalNnbnRHbWxISkNKWEM0WUNJNGJoNm5xOHkwNnNhaE5hOTdBQktK?=
 =?utf-8?Q?BhIWGFYsDr0tGh49l0Sv3Linx?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f612c69f-d738-4abb-9db5-08dca0e2fdcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 13:19:56.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YG32JcjK5DGlC1uqZWLv0SEeWUjw6X0Olr6uAJYOrXVAdHTCoVrB+8eN/gmxggDYcfA3lufT15pfQZ5lxzsf/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6259
X-Proofpoint-ORIG-GUID: seEiX6UP2xob9NTYO8sWKdDEkV1vZ0L_
X-Proofpoint-GUID: seEiX6UP2xob9NTYO8sWKdDEkV1vZ0L_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_09,2024-07-10_01,2024-05-17_01



>-----Original Message-----
>From: Greg KH <gregkh@linuxfoundation.org>
>Sent: Wednesday, July 10, 2024 6:28 PM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>Cc: arnd@arndb.de; Jerin Jacob <jerinj@marvell.com>; Srujana Challa
><schalla@marvell.com>; linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
>CN10K DPI administrative driver
>
>On Sat, Jul 06, 2024 at 08:=E2=80=8A30:=E2=80=8A09AM -0700, Vamsi Attunuru=
 wrote: > Adds a
>misc driver for Marvell CN10K DPI(DMA Engine) device's physical > function
>which initializes DPI DMA hardware's global configuration and > enables
>hardware mailbox=20
>On Sat, Jul 06, 2024 at 08:30:09AM -0700, Vamsi Attunuru wrote:
>> Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
>> function which initializes DPI DMA hardware's global configuration and
>> enables hardware mailbox channels between physical function (PF) and
>> it's virtual functions (VF). VF device drivers (User space drivers)
>> use this hw mailbox to communicate any required device configuration
>> on it's respective VF device. Accordingly, this DPI PF driver
>> provisions the VF device resources.
>>
>> At the hardware level, the DPI physical function (PF) acts as a
>> management interface to setup the VF device resources, VF devices are
>> only provisioned to handle or control the actual DMA Engine's data trans=
fer
>capabilities.
>>
>> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>> Reviewed-by: Srujana Challa <schalla@marvell.com>
>> ---
>> Changes V9 -> V10
>> - Added checks to ensure reserved fields are set to 0
>>
>> Changes V8 -> V9:
>> - Addressed minor comments
>>
>> Changes V7 -> V8:
>> - Used bit shift operations to access mbox msg fields
>> - Removed bitfields in mailbox msg structure
>>
>> Changes V6 -> V7:
>> - Updated documentation with required references
>> - Addressed V6 review comments
>>
>> Changes V5 -> V6:
>> - Updated documentation
>> - Fixed data types in uapi file
>>
>> Changes V4 -> V5:
>> - Fixed license and data types in uapi file
>>
>> Changes V3 -> V4:
>> - Moved ioctl definations to .h file
>> - Fixed structure alignements which are passed in ioctl
>>
>> Changes V2 -> V3:
>> - Added ioctl operation to the fops
>> - Used managed version of kzalloc & request_irq
>> - Addressed miscellaneous comments
>>
>> Changes V1 -> V2:
>> - Fixed return values and busy-wait loops
>> - Merged .h file into .c file
>> - Fixed directory structure
>> - Removed module params
>> - Registered the device as misc device
>>
>>  Documentation/misc-devices/index.rst          |   1 +
>>  Documentation/misc-devices/mrvl_cn10k_dpi.rst |  52 ++
>>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>>  MAINTAINERS                                   |   5 +
>>  drivers/misc/Kconfig                          |  14 +
>>  drivers/misc/Makefile                         |   1 +
>>  drivers/misc/mrvl_cn10k_dpi.c                 | 676 ++++++++++++++++++
>>  include/uapi/misc/mrvl_cn10k_dpi.h            |  39 +
>>  8 files changed, 789 insertions(+)
>>
>> diff --git a/Documentation/misc-devices/index.rst
>> b/Documentation/misc-devices/index.rst
>> index 2d0ce9138588..8c5b226d8313 100644
>> --- a/Documentation/misc-devices/index.rst
>> +++ b/Documentation/misc-devices/index.rst
>> @@ -21,6 +21,7 @@ fit into other categories.
>>     isl29003
>>     lis3lv02d
>>     max6875
>> +   mrvl_cn10k_dpi
>>     oxsemi-tornado
>>     pci-endpoint-test
>>     spear-pcie-gadget
>> diff --git a/Documentation/misc-devices/mrvl_cn10k_dpi.rst
>> b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
>> new file mode 100644
>> index 000000000000..a75e372723d8
>> --- /dev/null
>> +++ b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
>> @@ -0,0 +1,52 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Marvell CN10K DMA packet interface (DPI) driver
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Overview
>> +=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +DPI is a DMA packet interface hardware block in Marvell's CN10K silicon.
>> +DPI hardware comprises a physical function (PF), its virtual
>> +functions, mailbox logic, and a set of DMA engines & DMA command
>queues.
>> +
>> +DPI PF function is an administrative function which services the
>> +mailbox requests from its VF functions and provisions DMA engine
>> +resources to it's VF functions.
>> +
>> +mrvl_cn10k_dpi.ko misc driver loads on DPI PF device and services the
>> +mailbox commands submitted by the VF devices and accordingly
>> +initializes the DMA engines and VF device's DMA command queues. Also,
>> +driver creates /dev/mrvl-cn10k-dpi node to set DMA engine and PEM
>> +(PCIe interface) port attributes like fifo length, molr, mps & mrrs.
>> +
>> +DPI PF driver is just an administrative driver to setup its VF
>> +device's queues and provisions the hardware resources, it cannot
>> +initiate any DMA operations. Only VF devices are provisioned with DMA
>capabilities.
>> +
>> +Driver location
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +drivers/misc/mrvl_cn10k_dpi.c
>> +
>> +Driver IOCTLs
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +:c:macro::`DPI_MPS_MRRS_CFG`
>> +ioctl that sets max payload size & max read request size parameters
>> +of a pem port to which DMA engines are wired.
>> +
>> +
>> +:c:macro::`DPI_ENGINE_CFG`
>> +ioctl that sets DMA engine's fifo sizes & max outstanding load
>> +request thresholds.
>> +
>> +User space code example
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +DPI VF devices are probed and accessed from user space applications
>> +using vfio-pci driver. Below is a sample dpi dma application to
>> +demonstrate on how applications use mailbox and ioctl services from DPI
>PF kernel driver.
>> +
>> +https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>3A__github.com_Marve
>> +llEmbeddedProcessors_dpi-2Dsample-
>2Dapp&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7
>>
>+xtfQ&r=3DWllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m=3DbFx_7eltw7S
>6zzVu
>>
>+1LNEdtsbwwynJfAKTja649QUwGNU_y4uWqGoEZ4f7JluYLjX&s=3DwOMzADbq
>9f4xxz1Oug
>> +-slj_xy4ZcbrnWfQJWeO0_ugA&e=3D
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index a141e8e65c5d..def539770439 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -362,6 +362,7 @@ Code  Seq#    Include File
>Comments
>>  0xB6  all    linux/fpga-dfl.h
>>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <m=
ailto:linux-
>remoteproc@vger.kernel.org>
>>  0xB7  all    uapi/linux/nsfs.h                                       <m=
ailto:Andrei Vagin
><avagin@openvz.org>>
>> +0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Ma=
rvell CN10K DPI
>driver
>>  0xC0  00-0F  linux/usb/iowarrior.h
>>  0xCA  00-0F  uapi/misc/cxl.h
>>  0xCA  10-2F  uapi/misc/ocxl.h
>> diff --git a/MAINTAINERS b/MAINTAINERS index
>> aae88b7a6c32..2c17d651954a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13477,6 +13477,11 @@ S:	Supported
>>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>>  F:	drivers/mmc/host/sdhci-xenon*
>>
>> +MARVELL OCTEON CN10K DPI DRIVER
>> +M:	Vamsi Attunuru <vattunuru@marvell.com>
>> +S:	Supported
>> +F:	drivers/misc/mrvl_cn10k_dpi.c
>> +
>>  MATROX FRAMEBUFFER DRIVER
>>  L:	linux-fbdev@vger.kernel.org
>>  S:	Orphan
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
>> faf983680040..965641017a62 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -585,6 +585,20 @@ config NSM
>>  	  To compile this driver as a module, choose M here.
>>  	  The module will be called nsm.
>>
>> +config MARVELL_CN10K_DPI
>> +	tristate "Octeon CN10K DPI driver"
>> +	depends on ARM64 && PCI
>
>Why does ARM64 matter here?  I don't see any dependency required of it.
>
Thanks, Greg, for your time. This DPI device is an on-chip PCIe device and =
only present on
Marvell's CN10K platforms(which are 64-bit ARM SoC processors), so added th=
ose dependency.

Regards
Vamsi


>I just tested this, and it seems to build find for me.  As I had to manual=
ly fix it
>up to get it to apply to my tree, I'll leave it only depending on PCI for =
now,
>thanks.
>
>greg k-h

