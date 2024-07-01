Return-Path: <linux-kernel+bounces-236765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6474591E6D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2979C28555D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06116EB54;
	Mon,  1 Jul 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="FdUXxCkN"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A815A85F;
	Mon,  1 Jul 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856020; cv=fail; b=B8jStD36NeN93UOrSgZU2ewfoyrs3q5OH1yZ8nJu7eoFWcSlDc2VRz2acVzMmFt7/AQ8CcR4K6wl2EDKwG71woK1IkNFoDdRmwQ/Cu9CAadlkh4ROabr+pIAsRbgB6J14K/2kGE1o5f2Ae0N78iPlJeY3M0DBgXSNpeZygzvtpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856020; c=relaxed/simple;
	bh=4OZoUerAUxlyplsa9bkFl4Xho2b6x7K/EmdOtjUUBcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HO8CE5MkqIahJMp6PfWL1nzbyC0erysFbOCDGYfba8iisVt95UsqzLKstcAH83ZN4YL9f1SiG6z5bI+mvpaBH+rO+LQa1pNfiir0n1Xr0pbviL2ahdL2a4pu/XEcdo6MQQ0yRg2dPvttO2NOCjkNPrOXpNVHnVnaYoHyq5y72QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=FdUXxCkN; arc=fail smtp.client-ip=40.107.20.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhXiFN8I8PJvlU4+gw3Rssb0x0a7JOhnrNjk8ZiJccZaZFRKSo2gUTB8W5KPzPz9tlVDsr4kZFZ7Ld8iuoEpXHtmPsnxcaChf+cp78N1tQZARsUdUrZ+hd0Yy2U4b+TE4igR8yL//BYH3RBoxl9m6m0DgpGQhElyGPjVtjZh2k+28I26duKydwiy5WgEG6qSn1K5NNEoGI5ojI49L4MCuWGHkjT9AH37khIj4HkA53O2WU7NVnojpOBe5nl0s4Ou+4qVA/T6WmiHtM7yN9UW5i5pSIGrglXW23t3rx3UcUlrik7jqQ55anLHGb925blb52FoeqzSZ/v0kVm8o7lnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M1Gml8l9jPp67BU0eVqgNJl3dtUnm6cYkceJcD/Q88=;
 b=TVMmgj9ZHWUwTPz2BcvsV+3ttGJBh3WEU+Hd/yZ9cCYf0LJ0i8odS2j3UZPnb8YjAE+B3MfLUBHTe43TlfsV9RGizeqOxd82SCluqtPZPc+tKJUEGfNz0GUkJlS9URmbj3/Qz4xjcUTGlIVmUBVtusRUv1cDLK18VzVNK02gvPCZvVDQWCFlp9lvHTo0eXHD4iqO/fcJETlaYKyAoNattDtwagPa5oLDaNrgNamSRbmEnt1oJU6C+iiXOQQh82ZHSe1T7LuiCGBhqbGxQORU92EvkKDARnyt65HolOqiSRVFUzk5jC7s/abXIpDFDjy1q+OileL+qQ1LdDTW3O2C+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M1Gml8l9jPp67BU0eVqgNJl3dtUnm6cYkceJcD/Q88=;
 b=FdUXxCkNo7dC/IYljtaB15kHX1Mm9n2ZWkz0JCbMCbyQGn/g2VJW1BCVWRQDjg9OZqfus3xVv2Wo9IaB5Rj9MNDfcWNA4BCIt67OiK6vRQeEDs4/29cuYVq9ofbuq9BBEPtUa0v1F7b3saqi0IodH+1ULr4Q9WdNcKLLErqPo2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI2PR04MB10222.eurprd04.prod.outlook.com (2603:10a6:800:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 17:46:51 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 17:46:50 +0000
Message-ID: <b59cbabc-eef1-4697-8f33-276ee1967829@cherry.de>
Date: Mon, 1 Jul 2024 19:46:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] hwmon: (amc6821) Convert to with_info API
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-11-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-11-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI2PR04MB10222:EE_
X-MS-Office365-Filtering-Correlation-Id: 792bd1d9-5e99-4f00-717a-08dc99f5c993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUpkVjVLb3ZGN0ZJTmlIT25hMHZSdWdJWTlMVjBVVVdzSXduN2VWWjJrTloy?=
 =?utf-8?B?SVFZMGlpRkpLZ1BCcFpubUJCSmtuQ2VvQXZxYnR2d0hJQUhMZzNUZDE5dWV3?=
 =?utf-8?B?MU9kQm9WRHoxUDJSRzdVVVJ2WlErMEwxTEFjQmR6dUlHekpyRitNSklyalpN?=
 =?utf-8?B?YnVNemJPeWJzYWpXaUo0djBSaXUzWENzNzN1bHZ5clBlSE8zOXAvc1V4TGNN?=
 =?utf-8?B?MUREN3VxOGZMNUMwcmtFU2krVnVOcU5tV0toY1owbjU4VGh6cTFpNFZPRHhR?=
 =?utf-8?B?TFlkV09LZUgzZCtvNlVMY1ZPQlZsQlM5djVPYU5WNG5VaDUvWGRKNlJ5cnU3?=
 =?utf-8?B?Q3pWUUMwVVBVRHFvOFBIWHhwSnZudng2cVpWQnVtNmFFaVdTYlF0ZDFKVmY2?=
 =?utf-8?B?V0ZZTXRJZno4MVEvQ0RmMXc3RnJjUWwrKzNmNW5CNjhjUGVJS0xpWTd3dXNn?=
 =?utf-8?B?b2M5RWg1WGZKQTlZS1BlMGJhM1ZWY3RWYkpEcmhBVHlVUzFBWFgrUDNCZFlv?=
 =?utf-8?B?eDhybVcvbUk5dThtemxEYnllV0dmczk2OHJCWUY4a3JCNWtVdnh3STlNOEs0?=
 =?utf-8?B?TEdNczAwU1BCOGlKYzhwN0Jud1JBK3BTUlJSVUdyWUJ0STlOb21jM0ZBa3V2?=
 =?utf-8?B?MGQxdVpYdGpvTGMxQ0VjU1hQVVlnY3piZXhiRk95UEs5bXNkRnhNcWZkbm9T?=
 =?utf-8?B?UHhEZ1hTK2JCOHVqU3Mra3FZcTJ4REU1bDBqd0N0cHJKdkttSVAzZmR4Y0dj?=
 =?utf-8?B?L01FOENpZzBVejNiSWhrWVpyV3RkdnowVDZUV0Uwem8zSS9heFhUb3hOZlB2?=
 =?utf-8?B?b0NEOVgveUZzektFYmRJUGJRczBxbno0KytEWm1xdXovRDNVQXFiTFZYUFl4?=
 =?utf-8?B?R3Yyd1NISW1tWmRpVzhiUDVURnZXTDZIcXQ5VXNRMmFJNkpkcnZ1RjR2RTU1?=
 =?utf-8?B?bGR4LzFKZU5NWHVHRTZNdUpJNC9sZUhzWWlzNzBGNkdLNmtwTTQ5bmlEVzR1?=
 =?utf-8?B?R0FtUEFYazFnVGlJR3pvbUdjWXQxYmsyVElQSERVZ2pRajRlV2FPTXJ6TTJH?=
 =?utf-8?B?bkJINjNEb1VYQWRCRWhraHBrWDNTZWdPZTNsalhWdnladlZiYndmZDhWdG9W?=
 =?utf-8?B?M3RqZ0d3aENIdHhUZmthUWNwTEh1aFZjb2k2dVNLSmFGbXcyeWE0YW55dGIx?=
 =?utf-8?B?ZWNmNTluV1NuazJDME9qeWZPeDMxRnJocjZDT2UrS3RHaEpULy84SDlDVVE2?=
 =?utf-8?B?dDdyUm52cS9MdmJHVzNuQmdWZktNSU8yalJrNXpUalRUb0ZjTU9NdVhReU5y?=
 =?utf-8?B?U0FvK1JXYm1jVVFNZTEzWFVXUENtY2loZ3hJMDZtQkhhdlNUd21hdHZ5VkRv?=
 =?utf-8?B?WS85UU5ob3R4ajNrVzVRUXlxNUR1NHZrUit6bVh2U1g0WGVUT09ZKzU4Tkwx?=
 =?utf-8?B?MHNKdFhoN0d4TTBzem1iUG4wMmJ4RXNtcUNyNXM4SXFUMXc5c3g3MEdtTTdM?=
 =?utf-8?B?anIvYlRXUHFwNzIzZkFkMXRMTzdxNDJXUzZiREg1aDh0bmwvd2ZSc0hiTyt3?=
 =?utf-8?B?MndpdWFXa1lML1BJV0g3akdIWDMzdDNGMC9ySmlsYlZjZTludmhORE1oY2VB?=
 =?utf-8?B?cDZxK0I2MUlPTW81Tm40UkxHaXppbENEVGNRbEF1TGFaUXV2czNwK014N29a?=
 =?utf-8?B?aHB0WG92SG5EcG1FZ3M1TlRiYzhtQWVuSDVLU2ZyWlpIbkdraUFqeUo0bkdZ?=
 =?utf-8?B?RW05SDRYYUgwb1NQUVRpSkJwdlhMMFZxYStVYWhQMlRldC9Xc09yZXFiOEx0?=
 =?utf-8?B?eG91TURBS0lON3Qxby9rQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXY4VHEzYkE5U2lIWmIxSjFBZ2lzQTdSc0pCNGRpR21zNURUWStlTEdvWU5a?=
 =?utf-8?B?YWxsVWQxamh1ZG95MXVuZjErRDcxQTk1MkpLSWZnRlRvM3pjdllCWnJMdStj?=
 =?utf-8?B?enEwd3VNT25pMnhZNzRpdE5hRmNLOEo3aDRZRERMYWQxdDJwcXd5T1lpb3lk?=
 =?utf-8?B?dlVEb2pYZWFaeG9FakY1ZGhXaGtIMitNWnBnWStDTk1yNFJ4VjR1ZVRKN0N0?=
 =?utf-8?B?TWYzeUdjY1hZbDNDUi9GNERjaERQUHRhMGF6d2tnNHlCeXdDemRZVERrMWlh?=
 =?utf-8?B?WU9lVEtnbml1Y3VkeHovNVZNWkhhZFgyblJIeHpGWlpZM1IwdEJnSnRhcFJi?=
 =?utf-8?B?QzliSHBUbEpVeEVDdkZsb2p5S2F2ZHlOaW0xbnBjQ1cyMi9sbHJQQ3pheita?=
 =?utf-8?B?VjlyTkJBRXQ2Qy9LNHJ6TENvQ3pxTTVJZ3BaQ2xQMzU5REhhQzFmZ0o3RDZ1?=
 =?utf-8?B?bFNlTzJWalVoVlRlNUplT2ZvS3QxdXZjT3pBSjF4Y3hMM0VvUUd6RW8vNTQx?=
 =?utf-8?B?Uis4TWVBbkVPOHNpS0M2OUxDQzlPL2pDWjMzUEhqM1orbmNCSnZ3Qlhhajhm?=
 =?utf-8?B?T2hjWTlOWjNYYkFrQlpodGJWa3RCY2lvMm9GbzJYaEdvc1pvSWFaUXpuZW9u?=
 =?utf-8?B?VCtzMEdDdStQN1NYRWFaemx4RnVtNWsyaFRRM1FwWEErSlBlRXA1aTlpR2s0?=
 =?utf-8?B?a1Vxc2crOHRiYkNGVmFFSHYwSktxVnM2NldXOHpGQVduZGg1SjZPQ1JVdXAv?=
 =?utf-8?B?Wi9MT2V6anc0UFJiaEpxTFJuYnViSzhUdDdKTVBtbHR5dnhUd1cxOXhvUEFO?=
 =?utf-8?B?d095d3NmdEtXWWNMYjk4TTRjRTVkQXAvVmhSYm4zWlZ3MWJFcnlySkltdUtY?=
 =?utf-8?B?dzErZG03MDZzTWFEVFdvT2pvVWRJN1l1WlY1aytTSitOUFk5UHFnTjAyeHE5?=
 =?utf-8?B?TDJGOWticlRsV25DSHRnblNvZjU3VmpVYXA1KzBzZ25OTkk0MDltWmkxM01F?=
 =?utf-8?B?M294ckZNWWVJcnoxWDIxNUd3aWZwT2dsTkErb2NreWY2VzF5NS8vODFiaUs4?=
 =?utf-8?B?L2lTZWkrdjN1OFVORzZsSnhoQUpQNHJxT25YaFlzd1lBdm1vN1BIcGg5bmJh?=
 =?utf-8?B?TkFxWlpRVXZFWUNWY3NSbFRZcGt3TEZQT05DenY3N0w3dGdUdzdqc0JRRXY5?=
 =?utf-8?B?U3laWjFEK0c5MGtBMDBKaFRER0ZqZnRsRkpBV3pUZy9lUy9NUU1SZlVVdmtH?=
 =?utf-8?B?T2tYRjRQdnl6d20vMi9rQktqaFZOb3lnYkVjSVZqWitOckxUc2hBMm0xQjhr?=
 =?utf-8?B?dk9ndW5RT0pudmJ6OFkwSkVBeEFyb0NVMTNXM1NSK3N0QUlDMVBNRVc4TTFD?=
 =?utf-8?B?UTJ3WkJab09tY2hHaTZCb2lZbUtaS3phZ2pDSWhDT1hEU1hoUTMwN0sveldP?=
 =?utf-8?B?ZngyVGpRdFkrcVNqaXhsUEoyMDF1bWFtK1prQUxEU2NpdEVVQ0M5SnBkUkJj?=
 =?utf-8?B?d0h5Ri9ueDgvYWl0dURiQ3l3WXBQMkFnWWFSU2ZqaExxcHBoZ0VPcndlL0Jr?=
 =?utf-8?B?WGRWNERoSFpZQXhsWko3d2dmUGJwSG1veUdWSktBcFVLcWFyWHhkOHlsamwx?=
 =?utf-8?B?ajF6SVlpVnFkRlNOSS9RRXkxR0wyU2htTGNRTG5RaFR4enhlb2RIMVQ2MjRm?=
 =?utf-8?B?ZmEzQUU1UWxDQ1RadmtNalh4elRKRkxrcFoySTVJR0FkRmI4d1lRemlCMnBt?=
 =?utf-8?B?eTBHU09yM1lMR0ZYOEJ3Z1Ntd1lkeHorQWdNWGFXd24zWG1XbXdBd044djNw?=
 =?utf-8?B?UUY1ZnJsU2xkMTQrTWpnSzhLQzY1VmlqUTdCc0V3YURUOHRQZkNyY2tLVE13?=
 =?utf-8?B?T3N3WHUxS2ozeFc5cFZyWmJrRXQ1R3VsellMaHNTUFJobmp0M2xFdUVGZGZw?=
 =?utf-8?B?NHV2N0JpbUt0aXB1R0k1eEkzVzV3azJoM1RnWHRJUDRKY0hIOTlyOHljTE1S?=
 =?utf-8?B?Sk9IS3ZQbHBxSFlNOTVRT1dteHY3SFd5eXJud0V2aXlKR3c2WE95SzVyVEtY?=
 =?utf-8?B?cEovcEJRWUVJOFpSWmJxS2FOaEI2M0EyT2QvTUd5cFEyUGJhdENXOG9LekRI?=
 =?utf-8?B?cDFVTXNtWDdEd1ovZG1ZMVVOcHhSbGpLTitRZk0xaGxWL2pBVGJoSmZtK3ZR?=
 =?utf-8?Q?96naVxFHnFXS3I1EakaZBu0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 792bd1d9-5e99-4f00-717a-08dc99f5c993
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:46:50.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWsG12xVHaML5dsz8AR5tZ11z7gCljL6Xb3FS5vnWSZJO7dBym6bqHxpsaWIRvvIkeYFwj4dyVQ09OpnGrb8mJUiAL8kekFq7zk+ZZ89Yww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10222

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> Convert to use with_info API to simplify the code and make it easier
> to maintain. This also reduces code size by approximately 20%.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/amc6821.c | 743 +++++++++++++++++++++-------------------
>   1 file changed, 386 insertions(+), 357 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 6ffab4288134..14d59aa4254b 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -6,6 +6,9 @@
>    *
>    * Based on max6650.c:
>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
> + *
> + * Conversion to regmap and with_info API:
> + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
>    */
>   
>   #include <linux/bits.h>
> @@ -106,28 +109,6 @@ module_param(init, int, 0444);
>   #define AMC6821_STAT2_L_THERM		BIT(6)
>   #define AMC6821_STAT2_THERM_IN		BIT(7)
>   
> -enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
> -	IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
> -	IDX_TEMP2_MAX, IDX_TEMP2_CRIT,
> -	TEMP_IDX_LEN, };
> -
> -static const u8 temp_reg[] = {AMC6821_REG_LTEMP_HI,
> -			AMC6821_REG_LTEMP_LIMIT_MIN,
> -			AMC6821_REG_LTEMP_LIMIT_MAX,
> -			AMC6821_REG_LTEMP_CRIT,
> -			AMC6821_REG_RTEMP_HI,
> -			AMC6821_REG_RTEMP_LIMIT_MIN,
> -			AMC6821_REG_RTEMP_LIMIT_MAX,
> -			AMC6821_REG_RTEMP_CRIT, };
> -
> -enum {IDX_FAN1_INPUT = 0, IDX_FAN1_MIN, IDX_FAN1_MAX, IDX_FAN1_TARGET,
> -	FAN1_IDX_LEN, };
> -
> -static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
> -			AMC6821_REG_TACH_LLIMITL,
> -			AMC6821_REG_TACH_HLIMITL,
> -			AMC6821_REG_TACH_SETTINGL, };
> -
>   /*
>    * Client data (each client gets its own)
>    */
> @@ -188,232 +169,323 @@ static int amc6821_init_auto_point_data(struct amc6821_data *data)
>   	return 0;
>   }
>   
> -static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
> -			 char *buf)
> +static int amc6821_temp_read_values(struct regmap *regmap, u32 attr, int channel, long *val)
>   {
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	int ix = to_sensor_dev_attr(devattr)->index;
> +	int reg, err;
>   	u32 regval;
> -	int err;
>   
> -	err = regmap_read(data->regmap, temp_reg[ix], &regval);
> -	if (err)
> -		return err;
> -
> -	return sysfs_emit(buf, "%d\n", (int8_t)regval * 1000);
> -}
> -
> -static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
> -			  const char *buf, size_t count)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	int ix = to_sensor_dev_attr(attr)->index;
> -	long val;
> -	int err;
> -
> -	int ret = kstrtol(buf, 10, &val);
> -	if (ret)
> -		return ret;
> -	val = clamp_val(val / 1000, -128, 127);
> -
> -	err = regmap_write(data->regmap, temp_reg[ix], val);
> -	if (err)
> -		return err;
> -
> -	return count;
> -}
> -
> -static ssize_t temp_alarm_show(struct device *dev,
> -			       struct device_attribute *devattr, char *buf)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	int ix = to_sensor_dev_attr(devattr)->index;
> -	u32 regval, mask, reg;
> -	int err;
> -
> -	switch (ix) {
> -	case IDX_TEMP1_MIN:
> -		reg = AMC6821_REG_STAT1;
> -		mask = AMC6821_STAT1_LTL;
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = channel ? AMC6821_REG_RTEMP_HI : AMC6821_REG_LTEMP_HI;
>   		break;
> -	case IDX_TEMP1_MAX:
> -		reg = AMC6821_REG_STAT1;
> -		mask = AMC6821_STAT1_LTH;
> +	case hwmon_temp_min:
> +		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MIN : AMC6821_REG_LTEMP_LIMIT_MIN;
>   		break;
> -	case IDX_TEMP1_CRIT:
> -		reg = AMC6821_REG_STAT2;
> -		mask = AMC6821_STAT2_LTC;
> +	case hwmon_temp_max:
> +		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MAX : AMC6821_REG_LTEMP_LIMIT_MAX;
>   		break;
> -	case IDX_TEMP2_MIN:
> -		reg = AMC6821_REG_STAT1;
> -		mask = AMC6821_STAT1_RTL;
> -		break;
> -	case IDX_TEMP2_MAX:
> -		reg = AMC6821_REG_STAT1;
> -		mask = AMC6821_STAT1_RTH;
> -		break;
> -	case IDX_TEMP2_CRIT:
> -		reg = AMC6821_REG_STAT2;
> -		mask = AMC6821_STAT2_RTC;
> +	case hwmon_temp_crit:
> +		reg = channel ? AMC6821_REG_RTEMP_CRIT : AMC6821_REG_LTEMP_CRIT;
>   		break;
>   	default:
> -		dev_dbg(dev, "Unknown attr->index (%d).\n", ix);
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   	}
> -	err = regmap_read(data->regmap, reg, &regval);
> +	err = regmap_read(regmap, reg, &regval);
>   	if (err)
>   		return err;
> -	return sysfs_emit(buf, "%d\n", !!(regval & mask));
> +	*val = (int8_t)regval * 1000;

The discussed signed_extended32() in another patch would need to make it 
here too.

> +	return 0;
>   }
>   
> -static ssize_t temp2_fault_show(struct device *dev,
> -				struct device_attribute *devattr, char *buf)
> +static int amc6821_read_alarms(struct regmap *regmap, enum hwmon_sensor_types type,
> +			       u32 attr, int channel, long *val)
>   {
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> +	int reg, mask, err;
>   	u32 regval;
> -	int err;
>   
> -	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
> -	if (err)
> -		return err;
> -
> -	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_RTF));
> -}
> -
> -static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
> -			 char *buf)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	u32 regval;
> -	int err;
> -
> -	err = regmap_read(data->regmap, AMC6821_REG_DCY, &regval);
> -	if (err)
> -		return err;
> -
> -	return sysfs_emit(buf, "%d\n", regval);
> -}
> -
> -static ssize_t pwm1_store(struct device *dev,
> -			  struct device_attribute *devattr, const char *buf,
> -			  size_t count)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	long val;
> -	int ret = kstrtol(buf, 10, &val);
> -	if (ret)
> -		return ret;
> -
> -	if (val < 0 || val > 255)
> -		return -EINVAL;
> -
> -	ret = regmap_write(data->regmap, AMC6821_REG_DCY, val);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> -}
> -
> -static ssize_t pwm1_enable_show(struct device *dev,
> -				struct device_attribute *devattr, char *buf)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	int err;
> -	u32 val;
> -
> -	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
> -	if (err)
> -		return err;
> -	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> -	case 0:
> -		val = 1;	/* manual */
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_min_alarm:
> +			reg = AMC6821_REG_STAT1;
> +			mask = channel ? AMC6821_STAT1_RTL : AMC6821_STAT1_LTL;
> +			break;
> +		case hwmon_temp_max_alarm:
> +			reg = AMC6821_REG_STAT1;
> +			mask = channel ? AMC6821_STAT1_RTH : AMC6821_STAT1_LTH;
> +			break;
> +		case hwmon_temp_crit_alarm:
> +			reg = AMC6821_REG_STAT2;
> +			mask = channel ? AMC6821_STAT2_RTC : AMC6821_STAT2_LTC;
> +			break;
> +		case hwmon_temp_fault:
> +			reg = AMC6821_REG_STAT1;
> +			mask = AMC6821_STAT1_RTF;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
>   		break;
> -	case AMC6821_CONF1_FDRC0:
> -		val = 4;	/* target rpm (fan1_target) controlled */
> -		break;
> -	case AMC6821_CONF1_FDRC1:
> -		val = 2;	/* remote temp controlled */
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_fault:
> +			reg = AMC6821_REG_STAT1;
> +			mask = AMC6821_STAT1_FANS;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
>   		break;
>   	default:
> -		val = 3;	/* max(local, remote) temp controlled */
> -		break;
> +		return -EOPNOTSUPP;
>   	}
> -	return sysfs_emit(buf, "%d\n", val);
> +	err = regmap_read(regmap, reg, &regval);
> +	if (err)
> +		return err;
> +	*val = !!(regval & mask);
> +	return 0;
>   }
>   
> -static ssize_t pwm1_enable_store(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count)
> +static int amc6821_temp_read(struct device *dev, u32 attr, int channel, long *val)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	long val;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_min:
> +	case hwmon_temp_max:
> +	case hwmon_temp_crit:
> +		return amc6821_temp_read_values(data->regmap, attr, channel, val);
> +	case hwmon_temp_min_alarm:
> +	case hwmon_temp_max_alarm:
> +	case hwmon_temp_crit_alarm:
> +	case hwmon_temp_fault:
> +		return amc6821_read_alarms(data->regmap, hwmon_temp, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int amc6821_temp_write(struct device *dev, u32 attr, int channel, long val)
> +{
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	int reg;
> +
> +	val = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
> +
> +	switch (attr) {
> +	case hwmon_temp_min:
> +		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MIN : AMC6821_REG_LTEMP_LIMIT_MIN;
> +		break;
> +	case hwmon_temp_max:
> +		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MAX : AMC6821_REG_LTEMP_LIMIT_MAX;
> +		break;
> +	case hwmon_temp_crit:
> +		reg = channel ? AMC6821_REG_RTEMP_CRIT : AMC6821_REG_LTEMP_CRIT;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return regmap_write(data->regmap, reg, val);
> +}
> +
> +static int amc6821_pwm_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	u32 regval;
> +	int err;
> +
> +	switch (attr) {
> +	case hwmon_pwm_enable:
> +		err = regmap_read(regmap, AMC6821_REG_CONF1, &regval);
> +		if (err)
> +			return err;
> +		switch (regval & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> +		case 0:
> +			*val = 1;	/* manual */
> +			break;
> +		case AMC6821_CONF1_FDRC0:
> +			*val = 4;	/* target rpm (fan1_target) controlled */
> +			break;
> +		case AMC6821_CONF1_FDRC1:
> +			*val = 2;	/* remote temp controlled */
> +			break;
> +		default:
> +			*val = 3;	/* max(local, remote) temp controlled */
> +			break;
> +		}
> +		return 0;
> +	case hwmon_pwm_auto_channels_temp:
> +		err = regmap_read(regmap, AMC6821_REG_CONF1, &regval);
> +		if (err)
> +			return err;
> +		switch (regval & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> +		case 0:
> +		case AMC6821_CONF1_FDRC0:
> +			*val = 0;	/* manual or target rpm controlled */
> +			break;
> +		case AMC6821_CONF1_FDRC1:
> +			*val = 2;	/* remote temp controlled */
> +			break;
> +		default:
> +			*val = 3;	/* max(local, remote) temp controlled */
> +			break;
> +		}
> +		return 0;
> +	case hwmon_pwm_input:
> +		err = regmap_read(regmap, AMC6821_REG_DCY, &regval);
> +		if (err)
> +			return err;
> +		*val = regval;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int amc6821_pwm_write(struct device *dev, u32 attr, long val)
> +{
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
>   	u32 mask;
> -	int err;
>   
> -	err = kstrtol(buf, 10, &val);
> -	if (err)
> -		return err;
> -
> -	switch (val) {
> -	case 1:
> -		mask = 0;
> -		break;
> -	case 2:
> -		mask = AMC6821_CONF1_FDRC1;
> -		break;
> -	case 3:
> -		mask = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
> -		break;
> -	case 4:
> -		mask = AMC6821_CONF1_FDRC0;
> -		break;
> +	switch (attr) {
> +	case hwmon_pwm_enable:
> +		switch (val) {
> +		case 1:
> +			mask = 0;
> +			break;
> +		case 2:
> +			mask = AMC6821_CONF1_FDRC1;
> +			break;
> +		case 3:
> +			mask = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
> +			break;
> +		case 4:
> +			mask = AMC6821_CONF1_FDRC0;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return regmap_update_bits(regmap, AMC6821_REG_CONF1,
> +					  AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
> +					  mask);
> +	case hwmon_pwm_input:
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +		return regmap_write(regmap, AMC6821_REG_DCY, val);
>   	default:
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   	}
> -
> -	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF1,
> -				 AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
> -				 mask);
> -	if (err < 0)
> -		return err;
> -
> -	return count;
>   }
>   
> -static ssize_t pwm1_auto_channels_temp_show(struct device *dev,
> -					    struct device_attribute *devattr,
> -					    char *buf)
> +static int amc6821_fan_read_rpm(struct regmap *regmap, u32 attr, long *val)
>   {
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	u32 val;
> -	int err;
> +	int reg, err;
> +	u8 regs[2];
> +	u32 regval;
>   
> -	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
> -	if (err)
> -		return err;
> -	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> -	case 0:
> -	case AMC6821_CONF1_FDRC0:
> -		val = 0;	/* manual or target rpm controlled */
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		reg = AMC6821_REG_TDATA_LOW;
>   		break;
> -	case AMC6821_CONF1_FDRC1:
> -		val = 2;	/* remote temp controlled */
> +	case hwmon_fan_min:
> +		reg = AMC6821_REG_TACH_LLIMITL;
> +		break;
> +	case hwmon_fan_max:
> +		reg = AMC6821_REG_TACH_HLIMITL;
> +		break;
> +	case hwmon_fan_target:
> +		reg = AMC6821_REG_TACH_SETTINGL;
>   		break;
>   	default:
> -		val = 3;	/* max(local, remote) temp controlled */
> -		break;
> +		return -EOPNOTSUPP;
>   	}
>   
> -	return sprintf(buf, "%d\n", val);
> +	err = regmap_bulk_read(regmap, reg, regs, 2);
> +	if (err)
> +		return err;
> +
> +	regval = (regs[1] << 8) | regs[0];
> +	*val = 6000000 / (regval ? : 1);
> +

Just putting a "bookmark" here since we're having a discussion about 
this logic in another thread for another patch.

Also... missing 0 here between the question mark and the colon?

> +	return 0;
> +}
> +
> +static int amc6821_fan_read(struct device *dev, u32 attr, long *val)
> +{
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	u32 regval;
> +	int err;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +	case hwmon_fan_min:
> +	case hwmon_fan_max:
> +	case hwmon_fan_target:
> +		return amc6821_fan_read_rpm(regmap, attr, val);
> +	case hwmon_fan_fault:
> +		return amc6821_read_alarms(regmap, hwmon_fan, attr, 0, val);
> +	case hwmon_fan_pulses:
> +		err = regmap_read(regmap, AMC6821_REG_CONF4, &regval);
> +		if (err)
> +			return err;
> +		*val = (regval & AMC6821_CONF4_PSPR) ? 4 : 2;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int amc6821_fan_write(struct device *dev, u32 attr, long val)
> +{
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	u8 regs[2];
> +	int reg;
> +
> +	if (attr == hwmon_fan_pulses) {
> +		if (val != 2 && val != 4)
> +			return -EINVAL;
> +		return regmap_update_bits(regmap, AMC6821_REG_CONF4,
> +					 AMC6821_CONF4_PSPR,
> +					 val == 4 ? AMC6821_CONF4_PSPR : 0);
> +	}
> +
> +	if (val < 0)
> +		return -EINVAL;
> +
> +	val = clamp_val(6000000 / (val ? : 1), 0, 0xffff);
> +

And another "bookmark" here.

> +	switch (attr) {
> +	case hwmon_fan_min:
> +		reg = AMC6821_REG_TACH_LLIMITL;
> +		break;
> +	case hwmon_fan_max:
> +		reg = AMC6821_REG_TACH_HLIMITL;
> +		break;
> +	case hwmon_fan_target:
> +		reg = AMC6821_REG_TACH_SETTINGL;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	regs[0] = val & 0xff;
> +	regs[1] = val >> 8;
> +
> +	return regmap_bulk_write(data->regmap, reg, regs, 2);
>   }
>   
>   static ssize_t temp_auto_point_temp_show(struct device *dev,
>   					 struct device_attribute *devattr,
>   					 char *buf)
>   {
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr_2(devattr)->index;
>   	int nr = to_sensor_dev_attr_2(devattr)->nr;
> -	struct amc6821_data *data = dev_get_drvdata(dev);
>   

Should be squashed with the appropriate commit?

>   	switch (nr) {
>   	case 1:
> @@ -423,7 +495,6 @@ static ssize_t temp_auto_point_temp_show(struct device *dev,
>   		return sprintf(buf, "%d\n",
>   			data->temp2_auto_point_temp[ix] * 1000);
>   	default:
> -		dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);

Not sure this is related? Maybe a separate commit?

>   		return -EINVAL;
>   	}
>   }
> @@ -579,130 +650,9 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>   	return count;
>   }
>   
> -static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
> -			char *buf)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	int ix = to_sensor_dev_attr(devattr)->index;
> -	u32 regval;
> -	u8 regs[2];
> -	int err;
> -
> -	err = regmap_bulk_read(data->regmap, fan_reg_low[ix], regs, 2);
> -	if (err)
> -		return err;
> -	regval = (regs[1] << 8) | regs[0];
> -
> -	return sysfs_emit(buf, "%d\n", 6000000 / (regval ? : 1));
> -}
> -
> -static ssize_t fan1_fault_show(struct device *dev,
> -			       struct device_attribute *devattr, char *buf)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	u32 regval;
> -	int err;
> -
> -	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
> -	if (err)
> -		return err;
> -
> -	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_FANS));
> -}
> -
> -static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
> -			 const char *buf, size_t count)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	int ix = to_sensor_dev_attr(attr)->index;
> -	u8 regs[2];
> -	long val;
> -	int err;
> -
> -	err = kstrtol(buf, 10, &val);
> -	if (err)
> -		return err;
> -
> -	val = val < 1 ? 0xFFFF : 6000000 / val;
> -	val = clamp_val(val, 0, 0xFFFF);
> -
> -	regs[0] = val & 0xff;
> -	regs[1] = val >> 8;
> -
> -	err = regmap_bulk_write(data->regmap, fan_reg_low[ix], regs, 2);
> -	if (err)
> -		return err;
> -
> -	return count;
> -}
> -
> -static ssize_t fan1_pulses_show(struct device *dev,
> -				struct device_attribute *devattr, char *buf)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	u32 regval;
> -	int err;
> -
> -	err = regmap_read(data->regmap, AMC6821_REG_CONF4, &regval);
> -	if (err)
> -		return err;
> -
> -	return sysfs_emit(buf, "%d\n", (regval & AMC6821_CONF4_PSPR) ? 4 : 2);
> -}
> -
> -static ssize_t fan1_pulses_store(struct device *dev,
> -				 struct device_attribute *attr, const char *buf,
> -				 size_t count)
> -{
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	long val;
> -	int err;
> -
> -	err = kstrtol(buf, 10, &val);
> -	if (err)
> -		return err;
> -
> -	if (val != 2 && val != 4)
> -		return -EINVAL;
> -
> -	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF4,
> -				 AMC6821_CONF4_PSPR,
> -				 val == 4 ? AMC6821_CONF4_PSPR : 0);
> -	if (err)
> -		return err;
> -
> -	return count;
> -}
> -
> -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, IDX_TEMP1_INPUT);
> -static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, IDX_TEMP1_MIN);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, IDX_TEMP1_MAX);
> -static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, IDX_TEMP1_CRIT);
> -static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, temp_alarm, IDX_TEMP1_MIN);
> -static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, temp_alarm, IDX_TEMP1_MAX);
> -static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, temp_alarm, IDX_TEMP1_CRIT);
> -static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, IDX_TEMP2_INPUT);
> -static SENSOR_DEVICE_ATTR_RW(temp2_min, temp, IDX_TEMP2_MIN);
> -static SENSOR_DEVICE_ATTR_RW(temp2_max, temp, IDX_TEMP2_MAX);
> -static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp, IDX_TEMP2_CRIT);
> -static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp2_fault, 0);
> -static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, temp_alarm, IDX_TEMP2_MIN);
> -static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, temp_alarm, IDX_TEMP2_MAX);
> -static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, temp_alarm, IDX_TEMP2_CRIT);
> -static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
> -static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
> -static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
> -static SENSOR_DEVICE_ATTR_RW(fan1_target, fan, IDX_FAN1_TARGET);
> -static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
> -static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
> -
> -static SENSOR_DEVICE_ATTR_RW(pwm1, pwm1, 0);
> -static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm1_enable, 0);
>   static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm1_auto_point_pwm, 0);
>   static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm1_auto_point_pwm, 1);
>   static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point3_pwm, pwm1_auto_point_pwm, 2);
> -static SENSOR_DEVICE_ATTR_RO(pwm1_auto_channels_temp, pwm1_auto_channels_temp,
> -			     0);
>   static SENSOR_DEVICE_ATTR_2_RO(temp1_auto_point1_temp, temp_auto_point_temp,
>   			       1, 0);
>   static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_point2_temp, temp_auto_point_temp,
> @@ -718,30 +668,6 @@ static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point3_temp, temp_auto_point_temp,
>   			       2, 2);
>   
>   static struct attribute *amc6821_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_input.dev_attr.attr,
> -	&sensor_dev_attr_temp2_min.dev_attr.attr,
> -	&sensor_dev_attr_temp2_max.dev_attr.attr,
> -	&sensor_dev_attr_temp2_crit.dev_attr.attr,
> -	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> -	&sensor_dev_attr_fan1_input.dev_attr.attr,
> -	&sensor_dev_attr_fan1_min.dev_attr.attr,
> -	&sensor_dev_attr_fan1_max.dev_attr.attr,
> -	&sensor_dev_attr_fan1_target.dev_attr.attr,
> -	&sensor_dev_attr_fan1_fault.dev_attr.attr,
> -	&sensor_dev_attr_fan1_pulses.dev_attr.attr,
> -	&sensor_dev_attr_pwm1.dev_attr.attr,
> -	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
> -	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
> @@ -753,13 +679,117 @@ static struct attribute *amc6821_attrs[] = {
>   	&sensor_dev_attr_temp2_auto_point3_temp.dev_attr.attr,
>   	NULL
>   };
> -
>   ATTRIBUTE_GROUPS(amc6821);
>   
> +static int amc6821_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return amc6821_temp_read(dev, attr, channel, val);
> +	case hwmon_fan:
> +		return amc6821_fan_read(dev, attr, val);
> +	case hwmon_pwm:
> +		return amc6821_pwm_read(dev, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int amc6821_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return amc6821_temp_write(dev, attr, channel, val);
> +	case hwmon_fan:
> +		return amc6821_fan_write(dev, attr, val);
> +	case hwmon_pwm:
> +		return amc6821_pwm_write(dev, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t amc6821_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_min_alarm:
> +		case hwmon_temp_max_alarm:
> +		case hwmon_temp_crit_alarm:
> +		case hwmon_temp_fault:
> +			return 0444;
> +		case hwmon_temp_min:
> +		case hwmon_temp_max:
> +		case hwmon_temp_crit:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +		case hwmon_fan_fault:
> +			return 0444;
> +		case hwmon_fan_pulses:
> +		case hwmon_fan_min:
> +		case hwmon_fan_max:
> +		case hwmon_fan_target:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +		case hwmon_pwm_input:
> +			return 0644;
> +		case hwmon_pwm_auto_channels_temp:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct hwmon_channel_info * const amc6821_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
> +			   HWMON_T_CRIT | HWMON_T_MIN_ALARM |
> +			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM,
> +			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
> +			   HWMON_T_CRIT | HWMON_T_MIN_ALARM |
> +			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
> +			   HWMON_T_FAULT),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +			   HWMON_F_TARGET | HWMON_F_PULSES | HWMON_F_FAULT),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE |
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP),
> +	NULL
> +};
> +
> +static const struct hwmon_ops amc6821_hwmon_ops = {
> +	.is_visible = amc6821_is_visible,
> +	.read = amc6821_read,
> +	.write = amc6821_write,
> +};
> +
> +static const struct hwmon_chip_info amc6821_chip_info = {
> +	.ops = &amc6821_hwmon_ops,
> +	.info = amc6821_info,
> +};
> +
>   /* Return 0 if detection is successful, -ENODEV otherwise */
> -static int amc6821_detect(
> -		struct i2c_client *client,
> -		struct i2c_board_info *info)
> +static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info)
>   {
>   	struct i2c_adapter *adapter = client->adapter;
>   	int address = client->addr;
> @@ -872,7 +902,6 @@ static int amc6821_probe(struct i2c_client *client)
>   	if (!data)
>   		return -ENOMEM;
>   
> -

Should be squashed with the previous commit.

Nice clean-up albeit very difficult to review in patch form, not sure 
there's anything we can do about it though. Maybe migrating one 
attribute at a time, but I would myself not be very happy if I was asked 
to do it :)

Cheers,
Quentin

