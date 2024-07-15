Return-Path: <linux-kernel+bounces-252728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3259931764
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5077C1F22251
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3D018F2DB;
	Mon, 15 Jul 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBJr88cg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YZyU6IZD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A618F2C9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056453; cv=fail; b=fB9YF/MxRz47N5fCczFepMnO/H4xx05FTEfkyWNrzw8W6BqBoGAUDMZA2zpd8tKg4oKf3v//298kB67cCEDDIHGVwjmdPqq0i9477f81XdRzV+OY+0kt/Uw1dupjQCiGligSkhi9Mw6H9ffkdUexeHpKVS8o2yrTAgMhyYc8+mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056453; c=relaxed/simple;
	bh=LZ1DxPaPHKXZG3WzT5TKt8oDrpaYPYbGDG3fQ4TOGcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ec1EY2n/1w3MwveQa9GPRciI3X5Qjv64UMEnY5wWzkCuGf54dLgEVrCF03ZCPsQRoPqxmYazShm9pJzPkOWjJKZXDkMrHMvzjUqvsMKYY3zKgpFy2WgN2TdkiObRWoG6xKIdLJP5bpteNvRkr4xu2zcNNx+LadXYO4cR0t/0NQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GBJr88cg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YZyU6IZD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENbET005766;
	Mon, 15 Jul 2024 15:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=vHqfQRBKeG4jQ9+
	Pk+NPTFH42TQTlodx7GS6DLWd4DA=; b=GBJr88cgQ7bjGuqszUV+eD0aXl5EcVX
	IpKbJ3qIl6Nd/5zL/1honKbCvqGrtQHuQ/Ar4J+M/eTES1wzYZqedrYIvlhdBGMy
	CHx/kKMN04ckflLDHcSTCLM6LfwmyRL0HntItTn2zH0BOOHJO82ZaSCVP9Z74Wj2
	OYG/z6+czRwfBskJtI9B/aQ+VfdAK8kS7uekTuvUy107Kv92gM35DgNZ2+1ExA0Y
	RWNGomdnNwgPJalvflAbx1viPgQCxtls2dDCB5LncgVFsHZzXML0q5HI0wPrnhhE
	M5fyhH0//CLbNHMFm7tRPiTkkq/f/xWVdLbQnFZbYXY/zXfO29Zb6ag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bgc2br8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 15:14:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FF1iJb010679;
	Mon, 15 Jul 2024 15:14:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg180fa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 15:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSUGQpUN5VXp7B5KAV62Cp5fC0M6ipj1Kv1qvtqegXt4GXkcIQJHj1ISmHfz2vkPY1F3sX4cY3DRbFwaRYoKCn80EsT0acUXI6skbCuqpGpywILEsQbR6MaXy9WzGMEvvFPoxHLXKpRcSbjkDD2H23HyulEo4c3w5zGebzdX+wWHB2Mag3jIKVatGa5oevCdWBXTlWXg6Xl+shG7AX651HAHiwmJ+umcpYvxa6PV/RChKgYGrCQ3VBs7maiV3ZZ9qn+7XVnmKHhTmHsfiKcUezgG2fvrLLwzTA2WKuVJZg4gyRIdGHPcV+D06m0rNNH76kmsFpQmPPyh2fppxUFjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHqfQRBKeG4jQ9+Pk+NPTFH42TQTlodx7GS6DLWd4DA=;
 b=dDEYWRyA94r5eNDO2S191zVexgCCkfVnOBhXDPZkslkMdgTJf7swCGLF0HE+h2fsocECsmEj/fc5z2mM1Er6jAsXkQ6t1rtAWmlWivRz/hu/Bq52/t9Pa/urUat6JS+MwCoI1UdWP7x7gfvyDFFy9n20gDbjNyU+4BbGf489nhqV36LMogZ3/i4178TYcYUcqn0rT/6770XZZPVItbi7TvyuE0XVVkKwWIQqJXEjWor1/4NGP/TMJ0WUvAvrEk3BgDKrGfXWyi52gWyt72hc9LH1MgICxvW/S/rXlsIAfwXj5+wXW54nILUC7SkUnj/k0AE1635ghTt/P6ocZo3FBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHqfQRBKeG4jQ9+Pk+NPTFH42TQTlodx7GS6DLWd4DA=;
 b=YZyU6IZD1QCUpVTmSWvvDjA+ooWaDWTz2nynigj4Qnw24yDoSXIVb2PM8z4BfluQ6SuXp/C8TScOUUsnK3RYM9h8SCtnZ/QD+YN4vLoafE1dP9UoYLSG2czR5hUpYLFBOZC4nRENqvsva0d2Us++mQ4ihliSclJGtKXhrV899eA=
Received: from CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6)
 by CH3PR10MB6714.namprd10.prod.outlook.com (2603:10b6:610:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 15:13:59 +0000
Received: from CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc]) by CY8PR10MB7265.namprd10.prod.outlook.com
 ([fe80::d299:36f1:493b:33fc%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 15:13:59 +0000
Date: Mon, 15 Jul 2024 11:13:56 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH UPDATED 3/7] workqueue: Remove cpus_read_lock() from
 apply_wqattrs_lock()
Message-ID: <xesrnvzs4xahy4473mp5vzxemjdtrci457x76si6gqbte3xx7k@ubfomqay7tck>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
 <20240711083547.3981-4-jiangshanlai@gmail.com>
 <ZpASNBN0hpTVcjE-@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpASNBN0hpTVcjE-@slm.duckdns.org>
X-ClientProxiedBy: BLAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:335::9) To CY8PR10MB7265.namprd10.prod.outlook.com
 (2603:10b6:930:79::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7265:EE_|CH3PR10MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 57694964-3300-49ed-064d-08dca4e0c0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ixc69lj3c1AQ/8/Bni8LA1VggcJnED5GW0zqjRGDxFCiMWPlklRiN9Vx3WUP?=
 =?us-ascii?Q?TP8xGPtnD7U1V69rBn7Y6lmjELVv+CNwF/3tblLlqFv1H/5l6F2pxK6uPV/x?=
 =?us-ascii?Q?sUc0WjmYZnWhZR34LJAYbr5iAOL5lTWzUP9hvYxn203IlMWtWgzVRI9lH0wF?=
 =?us-ascii?Q?p/HBiCmqr3/9LA8VaDtnMixrUGyu17YxJr1NV2O80mR/S9LRhfrNiFAvgcRm?=
 =?us-ascii?Q?3H2RcsD2xR8y+tdAqNZo4kigx4xfD4vpzAzoBD3hBSv20q8L8mR31j7ZGDQy?=
 =?us-ascii?Q?w/CGN3ZBCTTHht5XHmMtjfytCkegpFHK1qzXC/B2bS4DhaNPCBeQjSFThCgr?=
 =?us-ascii?Q?oQLE82dFLVYgFZnl6tfIw8U6Ah1S7X/i9XGQD/Zb2JvIvxporv2FmMLl8g2Y?=
 =?us-ascii?Q?Limc6jb+Mko3ZTbc1fMgSpfrS31oKARlJ2rp0uINmxt7SMnE1uIM4SmU8uLd?=
 =?us-ascii?Q?/qCZbe9JhJKmBYgI5tE44xGZLoUFoVwiG7WMiM9fErpx6qq57shnCnYyvTxG?=
 =?us-ascii?Q?ooNMkLC6pOYDtw0xuXxj2YnRpg/Hq+eDOJwk/sxibS85vSZZf3ZMvJyuXuBp?=
 =?us-ascii?Q?zOd9uZuakFka8QML8ENyUlmwrQpuFH8TKR+XRLivlMhpcO6MUFjkR30zaxVM?=
 =?us-ascii?Q?TBt3YDdGIlOwVz+x5TO8/kDDvGv7kYag94dfoyoUxVZWRmIKh8GSDA+GXPXG?=
 =?us-ascii?Q?XB5pHifcwE8K5eC+KfkK7Fi3SlWhkEv+Wk6jOhAkkuevwAix/+TZKBEUe2pE?=
 =?us-ascii?Q?ra47YosTULfTHSrRxHzjDhbcqrYzDQ7/UD8b13TTju6zX6h/FeM+30aOysu0?=
 =?us-ascii?Q?1CKdRt53McaXGhDh5DzLfdmd8GX5s5nOjzSvoL+pMPtJOqvoHZA5y0o4zWIU?=
 =?us-ascii?Q?IcPTEubtlKrQa4NxfoJd50saacQzTZE6LGLB4KLUX29RvFsQHWmCB+x/t5uo?=
 =?us-ascii?Q?i3Caw6s9xst3t3s25nkHjUrNNzBZeRD0XX6AWzGCYh5gIp4xKXFQlMjXYZVm?=
 =?us-ascii?Q?VzAsaN+682hSQwMMgpm65lWBvh+y+7nfSgFK/q+3t+Oc/Ud6wiCjjd08gkAE?=
 =?us-ascii?Q?g6OA1iegPui5QKrNmeZIRpy695les2c3ujE/+Yz+pZJQB1ElFhiykjju/X2O?=
 =?us-ascii?Q?bTppo/JfCaENxIQsqkMdalf43moFiPLRzSCbLnxSAld6JsO+0ffqp+FTmxPD?=
 =?us-ascii?Q?/iVtegCyZk8nfB3B+7h/yxI7lN/9XxSBKeIleOuyltELCMEE6Hb/k1hdxlJ9?=
 =?us-ascii?Q?wV5YNgmW7r5SrYPXOb1BwWjex5/kg9JgGvn8E/ztrAzuufHOfrdSA3mcP0S6?=
 =?us-ascii?Q?mD2lgyX9hc4K4qdztO4ttT7I/K5uk+b9JJxTeH83z64qug=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7265.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?crMQstZOeX2CLht6EqSB8PRos9lsrUk9BLVofh/7fNfaa6NWmfiJQFu+w6hl?=
 =?us-ascii?Q?b4pZ9YnNkWjDP8NSh9TboHSM27RvtxaiOwOgfYoQmK6rt9k9jPGp06gC1BdC?=
 =?us-ascii?Q?eJcWuKb+h4TXLp69wReIoTuHOBFgQgp9kRYindGp3LbHym1d4SV3mLfA5uXB?=
 =?us-ascii?Q?KUnTdiaClRWU7bglhyB2U/ryqPj7QyGVm5hRQNMfr+PSeZaRwjMGyDcetAjU?=
 =?us-ascii?Q?EjSccQied+IbMJBOf8PRUtJdh26lnKZ1MDpjMJ9N4zy88YJSk2St5t8ZAWlg?=
 =?us-ascii?Q?nI9Sla99fHNGLa7c0yyaOsZ3kePTu5SVeBDOWx329yTpEWYqb3qGN8TxIfVh?=
 =?us-ascii?Q?C4TFaRns5lGHDF1tLonsIzyhWEUxVInEnNO/5KlQMIYuPU03x51KY9f54sZU?=
 =?us-ascii?Q?VbguUM61UgOmIeOVYGFzQ7UCUTt2KbclVIaVV370RxVnl9HFt0FeX6e3pak4?=
 =?us-ascii?Q?UMKKMh0jeflt98bBZyyt1XfIdMWZbMO1AiFiqQhkWpbs8fw4IU13Al5gxOcz?=
 =?us-ascii?Q?dEby6hbazSte/ZCYkdO6+kVncuPvoGZZ39dj1HnbLJUmcuwQMVbaCzmI1M02?=
 =?us-ascii?Q?ChL5U36QrJ8DPYeuCzaYfTf7mhpsJ5rwbQBAMMYZjQoNLjJVuc9KMZiLbwtZ?=
 =?us-ascii?Q?kom46a21H+QKYKWcHZGGtGYuAiAdUEhxWN1G9aXDUFHBflQUfUaxH0mITHfB?=
 =?us-ascii?Q?beMpj4uPRUiViWwfaEwkfjpYcGif2owUbC47DRiwXGiKQjBlmqrFi29SkmKs?=
 =?us-ascii?Q?u29iqC8WVEiZ4unoquKY+zVs6ju2fid9zmh5ZGoP4KLYgQ2yX01Tc9e89ZoW?=
 =?us-ascii?Q?X4oJm0S133V4AUkd6MIZA/M1PilTZzHC9Q/3cRfMsMsS+xB61BU8Bj2gNyWL?=
 =?us-ascii?Q?iHyqKkgEzdTDGnQ86PsECYD30ekphoRNlUmHczHudZ3gfK23jexQEuGwtpPD?=
 =?us-ascii?Q?qXCAg/GSQERgqR7+PqmMoCt0r6SdYl7jBr11R06/oWKT7a0LAs3YzMy6vZHb?=
 =?us-ascii?Q?Dcs8X3aELc+tDqKfUKrOkJbPFlqY0owa6rSxtpXbsyGzzHxH6p8uNJKJUsF3?=
 =?us-ascii?Q?M9rOJ3sqA5I86zU2AWbGmIlkSVaKwj55kx8UdQxmTAoTE3VJCC7tX2rmmFty?=
 =?us-ascii?Q?3mihzvFsccEe1VQS5G2tBCWylrBmOme9hhdxM8BwVFUbNlUmd3o5ln2vNVgT?=
 =?us-ascii?Q?+ls0vCory0kQEpyNxTPBTvXzVi/TzzRH/YdAFDzdW3Z89Opa4BsZvhartzJ3?=
 =?us-ascii?Q?beSqiS7vqmbocSncQ49yfR5pOEyj3Fpn45lNlfi82A/dw5TaGGQ0kwm/JTYS?=
 =?us-ascii?Q?o06crVSYBckwQ0ltGVA+iVgGN6+g1bzidixI9K0E/Qx5DwQGYSj+SuImR/3U?=
 =?us-ascii?Q?U1XSUy0Es6rcrZ3yAD1OWzPUki/a/wqfIPPtQtmHV1htt0sd60L/pCMttsdi?=
 =?us-ascii?Q?yqc87LDC4xSgZsqjyDeFlWG9HUWTRTu5zcX9baRrdvdR5/EO3nUy7ZrOKZ3u?=
 =?us-ascii?Q?LAJSAhNR6rZLGx/uxjQoHLVvb/ePTP1Hxl4fvVZjrXlaC4YIwheV9SU4VnNx?=
 =?us-ascii?Q?5xgK+QuHclezanECj7ITLA+bnhQzFqXf3cAJQjiT94RKvbrCCSAxmC24XmUs?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YNt2EV3J9sFqCU7vRdCnKqwZwU8XAhrxQb0lHYYHM6q3x5opyWHPU8u+Rm8bxu7ILt/BdesA4OHUZwGWm5EPu2PAnAQsywoZqLyysDLeBsqK/dSa+LNbQBoX982DA/HNnRkyUtTkqKOpywh7arOk7FPzaE4BHTF3hgswDppsyvDu/OK2xHNyavOp9ex/hROgL7r2IEDOI3I2UzZYzbU61b1jv+/uZXYOndDk/ck2xae5RQ7XwhMsjKwM8C+GTgBSKJqi7xxbPk6gE9XKWaJtoJmCUeQ7BZ3DkG5w45iQHaTbCiF1d29la90IPuHLf1yaNX23luetkSf2wg9gyqdE1jOLEJu0opBji4ELx5MsUvkr/eZ+7Lvqbvlw81NJFmkknJW9MKlhw+jwJ08KfyuRKDoItN5Qejbo/VmYv2TiOEdX+XMpQq2l4ESG3vHgMInXyTnFUpCJPeyflbIZrN2vE+12Bx3P09U9nNzZVt2rp43PYLJ4gXdeXq74KZJiVsmiozY96J0cwmbSZMSspHMPR2PwOAMw3HyNblNboxlU9hF7wGs+MPW48xNdKXxNvrHPQykLecpAlbwPrMMsFwXd8JBtlN/TWvr4Y6VY/hHuWW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57694964-3300-49ed-064d-08dca4e0c0c5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7265.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 15:13:59.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X74sPn7RxmW328GDQasSWsBgfNZ7AowG9f9uHC718Jr4N428F+J7VF/jGs2aH17x9rQtRPUZtWH/FanpkzP09LNmoH/R3Js0ov84cNvs9us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407150120
X-Proofpoint-GUID: 5GsZmIKy9e_sn-vpBxlSvVEnoB57PW0Q
X-Proofpoint-ORIG-GUID: 5GsZmIKy9e_sn-vpBxlSvVEnoB57PW0Q

On Thu, Jul 11, 2024 at 07:11:16AM GMT, Tejun Heo wrote:
> From 49d94fbe1f8c275c793e298e8a38278e90029cf6 Mon Sep 17 00:00:00 2001
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Date: Thu, 11 Jul 2024 16:35:43 +0800
> Subject: [PATCH] workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()
> 
> 1726a1713590 ("workqueue: Put PWQ allocation and WQ enlistment in the same
> lock C.S.") led to the following possible deadlock:
> 
>   WARNING: possible recursive locking detected
>   6.10.0-rc5-00004-g1d4c6111406c #1 Not tainted
>    --------------------------------------------
>    swapper/0/1 is trying to acquire lock:
>    c27760f4 (cpu_hotplug_lock){++++}-{0:0}, at: alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730)
> 
>    but task is already holding lock:
>    c27760f4 (cpu_hotplug_lock){++++}-{0:0}, at: padata_alloc (kernel/padata.c:1007)
>    ...
>    stack backtrace:
>    ...
>    cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel/cpu.c:488)
>    alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730)
>    padata_alloc (kernel/padata.c:1007 (discriminator 1))
>    pcrypt_init_padata (crypto/pcrypt.c:327 (discriminator 1))
>    pcrypt_init (crypto/pcrypt.c:353)
>    do_one_initcall (init/main.c:1267)
>    do_initcalls (init/main.c:1328 (discriminator 1) init/main.c:1345 (discriminator 1))
>    kernel_init_freeable (init/main.c:1364)
>    kernel_init (init/main.c:1469)
>    ret_from_fork (arch/x86/kernel/process.c:153)
>    ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
>    entry_INT80_32 (arch/x86/entry/entry_32.S:944)
> 
> This is caused by pcrypt allocating a workqueue while holding
> cpus_read_lock(), so workqueue code can't do it again as that can lead to
> deadlocks if down_write starts after the first down_read.
> 
> The pwq creations and installations have been reworked based on
> wq_online_cpumask rather than cpu_online_mask making cpus_read_lock() is
> unneeded during wqattrs changes. Fix the deadlock by removing
> cpus_read_lock() from apply_wqattrs_lock().

pcrypt/padata doesn't need to hold cpus_read_lock during
alloc_workqueue.

I didn't look closely at the workqueue changes that avoid this issue,
but I can remove the restriction in padata if it helps to reduce
complexity in workqueue.

I saw the recent wq pull though, so if it's fine as is, that's ok too.

