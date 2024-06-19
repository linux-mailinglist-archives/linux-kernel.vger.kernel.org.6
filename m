Return-Path: <linux-kernel+bounces-220493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A590E27B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877D0B223F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D24CB4B;
	Wed, 19 Jun 2024 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hzI/pRFv"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18555882;
	Wed, 19 Jun 2024 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773133; cv=fail; b=DOCBvTOgSJGzewfWMvifjKbQEqe+HDiGHWJ6XiLiruESB1Iu89gM1eRuROzNHYCWGh/R/bActojS32FdDhX5qbDplCGgJptXydAJKnWocjnswVWv01zNvJ5Rhck1NlKsn/PwbOaJiV5ryrGyIkdqtXmsheG5JjG5rHtRi6P97J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773133; c=relaxed/simple;
	bh=HoiF/txQ0VN6ek29LK3nF2aUxvbyLAVn4cFT8Pjaops=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MVIHPo1XhK7B+UM0syRFJgb94Pwp7ea2OXIjZ0zOrLOxdrLe+K7Ao+LAx0x3qG0V3bd9TT7/MgCM+VrYUhwAO8d328gfZcvYkeDzmg85AOuByKO4V8k6lZDTx3zjD8UUx5Trm+V4YICVWGLK5l1r8Z8HgiCzmtpW2YCphjV/z6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hzI/pRFv; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE/oryB+hs6ZAdQ4XDB6sBf43D9uO5hCmyz34NPNv6Q5LiGcNsc4xKL5CEF7PA8vDmylWSg+80/naXVgrd3Hrx/JF2mlsI66l59CM4XAMbaLk64sa9YhOGhIy3dVdG/dHf2vqp92+qlQUQCtuAS7ukSrzdVUDTCXkTfp9X8PU81DzjeXU9ZcaFP2Z8fvqbxqpr85BuldwhLlorEBXK1H5hsaTCGJ7wrZdul9zBMWLhzQk2bDCyMPOnJYkJxQRxWbP+9/M2Muqf2Z+7X47+lEBaMr6JQe1w7IITIFcNhps/+ax49a6qM4EMIpC3UedGi91H8wErPX2yVfnGvbKg2Eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP7XjiQs1TU9JNQXv/QSHhTrF4s/9593tWjWEHxgS2s=;
 b=Z1jGracc9yCpJNl3L+OOHV4xlpaQl0HbZk9X/A8+dWR5XP2r/D0hMaPW+zhUyz8P4V/mHxWyAkhspIfO+uPqjHJLWCcucMXqST7CRDEc6G7KrHsb3+/evsShLCXpGDBLShJszn2K5d/2vtXdzWuW/e4JrOjRVYRukQHOtPMFK9T0AmE5cmo/L6IieSOT+SmkZg/SEQcBsxpAkyKjBlsOa+WqoRTlaK0AMidHofPHTQ+tl331ieACecDOepeTrxI4hdstarM3ZhQgmWAB5oDOtvOeo6A7FXRtKCPT/s/HGisg5ruAVpuAUA3AfslMKiaqLH8kDUJkCXpW/LlYcHkC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP7XjiQs1TU9JNQXv/QSHhTrF4s/9593tWjWEHxgS2s=;
 b=hzI/pRFveRBYtyZmT8/AQAb7ot6MYS42iCuaebTKl2pAx6HZ5cX9Uiha58JSVXkM5TO0tt3uPbbBHuNroatWhuGO66vmbJfKJUTw7C8CWxzWfjK3q481z50CLAL2zjpeZzzfzC8m0juinFGRVg5HYYXRMlYQXsBBgeHLpGc/MighmYXNoWt2HD1l9ptTWXw84q+QaO7ZaFgjil9ZrqBOe2ItKl075B716IgksEdbGelt1z2lGdu80ygKqpTiG0EGON3Qb78IH+273a+9LoefAkOOOnPlorxwI+JSCNoxeTbYanAe37oh7/8AkPxLMS/P0U0saRKTeJhUC0n8zaHc/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 19 Jun
 2024 04:58:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 04:58:46 +0000
Message-ID: <ebc4274e-14d3-4b47-b8b3-9a0083118d52@siemens.com>
Date: Wed, 19 Jun 2024 06:58:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ti: fix dtbs_check for some syscon bindings and DTS
 node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Andrew F. Davis" <afd@ti.com>
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b12a49-d06f-472c-5bc3-08dc901c7fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZZbmdmK1JxWXRYbWlERFNkUWdJOFVnaVZpYjdCZUIrMjU4N2w4TVBBSm5a?=
 =?utf-8?B?NURld1AyY2h6b3l0bTNvR2JkUCs0TW1jS0F6Z1VtTHBnL1VHRHRlcHJqeXBk?=
 =?utf-8?B?UzU0VVZFRHMvb1NJd2pwQm5YSk5xQW1VbW5kcFJDcmVBelM2U1V1TjRCMTZz?=
 =?utf-8?B?ZFpqcWhWRkhEcndUZE8wNThCL3Ria1JraXpMc3JTbVpYT0pNeTErT29KRTNp?=
 =?utf-8?B?c2w0WFlMdUtiSlZOVGpQdzE5bmRMUGh5dWhZRitoeHQxUHF6d01aSmlwQkgr?=
 =?utf-8?B?MnZLcXpTOWozNDY4ZG0zdTRBbWJDNUxhWjFUYWszbnBwR2huSzB1KzYwU2Ri?=
 =?utf-8?B?NkdjS2NQSFl3VDBVcDhSdjBTZGNJSzhHTmhHa0RtdGpjOU11R21sdzlLTzhU?=
 =?utf-8?B?OUdCeTVuU0VrNGtPaGlrS01iVFRuc3l1cUkzb2lqVDhpWm16MEE3VCtnWlY4?=
 =?utf-8?B?L1ArUWVobERlMlpGeFZNeUpxbXM4SkIzNlhGOHhteFNyczNGNmpLTi90dlZ4?=
 =?utf-8?B?dEFDMTN4V0NZZHRJOEdJZmFjbkltRG5xaVpSbkl1bU1LSk1valpQeDBmMzJ3?=
 =?utf-8?B?bE5tUkhmK2JGSWdmbkt1UDVOKy9BeU04a205aFVQa3ZGVURxU0NOUEROY3Rj?=
 =?utf-8?B?d1poNUFkYmo2ZTR1dmRxekhOUGlFNWR0WGROOFZudTY0WG13dlQzeVF3ZXM2?=
 =?utf-8?B?ZHlWYjFka2ZZaFpIVVZleENqSmxjMlhMOFBTVkNDQmQyZGZvdkhyNzZYZEs0?=
 =?utf-8?B?bERrSXJsTTRVU1l0WE52cll2NjRZSEpxdVQrbU9sQmNtZ2NDUjlycjdtYlRr?=
 =?utf-8?B?K1ZycE1TaUFpN2tMTlNuc294c3NkVmtpMjRaVUE1Yi9oaFR2OE90NTcrY1hJ?=
 =?utf-8?B?OWtlWDQ3dWVaWElOd2JMZHJsblM4Q1FhTWVFMy94bXZrT25EcU9tUnNRSzli?=
 =?utf-8?B?MU5taGsvOGN2SHhqdmdXN2dJbmQ5cDRreVd0YytINXhWcFNaUk9nU2hxM1NQ?=
 =?utf-8?B?RXc3V05Zc0tpdkpnRmUyNjNIaGFnd2MxZEgwVkYrZ3RzejgydGdHS2VnMmwz?=
 =?utf-8?B?cXZ3VUNYNFc5VU9GaVBwOGhheGdnVTAwVm5EcGFWUmorN2gxY1hiOVMzV1Ni?=
 =?utf-8?B?MU9zaG5NYklsVVZxTnphZ043T0YzMkJ5OU0wdGlERkc3SGNjOStIWlY1TjN6?=
 =?utf-8?B?aVJnaXdoVXlkRWl6V0VwTGcxMnMrODR0cWRpeDM0YzJhcHpJSEQ3b3F0Skcz?=
 =?utf-8?B?N2hpSUlhSUg3MnN6U1l5eWFEOVpiblZ2R3Z2TVE3cjRmNFZzZktpTmx4dlRX?=
 =?utf-8?B?ajZ2WU1UckIwMDZNeUFURlFGdlhZbldsUGJRU25mWm8vWUtiS3hTa1JCSCt4?=
 =?utf-8?B?KzZsdkE0Y2RVdXN3SGFJdjlSeFBWT3NRQUxRMTBEcXYzYW1Jc1B4RnZLSW1X?=
 =?utf-8?B?T2l6QXBXVmltbUpXb2c5dkhIY1R3aDB2M2JpSENUeldodnJjZnRhRFRuTGRx?=
 =?utf-8?B?aFFzTmJDbithZ3hUclEyOS9BZmtEMk56UzkvZGFYUnI3TjFRejlFMFRaL1dY?=
 =?utf-8?B?b2xrMFg3RDdWWEtOL1JhdG9IMzVxcDBwOWwzT0hPSEdSSDdSaWlaWUQ4SUdT?=
 =?utf-8?B?ZzBnbHd3SFZQdXBrTENsVWJ2Znh0bWZZMGFnY1NMT083bXY1N1hSVURodWJP?=
 =?utf-8?Q?NZC0wMChOlKrLc75Go2b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENuQlZWSzE0WjBuM2VsZ2lEYVRpbEJXaytpczVWR0VuODBCWVMzckY0OHdZ?=
 =?utf-8?B?QTk5WEhodHNJZmlubVpaNlpUdUZXQlREd1J1OUxjcEhCVDh3NEJxbFN0eTFP?=
 =?utf-8?B?enZKbkk3MjZHekRvWVpEd2JicGV4eDFOZW9GRmZDbU9rdlZjQmM3aVVJTDlJ?=
 =?utf-8?B?M3BDUXkyakNHNHNPZEVBMWp5ajQrR2RTTXFnSTQxeFBwYkh0ZnErd3dKd0tR?=
 =?utf-8?B?amlRNlBESE5kc2pSOWRFeUpHYnQ2VU5Zbm5ya2lJL1FUZzFVRzNtalRUekxJ?=
 =?utf-8?B?YjVwM003WGJKbW1VaHQxR0lzK3JNbUwvSFo5YzZRbkhtUDZzU284NHBRdUs1?=
 =?utf-8?B?NVE1OEw4OUNNTmJmVTVHcXlXY1kvYnZNMXlQUVlwL2lJV3dIZGtJZ2tPM3d6?=
 =?utf-8?B?dENhQnE4QnpsTG90YWV2Y3lBOUsyRnBxWXoxODl2ZVgva21oTUN6Y0RXSXl6?=
 =?utf-8?B?WUhuZmNyQmtFQ25kVjhsRzlSTitFSXhlMUxHOTA1QVl4NDhWcm94NTFDQitz?=
 =?utf-8?B?VDdUYmNVZlZzM1cvRXc4ZktGY3dNYkQ5NkV3cEIyWGpJYXZOd1FpdzN6V0Vz?=
 =?utf-8?B?THZlelc3ViszU3gxdWlTOE4zNThEbWt4R0JmRkpEb1dwaGl1VXZyVGc5UTVI?=
 =?utf-8?B?L0JTazFVOEI4OW5wejhGZ2NZdEhIeVE1THhwL0JHK1Z4aVIwTDdEdm9TKzNF?=
 =?utf-8?B?ZVZzMHlTMTlmVnBacUZkRmVvZTBIUVFabjQ2RlFxR2V6RGYyRlFPajU3NENJ?=
 =?utf-8?B?OXJHRU9lb0lHdjJqOGxSUjUwRnVPbGYwcHN4OVR0M0NEcjB1VC9aK3dlSUkz?=
 =?utf-8?B?WHYreUdQTjFLeHNBdFpXNE1YNkVHazA0Vm94VlpFN0l4dEJsZERZTWdiTjNN?=
 =?utf-8?B?elNLVmFQczdOcW55ZzR2MGhhVkRNVWg2NEdvUDdsd3cyaUxodGJjTnNLdyt0?=
 =?utf-8?B?U2FFRlhlakkxeFJLL2s1d1BJZkI3K2lvTzlBYzFsVTcrOTlaVDQxRS9IcWFt?=
 =?utf-8?B?VHNLOEdrY2orRy91Sld4d25teWZZWXpOa1ZwSk1QS25KUjFGbzVRRlN0aWdM?=
 =?utf-8?B?UWM3eHJmdHErSmJ5UjRYY20rcTBrRUl5WGxkWVMyL2ZYdGNHWWx1SkcrbnIv?=
 =?utf-8?B?SFhQVXdNQzNoeU1Hd2lvaThhdFlMM2Y4Y2MvMnNzS2RuL3RVVnhpSVVTcmdn?=
 =?utf-8?B?Zkp1NVI2OThFV2l6dm0xZWZDR2lCM0RxRHIwVms5VkJ5bmM2YU44aGcxODNU?=
 =?utf-8?B?Kzd2ektYT0tnSkVqaU91NHBFT3VCQ21XQ04rNTBzbXgzMVZvMGRybWRzUFRU?=
 =?utf-8?B?WjRXd3JYb21LSldYa0NiK2VCcEtPOFc4b21LcllzYU9XVlhjRFpsa2liYzBz?=
 =?utf-8?B?TFBmMGtWQWxRc002ZzFsVnBLTmZkS3VnSGdLUVE1ZVlSbWRYQnd2S0RYZ2pi?=
 =?utf-8?B?MEtkbitNeGNhbkVWYU1QaXNvQjBZSmREL0VBY3Y0N3F1M1NtbmQxMTBBdm9v?=
 =?utf-8?B?dWRZekEwcUtGTzdGZlBEL1JHRGdIODNJeEVFcnVLa1dPNnltR2hCOVREUzU5?=
 =?utf-8?B?cXlOQ1o2cEZ4TXBRSHVDY2VSOTR5Q29SUVhCN0UydTUyYURzMnYyVWVTdEJ4?=
 =?utf-8?B?UTk5WjhWb2N2ZkpyWkR0OFNhc1orSkJlek5UUzlhVFZDN0NwaGRaVmRtdDZB?=
 =?utf-8?B?cTBTangvS1RjeUkwUjNqMUMwMzdlNlRYZVVkbFlnWjI0Y0tmWjR4VXdPaGhp?=
 =?utf-8?B?aEttbHlyZk5LOHBGNnpJS0FwZEZ4YUFVZzlKZnFWTHpHMkxyNjlvdEZiY29D?=
 =?utf-8?B?VndOdzhuZG53RlRDb3RGak94VzJyS3cyWDRHZUhCLzBZaytXZTcrMmp2QTBT?=
 =?utf-8?B?SFB5M2tYbUpxc0NyR1lyQUtpRnhXZ3AreWx1Z0NUNExFbTRQckJRZGk3WGtY?=
 =?utf-8?B?b0JmZVBwakc0V2JibmY2OE9xUm5rVlJvTnNPS1NkNDByUUpGU2tTclRyMUtB?=
 =?utf-8?B?NG1vVWlUL3RGazFIdmNKMXNlRHNmWitGNDN1cnpQQnF4M0hDeUs3aVIySTBF?=
 =?utf-8?B?UU0vMW1kcEhoKzEyems3TktueU9ta29kUUs5MWV2REpHdjVDbEowZG96bGVB?=
 =?utf-8?B?bm5XNnpad3ROYUxsandENURlc0F4UkxqbVF6Ky9VV1JmaHRjZmZkZFZKQlRG?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b12a49-d06f-472c-5bc3-08dc901c7fe9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 04:58:46.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQPis4RKS+3tcUVFI5Il7ni5ldr4VaJik55Mw6spwRyOhP/dsFOFmyfQN2H9jTTCLwuG5dIpRc2kQpOUeflKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6523

On 18.05.24 22:07, Krzysztof Kozlowski wrote:
> Hi,
> 
> I am in the process of fixing syscon/simple-mfd bindings (to be posted
> separately) and found set of issues in TI looking independent of my
> series.  Please apply via TI SoC.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>       dt-bindings: soc: ti: am62-system-controller: add AM62 syscon
>       dt-bindings: soc: ti: am645-system-controller: add AM654 syscon
>       arm64: dts: ti: k3-am62: add dedicated wakeup controller compatible
>       arm64: dts: ti: k3-am65-mcu: add dedicated wakeup controller compatible
>       arm64: dts: ti: k3-am62a: use a specific MCU controller compatible
> 
>  .../bindings/soc/ti/ti,am62-system-controller.yaml | 77 ++++++++++++++++++++++
>  .../soc/ti/ti,am654-system-controller.yaml         | 60 +++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |  2 +-
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |  2 +-
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  2 +-
>  5 files changed, 140 insertions(+), 3 deletions(-)
> ---
> base-commit: e032bb82c315d2317a80506195d16ce4308d8cf7
> change-id: 20240518-dt-bindings-ti-soc-mfd-ac211578d7a5
> 
> Best regards,

Good to see progress here! Helps us finding our own issues while adding 
things to the affected targets.

But you didn't address this ones yet:

.../arch/arm64/boot/dts/ti/k3-am654-base-board.dtb: scm-conf@100000: compatible: ['syscon', 'simple-mfd'] is too short
        from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
(plus our IOT2050 boards, all via k3-am65-main.dtsi)

And a number of other boards seem to lack adoption of the new wakeup 
controller binding if I get this correctly:

.../arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
        from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
.../arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
        from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
  DTC_CHK arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb
.../arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
        from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
.../arch/arm64/boot/dts/ti/k3-j721e-sk.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
        from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
  DTC_CHK arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dtb
.../arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
        from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
  DTC_CHK arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb
.../arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
        from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#

Forgotten?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


