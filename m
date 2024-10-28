Return-Path: <linux-kernel+bounces-386048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37959B3E85
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282DE1F2328C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862E1FBF7E;
	Mon, 28 Oct 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="skFfcRor"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2108.outbound.protection.outlook.com [40.92.103.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059A1EE02D;
	Mon, 28 Oct 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158492; cv=fail; b=dINYBHoi1HI9zh5KjQv3WngRocmsHlQfdikl7+bn6D2vfA8hm76tDEghGfwGhD+uebqUVrzcKw+DoMRszUv1fR/LuHpSty4N9pNPhLbOek4iITrqWvVhWu3eCBXadu45ieKGhM3Qle0+WWTqZKWjqq2QHWPv1/R3TWKohQmQlu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158492; c=relaxed/simple;
	bh=DEzQiDw7/1vSavjfr2FUy0L0gB6MoGEXlffEtV3QmS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XtqTU481o5EchEuuJtiXYF0cltBi/y0or5D3T8ct5ogRhiFEsNmgpbKC1rMArsybH0fIv49sKzYN2bMqwlIczza9+BfbTSPvdvsrAYHGDbaXcjXS5GEX8VfAw2OuKpTvCktKSQpBHjzTKC2kh/nfEWgXle5Gw5z5pLj76B/oQxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=skFfcRor; arc=fail smtp.client-ip=40.92.103.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIlFb7ezdXMnrXBbBBaAbYo5MoUZgMFY3V3enrEU777rqp3F0s1UUJrhWR/EPOEvwoBQqRADwdj6Tycevd6AtHF0WTYwKsACoPJyv/F5O774lc5RZVcvJMsGG1BEVv9KQOigNmfgeFv3TYX63F7DLqeU+YSBRd4Gy0X8EPv1xby2aGlQmi4vRqTO1pkZO9FKlQQmnHiimpnTwR1bsOcceGkiKlj/53qYsu+DhOqZ5z9lmBNPXaguTWCfDXGnOtbmOCkdZ565nP7YdSrKpBYoZma+qIHConLgo9XXnj5P/8BqSeraC9CCbFxzAjPzrC3HzPdxKQlIgW2VVGQujtS91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvpV/6HZ17YVElaQJ71f+RRCf4bAmg6nwjA9Mm75a0o=;
 b=VlkNi45XG7rkWXsclNC88vWQ+W4ZzosmLH8DUaXFFmwZzF+9E3I7+1Oep+SXEwwUwVHyMMaBzoj4pT4zzY2iaHighwh6xvw+2Le9b3eD0wlzLf8NgOUBv7yHSN1EdJFHMs34J/lvk5WcTrWF4j1a1asyR8/qcLlz4hXZNf+YiTJ0AYPdQkcDPyjtzqVHLE/r2nVsEw1eLjcYY8l2MdXjXxHwBRP18dlCa094+lB+Ky2Ii2ul0GYjS9FE30/F6VdCjX8FrseqmFUhxoW2NeQI3Yv+XbmOY7kPb3y8/PyOlrGGk65YbPUevbItleiKq9KyKhnD9K1gu7GnQ6KXxFBBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvpV/6HZ17YVElaQJ71f+RRCf4bAmg6nwjA9Mm75a0o=;
 b=skFfcRor75jSrlueu3RkrDF0Cu2tgKhIk2mX8re20cmWLhmh9N3AbuJtrjK5XErFDCnpgtGFyXYUVlKnpByPw98SNd07NLmfOk39hfgXXiTCIZtC2JMLT+laJAbyTE2XjKZGWmllIEWxLhlySC7B6pPy5I8RPsopOHyRrSbAy2EnDCmgX+pQjySu3QvIe5jnqmqk+PJID/AZv8XwMOy4Ng4Hge2SauKQSVNh5l9tge1vDIfmhOrKCV/1xEBj5ZKiUhhceVzCl2h1v5yC3uYZyS5bcK7dSIjwyox3eeiCUpz/4pMKal8y4faiZzZf6O1eoNiCtWtvEEBunyusmGAQWw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1534.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 23:34:45 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 23:34:45 +0000
Message-ID:
 <MA0P287MB282284A77094A096573A23F2FE4A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 29 Oct 2024 07:34:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: sophgo: fix pinctrl base-address
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>
References: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0a56a8e6-6c8c-43e4-a2e6-527dc85bf528@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1534:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c77e83-5d7e-47f1-04c3-08dcf7a91ac9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|15080799006|19110799003|5072599009|8060799006|7092599003|10035399004|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVlkQUY4YnUrc21EWnZTa3p3L0lROTNFdTZJTEhGb0RZOWxqclFJbDFyc2Jk?=
 =?utf-8?B?R1BIRE41ZSt1VDhMdnJHaVlrcHVaVGhLNi96czZ6a0w4WU9QdFBhdUYxTDQv?=
 =?utf-8?B?TlZ1am40OG5KTlN3N0hBa0V5NUhNUFk3dVdkUTdKeVNQQU9wQng3bU5XSU9M?=
 =?utf-8?B?eGQ2d2J0Y2YwYnRjcVRnOExmZ3BaWjB1Zk9UMEFtUmZBZGQ0cmd5eXFwazc1?=
 =?utf-8?B?bUJONnNJaTl0dHZLVUxCUjFyano4V3Q2RjlCcVFZYmRBdDRYR1RHYmNEbEdG?=
 =?utf-8?B?blM0a0ZKZmpQUUNIVDYya3pIajRyc3Z0ZXFpSkd4L3RLU0RZdXZ6eFhLdWN6?=
 =?utf-8?B?aHM3c2lGY2kzTTIzRndTaFAwNVJWRFBtUW1YcjFpcHZ2MmdBenFtclJrcURy?=
 =?utf-8?B?Zy9tUENNZHZ3cHlQQkhKaTc1cUU3UDZSZUhmSlo4WGV2Snp3N3JtM1FON0pa?=
 =?utf-8?B?ZWNsem9kVHB2bE5wbTBXVDd1TzJXY2c2aUtibUllRkRqQTh4czBEV1RVVjdB?=
 =?utf-8?B?b09Zd3VYTy9yR0trYXVmNXBJcHNYL01WWlVoMTR4OHI1ZTVHUkJ0SkFueFl1?=
 =?utf-8?B?SXRlajI4VTUwaDVUbVBpN1ZFbm41OGE0NlFKWlNTM2Y3V05mYTZXb1hqdExM?=
 =?utf-8?B?RmJ6UGpjdi82WUdrckgwNXUrV3BCemp5bDRrbDVLRjFqUVQ1Tm83a0hCTjBG?=
 =?utf-8?B?SHJUSmFBRklxVWJVeVVvUFdvUm1BcWxDYXBRZEVJU21ZNE5IdjJ3SGNGdWFy?=
 =?utf-8?B?UlhFSmM4WkNtK1l5c2NSN0VpNHBuOHQxdDRSVW5KU2lndjh0VjdHOHZ1bUVi?=
 =?utf-8?B?RGp6Q0ZqVVIzMlhJVmF3M3pwRUE3ZUZHTjRQQStvUnY4NHo3ZkhIakVzbVpG?=
 =?utf-8?B?MUJ4Q2xqaW1QeHhCL3o3NCtTR3BtQjFSaUhVN3RpWThWTTNDUFNWQmxhUnVD?=
 =?utf-8?B?cFBHNUowY3A0U0RVMnlqY2ZvVW04TnJoNlRlWUpIQWk4UXhIZ1R4cGdrWmh2?=
 =?utf-8?B?ZHFPZE41YkhnY25PSEQvbU5xQStlcm5MM2o2ei9QYzY3MUczV2EwLytmVStB?=
 =?utf-8?B?dVMxc1hDR0FpMTAwVk0rKzdwZzQwbDFOWkEvYWNDeVpHbnpHS0xOZzUxbnF2?=
 =?utf-8?B?Ry9TTGJtdkRiN0YycHl5emEydzRwWUtEam9ZUitLWGpoYUFvRS9RS1JRQTZT?=
 =?utf-8?B?TkFFalRPR3hSaWhYSzBTYy94NVdwaDlXS0p6SGpHZThUT1hKWGN5Z2NtbURO?=
 =?utf-8?B?SkN0QnBXSHAzaTd3L0pieGVHakhQc2xlZTh0UzRFZlJSY2VrUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlE4ZE10OTBDMlRaN28vVHgzKzdOT3ZlMVprZFZPQnIrZUlqdEQ2QXNnK0pE?=
 =?utf-8?B?eXAreWM0UTVhL0tSSlNOdHNaNkdERDlkc2hucUx6bk9sK1lnK3RwMDJSM1lQ?=
 =?utf-8?B?dVdicHpFR1BWNWh5RGc4TFZpaU5WMTZwYi80djJQVDBMbUQ2dU5xNzNyeUp1?=
 =?utf-8?B?K3E2bW91Uk1LandZU2FreFExeEtoRDB5bGxweHhCWkFsMDdsSHg1ZEpXQVJB?=
 =?utf-8?B?eGo3VGxIVDdlWGV0L2NoMUpTQ2NwMG1QN0xVUlVYekZFb1ZEU2oxQ05pUlFr?=
 =?utf-8?B?MXYySDZxOTdWdEVBdGlGSkpZMmsvMUNyZjB2Wlhaa2k3aU5PUk1vbjZZRG1m?=
 =?utf-8?B?TTlMRzA4WE1Wc2hDZ3hQY0xQeTJWbENYOXVUSm1wajh6SUN0UFhQWnJ0U2tZ?=
 =?utf-8?B?YWYzRE15SkxEU2xsUWN0SU9LR2k2Z09mck1qRktrT2U3ZjVQdTFMZjhmUXJp?=
 =?utf-8?B?bXJkc0xjRHkyZWlmOXFiL1ZxazM2UnpSRDR2V01yMHd3NHdSK1RuV1lwSHVO?=
 =?utf-8?B?WEt4azByOGJJeDBvYW5seHpWRHkwZTQrbDJzMndKUmpMUWJrdmJDdXoza1hx?=
 =?utf-8?B?aVBTY3pvRWpvK0xuMzdBYlVMOVUwMmlJT3dSb3FyT0tLbzcyWG12L2JOV29v?=
 =?utf-8?B?NStDdGQvWFhVQXJyNEpGLzZITlJ2aXJhTGx1Ni9HaHpYK1NUWWQ0VmF3bStJ?=
 =?utf-8?B?QkVJQngzejhrbEUydTZ1bDI0NUxicmhUM2NpQW10REJrcVQ0eUVPM0ppeXBN?=
 =?utf-8?B?VnZ1ekxzdUYxVG1ab0E5dEk2Z3dlRmNic1VTejUybld3dU0wSG9yRW1LZEZU?=
 =?utf-8?B?ODM4UXY0WnJYaUZQbjA0aG5EK3VoTGc4V1ZPc3FiYVVyd2pPdi9oRjZ1Q2JO?=
 =?utf-8?B?dnVaNDh6SnpIWDQ1MHJPZXR0MHZ4Qk55b1BGeXFLeW5MejFNM2tFY0JydGwz?=
 =?utf-8?B?QWVKMDM4YWI4QUJBYVNzVnMxZm9FY1AzT2dRZHNCUmJzRkQ1SDZqTUtPYUN4?=
 =?utf-8?B?WTFjVEJzblk3R2h5WnVJdjNuVXJEbUpyYW1ZRHp3R21iNzZGbTRLSHJVU1Ir?=
 =?utf-8?B?bkNxSWpVMkNQWUF0d0wxU1hhM3dWOHI3SDVWQ01pSmpDZzFIdCs2UHFRMnVJ?=
 =?utf-8?B?ZjFYUHA3ejF6ZlZueFlXQ2ZqdFphLzFoK3I0SVQ3b0NNMG9EcDExU2lKWllS?=
 =?utf-8?B?K2dkMEtoWHpxRVRWNVdrZG0zWEpndllOb05jRHR6cmRtcU45cTNJUW0vTHJx?=
 =?utf-8?B?Wm0ybVBBVmZzUkdoeDV1M0tQZG5aOVFaNjJwUWQ3YnlQUWMvZ1BDRFBYOHZW?=
 =?utf-8?B?bGtraFFpaWdHams0RjJGakNBc1lPSWwzRXQzS1VNVEZaZmhsTk1iVkx3MTBE?=
 =?utf-8?B?b055NEk4OFZqaGZNUjMwRm8yUUV1SzV4akNFQ1VvMWVUNkZZRktyVGdGYUlP?=
 =?utf-8?B?QTdqMXZjd21CdXNpU1BEM2QydjlDWHhLaUtZMWQrQVpPZEFScWkzNzNHZnZk?=
 =?utf-8?B?TUVRMGtzd1hHMi9iV1JIenVweld1Yzc1R0hRWkRiOFl0QmsrMXRLNTBUV1c3?=
 =?utf-8?B?d1FiMURCTEs3QlRITUdJSXgybW1PWTJ2c1ViUFJVcXhjVkNzTy9QaUpPNHR0?=
 =?utf-8?B?dEtLWFBwZnM3SlF2ajdRd0xQeUlBbXQ4aUhXTElkaHpjN0UxckwrUHZ3aTRz?=
 =?utf-8?Q?twJbta4eZEQLqI83Ol8P?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c77e83-5d7e-47f1-04c3-08dcf7a91ac9
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 23:34:45.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1534

Hello~, Thomas

This problem is introduced by this patchset [1], which is still on the 
sophgo/for-next branch and has not been submitted to the main line. So I 
think the right thing to do is to submit another version v6 with your 
bugfix.

Link: 
https://lore.kernel.org/linux-riscv/20241010-sg2002-v5-0-a0f2e582b932@bootlin.com/ 
[1]

Thanks,

Chen

On 2024/10/28 18:43, Thomas Bonnefille wrote:
> Fix the base-address of the pinctrl controller to match its register
> address.
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2002.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> index 242fde84443f0d6a2c8476666dfa3d72727071b1..6616f578d190f7aa2a82b233fa9c55267b41ee0e 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> @@ -16,7 +16,7 @@ memory@80000000 {
>   	};
>   
>   	soc {
> -		pinctrl: pinctrl@3008000 {
> +		pinctrl: pinctrl@3001000 {
>   			compatible = "sophgo,sg2002-pinctrl";
>   			reg = <0x03001000 0x1000>,
>   			      <0x05027000 0x1000>;
>
> ---
> base-commit: 45a544a62ef7cac9ecc69585a90da72ca68af898
> change-id: 20241028-fix-address-e7f0c40eac2c
>
> Best regards,

