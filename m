Return-Path: <linux-kernel+bounces-199014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC28D8085
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F9B1C21767
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C883CD9;
	Mon,  3 Jun 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BgR0Vy73"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69A78C80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412692; cv=fail; b=ShbXqbEhMljzSkuQAcLw6RP0P8ojC/7/XbNDX2MujgFFqmPZNcCkRZgEwghntnyJCBhjGmV/WAs5gZnvh24gnj0BMWy0X/oqqhYPHStnPpuR6MTRbJtUh0tfbb7pJ8i7uR6DG+J2hYoCI1ldIufPjlv0Rx/ycSueo8Y3bXL2F38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412692; c=relaxed/simple;
	bh=WB6bw6vHSociDxdBpWMmwjNPb5lSZXaqzvGiiDQTqZI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MuJA5eLWKFqdesY3DWEa+V7NMzsnJ6fDiGEsaxaXwwYRU0zbabdw11YsbqgEhm1miu6TDGTIh6cSltFo6l+ghDcUbZVmd5DgQPEY41auFPOKqD2aYRj+3WCnuaGliD0IDRDwwlY3z4ptp8MNucLk+Evy+JYZq6ztB8/ytvpKDEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BgR0Vy73; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0SY312GSbXsrCNsHqBDea2iFMg3/vVeGs06LIuZPET0fTeIvbe06xNNw9bsmKZAenyL6K3hFOmYwE6zrVXv5/Tpa3JZiLy9qvMyUAHDxNq4hlLGMhiQ3/ZdRX7jbH71jS5RvMABenm6qljjF/we6XOotpSW+YVGQrMHDK4GNytUNct/TRLym07OwK8TjhwmNv8jWYnc3DVfeMxbeCyE1zOfCSI/3qd396DSKddKjNaDkRaPjw08vTLXWebIEak2ck6gxgFyXoaNTkXBUx8kfLEuTD+Zz+jDHlcAHTZ3AAKzk9b9sfH13ulW74M59/9SAtCdYaSb9ZuIo3/e48tMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZWypXdPCm1RXJBWmvsk02vByxi76xyl3PFdYzn6t3s=;
 b=Wq94a/i5IAjH1FNOwxKxWGsEx+tGNAaXIsZGI3F0KI9snD8W1R7DkJmdfAwVHzKAbsEUu9a1nIU0ffBKIUSnDppSSOgJ8Szz9fqeApTqEi2ppOAZ2WaJIjibsMH9wtaPoBMocMiu+2vLIcsgVm//nENYeCh1km6SGBWHOg5iiD8ik543tx40BA+nGrqHO33xlnWVAoaj2vaIJGQ8Ou0xuQN9dKsXiwYpMdGLv877R/vjwxqVdbeOe+E5YOg6C0faffF+CnybXggiEs+BP4j+0WLTaeWtV0BiQ48hjm1uihIfD/76GdKe9SIzWah6yUgmlZe2LxcggYqOqrhpZc/ucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZWypXdPCm1RXJBWmvsk02vByxi76xyl3PFdYzn6t3s=;
 b=BgR0Vy73zuLwK7CcWSCRHWQIzxQvjF+OrvkncQ2Z5Qwmy7EdA/LWsniVyZGc/9aKwytfYQpmSU7+YhkNtUUx1hSesLbRcSk0L3UKue4oX1pzSkygwNDDcxLmD/PW2/5CEDgPDP2Kl7Kh/TzMFD+j3TbDzSqb5n/a3YWs07IRxG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 11:04:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 11:04:47 +0000
Message-ID: <5a7d3d78-f152-466f-90de-e4a781577bb1@amd.com>
Date: Mon, 3 Jun 2024 13:04:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: Move FIRMWARE_VERSION_MASK to
 xlnx-zynqmp.h
To: Ronak Jain <ronak.jain@amd.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240425095913.919390-1-ronak.jain@amd.com>
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
In-Reply-To: <20240425095913.919390-1-ronak.jain@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:803:1::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: c019b4c5-5059-4d61-d5a8-08dc83bcfb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZExHUTA2SlJnZUtLUEpWWmZmdG9YeGtlbFMySmVFZzgxYllyVjYveFZyUzRo?=
 =?utf-8?B?eldGNDVZYXN0SzAzKzMyQndGOEVwQVc0cnB0Qll1OEdGckJGbVErTmZOanF5?=
 =?utf-8?B?MEdFTjUrSzRpUllmL3VQMCtLbDlpWTRoTnFzUzRlSnYwN21HUy94TzIrcyti?=
 =?utf-8?B?bFg1enE4T0lmS2hCdWljNUJnZG5hSm9YRXdDbWVlSFNBL2ZQUGNrK1hIVDU1?=
 =?utf-8?B?RmxJTXJidkhsMS9oUVVsY1NLUzlhUXRwSG1wTk5UTjE5QXZESTB1WEE3bm5m?=
 =?utf-8?B?ZWNoL0Ryc25jcCtGa0VFVWdxdFJDSTFFRnlRM2NsSVV5K3czbUxyYURCVWhV?=
 =?utf-8?B?TFZMWThVK0NHS21lOVFiSFRFZkN5VCtHQytXMkpnYnJaZDQwQkg3KytRcTdp?=
 =?utf-8?B?L3d3S1F5bEUwQm4wSHd2ZHR0VGNmaEhPTDhPYjdUcktsTjFxbGQzL0RuTjZF?=
 =?utf-8?B?czhDZlkySXY3U3EvQ3RDc1ZqVnZYWm55dUgyeTF6RWl1SlA3K0JKOGJVNUxU?=
 =?utf-8?B?V1pPMnJjeTJSeU5ya0dPcUN5aXEzNUNWZmNPZnk3RnVBMElTbG0xckFLdTVn?=
 =?utf-8?B?aG9XSld3SFdoajB5ZUE5YVYzcXMrOC9zOGRRS1IwODYyeGpRVk52MkdsRWxR?=
 =?utf-8?B?VHk3eGJ6M0VFQUEzakhlZHJIenljNENGenVLdHdjRDJ1M1VnV1lteDNPbzFl?=
 =?utf-8?B?eFA0RG5ZZ0ZrUGlwVUx0VVZEbHZHUm04aVkzaHRkd3FhcnNXR1FOTlY5aEhw?=
 =?utf-8?B?TWlWcU1BWTBsdjJPQWJDaFF0M3UweFNYS0hRK2xBakpIemc4YWdobktKZWFR?=
 =?utf-8?B?TS9CV2hBZmpaK1FYQmw3bG5XUFNnWmZvVDkvUXFDYXI3bEZaSmxkOTV5Y2g3?=
 =?utf-8?B?aWt0Vi8xOEJ5b2F1dy9QNG9Xek5oNEN6NW5hZGY4MysvWjJLbkV3N0d5Slll?=
 =?utf-8?B?SGh5MVl3ZFlhbGdxSGpyZ2ErMHJaYkZSUkROTUJqcEpudWVaekxLbE9CbEZ3?=
 =?utf-8?B?Y1ZFeVF5ZXIzMExoUGQ4bkFqT1NjSHpCTzJmWE9TbjNBdFUzQ3hyK0tmdDFw?=
 =?utf-8?B?VU9sYlB4bmRSOWpvN1h1YWgyQ0pJaUkwRzJjQ0svTEs4K20rdlFYbm9BUnB4?=
 =?utf-8?B?K0IxN3duaDFMUkE2WW52NG4rblpaVmxWTytqdlZ0OG84bFJlSkJLQXBTTGZm?=
 =?utf-8?B?SEE5b2FWVmJiZmxUdE1wcU9WU2JWbnI4NVJxb0tCc1dhYkxKVVN0NnRSS1NH?=
 =?utf-8?B?M29wK3BPR29BMVJnbDZTVUFRanhRVm1GZ3V3VHFjODg0SURvME0wbk9YSzhC?=
 =?utf-8?B?SkpabzBzUVFEd01STk1PRXdxWWJWelQvOEk3MzU0S1dFNUV4cGdaSUo4bGo0?=
 =?utf-8?B?b2VxcFl5NWNZWWxZQStFUkxuYVVSNHVYcE5YTUdTbmltOURkUGZVNFJ3RGRK?=
 =?utf-8?B?dTlLQStvR1pMUEZuNTd2Tk9RUFg3eEw4cFRHRVEyMWVTVkFxZ05WaUJDa0lH?=
 =?utf-8?B?Q1pDYmVuQzl5TWlsdUpkeU5NMGd5ZzdhY0M0b29seWpvRlFHL3ZNRm16UnNC?=
 =?utf-8?B?NGZScnN0YlVNaWdTOXJlRHlNZmF1ZjQzMGRzMHFHSUtzWnBXbzltdk9DakZO?=
 =?utf-8?B?V1Y5UTh5V3hlRURTNXV6M1FvV0VXRlpuenF5Qjkrb2dNUXVrcGxBZ0c3N3Zu?=
 =?utf-8?B?QnJMUHN0Mkd2NFg3anFLNENNSWtURSt1dU12RFdEUHkycnhJVlIvOEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlNUdGJCVUlWTXZjdDBXaHBjVnk2cTVqMkhSWk1wbms2QWN5Yk9SRXhBc3pD?=
 =?utf-8?B?R3Y0bFNjanlLWUdWU3o5eDdYR0lITTNjTDRRSDF0eTRSaE1TS3dSZDBza0tC?=
 =?utf-8?B?bGdTYUxzSTNnRjNGVlR5R3VwdjIzY2lQeEhkUSt6M1JWM3JZclhKT1U0OWsv?=
 =?utf-8?B?Y2dLMXdDbHEvSXZ5QlRRWHNOQUNBcC95VXlySlRLZFhVZXhGQ1B5K3laTEJJ?=
 =?utf-8?B?TkhEdE9rQzNwMFRMdmtRb1ZaazRTNEU3ckVWNnBpaVZrQ212c3FyM1JhdlV2?=
 =?utf-8?B?MExnWWRlN08rZUpVU2Rmak50ajhGeFQ1YlA1RXg2eEx2YW4zeUV5a0VnakJK?=
 =?utf-8?B?NlFqeU5xMmxjTEI5dnE3NFYwYUtrdXJBWktaNXYvcEFnaWswczNYNXdPZWt6?=
 =?utf-8?B?VmUzWGhWWExkYyszcVJ6MmJKTFlYOHFYREpkU2Y5NWIzRW84OXRqNFA1QmpN?=
 =?utf-8?B?bkFJODRQRHJJQUtKbzdGMGdGdUdUNG1TVXg0Z0ZKTFplWFMyaktFYnROajkw?=
 =?utf-8?B?TFhmai8ybjZ1YXhEUnI1RlNkK3BOSFZDQzlwU0dpSFFJVHlsYzVWM2dwZmtt?=
 =?utf-8?B?aGpVdFBxVUI2WnVwK2pvNmZiYUR6cjVFVUdCRkRuSEtka1F0em8zRjU4M29y?=
 =?utf-8?B?NThXSjNXenVnRTQvRTVjVmRvdTVBdFNLSVR5aXQwN2JCaDJ1T2prRzZoRGIv?=
 =?utf-8?B?VmlsU21TaWFwSVRFRktZOWpMeUtuaS83cnVaaThpTEdCTU81RDc3OHBPM1M5?=
 =?utf-8?B?aVV5aUw1WWtVRGVHTUp0WWlPb0Q5QlVHbFc5THF5b2VJQjkwL3RqQ05ZQ0g4?=
 =?utf-8?B?d1ZpYWMzSVZzU3JYeWxMdERqODhEankwM1dybXFjM3gzR1VXNHgwNFA3Z3dr?=
 =?utf-8?B?WkRqOTZSazBSajRORG5lM0U5VWpsY3dRdndJSjFucExaTGw3WFFvMldDQmE1?=
 =?utf-8?B?RllZQWxGdW5xbm55dW56UVZDMjhMZW9oaS9xeTBNbDFZSU5ndGJOamxUN2Jo?=
 =?utf-8?B?bVBTd1A5bUtVQUVadm1CTFdwRlpHczJwSjlBcFI3TlMySWlOajJlZFJ0V1Rn?=
 =?utf-8?B?V0dEaGNMSGVTNmlScU0zcWFBSmh5RXlLRDd5aFJWMHRLekY3VnFMR1NYOThP?=
 =?utf-8?B?R2VLWnIwUHB4TC96ekVtOXZ4ck1CMk4xSXNYZ1UxNGF6REE2a0RQWkhXNUQ5?=
 =?utf-8?B?SXdDcVVUTDBTakJjMllkMlMxRFo2L0N0T1l1OWF3V0g4T2h2VG9CNkFLUkJR?=
 =?utf-8?B?eTlMbVpOUVVENCswSCt4ZXR6R0NoelFPZ1Jtc0tDcGhrNXh0YjRaT1lmRmJy?=
 =?utf-8?B?Y3llVXFEVGtkRlA5Wi9lbmJaaDNsTkRTMlg5dmlyNzQweUhTUFY2aXY4Ukwz?=
 =?utf-8?B?NUxHTkV3YmYyUVF1MUh2SlQxNWtOcElsNUpxY1lmSjJmMEZvU2RGZklXMTFr?=
 =?utf-8?B?QmdDNUN3ZitSRTVCWTVkK010OEc0VUtDYnNnUmtocGZVWTBKZFRjWXVBZEJX?=
 =?utf-8?B?c1U1YVFxWVhTdUt0SlZzSEV5MmZTODM4elNVb3ZuUnZaU21adVlBMlA0MmhQ?=
 =?utf-8?B?ckhBWGQrWlRPcHVjVzh5aTk5Wm1JcnRUSnlTSXJCUWZ1TDl4QzhmdmRpZlIv?=
 =?utf-8?B?R2VxYk9tL1dXTFdIdG1waW85cDNGWW96N2s0WmUxa1RUV0FHTGhEcnpSOTBo?=
 =?utf-8?B?U0xnU2kwSmNINU5ZcDNQMVQzdEpEOWlTbjFvbVRET2pKZEgwK2xxU0NZc2x0?=
 =?utf-8?B?RVpQNUNLV1BweHo2NDFqdDZxYWJMNzh1QVFjZnkzVDBXR1RhbVdGalRtUkVR?=
 =?utf-8?B?Z2JQMUljTVcwZDlqcFRnT2s4ZDA1dWlmTHFPUGs1VjBOSndqME14WmdvcFBL?=
 =?utf-8?B?U2ppdzdMbzZZWWhWT1p3RGQrVWdqQkJiMVFMQnFnUkRpUUs2c3UreW54bGZJ?=
 =?utf-8?B?d3diczk4OVJLZHJOQTB3TjgxaWRPc1U1c1ZQL25vdjRpTjNpOXY2YjQ3QkN5?=
 =?utf-8?B?VElFVFNVa1ZiQVdNcGZlQlBvdHBmQ05wTEJ1ZGR6djd4V2NBczg0Tmcyd091?=
 =?utf-8?B?RTJqd012cnRGWElFVTI4bmpxU3hMR09qdDE0ekZTalVkMERlWWlkRkljM0s3?=
 =?utf-8?Q?usfiQwPrzMMdZI9rx/tZtHSSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c019b4c5-5059-4d61-d5a8-08dc83bcfb09
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:04:47.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Rrz9cYuT3VU4pn3ZW8BqLK0O7Mai6RP/bEsEZvxPKGkA2Yd29BgNvs/8k9pNx9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231



On 4/25/24 11:59, Ronak Jain wrote:
> Move FIRMWARE_VERSION_MASK macro to xlnx-zynqmp.h so that other
> drivers can use it for verifying the supported firmware version.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c        | 3 ---
>   drivers/soc/xilinx/xlnx_event_manager.c | 1 -
>   include/linux/firmware/xlnx-zynqmp.h    | 3 +++
>   3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 9bc45357e1a8..add8acf66a9c 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -41,9 +41,6 @@
>   /* IOCTL/QUERY feature payload size */
>   #define FEATURE_PAYLOAD_SIZE		2
>   
> -/* Firmware feature check version mask */
> -#define FIRMWARE_VERSION_MASK		GENMASK(15, 0)
> -
>   static bool feature_check_enabled;
>   static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>   static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 253299e4214d..9d89b5a40f97 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -35,7 +35,6 @@ static int event_manager_availability = -EACCES;
>   
>   #define MAX_BITS	(32U) /* Number of bits available for error mask */
>   
> -#define FIRMWARE_VERSION_MASK			(0xFFFFU)
>   #define REGISTER_NOTIFIER_FIRMWARE_VERSION	(2U)
>   
>   static DEFINE_HASHTABLE(reg_driver_map, REGISTERED_DRIVER_MAX_ORDER);
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 1a069a56c961..d7d07afc0532 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -52,6 +52,9 @@
>   #define API_ID_MASK		GENMASK(7, 0)
>   #define MODULE_ID_MASK		GENMASK(11, 8)
>   
> +/* Firmware feature check version mask */
> +#define FIRMWARE_VERSION_MASK		0xFFFFU
> +
>   /* ATF only commands */
>   #define TF_A_PM_REGISTER_SGI		0xa04
>   #define PM_GET_TRUSTZONE_VERSION	0xa03

Applied.
M

