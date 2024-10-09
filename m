Return-Path: <linux-kernel+bounces-357548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AD4997268
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595691F22774
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B1F1DF961;
	Wed,  9 Oct 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l7aTmpXW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ft50wGWw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA051974FA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492898; cv=fail; b=E+/sDQSyb3rAO9Pv+MPmB2Z8Ail5u3UJWmy/DzIvvd/pTXZqZ/8VDlbozuA6FffMrzrewPCOmuTFqWY06mf4Fs4ytUmSFN2TGJHbfVpcTMIpOHMgSEoIk4GzCtG3s1/SlfUzmu6ndCT2broN8sRGfSPPnZD+LI5eutuFcSCZ06I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492898; c=relaxed/simple;
	bh=c/1eVAbupJtRXu4RcJxi+9MpewfZhwByuoXzkX2Sh4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XnPahGGXI/Qk3KipTkvcSAZVs6F2mKnn+Dll+WpuoDPK3oIfhd3KiDbVhrvxZc+ZpMckM/fbfE04oiBviaqS501G2qNECfuDmkHu28JwPXk75OSvsMEGGlOCZlHP1rQZqQGuYyeimuszWtztfSCvat/bLSXY97Bkm5MBtiN2BmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l7aTmpXW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ft50wGWw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBaf0013514;
	Wed, 9 Oct 2024 16:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rRAQgfg5a1tyY8ds0elwW6Xnqn5KrklfeoY5dztdxeo=; b=
	l7aTmpXWa4ezS/SYvI19nsvffhNDEwKfq4iXeUIKCZfcD5ErseCEUvBRVV9U19JX
	nmri4T+XcvZ1sjJCs8YRgC31fcVJ9vJDggseGYsy/l3IpGFk6MEjgusQympl3MLz
	K7ibrvA0chZB7tM2bU8ZqDDbjtuMHaeiai2d3IdHGfu11Z0pp+A0Zx8NJRBcrjSE
	0XvWedQUzPepLt02uoLRzLKdRg7xd7bBxgKVLinoxNKuc7T60VpOOYQDWMBh1ySv
	ys23trrRsNRUePrQB3ffWDeYggxcEasP9pJxyAzL1w5lg8a7ZAtlSB43X+4jLOzA
	ITxtU18qgzPXsshsUeowYg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e0w6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499FMRtV022992;
	Wed, 9 Oct 2024 16:54:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8vdwq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fir0cLzmW5YY0icYp4hUfHLDgwouks/O/3TfEinMfCpbZKPARrCYj/RM+5TjuouScZSgmjazQzyu5oj1XpuZRI1poCaYObtcSeN1hxon8Ocd4tRAHA8YMZlLxiKxSBGH7VONBdshJq1Zh2XFTexN+yK0bXbk+36WrNXKsqjUxBXHdkW1X52k3yAWakjHhiYWTqWzi4AJSwRzrui6Ga+t8KxulS/n8qAHjy3GavqtwAiP9ts7UP8n+YFdVYVuYEXmjTL0/9sBaieuEZ3zytZV4Q/CoFQyP4aVVzAUtaWLBNm77/09b8buamo8lURMse1ETkR6Q0lcR+F0A3n3fiVlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRAQgfg5a1tyY8ds0elwW6Xnqn5KrklfeoY5dztdxeo=;
 b=KVuWhPD0iKqx0XD9LsaP+MVCYr7vpnmTnYNySPJS6wap8nM1mmomxCKdnph/tmw4UvpzpPCOoeHQeqLIvYH1kUKa7+BZqeYcqqH6pUHzmtcoAdvWHZFBawf/KaVpuzpU09B9Vc8kVvAHs/69q228fcHH7oF1RfudbD4aXVf5zK6or1vCYiGRrW8aSKC7qYQ+nZ36gKWY7mVeOxOC+Rt6Qpv52ku8GwJ1GAYRPXLLXnh6bhuZ8Ta+6rECgCi+8UdgX8hEJZfVpD9P20H9IMWTo6wHnIEv5vMB/cNvAVdhHWoDps6Gdh2PdjfOzJv70UpHAXcBJn5TuVSGFyzlkYiYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRAQgfg5a1tyY8ds0elwW6Xnqn5KrklfeoY5dztdxeo=;
 b=ft50wGWwI86LUMHy3k1Fh656FxL1EAUVFCiLHKeWgoqjBkPWC2xtUOW/sphzlsmYN6zI8G+D6bC3ASP4XdhAlLhewxd0DbIC3bE6k1T8JGoQca7QP8iaqMCoxiclOMNQ7PCE9MwSVwTT3fGGZRNx1yziJr5ti9IABHX3Ih5I/s4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL3PR10MB6044.namprd10.prod.outlook.com (2603:10b6:208:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:26 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 5/7] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Date: Wed,  9 Oct 2024 09:54:09 -0700
Message-Id: <20241009165411.3426937-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BL3PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0897d4ff-f2d2-4e15-44c9-08dce88308dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTdjP+dl55Cw9o5s44MWDk+8vgKjbXwIl/HzLXbS2ofdfhYR/5MsKu2eAnfv?=
 =?us-ascii?Q?G/5b4eo5uf5CHYbQkBDAdBUvXm69N5AHocADSrUwsCiL8rINOuWvUS9Ur3Un?=
 =?us-ascii?Q?dMnE2bsvNTk7AOgZolAMQPyDLQTIy/w9TDiATXa0KVVRIMsckPzA60n1Sajy?=
 =?us-ascii?Q?69ltnaPQkEzldCuffCP4wFeyTOdmC6th/TrNF5cpFlT+ZE/NPf9EPW42nx6d?=
 =?us-ascii?Q?AfjGT17pd58L4IyW+MVnYGpOVPozfz1xNRMj62wKqI4VdLkulx5nF+fOB29q?=
 =?us-ascii?Q?kEwFIIuhiE2tVYQOZVPSVaZeCa4G+ROmJirfgFzDQSiEZ8ie+NN4le+v518v?=
 =?us-ascii?Q?gAd7gRTEE9ZAlToWClYFzZmaLM0sLGWf/bFYPmsOUrmcofF1Devofy4/DJun?=
 =?us-ascii?Q?LBdTBYugY62+Le4LBd8kfP8ohG9DBzQ2vsKSjorppxGE0NbOV0eR7wewE9qf?=
 =?us-ascii?Q?GDTpsrGIDdNsh7KZSREp/BtA227DlycYYleeUcN5hjyvVm9qiDKHwjwa6Udb?=
 =?us-ascii?Q?N3r5fKpa+C7qVyLDALpW86r8EAYSl1rz+fvUrGRa6qIL9auozxgOrKk0Y057?=
 =?us-ascii?Q?ui4cypY7Wdqy4w7dYTDubVnpCr61zZmmDJoeSany7EjTybeyjz0Qji7Tc/rD?=
 =?us-ascii?Q?BR6D5365UnztGeLLP8/Kzlo6/bRhC6081YDVulrycCCjjtMbrISrr1EimT9q?=
 =?us-ascii?Q?4aQzJ0YCcT1OxopuBl1FZumloTRAQTjWvBgoOQerXopMuDXyDm2ivK5Jj13+?=
 =?us-ascii?Q?Fwx42Kfupz4HRD8xlA0bpprc6OcGSffeD9eUTaOObomJj7vMwjbIrmNCH+lU?=
 =?us-ascii?Q?oSirCUXSFUC+auZeHK13UN8BWOkR+VmTX6cXX4wTTY5M1OUmGrT7L4fXkjuL?=
 =?us-ascii?Q?G/snV71M7/ZzvDwcGTCl/RzS94yfTAmnnWoccwZFK5luMZZF4FvH+Q8u31+2?=
 =?us-ascii?Q?q06rHKOdf8Hh9BiaGXqdeXedrQx1oW7XOM/C+/wY+Ba+0a7s2Aex7ZFhxkO5?=
 =?us-ascii?Q?MzzTANyWKqLvdrPnZZY6+Ou9kwl6VwE1w7JfWJ5+uokBCTnw2Sg/bWmwrFIJ?=
 =?us-ascii?Q?o7MxHqUErP+VNDS4M3zEGLRO+mnO7QmR89XpVkUNmMdyn6T6gF4P0TpHJyG+?=
 =?us-ascii?Q?4gh2WeE06qduvG2+PFynF12+J6wxbA8hbWkvmI89Y1pl3Uipc/jSe4sMlLw/?=
 =?us-ascii?Q?31SQisDFNAPYv4EtPM+wdjnMAQksrXUiDafVWGpJuQTRG4xhbs3/hT0C/U0X?=
 =?us-ascii?Q?LZDoLY92YkNbhkffUJOBzLabEEsl9nFUQ5pRbKhqmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlX9fHI6PobPLzvlwNeasir/XkZrpHLOQKQ0xh9t+ZmgfKNHl5KV/IkThgb2?=
 =?us-ascii?Q?A0xXhkdksvnf0THKMakbzwUcMj024njSOflxhEGinq0RaTo6u6MYga0CgSJI?=
 =?us-ascii?Q?/2lA68yi9etCHO8De8yarNsUFbfEAhMUo9nWvJrd8an2E+AqxY7rKIUaKlx+?=
 =?us-ascii?Q?IA4By77rnqQFyGygnSt8D3YhcV+CqflGM/bGPcFg6Sq3aVF7aZd5sNJLkLps?=
 =?us-ascii?Q?AsHB5VXIVnmsPmBddA9ahiQ9UPyszOhBKacNMCfj+nFawEJeZkoy6VMGiP3S?=
 =?us-ascii?Q?OybFpopQEoC+FH+A1kTnqWxWnGm0OSEgzNC9oieWiTgvoO0nqc2PhJaPBavt?=
 =?us-ascii?Q?ZrsSeyFlar/vguoLXJ9AEdf4TR8q9hlcBDsAO7T3/PJlCHxuRi/0IMk4a14Y?=
 =?us-ascii?Q?ozxDrTHs/9JUlCTHGu6H8H+F3MgZhutxuiuNMslP5tP2PbykqLPxqyOPhMEa?=
 =?us-ascii?Q?l0WEIoycgIq4/NJl5kIZLFF4lLPuwd8Szpa9U1mRjyUo+cV2vF2EDtTnFyyT?=
 =?us-ascii?Q?/IGNh9hvrpkr/YcNQZDnbr72J307EyTAlYbDMA0zAgOUoUMj+tfXnBu44uSd?=
 =?us-ascii?Q?8pdTApsrzKGc8Uv0zL5HMV5C9vmle405JGUHcVKOor2KKK8VFLoj3+N2dr/D?=
 =?us-ascii?Q?FoAwOzmxiOuiH5AHbM83+pALOtEQfWcMgJWQgLJKnXunx3xBQbxwyLPYv/gZ?=
 =?us-ascii?Q?dZiIpDuGqQQwahU82UAp+rg83IGayrgMM+rWghqrwLbX9AfHChtRgu3CzRva?=
 =?us-ascii?Q?2doxSX18PNJs/vSeybCIzXEXD9YrT0pyh+pS+7ZgmIcKhTASeVd+dzpToCm4?=
 =?us-ascii?Q?idfYa/mxNbBazPnydt+jhOsieW/yqtZzb+NlvEkrTj9QX4H2MbITwwRwHTXk?=
 =?us-ascii?Q?50JGVWpJgbD9amBs0EsWnIezXGMcUA56rYG79q1vg1ONvlYv1mNXJNcKXktr?=
 =?us-ascii?Q?l01UmkRtfGSdCZ/NryWnfYGiTh/soJGTOr5v5pyOtl7qzEFS/pW+3l3Vg9O2?=
 =?us-ascii?Q?Cbo0M7uasY9Pt/IflVd5G2La9oMFq6UCS8CDFMAe3ZqQpbP06PrkGtPx0c+x?=
 =?us-ascii?Q?zGHDkk6zSGNGxp40thawlGT9g2/yHtjG4EZ8pyid2wiZtxPU0bK3VSSac5+k?=
 =?us-ascii?Q?RwidE4FWGxaAJ69dA4/DLFTBQwmhW5ceRFNUZbYx6M/rCqn/w5S15R7zOemG?=
 =?us-ascii?Q?XjukjOyq4G5XTmeBknJeTVgOA1fdDWBC2G25MbaR+JsSDzD1LK0WlFfjzA1d?=
 =?us-ascii?Q?95yd3cWXJCI71kzPTTLRQqbqvWiTeNpGaPh+aNR6/CdlCwutfJV0qK5UN+V+?=
 =?us-ascii?Q?CvK5VcwGEyV0OxxZiNkcNVGIBw6Fp21JPAPeIOsNQOM0xojoH7IAWF171cwN?=
 =?us-ascii?Q?SDZeplxmncJbnSPKm95izw48l0Q9ykzYfc7Xs4Ih/momId0G0pSRK+4FfY/n?=
 =?us-ascii?Q?GZxUvJu14aUHh099a+4EqmxUsJf4WCJP0IrF2IxY7k1tFiQidaFVkqDkrKjQ?=
 =?us-ascii?Q?xKwuHRejezOM8kE/FBaOB6/g03xjJ0jrNu6+Z3lDC7BrprNBo2ysKNJ1sBg2?=
 =?us-ascii?Q?FLfO5o5jCXrNQ5XI369ItuJD67tflXbsFByfPW8grPvvdw1/4KwO8HHPa0AK?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P7cTQ+HGfYOeAM+WROH668oA2PXxyUj/PMPKnr1Oo7ydvEk0XnGvPymjEbmKIARtBpH0kjerFEGjJGqgtXoyfGbFwfZRYtxaOzBipxZa+ouBtApB9sb8rlZQMQeWaK9uPnpU+ReCVBA+K59V//IwUl5VY0s/Zel1TU3zPTXShtBKDn7tv1kgYJdo/+VQtsRCrrhe9eeKyDITdgH1Vmwm08fbXX/g4QwgqpWdS5HDVb97aB9myoeX/1zSISCI4j93PfRuFKNB45QG4pQFoP1splQ9PSNwjgK35uomiC0Ea3QNEPw8+7WO/3/Oe2v254urXqf4dW3KP2sEvGifBbnX98jDJBWP1sIT2g1FyJ/V+6y7v8mDZdqWAikcnWk/m6ojMcchHhinGGAfN0ibczEXGmD1fYKcOiuq9SzGmfDHl8ZSjQX68x+VJa5YEWe8VqZR3DzFHAfjktoZn+546FA5rud7RIv2aC6kD9EUs3qmflkPBK8XVHYMAGsijP5iu7e9uvWhasH4iQhTdiFyNvKtvz3fxwqBJg8j1r0rlXZtQ1YCMSAboq8hxTmoZncyugDOR/TBP3f5qJLv2Z9Dob6ifdMEJSL52OX+wAb5+wPPENM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0897d4ff-f2d2-4e15-44c9-08dce88308dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:26.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTYLNf+l3Xqp7J3c221ryqjWsNEjGy2G/fJ0hRGV1D9mdjoGotmm66I22DLGwzLS4+ABa9DVs3MXDphK5EIx04pmyoaSuQQz3YM0pSOA4BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=989
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-GUID: JjcbrITbjAmQ2UjrdhH3JgYO0_MHBSyf
X-Proofpoint-ORIG-GUID: JjcbrITbjAmQ2UjrdhH3JgYO0_MHBSyf

CC: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/srcutiny.h |  2 +-
 kernel/rcu/Kconfig       |  2 +-
 kernel/rcu/srcutiny.c    | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 4d96bbdb45f0..1635c5e2662f 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -64,7 +64,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
 	preempt_enable();
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 1bfe7016724f..cd3148fb566a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -91,7 +91,7 @@ config NEED_TASKS_RCU
 
 config TASKS_RCU
 	bool
-	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
+	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_LAZY)
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 549c03336ee9..8a662d911abd 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -98,7 +98,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	int newval;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	preempt_enable();
@@ -120,7 +120,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
 		return; /* Already running or nothing to do. */
 		preempt_enable();
@@ -138,7 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	preempt_enable();
@@ -159,7 +159,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * at interrupt level, but the ->srcu_gp_running checks will
 	 * straighten that out.
 	 */
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_running, false);
 	idx = ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max));
 	preempt_enable();
@@ -172,7 +172,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
 		preempt_enable();
@@ -199,7 +199,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 
 	rhp->func = func;
 	rhp->next = NULL;
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	local_irq_save(flags);
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
@@ -261,7 +261,7 @@ unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
 	unsigned long ret;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	ret = get_state_synchronize_srcu(ssp);
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
-- 
2.43.5


