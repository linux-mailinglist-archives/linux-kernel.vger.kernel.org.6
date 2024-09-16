Return-Path: <linux-kernel+bounces-330839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CB97A50F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C7C28AC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4101598F4;
	Mon, 16 Sep 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OwVUDonA"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD29158A19
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499703; cv=fail; b=QBhLaRh7kKCeixB9IefFHt1L+IeICv0foSgzhH33SW2MUIM1yQmgDEjFwNxT2R4ifRCyyyiMkVLaU/ThSo1VesIjtHlN1isYgX+Sy94qkOpmKo+6wj4nP5gsRv5+hxfLEUD/1f3IGhOuzRcMfe8OyNex+ns2b6PHvNpj6XD4iS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499703; c=relaxed/simple;
	bh=4s1gVez+YbDfWkHD+k5fXZYaGFsQLZVc8hmgucUGoWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X06raERFPm0R9teDuFDhIjw3VJ84K7x4QmkjVSz+coBGynp6Xldv2TjHmDPRD3L8uS82D6mK9pqGbs5CdswZXWjJZ6NM3BQJFxW6F6CmeQYxX5Sg+Vkbyz8kYSShJX58vU4E7PoX6JoZj+fiDczCVwzE6aEv/NqfZ23B5Ti0w50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OwVUDonA reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9llKvFcbGZD32AkdH80hMdWnctorFelUyUzbXONKP+STPf2s6v6KVLq8UwbLxHfKNvZndjiC0Xty6e24oqBeS3FSWBziGkrQIgOU+UfHx5F7/pExUCygD3g3G0FzD7F3VmF2HGwcyxGhaJzzx/1PvX2TYDQ4m9fryXe/MpkJOsPDk8nP6BzMShmTcPLsLfmicILKoZl5w/Geo74gWlaQcCz/wW4z9fgr346/NX43KghO9zjFDL4B/cBHtxqrtnG7P6RxIoZFtRJzmMs+noKmNbpNJgoDf7+omsAENNAbZoIGZMwL/XoVl9grIL5yYOydp69BSyME3/sgcxC8GJtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkwCrxpwxDAe7oZLvAx/LUJ1sLC01elcgjqgYfkxLLo=;
 b=manEcEiZpmDAjSfWIp06/S/LmoI24vpwIS5gHtPQ0gsXxc7MmM8QoCjI61mBr4+j5OymBPvtJqcWAOt5k3ZU53hJgR7Ns3XsEwA/RJWjStW2mVRNo7zwvxjrIwfBLZR1iA3gc8KtamfC9zFVdmczXXdFjndDkNeweUH9J7mMuUtWLEpFXPTM74BXlUwQq+L86/ugHLZA84MAa5wshtEdsme7Biyy70ANnVPUaCNeZ8eyb3ATMuGdNnLiAYuci0wK8yUAcecD69KmU4OJtXYFiMFMCy8Dd0oH2VUr/RZ8vhwgcZvHfdFS5GWBMPP6OxFx5h4rsEeJJn0831lztZRcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkwCrxpwxDAe7oZLvAx/LUJ1sLC01elcgjqgYfkxLLo=;
 b=OwVUDonAuUCyC5a/M1xy16Est6c4x307bR1+HH+/lUkvUf8kecWr3Cr7Zo2rWqOkEs1eZ+cZ64erxTmqrJEpGGE2LLODJiLZ9VsklC/q2tksdOO6Bfgfkh0EAoa8Cs3V7LwaUljiqSftgoUVxa0j0aKgPgmmUMNXGbh9CvTH+coR7hhGdl4uXPJVa2RSDiAEvK6uZunO/mJUCZEhcHZhnMwWUmmiWh8I8krRI0SNu5CkIT/UNupZJ97o8Yy2GpmIbyzKIAFUun657Pn6a1BKuF9sutVlZ2RO71jidFCmYANMTT7HaORtKIjeS6MK1rJlRFoJ+v7rDRX56rPORRQySg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9707.eurprd04.prod.outlook.com (2603:10a6:102:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 15:14:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:14:57 +0000
Date: Mon, 16 Sep 2024 11:14:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 03/11] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_INIT
Message-ID: <ZuhLZ+DJtFLstwyZ@lizhi-Precision-Tower-5810>
References: <ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
 <20240826100430.33194702@xps-13>
 <Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
 <20240826184924.53b48861@xps-13>
 <ZszPrBeoPehGsocC@lizhi-Precision-Tower-5810>
 <20240902161250.26846654@xps-13>
 <ZtYCA9cYywmUaJSQ@lizhi-Precision-Tower-5810>
 <20240903150038.3f224ec9@xps-13>
 <Ztcl9phmRK4yOvun@lizhi-Precision-Tower-5810>
 <Zt9UHICWjcq27GkX@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zt9UHICWjcq27GkX@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad8ffaa-355e-4ae3-30f4-08dcd6625348
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?P7Q6VTi6NP0fvG4gM6r6r5GFcEfKCxyz6Z4P+77/UCewRoAMNeIhi8BUul?=
 =?iso-8859-1?Q?1jAWKJqecSrbigiJcGS4KBpjW1dmQl3KLOvYK5196omqH4gW7XLvjMd02o?=
 =?iso-8859-1?Q?50b0WZeF49+S4JhOuiI2zz3lX6LI4Hk7PS9aR6P1McQrYbRUScc3TvFA/D?=
 =?iso-8859-1?Q?HIdri48p3Qma0Nc5U0ALOKiA0j/25niPQgDh4KXgLVglnV5/zMQFIu9m+v?=
 =?iso-8859-1?Q?DqhIr56omREiRBTn64JZSodMXNa2ebDLRL4XtHPuSnGEQlR/s89vHrke32?=
 =?iso-8859-1?Q?691SgZ65RyCuj6R0zk8uP4NfLuZAlLRgnzx9DQvcIVORF597WtBp2LEGbt?=
 =?iso-8859-1?Q?NIUKHee++qyDVGpFwIqpyEI/OjlKg72iGyUlz3eovoej1AXZz9/0wRLFcF?=
 =?iso-8859-1?Q?uukdF0ASnRhOxVf3WQDb7dvmTgtS0HsqV1+SkUzobGybBeUIzq0Gbrr5hM?=
 =?iso-8859-1?Q?UDVGcn3VVWRmpHJFdICtGJJsV6P2NhkJiI35bxcS9+w72kt7d0KUskELph?=
 =?iso-8859-1?Q?+/9+4Cz1t+oA3T1ZInV/0UiEHELI8Qc5zhAaotjWPDSRKm2gauesDk3Yaw?=
 =?iso-8859-1?Q?947n8ytOW7UKQHzuLcREcvjwggRWh6Lymal9LrvNNFCPWrhsA86cX/xefg?=
 =?iso-8859-1?Q?4owfqLOCC/vhaV360eLPjefk3sCzh4wmMJs+aVJ4Jzpruvq8WMGWN4PAbE?=
 =?iso-8859-1?Q?5UPVdl/5RP2c0ewQXSP138pU1A120kWxiWZcaEJdNmYl4rc4leI44laSOU?=
 =?iso-8859-1?Q?0ohtHpYC8953mEcgJ07Savqad1FOzYMNRWnNRLjY2hfHZFWrMseL7wLYNd?=
 =?iso-8859-1?Q?wSM9B1A1tGld0RLZ5bsYKF+GJCxxd1Oz6mEcssq2CpdDQ5YZSHgFjdpiSa?=
 =?iso-8859-1?Q?5wmNnE/ii3pVISGjBNJjCz65t8alTySKYWA4V28RgQQ4xJx6mqbA592emV?=
 =?iso-8859-1?Q?B4KMnhqWEqne0leRvKBgpvmS8E1CBufWdVJtLuiCuCceLQ/Qwn25P6pfKv?=
 =?iso-8859-1?Q?9tqebNRUxatLfeILqBgzINbdJw4i8bXguZETBatooHHzzlcHGHbsH0kyhk?=
 =?iso-8859-1?Q?0TspWIuO4nfwBd/L+cl20U89oni1ZLtFRaOuTjx6YmWiuWWU7g+RFWoi0B?=
 =?iso-8859-1?Q?Ds8ocazGe29WGE2d5I+czLMED5mX6vNlGiwnPlHVYx6ktsnKIH628/swHi?=
 =?iso-8859-1?Q?2qiqy92R1up4mQIDXVxVVR9w+wr/9CpmGIch4Y1+galTrCJVGYcJFjEg83?=
 =?iso-8859-1?Q?ENEHBcXcz67FkKeCpmrDgM5PO7NJGCaRiyYTnqhYyrk6YgmOvZWFRwvvkA?=
 =?iso-8859-1?Q?ZNTtoqhEKEJ08iS8yppBIYQQm4cumV5N+yKIr2r1tkgXEo4vI9yzYvS+Sa?=
 =?iso-8859-1?Q?5oFkY5AcnPIYCsPj7i8Bn9UHmziEoa/rQ9powhz1+JsnSg1asamWnh7AJU?=
 =?iso-8859-1?Q?k6bt+IQY9zR/r/iemeZHmdhtilLS5ojLOO/4Lw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?GG7MaIrGJIIlhUbzzj4tTGqb2PGiTF/DUkIWu73AFsl98W1hHiy3EADww0?=
 =?iso-8859-1?Q?r6KCfe3Mk8RlIIRaUJtmRRqdSbGE5KlYmWReQpGRRk0LAl/93aLLGWhtTL?=
 =?iso-8859-1?Q?3c16T28UTiER0vpu0KmdZEYCM87d/EB/sY92Miw/IhBbmIKsJnNWj4pAiq?=
 =?iso-8859-1?Q?keVcgW6SXAO1jScKpi4j9MHohI7lgRxEKprqXdfVtwLID72YuQUzpmaNiB?=
 =?iso-8859-1?Q?sgLKmJ9pMG19eSP0hR1hWcBS8XMCsb7afIIIBT6xLUPU7/l0UvpNwacgR8?=
 =?iso-8859-1?Q?yOOUULssHShQKcGg27IyXItwXhx1r5SSr4cOzRxsH6XFsfv01L52M2R/r5?=
 =?iso-8859-1?Q?Ee2S3Jfgt4CCIqFjPRzJI5jR4VFtqX/IN9WUfAQyxDtRZAAIm+5q1UPiya?=
 =?iso-8859-1?Q?Y1R1wncnxJz98yIzG4lEKbOGySH98fI19s1DEYZAzINbDdtkcYHjmRH0vj?=
 =?iso-8859-1?Q?OR1EjCaJCKpktAn7LTTCa16bKa1quhH7MciWNXNoitggo7yrfs5B9jlaJz?=
 =?iso-8859-1?Q?ndEBDVp01IolPfPjKhNMoKj9gG6+MfczrQSgBXrmEH7SMZEmMBlvC5FtYb?=
 =?iso-8859-1?Q?mOA/BK0A2eE22cjD1yINW0PYmgPZ3+5ZeKaqvrO2nSipLxYD16L1wEb4OL?=
 =?iso-8859-1?Q?sDWmFFgDS90ISB7LzLzZ9TO6y2n7UEG6eyn7Sj3deANhvOBFux3desKNEG?=
 =?iso-8859-1?Q?LWV8PWp2ScSeimI9H70NWVP3kyR8By2pZxnkJwFMJ8RKBep8wQ51GsOyvx?=
 =?iso-8859-1?Q?Na1Ivy97uucO6G7ytN4pna0VTfyztxqsF5naErz+EOj8sscxQZAtEkaTDy?=
 =?iso-8859-1?Q?dQrcHT5Oh/dVhMbIoc2DiApfgkg+zxXl2xVFUXj8Z6Un2ZlKWqhK/mW5HR?=
 =?iso-8859-1?Q?C6FJ4h5sbB31dnqVbzpRsQqdwNt5tbOi9sCGI1T1cRZNUjSqz+RJcdqci5?=
 =?iso-8859-1?Q?zDKztAG8xtm+SAMiJQi1jL+FWs2qkERQ+xmDPYZnY5rQoagMQ9eTnpO9gh?=
 =?iso-8859-1?Q?HIer3TFNxEXqzZVCotRCHFJmosLbaZ5zgbqinOY4ZnVknaZAcfTAUq6LS4?=
 =?iso-8859-1?Q?p9um4gW3CRWpJ9PY+z6t6nxlxLTff8bYpcWQasvokbS4hvUi6kvHn+6TVs?=
 =?iso-8859-1?Q?+8f2fhntVABki168E9EC3alJ0M10el5q79PLBUq7LB78CI2iWRdpJej7oh?=
 =?iso-8859-1?Q?ymN5X3rxUIYDVzDqAQdU52WhjlEkJo4JNwLvrE2ePzsN8E3T9g7eVeZg+P?=
 =?iso-8859-1?Q?b7jhiE7dY3GTp2a4IZHY0B1E6JVcTzaj4nMNaKMKJCPaC5QH68UhtDHMTi?=
 =?iso-8859-1?Q?QyYDi7p8iPt3NByoijiPQUetBX4RHsfIobzVN5blQTDdYgjf3BLnxi+uKp?=
 =?iso-8859-1?Q?13WoQ6KskHfU191VKY1N22MGOmM7VJdJIwT225vrhzP9RLw8i+6eNEHzVA?=
 =?iso-8859-1?Q?LhIKzAbaZaSp0eebkdOjzcvlwYqwM6EmG3Gca+/1fFP1E5i3oA9gUiJqtd?=
 =?iso-8859-1?Q?rRKyaNN/eLIn4TnjM01PvhIUzfHjIzrCx9yzW7Y9lAKigd0fFx2QqYS4Ma?=
 =?iso-8859-1?Q?uaBvBGEAr2X4YS5mV/h1m2bOSemeLHVHhg1dYVFdzAXljfmk1IFDqb2DTj?=
 =?iso-8859-1?Q?uny9l9Hx17I8s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad8ffaa-355e-4ae3-30f4-08dcd6625348
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:14:57.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzc1rBdtUbnqPJK07DQvp1UiMyY2brvy58/mTmz2E28AkAKe9ctYwfXOqldAzt+/a6MBPx+zwETOzly1DiYtvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9707

On Mon, Sep 09, 2024 at 04:01:32PM -0400, Frank Li wrote:
> On Tue, Sep 03, 2024 at 11:06:30AM -0400, Frank Li wrote:
> > On Tue, Sep 03, 2024 at 03:00:38PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > >
> > > Frank.li@nxp.com wrote on Mon, 2 Sep 2024 14:20:51 -0400:
> > >
> > > > On Mon, Sep 02, 2024 at 04:12:50PM +0200, Miquel Raynal wrote:
> > > > > Hi Frank,
> > > > >
> > > > > > > > switch to this address if it is free.
> > > > > > > >  *
> > > > > > > > In step 1, i3c_bus_get_free_addr() is called. To optimize for step 2b, this
> > > > > > > > function should return an address that is not pre-reserved by any target
> > > > > > > > device with an assigned address in the device tree (DT).
> > > > > > >
> > > > > > > This does not make sense, if you want to optimize for 2b, why not
> > > > > > > selecting the assigned-address property in the first place if it's
> > > > > > > available?
> > > > > >
> > > > > > This is my first idea. But I gived up this way.
> > > > > >
> > > > > > Select an assigned-address here will involve a big change in i3c framework.
> > > > > > There are no PID information in i3c_master_get_free_addr().
> > > > > >
> > > > > > In DAA flow:
> > > > > > - SVC is get PID first, the get_free_addr(). This case, we can use PID to
> > > > > > get dt assigned address.(if change/add API)
> > > > > > - But HCI, it is difference, hci_cmd_v2_daa(), get_free_addr() firstly then
> > > > > > send out DAA command. So no PID information when call get_free_addr().
> > > > > >
> > > > > > To cover both case, return a *real* free address here is simplest solution.
> > > > >
> > > > > But this is a limitation of the HCI driver? So why not addressing this
> > > > > in the HCI driver instead? It would greatly simplify the core logic
> > > > > which becomes complex for wrong reasons.
> > > >
> > > > It is reasonable requirement to reduce stall SCL time. After get PID, SCL
> > > > have to stall low to wait for software get dynamtic address, I3C spec allow
> > > > relative long time for this, but still better if hardware can send out PID
> > > > and dynamatic address together withoug stall SCL low. Pre-alloc adddress is
> > > > good method if consider this.
> > >
> > > I don't think it is worth the trouble, given the complexity of all
> > > the changes. I prefer to simplify a bit the software and keep it
> > > readable than gaining few us with SCL low. In this case you also spend
> > > more time on the configuration I guess, so is it better than keeping
> > > SCL low (it will be low for some time anyway).
> >
> > Yes, but see below about HCI. But two solutions will be worse.
> >
> > >
> > > > > > >  Also, I don't understand why you would care to specifically
> > > > > > > *not* return an address that might be the default one for another
> > > > > > > device in the first place.
> > > > > >
> > > > > > If devices A (want adddress 0xA), device B (want address 0xB), if both
> > > > > > device send hot join at the same time. device B's PID less than device A,
> > > > > >
> > > > > > Device B will be found firstly, call get_free_addr(), 0xA will be return
> > > > > > if no this patch.
> > > > > >
> > > > > > Device A, call try_get_freeaddr() to get 0xB.
> > > > > >
> > > > > > So Devcie B will be assign to 0xA, and Device A will be assign to address 0xB.
> > > > > >
> > > > > > After do_daa command, framework will add device B and device A into i3c bus.
> > > > > >
> > > > > > When framework try to add device B to i3c bus, framework will try switch
> > > > > > device B's address to 0xB from 0xA, but it will be fail because 0xB already
> > > > > > assigned to device A.
> > > > >
> > > > > Well, okay, but that's exactly the situation that will happen if these
> > > > > devices are not described in your DT. I guess it's expected that a
> > > > > device not described in your DT can be connected, thanks to the
> > > > > hot-join feature. In this case you cannot know what is this device
> > > > > preferred address and you might end-up in the exact same situation.
> > > >
> > > > If not descript in DT, it means that any dynmatic address can be assigned.
> > >
> > > That's the point of view of the host. But a device might be "critical"
> > > and expect a low address, but the host not being aware. This is the
> > > same situation as your A and B conflict example.
> >
> > DT provided addtional information to let host aware it.
> >
> > >
> > > > > May I question the need for preferred addresses at all? Is this even
> > > > > part of the spec? What is the use-case?
> > > >
> > > > It is implements detail. I3C spec said lower dynamtic address have high IBI
> > > > priority. Spec just said assign lower dynamtic address if want to higher
> > > > IBI prioerity. Using DT assign-address just is one implement method.
> > >
> > > Thanks for all the information, for me the HCI driver must be modified
> > > to retrieve the PID before assigning the dynamic address.
> >
> > I am not famillar with HCI, but according to I3C HCI Spec 1.2, sec 6.4.1
> > Dynamic Address Assignment with ENTDAA:
> >
> > I think it is impossible to do that. A dynatimic address must be provided
> > before issue ENTDAA command. HCI is MIPI I3C standard defined Host
> > interface. we have to consider this.
>
> Miquèl:
> 	Do you have any additional comments for this?
>
> Frank

Do you have any additional comments? HCI is MIPI I3C standard. we have to
consider this.

Frank

>
> >
> > Frank
> > >
> > > Thanks,
> > > Miquèl
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

