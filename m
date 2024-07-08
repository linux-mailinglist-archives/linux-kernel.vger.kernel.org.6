Return-Path: <linux-kernel+bounces-244331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB492A2C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDE72819AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BBA13A87E;
	Mon,  8 Jul 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="luPQjrVX"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCC811E6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441523; cv=fail; b=JvEZ1RdAz48p0mxPuLhe9yYxNsLPDCS4Y60HDGbvURLOiLhEKeHOzoCovzpY0NaSczdaZhMiew0qHjo9rQFeDInM9crDiMgSriXYMNdbVCIuVgZ5h4kwII+jekWA0/1nXdbKM/uy7I4N7LGzFpeL63nmAG+GvnGYmrqOQaKFdCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441523; c=relaxed/simple;
	bh=OJrgxRTy4YNLnL6R8xDJKlIgzlxhzx6m7IRU+/+LiLc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XiTiw1g0EvMqKiDQ+1+mB80qI93wZqtIgm0v6VR6umg1MXAVt70jGnyQeuiZfsxHOc+cyRNSuv4MkK4BWwx0nn4B2Yv/Xbtmf75t7t6B2C09U96TRgveO6JzdqbsM3ikz0FTCJoOWnrj0ZWCPogT1n+1tMMV2zAf0RjySHahsdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=luPQjrVX; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noEYBILMQJ4fhs5YCAJAN+Tge+k5zc6ajrz7KMJlzOZUh3DJo+Wvc4PUfGRCa/kWn/Pgj2IhH32K0WDOnXLnYVvoePb8n+Up5lecPE2hgKeSFzP43vd8zKnu+0nWmTcwpZF2Ug0hgCfa2boOMfq7e8Ioy+7Ii/D3i+iIXhbXI7/ULn6virdtzg3ju9qg8xcLE/MHRzirsvCFkqwi/PnugPMqIfS9Mj4pzfLe/O360cLA4wAXHJh9brLcMZHu+dTnYc3oJWdHRFRUWtRCX6Mteel0BlBvea0eTwn5zUh8XgHLN2/tv2h2ckXCZwGX2b/8dYcWEUFvUy/EzVrHzk42rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKeWj5u0JFt8xzH4d3CwtQMJJEMGpGrw+r7nfsH7aOw=;
 b=BWM005jFEgYFC8jX7canuE/lo4910UcHKUCY2VEMDFn5poWHJmf9V3J+lxSqdGNgBSSBZPlRU1rjagsN4MD5sbSTlzHp+jg+JXcnfVVcxuWA+rS88+V7FVmlTZ/NfcaGNBqGdgduhvyoFA/giVaeQA3O1nOBvD6tp6/MBKOV0nRqL99BLf+HEcIwTBiD41ZfWFq4VoisLEQ1DLI7C9ZPTXJiR+VPPiwIoEirxiwyHWrb14NR0H9QXCmLayHiHdwYwm3jRmGbiHeYqY9WAWHIc6kpvQSVlTtUaLWKlOStmV2J2Ny55uiIcfiw4uV3y+sSA4Nsf6Y+Ko/Yf0nHwoOR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKeWj5u0JFt8xzH4d3CwtQMJJEMGpGrw+r7nfsH7aOw=;
 b=luPQjrVXY2xtTK2zrFAibJFWcX4Z6sk9HAZytKKfke/9+vkIV64cqEwFvw+dUzNiqDmuSEWc4I6YQki8rQhw8+CmZ3LoE85Lq0YzR9rGyoj3plZNBpQjlc/olbXgRBbiCkG5l7BU/fJBaiS2LTGIn6leIu7WDIS9vFB98kzOl2R+LWj7TahVC+1sj3I2geu9+QgcmdRcyZ0rA1iWu6aEU+WY8H2dHfcP4FXi6V2f448RWAqTEWXTz3TNwlm11wzRHenXSs1PCaCioI61dbiUf08OlsxtxsxaJFKPqmK/7nI4Q9kVRjOpls2US7J2ZwM6QdmMVxT2QtERAksU9doESw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB6560.apcprd06.prod.outlook.com (2603:1096:990:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:25:18 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:25:18 +0000
Message-ID: <4ca9836c-4f03-4792-9be8-f7db71a2b162@vivo.com>
Date: Mon, 8 Jul 2024 20:25:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
From: zhiguojiang <justinjiang@vivo.com>
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240708090413.888-1-justinjiang@vivo.com>
 <CAGsJ_4yrGR5ULU=MDXZq+hEDb+TWuRkfbg9V9Rg=mGAWOpUkxQ@mail.gmail.com>
 <122bbe20-f2ab-4d44-97ac-76df8469d3fa@vivo.com>
In-Reply-To: <122bbe20-f2ab-4d44-97ac-76df8469d3fa@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: d74357ac-1517-4056-61fa-08dc9f490733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVdEdW9lcmdyRmZPS3dKa2c1cXZ2SDhPdmdlSFBibHZWUG9uZ3VleFVGQnhG?=
 =?utf-8?B?Snc4WHhNQ3dHNlBEUnllemo4dWNDR21tdnBZZCt6Q21JUXU4T2srMHhySHdX?=
 =?utf-8?B?c2pOMDZlZm5qYnM0MEpUZFJ2amZzQkd0bitzcXRNSjZRLzdGRENNYnlSOG82?=
 =?utf-8?B?eEgxUXdVcFREeTBBV1h6d2Y4bFdQZ3ppN2JaYTh3WCtMTVZVd0k5RjM3TWhD?=
 =?utf-8?B?QzNaYVgvejlpSnhCd0U3OUhrbUl5bnRDNUh1NkdEYXFWbWF6QVBNZVVQU0dC?=
 =?utf-8?B?U3lKS0N5M2xRTUpxVy9DNGNzVDd4L000QlNic2JmUGZHUFVCVDYwNnNHYVFm?=
 =?utf-8?B?UlAzOVdVL1ZUcXFHZkFMRWZUY0lNSHB5Z1RZSGErNllQWFFtTEhWdlhuMmR5?=
 =?utf-8?B?ZG9XK1AvYTZTZGd3UkpOVHovMnBLaEFSZTdVN1JzNkVmTmVZZEMrUDdpbHlo?=
 =?utf-8?B?ZnpLTkk4NmtyVXJzTFZ2QmxHQXZKU1dCd1JYc2M0WHhRcmlpZFpyUEJ5V2xo?=
 =?utf-8?B?U3I5UkdpWUxnZ0VDbDVwb29Pa3Ntc3lSWGcrZE54Vmp3RVJJUWF4NGNuVUNt?=
 =?utf-8?B?SEp0ays4SzJwK2RrUDRUMk9VeXVTM0hSVVpjZ2R5WnNVTlBoREFrUnhyZ3pE?=
 =?utf-8?B?cHQxNW9UZy80MWVDZ2U2Y3ZxbUpXNHpjNFY4K3RYRldPbWJ0WWQ0eSs5aHk2?=
 =?utf-8?B?YWliUnI4MXdiWHkybWdVM3k4Mlo4Z3FYcnJLNHJaTWFyeEltZTJVb1JLYlhW?=
 =?utf-8?B?Nk9rOWZqUTZjV3RkcElDVCtyOHVhV0QwaDk2NW5nTTRUUUl2RFc1Nzc3bUxY?=
 =?utf-8?B?UjN0a1pOQ3Q2UEs4K2E5NVNSWC81NmtVY2JXbkk2SVlZZVl3MnhrdFVwcTRW?=
 =?utf-8?B?VDBLdndNYXJNNUdDWUdNcEFWM0dnSVVVdTBTRGlrRG9nNzFkaHpnUjBMSm8w?=
 =?utf-8?B?b1ZNU1QwTzZ2RU5jcnNPdjhXY0plZmZBcnM3a21sMVd6RnNkUzFFYzBoOVho?=
 =?utf-8?B?S2pqMVZaQll4eGdPM1d0emdqcCtZSG1JUmRDbmpSVzIwbWVwMmZsTVBJMklM?=
 =?utf-8?B?Mk1meW9FdDk5SFZ1NGQ2RzRmYitCV21YK2E5VzFmZW1Wd2xzUTU3aDZZNkE2?=
 =?utf-8?B?cXJwYjdjZUYyanl3eHZDYXVROWYvVlN2anVEM2svbGNvRkh5UDh1bkF6WHRL?=
 =?utf-8?B?ZHBvN1JDVDljYkJMQ0FOWkFWOE1zbGV1aVlzMFpSNXkzRnJKb2FLYWdFUDk3?=
 =?utf-8?B?QlFOOHB5WEFwTGI2MnY2VHBvR2NwV2xaQ3lUTDRMc1dva0pzVlRCelRjTE02?=
 =?utf-8?B?U3d6ZjFtTld0KzI2N3Zpazc2SFhVZTBQaEdRUi9qZHZGZnFPOGFMbFdWVVhv?=
 =?utf-8?B?MzZSNU84eGpqOUlwc0VaYldiMnRydnZ0aHpFdFZqT1VHVkhDM3BncURlK0V0?=
 =?utf-8?B?Yi9oeHM2RkR3dmFRK1RGQXEyZjdNY1dXSVNtK05mbThBTGVPMUlyWWE2bXNx?=
 =?utf-8?B?a2xLYVl4WTROQUh0UVc1Z3BrRmpXU3NoQ2RJckh5cEdEWkhNU00wVzF0ZjQ4?=
 =?utf-8?B?UUY2ZTNXQ0VKaEpYU3VPZ1VuVEE5VElTbnBSd0puU0xNajNaazl3SUNIaFBw?=
 =?utf-8?B?V2xudDg4OTY0YnliaGR1aENUNFRRb3pLanFXZHhiWlZVbHpVQlI0KytPcFk1?=
 =?utf-8?B?dXVuU0xobi9wcjBTeTBrT2hHTi80WjhCU3R4Y0hJTGdxL1JodDRpNW4zRDJD?=
 =?utf-8?B?aG9Va1pRWTIyT0JKOUIyNzFjZjZ4QzBsU1JNeUtZSWZBc2s3WkdDNUhJc29R?=
 =?utf-8?B?QlFZdFNyT3RxWEVadmZuTG10T1NIZFZ3MUhYa2ZoVDlmNHpCS1k2OUFzeHNP?=
 =?utf-8?B?N2EyYW1XdHF3M2ZZaUdMNm1qeEhMaTZlOTBvb1hVZVdmTUxvaFpCU3JaVEI2?=
 =?utf-8?Q?3jDiVe73L20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtRRmpHRURndytUZ3FMOERtMXpYVXZKM2VuMWd4QkhZT0hRRDk4bWJFcTQ2?=
 =?utf-8?B?U2k5ZWFmekRjak9BUVNvdzdRanhkN1Arb29pdzVqL09tY1RqaWs0aW04bklJ?=
 =?utf-8?B?SmF5M1gvRTgreGh6dkoxeDlxOHhtZk5vVWNBdFdRWVFGc2ZkaWZLMnlRcVhH?=
 =?utf-8?B?aWZVNjVNTW1JTkE5VHBnTU9xaXFRQzFxZnZhT2cybkg1U3N1b29WUmFWcHVI?=
 =?utf-8?B?bmtPQk1PaGpGeG0zdE9vdTV0U1h6OTBKY2NKSDhQR1JOczZXMi9icEVwNzFI?=
 =?utf-8?B?VVRXS3NJWEJGN0JnOUVNa2tKN2NwQlo0ZElWcjA0Zkl3YXIwSXFEcGRFNXV1?=
 =?utf-8?B?ckVxcmp5cUliM29haW5VZitjdGNlK2pkeEl1K3hZQ0tsZ01jcGtOVVA0SWlU?=
 =?utf-8?B?Q0tjd0F1VDlzTjgyYUhtTmNoYVRrakpMYXVCQ3B4OXl3bWVGdkJaODB1VGVw?=
 =?utf-8?B?d2RUL25BdEVmOHFUcXV6aWRoY3V0NWg1SkZMTGRaQWxGbjZGQ1FXVXZ4Tkdy?=
 =?utf-8?B?cXRka1dtWmltK25OVGhFbW53OGlKcFVGNUtPTEEzZXVYR0JkL3grNm5QMWdF?=
 =?utf-8?B?K3RtUzRmNG9tOUVKNFBhUWpET01NbWFRMlhRZlMvdlNxRDRoZnM2RENXajlj?=
 =?utf-8?B?eU9lU05zaFo1QjdPbzB4dE1uT2IwUXl1L2YwNVdEbC9Sb05YaHhZdFM4SFpX?=
 =?utf-8?B?ZmJBSXBDUkp2R1BzNFAwRm45d0RtQnFsSmNTZHBSU2diNGliVUNJMEtuTC9r?=
 =?utf-8?B?WUI1NkNrQmVXdHh3d21LN2k2U0Npanc5UGh0U1ZleTdjZ1JHMkZodWlPWTRJ?=
 =?utf-8?B?R215RkNVRkpJRXFKOFZCK1NjV2NZaVhZSE1heGhIV21mdjBhY1NNVzM2QjdB?=
 =?utf-8?B?RVB6SU9lWTY2NmFtMkVNTy96cWh6MGswRm44eWJPMU53cHhXTXB6Ylk0MlEz?=
 =?utf-8?B?S3puMEtQbWNXODh2RUlWamRBL1Z4Rm1qTE82Si9lblBDRTB3d0lxUUowaWdt?=
 =?utf-8?B?T0ZHVVRiS0duOC9aYlp2M1RjbmgyRDR2U3JoaktjcXdGaHpGRHg0bHFQMGl4?=
 =?utf-8?B?dEhrdkZXS0FNTjJRdXBpR1h0V0JrdEtLMHVpQmM4RjlLTmNwa3VIeEh2Vmo0?=
 =?utf-8?B?bDhhS3lHZnQvNUVISHp6VElWZDdUNlA0QjBZc2piZ0QwUHNiSTNhOU5qVmxE?=
 =?utf-8?B?LzdSMC9GMmZDUmcxa2Z2RGNIL3FtS2ZldVBNMmo0Q3BYa29xdkRjazN0VTEy?=
 =?utf-8?B?VkNhSVA1dEYrb1JVMDY5SkNSMzJyUDdEcnRpUnJXNzZTNGdUam8rSlk2NmFa?=
 =?utf-8?B?Vnh1UXpkMVdSNU9ZLytldW9kR2N1em5kb0xYZ0lIaDhzZ2hqQVEzaGtYTldZ?=
 =?utf-8?B?ZXhjcWs0MnZzdjFmYzFSZnAzWUNpZlIzbmN6YlhPb2ViaHpOaFNURVJoQXcr?=
 =?utf-8?B?VTkrMmhIVFFjTWVTN0Y1d3BneHpmamlLQzVWbm9XTGROaE1Yb2cya1p1Z3VU?=
 =?utf-8?B?OTFkUmV4bXg4OUxOSVpzOWZPZllodkZVMFdvOXNuQUNjSzF4Zyt0VElQdFVN?=
 =?utf-8?B?eXZPMWt1d21SeTBJMzd5bWlSdG5KMHZ3OVNuZ3FGcWdEU2Q0WXpJSFNWVVJp?=
 =?utf-8?B?eDlGUXFlOFZmcFI0NDJXc1JSYWNvcFdVbnBTNmJlR2ZHVzEreVYrS3daR2Vl?=
 =?utf-8?B?NU9hMFNvcm0zVDM3Ry80WklDbkN2aGtXRk1DcFl0WEttV1RKVndWRys2NU9T?=
 =?utf-8?B?cEU3ODBJMzlwQkZ0OGtoV3hYZm1uQ3lzbk1rMHhYbWd2Zmp3WjFpRXBRUzhi?=
 =?utf-8?B?cUZhQ294K01LOGluRTFoSU9xRitzOVU4VE9XeW9kMDFnVGJxSlREeUkybkFo?=
 =?utf-8?B?Ui9TRHN0VUZLUXROVitFc2JyWW5acDlrelFrL3cyZjlVbHFwOUlsS2FOY1RX?=
 =?utf-8?B?dVBRWWtvUEwzaHJONjFVNXFVUTMxNGNWdWMyalV1UUxNMk9MMUlLWTV4SnlH?=
 =?utf-8?B?WDNpb0VGSU1DMDMrZlpvb2R0MVJyWWtqSU05SFJzM3V1ZzZhbTJjRTdXMGI3?=
 =?utf-8?B?eldJL1U4MFc1d1pXQnhseG05emRGcVQyTTgyS3kvTEVnNzdwdTNrKzhOdXFm?=
 =?utf-8?Q?DZb3k+EeRVbBZ1slo2x9wUFoX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74357ac-1517-4056-61fa-08dc9f490733
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:25:18.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH6UWnO58UZ8NfqFkVrdyX9Rpm02tx47EsF/rQDFm1Z6bZLf1AuWO8sJJ8ted1px7rdty7tiUlcdp4yEK4boAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6560



在 2024/7/8 20:17, zhiguojiang 写道:
>
>
> 在 2024/7/8 19:02, Barry Song 写道:
>> On Mon, Jul 8, 2024 at 9:04 PM Zhiguo Jiang <justinjiang@vivo.com> 
>> wrote:
>>> The releasing process of the non-shared anonymous folio mapped 
>>> solely by
>>> an exiting process may go through two flows: 1) the anonymous folio is
>>> firstly is swaped-out into swapspace and transformed into a swp_entry
>>> in shrink_folio_list; 2) then the swp_entry is released in the process
>>> exiting flow. This will increase the cpu load of releasing a non-shared
>>> anonymous folio mapped solely by an exiting process, because the folio
>>> go through swap-out and the releasing the swapspace and swp_entry.
>>>
>>> When system is low memory, it is more likely to occur, because more
>>> backend applidatuions will be killed.
>>>
>>> The modification is that shrink skips the non-shared anonymous folio
>>> solely mapped by an exting process and the folio is only released
>>> directly in the process exiting flow, which will save swap-out time
>>> and alleviate the load of the process exiting.
>>>
>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>> ---
>>>
>>> Change log:
>>> v4->v5:
>>> 1.Modify to skip non-shared anonymous folio only.
>>> 2.Update comments for pra->referenced = -1.
>>> v3->v4:
>>> 1.Modify that the unshared folios mapped only in exiting task are skip.
>>> v2->v3:
>>> Nothing.
>>> v1->v2:
>>> 1.The VM_EXITING added in v1 patch is removed, because it will fail
>>> to compile in 32-bit system.
>>>
>>>   mm/rmap.c   | 13 +++++++++++++
>>>   mm/vmscan.c |  7 ++++++-
>>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 26806b49a86f..5b5281d71dbb
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct folio 
>>> *folio,
>>>          int referenced = 0;
>>>          unsigned long start = address, ptes = 0;
>>>
>>> +       /*
>>> +        * Skip the non-shared anonymous folio mapped solely by
>>> +        * the single exiting process, and release it directly
>>> +        * in the process exiting.
>>> +        */
>>> +       if ((!atomic_read(&vma->vm_mm->mm_users) ||
>>> +               test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
>>> +               folio_test_anon(folio) && 
>>> folio_test_swapbacked(folio) &&
>>> +               !folio_likely_mapped_shared(folio)) {
>>> +               pra->referenced = -1;
>>> +               return false;
>>> +       }
>>> +
>>>          while (page_vma_mapped_walk(&pvmw)) {
>>>                  address = pvmw.address;
> Sure, I agree with your modification suggestions. This way, using PTL 
> indeed sure
> that the folio is mapped by this process.
> Thanks
>> As David suggested, what about the below?
>>
>> @@ -883,6 +870,21 @@ static bool folio_referenced_one(struct folio 
>> *folio,
>>                          continue;
>>                  }
>>
>> +               /*
>> +                * Skip the non-shared anonymous folio mapped solely by
>> +                * the single exiting process, and release it directly
>> +                * in the process exiting.
>> +                */
>> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +                                       test_bit(MMF_OOM_SKIP,
>> &vma->vm_mm->flags)) &&
>> +                               folio_test_anon(folio) &&
>> folio_test_swapbacked(folio) &&
>> + !folio_likely_mapped_shared(folio)) {
>> +                       pra->referenced = -1;
>> +                       page_vma_mapped_walk_done(&pvmw);
>> +                       return false;
>> +               }
>> +
>>                  if (pvmw.pte) {
>>                          if (lru_gen_enabled() &&
>>                              pte_young(ptep_get(pvmw.pte))) {
>>
>>
>> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
>> &vma->vm_mm->flags) is
>> correct (I think it is wrong).   For example, global_init can 
>> directly have it:
>>                  if (is_global_init(p)) {
>>                          can_oom_reap = false;
>>                          set_bit(MMF_OOM_SKIP, &mm->flags);
>>                          pr_info("oom killer %d (%s) has mm pinned by 
>> %d (%s)\n",
>>                                          task_pid_nr(victim), 
>> victim->comm,
>>                                          task_pid_nr(p), p->comm);
>>                          continue;
>>                  }
>>
>> And exit_mmap() automatically has MMF_OOM_SKIP.
>>
>> What is the purpose of this check? Is there a better way to determine
>> if a process is an
>> OOM target? What about check_stable_address_space() ?
> 1.Sorry, I overlook the situation with if (is_global_init(p)), 
> MMF_OOM_SKIP is indeed not suitable.
>
> 2.check_stable_address_space() can indicate oom_reaper, but it seems 
> unable to identify the situation where the process exits normally. 
> What about task_is_dying()? static inline bool task_is_dying(void) { 
> return tsk_is_oom_victim(current) || fatal_signal_pending(current) || 
> (current->flags & PF_EXITING); } Thanks
We can migrate task_is_dying() from mm/memcontrol.c to include/linux/oom.h
> static inline bool task_is_dying(void)
> {
>     return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
>         (current->flags & PF_EXITING);
> }

>>
>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 0761f91b407f..bae7a8bf6b3d
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -863,7 +863,12 @@ static enum folio_references 
>>> folio_check_references(struct folio *folio,
>>>          if (vm_flags & VM_LOCKED)
>>>                  return FOLIOREF_ACTIVATE;
>>>
>>> -       /* rmap lock contention: rotate */
>>> +       /*
>>> +        * There are two cases to consider.
>>> +        * 1) Rmap lock contention: rotate.
>>> +        * 2) Skip the non-shared anonymous folio mapped solely by
>>> +        *    the single exiting process.
>>> +        */
>>>          if (referenced_ptes == -1)
>>>                  return FOLIOREF_KEEP;
>>>
>>> -- 
>>> 2.39.0
>>>
>> Thanks
>> Barry
>


