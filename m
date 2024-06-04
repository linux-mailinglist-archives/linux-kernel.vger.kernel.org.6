Return-Path: <linux-kernel+bounces-200650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769058FB32D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2FB2AA55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E51465B4;
	Tue,  4 Jun 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQ3+Hxxu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C41465A8;
	Tue,  4 Jun 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505561; cv=fail; b=YukZRznn466AB451aJOYZfF+nRF+9wQdITwnIYGO9lZuncIQ8tq635qg7al2XYeoHOHnB0DtUZ+fJcSPE8z4V7o03nXUloPXyZPro/WcHu+QyqP0wi9tSb3CLd79dnzz2B+SRGgJSL+WLvihdnAb14QM8lcBf161/k81a57gEj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505561; c=relaxed/simple;
	bh=Lsj4EL/+pVKixBsSbcWW120ivRSG07vQJYFf/osERZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PkNXfl0zikdFXdRazhEN3sYkl1vfVbXcOji+7/WOYcAYmGKqjpc2UhQ76RaF+8eUnoTJsL04ASetfu3xdTumw7Li4fJqyBRgSb1eWJsDw3O9H61bKy1KeMxrQX+MzrZeJuJ+j+eJB0yC8j7f7rJlUVpP0RZH+AAjCpFPgPA2WDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQ3+Hxxu; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8UyEAYC5tSmtmS2KRn7yyEjq40OHReslO+ecgjpdoE+LjAMHlPe1sij0TsArRprGwQDjd65ZB5lRLvd4K+VIdPmf8jhLTXJrL/i/0VVJ/dcIhF8mAoA10WksnXT8g2VfojpWLuoFr8WCYZeONCYPk9rX58iIhpCUHXg+shjnK6K6qdaUG3tSaTsGmG7jKFZujF3HZaxR/KCSoQkGncvW1z5f8aiYHYrkHcwMGzsea6GO4qaEEffb804xuwdYL7EIkqbKUJ+bACLW1WmO5z8RsFp0jUtqbJF5o/fAFNEduvhKmu87bs2fRdaXOc4eILpyHrmzIFNywKrZ4/LO2FQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40NitisfLbrOuhMtLEQNstLR1M62XSZ7Htn4iWYhnE8=;
 b=kS6dGBZ929u/vXmuTPAwnK499qwi7jl3latRZv7eqf37+W8+mRxipSboylkETgHA9y3KVyV/mPkb3dFkMtRnihANkoWYXonYnfWiYlx/UG91Hr4v4jv4L/Dd0Lr4+5plv9LofMLB6DP09o4+rsXpFLYBzqipxKZKmCjF7QG/V+o/2QtqS9MEbQGFq4cHX/9rz7DA4tLKCDDxPBQu1uzHmw+Z9s7jdmN45yYbA0n9KAYGCTILcvf4Mjn5MkqhTwfTZVKVSAGCuozN+tqhgVHDZVQXMg5phKMwSiZRvWlr45Xqwrn5u/+goe0lg32+lYcGE2gDeuk3H963kEq1Sv5Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40NitisfLbrOuhMtLEQNstLR1M62XSZ7Htn4iWYhnE8=;
 b=HQ3+HxxutGEOUhI9VfG/nYsUJ8X+HoAdWw+11VuRfbrOvwqVTFTCtXWYT1bQSXundGPNhbjfznZjKfayiL7YN8eMgpvxBfsOt18hJoPPXUKCaLJTZ6W/H1RwGWOEbOqmS3Lcw+eEGnOp+tDZWuWdQINWMK/MFxAc9x4VtTq+MoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 12:52:29 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Tue, 4 Jun 2024
 12:52:29 +0000
Message-ID: <47b3cb0c-600a-43bf-9292-4164359f83d2@amd.com>
Date: Tue, 4 Jun 2024 14:52:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add coresight cpu debug support
To: Sean Anderson <sean.anderson@linux.dev>,
 linux-arm-kernel@lists.infradead.org
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20240503153422.1958812-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20240503153422.1958812-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8ae9da-1793-42b1-a562-08dc8495318a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1k2TDkxejVjZStvamx5WHVCakRVUU9iTkNvRlJXaWhVMDVKUnRGV1BrdC9k?=
 =?utf-8?B?UFJHaGJPd21QbVdTVU1FTXJ2WGJoZm9Eem1FamZ5dWRGZzRUaUg3dldSSU1H?=
 =?utf-8?B?K3YvWG9HV1RXREpQbnZ2Vk9sN2JZZTFUVE1SYVBBaDErVDRwV1l4bGNVbWhG?=
 =?utf-8?B?blU1TjlEUXF1Y0ZLZERIUEZabVIwbWo0Tmx4RVZrVGxSUUtka0I4TDMzenBB?=
 =?utf-8?B?SS91S0tWZkdsNzRvVjhQOHZTNU0xZU1QdThJUkNkTXhYQ1luejJCMThYVFZW?=
 =?utf-8?B?dFhzUzg3UWkxejEwaVVSOTdMc1BBREZGVjFnOVpDSi9rWXN4ZVJhUVpKUHdH?=
 =?utf-8?B?RW1PNFdTQkkrZjJYTFNhOW9kUDZUZ0VXV0dZazNtRm5ZdDFVZDVkMjIwYlBK?=
 =?utf-8?B?Q0Y3RXRyUlRkb0hTWEZ6elNwWlpDOHJlK3BjZnVUY0UvM09JODZTd1Z1L0lL?=
 =?utf-8?B?NmtQQUhVZXhJM2FKeGtHQ1R4RUF2MWphcXNUaC9rQmtvd2hvcnhZTWJTR2V2?=
 =?utf-8?B?V1g3RGdpMnpZcUxzUVNhU2RNdzg3cjdwaDlLRVViSk1KQnNuc2JPcDllaHJt?=
 =?utf-8?B?Rkdxbmd2ckdnWWkrOTQwc1RCQzZNMDVKM0NTREk3K1E5dkliMkgzK1ZHcG5J?=
 =?utf-8?B?OUtRcG5xWUM0bXNmcWdVclpBNWRXYllJcGFzOVFHOWc4dk94MjluWUs2ckZY?=
 =?utf-8?B?UlhHUi9zZ2F6K0NhelhwWEhWNWFldDRyVWFVeUJWVHNPNkEvV0s5aFQ2ZEpp?=
 =?utf-8?B?MkJDMGhhOWt4ZUE2bGdvSDh6a1dkTTVVYWR2RU9FdkcrZndYM1lKRDdCUy9r?=
 =?utf-8?B?bWg0UmRLV3dkdWxFWitKVnlsY20zaSttK1dGQUVSckpzR0x0RExqbktvS0Jq?=
 =?utf-8?B?VHU3dkJ2UEwvdFBPTEp2aVZUa2R5NEpQdGhORm5pY3R2QUxZUHRjMWlxZ2c5?=
 =?utf-8?B?am1SRy8wbHFSWUJHT3NNNjhyY0d0aWNzV25ycEtsS0ZwamZzek9tOTNLTHZQ?=
 =?utf-8?B?eHhOY3NTaEtPcWZYZzcrdHdKYzNqOUVrb3dUSld3MlZwQTNSeGNKcVppSzc5?=
 =?utf-8?B?Q2FaQ0FtcUdCZVlLRlY4bHBwRVdnTmkvWGdIbE9HVEJPd2RrdDM3ek5jSGZr?=
 =?utf-8?B?a2JJKy9sdStEMDFTRzVPN1EzYnV2Uzk4MmI4Wkg2cmJTdGdyN0RxV2ZUU3BV?=
 =?utf-8?B?VnNuWTJibnFsZm55QnpwbGYxbk5xWVVVV1llU2I1SGdBY0VTYlNhMDdjS29J?=
 =?utf-8?B?M1loVXlJRW10YWMyc0FzRWtoRU1wekRBV0N0UmhqTHRIU1NybW1DaXFtM280?=
 =?utf-8?B?anF4aFdOblhVNDllSW1TaGluRlJVZXFsL2tjVUVENkxBaUgySWdROXo5NE1i?=
 =?utf-8?B?NzI4VmQwR3hDOEFUU3RCczg4ZmVjOWtLbDY3SjE1cEtlbXg4VTlNWVROZWcv?=
 =?utf-8?B?VURwOGJXUkZDQTdETnV5Q1ZFUmVQN0hBZk1YTkNJUGhEem16MlZsMHkwbWJ0?=
 =?utf-8?B?My9YME9pUjJPTmlKa1UvMDdnVHQ2UjlBZWpwL1dTbXgxK1RjSFdBclBJN3h1?=
 =?utf-8?B?MnBidjlWRnJmcldjU25YcFFjVmtWNTQ5VWpoWDMyc0JYRG14WTZqa3p6TXR6?=
 =?utf-8?B?YlFXSWM4Z3JGYzF4WXZ6WGNmdlgyTEE5cDk0VFRtbGp3OGRiMm9xRTFSdTVG?=
 =?utf-8?B?Z0hOdUw3VzNWUGR6ZENLRWQ3RFBzRzZYM3JPWjVnNW1QU2psVWJTdEtoRUY4?=
 =?utf-8?Q?jnCzXL1TvtJMFcIF+7x7rU+p4Fg4lzmYnRol9Rl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9HYzlFa1AxRUZqMWlyRFhxdXdKWEU5Y0RIMnNYTFhEbkNoUlFESzQ0eFl1?=
 =?utf-8?B?WG1aZUhZMnFKQUVLUUZKYVpkSGhZNk5ENndaZ2JlN1V3REY4N1VHS3B5QmVl?=
 =?utf-8?B?S2htOFdrYkhuMUhRYmlSNUswWE14WEp2SVRkemw5b1hKdHFQTHQ5NkFxYkNh?=
 =?utf-8?B?RmQ1bTNIaHF3cFhXUzd0Z3hWUkgyQUloNnkwV3FzSVZ2eFZJTkZWL1ZwK3Zp?=
 =?utf-8?B?Y3dMQjRtQ1lGZ0Q4SEdyNHZNb0lhdVhsMHR3RytwNTViaVZHU3U4QlJva2FS?=
 =?utf-8?B?RVhLdkdPTmZVM1pyN3ZhU1pUMFRGS0loQVl3MTRmemp4bEpzc2NEQ1diQi9K?=
 =?utf-8?B?ajdVRWZZS2dac0VLc1lCaEo5RmdsOHE5RkVrSlAxc1FCQ2IzMVVPWWtJK3Zv?=
 =?utf-8?B?VUxYbXRFNUlBN3dEYm1oSGl4S1V1ZkN0Mkdjb3JCNUlORUgvVThzK0F3UUJx?=
 =?utf-8?B?a1p2eVloZWtTeXoySDVqeWtLU2dGdnhsanZZNDZsNkdkNDdpRFF3aFFuV2J2?=
 =?utf-8?B?WVJzODQvOEZwamdJckhOUERJVVhrZHhaZU5wb1FnbUh3TEZ5b0lJMVN2d0Ro?=
 =?utf-8?B?MEkzNVJOb0xOczNkTENwelloeVNGWUY4UXQxTjlOR1prZXJNR3JkbWRRMG9m?=
 =?utf-8?B?TzFGZHRYaVA2amZuN2NIallQb2RJcUR1bjNXbGoxdVdoa0tBN0hrT2RHa2NY?=
 =?utf-8?B?UUlHUm1FdHFzSDRVVFVnblE0aWVJUnhueFg3NFk1MDZ2cXlVTXFmbkJwMCsx?=
 =?utf-8?B?UmZ4ODVscmlHcys1Mm5jdWZDemRkYzFZVWpLMEF0WDZjSmhJQm5ZU0c2WC9O?=
 =?utf-8?B?WXZ6R3NFQ2lnQjhVVzFkQldXYmxmTWtOUUhWdE94NVYrUHRxQ0NVbjMvR3Bj?=
 =?utf-8?B?Tm1VTEdYb1BCakZiSDdPQjVHSGQrbGIyRFZMRkRwNU8xKzlqWDIyczVqcmo5?=
 =?utf-8?B?Qm9ZOXduWUlOWU80QVlWbHZ6NmhkVi9zMFNhUjdFN3hhWXdPZzRXdHBDNkxw?=
 =?utf-8?B?cXh4SVdISkcra09NWFJDenppd1g4MlZUSHZaeTI5OGY3aHE1QmlTSDVRT2U3?=
 =?utf-8?B?RzR3YVdGdnN2MnAyYlhXdk50TGZjaW1CMzd3eTh4eVpzQXJudklRZnZtS2hn?=
 =?utf-8?B?amxRSEVjaWNWRWFKeFlEcUFHM2kyMDFPYlV3ZFI2ZlVBTEkxTzdNUEtyUmdv?=
 =?utf-8?B?c0x6SDlwYk5rZHZ6MlgrdlRQTldsVEZZRVBrQXRSYnpCV2FWZm84SThKTWRY?=
 =?utf-8?B?OXBUKzYyckZubzlOQWIyRlo0L3RsWFdONmNWQ1RMRTExekUyRmY1ckI4bmZp?=
 =?utf-8?B?S1pzdnE5TU1HeVlHNUJ3a1gyeGxYRUt4TjVpWXk3S0dyNTV5NDhuUnRzZmRz?=
 =?utf-8?B?cTFERmdPZy9tR1lJSFZHWGpkVEFrNWNLWTJXSlNmaFdnMzRjV2xSTkN1d004?=
 =?utf-8?B?L210cHRZSjQzU2Z6RXBmelR6cHUweEdMSE1ub1dVMmF6Vjc5RExaZFpaOWdN?=
 =?utf-8?B?cW12UTB4UHpHUE1qK0V5RUkrTXZjQ3VlTUV5NTdqZTFacDNLQmVGa3JVelJR?=
 =?utf-8?B?Znd3Z2NnRm5vN1dVdXQzOUZHRWh2d3IvNzB5UkF4anZuYnVlZkc4R0kzTCtM?=
 =?utf-8?B?QVVPbVNIOUVVK1pYZEJFek9IMGZzZmE3THpMMGltZFFhVlRKV0dmNWZIRDcy?=
 =?utf-8?B?cFo2NmpjSkU1RzNlcnJjREh4WkZUc3ZKVUNEVXJ2QmFwZFp5bXNYQjFMdE15?=
 =?utf-8?B?R3N2TVdVYXpkb1NXMlZSZ0V6c1NPNktZNXg1WWJoOUdnU0NOYWs4SnIyMXlO?=
 =?utf-8?B?cDVIekx0NC9QWFN2cENxclhnVlEvOXBvby9ON1NMOXpONUxabjJub1VTUkpv?=
 =?utf-8?B?QkduRjZsM1E1bmsrcWtBcUN4cTB1Mm4rK3h5bjdkamdxb1NnZElKZnJCUXUr?=
 =?utf-8?B?SUJlUXZKMHQ0WWt5OGxmWUdrVVB5dTdvMHVkM2xQSldsMldPUHdVR3ArZzhC?=
 =?utf-8?B?UDRhZ0N5TVF4c01Pb1g5LytxejFkTkhxbERnYjQ3dUZSUnlXUnpuRmg3djZL?=
 =?utf-8?B?cmZhQlFHdUx6QmptNWpDOFZ1SWZDM0didjBSckRmNFQ2RklQb09JdXUwSjlD?=
 =?utf-8?Q?4IUMzO/ugDJ4Mp54wJPKHkCf1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8ae9da-1793-42b1-a562-08dc8495318a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 12:52:29.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJ3emOJWw2UNzlHRu53oSXpjB9X/iDusTmYLwc8h4672ubMizQvg+Uu2mAClPatv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261



On 5/3/24 17:34, Sean Anderson wrote:
> Add coresight debug support to the device tree. This can be useful when
> panicking, especially when a core is hung in EL3.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 16 +++++++++++
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 28 +++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index dd4569e7bd95..60d1b1acf9a0 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -70,6 +70,22 @@ &cpu0 {
>   	clocks = <&zynqmp_clk ACPU>;
>   };
>   
> +&cpu0_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
> +&cpu1_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
> +&cpu2_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
> +&cpu3_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
>   &fpd_dma_chan1 {
>   	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 25d20d803230..ec8d5d19ac1c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -330,6 +330,34 @@ pmu@9000 {
>   			};
>   		};
>   
> +		cpu0_debug: debug@fec10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfec10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +		};
> +
> +		cpu1_debug: debug@fed10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfed10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +		};
> +
> +		cpu2_debug: debug@fee10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfee10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +		};
> +
> +		cpu3_debug: debug@fef10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfef10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +		};
> +
>   		/* GDMA */
>   		fpd_dma_chan1: dma-controller@fd500000 {
>   			status = "disabled";

Applied.
M

