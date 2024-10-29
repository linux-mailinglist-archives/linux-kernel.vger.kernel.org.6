Return-Path: <linux-kernel+bounces-387740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981849B558B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F255B22584
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320F20A5C9;
	Tue, 29 Oct 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gHgixi5b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ezF7Dkq4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC520A5DD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239683; cv=fail; b=txXSoes/kDjWEs+wNngMztH9BHDP/JyGRgfsEDBjCyKSm/V5tCdbV14HmCnDSHV9JwvJ+MTob0NB+9nXiesJZdsQfgOanu4bkmEHmKa8lwL81ZepmCxA04QujefFEMpypdadIeGpplrr8BIgb3m5jzYCY4k748R9de8H7oDq040=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239683; c=relaxed/simple;
	bh=HrYXiBAluulePDYGE+YW/SWxOqKYYaYSw7UGKZW1/jI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TUEC1o8ZC2wXShumSeSD1LDEmBFiLxuQv6PbDmrPvWORHEYfmUinAhH+730/kbhb5GdpguOWsAKPF1y5Ot+ME3tKauGIRQUwRSZjzmwGRnHZqbChmxrDnot9+OzHtSTp3/9IsQzLcmRcFVLeU/r8hNICMm04y7yQW3w+Y1O+sck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gHgixi5b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ezF7Dkq4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfdao003425;
	Tue, 29 Oct 2024 22:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BL4igOCXuqx0AUQFF1ro2H+NPKZz4u4483iLWGdMCxQ=; b=
	gHgixi5b1E8hAd8FRHdvaxvitQz1RutQiiE2k1+LgqbIVddgu3cxm6ImoVHvTWjh
	Zs4Il84ToTxCidsVlRoy9r2gMyqZ7vpkvt5wH04Ukk4EFoUkam7sXCHvnBWQMTZ7
	YZqxSjtOJZhi2vbWtz25V+YSc2ndkHZUO/bAHfKMi35Inpa2KV/ZtD+heetKJzJg
	3NiNV/GMfJmpHc5jdvGs5/RLmB0Oc5e87Ro3svzEKLlTHaQ90awrApb3TTLG456o
	xH+p6NTKUHIoQZ3/M55TZC7c7i6IpC0/0vP+De8+rpUC1MCAXuLcFVYo5Wih1oQ0
	xtrUZZYM+iieCaAJwNaVqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8xpjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 22:07:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TKOswM034894;
	Tue, 29 Oct 2024 22:07:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd8ajsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 22:07:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFeMcMpD5Yg/UlV1bc/Guw7S9C/jNN1xXfot+hR/C4bQpl5m3ubZBY+qVyLUNj7e7x11e5MHPxP2HHiWcMkE9AXizZIpA4Rq4ftH5OC9FGgKaDwwk+PEXXbzemQ2UkqYnE0ba68OBiXknJfx8ltbeyq6B86uywT07Mti9QMHdbwKr/fGjGuaHcZRAAS2W8N0qxmrbUjbpyIi07LnvQeBpDqK5ddBgFdSIjIxhtqK2VhsgZd7V8VgHPXKbJTrOM7qNEEuXgDEdrN30NJ0gNGxA9+twKSJcnX3+UwQBOwJBgh0Pxdl5pbeic0hUbY4ORJNkmYQPZXOOWG4C+K6auAJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL4igOCXuqx0AUQFF1ro2H+NPKZz4u4483iLWGdMCxQ=;
 b=URfw94CnV63XoWRx47kj9PK/Pvq0/kmYxhwyj1Y4xEwj4xp9r9+5ZzoybyQE8EkjAO7DPQyZHcv2OSJ5QS5Qn03zQMTyVFjbGMATKQxfU0fknlNTlXmlAQVTSzixuoyv3/4ih25NvDyFW8eUhQk2b/o3S70WLGbznOih9OAmkaZlPI6UyDchj6Hz0UZiBD/poMEwBRCobcPhnXYVPtRpE4g1yVtELYLzfGCwUXMk4yejm5RcX7yRwLXzfMGs80TXOd82yXfvwPgFVN0CZfe1owEL+s4yUUVdfCubUSMXJuEmxJy/44vIKU6kcZI0ZiMhMTXgapCYxCXLPSnw+jFQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL4igOCXuqx0AUQFF1ro2H+NPKZz4u4483iLWGdMCxQ=;
 b=ezF7Dkq4Wf6/kUldQnL4s8TCtLKt4gdB7c8U711BlidUmMX2jIFge2FqAQD98ny6W/zNzeZ455/nC0clxE9s2lyyX4oA/+KuucTFhgmv1rThRWHO8ABb0lW5c9dAqthAyINtBP5AaVMCnyAJns6RfMvG9rMUXG/Wv7/7k4tzk6w=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH0PR10MB5162.namprd10.prod.outlook.com (2603:10b6:610:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:07:36 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 22:07:36 +0000
Message-ID: <d2d3514a-3f7a-4367-b7a4-953a76687053@oracle.com>
Date: Tue, 29 Oct 2024 17:07:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in jfs_readdir
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, eadavis@qq.com,
        osmtendev@gmail.com, ghandatmanas@gmail.com
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
References: <20241001060548.3090738-1-ghanshyam1898@gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20241001060548.3090738-1-ghanshyam1898@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:610:20::39) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH0PR10MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: db9d71d0-d533-44ba-bfa6-08dcf86618ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWcrTVUwV2laeWtEWnE4ZzVDdCtsQW1RTmFXTGxMUnN0U0d4N1hhc1BPWnNv?=
 =?utf-8?B?NGs2YjlQQkpsOE5Qd1hxYy9DSjU1dDZ4QnBLSVhQSXVuMEdJYXdZcTFrMVRw?=
 =?utf-8?B?ZEJJaHNjbHc3MytldmE2OUdieFBVcjVlTkd0TzBydGR2S3ZmZUdEdEJ1N2tN?=
 =?utf-8?B?WTVMMTNkMHFsU1hjbkJCRUc2aVIxQmRESnlnQmxBNmRLOE9rR1F2aWtkcEtD?=
 =?utf-8?B?YStVamVuNE1YUkg3QXNoM0ZDaWVDdjJobnN3aEQ0akRPWXdjTDQvdGU0alRS?=
 =?utf-8?B?OVFqR0JTazEvTlYzY1N6aGVYbUNpY29tK3RoTHZJRmcvZ1FyRU9NS0JuNTN6?=
 =?utf-8?B?YlVMa1k5Y1BoeERpSkhxbldSRC93SDdZZlZvZEhrOGxtV0I0bHVvNTZoTkRo?=
 =?utf-8?B?OW5uK0grV2R6ZGsyZFNEU0ZiMzNRbWd0NmhIenhKbHBzRGx6MHkzU3JTeTZv?=
 =?utf-8?B?WSs5M0FHOFRPSTA0TE1QZTlQNjNQN3B6OHp0dmsrR2tsaXRqaXdVdVBCTlhv?=
 =?utf-8?B?UmJqczd1NkFscytQMEU2N3FOOE15T3lnV1RwUzRCSjR0eGxkaENHRnlyY0M3?=
 =?utf-8?B?U2FYdDA3STBzQmVoeWdwZitUM1RVL3JzQXFjclRXYnZTaXpwdXM5bnFwQ2li?=
 =?utf-8?B?TFRPbGlNN0h4cFg0elFiQXpxUmRuODFsdUZaQnVnUTNyUjBSWENaNkFuaThP?=
 =?utf-8?B?OXcvNnB1RW1IYzE3WmZWblhiY2tDYmowUjJ4RVdob3kwZllxOWpaSkNIV1p1?=
 =?utf-8?B?K1hDa2JSSnB6VVU3U1pqV3YrZkxMWk05aWFyMmRJYXJBTWtwVThpdWh3K0ZD?=
 =?utf-8?B?UExZWkp4RnRJOWNzck5sWUEwNXVCNkhkaE8vVkU0MG5kZXY4bUV1MVVFUEpT?=
 =?utf-8?B?VE1RYUR1ZEx1M1c4Z0FHVmpjTUdDT2xNeURKY0JvNWJxbCs2MjRpZzBxTUxI?=
 =?utf-8?B?KzlrM0p2aHBLWUdtbzFueDJRdmRRckxZMEtoeFV2RGVNMmkvQkI3ZUFVMTVN?=
 =?utf-8?B?Qk1LL2NmVVBXTlpESEJuWmxrVXBMZ2pnQWRlNTR4d2txdzFtaDVlenJ5dFkv?=
 =?utf-8?B?bWMwakhacnlpZ0ViU255SFdQbFhFdmJLOWhmZ2RTbFZ4bUJVZGlYbjZ0VlZN?=
 =?utf-8?B?Z0Vid3l4UGwyVVkvSVY3Vmw1MnJwWUtXY0tMaFR3dWJPMktVMmtlZnpoSzNu?=
 =?utf-8?B?U2lGcnl5WTI5VnRKd0VHNjJJd0pyVTF1TWZpZnd4TzJPaDZKTnVjU2k2V2Ix?=
 =?utf-8?B?c28waUFhRi9lMVdxbUo1TkdFSE1uWllmeW85eDdBRG1wSU9zOXdmYWNQSEhs?=
 =?utf-8?B?TzlOSjFVaC91d1gwY1A2WVNjOHQ4RHd5YzZUamFDaG1lQm9pTWFGVzNRamoz?=
 =?utf-8?B?OXlSaUp0eU9nSWxmVDhBbjYrTkZ3SUFES2pzMU9TQzdnemxBZXlGNXFkVTJ2?=
 =?utf-8?B?S2IzN0ZML2JRREhxWHVlWlZJY0F5NWh4WFc0Wk0xYlNNZmY2NGJWbS9TYVNu?=
 =?utf-8?B?YnpwQkhENFZxWHArd01aOWplbnNCaTdIZWE2Mi9LWUlvZ2k5c3AxdnFJaEUw?=
 =?utf-8?B?K1gyQVphMkJZTW44VklXK2Z3Qnc3WXA2K05KclB5L2FicVc4RHZPWU9QWURP?=
 =?utf-8?B?bUh4b0ZYOHdTSUJGM2tqTjVxVXNHWWMxeFRmTG1yVEsvbVpKeEJOdkw0eWFu?=
 =?utf-8?Q?AdZJoKS8DOBYwTZ1D3Ae?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejV4SDlteTRLcUptakhWRTRrRjVNTUc5VmdhLzMrSlU2a2hJazdWRzRCOEwy?=
 =?utf-8?B?YytpalNDUmlDOURWZWhlZUVoYThuOE5JemV6MWlUdm9JT0RVSHZmckF6dE1T?=
 =?utf-8?B?dTA5Z2JUNWhQWXZGcHh0L3BlNTE5VHVpUzd0NUU0ZG5odVN0aEdJdHFKN2N3?=
 =?utf-8?B?ZmVNS0xQRmR1NS80NS9nQ1RmUzhkTkcxalE3M2o1YzhOWE8wd1BLTnlRQmhS?=
 =?utf-8?B?RmE0OHhmNDFzYVNWMHdPWVN4Uy9obHB3Zk9sNk9LN0JTWFdsa2xoWGZJUGFv?=
 =?utf-8?B?OXk4MTJ3QnR0amlTK1pqKzZJVVVIRXByRWJDbU1odmNoSHErcTFadjhuNldp?=
 =?utf-8?B?UzNuSDJLU3ZBWHBmcVQ5NHhWYVhreTZoUEpEYUViUWs4RjNhaHBEWWM4SjNv?=
 =?utf-8?B?RW4yRVRmUlpEQW1JQ0lwY0xmVVhteUtPVmx1OUpIY0JhaXAzTnJidFlJYUQ3?=
 =?utf-8?B?Ly8xVTQwU3hNQ3dTSjYvb3F3cjRyUEFyS0RRS2ZXMm5TVGZDUEVNMFJGQ0s5?=
 =?utf-8?B?VnY0SHFwQktqQ0tSVzA4RHhuRkZmTXp1Yml2UWZFS1ZRUDhrd3BFQlVzVU5M?=
 =?utf-8?B?UHFTTURsVDJiaWpWeTFhMU1VL2d4TkhPWWFPQTQ3S21WVTIvZDZnbWJHQS9T?=
 =?utf-8?B?WDBwcDN2TXNEU0V1Y1FGQU4vUkJBL0Uxb1pHRHVPaURqSmdpcVpmTU8zWno1?=
 =?utf-8?B?N1Y5TGtqaTdCNysrQzRaaTNSanY3R0dXbkdjOHcrYW9OTjJXWVp5WFZYeUZL?=
 =?utf-8?B?a3VBY2dQdFNsbDNsTWJsbjIzQ2Mway9RRDhYZ1FtUVk5a1pzNXBvQk5Zc1Ba?=
 =?utf-8?B?SytlaWVvOGNpSE9mUEI3eGord2hJM2dhUUdZeW1lZkU2T3N4ZVRvK09lblNM?=
 =?utf-8?B?T0VNbWZGbW0wTVVSTVBadWgwV0dITDRiT3hhSVlka0hkYktrakg1SnJWYWYy?=
 =?utf-8?B?NjdVNlNGWi9hN20zT2lrVklxVWU5TExhdDNjSUVxY3ErOFhSSzh2eWcvS2Rm?=
 =?utf-8?B?VlpKcHZ4S25qV0o2eXJ2TjZuUE0rQmFRUzkrbFBTWm9aeW1nMW5qZFZYMTFn?=
 =?utf-8?B?UzZSclNHS2s4SDQ5dEtWK0F1b2RLclpnMWdJclpRaG5va3hiRmx0c0pUaWNs?=
 =?utf-8?B?bSsyRmNiNTV5VjhzLzlXaGFrUXZxb3B3NFdyMzZlOEtDTjJtckxKUEFoTy85?=
 =?utf-8?B?MFJyWlRBM2JUODQrNlpIbmpRdmVsd3BVYXAvZUlhUlhXUGI4SG5WUGtYWHFo?=
 =?utf-8?B?bGRaVkdRdVN0VXl4MitJOURRT0tHbDhxUzY5SWJjZFkrd2NOV1REVmRLNDl4?=
 =?utf-8?B?eFVMNUJ5VW5UWFRhTFVVdTkxRithK2VjWTk1SWJ6cVlXbktwMEkraDhHQXlV?=
 =?utf-8?B?NWljcFRHdktYT0pQQkc5Z0x3N1p5bTAwZklEZ091SmFONFJaV0U0UEYyTVBY?=
 =?utf-8?B?N0E1b0IrRVlJcGpHWjRQMzlYODlXMlFyeHF3SW43YTVKNlRnSTRGMkMzMFZi?=
 =?utf-8?B?NTd4aUE0TVRkMFdPWGtrZHBOczVHZWIwdHJUTllGTU1FekFNZmdGUTZEVTE0?=
 =?utf-8?B?Vjg5Rm9EVENpbzh2Y0xjaW1BT3hVelNCSUtBekRVb1dNdExVSXVyYUZZdlJx?=
 =?utf-8?B?YThLOEdNYkl1bDNmZlNFaXFnRWpxMHV2aXRwalgyb1FqRGhEOGtVanBsdFhB?=
 =?utf-8?B?clNpcmpFcW9BMU1EdENQTDk2eWEyK0RGOGxJdVlIRm4wR0xkdzBnVHFobzJz?=
 =?utf-8?B?QklsM0VqY3RMSVliaHRuakg3OHd5TCtHVzR4QnBvbjg3Ly82ekdiUnFrYzI1?=
 =?utf-8?B?QXlWVUdUU3JSWks5T1kwV0svYUc2RTFKSTkybENwSm9GVFVXWjNyVTQ2TFpy?=
 =?utf-8?B?VG8rRFluRGJjRWtXVjBoeUpJd1FUU21PVmZxcjNUODdVTXppSjlEbnlETHg0?=
 =?utf-8?B?dmYrZ0wwTm9icElvOUFVY2lkVFNBcE9WeHIxanBnRGd5bm9KbGJMeVhtSG90?=
 =?utf-8?B?WTdpUFNMblBkNDN3U3NrMjdwREhMVXBOa3pwV2RMRUk2RTJ3ZFdVWGhaaXBv?=
 =?utf-8?B?eHdlNEV5UGhsNVRCZkNqY2NkQWppMTZNOWtWRENvSjNFbngremdscnZuMTVu?=
 =?utf-8?B?U2txVU96TERwZzk3NGN2ZnpZZkY2M3lTcjhKR21SelJhbFhsd2tJT1k3V0lF?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Thp7Dp9tUn95TapmKbHC2KhGcgWDROKtIiLo5nsTFeFk/uiFtWIqPDlQdn+4CPkN0t11gR/yNxENJP+U2X+pCZC28K/CTmKNj0RGXh86MPTIgfpk5cnMRBwwq8udqtvwTRXW6PuWnoWfqK43aGAJV1hXOvJAr8RRDgPRSWTqH0VY+k6IXxO7Fa0hnYTVTI6NDhKb2cNZeCPYvE2iAFw3mxlKQ4VX3wC5MMvuKeD2UVoGcTHDgw+2b5DsuwBiLnTny+4AbajXGZB6cNnytvL9jSzU7GdUqyrLjm6v4Zs9sBkFyS+pZWosQ9nMuUm21us3YXNPyPjHYNNdce7vXC/mikLyG7qIi9A8hIivj2c08Cuqa2faXsZcnyHlHKg76KXmorGFfuxEXNUU8Rlpq++S7bVB8xTZ9H4z2lFleDDAUy9Rv5ngGHnD939pErGZKLpN/puVrtXYVqJyY1PX3wCnc0PVu6Xb+Yx0FmQKtVLAYD4LYj37qf9WIFQ4kny5m7eNyXDtDdCTvDSHvaTVcVZQyA914dA7p8PiXqiCMY6W/6738ltX7IJ02zGPFXi/a45IWW8GwBCPLKp3VF0xiJTkYOfmonrSaaTQtOYM0HDtX8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9d71d0-d533-44ba-bfa6-08dcf86618ab
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:07:36.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/03zKhgjglWkhfJN8TjTJ8QpJLI2fqQhiVSSBybLr7hOJltFfsGjlJ5hk8PlTuya+x3BuPlZuI3Ca+AdXl0js5qd/MA3Tprbx4/xe+Mmmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_17,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290167
X-Proofpoint-GUID: cHTPkx4XxpFlGSV_GbeUawvOiJKmydkj
X-Proofpoint-ORIG-GUID: cHTPkx4XxpFlGSV_GbeUawvOiJKmydkj

On 10/1/24 1:05AM, Ghanshyam Agrawal wrote:
> The stbl might contain some invalid values. Added a check to
> return error code in that case.
> 
> Reported-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0315f8fe99120601ba88
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
>   fs/jfs/jfs_dtree.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
> index 5d3127ca68a4..c8f6e51ac047 100644
> --- a/fs/jfs/jfs_dtree.c
> +++ b/fs/jfs/jfs_dtree.c
> @@ -2891,6 +2891,14 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
>   		stbl = DT_GETSTBL(p);
>   
>   		for (i = index; i < p->header.nextindex; i++) {
> +			if (stbl[i] < 0 || stbl[i] > 127) {
> +				DT_PUTPAGE(mp);
> +				free_page(dirent_buf);
> +				jfs_err("JFS: Invalid stbl[%d] = %d for inode %ld, block = %lld",
> +				i, stbl[i], (long)ip->i_ino, (long long)bn);

I'm moving the printing of the error message before the call to 
DT_PUTPAGE() since stbl is part of the page's data. And I'm fixing the 
indent.

> +				return -EIO;
> +			}
> +
>   			d = (struct ldtentry *) & p->slot[stbl[i]];
>   
>   			if (((long) jfs_dirent + d->namlen + 1) >

Otherwise, looks good. I'll be applying this one.

Shaggy



