Return-Path: <linux-kernel+bounces-174500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056B8C0FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D661C20E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108914A4EB;
	Thu,  9 May 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="La7ZmpFn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9550A6C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257887; cv=fail; b=Qm41dHzUyr/pODM/co24LSFi1ssHtznNwMoO7qzo83ufGNBFap+bqyJVl5TPuh2Vcg3auOHV4tYxG1NnLlUyPgBL07BVc4UskfKtX9c1zKYPIbOUH5e98ZziidAsuyU1YccmQfGKTcVtClpQWOwWndpKQ87rs2HhydO8UnEwH3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257887; c=relaxed/simple;
	bh=VL33zFDqDoLebuZtL/sGsFVIsZLjNXpeiC2vKAI3WkQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHt20PM/IHKhVVoL+YhsTTqymv2urp+j4SqzzbKnd+B8dznKjLyhp28wyBsg2ug6iESlsdTSlBLbty/T/hhDyc9CpjPSipLYaEza/uflAgn131L+aAHIMJ87PL70yZwzEhNvkgPOGTjTeXhNuj9rwozra2km/Nuo5NcSMXB6qxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=La7ZmpFn; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZJ3hkE37S/0PdQCxvhBEtH411UHBNRUdC11/gOJmezzoi0qRGqkZ2+1y4oo1OathtPxQNJAUqnXrmMNzzWvxXKNIceuRUgruHr/S9yFX6rvvHT2bM8MHHSf0NQPCHQAZGdLF77SH06i0bDY3m1OptTTbs9SzK+uia4DBbTlCLx2fpfbp+obCpJTPReyjGxLDVuIWEhCF4fhaWOB/9tVjLv+q5YaoMgXq5XjA+EpYV1zy0oz9KCqDpQ9P+GDDko/zagGdYaBoorbYqBifRKIy0uXeXffFsDEh4lUFxPYuMxj0EMm2CH69VB1V1/W6dEuszEirZvLULrZoUZnGEXGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgBN2Q/PI/h6ZdTY7ov4vjEdl0Pt/s17s1Lirk9gun0=;
 b=ABf/1aVmSD6cQteHX/DrOC8PbFOAEg+0otkc6VgbOMg0Xr+a/4Z/sO+cxSkLIpD2PvFY7Z7fr95/KxyQyn6dZhoWpe29dSvSpAyMihYTX93cq40IFxOFyQ78jfUw58Qw/69s9+Hxtwtl3hSBcLyWXZJlCCEUJD6heYcONSlcJFd+X2R2hNW/oW9e78T9QOfQ46Ayv9keRIh72D36+XuXeeAeAysyKA/0/TVPbWScM03lUWdcAvuTR8RxkUuc9+6ti6sFNKkfxiEgrXZ96Jl+vZPKAu/HVvhEkE0Eo921Fzjr9E0MIq+2G4ytvHT794/t9C7k2OpKaKCqNsHVAPVzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgBN2Q/PI/h6ZdTY7ov4vjEdl0Pt/s17s1Lirk9gun0=;
 b=La7ZmpFnXq2l74GWxivvhyxyrJuOKTra/p9QCU9cUHg0GCeKN6fzfWffJTfm0fw+rOt95zmXcXzwpKTIvEQPDxRoSsSNyxyMiUMp3HS05rDD8rFWcRpY9mehZTeApuDYRkZNCwaN427nncmNOU+yalydSiDeroWzH5LC8KJDfEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 12:31:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 12:31:21 +0000
Message-ID: <85aaaf05-40c8-4b25-9d4e-1f9c09780d9e@amd.com>
Date: Thu, 9 May 2024 14:31:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM
 mode.
To: Kenneth Sloat <ksloat@designlinxhs.com>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
References: <SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
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
In-Reply-To: <SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 60392685-2b5b-4087-2bb1-08dc7023ee83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFdUMUpRUHFtaEZleFU2SWx1bVhiWE9SL3VXY2I5eXBzZWh5UGRHKzI5cEty?=
 =?utf-8?B?Qmp6eTcvdVRZUGF6TWVLb040REJVZDFRQjcxVGUvN1Z6cDFYR0gxNkVNUTZw?=
 =?utf-8?B?UlBHajI5TXRPRTZtOWl2RHgxQXU1c3JadCsxSGVRRnhodnF2dFV0dFpsQjgv?=
 =?utf-8?B?eTV1cDM4TmE4bVNoQ1F6ejQ5LzdEUjdLZGZZY29xNlVNUkc3dWR6SDFTS1Aw?=
 =?utf-8?B?VDBlcjlkL0pTM2Z3OFRyUnlWYjg3QmtKRVY5cUJsczUzckdKdkN2WnZ1UUJK?=
 =?utf-8?B?cDdHSmw4UTB5NlkyRWdETGtwUmdsc2xweC9BQ0NEWFJvanI3eVBEZzVuNlN6?=
 =?utf-8?B?enU4TEVJUUxSODRDRThjdCt1d0xJUU5SS3NSQkcwU0NZcFljaUxucGlxQkJ4?=
 =?utf-8?B?SjNJODVHWlIybW1jcktUMDRXdmVXclBhM05DaTBRQWlVY1hpTFllMHZxT1hU?=
 =?utf-8?B?L3Q5TTIvdDlTMmt3ZHdmWDE2bk1TSkt5VW96ckQ1czd5anQxTlZHd1FEaTJn?=
 =?utf-8?B?NjhoRUtjQ05rODZIUlduS0NTcVVaMythaG1IcTdxWjVlM0pnWlFhVHlwMmhv?=
 =?utf-8?B?Yk0xMXlzR09pV2VmRzJNWkpyVGNoZXRRSmduY0NuL3M2dGVnUGN0bmkwdDdv?=
 =?utf-8?B?RkgrNUFlK2tIVWovaFUwWDdrTWYrWUo4SXNMMkd0NGhzbHhCSVlMT3J5RjQ3?=
 =?utf-8?B?L1RueGgxQzgrZU9kUUhMVVpPSXM2ck53cEMrSGRIR1VCSkQ1UHJhMjlmOENt?=
 =?utf-8?B?ZjNCbVhKRnhocDZObHN5SnhTVnh2MXd4TWsxTlZuVXVPbW1PU3BDVy9HNU5s?=
 =?utf-8?B?dVd1dkJWV0lWKzh1Wkx5ZzFkWnBjT3RhSGZjdTEyZGxIaDNxUk9KRmlzTHBB?=
 =?utf-8?B?U0FKNlYwVUlsNlI5VkxDV00xcW42T245NUl0OVljU1BCbFgxUmVtUm04R0k5?=
 =?utf-8?B?TDk3a1c5ekJvMHNBRnMrZWVydWgzV1V3dC92ZE5hSzdWTkl6d3ZoRXkrUjAw?=
 =?utf-8?B?dTliVExKR3BQcEN1OXRjR0QySFUrc0NXNFRhY2NONUZ6QW1McG84NmNZMDFz?=
 =?utf-8?B?RTc1OTB5a2kyUTh2MFdvd3gzaTF4bmJua3QzWXJOZ2dwcHlzOEY5N21xWW14?=
 =?utf-8?B?S1pWMHlKRWpzbXd6WmpUa083VUQ1eEdyVHZucFBzeUpSeE5ZOW51aWxNL0pF?=
 =?utf-8?B?QXpwY2F2dUFvTzV4Y1lWNkJ0K3RmRmlHdzVhclNBZ0pqYWQ3akpuUlFqb1E1?=
 =?utf-8?B?c3F4cjBlZmZOdkY3UHJCc2ZGMjFNb011MGVVSGtTMUF1L0NCbDFoY3BRUUQw?=
 =?utf-8?B?aGNtaVg0K1pVZ2FHbk4zcjlTQ3NyamtlSk9reUxkNmc4OXd1eTgvZmdSQzlV?=
 =?utf-8?B?WDdUWHNvN1cwU0xYMTlzckxSSUREUkVWRTFkak5TOG1CUU1GcUxTcmVybm1s?=
 =?utf-8?B?Y0pwamxiQ2FPOEorYUVwMU4vUW0zTjRMTjlnT2gvSEl4NlBNTGtjcDRsc1Zk?=
 =?utf-8?B?eldLQ0dRTXVHWG8wbXJhZmRxZnNaamtNOHRxd3IvTWRDYU5mbndlVWFQanZ4?=
 =?utf-8?B?V1pKSDdJb2N0RWNGc3JmNm50L1JsNjhlRW9tR0FWV2JRUDcrcHExRWwvQ0Jz?=
 =?utf-8?B?WHNHRFl2NW53U3BNZFdtcXVyenl5RGxicGVqVWxESjI4WktVZHRHY1VKeURG?=
 =?utf-8?B?aWxwbUJ1QUZhNERUZFRFL0lqQTFxbUJkVGNNcHc5c2JES1ZXS3Jkamt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEVNRjlDa0NhRW9xSVlKaHoxbGpLUTc4NnlVRnV1YzVvN0ozY2ZhNUZlSDhR?=
 =?utf-8?B?bnBLREIybEpsUGh5dHU1M3RPTUxiR1ZnR2s2dUVLZkVGMktEQjhuNVphQ1FI?=
 =?utf-8?B?TXBwek1ISzdOSEVKakl6aVY3QjFCaTR4R1Q0TzRQaUhpNFFLbzZXeHRhWXRv?=
 =?utf-8?B?ODRWcHJuamltYTZrNkVPcFRTUHFycWtjUXpCd2t4dlkxNGxsQkQrcGtEbUxY?=
 =?utf-8?B?dlZ2ZFMrQVM5VFdVRmNHRmVXYnpHRFBlR2tiM0dUU3V5emVNT0FaY2t0dEtC?=
 =?utf-8?B?VFZRV0FjWlJna3lBMks2UzRRUlRHdjVuajZFVS9JeEYraFNERityRWlvNllk?=
 =?utf-8?B?ZkpLM1hIVW94N2U1TmFXOE9Na0h1TU90NVlsS1ZrejB4RmpoTitOc2NxS1BH?=
 =?utf-8?B?OEsxRW1jMlBWK1k4RENDcWxlQVZ6NlllSWFlN1MwOHhCQ0RYWVNqcjVQeXMv?=
 =?utf-8?B?S1ZqMUJUNlhjOUhKbDliR0drRUNKeXF2RXdVSlJRdHVnQksrakFyRGhoZUQ1?=
 =?utf-8?B?U1U1eGtyc2luRm5YZDMvUktrcFB3SE4zaWdybTBIZDdUSFdVRThMZlRia1lo?=
 =?utf-8?B?eUxGdVBQdkljTFNNamYxQ2U0eGVxd3JhWjdVU3lEbWsvT2pjQW5TcmlIaThU?=
 =?utf-8?B?cW0wUGFLRndHK3BzdUlnTkwySi9IUVZNZFUwQ1pBYytVTmNxZWZSalpGU1N3?=
 =?utf-8?B?eXFEOHcyVFRkclpmQmNGOHcya2VDTFNmRTlOQUdSUHVHT29rN1dXWkFaelB0?=
 =?utf-8?B?VzFkY3FkZXl4cFE0WkxMaTNsZVBLdlRURExxc0dxa05QTG9wQkJVUTE3VEtP?=
 =?utf-8?B?SkRpeFVUdEJhVldGTmxOTjdCb2pNaVlOWXRqRmdNUy9rcjRUQTdWWnlQa0Ra?=
 =?utf-8?B?NlRkT3BQSTM3cFBydTZaZm9mbE9JR3Q0NnoyL2todHp6WW5VOWRxY1A2a0hk?=
 =?utf-8?B?ZExqdm8vQlE4QlZFSnFMYUUwT2FocGxRVDBwU3FTS3JaK2p2WS9UcDlBTjBm?=
 =?utf-8?B?dzNTV04yMGx4Y2V5Qk5NRUhWVUgrVmlKZkZFU0dQaVpNSGV2MFhTYkU0b2cx?=
 =?utf-8?B?QUtiUU9sQi8rU0RQWDNSRUZpVndYUGp0ZHBEc1FwTVZ3VTE5QXN6TnV3OVRU?=
 =?utf-8?B?VUM5Tm1UMnlRY3lnWVUyUHhwalFFb3lwUE5SdXJIZ2lvdkJTcEVqMjl2NnVT?=
 =?utf-8?B?WUY5bjlMWkFSblpEMUJRVHN5VDdGS0tvNnBuRWxpb2xEa0J5MGNzY3lid3hL?=
 =?utf-8?B?VEVkZjFpOGZTbXMydERwYTV4M1BvK1UweTNKcnBrTTYwdW9acXJidTZXVS8v?=
 =?utf-8?B?V0pRdlZFNnNWb1RmUzF5bElobDJuYk8wT1gwN0llVjBoOHFHM05uZmIvOW5M?=
 =?utf-8?B?aTFyd0QySi9ibWN2WXA1M0o5dzdyOHNXNW83Nkd0cHA5YjRHcnNoelIwcXVC?=
 =?utf-8?B?QWRwN2gvdGZXbHhXRkpzSStXUmQ4VlhXYmNHOXZTRTNqWjhrYVhPOE9qL1dp?=
 =?utf-8?B?dlVTUmZTUHFYclZqbTNWd0RMb2tjS2h3RS84eXNtSzFxL1F1dWRBREdhd0VR?=
 =?utf-8?B?QzUvc0lDUWpiNnpGNHpSU2JQMUdFZlRXSE8wZW9BanEzMk5heFJYamJPb20z?=
 =?utf-8?B?eXhTWGNTWG0yTVVweVgrOENCWWdxaHA4ZmpzemFhQjFDR3pmRHZOc0ZEcFd2?=
 =?utf-8?B?NUNjcE1TMGRIeEZoOFY2eTZVd2hDWlBKczhYYThnMUVtYmRjOGxzMUR4aUV3?=
 =?utf-8?B?SmRydDFWTnB2VFFBUDZGbnR1ckg5SDZZQjVsWHhyNjdxZXcxWURZU0wvMlFi?=
 =?utf-8?B?T0o2Z1F0STVERDhQemNSRERpaStkazhJbktYdjMzRHQ4eVp2K25XNGJ0NW4y?=
 =?utf-8?B?K1VmWVM1bGFVS0ZKSTRDS3JZUkpPQWwrY2tBUGxudWw5M2FkdUhLUXpNeWQ3?=
 =?utf-8?B?Z2p3UndNZ2wvMjhoZ0JPWFFZSUFyZFNpUEdmNFdsUVoxbXdOT1pLNFBJUks5?=
 =?utf-8?B?TFV1NHBSSnVnL25yRHRrRWd1a09jYjB6TEhZWU96VHM5eDFpNGRaVnFJZWdK?=
 =?utf-8?B?QituNEdPcjZtODhvMjM4QnRDYVZzZWo1YThuRUd2aHNwSmxaRDJiN2tRYUow?=
 =?utf-8?Q?e/opFSBDuFhDc/J+Q/LxOsliA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60392685-2b5b-4087-2bb1-08dc7023ee83
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 12:31:20.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2gmNWoBeMac/EIZFdZoa1ho966pn80C/u7xXp5gt6bbR9pFCgp45dNu0vN+hIOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157



On 12/15/22 17:07, Kenneth Sloat wrote:
> From: Ken Sloat <ksloat@designlinxhs.com>
> 
> This timer HW supports 8, 16 and 32-bit timer widths. This
> driver currently uses a u32 to store the max possible value
> of the timer. However, statements perform addition of 2 in
> xilinx_pwm_apply() when calculating the period_cycles and
> duty_cycles values. Since priv->max is a u32, this will
> result in an overflow to 1 which will not only be incorrect
> but fail on range comparison. This results in making it
> impossible to set the PWM in this timer mode.
> 
> There are two obvious solutions to the current problem:
> 1. Cast each instance where overflow occurs to u64.
> 2. Change priv->max from a u32 to a u64.
> 
> Solution #1 requires more code modifications, and leaves
> opportunity to introduce similar overflows if other math
> statements are added in the future. These may also go
> undetected if running in non 32-bit timer modes.
> 
> Solution #2 is the much smaller and cleaner approach and
> thus the chosen method in this patch.
> 
> This was tested on a Zynq UltraScale+ with multiple
> instances of the PWM IP.
> 
> Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>
> ---
> Changes in v2:
> 	-Update commit comments to explain specifically where this
>   	problem occurs as well as compare solutions.
> 
> ---
>   include/clocksource/timer-xilinx.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
> index c0f56fe6d22a..d116f18de899 100644
> --- a/include/clocksource/timer-xilinx.h
> +++ b/include/clocksource/timer-xilinx.h
> @@ -41,7 +41,7 @@ struct regmap;
>   struct xilinx_timer_priv {
>   	struct regmap *map;
>   	struct clk *clk;
> -	u32 max;
> +	u64 max;
>   };
>   
>   /**

It looks like it was forgotten for quite a while.
Let me take it via my tree.

Applied.
Michal

