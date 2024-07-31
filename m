Return-Path: <linux-kernel+bounces-268367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70E9423C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36DFB20F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EC4C7D;
	Wed, 31 Jul 2024 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c0hy5eqU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2062.outbound.protection.outlook.com [40.92.40.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB464C6E;
	Wed, 31 Jul 2024 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385606; cv=fail; b=HCLSOPHy4Sk3q4pmVzerORbvvzZYSUcCPZS9fwPqjrqSlKxzTNGa4dfGTQOen3jfkX97yNttCZ7P+gwpZ/k2fxOa+8I12K1QXdt0rvZQOBZPO6M0Vo0Z3YmY/odObEgJH5LGzKBb9AhZ/7PwCHKuzOLBK4kedRxzCFcH6cTS9Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385606; c=relaxed/simple;
	bh=ck6n0pQSjILZar7X/FBQ+cCrrkRynm1IKZiE0BBm0ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGQhbMySSPz8oUk19FZec+OwIcuOvRJyliotr6H6VBoZqGUghAcjb61FgZiv5lO+ARmi3k0XK6YEQp+zDnpn4gLdovILcY6SdGX2M13YbfStFkca8gw0Sdr3SULN1JH7Ph47zDhe4NbJjnNOj7DghZ7a9Cfm5VPyh6U9L6eWivc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c0hy5eqU; arc=fail smtp.client-ip=40.92.40.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTKmk9fKJHvNwaFgJmP4P7J6qxWDRmAeqBSuRrzMe2kITZPZj00soZI0QEHIVUUBz0JKWNPmvAlAX1UQ4iNA0o6uNVXR9sggUs8BFSZGbuv2Ii5cc/of59baQBch7mKpZff70cIeIKA4c+WFuPI183ZN+u+pqzzDwfueVTATEj/3w+B2+QAwnD4AnLHUmWv1w/GziWcMwkpUdznwTQAS0LFXUY/D/ge55t6kaYG0CynFC7lIKGYppKCTFdnV1MVuGb1KYwevkouQ6wG9MUL0CB7FWDGUIrM/wfcfgbi2a7fN/XHQJUSxqJXbp0bu/8PFSBUqjrAZMRxmtSsEFai1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCpZEm2pRG19JHrDlNiolcw4MjqGkxh30sCjKShNWQw=;
 b=qryA2sAyNXAOoLj5SST7lZPNR0NOmoy3EndqJlO/5xFNwdv+pORQJ6N6bUnnHn/QiRC2YErwOMC5bgLKt7lwHaFR77DxA9kufyU+jtXA5t1TY4wJ3yd3798HZAFmIr+syrfERiqw/JWcjqaSaH+yl+CoPpzHfeeYrUKDBYhYJNmRFxMbMk1ezeiUMWaincC4GKfYArYzzMJZCBdF7AP889WnTRkxVwGGFYwfLj1d1r/jKgQmRo87jdtc3BLE79ACH8Jk8iw6m5OHUSWLk/fb3uolL/mU4lvzRyEGR7o0446soPOKkm8Wi/QlLAmNb7CC2/uXSXfes53SGM/1HLCE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCpZEm2pRG19JHrDlNiolcw4MjqGkxh30sCjKShNWQw=;
 b=c0hy5eqU2YPfJ2kQxpShfPS72mfPdCw5yUYKlMTk9+6nVTtv4Iz8VZDthjcd7PysBGpo5/+X35WjPGXNP4b84qpSBsg7e/Oc9rlTnVFZrmRC+a4UAHtL5noNGdQx5XI3B/kmIdrY9hQudCnueGCQ/sZJyp3qA2r9+PfgwBf6kX22B8lDxqJAW5V5W+fCWsApCKPzeblbveqMG3MiC7b4yz34bXTZ9imda822Saz4QrQEPEL26GvxLSmIKoq/2B9dBKkR+y/6EaIEyc1dkGtOjCHxv6I8TnH5V5lavv9aJXOboIqzRE6qfJWg0VTA6nGDktSszFovNEnVJ9AXKZ8vfQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6431.namprd20.prod.outlook.com (2603:10b6:208:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 00:26:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 00:26:41 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chao Wei <chao.wei@sophgo.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: dts: sophgo: Add i2c device support for sg2042
Date: Wed, 31 Jul 2024 08:26:08 +0800
Message-ID:
 <IA1PR20MB4953403F226F7C9B94D0E784BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [S3GDntIxyDMLurKV3vBSlekqDBgZtGo25AZX5PaeRYs=]
X-ClientProxiedBy: TY2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:404:56::33) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <172238551093.92905.13309137781560088395.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3b8f08-faa1-49df-027b-08dcb0f77327
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFCQMjUvxMGLyIpm4mOckbMCYHUrlLJFUUC5oz6dd0t8aBRQ0QNg6ESQq6W7xsqqzzh7e8eneybKtWcF8aDkVOJTv+V+hA8ArI5vXY53/AWuvWeSuQZjHiMgo635HfCOhnlBZGS7wGaoiZr79moPsxDtFEjr8/TcPnA17BNIxF+8PNvIYYJHdt/qYD2MLy22jgwM/NwOGgx+fg0n/VwWONzpJmggGCTVQuZmcDQAQvnCEBHFZhAKjKNfArwlIIHtrwI1zAYCoI9vjk8SgfttkXjHBiycY17+r087crnv34gFsWwPNaSxInjHhznMTrDY80l4SsmlFgD+0ZVxQzBKZhaJaMGjEkgtmozkevN2HrKtXSQ6uvEEEg7PSFH1v0DA24HNgbLxPB0bNf8Y7QHn6Ke71557F/2OXIXsqtJG/H2q9/QopvqD6r0EMXyk/WstWMeMc/9O8HVtVXLTV3gCYpzLXlTyoRc4l36UpqtaNtBe5ZVkFbECCoIPRQ/IH+Og4okgC/nNqQ4V8pnx+GSZjrRBIRQmJjW2qJePt8OWMh+OaAk0wLGwjRp2CAm7BvSZ9otfPs8GHKibKrtpQYY46/2ltYkG0MgG2GexX2ZFn/BDmB0keS+gUzkygzbk5Fbr8Jaqb1toZ5mTGz77s+egLriZ3x6W0tz9jq5KGYPcvVe8sdGgAfu6uuwBdvXjq9Djtcfn59uym1yiqZhre9DTgnWIhTlUJYqOagSSCNPcs7o9UQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|461199028|1602099012|3412199025|440099028|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	/6XpenHiaW8W16sjuD1pI9gedCe6ckoS9mn03O1HjTb/ApCeItCaJTxxKbXhUTdkI8adoO3YG6SFdFc+iv97ZvQpN+89CVvENxLr7Rs+kR0jguz0GWHgZcayAgXUHK1WPPx4b53echelcRCXZAAM5wligSZVd+8rgYPjG3/U1TVTnkMZYjRQExCL+Kug32Xmrv/ouxHDv/hPBm5YmlNN/GsTK5+q7uLvyuRcROKjpWCRTEzGcqTNufxgEK7SM7aDu/wjjfMPNCJv8yYseR5DkIVQ/Lad8mAlNwD1xymw2nwC6vkcP6Js34DzVBdzVTyc8lCFx6juYonkpdJomU66qqvT7AbmBtYnT7qGH9XX8OYQyjXXxIOfaddmgzB0CZqW1AmpTG4kfM3eA8A1A+d+ob2C5oanY/nKpxm4Lo/6o8zDc65Y2gLBwq1qXymOkxVfzDi4L17SjCtZeAL61ny5FTlyCDP+Raogiu3fehFMb+QOkVcXUf5BiL+UK5azrXgAh8TXd8LLPa3HY/vUaPapjzJYW90f3criaLfpoNKZG/KKAEVxzVm61g0PrvDsHcQ3tMWOZy+Q772Yg6B01RN+XVfOUm13BF9k46tvhfWydVJ5hgqKRDTjeA/wf90ju0DgjSL5Z5pJx2HJBeohUDGCENNHbUNbctqlEeqlH4xmz+axrWqfl9iNcgDFvbTyGL/qEUgk1rEqjdn9ggnXuzpp5JWezHOB/llhETDtAROCFoyxc08/JHpeElOCvUy09TK9r6oXH1MR5cxMHa/26PJKv5pJR+UmskwKAGz8y5gk2gynATJxU99tvMVCYLVDOZG9aQgDqZGptVSd1mT0BJvpeQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3UraUlFTnl0L0VRSlJLSkYxeE1VNnBCdTVZaURJUlJwMEpDblJKeEllem5K?=
 =?utf-8?B?b1haOWxNdHZIOC9YblhmMkRZOUMraHpvKzhxTTk1NTN3dEl6c1RpYStyb0tS?=
 =?utf-8?B?ZG50NFR3QXVRQ1VXZ2ZVdjFhTUJGUTVSTEFFQ0h0bXBOSHpZVnpRM2JYODZq?=
 =?utf-8?B?ZG9nd3FmYzl2OEgralQwSk1zclYwYVE5dHlvQVVBY21pZkRiOVY4QmhnWVRY?=
 =?utf-8?B?aWhZZklKYi9mcEQxWUxFV1AwdHo3cXZhSWNlOGhCbmRYT0VOMEhMazVBR0ts?=
 =?utf-8?B?T1FvQUNYZzJkR2doOEprL25qVk9pOVdqUkE0NjNDZ0lwYys3S3NBekE1aFlV?=
 =?utf-8?B?dDRrTTY5Qk5YT3VWSFZsNFhpRTJ4VTQ5QUJISzg5QzV1K0kxTndWWEpKbUhy?=
 =?utf-8?B?cWdpTTBabFdJMXNEanpzblI3UDZxeTlzVFhnY1FvVlBMZzNoUGYrQW5oeHRu?=
 =?utf-8?B?M1VkSXh6d2RLcFE5VnJCV0dmaS9sZklPaW5TeUdZcDlMMVJzWlZSK0k2dGpq?=
 =?utf-8?B?akk1T1FaMHRBcklmVWlSdGpQUG0yUHlUR1VjSEt6TllNbDc2RloyUlFiUFlz?=
 =?utf-8?B?SWtDdXN6Sy9KdjRBVUxhRkNvK0RyMVd5RGZqdW5pYnNJVWh2eGpjUFRqNGlP?=
 =?utf-8?B?WWFublFCUWxjNUtjdGZBL3lzNmwvNEhZajhlZU93UFl2WlhwY1ZYNmpRK2Y4?=
 =?utf-8?B?ZjRBS3RqZkM3ci9xQnVSSjZvYmp1cStZMjFFRFJWN3A1c2tqNnl0MEVoWUlS?=
 =?utf-8?B?RFY2WUlZN21rQnVOTVY4VVJGQnE1NjU5V0E1dlpLYVNxemphV0J4aTFLRG9r?=
 =?utf-8?B?V2RKT1hOZVVjTHZUVzRNbnE3N0Izb0xQQTZNV0FUaTd2c1MvMEJJYzQ0Zy9z?=
 =?utf-8?B?eGhVL2szZFA3Nm9McmpPeE1xQ09Zc216SHJrQUl3T3ZEN243RjNaR0hyNERm?=
 =?utf-8?B?U0F2dEFRS3pocFByM1o5ZWVwb2VxYXpJUWRwRktwYlpDaVE5c3JLb1dnNXJs?=
 =?utf-8?B?bSs5bHM0TEtIUXpFQWRveWpHUzBlVEF3ZzZxNW9XdkVhaVVNMStFbkJqT2N5?=
 =?utf-8?B?cTc4MDNMeEorNTIrUkIrcU1SeDVKNytxTVdaMVFTZ1ZEa1FlUVdZZlUzTHNH?=
 =?utf-8?B?Mk9nSTBjdFF4TXA4dE9IcGVTUU1WRVJMK01ZMGp4MXd6OFQrR2VqYTk5TjJV?=
 =?utf-8?B?cktqdTBvY2RqYmlpNXRBbUhGQjVCenNvNzRxTmxZNFBpVlRJWmkxakFobmlE?=
 =?utf-8?B?TUJOT25KVS9GWnJyS1piM3MzOTV6L3V1bUZUMFlTTXZBdTBhVmpjbll5YWFJ?=
 =?utf-8?B?c2d3czloajVZdUIyU0NuUXVmckV6SmNqSWd1Y2k4YVFPcmJYODdiSEZUdUtZ?=
 =?utf-8?B?Z2Vub1hTNC9lVDN3cmFMUy9ST3lNN2l2amhGUUtYUEVNbzVLUGJJNXk1UTRt?=
 =?utf-8?B?cFY4Tlp4c2dCZjN0UmUyemptZGxGWDJWVGR2eEJ0bElsZzUyQ1d2Znh3VWl0?=
 =?utf-8?B?bFROdGVRRWFQT2E4U3YwOVh5eGhEem5WQVN4YU5uM1psbTV5YTNZWHJvVGhV?=
 =?utf-8?B?SWhwemxkR3pxV2VaUEFLTEg4cmR3RnpCR0JHSDlSTTRiYjVqQmx5N1lWaUgr?=
 =?utf-8?B?WFZ3TDBIZU95Ty9WcFNVTUdzeFV0ZEpMVzl6N3EwcDN2ZVpFUnpjUWJORk9B?=
 =?utf-8?Q?1hzzFT/yzOdnPRwAc9Sk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b8f08-faa1-49df-027b-08dcb0f77327
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 00:26:41.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6431

On Mon, 29 Jul 2024 10:12:51 +0800, Inochi Amaoto wrote:
> Add i2c dt node for sg2042
> 
> Changed from v1:
> 1. split the "interrupt-parent" change as a separated patch
> 
> Inochi Amaoto (2):
>   riscv: dts: sophgo: Use common "interrupt-parent" for all peripherals
>     for sg2042
>   riscv: dts: sophgo: Add i2c device support for sg2042
> 
> [...]

Applied to sophgo/for-next, thanks!

[1/2] riscv: dts: sophgo: Use common "interrupt-parent" for all peripherals for sg2042
      https://github.com/sophgo/linux/commit/3e2b6b3302bb40c75756c74c38ee30cf34cd2879
[2/2] riscv: dts: sophgo: Add i2c device support for sg2042
      https://github.com/sophgo/linux/commit/d9773e09adddf5cd69889545a5feeff119dc9034

Thanks,
Inochi


