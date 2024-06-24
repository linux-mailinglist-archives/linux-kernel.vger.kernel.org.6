Return-Path: <linux-kernel+bounces-227901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E59157EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E57B22AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1881A071E;
	Mon, 24 Jun 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ht9l+Zpu"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9B1A01AD;
	Mon, 24 Jun 2024 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260626; cv=fail; b=dEBI7Vz14ooEV6RP9OXL2ak1R+dQZuec3WdNf1I8oG6KkRqw7IhwC4CSAnEm8EhOFvWGywMbIIi/PIywJJkunkqo5HtYbZPOZMwoQDLVsoijpIx28efJ+oiRqg0LAZ3O0scKGqPQmKWrvbhDQamk1HhscRZ3DzIaXpFZ92aSnD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260626; c=relaxed/simple;
	bh=J1IYVCOIYFVGVXwJ3FLtUdm7gfNDRhTeGT6ac+mwH1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AVRXCsQjGw6vkmwWdgf+FM2iqXUgzbn5pxziSbh/TM4xtoyGtw1s1F6+H18xnt1tG2I5vrKEUKC3pOLCXbYUB7LPysxkuL5xQ/2PV2GCJaMCNW5Fou3bouDQlbrK0M5P/VYYusSrRn7PAsNUx1hvwPFbvptjBLyQkP6DnkDbbdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ht9l+Zpu; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5KaU5LNgKp8Scj3lKn05qmNYDefcJdEg85EaBlcCu0h5nW2vxEd2U7f1ccllr88dlbl2nX8ImO82FhoFxJlDGXRQYm3qYug7ChJZp6znqV5p6Kb89FjVCv0TFvCNLBxr8O+qenCAxR3y/POUMetQhCTh4Ae9IDtCwVyLKeVoQf8T1w4Ad+U+ObkyB7WFcoXteVBByjB5Lx0fJkJOOQst2QFT6KSWcs5TicyZpahbgMYQfnmowaAYTw6/mkR7Y48sQNGJlclSPwRs/iLuothIJdrgrdnSLtSm3ZjYTMWpEV5aBojyCaMB6bf0gNCiLeJBLKv9CErq2t+Le/ADiwUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HY4F7OcPApH3WL0eq1N4GVD5OZ8uJ4vLnMXX4fzINI=;
 b=QkgEjPZgtgFXYyo3YpH6rX4geyvF9m2ieUReCAve4koXme5wnoyZd+eAeHzJa/pHGvBtVy3sAzwZrf3+zQ8xcqz8aHBVsVhXQiZu/KCJOgn9nYODBELn13h9OXd6fYbXXUs+xc7BxvYSdVy4uWz1SEZJA7bnUU2FBSOpgeAVoA/jNyKqjISHHD6T+9jQFYEeh0i6aIwhIpsIe3deG+OXCRsBxmQYUgOX0nSbSMa0So0fcGt7FPMytPR45ChRm3wWpuRAs0Hg0fhmVuZrMHL5ZJy6h3eozxy7Immtc/9rTZaYjclKWZbOj+ckc1V507T44TkEs12UEfRveiUkYWFt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HY4F7OcPApH3WL0eq1N4GVD5OZ8uJ4vLnMXX4fzINI=;
 b=Ht9l+ZpuqwY19X9KOWgWN7UkGd6jmQjiYib63cb07HSPrFenb1aUJ9nEFOaxP6pSmpwoLddGojYA23vYRGES0bl3tT3frPDNsL8YRh/KF2hkrXba+85NlAhVlay0BA47fguxi7DAkLE/GAXhTXNPyypsOK4fMhAlvcvrxQ73Fy4iqdEox74JyjZrb6dFWEiSjzAhNhU83zPuNWRjYBz/SWdJFCpSAry6IC05dMVBh+gs9ktM0uZkkHN0bkLgrYz9obq47BmbHxU/iGFNP5f0tqaZiP0MavWNpdZcLYIPT0uP8zs8Lq8oASb2BEdiktGOaCDYx5VipmRF40JdFOzPgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3599.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 20:23:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 20:23:39 +0000
Message-ID: <0e0a9627-0e5c-4c39-b1f2-98f8095ba8c5@siemens.com>
Date: Mon, 24 Jun 2024 22:23:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: soc: ti: am645-system-controller: add
 child nodes used by main domain
To: Conor Dooley <conor@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
 <52848094062ea55b0063e6fc37f27e6ed5035aa8.1719210050.git.jan.kiszka@siemens.com>
 <20240624-hula-fever-74499b22784d@spud>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240624-hula-fever-74499b22784d@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3599:EE_
X-MS-Office365-Filtering-Correlation-Id: 16800857-1b97-48ef-09cc-08dc948b88c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTBKSFA5TWJuRW9pQjVvYWpFZmp3Zk9XLzdTYkthM1FCQWw5dEc3QzFmQ3Bj?=
 =?utf-8?B?V05UVzlPamNnSThqdFUwWm5VaFZXdzJpUnRvRUpzRWtLN3E1RVhxNk5hSnRh?=
 =?utf-8?B?djZXOXBTS0ZidE9CdnRFYWFyMjFGUXlBN2ZSZmkzaEZWei9veENRTXBzNlcv?=
 =?utf-8?B?VTNsTnNQUXlwVFBHd21TOXdIUnF2N2xMWGN1OUp5WThFY2gvdzQ0amdLMGow?=
 =?utf-8?B?aXczT2pEL3NIQ2VrelA4NG9leTBpaE0ybTNjR3V0K0dieXE2S3M2SzUrZUxo?=
 =?utf-8?B?QXJDMHg0KytSSlpxTjFZV243VU42YWY3eDdRKzdjY3RBRWR6dWJpWnY2ZitO?=
 =?utf-8?B?NTZOR0RHWnd6SG1ZakFFYk9CRUk1U3dlbDNyTnVpdHBjYWNHSEprNFNwRzFi?=
 =?utf-8?B?dGhsakxtem1EYnhoVitRbHIwbkkvWGRSdHArekhIT3dyd3gxRWx2cGpsZE53?=
 =?utf-8?B?V0tyUTBvRktpbGNMSU9MNWJtb1pvbEFwQVI3cmFFekk0Ujc0blJwUFJKUXNS?=
 =?utf-8?B?dlAvbEluZS8yY2hmTW8xK041b3lYM2JlRTJTVmRzdERud0NlOHNUQk82NnBE?=
 =?utf-8?B?NXhlV0FTR3pVcjlxTnJUVW5mYU9IUDA2YjRHVy93N0ZtdzdPUEpyTHppMmlY?=
 =?utf-8?B?eFI1R3FMSlArWjBhelVpeEI4dkNFTjNSZkVQT0dtdEdKTWJldUJmMU9UUkpl?=
 =?utf-8?B?aFkydzN0N3BmVkZDZUxLMGhTSzhXZGJJbHNpR3F3dnVVRkZMaGpmOWFhNTc0?=
 =?utf-8?B?eVR4OFZoZTcwMmxBQmxDYUkxTlR0WFpEekZlZDZKQWhiWEoxR0kxUllKc0ts?=
 =?utf-8?B?SnY2dThKVmQyWlRzSGJRUUtrSVBodFdVcW5DSElJa2FNc01uOGVlZmkxYWs3?=
 =?utf-8?B?WUpUSWQ5eTBpVFhtS1hYS1loeGtOYURkL0hpQTJRSnlhczZHd3BhZU9QVmFV?=
 =?utf-8?B?eENxVzREZjl4UXFFOFJZSUxGaXVwZi9TSDU3SEpqZUZna2dOVEZKQU1MQTBt?=
 =?utf-8?B?anM1bk1EbGRDbFdlZnhHcDRzVlhReVQxVC8wbVAxTlR4b1daZjBFK00zNnJR?=
 =?utf-8?B?RXk4aTlUcHVVTnZXMHdYcmFHZDBUVkMyQTN6T2NyQjhBb1VHY01CbXh3a25I?=
 =?utf-8?B?VmlVdXkxOU1say91cU9aN1BmZElEVzR1WHVxMitPT1FocXVWbFJPaUVYdlg3?=
 =?utf-8?B?NGJ2WUJGTzdzRDR4bVNVcjVMMmRZTU0xZEdKaDJyUDd5MnNqLzUrT1lUQm5l?=
 =?utf-8?B?WG1UTlpmQnV0VGY5eVdZdW5lMzhCVXpWb2NmdHlzMHF0Z1pERGdsTmxuY3JS?=
 =?utf-8?B?b2tkWktYYWlqVUNPc0FJVEdtdlNFMkZPQ3IvNE40K1NnK2VzVlhGM2RxRitX?=
 =?utf-8?B?cDR2ZldjNjdtWXhSa1I5alpvRWQvY3lLd2M5YndWMEdheFZGd0VIemo0SGNa?=
 =?utf-8?B?eittbk1WR1IrdWVWQmdQdFZTVlFTNGtMczVHY0FKZmd6N0o3bWRkbzRTTm15?=
 =?utf-8?B?d2d0VXZxdnlOSUNmamRZZ2k2V2czd0FRUi9oMkM5dGpTMmV6dWtRQkpQY3NQ?=
 =?utf-8?B?NE1ROVZqZFhaNjlFWW9TM1o2QmRKMTZubFZRVHBxNHB1R1ZyS2drWUlHcStC?=
 =?utf-8?B?VWtFN2JOanVpRzNUQ2hva1dyVXNid0ExdElpVVdhajBXY1dCQWF5bDcrdVVr?=
 =?utf-8?B?WXRoMVhTaHAvNVR5UTU4RGNRcGxtanI2RUJPNks5MjZpWHFwRnNkQkZGNHFv?=
 =?utf-8?Q?F/bJPtao+ADyJ7ylufuSQOVVjTJVKOrSow8gBCv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGpzQ1NqSGxOdXY3c2g2NGFhWmdsaW1Nd09yb09KeTlRTjJYMGRad0dLcTZ0?=
 =?utf-8?B?S3Q5MktocU5mdzFLVjdORng1Z21iTk81RjF6M05vN2N5UWNyekhTbVRnUWkv?=
 =?utf-8?B?ajl0dFZUMXRDalptQ1JCYXZKcVNZVFRQYzJxQ1hkU1R6V2VreDBDRFB1M1N0?=
 =?utf-8?B?cTU0emxKckgwcWJGSEpCaFV0REh6NXZLZjQrOFlSZExzYStyR0h3K0JVY0Qv?=
 =?utf-8?B?all6TUYxbEo0VGFVOGg1R2E1K3BBRjkxOS9paXZMM3R1U3FuMGhYZ21BU2FL?=
 =?utf-8?B?RjNQVXk1TDFyL2Q2NC9aWW9zM1FsZG5TUFc1dUJRdnMxYVpST2kwejJGLzI0?=
 =?utf-8?B?NXJBNjA4cU9YUXJJKzlSVXRuOGdwUWR1bmgyWlNpMUJXOVlSNDR5VUREU0dJ?=
 =?utf-8?B?aERXbDNaU1UwMStXRVkvUW8zWm4yd0w4TlFBdlZGd1dXYUs2dXNzdmltMDJR?=
 =?utf-8?B?bjJMd29wMTg5WThyTm1hMTdCSVc3MldYUmxHNFV3VkRRY1VDS3l5U2Q3RVZ6?=
 =?utf-8?B?RjR0VmpMcWFpTHBiNnJGTFNmSEdSR1dMYmF0Tk15UWJtdjZDTy9BOElhdUJR?=
 =?utf-8?B?aEppRnZBb0NQaTJxTFk4OUZVemQzZWZTcDZZcjVoUi9IYzZVT00zNEExRDBm?=
 =?utf-8?B?ZVVuYXhvQ21ObnY1eFJ2bDBCWldaNGNLd2Y1OWFvVTA0cVpZYVh1dSszekRn?=
 =?utf-8?B?UXdmK0QzTDM4SmJ3b0YydjJWQnRNZkllbUlWTWxROC93d1BGSGxORG9rY09m?=
 =?utf-8?B?eUIzSFlRWWZIc1pPK1ZMbEo3Mkx3VTV1aHdNRFZiQjZFZUVwQnpDR1NLRzl3?=
 =?utf-8?B?QXYrU093Mi9CWTJUVUZwQ0hrT0s5UHRjcXVnWXBOVERyQUZxaENkdXRjay9u?=
 =?utf-8?B?MWdBcEFuTVVWVEx3V280ZDJOVTkzd0RLZ2FIS3ZvMUtkbnJFMjYzcDdORVJ3?=
 =?utf-8?B?U2c4S21sb1ZnMmtTSkZLWnQ2emdwOFZpRlQyQVJLMTI5WW5wWVJqOVd3RGwr?=
 =?utf-8?B?RlJPZ1FnckpLL3dJcGpzUjY0bE95ZjhFc3YxUDBZUlErMkxzaTR0S0l4UXMx?=
 =?utf-8?B?SWtEYlJscmlNbnVpTW9ZM3B5T2U4dDZNbHRWSExtNGs1VUlGVWlaSlFqTGNr?=
 =?utf-8?B?Q1dzNDRzNFlXakZ2RHdlWG12VzhyZHJGODFmNWx4bmZhSUVYQXUxS0lHTmFL?=
 =?utf-8?B?c09qVlhFYStZenVSdmdnMFRMbmxNZVozVkFYU3VzeWxZemxILzVPb01FdEIz?=
 =?utf-8?B?a1FiQWUzcVJRbGRleUtUM2crMFBjbjdPbVhZVEdpRXJiQkZwUExXUVU5SHly?=
 =?utf-8?B?YlJxa2NCUFNma1lOVHpkaTVYZ3lzNy9OdHFpd3VLQW1iaTFMaUs0eklsMVEx?=
 =?utf-8?B?YzNMazVzYzJwWTE0Ylc2ZG55alVYSW9hY3lOZGRYQTRzeGQ5SEVpQ1RXNk5V?=
 =?utf-8?B?cEUvemNTRlhobTUwemFnRmtHRVhsdDZ5aUNwYXU2TDVxcUQ1MXlJNXdUeGND?=
 =?utf-8?B?V2xXWW1oTDBMZjNsT1p2Qm9iRjh5YW9scGtCbmhvQllZMkVuc3lFR2lRU2xi?=
 =?utf-8?B?bHNyckw0eUhhUUY3clRXc0VwOE5uM1hUZzZhdmsxZEllZFdjMzhnS0xMUXEz?=
 =?utf-8?B?Z3BHNUo2eGdKQ0N3dUhyUWcvSnhhRU9ld3R0ZFUrOWg4VHJ4M0UxUVVSL1Vi?=
 =?utf-8?B?dk5BL1BBMThoLzU5aEh1QklHdkRja0xmRURuaE4vWDVtNnZwWFRVUFVLTlZ2?=
 =?utf-8?B?ZGJCeXljTFExODJodWdaMzh5ZTIvWHQvaTRUeWNEaGlvOFRMRjY3ckZHVzJq?=
 =?utf-8?B?UnZGK2k0NlZrVjNtdmF0d0hqZkttZnM0RU1xa2MxQXczNmc0VDRCMmpXRElx?=
 =?utf-8?B?WTdVUWliZGE5R2h0Z2pBc2NJck9lV1dSbTdnRHkyeEE5b0tCcVg1b1NzbkFq?=
 =?utf-8?B?Z1I0UW1JeGNhU3RwWlBPZHFGWWF1NU44Q1ZlMVM2Zy91aWlNc2pEemthK250?=
 =?utf-8?B?VnlqbHdGRGJIRDJNM0pWSU1pRzB5cnJpMVNNcmE2N1pLSVprSVNTUEx2VWJw?=
 =?utf-8?B?TStPODUvbkFMK2NPV2NvM2Myd1gyK0JVbkloMW12VHhvUHNqTnM3R2xIZ09H?=
 =?utf-8?Q?BBIN5Dcj6hDdHmB+vLVx2jWQ8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16800857-1b97-48ef-09cc-08dc948b88c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 20:23:39.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EcnBQNT6L7LCrLYp/8Tfrwy9ZW+yaBC5zn+wfYwUJQkJSXfghJZ2eJfWDA17yQEnNTbWVWqadw5shmSCa4OeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3599

On 24.06.24 18:24, Conor Dooley wrote:
> On Mon, Jun 24, 2024 at 08:20:49AM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Expand bindings to cover both the MCU and the main usage of the AM654
>> system controller.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../soc/ti/ti,am654-system-controller.yaml    | 29 +++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> index e79803e586ca..0eec807f38df 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> @@ -34,6 +34,35 @@ patternProperties:
>>      type: object
>>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
>>  
>> +  "^mux-controller$":
>> +    type: object
>> +    description:
>> +      This is the SERDES lane control mux.
> 
> Where is this object described?
> 

Nowhere so far - I've only followed the pattern in
mfd/ti,j721e-system-controller.yaml. Would adding "ref:
/schemas/mux/reg-mux.yaml" be enough?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


