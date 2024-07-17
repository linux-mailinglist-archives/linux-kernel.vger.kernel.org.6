Return-Path: <linux-kernel+bounces-255477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433FF934134
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655041C20E47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF631182A4E;
	Wed, 17 Jul 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uon2/vGY"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2179.outbound.protection.outlook.com [40.92.63.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4777470;
	Wed, 17 Jul 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236254; cv=fail; b=jE9y4R2k3DtXt6dA2QVA/q45xVt/cqI3Q9P2a7Cz64MpzvR5HhWliMNEdhJ547mJv1Bv/6zdqSpHfQ8Gs9YpfXGD3KEvcIikLchygL3Tj8zqg+KLbO45AppYkY9ONO81KpuqagC1gqByKgB8phfGQdMQnGUUuDIvZH3D7EGw0/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236254; c=relaxed/simple;
	bh=z59tWiqnIeoIDUnd0UoczuRkQhxpbchrFm/d/50vxCA=;
	h=Date:From:Subject:To:Cc:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ab2F3E/se774wx7CIwBHZffbbduiYmhuEx4lSn1IJriHbduKy9J3qSdUDS7sUENnkK0LGzMkZY78qQj+xtjKx5PKFjqXvCcMVx9OSke2bMX1mlIFEIBa2VZCerMVhfYZXP1FkYrNjWXThq3EJJy/9D4vfM4M8CvbKGfSxfCizak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uon2/vGY; arc=fail smtp.client-ip=40.92.63.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k63jjfpOI6+jB/3hNhvOrBMnUiePgrEs/fpFHHjQjWGxA/44geYYVQIqaaFhsBGXlOT2l7+ZLy+yk1AvKRCFxG8q/3u9+Zuk8RT4Wsbz4TNGunvm3FMjmXIIoPNJKm3ZDNiHDgnISEEyNHOuP76VK6jKAlNdCuJyQdfs6qnG03YDNtoxt4P9tvl4AeLQsaboxv6UKcmqj6l6hBJimVfIePoFDR5y1hlKp35YAbCaKqlC3pey91w01Ga2++7WYKUM0Rqkl6CgCG1cQVsVLrqCEyAKnXTTq6t+2uqW5BBtgxbaHVct8LxUcOft7TTc8olqkVbfhPtXwnazbqWErR20uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/HWEZfO6RmlnRuk12Wl5KmCmvGABw+UmQ1J0cG0F24=;
 b=gagmJKG9Vxk+zSHRzobHId99p6b8hppy4L2DD5Zt8FddRYWsTnIRZDRLm9hatRDgQKZhKDFmrkuPbnQnbwEwnYjEd0gesiP4/lMnC4QpIOf0ibWsmSIv/8XK3poQ+srKST0Vobnx1OQw6iNWuuVQ7iWBY4r4eAnBvGSRvl/1O60JY6Sn6jl/mN0G7IjrlHbry/DCYIaGr66c22qFqCS9/X70JZMB+zW80GaB2RYkT8wgIQBqLgVmhsemFgi/clUK1+NQahADkSSXGnpacVPB/y72FsN2tXaHMe/NeZUFSqqxrC8Zcea2deXS+AoZhzAulznmiNF10qdBeoF+PNIuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/HWEZfO6RmlnRuk12Wl5KmCmvGABw+UmQ1J0cG0F24=;
 b=uon2/vGYIc6L4hhVeQfSsRttcOR7A1CEqK8Wdw4Yl1n13I+vLwyQyr7OlinjvAmvYwQ0zydvXymXhkJQQa9CxVdnluf6QLrKOl96m4skG/55bQlB5MdG+axW5o1URXsoP9zMWnpCUGLZIUGw4NU9p9IYeKZK0MG2kQQXEYzPXdWGoGd36YmuBSVS63iuBewHS2HuoGEdvLUxl5dByVA4DrYO9jDsfjCyUG2W6x+3vqL64f6h0CxVbTpn48Z16xn/l2JcynaCwfut2T1Irf3Z7TRl2jNKrbPDu6BROb5Vs/DAbtulgU5korfV6POd/EQonJ9EZXeJ3m+gCnLBH/O/BA==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY7P282MB3740.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Wed, 17 Jul 2024 17:10:47 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:10:47 +0000
Date: Thu, 18 Jul 2024 01:07:33 +0800
From: Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH v2 0/3] riscv: sophgo: add mailbox support for cv18x SoCs
To: Chen Wang <unicorn_wang@outlook.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, inochiama@outlook.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID:
 <SYBP282MB2238886048E92FCF38FB940AC4A32@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB282276F453744C2ACC2FF627FEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.CO
	M>
References:
 <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
	<MA0P287MB282276F453744C2ACC2FF627FEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-Mailer: geary/0.12.4
Content-Type: text/plain; charset=us-ascii; format=flowed
X-TMN: [ACFLk+RJeoHJGvQtw/FrkMoBaa+tlRKvswto4q3nbjc=]
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <1721236053.4845.2@smtp-mail.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SY7P282MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd1c849-49a3-4303-40d1-08dca6836684
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	vCgh8Y3pDHdfHZtAyAKKJf9L8k61/DmyYy/YQJhDev7V7jiIWUW3EddMo485RGoReNvOkfUaibJIQaE7Rz2rEkWYrHB7eGBtMXwzEpyQ+Rny+6gFm8L7cOTMgGijLQFdcQU2k2XHS3bwY8gxL1891v9A9qzVLjDEB7L0G+/Dp6O5c9mnW4U32XHn3FPuBWRsze8TzxNL0+QKgtzHlX1Dz12+2aOyIJ5PuMRlp/gogfL6ja25rme4uG2HNwDlla4j+t5ua9shVRVW42HMzr2UUYFp6HFCVdylUuO4aycpU+DHggII5ldxxKzJvU+YbMsyfpPhoSyfF/GpSKdqDJHyCVpaGAUvxfUt/qxzq/G/DSyLqjTbNNhdiW5sU9uOMfmniSGBAeL9DFIFK4Z8EqI7H0Umuy8SoloytHiDYJxCh+vOFLvYVX10xlVIHJYvFxXW5ucQflfYcuzfsXiAFULuD7r9a8ZJijxgpj+0A/YrEhHv6BDg/Mzo56KDfCiXI42oec7/ZD0AaKoq0ZZtBxZyC2wtFTbC9JPgLC4PLW/bGoEqcRpkbWnnLYzw/EaqXma3LIpAj0TJaam9I4Gd8AVBbqRJVqe5QfKukKyB92ZCKAsWwDksOqak+ayAioo/RjcKu5otH8Cldu4tnWnqUOVVmw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xJvn4U6RLusA8m5apuhgFP7CG0n7ZuaBIAQlGCLAlvK+wliy6JnZ/hpuza8?=
 =?us-ascii?Q?5FiofUdNfajYdql2Zjyf5kqCSyQmWfAaRDlluZxnYy2NVmSxz+NJW+7gmQLc?=
 =?us-ascii?Q?MKsooGkiHk8WKwcv19N/+v/1lMX3fGHxTcINb7eJNsdlHdlsmEoa10CNcBD3?=
 =?us-ascii?Q?t8eWwuBLhuKSeRyIu8tBveCCJmkTCEoTMei8pB5t5Ii3WuA1rh+ygL+WZcyY?=
 =?us-ascii?Q?BQR7jHNgxkfX8QQfFPNEpfh7vF0wC7zgpFkGvJOp7aBB/+dkODxW8HEnHpe5?=
 =?us-ascii?Q?4T/NAUwHF2xNoSUN3Zjiwo2xgpX4R+dekg5YcFb/XyMz8poYd3ZjP9MQDp6w?=
 =?us-ascii?Q?Zpa88MzYDRVQiif9OXVi2RgE+lh4RbJwwVhgfXC3J/xy7BR747C5hpUC91Iw?=
 =?us-ascii?Q?3wlF4MF+PRcAMxBzt6wbPE4FlL21izUzpK9jlRxPL5jz/bs5wOcS24gjW55X?=
 =?us-ascii?Q?aq1rg6TvgJcr2BS+nT8xUr0HLI9ZuDl0/u9eBPPmINru2BljmXCxQ2NCNCkV?=
 =?us-ascii?Q?QHLR7+HP6UIKiTGUDFjL4oqixJs/spD+4pyu6Ch0OW0xDblfWUwE5Q6+kU9q?=
 =?us-ascii?Q?5EUNpHzw3ufdkbfe2T73lDeR+/py9/1y7kbg9fYU6Rj4q1ntcAgy3xldynPm?=
 =?us-ascii?Q?Q5JonFFb/YaLEo3gFju8gKcBiXtfW4cG/QVLtG100wj8Q+0jlth0mX8i1M3f?=
 =?us-ascii?Q?a3UDEGvV+q1qt4dG9lxPX+SSrYLvlIIvtBrAUCaKnAsvl4WBOvoNPMXhTyKG?=
 =?us-ascii?Q?FMP8JywJ2o/wkYV/AdnCpbr0lgy9vgaQt5qOrnTNJf8YiFJQZpTE1W4KXlX5?=
 =?us-ascii?Q?FyldVDvjLY5cdy08bSdruWLfPwG4PKmXZy6m+vjWYGlIZNc+7ZHdo1MviwR1?=
 =?us-ascii?Q?Bq0OedFeughEUdRaODfX3QVJviYsrnyKkaTBPXyNiIbEGxrS7yM3W4Kajdi1?=
 =?us-ascii?Q?YPkqQQnqqCdpBLVggkosmAPi9rt74TBpKYpYR9jeHwjDMavfueFyt3mL828b?=
 =?us-ascii?Q?nrhkEzNzNxrFu7pcKbo4XRAXT3A/eT64cJTH/cIvRSoL/lFNO2iVjOQAm4O9?=
 =?us-ascii?Q?aRVpxwwCEnt2pyEDCCWOAzy8y4bwpWn2ES3RceAjAMUASPRGjNFHoPgsX/D4?=
 =?us-ascii?Q?PGdN7pICCJErVXH8IkAxOEvjEf0QBsXVHDfaXUZoRdE60Ti9ViKWZzzvy0vj?=
 =?us-ascii?Q?AsP+JtbgqhaviN2CQun4kXm6YP1Cq+pVlNlSjzYM/vHiE1CZLOGlqrkSAOw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd1c849-49a3-4303-40d1-08dca6836684
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:10:47.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3740



On Tue, Jul 16, 2024 at 8:55 PM, Chen Wang <unicorn_wang@outlook.com> 
wrote:
> cv18x -> cv18xx, please check this for all patches, both title and 
> message text.
> 

I will fix this

> On 2024/7/15 0:28, Yuntao Dai wrote:
>> Add mailbox support for Sophgo cv18x SoCs, and test on both cv1800b 
>> SoC for
>> milkv-duo and cv1812h SoC for milkv-duo256m
>> 
>> Changes in v2:
>> - drop 'recvid' 'sender' in dt-bindings
>> - fix compatible to 'cv1800-mailbox', and change filenames too
>> - change #mbox-cell to 2, for <channel tagert_cpu>
>> - add struct cv1800_mbox_chan_priv and function cv1800_mbox_xlate to 
>> extract
>>    informations in mbox devicetree node of mailbox client
>> 
>> Yuntao Dai (3):
>>    dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
>>    riscv: dts: add mailbox for Sophgo cv18x SoCs
>>    mailbox: sophgo: add mailbox driver for cv18x SoCs
>> 
>>   .../mailbox/sophgo,cv1800-mailbox.yaml        |  61 ++++++
>>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   9 +
>>   drivers/mailbox/Kconfig                       |  11 +
>>   drivers/mailbox/Makefile                      |   2 +
>>   drivers/mailbox/cv1800-mailbox.c              | 203 
>> ++++++++++++++++++
>>   5 files changed, 286 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
>>   create mode 100644 drivers/mailbox/cv1800-mailbox.c
>> 


