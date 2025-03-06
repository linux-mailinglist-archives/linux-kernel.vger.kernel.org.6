Return-Path: <linux-kernel+bounces-548480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD3A54564
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536363A6CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064211A83ED;
	Thu,  6 Mar 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="TFDHcBg3"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2125.outbound.protection.outlook.com [40.107.215.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34B1A725A;
	Thu,  6 Mar 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251115; cv=fail; b=QdfwvzDNOjb4ZSgnK6VR81EKrJkddLD5cchLt55F4+hLECY6EE13p/L+DowqepHiPIvHM5edK0yhRF+GR6Unysb+/1CIaqjVCUixAsPVm0Hxu8FA+fwiUeFZgtLqjgv6m6VS7J2PAGXZHfvHXfH5tiyw+kiwMfDGVuGQPyUEfRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251115; c=relaxed/simple;
	bh=s5vuAVlCHfXXte8fYxbqaf0Ix1RZcFn+i9zWztdiTME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q1NUm1BzG7z3QWfzfEDst1Dv0DJMEOpr48NzBcKgxFia6UFOEpkmbOrDlw04z3GsYEmSq6/T4KHwmQyGVA6mqCWzaAr/JGcciI+P0OcofZB+oMCU5dVwKTtqxxodvXWhhroPJKHEtYvdqXhku6LD774OPM/BiHUoFaLtcCilucw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=TFDHcBg3; arc=fail smtp.client-ip=40.107.215.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXOOt6s48F+AXNfStx+oeKiH3O5hMGfZVrjX48zSp3/5PXTrulSxiUsK2wS0A72zUQ+gT3az4+7mkFNSKMv+nMWOW9xnS7ESOR/26GHMyTL7T5SchSkGQSHaGGuIHshB8AVkSFN2FgZdoVJPaNy+Tig7P7OEgvne3w7wvaEHHEO2iCawdZIbrdjOS9qL8GqWg4GtbiKIYKaG5gCdMTKqsySecygCITZ5h8tSiL0+UP4imZwIqtyrlx8V2jvGmQcWrQMwMMJDLLvKfiXxXpJUTDbu3w6OO7vYIfdOQaPK6CetSdNUQuvI6Uxm7BLAmjJwHZ4M11vEcUF7oxQyN8cNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIXQnb62SVDrnK5FF+vql9EuqBlYJZ4gKuPwjB6XXiA=;
 b=Ja2/arNF5CA5U73SpR6Mpp6eaiv1f+L7JCSZNbHkdBwYbdUXxnHXDC+raO80PBnQDCptR6M5rzvlKDY2zMV/MQDqU/O3ckd7G3GsP6gCsmWWJfxiuGEEh2Ns5NOk2hNroz8HbkEdwR3VrZigdQRdcc0eeiZyp1ywYFKF+d3gQpKKC0xX1zZI+/Vd+t+GfJRiFyrIAw+pJUMqUqBOJ/jRf11s6qa3XtDmAawSuPV+1UAtTi/79Hsi7PrWW+5BrU4hdXCdQNNJfQQArTj+kSjvQBLFNuepgm+yTZSweWibgtil3gYqG/37jrb5b40JgfxuX3ZCcVGIHtADcfSAu5E0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIXQnb62SVDrnK5FF+vql9EuqBlYJZ4gKuPwjB6XXiA=;
 b=TFDHcBg3w/yO4Wdp+ZGAk3iY4cADJ/ZBJuOtEHHGvVCU03itqq202+y1fLb4Cp2TnWIWvbOfldVqTZ0gEGKPtG0SrrAPGK5xeFkd4gQnnAvSeAqNQR6cAHatJSN1Qt2bBNI5aJp1DLEHNYJ6aL6woYZ9WUwyhBaDL0EN4F/rS1CxAtCLcm1B93n9j2W46aiX1/MCQ/acbVZCP/6X4EuU9wSy3GT22LhHuCmVXDu3aKCVbZESr/8dsFJrdaLZCZMr4GUZ+dcGELfAyv0WDwblpOuqUBSMngVpmDTuB1pqPWbaiIMNSJxp3kBoDIz2qkZ+t4vuIWXfJDSeT6DEcSsdCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB7370.apcprd03.prod.outlook.com (2603:1096:400:414::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 08:51:47 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 08:51:47 +0000
Message-ID: <5631fbe4-54a4-447f-ad45-e69d9484919b@amlogic.com>
Date: Thu, 6 Mar 2025 16:51:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: Add support for
 Amlogic A4 and A5 SoCsy
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
 <20250305-irqchip-gpio-a4-a5-v3-1-1eec70352fea@amlogic.com>
 <20250305-corral-unfair-a7f25abbfd64@spud>
 <20250305170723.GA2143418-robh@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250305170723.GA2143418-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: af84a791-75f1-4790-89e0-08dd5c8c20ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkZmclhhUWlyRXpXZ2lCTnRwL0F4RDhNa0c3MkNCb0ZFdHhGQ0Exdld0V2pn?=
 =?utf-8?B?Q25Xc2JHb3Q1ZFVETVQ3U0g5T1B2ODQwOE9QY2Z2TGFvWGIvam9KTGlkUVNV?=
 =?utf-8?B?enYxUG44ZzZudWl6TEJQaXQ0Wi9aZGNJZ2RpcGtkK3gva24zTzNNSngzeFBY?=
 =?utf-8?B?WGk2U21CYU1rcGREOXFSdWVtOUtFd3FwT0ZTcTVFQkdFTU1sc0VlZS8rMEYy?=
 =?utf-8?B?Y29XWmZ5MTFHSm00UkUyd2xvb0VQRUlPa1Rrcm5vMkIrVi8zQTFVbW1UMWRY?=
 =?utf-8?B?czBLSVRnaCtQc1BZNFZ6OFk5bTdLek5IbWVTMVBucE9xRFBOVVRqMUluTWNm?=
 =?utf-8?B?K2JPaEJ1UlE2a1dRdVNPaDJSVi9sTy80Mzl6b2lRb0ZaK014SHV0ZC9YTlNU?=
 =?utf-8?B?aDFqTEpQSWd6MDJkbWFTaTRBa3JEcXVsTlcybTBLZW9pVUEzUjZPZUNZRmdJ?=
 =?utf-8?B?M2pTOU44VlNwWkkxS0s2ZVZ2dFhvRDVVRFRKSWFlMU0ybXZmTjg0WVppVEZJ?=
 =?utf-8?B?UDBLK1h5Qms3VXNNM2gzYkd6bU1Zc3ZJSUx1STFJMGRHdWtjVUN1QzhnTG1m?=
 =?utf-8?B?YnNwZlVHQnNzNkFETnVIQ1M4T0ZabUxMSy8vU2QyaytZdmpxZTQzZUtpeW5H?=
 =?utf-8?B?YVhLWjBsYXZ2RXBpSzNQRXRuZ0RVaDNHTVQ2Ui9KTU5xNlNLYk5jR0txNkJK?=
 =?utf-8?B?UFFycU9xWk1FeXRVOTQ1aDhoOE1vbDZqaE1zQmhSWng0UXQxcC9nREdJaFl2?=
 =?utf-8?B?T2tQQnpTNVNTMitlRDZPbmJVUFhtZWZjNzRGdzdXQjFNdHhtbEhKTyt5a1Ir?=
 =?utf-8?B?V2RCWTRobzFhUFBuR1pWcDYvcEM5azZkVEJkWXhJaGttVlpwbVpxUnRjSHhT?=
 =?utf-8?B?bDJJRjdWK3ZpRGF3SVdncXFqRlBKMTVtYkt5Q1JHcEdyRUJ0UzNFaVFwWlBW?=
 =?utf-8?B?OGVkV2lIcnJ1dEJWM1NwVVpZaWNUbzlNakpPMHM3WDlCOVlJb0Zpb1NMZnRw?=
 =?utf-8?B?ejRjQ2NmNlF3OFJnN3Bwak0yOC9vNWNEeThQUFY0Umw3b1g2cVI3M2U3NWQz?=
 =?utf-8?B?b0c2dVRrKzUvdEllWkh2UStyZFF1N0NBdm9Bd3V4RWVxWVBsMkJrYkdlK291?=
 =?utf-8?B?c1ZSUXc0a2FldXJHSmZqdUJMYVJJNHRDV3ZtaXpjeHpqRjlyaGw3aWtvVklG?=
 =?utf-8?B?aENQMGlQRjhGRHFwVWxGOE9VM0h1WU9xWHB0UUtWKzQ1eFdQSytCNGJuWFdK?=
 =?utf-8?B?N2ZNTnRNOWV0dXBobXlaYVE5NGw5dVB0UDVISmtwTnc3Z1ovd2xUY2xrejZI?=
 =?utf-8?B?VFgxME1lREZSZWgzL0xsTHRvSFptc3g5bWtuaURvbEdqMExQemUyekRYMUxY?=
 =?utf-8?B?TWUyQ0toZDFUbkZtY2VqdTlGdUs0NlV4Yzk5ejZHeXBtNFZUSS94QytoNldU?=
 =?utf-8?B?ZGFRSkNob2pnbVA5RmNsOFRIWGxVeldtMndHdTkrOVdhM01IaVFMSkY3MkhC?=
 =?utf-8?B?cmJad2dNbVpKYVlUK0d3bGhmaE9DYTdGMUVPSDBlb1RRbzE3RXVHdE5jRXVS?=
 =?utf-8?B?ZmhrWTRRR254bmt5VXF0N0lmSmNSYzdNZXEybFpsVkdERVpkaU11NjZwNXI1?=
 =?utf-8?B?MzJyRVlVVm91bDJocjE0eTVKbyttQzFzRlN1V0kyZkR2TDl2ckdBanlsVmVN?=
 =?utf-8?B?RHNiOTJCZ0I5TU5TOTJKazNNQzYrbk9aV0xqNFdtR3BKTVlSbEVocU5RRmhh?=
 =?utf-8?B?K21KSWZ0TUFaZStzRXVzdmFyRXJoMUhWVFNnZXZUTVFwZ05yTEY0VFFEYjZx?=
 =?utf-8?B?b1pDMVM0Tkk1RS9janlvVjhycU4vZUI1MHdpVnFoTk5FRHI1eEw3YWdQa3FJ?=
 =?utf-8?Q?1xtKddouvMIfe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm5NQUNMY1Vodmc1S3FMaGVEblBuZCtORkVaMXhzbHN6enIzTVlJM0pWdkxp?=
 =?utf-8?B?aENnenV4L1RtMVBaTEJxUTdOeUNZemw4cjgzWk91RG1IbW1XdmNTbzhJekpK?=
 =?utf-8?B?VTczdWdMc2E1aXBUYnpXU1p5OXJab1M5Z1dpYkpFSGY4bHYrZGNYM0RUbGJu?=
 =?utf-8?B?MVNHem43dm0rTHpjdHV6YjN3NFp6K29CZWJhRm9TY1BiTXU2WndGMk9OODRi?=
 =?utf-8?B?QTg1bU1UTlNhY2RjK2FPVzVDTW45NzdrRFVJM24xak5RM0RHeGRmdTUyOThN?=
 =?utf-8?B?ZjhvZDlFRHorUkFnTXhFeXpYN09QNGsvWFBEU1R3K3plRENSdFEwZUVDTndT?=
 =?utf-8?B?SklTd0haa1ZkeENJQjl5dHNFZW1ZdXM0Y2FQdWtuTHVCSTJORGlwd1NYVW1j?=
 =?utf-8?B?Vjc0VEdqdStjcnQzaEU3bWF6eE4xYjBRZHVpc1YzSmF2cDl2RWFwZEljWFRn?=
 =?utf-8?B?OEs0VitqREp4c29LK1RQYzRKblAvRmZ2UDcrRUdKalp0RXQrUWc1cjhnR0sw?=
 =?utf-8?B?dEYrY3hMZXR0MEw3NUZoaVJ5QmtnVnRHMVp3Tnl6akVUU2czVUV3SGpRcWpx?=
 =?utf-8?B?TkxEUlJnSzgvWjNiajk5ejdvcllweDN0a1RGeDh1Y2cyclZwWUpDOGhYd3k5?=
 =?utf-8?B?S1pNVmkxRzYweGxJVU95dURTdXRQR3hHNm10ZGRvU2liTkFaUkFqeXFRV01s?=
 =?utf-8?B?TGRwdUE4NE9xQmVvemNTM3VPaThSdTV3SEhCcktNcUVPOU1IMHo3bzl6bE5U?=
 =?utf-8?B?aW45Um95Zyt5U2l5TjNPNHl6eVVIS0JKdjBjTTdkSThKejZNNjIzSTJqM3Q2?=
 =?utf-8?B?NVVTREw0UzlZOUN1YTZsUjlZTjV4ZCtjMkpvcnlLbmFxQmk2ejZpbFhPM1dW?=
 =?utf-8?B?V1RFZ1ZzM0JtVGNLaXBaVXdHYlg1WFk4TTVub2hpQ29Ga0ZzQXQxUkxBVTRn?=
 =?utf-8?B?dVpiSHREV2pYSi9NS3JyUVhYbTlPZk9vM2hMbFFwZnFBdmJCWTVKaHhlamdS?=
 =?utf-8?B?T293L0RlbFRrMlJRTmY1L1J6Z3dSeVdHRjdYYThDa09wYnVxMjV3QkduVHlj?=
 =?utf-8?B?N2lMMEpKa09xY0lzekk5bkh3ZnpqMUV0a3N6ZFZNVXFEcytzc2pkSmN6TTdH?=
 =?utf-8?B?NXFXalIwZzZ6MjVTbnJEVVBoSEV1V0FMQUFjelh3TWt5ck9oRVllQ3MwaElE?=
 =?utf-8?B?OEdUdVhjSUE5YXZTeUpCNHRucUFTVXIyZ2VyUnJuLzNNM201czFIUXVub29k?=
 =?utf-8?B?TGg4MHpZQ2x2dk9wNy9nMFlpQ2VlWFhPd0pyQnRoajh5RUx4aUdKMURvaGo0?=
 =?utf-8?B?eDZvWW9qM1JNbU5Pem9WeVdvSVp0MEpmdWdtTGpZOC9NN0plZ0NHY093QjJh?=
 =?utf-8?B?MUJFaEpTNndEMnRsWllXWng3eVNTVEprNHkwUE5FUUJwU3NnVStDN0ZLSFZr?=
 =?utf-8?B?Q2dPSEdJcUY5UjJsWnhkeVZRMXUvWVZPUnNhQW12a3ZWQ0duYXNHbE5Gd3c1?=
 =?utf-8?B?cTlHVSszbkpvdHVXVmQxeUVWdXhXMWVBai9pcnNUT1ZhV2UvWnkyeEQ4aXRy?=
 =?utf-8?B?NXVhMDRzZUpTYm5oWXQxdW1JcExhcE9NMjhxU0pnTkVyeVBETm9BRUNoUEhL?=
 =?utf-8?B?TTB6bUpubko2S1VQczgyMG9aQWV0YmxMNXY0bHAvR3F4SnArVmt4QlBwVEZC?=
 =?utf-8?B?ZUhKeHdUYzQ3eVpYaWF5QWtLc0VwOXZBaEg2UE10V1k5Zk1FRHo5aVJBcmxE?=
 =?utf-8?B?WHljVzJES3NYRXVDQWpJcmZMb2kzUGJrK1o4K0ZRb3dNQzFoRlM0OUdvazZK?=
 =?utf-8?B?V1FzU2E0eGM3UmNKN2ZjZlN5eGVPRzNVQ01nL20xOXFyK1ZGbldTcGVmVEp4?=
 =?utf-8?B?VG55dDQ4S0MxTG1HSHJYaU5qWnBublNkNlNqNlFSOE5RcGNIT0lROHVKc0Iw?=
 =?utf-8?B?ODZ4dDg5LzBsWlBJZjRQZHE2TXdVWHNzQytLa0V0cXYxeEVHa0l2WWxFd00z?=
 =?utf-8?B?UVZJY3hZaXVGSVBTVTB5SEloOVRmcTRMWmtvTnJJYmU3TzJQSjNJdjJuYUVQ?=
 =?utf-8?B?N2RRcE0zN29DZG4ybXZFTkdjKzl5akFDK0lHdmI3YlowN1VSbXZvMXp6S0pM?=
 =?utf-8?B?QVdwdjlJNU9mTmF0amFxSGVweHBwUlNJQXU0aVYxMm9rNi9mVUw0QUJva1Jz?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af84a791-75f1-4790-89e0-08dd5c8c20ba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:51:47.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaupOtYxAzC+k6ZIGnrLX51qE03xdrbdg13N/8/85YXiW2JtQa6U6vuPPwMKC7Vee0KRUsKwHOjp2OHDgspid8r7EWCRlWKNF1UW0X7WuVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7370

Hi Rob,
    Thanks for your advice.

On 2025/3/6 01:07, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed, Mar 05, 2025 at 04:28:16PM +0000, Conor Dooley wrote:
>> On Wed, Mar 05, 2025 at 06:02:56PM +0800, Xianwei Zhao via B4 Relay wrote:
>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>
>>> Update dt-binding document for GPIO interrupt controller
>>> of Amlogic A4 and A5 SoCs
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>>   .../amlogic,meson-gpio-intc.yaml                    | 21 +++++++++++++++++++--
>>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>>> index a93744763787..3c5853c71efa 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>>> @@ -35,6 +35,9 @@ properties:
>>>                 - amlogic,meson-sm1-gpio-intc
>>>                 - amlogic,meson-a1-gpio-intc
>>>                 - amlogic,meson-s4-gpio-intc
>>> +              - amlogic,a4-gpio-intc
>>> +              - amlogic,a4-gpio-ao-intc
>>> +              - amlogic,a5-gpio-intc
>>>                 - amlogic,c3-gpio-intc
>>>                 - amlogic,t7-gpio-intc
>>>             - const: amlogic,meson-gpio-intc
>>> @@ -49,8 +52,6 @@ properties:
>>>
>>>     amlogic,channel-interrupts:
>>>       description: Array with the upstream hwirq numbers
>>> -    minItems: 8
>>> -    maxItems: 12
>>
>> Please leave the widest constraints here, and let the more restricted
>> ones in your if/else below.
>>
>>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>>
>>>   required:
>>> @@ -60,6 +61,22 @@ required:
>>>     - "#interrupt-cells"
>>>     - amlogic,channel-interrupts
>>>
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: amlogic,a4-gpio-ao-intc
>>> +then:
>>> +  properties:
>>> +    amlogic,channel-interrupts:
>>> +      minItems: 2
>>> +      maxItems: 12
> 
> And then you don't need this clause as 2-12 is the full range.
> 

Indeed only 2. Will fix it.

>>> +else:
>>> +  properties:
>>> +    amlogic,channel-interrupts:
>>> +      minItems: 8
>>> +      maxItems: 12
> 
> And 12 is already the max, so you only need 'minItems: 8'.
> 

Will do.

>>> +
>>>   additionalProperties: false
>>>
>>>   examples:
>>>
>>> --
>>> 2.37.1
>>>
>>>
> 
> 

