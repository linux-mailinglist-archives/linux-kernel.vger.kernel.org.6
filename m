Return-Path: <linux-kernel+bounces-517841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0213A38679
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730721686C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F240221575;
	Mon, 17 Feb 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GzKsnx23"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8C21661B;
	Mon, 17 Feb 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802624; cv=fail; b=McuSF4TeH5sHPeF5HlByF+y7q0oQPVzrJXagO0HYALUVQcRy64Qm/Z2ARmmu0KDIJQecq/6TvNsPhPIKqD4SLEhFQfc+BaPa9wBOF23CRx9rZClI0TpQ53KWFcaJaiRlAm8erfi6RYnSYD8Zla3/qIUqK2yeYPj5oRBpMNOBCKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802624; c=relaxed/simple;
	bh=OnPpLuRDxQUeb9XdmZoK05H4x90JnMJlChJJDJdhryM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YtMgGFz9FO3mUc8Jm68nfjs5z6UgWz/MWVfc6wnQVKlGwTNQKGR6ZoCMvCSUVaCrfI24jvvwnDRyzQ9n/QFfeviQ/uALxu9rC0aHQpYlF1O2a5NiaUor/hdX2FrqZUx+SpwWZh+WvaXQy3zMfSRh6rcwvdi/K+UePKs91LsuOVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GzKsnx23; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTmmUvL1rV/JhjfuCyJMFxD/LO1bMfmS+U1XweLnvkw4Vfq4SUGB3mGEBRMmeljIIN6rxe6FYKvxivjMvJX+UDPt+aE89NR0J+UIFYTV5FTqfCk9/FT+XKK6ImtN4qBZzSLFEPEgR6+lGl3/dBDCsrf6VJX+weQqaOjWAYx8RVPlbQZTH8Lrxaj94g2OUeK61y2wxrM9cBzDh1NFRqn3+G6RyFxNcqk4PM4msrhwfiyktgST+POeQQRoTfaufV7C0DnuMszqvJDX7eSu4cDcSNePWt7IBtK76ytNk5aAYTPlTOYmX/itj7FELqtxDmzBU93VgHL38cqfbMvdI1+lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5eEY0CwFCO2uHoY8OikoUUvhu7pT9nPplB0Eb+NLro=;
 b=aUhgH1owQBJYHngV3W5vqsjquTUpmgDlVP6OqpCfoBeYVL+T+95UvVvfUeJiOsHXFGkZG1Vh1P26OPenAzx55UxTdVjyF3aJ04h4aOur3ypXdE2Cl7/rnvjnPy9vF+bd0R4zzJluPbWACiO6QTWYEtLcssRL+ZCfDLF5mHlIVhGXb2PS1sa72Tssa7IUAXWkV4IEA80ouwozA2W57IIk9VeCbfminF5GiVqRsxsYlPDt2uQKUcCyWdFRFV3+Eq5a7ockNao41gPIqJHY7RtV2Sq76dw0Fd3AQvPalwPSTVhPUZkRns3zMKjGyyRNpVhZQE9BUqJTsir/COwf3VnHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5eEY0CwFCO2uHoY8OikoUUvhu7pT9nPplB0Eb+NLro=;
 b=GzKsnx23PYf0XraT5HDGijzGXQMORRv6XWIA5VArLWp7LVNnOg/Qomz64u9TpleJ5i5todqNDW9eWeJpTExBuJeNbCHKrYlNgCnHXwnOKGxJvFgVRGBgh2nxJ4j3Ba9/XYjF1PZNNOJI1v3fUuPojRGlzAGaHnrzI4TfJ8xUAqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 14:30:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 14:30:19 +0000
Message-ID: <f098b7b8-29a1-40f4-b348-39bc6d0411ef@amd.com>
Date: Mon, 17 Feb 2025 15:30:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm64: versal-net: Add description for VN-X board
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1738657826.git.michal.simek@amd.com>
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
In-Reply-To: <cover.1738657826.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: f92a93fd-897a-43a4-d851-08dd4f5f9af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2Q0MGZ0UGNKUkRJMXE0ajhoWkxLMjJkQ3d3RW5teFVnVTRKaEFzT0NSc0tU?=
 =?utf-8?B?bm1HOWJlNVZZeHdxUitGUXo4K05XUE1aL0xISk5YN0VoRVEvL29GTDFLSXMy?=
 =?utf-8?B?WFh1Y3NSekZmQVM4TGhIZHhtNE9xbU1hMmVoMVZPU3d5WkdiWWd1QzlCU0s2?=
 =?utf-8?B?aURtck0ySngvMllZc2FFNDZYSm91d1paNmZYNitmbzQwcU9oZ3hFS2YrajdI?=
 =?utf-8?B?RCtwa2kzd2ZPbzB4NDhTK3EvRzBOMXhpM0tnNlBYdW5rSG81bHpZT2Q3MnBL?=
 =?utf-8?B?bkZ0RUJFV09PN3dveUJDL2crYlpGYVZhajA2aTBhNTZhTlZHVHNxNzR6U1hH?=
 =?utf-8?B?b2k3SkVQVDZSNFR4WGVVT1NhNkRCMkxMdjM5VXJndTVEV1E0QnZkNVVlREpm?=
 =?utf-8?B?QnRKVkIvUXZ0Y3hwWjNaOHo3RXBLZ3pid3BFNWFaMWpFd2hLQUZaNG5xWldk?=
 =?utf-8?B?NWlSb3FnR0NlYmlBQS9YanhvTzF1OGVQMVp4dkYrWkFFRU4xWDZTc05xdjJU?=
 =?utf-8?B?QVMySzl6YVJjN3ExL1FsVHJhVnVUVGRXd242WFpUbXVISGZkL0JMd0hyZitt?=
 =?utf-8?B?L1EvMExSTWdPN2ZVRkFTKzRHODNZZDkvUHQwdzFXNzlBZGtsdU5HR21PUm1C?=
 =?utf-8?B?SEY1ODE4QUtiei9HcVkzbGN5QlFTS1I2MDZ4Tk5vL2ZJaTVUN3Iwamt2eXZ3?=
 =?utf-8?B?bHlibDdBQmFYYThCRmlyanFLNFlsTVNIa3BUWUVXTk1xS09sL0sxVnJqZDJa?=
 =?utf-8?B?TSt1SGNkNjhWblVOb0lySUJTQzVEZWJiZXdna3pJUElBdFFoUStRNW05NU9u?=
 =?utf-8?B?ZElaMjA0V21ERmZkb3pyY1lDQmU1RFZ5TndRYjRCR2ZGb0N0aDN4ZHhsY2pX?=
 =?utf-8?B?L1FiM0Z5RWJqcjBDSE9GMU4zL2ZpZlFJbEFRWUd4K0x3Nk80V0xKUVBzM2J4?=
 =?utf-8?B?c0dpZ25wdi9WTFBBUFVOY0dNNUZHY0Jqd1hYUE9uWUw1Q2xJVWFpbk5YWWIy?=
 =?utf-8?B?VnBPK3JtYjJzUHJxdjlVbmIza1Z6enVKdXVNYkpKQ0JGRDhmSTdkR1hvaFBD?=
 =?utf-8?B?OE5QYXU4QkpyT0NLV29UcmZGZ1BMa3pZY2ZjYms1UGRzUGVHeG1SMnRsU2pt?=
 =?utf-8?B?RzRvcjNBejRHb1h2ZzVmdGJhVkFlaVJ0aWoxNy9lS0U5UjkwdUtYQTR0NkdG?=
 =?utf-8?B?N0phV2JtNXpib2puclRZOTM2UW9rQmZTcEJOclIyeTB1M250ZTJMS3JUMXlO?=
 =?utf-8?B?Z0tVMndZVStLNjNvaTFpQ0FWeEh6MGw4V0lLdjFZVWM4dlA5SHNYcXRjWWRt?=
 =?utf-8?B?SEgxOE9ZYUZLSXQxMit5cGRqNmFQY3Fua0tCZjdpc24vaFRLdFFrRHZ3M1VO?=
 =?utf-8?B?eHRDQmhFSFFjbnlETDJoR3o2RlRibzB2TkZOZktDMG5PdUZKOUliRzlsZ0lO?=
 =?utf-8?B?QTVHL3ZiL1hwTFpWV0NRd2pVQUtqOGNDcWdOMWYxdkJheVVDNzBMQmt1elEz?=
 =?utf-8?B?eDNldTIxR3N4Qmg1Q2VpU25VaEhKRlY3eWF2ZGZDNlJUV08rUThTN3dpeGc1?=
 =?utf-8?B?U012QXN0ZHAvcXZzbHpWVzZkOGh2SE1uaUt1RGJiN0UraWhWNEM3bzlkR2pO?=
 =?utf-8?B?Mm1KM0liSjd1c2taUHBHZTRzY25zZUY0ek9Id0d5TjZGUThUNTJobkhSZmQ1?=
 =?utf-8?B?dGtRdTFZOTdwOWJrRExhYUtCNHg5YTR1cjdYVE15WnRqdHVTWkNmbExFbERa?=
 =?utf-8?B?c3NoNkx5QU1oQ2R5NElPTkhFbWYyQWlzR1lyd0RKdWw5MGc5YXpLakt0WW5H?=
 =?utf-8?B?QUwrR1JQcjNNRWd1bm9nMDZFbzV4L1B5eDRFdmU3RjcrMU9CSHJKS2pZUUJ1?=
 =?utf-8?Q?j3SMXwqYm8jX2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDMzc0U2ekxPRmRVMnNJVFowcWIwWjZ3RWhjaUl0TjcvS0xWRytOSnRrZTQv?=
 =?utf-8?B?YkNsZ0p0aGtlNHYrM3NDN2JHd01LS2lXQzBoWHRXMWdrSzFaZG1oRE9raFIw?=
 =?utf-8?B?YXN4VC9aZUpmZ21oWENuRVl3ckt5UGx2QWkzVDlCNmtaa3dLa1ZTUkpDdFh6?=
 =?utf-8?B?cnU3cnpqekx2WDc3cEJWVjQ1ZHNTbjF0KzJnNUMrZ3I5TjBnUXo2UGozS01w?=
 =?utf-8?B?V2RFR2Ewclg1QVFrSHM4WFMyMDhNdDBLbFQyWWsyUWdqOWZMaXhtajJMTGtW?=
 =?utf-8?B?WTU1d3ZBSUNnWTlYUWl0NHczWW5JNzJqRlNlbWpKZys0MzZsUmpYbENkZ2Fi?=
 =?utf-8?B?Z24yU3VpcWw0NjY3UE0wMmczOS8xcncyVWEzYXhGaFZsSy90akM0dEoySGM4?=
 =?utf-8?B?Q2V5eHl2c3Jub3dFUGk0eGdEb3lvcWJocXpwejQ5aW1HNU1HVzQzYmp5Qjda?=
 =?utf-8?B?aHlXajdZdnltS3pFVUFiVE41OWN2SHliOWlJVHZ2dVpGTXlVMTRNMzFDVURU?=
 =?utf-8?B?a0lXekRVM3FvNzcrcVpTcVNzNG1oTzUrU09rQmZRc1NFY3RxRDN2TSsrSTVr?=
 =?utf-8?B?WnNQbWNiUmxXUlQ4OXlEWEdOZUk0bkVxdUlEem5Jc29xeG40REpZdHBjT2Y5?=
 =?utf-8?B?NDdxVjlmaGduZktWMllZd0FFMUc5T1dwdFpGWFVSNm1PYVpRY3ZNMnhvZmRh?=
 =?utf-8?B?VGJVaEhOMGY4cE85ZkdkWjFjbkZzbFV5d0FtYmdPODMydGtDWkN0L2dEQTJ6?=
 =?utf-8?B?azZSb3pQcEFRM2cyaEpvbW12WE1hRTdnUm85Zm5XSlUrUTYwSmwvWk1qalRW?=
 =?utf-8?B?MjFEQURJTTJpRFlreE5vYUVZQTNRaW5oTmtlS2FSSDhlbnpEa2tGbGl2VDdo?=
 =?utf-8?B?TmgzMkR5dTNQNmZhUnNIci9FTjF0Q1JrQWVmS0FJZ1Z0SER3UmdIbXBMc0Z5?=
 =?utf-8?B?ekFDTEx6SDZ4QVRWSFljUGJzSjhkUXZXYnhRWGlwaGFCckU3aW1vZzlEVTNG?=
 =?utf-8?B?SitHZzRSNFFxY1lzc0taNjkxNGg2Wm0yOWdiVjJpSWNTUEtpRGxrb0p6UENY?=
 =?utf-8?B?aitjRGdnNk1ibWJERWl0eDdXYTZncFFOWkpVcG1nVlpLOFZtWjBrQ2cvOXEz?=
 =?utf-8?B?TlJrVDZpTEduWkJhbm5TSldsaXFuSGk5ampyN2IzRmFkSitkUitjbG9GS1hw?=
 =?utf-8?B?Qjg4Y1d6ZGkySDJRWUE2QkdQbjg4bXl4UkFSNnF0eG8zaDUrdmI3L0NNUjMy?=
 =?utf-8?B?QVRnR0dSMW8yYy8vOXNWQzVsQnUyYk9NeU5qdWNvMHVOSkU0b2RnYjIvamxV?=
 =?utf-8?B?dTNSV1ppSWE3Wm9nNU5RKzU2R3gwaS9PTHJ0a01CSURkd0p6amtyc3JzcjNP?=
 =?utf-8?B?a0tiamNPU1BQNzJ5RXB2eTNiSDU0cmgvdEIyMFAycTl4VkkrNkRVZ1UzNGtK?=
 =?utf-8?B?VGFhQmp1OUpMNDI5cFNVVmxpNExXai9PQ0FjM1YrTmg5T3pocWZiaEY0TVh4?=
 =?utf-8?B?Z0hpak1wUzFPNHB5dG03SHQvMC92RGpNQUpFVzQ5K1ZPQXgvU001L2l0MTFP?=
 =?utf-8?B?NHI2K2N4OFErTWYrR3FwTkcxejVKNkNpZTdLdE5vS1BJcEtJNlczYVFzWVQx?=
 =?utf-8?B?N0ovdzNDcjVYdGJUdVU2bDVFM1lJN3VDcHg2TFkwQTF0VzVMSTd6dzJVQy82?=
 =?utf-8?B?bjdhODhNOWRLQVBPWHpQbWFiR1dkaU5ydWtQZ1JrK3lDNWRIcFZoVVo0TGo0?=
 =?utf-8?B?YkpoOTVNS0d0QUhnRlExQVpGSUVSUGg2OUhWaEhrL1ZhbjlFSDROM3kwTkQz?=
 =?utf-8?B?aEpDeWNXcGdXRDk4akxXUFJnRE8xL1dnMXByZFlUR1lnNkE3bzcrRjhWcHRh?=
 =?utf-8?B?ekx4R3BYK0NHMFpTTURNTDVLajF2V1I1djBlT1F2L2pibDF6dm5veWlMbjU3?=
 =?utf-8?B?ZThVRk9xL1dPVHp1b2xqazErbWhldkJvWVQvZ1FmTktlaG5tcnQ0ZnNua0dZ?=
 =?utf-8?B?RmxERkhQQlBCaTY1THVPNmhVKzNFd0krYTlCR1VrRGRkSXpyWUlSNE0ydTVO?=
 =?utf-8?B?ZmtXSk5xaG52SlZsTWhXTGhXbXJiV0RmK1BZOHpKMU5EQXgxa2RpWjc5ZTBD?=
 =?utf-8?Q?b6zv0JtGg7TCEgBypok/HpqY3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92a93fd-897a-43a4-d851-08dd4f5f9af8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:30:19.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iB9GoC0eXTBQGY8A3ZzZOP+bN34jpkqAXai13LyhAJYOeDWALLeTIDBD4/9QKay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090



On 2/4/25 09:30, Michal Simek wrote:
> Hi,
> 
> add description for VN-X board with Versal NET SoC to see how that SoC look
> like. DT binding patch was sent already as v1 but make more sense to send
> it together also with board description to see full description.
> 
> v1 of DT binding patch is at
> https://lore.kernel.org/all/20250108113338.20289-1-shubhrajyoti.datta@amd.com/
> 
> That's why this series is sent as v2.
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - Remove | from description
> - Change description
> - Update subject to match VN-X
> - Add description for VN-X
> - New patch in series
> 
> Michal Simek (1):
>    arm64: versal-net: Add description for b2197-00 revA board
> 
> Shubhrajyoti Datta (1):
>    dt-bindings: soc: Add new VN-X board description based on Versal NET
> 
>   .../bindings/soc/xilinx/xilinx.yaml           |  11 +-
>   arch/arm64/boot/dts/xilinx/Makefile           |   2 +
>   .../arm64/boot/dts/xilinx/versal-net-clk.dtsi | 231 ++++++
>   .../xilinx/versal-net-vn-x-b2197-01-revA.dts  | 116 +++
>   arch/arm64/boot/dts/xilinx/versal-net.dtsi    | 752 ++++++++++++++++++
>   5 files changed, 1110 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-clk.dtsi
>   create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-vn-x-b2197-01-revA.dts
>   create mode 100644 arch/arm64/boot/dts/xilinx/versal-net.dtsi
> 

Applied.
M

