Return-Path: <linux-kernel+bounces-326072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A0976221
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A8DB2164D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C018BBAE;
	Thu, 12 Sep 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="B9SjkHAT"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642318950A;
	Thu, 12 Sep 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124723; cv=fail; b=iYS6+/4Kle+8TKHE1sRzf+CR05TcIA8rSPz2K8ZV/siZssS4uLkPfvCRLlmBZz49ZgTlgyY1wsLlmmD9aIkGdFByy88L6WzINTdi/LqIebBUyC7F0GWwN6isJNsJbHmICEyNkKyO6PN4RVbL/VV2vOWLJ2NYPg4IjAELWFCVQ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124723; c=relaxed/simple;
	bh=MSOBo6GSedwgdzJV58UweWNT3l7NbpCNSefqErEYvn0=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=A6OWxPhvqv/hj3sbiWLZXM4ZjLDLiQ79jsqUkivTtbRKHAIKn8k/q1MCg0GJKbw7Gb5+J694c3H9mnFXZ8FDUmqYDXbPvhFZZmZjGI7PkoOT1NvegYm7CXqbI6r1HkN+fEO/b2tuMEgbe1RWFGyAL38V4jx6QjE0qBKAGQ5IBF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=B9SjkHAT; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV4RIe0w0IcTOYIPEa+LGDpkxLjn1rNzi5UKTyzYWNw7x6n7nmjv44geP60rZyRyuHNsFZy1KcR4DnUf+cDzxgZur6epMfk9s79ffw+TlgZdoU4bEhzVz6UEBKis8fHwoZeYP6eHbWNpg/A+VtG94LAm+vWNzy7zGeBzPouZNYJVCV69FBGTwr4gql6lr9mO1lytEpTd1fW9FHegar0EGttwWgZsGeF09kgf1NQcGeeG151HlXXmjb00GcMtfBkk0N1xxF1hZOTzWGtfhWiMNUwy1MMr+l46ZFTurPvW+LnXwfOzCLFuGV80PST52P/hp6msiuvju0PYGf/Yl28ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT4udsYdUlOrPL/pzGbryYdu42VtNCls+SWefI4bNDw=;
 b=Y/2UV7zJf/dorr+ihhiwoAWAPchFuAE5Jo9D7z8+y3NXbK/bC5160A5rsd9rtHyUHezEMHtUclle+BjBdDBannSzrlTToVsTuOpcvTWxvnOhf3zvBSzTJcOXw/dupo4ZJ4fpv0ENr5Lw+UcMK0Hm9tkwDCjQJPO6NYsqTNGEfUwLedbqq272kCoS/AK1kfwx825clbRmE0YemnpppPIxRyo6GtqdtwMD1UTioWfnSjqyruztgK32ZTGdUXf+dTtubn36+4RV6FltqYkvEPD83UnJ3sMTRTtq7vk+Ze4z/GZzYdTEWo8AwXwLgs33bSVp7Mu3vNh/6uwcH6vLGV1kLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT4udsYdUlOrPL/pzGbryYdu42VtNCls+SWefI4bNDw=;
 b=B9SjkHAT6U6zIWUcb9asrUz3j9AUteq4usB/P/vCYT2itwG8GOWk+zxCpPgg+11WxGiZ3nogbcFAv3Hje0vjej0t5u6bg1FfTF+aUhjjF6klVFzdJh4j6u02udisq7gncIqfdOYY622Elp2g04lcT1m8BTCLbNKEsr0e3vedcPGLPmRoljyyt9aZ6vrSc8CDes1f1cbhqbh62vvR4UlY1XL1M/MIgotyo1GVDTk4+PbsoTSIbCgvSwA2TSMQ37hwuVMf/8vgUZwKmzMTwkHgT4BDFmtH4DXh15ujnbywUmt8zSffCGlz1WRCk2I5zq9MrXBi7arraDKO2UqwnSMZtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5797.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:504::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 07:05:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 07:05:17 +0000
Message-ID: <ecfefb25-7ce9-4a74-9708-f08d51d03ec1@siemens.com>
Date: Thu, 12 Sep 2024 09:05:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] USB: serial: pl2303: account for deficits of clones
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 2519d0f1-e9ae-42c5-0f9d-08dcd2f94197
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGoxWFk3TXBsQmJ4VjM3WmZ4bk5La1k2MjJFcnlteVB4clpvV3gzTjBJTVBp?=
 =?utf-8?B?bXBuOEFianFFVXZOTXNSMHQ5RFM2Tllra09lWStIZzQwU1hkRGMrekpTS3Fx?=
 =?utf-8?B?c2FkcHJlRStCYVhiV3ZqRWl2MzBlNkUwMlJ6ZTlvVnVyTC9oWWYwaHYvc3cx?=
 =?utf-8?B?UTZTSTNYTDhBclFuL09lYlFkbHJqRkxWam1KR21rTW0xN1c0RERNY0FpaEVw?=
 =?utf-8?B?ZWk3elJKSW5nejU2TnI1UXVYcWEweEJYQkhMeWxScFpmeWd1N1ExSDRpaU4y?=
 =?utf-8?B?cDhGVS9pZjZFcS9Wa1V5K2xqbjQ3S2QweG5XQ1RVYWJXV3FCSkVGRHE0d1NR?=
 =?utf-8?B?cTdHd0JkNlQyMFlLWTZsWmhtMk9xV1h1d25VUzNDME54MEU5Y1pXU0VJaGNq?=
 =?utf-8?B?cDgzN3gzaTZtOUx4d0E1K1VQaWtud0R1aEtJS2htTzBEaFJYTkJRWkhReVlP?=
 =?utf-8?B?clo0S1l4TnYzMEZnRmxvVXA2TkNYbjZpSDczanY0SVFIcTNobUVVSkZzZ0V0?=
 =?utf-8?B?a0NCc0c5TDNVclJBeGRGSVR5RDVNeGdiVUx4ampvUlhLVUwxdG1ycld2dDA4?=
 =?utf-8?B?YWFQT2xCMXIvTTkrNXM0VHFsNG5LdmxGVk43UXA0MzNVNmFWMWxZMVVaVGdQ?=
 =?utf-8?B?RTcxL0phV0lKMjBDZlpzeHB0a2RBbUt0bFFndFUrSFVhZ1ArOHRFV3lFa2Rq?=
 =?utf-8?B?Yytjd1RyM215dkJPWnJvOUl5YnlzMHB6ME5LOGVCdXNkTVQ5NDQrRjVtOGNo?=
 =?utf-8?B?UVdSNXgvOVNQZE1xejgyYlMzczhDWkxwaFRHUldELzBjVlRzZGx2MzBZeEpp?=
 =?utf-8?B?UFF4eVRTSG9OeWl0Rk9Vamhla1hiTzZtZmFNYVpjVlpWaFFZTTR6S1BqQTlX?=
 =?utf-8?B?aEV4MVk3SUdPQTVwS3BJY2kxMm5pM2t5dmJ6OFlWUzZucTJDNlMraGtxZjBR?=
 =?utf-8?B?NTlEZEhJTUVSbGdFcjVzRnJtczBDQnVSUXI4T0RCcTNSWkdJL3YyOW45NlVL?=
 =?utf-8?B?NWtzbjE4OGJjckk1azg0dE1BUElBc2xBQlNCbVdUMTJTV1h5ZnRBNXNNcFVE?=
 =?utf-8?B?OGVYdmZjaUUzajU2MTJsQ1YzL2lRWW9xSVlDVzB3b0dKczBURER5RnBGYUpn?=
 =?utf-8?B?dElYa1VIeUZBbFpBd0NTQzVGbTkvNXluaEI3djVFdGk4QkxCcUdkbkdiK3Vt?=
 =?utf-8?B?OEpEL1UrZGNJNnlaZGcwUTJJRWhxeWpOQ0ZvUzcyY0pCMWNLSzFIQ0I5TXpa?=
 =?utf-8?B?c3VFVU5YU055d21kUDgvZDFoYWIzbUd5Y0FGbjUzcitTeVhmLzRuS2hiWEFy?=
 =?utf-8?B?N0h3c09GTzZST2xvR1BBVkJVV2ZiVm83L1Zod3FGbUc3d1U5TXNuK1ZENDl6?=
 =?utf-8?B?RXc3MXlMWTZOS09lZDBYQjdQQWJYUlJNMXpNTHliSWZiNXhNRHBSOUk0SEx5?=
 =?utf-8?B?Ykk1eEdMeWFHLzZ0eVBSdVd5NGJMbnNGZy9pY3B2U3JkNEVmSXB2RzdhQ25a?=
 =?utf-8?B?UWQ2MDh3QVI1cCtHdm1BTEdzZWV6bWN5eHdpRlZjWk9JV2pITHlwZWtPYW5j?=
 =?utf-8?B?Y3dlbkQvOUtBckhQWUhwL3dqZ0U5b29zMUVmcHAzYTErVWJoMmdmOEh5Vkdu?=
 =?utf-8?B?WitnN2d3NElmdlRXOE9WYUxvUEtINmZHbTVvMkJPRFp2eHRHZTc0cGc5VHYv?=
 =?utf-8?B?ZkNBVEFiaDQ3WHI5MTAvTVR2eTh0eDVYRGQ0REdvbGpKSE1jb2VJVG5JTXFm?=
 =?utf-8?B?eTlrd3FRRWM5MHdmRHNKSDI3eXJ3TTE1ejBWWWRtbThXSFpnVVdVdTRmNVdH?=
 =?utf-8?B?Q3p2MGtjOWFBMGdmWXpJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFaQkhOa0ZKb1ZVdTBhTkVRM2Q0ZExFWTE1cHJML1RncTM3NDc4eFF2TG9p?=
 =?utf-8?B?WWZYcklsWDhodjFCdHcxd2U3b2pBWHE1endwZ2lPdGtIV3ZvZVAvWjBQMVps?=
 =?utf-8?B?a1FrYmNtSUpkNG1nRnZGOU9TcmR3U3BBRUowMWpEd2taSDRIcXNOdmV2VHlG?=
 =?utf-8?B?anlYRHNPcVoyVldQdTRXa1NMR0JzQU9RTmloUzVuR2syL3YwTm5hRHFOYXQ0?=
 =?utf-8?B?ZmI3K3F5T3NabnlrUHRNNHJwOU9xeWludms3V0JUNFhGd2ZKUno1eFVVWklo?=
 =?utf-8?B?QTJjdWZ3YWQyZnNxRytGWTFjdm9MbjBmQnZLVEU0MFoyK3VWRlV4bDJyUXZ0?=
 =?utf-8?B?cmhMVG02T2t4eW82N2ViSlVlc0Iydk5lL1BQUk50VFNuNTBwcU1QYTRReU1X?=
 =?utf-8?B?amdrOWV0YVY5TGdKWkJhUjU1ZDBlTVVNSGQ2RVptYWxBN3lWWTRnc3JoazVZ?=
 =?utf-8?B?SXlBcThJVkJ1ME1sSGVsc3JPNzVvY0hiZVdURDAvQVJVZWNUU0Y5WDlNMmQy?=
 =?utf-8?B?U3NoQWdXcVB5ZGh3UStmVThQTUlXS0xPWXkzcWJMUHVnZDFycm05QUd0R1pu?=
 =?utf-8?B?aDFMd1pLWTVtTDdYT0NmcmFjWVBLUXErNUFRTWh2R3ZaSDFDODRPbkJSQmpH?=
 =?utf-8?B?ZjVzY1pHMEhzUndoYkcxQlFBOURpUm93NjB4QUZEMW0vZmdocjN1NlQ1VkJ4?=
 =?utf-8?B?WHlKVDIvUmJSODdiU1Bsc2dGc2F5QVVTaHRoaG52Z0U4U1krUlZ1UmN0RTZP?=
 =?utf-8?B?YVFZeHl2cUpSdFZyRWNtcll2T0xmb3VvbElrcU9Sa2hSWERBQlJwVUpyelBn?=
 =?utf-8?B?b0o3UDlBSHZkUVkra0U2K3lmUVh2TlRUNXVFSW9qS3BzeEN0ZzdtNVMwS1dN?=
 =?utf-8?B?TGFibTliVUJFREJNNVlQN0o5YmdrMm04VkE1a1FaSlVEZU8zK1JNZVdoTFdn?=
 =?utf-8?B?WTE2SFhRNTV4TjhhK3dJZE40NVhFcnZQTjd5TUFHNDA5a3g2MlJyYVdPUktQ?=
 =?utf-8?B?SVVlay9tOUJnUStZajdOLzdTMWJzQzdUZDduZGZVQzBaV1NiVkIrNmEyM1Yy?=
 =?utf-8?B?dUhMa2c0blBKN2tpNHV6TzNpeG5acUVCQytjbWpCSlRjRTV4ZTBpYWRJeHQ5?=
 =?utf-8?B?YlhtRFZZQ2IrU0xPakFKa1F6SXRpR3ltTHBSK1JLR0FxcExsc2FTRzlQdVlY?=
 =?utf-8?B?OXVrM3RsTmRZWjBJdVRid2lGNGtLUXNpM2lSenROSzhnNVpWc0NVYU9UeWpT?=
 =?utf-8?B?aDdncUtZRkxJa21hVVU4SFBJZjN2N3lQTVNUanEzZUtyVjltY3Z2cmMxNjho?=
 =?utf-8?B?SURNb2pySStveG5yT1A0NW15cDFONUcvVUhsQmhxaW1TWUJ5bzRQU21CczJ0?=
 =?utf-8?B?eVdWQmYrU0ppMGkwa2Noa1RHMTFpUDRGNW9LaVhGZ250SzR6cm1wdGc3TnZX?=
 =?utf-8?B?Y3NJUnhKdnZBQ2w2a1VWL0xSWEZYZHIxV2FLQUxMcjJZTmRyZGw4MXdrZGVj?=
 =?utf-8?B?TXpyMXBjY0xPak1wNEllTTBoZlpoSVp3NllVOHIzSThDRmJiR0lJWHBjWHFa?=
 =?utf-8?B?cHZyVnlpSnk0TVFnRHlneG5PazJwT21CSHNEc3kyYlQ0ODAvWnQyQXh2U2FS?=
 =?utf-8?B?OVg4WkdGNmxoOG9wUmUvQ0RDWlhsSnJ4NCtWNFFWYU1QaFNWbEJWR2ZUTGlo?=
 =?utf-8?B?Zk8yQW80UUo2cWxKU2dOSlhmcXRERmRkcEJhTlhPQSsvTDdaR1BGeEhsRENV?=
 =?utf-8?B?SXRXNHhIU29QaFFBSDlja2w3bzgwNG5EcHdBNDg1YUZiV0dvOE5JcW1wdGpH?=
 =?utf-8?B?MDgrV1U3WVZXcmx5M05tdzNtRFJhSm9ORmtsYkVqNXlPM3NlMWN3WlhzMFl3?=
 =?utf-8?B?NkpmT1JWVkV2NUZPSCs0ZU5aM1M1Y25wd09Jdk9sei9PRGxtRENCQllDTTBY?=
 =?utf-8?B?TWo5RGpxWVExdThFS0pWclFka29hNnJBdnJuNytPcHpEZDg1dTdEUDNkSlZ4?=
 =?utf-8?B?WUFBQ0l1elIvYlp1YWRkVmpqanRqaENITDRUWHFwT3BqSG5TaVR5d0gxT1hQ?=
 =?utf-8?B?TzFzWEVMaVd6MldnTkh0NWtEZm1LQ1ZtaCtURCtjREQ4NGZ1eTFjZ1oyV3Jx?=
 =?utf-8?B?WG1OMi9Tb1cyc3dYRGg3TXlpSS9iVmxLb1VXQ2lzRVRKS21PYks4ZHNNWGRj?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2519d0f1-e9ae-42c5-0f9d-08dcd2f94197
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 07:05:16.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HWO1Jv17Sr7k7IQWUkISl1NP9Xdu6rUKJmDDbZrjHbo3O2RT7ZNzRRr4uf/1vEf+4jZppMik/1Nn5dFYUEGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5797

From: Jan Kiszka <jan.kiszka@siemens.com>

There are apparently incomplete clones of the HXD type chip in use.
Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
flooding the kernel log with those errors. Detect them during startup
and then use the line_settings cache instead of GET_LINE_REQUEST. Signal
missing break support via -ENOTTY.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - probe for clone and avoid unsupported requests further on

 drivers/usb/serial/pl2303.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..a61ae0d0c4ac 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -181,6 +181,7 @@ enum pl2303_type {
 	TYPE_TA,
 	TYPE_TB,
 	TYPE_HXD,
+	TYPE_HXD_CLONE,
 	TYPE_HXN,
 	TYPE_COUNT
 };
@@ -192,6 +193,7 @@ struct pl2303_type_data {
 	unsigned int no_autoxonxoff:1;
 	unsigned int no_divisors:1;
 	unsigned int alt_divisors:1;
+	unsigned int no_break_getline:1;
 };
 
 struct pl2303_serial_private {
@@ -232,6 +234,11 @@ static const struct pl2303_type_data pl2303_type_data[TYPE_COUNT] = {
 		.name			= "HXD",
 		.max_baud_rate		= 12000000,
 	},
+	[TYPE_HXD_CLONE] = {
+		.name			= "HXD",
+		.max_baud_rate		= 12000000,
+		.no_break_getline	= true,
+	},
 	[TYPE_HXN] = {
 		.name			= "G",
 		.max_baud_rate		= 12000000,
@@ -466,6 +473,28 @@ static int pl2303_detect_type(struct usb_serial *serial)
 	return -ENODEV;
 }
 
+static bool pl2303_is_hxd_clone(struct usb_serial *serial)
+{
+	struct usb_device *udev = serial->dev;
+	unsigned char *buf;
+	int ret;
+
+	buf = kmalloc(7, GFP_KERNEL);
+	if (!buf) {
+		dev_err(&serial->interface->dev,
+			"could not check for clone type, not enough memory\n");
+		return false;
+	}
+
+	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+			      GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
+			      0, 0, buf, 7, 100);
+
+	kfree(buf);
+
+	return ret == -EPIPE;
+}
+
 static int pl2303_startup(struct usb_serial *serial)
 {
 	struct pl2303_serial_private *spriv;
@@ -484,6 +513,9 @@ static int pl2303_startup(struct usb_serial *serial)
 	if (!spriv)
 		return -ENOMEM;
 
+	if (type == TYPE_HXD && pl2303_is_hxd_clone(serial))
+		type = TYPE_HXD_CLONE;
+
 	spriv->type = &pl2303_type_data[type];
 	spriv->quirks = (unsigned long)usb_get_serial_data(serial);
 	spriv->quirks |= spriv->type->quirks;
@@ -724,9 +756,18 @@ static void pl2303_encode_baud_rate(struct tty_struct *tty,
 static int pl2303_get_line_request(struct usb_serial_port *port,
 							unsigned char buf[7])
 {
-	struct usb_device *udev = port->serial->dev;
+	struct usb_serial *serial = port->serial;
+	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
+	struct usb_device *udev = serial->dev;
 	int ret;
 
+	if (spriv->type->no_break_getline) {
+		struct pl2303_private *priv = usb_get_serial_port_data(port);
+
+		memcpy(buf, priv->line_settings, 7);
+		return 0;
+	}
+
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
 				0, 0, buf, 7, 100);
@@ -1063,9 +1104,13 @@ static int pl2303_carrier_raised(struct usb_serial_port *port)
 static int pl2303_set_break(struct usb_serial_port *port, bool enable)
 {
 	struct usb_serial *serial = port->serial;
+	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
 	u16 state;
 	int result;
 
+	if (spriv->type->no_break_getline)
+		return -ENOTTY;
+
 	if (enable)
 		state = BREAK_ON;
 	else
-- 
2.43.0

