Return-Path: <linux-kernel+bounces-301377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5B95EFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06971F21AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56801153812;
	Mon, 26 Aug 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wjDjTrvd"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F6762D7;
	Mon, 26 Aug 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671887; cv=fail; b=Ati4L5uJUUjOMLyMeq/1tO0jQAmg1b0V4muWNsQX4KUHQLv/5YNvWgfRvRLuL0Lzs/OIlu5z0BHnFIfaZ3P0elqIwNTONLJR5rDuvUYUe/jVj3oPxZfx7WV/TeCMgZnhydO6UiIADDy6H6jEVSSynscz5l+9jCQnliAXw5y/2I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671887; c=relaxed/simple;
	bh=5QG4S+AVKp+BjbbD37coRrm2slW1A2qBy177/v+yrac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WlQuaINoSXKvcipQvjD7UFNpYKmrjMOEIPB/ON5NQN6tuNZ1m7QheVaH8xtA4BiIFE/pkMLgXbYf4wxvOmsu14+RZ0WQYe4K9OSyf7fv02wP5L6zpm95FfTcCl+92NCskWAVU09+vf4C+ODPQHWSHPiEVQK7Akcz5PDSIkMuinI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wjDjTrvd; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVHQrrnQ/xGBh3KLvrzfS5y7NIUsOku0KrnaMx/5YzMjEfurjFr87HlcLt4T0OyEqBgFWzT5pLTsUVo+pHbMGz/l4LrwGQ/ioCfvQLsx+zie6cGYFowmdzkWZEkBdQiqzjXIeBCP/qB8uESiNdvFYGQX8R9PxcEgnG+Uk63RRxTS0v+tNJ5sM/+CHthuIdRBGgMTv0K8SeGQiJVX593ISa0iVg6K41Z6bsgU09z4BZPQkcWp062vMkHMi6SReo0UQK1XzefRRA3mMJOO09adbJJtQ8kVh9ljIhCA/r4GZK69NhCbyuiRHAYs4RF82WxPS/MmRKPFWxyUAmRzYqeQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfR2Q30acXiGSc5gDjJ57MyJsVSuiHog/9vQ7LTTdco=;
 b=ekQRwVpwyGw3HtjnAp4b28fUCzGhsXGqMlCyEZbcl5DbmcgaQRInOfyopQawyoK7F8riylxYXVP0hU6YSVWDDPckUbf9SrW8bIet1q67Vg0I98qJxNlu0OSpEO3bfvvQ0TCmSijccUZt72Iz5lNPuHmc2w/M/ZkoRLirjYE3UJSERYwIn9Pk0J3I5GKpgKIGdwyVLWYrojKR+lPZOiJoQIzF/AcShqgztADHOycJMlq3OkkgZ4LS52iem0mvUbbmNJb9MtDsStydnDC+zLMWt4AU7NNSksjYa3vlPvFbZeCKzgjaaMLb29tCpiD4n6RichDTRYZbudL2iNLdzXgoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfR2Q30acXiGSc5gDjJ57MyJsVSuiHog/9vQ7LTTdco=;
 b=wjDjTrvdqeLWeZc8XU68EdxWVUk7jEqKLD5taj9tIP12xMdQkCLF9qmEjeXqJQrUt6hc1O/7Btx7s/M8qxtHCdmbpIH1+3X1KW9KeMEQsp3MAge8fz8WKBYIFFplyZdMq21onPrp60yuSSdJK1rS3m3z0asWLPoSjltX7gURVpA57wYFYim9GRZNG5WLFb//85KfDyxOR+wLn3XqQVVyEM2MYDl+kL439AT9a1SJaRULmxxlCAO/yFHDEPNEPK/JMOCWVe3uwinq3mMUhRf/x8oEjJ0UycATbD3iigk6KZ2y01Yh+HWs5DKcyeV398XUBzhfmfHfWnLdS7s6lpgWLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 11:31:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:31:20 +0000
Message-ID: <992d6ff9-3181-4a71-9e21-3ba6465693d6@siemens.com>
Date: Mon, 26 Aug 2024 13:31:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller: add
 child nodes used by main domain
To: Nishanth Menon <nm@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
 Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
 <20240824175825.bedufmhfkx4btv5n@anything>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240824175825.bedufmhfkx4btv5n@anything>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3521:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d3bd4f-a49e-4471-43e8-08dcc5c29bc4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGY5c1VrbXduak1sb2h4YWJaN0FOYXk2R3c2WHhKTnlhVXl5Nks5dnlLU2JY?=
 =?utf-8?B?Z1JYLytDRktEZ2UzbkhaMWNjN2NCck92NndNOEhLMm9aS1dDdk9ZVW5CSkxl?=
 =?utf-8?B?V3R0K1lVOUFUUU5FeURJTUdncG84RlE3ZENkNThMRUZGS1VTeTFOVG5HSmNZ?=
 =?utf-8?B?TE1QUFFWaC81RXpnUEw0UnM1a1RoNzZzUmFvamtiTm1LUEhNQ2dYeVRCdGoy?=
 =?utf-8?B?ZXhKVWlYQlNwYVhEOHJENVNJSzZpTkEzTzNqM3RQTWIzK1Z6T05OYnhWeEsr?=
 =?utf-8?B?amYxbisvZUJHZVZMTEdkZWo0ZTJyR0Vha2JUdENjRGZzcldxSWR5Vi9hQmdJ?=
 =?utf-8?B?M1RrRHRxSmY3Z1U5U3J1dEZOL2toaVA3a1hJSTdwcEZla2NBUjlhY1o5aThi?=
 =?utf-8?B?a0NhYW55SDl6TGl4RklRWGJsSFBnM3JHT25wS3hPZGk1bnBXMTBmM1JhaHhy?=
 =?utf-8?B?eENSWk03cXFWVlVNajUzYm4rYjFWK0tzZFFGNFRGNU1KcDU5aG9SVmZkWkFm?=
 =?utf-8?B?aG8vWkRJbHUrUThZSUFGRjhrYkNGVjlwcEU1Z215QWViVDA3L0YyU1ZoSTZJ?=
 =?utf-8?B?QzIxNUw2eDRsV2pNdGo0RUZQVXRPY1JucFJmVUtpOWZMcUVsYnRZdlFOVThp?=
 =?utf-8?B?bzBMOVhBRGpQVjFoVlgrdmRaTXJleTVUbnNuRWkwWG9PWmJoM1ZsditCOG1o?=
 =?utf-8?B?aElSZ1A0cGhqMytTV2wza2haazg2aWZUbU5iTERvZzlLbDZiZjd0SXM2cFpE?=
 =?utf-8?B?YUJWZzlybno3OU15ekphbEdnbmhPWVhZbkFGajN2ZWdtU1VCZkd3Z3JVbVpo?=
 =?utf-8?B?ZlVDZnFYUFRBWWtURFlPV2NOdXQ2KzRIY1UzczJ5ejdZL2tzb1FSamJjQVB6?=
 =?utf-8?B?QzNpRkFvNnlSOVh2RysxeGpxbWRDc2puaXlIdzg2VVdRWXhQUFVQQkNsb0JK?=
 =?utf-8?B?dDVNdHNMdWdGaU5NWHdBWHZMejIxVlJvOWMvY2xaNmlXMUZORXMyRnRmazBW?=
 =?utf-8?B?Q2w5Tmh0NEpFMTBiYTBsbndqeUJjZ01VbDgwemVyWkxyOEdQRS9PUzZOOTJQ?=
 =?utf-8?B?VWhNLzlMbnNLVXVFc2tCMWhtTkJ5OVNMdHJUckVkYzMwbGdWQnJhU1ptREVo?=
 =?utf-8?B?RnlZZW8rZlVMeXBpRUpaUnBxbjlLTkxpMkZNV2dRVG8wM2xNQk5wZ2JyVjBU?=
 =?utf-8?B?WHZsdlVsV255bG5UYVhoVEtWSjVuN1h3YTgxWUJ5NVFuK0syTU1KcDhHWkty?=
 =?utf-8?B?eE9mMEFlMUFNNzkvVWFpenduRENFSHdnV0c5aVRLQ0xGcTd1NlFHY1lRQU5I?=
 =?utf-8?B?UFpNMWdxK2NOQ3lvdnNsWWYyMVpRbUhlanpMRElWU2o2YnZWM092ejdzT3Jn?=
 =?utf-8?B?N0tWT1RmWmZpSHNFeE11N2ovdjE1WXU4eVp2Ym1RT1E4U0p1NXFNVGpjS0Fp?=
 =?utf-8?B?U1phS01sSjhFRW1PYlYrcHhiYlBFK3I3VXYyazhKY2RoSHJOek1iZ1Bvb0Ni?=
 =?utf-8?B?VjQrTUxibSsxOWIvVUZxd3VEYVdRVTZPdUl6SWl1alkvbWJiVENQQ2ZiMGIz?=
 =?utf-8?B?bXpxRWl1cGhlSFNJNUc1SDU5bU9XL25oTXFUMkRxeGhzK1dOdC8vZ0xHRDF1?=
 =?utf-8?B?UCt1VjFaeG9meDFCWHl5N0hodmVuVFJtMVVwc0lEQjNoek5jYnpSSE43eWZm?=
 =?utf-8?B?ZERtc2NnS0p3T1IrSUF0K2ZBTnhRWk9mNVk0ZmcyeEFoN05xQ2M2MXdXMHFm?=
 =?utf-8?Q?TVQ/2wgty87K9wpAXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjVYR2VjVzlnMVN2OWJmS1J1c0ZJNXkvY2VZalBsTU9BSkVCN3J1MXJFQVZi?=
 =?utf-8?B?MHR1Ly95cnF2eWs3eVgzcE83VmExU1F3aTcxWlFid3dzakVnSXU2Nm9tR0Yx?=
 =?utf-8?B?VERkdnJnRys3OVhkVmVpeE5uazd6QWJrbDJRcE5jZTVCRlZ0bUQ0bnp3SUNG?=
 =?utf-8?B?NXZZcFZubFZiN2F2RFBFajBhYWJHcURpYlU4K1ZwQTUwMEZ3ZjR5OGVjcDQ1?=
 =?utf-8?B?NmVFUjEzZDEvZElQS0lkTDNBNy9JRnFPTUFvZG1QekhoSTlsTUJqVitnY2Vw?=
 =?utf-8?B?Z2JVeVRDVDM1UmZHdUY1b09oN0lZNG0veHZBM0Q3Y1ZjOTBoUWtZelVldHpo?=
 =?utf-8?B?M1lScnNjdXY3SFlVL3FtZVJJdFFEWDRMcG9CRW03eUZZb0F0QWJhT3A3ZGVN?=
 =?utf-8?B?WHluZzJ4VnQ2b2dmdmlubG1VWU1wbzUwaHBNeDl0VDVicmd2dTMwb1Q1SWo0?=
 =?utf-8?B?bmFtNDVpMjNtaVhzbEFyRHlDbElXNHZoa3RrNjAwZWlFbW5xV09xSkpXUU5E?=
 =?utf-8?B?T2ZxTGVuZjN1UjBia0RjNzlXeExHMjdjRWNYaERXTWRYUzUzSHBZRVFVTnhy?=
 =?utf-8?B?U1R1UGdrWS8yb0JXM09MOTUwSzZzUW5oeFpFdmt3ZEcwdHdaelN1MWMzNE5n?=
 =?utf-8?B?VlNiQU5TdkhLdU9CN29PL0xwejJSdTlPck5YcGxiSDJkaGR2ckJnSmNEOUdv?=
 =?utf-8?B?bnR5NjQvdUgzOGI0b2lmSVBDUm1vc1Nad3FLZEIwZzdYYlJZSGNpWndIREI2?=
 =?utf-8?B?VVh0UVo5ZWs2V3RrQ3lISFBUbzVzMGJzZFFHbU9kQlFESHNGR0lva1hmT1li?=
 =?utf-8?B?aVdUY0ZBVjFIYkgyMU1pNmFWWUtob2tyeUtXNUxXVnc3djVzSE41bnduTlhH?=
 =?utf-8?B?WDM5azlDQ0ZpR0h5RS9VSWw2aXZQVmN3Q0E5Q3Bpd0F0NkxMR1k3cTlQSVBD?=
 =?utf-8?B?bDZyb1pQTnJNM0VkNkI0L1hmNlNlWmtvTFBvQitCMXlOcE15SS9aZHZGYUVJ?=
 =?utf-8?B?N2ZiQktFVHlGMTBuOU1raVpyeHcrMnBHcW8vQnkyWVkyTHVuSzhKVDVpU3JV?=
 =?utf-8?B?V2U2QWlaTGVXcUdMZmNrUk42VjZNamhFTE84YmRTRHFwQXNBTWxCMThmbDZy?=
 =?utf-8?B?S3B0dmVvakV1VmhFdHpMcktjZXdSSi8ydVNMU24wemVxN1BVWnVFYjR3UldN?=
 =?utf-8?B?OGpJS2JSZmVnSGtFWTZwRmZIMk1ZcCsxcVVFdW1KaVQ2ckdVRW5Eb2o2Z1h0?=
 =?utf-8?B?QzlOaHltSWIrS3FhZm9EcC9zVnhIMW4xS2VWZnRBYnBQVUZOUEFUY21RVVQv?=
 =?utf-8?B?Y2MwVUkybFVBVWNLZzVZQnBDZExrSDU0L2pSQ2lpOC9JaWpwU1NwQ2lSanRG?=
 =?utf-8?B?SFBmMk1nQnJmRklPclcvNDFXSzI1QjZxN1RaekM5WERac2duS2lTa2VxbUdt?=
 =?utf-8?B?QUk5Y3BsUjRtbUtlWHl1QTJIV0FSL0dtNHhYclVFd3FLdEt5dWNMOEh1VVNJ?=
 =?utf-8?B?dEU1bTNpbnk4MlVabjc2aGNlY3MyQXZLKzBZcVF1RUNGYk1wVmxFNGt0a0Z4?=
 =?utf-8?B?WFJyaEdmdnlCbHF6Ym1wYndIMDI5WkZoTWx0US9iSTVoYkU0LzhLYlczZ0RT?=
 =?utf-8?B?OS9Ec29ZUTNSbGhRTlowNU5RVG0xMkhyRzkrTFZVRkNQT2hXNVdtdHdQUmVZ?=
 =?utf-8?B?TlJkQ3RWSXJTUnJ2UDdPbDV1TUJpeVVyditUOU90OFpGd1pqN1lJZWl5TEEy?=
 =?utf-8?B?dDBYVnZtd2xudk56a0MwbEoyUC8rRlAxdGhseVpmRG1tMmN4YTdRdWNGakZO?=
 =?utf-8?B?eU1Ubjd3QnAvMUlHeTZ1UGZiU0JnTDhjWU1BbUZ6eHVUWGVCNmtMaGloazRk?=
 =?utf-8?B?anFKV05GUUVpZmtVaFc2VGtNT3R1b205RHlFcXI3RjJTTjJjUmZOeXllbkN5?=
 =?utf-8?B?a3FNck1xMjNvYWd6cTljdkpjV0NVV0JrdlRMUGs4VVpLMWxkWWhMVWhnMjc2?=
 =?utf-8?B?WCtwK0Ywd1R4NVZRS1VvQUVXR29rb2JmOE9Ea041Y0YwdmFQbW5rVWNlOVFY?=
 =?utf-8?B?MGhXUDBLYURhdGwyZE1xbFQwaktMWVJUSXB5VlkvWHBNUGdHRTZzRGhJbkNs?=
 =?utf-8?B?NFRDVDFNUGVsSWpLQkFEbk05ckV0dWxocWVGQ1hjOExUUzg2L21melFDWlNl?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d3bd4f-a49e-4471-43e8-08dcc5c29bc4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:31:20.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyoOb+wQPqBLSdIDcBRFSXmDvEzrqrqNVYoGTm1SGxrcyoxo9j/LD5yks4Z4R/VNfT7mRZSc8xZtydjC6e6wIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3521

On 24.08.24 19:58, Nishanth Menon wrote:
> On 18:37-20240814, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Expand bindings to cover both the MCU and the main usage of the AM654
>> system controller.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../soc/ti/ti,am654-system-controller.yaml    | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> index e79803e586ca..cb9da3ec39a8 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> 
> As per linux-next, this file does not exist? looks like you might need
> to rebase on latest next?
> 

"This goes on top of
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org/"

Is that series obsolete by now?

Jan

>> @@ -29,11 +29,30 @@ properties:
>>  
>>    ranges: true
>>  
>> +  dss-oldi-io-ctrl@41e0:
>> +    type: object
>> +    $ref: /schemas/mfd/syscon.yaml#
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: ti,am654-dss-oldi-io-ctrl
>> +          - const: syscon
>> +
>> +  clock-controller@4140:
>> +    type: object
>> +    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
>> +    description:
>> +      Clock provider for TI EHRPWM nodes.
>> +
>>  patternProperties:
>>    "^phy@[0-9a-f]+$":
>>      type: object
>>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
>>  
>> +  "^clock@[0-9a-f]+$":
>> +    type: object
>> +    $ref: /schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
>> +
>>  required:
>>    - compatible
>>    - reg
>> -- 
>> 2.43.0
>>
> 

-- 
Siemens AG, Technology
Linux Expert Center


