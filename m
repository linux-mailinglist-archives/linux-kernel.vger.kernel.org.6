Return-Path: <linux-kernel+bounces-526450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0472BA3FECF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E731819C7551
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA42512FE;
	Fri, 21 Feb 2025 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kFnbmfdM"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2095.outbound.protection.outlook.com [40.92.58.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9971D5AA7;
	Fri, 21 Feb 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162473; cv=fail; b=S3xuig4OB8u8GALfJOFM0WE8wEe0vMzNfRIzTCjPIo/6/XKXAkj5MVPqlIYZuOKbKr5dYxIpPW3dur9/1EW+HGCXEUBAcyokaDJ1alLX1IalrcWodLy4T/YhPycVqtnJyO1hMxAC5fS6OdlyAll0LpcKhrwONAvo+hhaedVxSUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162473; c=relaxed/simple;
	bh=A4ePnOMT8Up35+rMlPXzd/lagByAhTXfVKGbhNjLMzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uzhpNaJA8IFuD/eLWmZ8mhiy5P2xYLZ8iANPSzya+ZowMwnzuxld5I6uNo91nc8geR2YVwwP7+3UDgLP6HM6cWEIrLHcTS0/wdW3ottHnHMpuqE6KNBTeAubiWx2ApvfSPSaYDC7d2Cd1fN6E0YwzkvDkbTtrDBMgLIMTCX2chc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kFnbmfdM; arc=fail smtp.client-ip=40.92.58.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUYYxFIXrRIEqgFzoXLjPA4LbY8pDZhXQY0Nxd+bFKCf59qJCAASCAxwVQ5ucrkYrjzd89lMEPmQQTKHqV2vvX3mDQyJh9Y3zN5ZM3uJUsCn2QqH+GEhE4rJOJAYw/B/5PZJ/L0GCapZ/pCkUQW9VNeSwOXuIxy01WgqMNwRBOFudAqF3xE55nwJgVqVM+5S0RT+nPwmv3C6AgE/TqK2Efm0iUPqHpQhlAvyp100nqQtjxswli1ebZ9zOd+dsFpG0bpmSzjeldSA4f/ASBGw8/cK9D/SfQ28WmovsGQiVvKtJbCpXoaNC/rC+WMcaC2u6kUjSONY2t1o7Du2MdfW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r7hKyArOjEkZviJW0WSxKu7tyWIFSlN3CH5B78ntDE=;
 b=E9Kdb7Za+MW5W19Dasky+vFx91T0hU3xxf0wSPKEF6epc80TubiJfX5lq/rrNrQMThniQos3FJdwumuMDnEdzRymIC24pSRsznt9KN/e6bLuHXkL4nODofs7zry4igbj1MuhU28Tu7TJKbyQZ6+nRuPJiowdsfERdKHrXfmDdS6/I7xDY8XCOm0Eff1jawXus/AQplVPvI9UPO2GCbzTbMDQDPdpoMa/9aC56te4QjBJPBcKJsGVBcxZadpm3ndo/TPJzUOJxMZWTtMHy5fmm4/V77n+5aWdMTBe8JgNSVZhll1cvLjuzwuaovjYOV1OniB0gUZDHJF5mHEagsaVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r7hKyArOjEkZviJW0WSxKu7tyWIFSlN3CH5B78ntDE=;
 b=kFnbmfdMg82APPEAQBQDKYWdTudHu5qXCWR2wAukXGNXwIKNuaj1/Ddh0E0heXo0/bvHJAPO9s4DSXHmIfOi3DhopwWbVJs9LOf+aq3nabJXNRgz88SZzkg9nmYSO+aOTrm9qKK+CJNEH7v7LaMnZLkbdzQBGdwOz0H5YRpn+AvbdUf2WwvZHyblWc1rCLYivqn2fPa2xYLCraz59azGZNEa7aPX11+cFH4friF4X53Yx3ABLGpaUKDtWcvu6LS0EGcaJP20poPJ36JNooNlKqb1wvenUX3sltPWHzPdG1+bxGdCcXxB5YKq31vhgm2QnqobYWgexQv8qp/bHWkxLA==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by PAWP189MB2804.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:46a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 18:27:48 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%2]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 18:27:48 +0000
Message-ID:
 <AM7P189MB1009AC050A4FFC8BBB5D718DE3C72@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Fri, 21 Feb 2025 19:27:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: dts: starfive: fml13v01: enable USB 3.0 port
To: Sandie Cao <sandie.cao@deepcomputing.io>,
 Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250221055857.481992-1-sandie.cao@deepcomputing.io>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20250221055857.481992-1-sandie.cao@deepcomputing.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <a9d642ad-a036-4429-8986-3fd851d171e4@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|PAWP189MB2804:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ffc30a-bbb5-4e8f-5669-08dd52a57176
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|461199028|5072599009|6090799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGlvS0N6ZWFRbFVRNTF6Y01YRXcyajZ5SVNUZXlzNEhGWXlKZWdGY1Q3ZlVy?=
 =?utf-8?B?ZW9DTWRPU1IybGlzR1FNR1Jvd1gzSWpHcnA4aUJKSVNzSWZZdkExRjEwNTEy?=
 =?utf-8?B?SFhDYnp0bVhKVjQ4cld3UzlUQUtuanpmYzNObDV6OEh6ZVRON3lwWWRlMjJM?=
 =?utf-8?B?UmFTM0tZbExtQjdSaktDMzMvcVNoOWg0bXFmNllGejEzOTVtdkZRT2VOMys0?=
 =?utf-8?B?ajg4QkRLRVNscmlNZFdVb0YxRW5rT0xmNEVSdXVJT2JrRy9hVmpSSHRwSmxQ?=
 =?utf-8?B?akVraUNhUUFBTjhrM2JuejM4WEVYWkY2emNWekErRmtHajd0c1hVanVyc053?=
 =?utf-8?B?R3Eza0VzcVR5TTFCaE05SWhSQ0gxRXd5OEFqQzZQeUlnTm5abDEvTmE0RTZ5?=
 =?utf-8?B?ekJjS25QM2tFTDAwdW9xaUg3dVorZWE3V0lseUVxeXRsZnFyRzZEeXVTOEgr?=
 =?utf-8?B?NC9KQkoyS2hQTjBHNDB0SHl0TFgwbmJtcVZncnkwUU1lZU9QenFVcW84UFIv?=
 =?utf-8?B?TWRJZ2EwNXQ4WUxuZXQ2VmdrNlNnS3ZTMFh2dXN4S2t3amdwalYxU1daT3py?=
 =?utf-8?B?djhoSTY4ZEI1M1dDOFlmMkdyZ1VGTktmNTAyaDYrRWM0VGowZ1NueU1TNGdx?=
 =?utf-8?B?Nmc4emVjS3k1TVYwb3hJTklEdlZVaTU3RUNveGVOc01JUm5nVUh2alhTOWRm?=
 =?utf-8?B?cnMzVzJWOVZHR1pKTnFXY1B1dEdkRzNYNHFnWUM1bUYzUmZWK2lTbXJUa2wz?=
 =?utf-8?B?UFBBMjduZ28wMVR2MlV4dmdKYitERlRKdlBKdFVvbVloNmcxbmUvNFBMc3g2?=
 =?utf-8?B?anAyanlnNWVGQ2pXUWtYV3dLM09mRnI0U1RiblJEdlFSYVpTYW5ZaW5HSi9t?=
 =?utf-8?B?MkZvNnlhZitCYlJpVExFL1Z1ZnRleGJ1eFk2a1NwQW9EbFQydkltM2JWd2g3?=
 =?utf-8?B?Y3E1M3BqdHNNUEN0dFY5cng0MnA5RWNUTlo0RWJ1VjUzNnZ3d1o3aVAwOXJ5?=
 =?utf-8?B?RnVKalpKRWx5cUZQTmhUN1VtVTRNODNhRjQvTU9ZUitIbitMN0g4ZERYQkwy?=
 =?utf-8?B?Z0NOdkNtZTA1eEtpSzJpYVpHeFBuRnZmckxHYXpFbkxHcFptcEJJQW5FNWg1?=
 =?utf-8?B?TTNyUkk5SEExcDJMZkRYOENzZVVrVVJSUlBYMTVOWjRkM1pRK3hDaW1rdmtJ?=
 =?utf-8?B?aDdhV09EK21RNWM2OFBwa2wyNHIrWWZjSEt4R3VvTk5uWXNOYnozM1J0UWpl?=
 =?utf-8?B?a3VpODFqVTZBZHcyQ0RsMkVzQldZT3BKeVo1Wno3amx0djU5Z3VuUDIyb2Ez?=
 =?utf-8?B?bHhLaFoza3hIWEVNZkVSLzNJUkxTZ0Vvd01uNTB0SGh1UkZwZkN4NzBDSTdL?=
 =?utf-8?B?SFNORElpV0pUcUxiWlZnaTVkK3A1eExKS0dFd2E2QU9rMXZSV0tGYm9pQWhV?=
 =?utf-8?B?bFk1TVRwRFlmd1IrTG9uc0ZUSDliMlhaU2JPd3h3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBscThnUmZVVTZ0c0VUQ205MDE4RFRCV24zSEhxVlc5cUtiYkVDYUhxSXJw?=
 =?utf-8?B?NkRjQlJITldDM1cvQ3NvNWxBV2VOVXhESWdSZHc0OWpRdmk2VGl2SlpoU3R2?=
 =?utf-8?B?elFBbi9zbkhjUzZTNTh5a1ZPeGhIMW9YQ0Fkc1hnNWw5MkR6WTRNRXk2N0dS?=
 =?utf-8?B?WElJSkpqcjlhS21hRm1TM3d5T2xlSWRnZW0yaExCaE1jZEluRU52enVpd3RE?=
 =?utf-8?B?ZjlCeGVYV2l1R2I5R25OY2k3U1dYZFpiRmNPY1U5VnRsUTVqa01GMmZPRVJm?=
 =?utf-8?B?eDlacjdnZWY1NEo4YW9lM3gwVzJhK3IybnBtTFQwRG0wYjlGbGh1SGFlckRm?=
 =?utf-8?B?VlhlU0Nvc0QxZ0dyZzdhbkUyQzV3T0dCdWIwUWhlWHFBcGJXYlVDTWF5M3g5?=
 =?utf-8?B?cHREdklEMGlZQTlqaXZSSzF6MGJINlM4bmZPdzEyWWdEa1pnZDNHdmEyQ2Ra?=
 =?utf-8?B?NXM3ZUlDZEhsZlRyZ29UNm5uODhUUkpwUDE1QVFWazlUV2VqZlpsWGFSQzht?=
 =?utf-8?B?RHZOdk1WUXQ0RXN0MTh4Y0lDOTlRRHUrREx0MkxDdDUyUWdlK3dnL21FVnFa?=
 =?utf-8?B?U1cxMDNoSWcxOC85N3NtTVNHblZKU3NqeU1aTW9XRnJpcTVud3JSRVMvaWtC?=
 =?utf-8?B?Z29RSEFzVnF0a1JVUkx6MTNvNVAwU2hiRzBZdExuQTE5Vmd3UklPYUlsdHVT?=
 =?utf-8?B?dzNKWkJsc20rVnh6QzhDZi9jdzA1OUk1YWo0bUJpNCtKU0FwdzVMWnZMMHZG?=
 =?utf-8?B?cTd1YTUvV0wwcis3MG44V1FQL0c3Z01LNk9iUDhHUi81K3dTZmZHeEZnZHUr?=
 =?utf-8?B?ajR1Z1IzWE1WSUhUejlYOUowTTVERkswZi9odGhPckZsZDgvUVVwL0pwUEdr?=
 =?utf-8?B?ekxZOEVaS0NkOWRiSG5ScW1oQWRDT3AzajdVQXdWaHAwYXJQZVpOWFE2c3Ny?=
 =?utf-8?B?RDVmQWJNaGw2OG0xZ2h0T01BTFdtZU4wMGNDL3lxWWg5YUd1c0NGSGF5ZzF1?=
 =?utf-8?B?MDhHOFdqVWl3STg0bFh6Vy9WNXg2c2xjajR6WVgza2xpcFlyeU42cHZ0dzQ0?=
 =?utf-8?B?VnZmQkxCdGR2QTV3SGlMUGQ3czdjZm5iczNVVXBVTlhhRXRsQXdadVMrclZ4?=
 =?utf-8?B?bmRhSnFsUEFPNm5WeTdIT2JERUpQeFpyNUxQMmVjN29USmE2elNKWUVuQlhl?=
 =?utf-8?B?amRWdjBmeGhxSHo4VVdDblhudUYzaVlkMmduVmFqQ2MzTldQb2xnRkpkTW1G?=
 =?utf-8?B?SXByTWNnVVk0TkgvYU5GN25kbVBZdzZhN05CWXRINStSQ1A1eWJRNVJSS2Va?=
 =?utf-8?B?eWhGNU5NdWZxYmdkRmN3eTVDVWxvWjc4R0hKUEwxaWdFdVlYQ1R6TEZkWGRQ?=
 =?utf-8?B?cVpIcExwaUxNcDFZTU1rNDdzVEhjb1lnTW10ZUM2UXYwNi9Za21Sb2t4bWJ5?=
 =?utf-8?B?SDVhRjFmTC9kKzlUSFlQS1h4TG1qaTFsNW0xWlZpRFo1aytLTGdHTFZnZG1i?=
 =?utf-8?B?QVQ5MHoxcTF5ZXhZZ1hLUDAvSDJSQ0trUUI5eDM4WTJ1czlidllha2RKbHND?=
 =?utf-8?B?TzVoYW91QUhKUDkxSS9PNFBvSjVGYVNZVGRjUzlIdm1wbnlXWEQ4M012Mllq?=
 =?utf-8?B?QkJ2aGJDeTQxMjhzS0hEdkx5NmdNdGFhOUxyYW5lbDNjTzNRdno5ekFsU1pG?=
 =?utf-8?B?bUFCNHZRV0pTY1pmcmNONGV4MTFVWXIrVzNNaEQ2aG9ZQ01Ubkh1VUhjY0E0?=
 =?utf-8?Q?LABWHa+/Qag5cP9x3FcUsExpb2DQHb8EfEvS/wJ?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ffc30a-bbb5-4e8f-5669-08dd52a57176
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:27:48.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP189MB2804

On 2/21/25 6:58 AM, Sandie Cao wrote:
> Add usb_cdns3 and usb0_pins configuration to support super speed USB
> device on the FML13V01 board.
>
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> ---
>
> Changes in v2:
> - Remove space to pass checkpatch.pl.
> - Add usb0_pins and pass test on board.
>
>   .../jh7110-deepcomputing-fml13v01.dts         | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> index 8d9ce8b69a71..f2857d021d68 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -43,9 +43,28 @@ GPOEN_DISABLE,
>   			slew-rate = <0>;
>   		};
>   	};
> +
> +	usb0_pins: usb0-0 {
> +		vbus-pins {
> +			pinmux = <GPIOMUX(25,  GPOUT_SYS_USB_DRIVE_VBUS,
> +					       GPOEN_ENABLE,
> +					       GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
>   };
>   
>   &usb0 {
>   	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_pins>;
>   	status = "okay";
>   };
> +
> +&usb_cdns3 {
> +	phys = <&usbphy0>, <&pciephy0>;
> +	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
> +};
>
> base-commit: 38818f7c9c179351334b1faffc4d40bd28cc9c72

Works as expected, thank you very much!

Tested-by: Maud Spierings <maud_spierings@hotmail.com>

kind regards,
Maud


