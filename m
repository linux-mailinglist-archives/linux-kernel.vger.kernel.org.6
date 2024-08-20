Return-Path: <linux-kernel+bounces-294707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D90395917C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FC51C20AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CE1D1724;
	Tue, 20 Aug 2024 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="feJQT9lm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OtDRbanS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219C1D0DC9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198309; cv=fail; b=bas9nMOscNDwaS1ORvodxS21Em3GxZyyseMhP+4wt1EBG/Nedx8XCsuYJTJcHMZM/ixtlwAvK9LqdS/6RzO07/2hKOZUDcKPC7YZG8cpuHKpjfFoRl+pyWYitiuBf43OcXk7eDPI+rcbzOKkQ8BSPQteqP5RL8Egd5oIi+ugmzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198309; c=relaxed/simple;
	bh=1AazEpYlekbrV/DSlUWTYTSr5b79wjqwiNlE0WbULn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/VNsS31O3CnYBNfBPP2QBTSjpaz0sC48uBHnsiTTseLGaZiSaoDlTMmFrobqAlZVa9gNQErdpxH/+zPYVtQVhKxBrNWPPyAhJ7zmM/SZWPIDdgknfWPZKLu/EIO6wsA5v0H8pV8I2atjZvIrPNkcYYY290sAiNh/rEIxbZ8Jn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=feJQT9lm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OtDRbanS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBvvu005187;
	Tue, 20 Aug 2024 23:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=9tEwNxjNGC3trfidDDdxabxW9yBYLd3veiUzYxgKkUk=; b=
	feJQT9lmBfiCQdltLIOr9H71Tbb9D5W1WnPGkmfXh/Q2O0d9d2xPXWLeRRHVpUEi
	OnnEKPIoeaTOvNsAfhjNcFjK6a8drX24UGxMSgc6hgfvK/A74VVsI+iaM+rBtkgf
	zAA+D1gwb143wEp4AXGNopA/wXO84dZ1TluSyVULlPKrD4wAX2Nzz7DqWedHa6Ri
	k17OB1XkPy5u+rZDyZg2/0jKDkwoiX0vm6agN+svTzYFFMStciAAo7eNVVhoqX2v
	LeST2Fnd4LGUWMaqtHtxx8hcc8nZEWUiy7lfGi0Wfj0xXzJGMw7ua8gtQJOOlcBv
	badeWHAL0CbS009QyHvGrA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67e8qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMinOH037575;
	Tue, 20 Aug 2024 23:58:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41546yhr0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQvz2JufbVaXr8YWR72BQs2E4XGMGdeWjkjD+9KTP7PaE4T3jvEpIlaLDFsaCeC86uugbzn1KxS7X+ABVf/iKcDj3o8+5VOvVafTTVadvAKN+fq4wMlSognzOjCj2hEGAnjJ/aMH+GaWr+UQn851iLaPscu0goQR4atsafg9Vjp4ttK6SKGTZZ9cWQOA4+BjeAnTKe4GSHbrVJTQy7zdTq0ZJJeNPXpyhC1UuQaNGOdKkTfgH0qV7MwLgEEBVxOc9I32SLZPmasU1HNyyUF7vxuU8JNqwVDsml7bPzrXWq/krfRZQhx7X1WfhTcHyFbV9CyTSR6H0L762dpGmpsM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tEwNxjNGC3trfidDDdxabxW9yBYLd3veiUzYxgKkUk=;
 b=DTMI2XeKF/3MF1CtaR2P9QlXOq7bO7C9frnFVhRjMIx/i13w+xWdz/KPG2cdMGpEFvRlVjapf7hBFbzBnCyjiiFNyMS6tC4+rPN2jOUKWwDpTddCNGn+0EaDBps7nImb+lePXRpsPit1yi/5Yjng2tL+pvnAD5FrA78WcamMhvh+uvlYfjkewr9a+erQ3EkhmFKVjGw+ytK7CRYfddh/HzzN8MjCIe2mpzvstT333R+nhbzbKMrORKyDEfo4YVTTyyJMBqBMvqjVzKgFbj06cc5rLTA1UscSARo72EvTGUo3814lE7mdOwaZmFpPilTSNnuXWJ1yOsn1wXbxV1TIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tEwNxjNGC3trfidDDdxabxW9yBYLd3veiUzYxgKkUk=;
 b=OtDRbanSUvjmIz/LX15uM3q3bjopkozc9dVs3NIyBDl4IicpJBv/KfHEUsCbwXmg6ZT+sc72KICh2OrH/qYKnBzCx+Rn0NdGKq0ZyTmnnfq0LnEAkeCE1pS6sh3nnHVc8TavJjQkUWKjwSvaMCOSrK+lw/mD/SPnvHVq5RujSMU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:11 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:11 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 13/20] mm: Clean up unmap_region() argument list
Date: Tue, 20 Aug 2024 19:57:22 -0400
Message-ID: <20240820235730.2852400-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dbf3ef-7f2d-44cb-5824-08dcc173f25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBRhYgEja2dGfwRuyZ3ERSzaNQ/Mrj/8/RAuUNh4lrgtkmKwexMxO/aM1Gq6?=
 =?us-ascii?Q?6NG0WwQ312YuIbC5pBxi83BgrRG/azl+ydo/5zRAeg2LtEBk870oNiqSjOU3?=
 =?us-ascii?Q?p2yx538gYD3pqOLJVUyINqrZwCWfh38e3TnWItdMQC1ufu3RkEsqJLBQB/cO?=
 =?us-ascii?Q?10IQyD+Gc9oBD2CFUW4x4D/CwYbCRQBGTip4WA5BsAbRhKbJT8EpLpNurmb1?=
 =?us-ascii?Q?IRT4VWV1AwYxwSGzQ77K9ZbaRXhWUrpU9XCMW3mqsH99LacBe+mDTrAE1kiE?=
 =?us-ascii?Q?K/yeyDos/X/FX+VgGcvs0RSawxVNNmxBQb9QXTYQ878925Tg+fTP9jscuSg1?=
 =?us-ascii?Q?+liBsG2JBE2Ce5OiBqyyqxMCeoTsT1ELnDC82Qet7o9j/oXARtGJTmtPLVuG?=
 =?us-ascii?Q?MvjclRciDD64wUaxw2zMI6e60/N50LnnYJgdf26Jiw2xTLhw0naS6C7LXHpv?=
 =?us-ascii?Q?gSJX809V6f9wAmSVYi7mFaAWnosUYwBmtWvt+uvEO5SKkUwDbh7pSlq9NwY6?=
 =?us-ascii?Q?BISkFutcj3WPfTtqEhT2riSG3oXJZonPLJZz2n2OI+ppBONfzgM0BTZ1vvk4?=
 =?us-ascii?Q?z4NEQ0jPVMKr3xDiKnNooiJE5dozaq6vi6Vrs2mVAs7+xqVV5OAeuIuF2xgh?=
 =?us-ascii?Q?1fhxLdwuzWV6NDT2mfOC8Mzrp3D1K0HnxR1HqeCTc6/8yfxDuBAnc2+8NEvM?=
 =?us-ascii?Q?DcRYKm5q6dgpVK835P96KLnlxH7YMQZFtDZAfXjcajUyMs1oiQuGCTZqD0IR?=
 =?us-ascii?Q?xm7GqA23tcxMs71wwYKY8UJuUnO24MA6+UlW/hb6ZAZm5QAOevvHZ7+5X1qP?=
 =?us-ascii?Q?NgCBV1hYFgvaEiWOHDwx/TpcpoIns53qBmKV/qXetHPChT1dRLP2cW4Sj7BC?=
 =?us-ascii?Q?WcEh5KUPCViaik/Ik3DKQnCdOJzxIG7JQYdq9NTdhT48rVSrgz+uyONvT9W0?=
 =?us-ascii?Q?PSguDHnozG5QcyLLTTCnSSmpiTFEtxbPHsSIh1T67GMP7IY74ro6HGOIJ6+P?=
 =?us-ascii?Q?eJ0M7VqONlze78BW5QLFrn+ZyrShFyeYVI/uZZygb2wWwp37qrv+Pn1Y/h9+?=
 =?us-ascii?Q?kYW96I4Z5KBZK6dGi7NoTT4QXZQzxqMbmSgPZlDKloUAJ5hk/g8Ia5hdk6K3?=
 =?us-ascii?Q?DxngNmic73KN4ozXSi1OiBo/rCA56EYBl1WsoFSjX659BVnbZA1ZwKouNOSv?=
 =?us-ascii?Q?5GX1+muoGOESCDC8HWWnq7ULiuZuX19aqwt7ZI3BsvjKW84geu2mvl9OgyZu?=
 =?us-ascii?Q?hGY0QxgmwAP6ysP8R1Qhg3I3miX5f9ZAOUPD6EVNtUFEWvp9C7wJukKGrbXY?=
 =?us-ascii?Q?3Q5GJNJ/xqRHgBv3kbbNpEgdsdTzqMB6gt7A7JB+1I1ZOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VB2WvdRVax9cgc2YPVbJ7HxZBn6vuVYHoMxioBHrWbK8E6Y53hq6+Iz9DhBF?=
 =?us-ascii?Q?Z3CFje+/4lgeFtsk0MqQRw0xFXxtTOXkqv1XKsI+0PKN3QWYiUYwq3fMrr6W?=
 =?us-ascii?Q?6pn8xviGIcoIKisExv45TdmDQKsrxvSyqeiOLihzb8Bapjx6pgJeGCz/euZJ?=
 =?us-ascii?Q?46jVgyF7ircnCZlkuBvwcqevSrQRsOVYC2oGsswu0AczaOPPkcLrSPabq1D9?=
 =?us-ascii?Q?W0gXTtrFQXAShxC5lsX6vNhMizYkg2coYT4fi+0D6MwqWKfrW1VkYopC1w9D?=
 =?us-ascii?Q?AahgUzsXzYNzqs4CGJ2CXdJvysxVe5VVI9457Q6AKm9oVdda54DFqdo/1903?=
 =?us-ascii?Q?AdO6F7+waLsKvdcChDbcM7KftfS+H2Cf3cAc8epTM/KMoUIdtXhHlV/J8N8J?=
 =?us-ascii?Q?+K7gIf4sezcFpStyDNm6U1mqz4HPNasnsYKPz0HLeVzGsOd44EUV2G7HRdao?=
 =?us-ascii?Q?ZPL2duBadzsFeYViMnCW3C3E6HhKveY0JthorLmreJQ0THqYR7PZjwckdlgi?=
 =?us-ascii?Q?sCG9TJnBGaxjV/8IT/yWS50sXGfal02S03tV0uIiTAGcnGARrCkztA69Uk0S?=
 =?us-ascii?Q?P6oRDddipXNVj/OGTxoB4PniIjlDzXIgOVJ9k5KHotqLbfFnujvUDor8jxzM?=
 =?us-ascii?Q?+/9xbswZyU/BFu5GwDSEMRM9WjdNjOim7VCaxv++ZdoJIKL8YYg6xwvebb7m?=
 =?us-ascii?Q?xB2SwfEGLwBX4TjZln3p27vcWhrDsVsqBvuctEjiaqZjz1keDL7pGSJcilS0?=
 =?us-ascii?Q?NwsQAf7V5NJMFjaWuU0VcC1WwFMvGxr4q/MhAJNshlL71eE+sWCtZXzjYKTZ?=
 =?us-ascii?Q?UwGVobs9/P2E734N4+qhUZ+1j5pvkHUpgUXb4AZ/+Zr0ot/Jmv8YbpGPiHXd?=
 =?us-ascii?Q?nkxQOdYIlAfVUsvGXFwxexh+MvY2AqHVO2skc6sdF62C8N09yNXvX/sDqPk8?=
 =?us-ascii?Q?VqVxIBFPGdN5Qwuw/dttqOofzCXQQ/biT45v0RzHo6baSDp0gFdEN5eTonji?=
 =?us-ascii?Q?wVWoeDcljuHZRqXNU4PyxeBC9vVbIzOsLBN4uH54KjIg5rxTI094jUFGBJMK?=
 =?us-ascii?Q?kCFMYYkrjXhu4HI13AArZVKnyQMgjBY2sQo2T1T8gwS1X62we53X+Pu1MS41?=
 =?us-ascii?Q?aOnqVa2cAKq4epX2GqZTmYxspOYtInaxDXJR1riXaQIh0/0ofs6hjJgXg26M?=
 =?us-ascii?Q?dA6Nz7GbKQrQOwIpVPk0ji/i9eRk0B8MSbsGkSYNH/PTk9YMfv6XeJ5pHTOU?=
 =?us-ascii?Q?QiUPiudnFT+d/LM0xaiiCpPvvAWAVhX7JXJ1On59HBFcI+gd15IZSimWAd+0?=
 =?us-ascii?Q?GiQ2UduPKR5XDnc/3AbwB084mDyA71tAdno1mod4Suckx8CTtmHOL2uqFPEp?=
 =?us-ascii?Q?zQiS6fI8WPqkLM+eUJFdKSC66dxHOOy+nQT4cbLaJBktI8+UZDDHTPiDzps4?=
 =?us-ascii?Q?PGnjK2PaMGrnOD5hEtcO36M5ARxpKJNXFBFRYJ5VUgHnngtB32Y5e+txx4fE?=
 =?us-ascii?Q?xveH5mr3ACxRYMgtuA9kzg9HYgxAtXPjhL8HjQqbAnChX6AJqmi5gyYrD+uS?=
 =?us-ascii?Q?xI6KuB/17KEWAOfe6fMtQMmFPsAt7IV33wMbkXqdtTdQDx+lrPF+TeHdZhKL?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hxXbKyMJ1z1ViWt1SN0BAkQNf+Bq5rI0PV1+EMrLhYSSZMxwQOWnMaWDHNvnox6OiV0CZSEypy+3cVvkO4P6XhvKWdcy2VP6OP9pYf/Y6aecbI7vwZIyt66iImm2vSYHCn7I0esJps5kQuk75i0gTTY/mGtgPBUjNpgzRyg2Lruc3WdgpnXpCUwgt9xcQvfUp6nat6uHR4E1Q0Ryo639dKqvZKf1tub+cZFvjX1Pqlg2BH68SrKfuU0OSTpg6Nl9flMaXzzt9UQL+VXYeP1CHmZPZviXTMLmLKC/a5kz/xyTd2jGQiXDISgiMJlj7hM5u1bH8IJHBQkP9i4Iz4+lRV2/sKLXn/cWLZDixN75QWySv6Aw4B83TmKY4nsy5/YKcsnzyk2pFk7iJiepQou2USA8Gy2aWxC8/q1v8o2IwWvADnOx7b0VqL9+6Dx2weDImvvloXnNu8jk+c7meZwzemRGaqS/ZiMB9RFSEBqA05O6xR3vRMEBvitRVPMgc4V5N1pwZ5DA3rbYZXu4GgAG3tZo6QbQa7JNlicp8qRxzBVOabAVWmQDySpowMpck+sTUWBd7lreznaP4Dg4zo8aD1MRWQ19gOT612DdvAX5zJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dbf3ef-7f2d-44cb-5824-08dcc173f25a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:11.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w34LRFph3pUA+/Ft/DbM2LSZheZAqt7izAvYf6RiwoxLNaLMJAWVxmprGvMnkQX5rWkSt/VfKJaHB73IXwJSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: rlsHmofMYRIYAkEi1rr1KqAbo80L70pT
X-Proofpoint-GUID: rlsHmofMYRIYAkEi1rr1KqAbo80L70pT

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

With the only caller to unmap_region() being the error path of
mmap_region(), the argument list can be significantly reduced.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  3 +--
 mm/vma.c  | 17 ++++++++---------
 mm/vma.h  |  6 ++----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9285bdf14c4f..71b2bad717b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1613,8 +1613,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
+		unmap_region(&vmi.mas, vma, prev, next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
diff --git a/mm/vma.c b/mm/vma.c
index 5ba01dde52e7..7104c2c080bb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -155,22 +155,21 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
  *
  * Called with the mm semaphore held.
  */
-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather tlb;
-	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
+	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
+		   /* mm_wr_locked = */ true);
+	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      /* mm_wr_locked = */ true);
 	tlb_finish_mmu(&tlb);
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index 7bc0f9e7751b..6028fdf79257 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -147,10 +147,8 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 
 void remove_vma(struct vm_area_struct *vma, bool unreachable);
 
-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next);
 
 /* Required by mmap_region(). */
 bool
-- 
2.43.0


