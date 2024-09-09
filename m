Return-Path: <linux-kernel+bounces-322032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41408972313
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56CE1F246FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8A17C9B8;
	Mon,  9 Sep 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G+fn0I05"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2238DD4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912105; cv=fail; b=HS4GiBtaTJOwcggqrep6rQd5cH36HR3ErdudmXbeRmkXPpiUFfvUxyUlOKA+4DMjJv8FQTLauY1CxW124UtNBce49g3lJpsRJ6Q5pt4JfYCcc+n3j+RurQWFVt1AVcOsgEMVpZFBDWRzksmoC8xDF8zI+wp0NVRb9yTBTCUgkHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912105; c=relaxed/simple;
	bh=QHiZHQrscdlQMEDaxXkpCeuPsCAAYYnPObyGLI12po8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mqMv6Ws76YxpUu3XvNZWpdnhMCJOdGF5DVVoRMlXMxhZJMtBolQ4M7SfZ+WDZr/vzsrRyE2sebkREE88G2zIWOx0f/Z6fGK+xRekc0aM04SKGl4Ee9TO99E0sDaQ79o9VabZ1TY7T2Alm38c/S6Lv4/l4W5onrxrV/Jhk/UHwdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G+fn0I05 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky/DgLH8ocX6Cdya5DLU63sRw6671iIX/97zMLvXTsw8OXcoONUwHGBH+SrKXINGYjZujKB8c9inbnDPX7prPwFP7Y8h8faRPBhkqgucOdja61fWk5J8C110vpvZZAXIVc/8v2n8a17EUJXRbJ2t8XiFdjt5Ba3aNEe+9jKUCSphr04V2/QR/HatcquwLVJiOfRj4DxxP0Jy/vhPKBQo3IttMN9o3CIrD5PxrZ7fcDVburWkMV+f/I3AJrbhbgSS8QhKBsbH0FCh3L7JBLTtU6fLJHzKZDLuV9dbc+SW8nqhIFN/+LaHWwO0wvw7fa1OOHXfO65AOquZ8XyxPbCDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V1yNV9k2Y/aXKg7nnum6Ut4ENifWsWnIXkyVhI9qiM=;
 b=qVvJ9ueKzKP3iQI5w+YMnRSdv7ByK4HvyTvPV2ZHnXg2MX9rYnyIpttrrSnrraNzHO0iFIe4uYWV3Z+8PLmancKJpTYiCUWFEXQmn6aGhqZTUtCQxaKkdfvplvj6lIv9uLzwgbtTLh1J0rofan8Y+FRk1vz8t1ewqV2qnYtqXVNBjwCHqWNKiaabKk1pagbmKPHrSMHwxLg+eEQgFBvaLBWritP96mRgjgUCWL778apsxE9f1WUGf6jAr7SSoKk/EXLBao8trZynI+A7+9KxfJy0boFsybv6pXz9rSyjRpIqQa/1gpWwBJ1XID+rubb1RVvhVVjwpvhl2oE8OqDrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V1yNV9k2Y/aXKg7nnum6Ut4ENifWsWnIXkyVhI9qiM=;
 b=G+fn0I05buZxo2tcjbqS9+30gjzlPcc2CdrkhsJ2aA2PFndhLjRUCsEnXOccmzdWFeUhs8ebfTBH74lqTnxiaPhJhc39ZD0KK6fGjbV5S6m1RjtxfM3C+qqCTmCvgvxgl+KF4oJjlEhhbSnS9ffFMGpygqdXxmRNlcTsWyxf1WjeOJfdsFsplVVixNJzdTTJ4TNvMmK84MyYC2PrZnVbo2cMzOSFYjiLhd/2b1lptTvR90Dy/5pGXtVTFLnQo4HDh3kFumYf7r1Xte7I6z+uBEbgZrde7Zfj3ANwl28rxVSQiKTds4opEc+A6RFDzSA7KzaT2xNGzBzZf1tUktLspg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10572.eurprd04.prod.outlook.com (2603:10a6:800:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 20:01:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 20:01:40 +0000
Date: Mon, 9 Sep 2024 16:01:32 -0400
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
Message-ID: <Zt9UHICWjcq27GkX@lizhi-Precision-Tower-5810>
References: <20240823180426.056ac093@xps-13>
 <ZsjNA9JV0UKONV32@lizhi-Precision-Tower-5810>
 <20240826100430.33194702@xps-13>
 <Zsylya9TN4mVFL79@lizhi-Precision-Tower-5810>
 <20240826184924.53b48861@xps-13>
 <ZszPrBeoPehGsocC@lizhi-Precision-Tower-5810>
 <20240902161250.26846654@xps-13>
 <ZtYCA9cYywmUaJSQ@lizhi-Precision-Tower-5810>
 <20240903150038.3f224ec9@xps-13>
 <Ztcl9phmRK4yOvun@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztcl9phmRK4yOvun@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f05181a-08cb-4485-2016-08dcd10a37ff
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?lJagZRrLvEAwFBCKLnKPFI6Iemugt3kv5lo7YxuIUeraJLZuR9jSKtwxPP?=
 =?iso-8859-1?Q?lf1VPznIYj88Dpv1VBnRKpEOpi0zL9tRcNTkyx7wytxSFaVOv0Rn08B5Cg?=
 =?iso-8859-1?Q?oa24m4IjhWKEYtCP8TJ6Wo4IxpdIRfYpLN6hCeUAmQkfasjjQ64cMrCR3W?=
 =?iso-8859-1?Q?QzdEY0z+TCONfwHY2mzyNJSrnXcLVxUCef5nX/LhufwYw5YV/CvtUt/PF9?=
 =?iso-8859-1?Q?zXlUhoQULdr95s0F/s7th8ljmm3162M8xQaBWhrmMfJkDBDuA8OI0qMIg/?=
 =?iso-8859-1?Q?udnhS7ruBo7Yw0kkCH/CcJJVNGjItYEaecfqAfDHIAkjJj5BUkSxwAPaTH?=
 =?iso-8859-1?Q?m4tf4qqIzt3TM/S79pl//w49Q8VTnrlwipF0KwJxgENgftjF5+wtpdIMA/?=
 =?iso-8859-1?Q?vxfkT76+omwn1z014mtHjshoYMzZW8rvqhPm5Lv6p0bFn6ZMgMjHH4u33G?=
 =?iso-8859-1?Q?g0PaRX/2weg3+1dh2JlY+3SXFfrL0Y6adbL/gDwOfS5c9MKVuLD+GLGxV3?=
 =?iso-8859-1?Q?G78NxoEUAps9LFPnhUAQ1LoX90fbQoL7jvXedFsLFxlqsuiiRE2RTRKI7c?=
 =?iso-8859-1?Q?Z1+Jr5pJ3d+5qlIbh3MF3ndUWzS9CtteiCCpqIP1NrVDgaPIOFx+q40+ES?=
 =?iso-8859-1?Q?94t2zOuGEDDGtbdpc06Q2vYezi1QWx9ZlQWFUepHSTKSZC1y5DjWNK6p12?=
 =?iso-8859-1?Q?sR8Mga5oYZZGp/VTrKjKaChSFoMe2xXqpPHxYjYsJhweGTQIHC9YelsFTN?=
 =?iso-8859-1?Q?t9VC8pTvqXsud1Sg4L3D77OOXe+75jLVR8SwwZj8af3wCY+na/GsHe25gL?=
 =?iso-8859-1?Q?OEK2eKgQebMuhmY5W9kzvpGH++1AML8wyHks7jcb5M1yjPIISYObcO+zq8?=
 =?iso-8859-1?Q?MxlAH/aXbgideN36gXS7paZqHonaCZdTRcTW6zUfzU7/GaV6N1U0tevmkb?=
 =?iso-8859-1?Q?0TOn2vMU39lQ8nNTuXddH2nsdH21wqK5U4WyAnXieAbAiEx/LvEqTPv3Qy?=
 =?iso-8859-1?Q?y8YsEu/f/B/i5yypbZBr/hJpKKSJbq7D0UKUnUk8ocg3gS7H9LoIHsSs5o?=
 =?iso-8859-1?Q?cFOYxepGRmButanTFcR9hXUIp9098cYqcVIkdIp+nmarZzFFGHl8Et2nqM?=
 =?iso-8859-1?Q?BHfvZb2+G80DshfqfMIZhUUlMHhtZ5lubeu2KCmtwCIob/LWJ9gEfnQujJ?=
 =?iso-8859-1?Q?qKdHWxzQMZo8xEKO5SsRTwQD8xQCW91YyGyiS+eisCY9yLuE4mgu3wgPjU?=
 =?iso-8859-1?Q?y7Wf1nhWulHWmHLKCrf33RFgT8OL8vSYb8whPS9OV2tXXMzHQJuZsqGHvj?=
 =?iso-8859-1?Q?HbHBQO8UpORf65zUTj4ng5UNd+G9PVuGPFDQ9tCdJ00QvfKx/hSizRVPB8?=
 =?iso-8859-1?Q?fKbnz5GaMTAzF+3pHY/t0jqe2T9seWHZRsBFS0DZwIJKaRbfv54mApKEQJ?=
 =?iso-8859-1?Q?5+3ys8Iv4KPefWz4qmwpsqWbSQv6LsMMCPPQlg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?JciLQMPibbX/GCjuZzkX8jUsF5+sTNqsTaeJwI8OsWjkP3SvKyB4iB5C9r?=
 =?iso-8859-1?Q?Csv8mEk0jSrAwe54Jhk1i5FJwIeyuhw5UCXvNUO3/q/hrAmsM9E14gvAF0?=
 =?iso-8859-1?Q?Q5W8L7GuUL3mX1b/LwsS1/VZkqLk8Cv2cuzxOJU40KFrStiAcD/hMJHDXS?=
 =?iso-8859-1?Q?zH/yqlCMPov8FrSES1dQw1Mn1kCasiX8H2QIJD0bMDw7EUcef+CHX4mk2u?=
 =?iso-8859-1?Q?GuqFNnVMoBHZblmShSPpHFydBfVZrUdgJJZoJkVhh1InoGP/CZah8WkbpL?=
 =?iso-8859-1?Q?t/mxdKicTUkd7dUsana6vIO2OOPg/ByDc4806Rsnx9lQagq3wYK//vHEJz?=
 =?iso-8859-1?Q?H5CKEon/mY5t/Y9rwXzXukpJtTlhFDH2JeIp0a88F9czcKSaWRE06txGEj?=
 =?iso-8859-1?Q?zg68ppbooLBT6mnJIkz/+DpJuLaBAuZ1Z4H8itbYoI9cxG1dywoyg/vsyD?=
 =?iso-8859-1?Q?XDquZ/oe4tBA21uhuId4fuyJJT0Z7oqzgaylIRfBL6DVXldHCLNFbGDsvL?=
 =?iso-8859-1?Q?oXZTgrTw3WvSo/qZnx2/g0XwCrUeaYm+dM68XrQVbFhc3BQm2so7pkhEr1?=
 =?iso-8859-1?Q?sivVZNDs7Kihoo/i+euDz7qO7sLHs54VS/uFgIVfevE3OPRJCt2NVwi97P?=
 =?iso-8859-1?Q?lcRAuZoFp6YERbATwsYpvc4nFY3K3wFFRhQxHvdSOQriLC89hYsCljTptJ?=
 =?iso-8859-1?Q?7Hfl1yrZDXgyEKDIXfZZgwZdARcTPQhSzuVJLAR550PHo33BREu4XCwGfJ?=
 =?iso-8859-1?Q?SZ8X5sReN7vYL1fJ128tO/TRpbNL79exTvdYhfeNmY/8qRWYUpO0n475un?=
 =?iso-8859-1?Q?88NQEw2PAJJPsWGM9jVh6wOWmZ+fqpC+GEjiBY7+c+ZJS9Nj8vymfBSLjU?=
 =?iso-8859-1?Q?cKUKIktxSyekc7AUf8hM5HooTev+ywlLeGb3ddh7X31qTQCkTEXMcKHoWL?=
 =?iso-8859-1?Q?43HPMn0tPmXM+oVYdiw2sPxd/m2EymORYk0bbLkmjS5MjYBmpMVNt1jbln?=
 =?iso-8859-1?Q?1ot2T7QovytIdn2uxRdH4ykAAQ7vRnXfczda++D119mxjM7jOzNkK/ARGG?=
 =?iso-8859-1?Q?2M4Z1WgzDCf7Lz3p5NC3007Y90LRTW/RFSwGLys2Jf43c2WTx8JmL4Oc78?=
 =?iso-8859-1?Q?bOHFHkSOCB/LLs/c7lG8ce17kSdcEo+RGYOl0X7kVYV3dXUosYD8hKcn9E?=
 =?iso-8859-1?Q?voxncq9amUgUlHBwbelxNHdwQIX/IH57x5eDOJOCN8TyB/oikzYxfgTPy/?=
 =?iso-8859-1?Q?MgVTieOfj1/n32vi/k32IkSlGvjJLO7n10CFsBLw9TbyG2SLMLuxslDg3R?=
 =?iso-8859-1?Q?Ouz0KcRB5wDrL8CjA8CxO08OFjaPnJLiuiveFoXdZm33+0oMYcFhFvit40?=
 =?iso-8859-1?Q?x0ss37B1c5oknWRIo17nqmos79nvf+YcghqD54DmnslCkSNVnSFTKbyqBV?=
 =?iso-8859-1?Q?elNoRq5El8vPP3HKgj4Nj/aZJcA/JiUqn0svGihRlPJqNQdbrEg5JylgYk?=
 =?iso-8859-1?Q?lLf8muPEYpT0DFLo84S3h/DPBvAO/cw1Uoz1v3Dlr88MntNVSEWRcXIWu2?=
 =?iso-8859-1?Q?babyCN0E1pcejXxP0fdq7AS9Ih1M4M1xe7EKIMV7DiGJiQ4KVvHmjdOA5b?=
 =?iso-8859-1?Q?hI66A9i/WfH/Qpw6/ONq5V+fQ4VP2ecO42?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f05181a-08cb-4485-2016-08dcd10a37ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:01:40.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucP1Z1EcYVX7GB7VvmimFTmIczReMt9eVnhgRHWJM86dApNYr17D2myRBvxER+7CjgnghQmbuyh/2K0s9e4TdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10572

On Tue, Sep 03, 2024 at 11:06:30AM -0400, Frank Li wrote:
> On Tue, Sep 03, 2024 at 03:00:38PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >
> > Frank.li@nxp.com wrote on Mon, 2 Sep 2024 14:20:51 -0400:
> >
> > > On Mon, Sep 02, 2024 at 04:12:50PM +0200, Miquel Raynal wrote:
> > > > Hi Frank,
> > > >
> > > > > > > switch to this address if it is free.
> > > > > > >  *
> > > > > > > In step 1, i3c_bus_get_free_addr() is called. To optimize for step 2b, this
> > > > > > > function should return an address that is not pre-reserved by any target
> > > > > > > device with an assigned address in the device tree (DT).
> > > > > >
> > > > > > This does not make sense, if you want to optimize for 2b, why not
> > > > > > selecting the assigned-address property in the first place if it's
> > > > > > available?
> > > > >
> > > > > This is my first idea. But I gived up this way.
> > > > >
> > > > > Select an assigned-address here will involve a big change in i3c framework.
> > > > > There are no PID information in i3c_master_get_free_addr().
> > > > >
> > > > > In DAA flow:
> > > > > - SVC is get PID first, the get_free_addr(). This case, we can use PID to
> > > > > get dt assigned address.(if change/add API)
> > > > > - But HCI, it is difference, hci_cmd_v2_daa(), get_free_addr() firstly then
> > > > > send out DAA command. So no PID information when call get_free_addr().
> > > > >
> > > > > To cover both case, return a *real* free address here is simplest solution.
> > > >
> > > > But this is a limitation of the HCI driver? So why not addressing this
> > > > in the HCI driver instead? It would greatly simplify the core logic
> > > > which becomes complex for wrong reasons.
> > >
> > > It is reasonable requirement to reduce stall SCL time. After get PID, SCL
> > > have to stall low to wait for software get dynamtic address, I3C spec allow
> > > relative long time for this, but still better if hardware can send out PID
> > > and dynamatic address together withoug stall SCL low. Pre-alloc adddress is
> > > good method if consider this.
> >
> > I don't think it is worth the trouble, given the complexity of all
> > the changes. I prefer to simplify a bit the software and keep it
> > readable than gaining few us with SCL low. In this case you also spend
> > more time on the configuration I guess, so is it better than keeping
> > SCL low (it will be low for some time anyway).
>
> Yes, but see below about HCI. But two solutions will be worse.
>
> >
> > > > > >  Also, I don't understand why you would care to specifically
> > > > > > *not* return an address that might be the default one for another
> > > > > > device in the first place.
> > > > >
> > > > > If devices A (want adddress 0xA), device B (want address 0xB), if both
> > > > > device send hot join at the same time. device B's PID less than device A,
> > > > >
> > > > > Device B will be found firstly, call get_free_addr(), 0xA will be return
> > > > > if no this patch.
> > > > >
> > > > > Device A, call try_get_freeaddr() to get 0xB.
> > > > >
> > > > > So Devcie B will be assign to 0xA, and Device A will be assign to address 0xB.
> > > > >
> > > > > After do_daa command, framework will add device B and device A into i3c bus.
> > > > >
> > > > > When framework try to add device B to i3c bus, framework will try switch
> > > > > device B's address to 0xB from 0xA, but it will be fail because 0xB already
> > > > > assigned to device A.
> > > >
> > > > Well, okay, but that's exactly the situation that will happen if these
> > > > devices are not described in your DT. I guess it's expected that a
> > > > device not described in your DT can be connected, thanks to the
> > > > hot-join feature. In this case you cannot know what is this device
> > > > preferred address and you might end-up in the exact same situation.
> > >
> > > If not descript in DT, it means that any dynmatic address can be assigned.
> >
> > That's the point of view of the host. But a device might be "critical"
> > and expect a low address, but the host not being aware. This is the
> > same situation as your A and B conflict example.
>
> DT provided addtional information to let host aware it.
>
> >
> > > > May I question the need for preferred addresses at all? Is this even
> > > > part of the spec? What is the use-case?
> > >
> > > It is implements detail. I3C spec said lower dynamtic address have high IBI
> > > priority. Spec just said assign lower dynamtic address if want to higher
> > > IBI prioerity. Using DT assign-address just is one implement method.
> >
> > Thanks for all the information, for me the HCI driver must be modified
> > to retrieve the PID before assigning the dynamic address.
>
> I am not famillar with HCI, but according to I3C HCI Spec 1.2, sec 6.4.1
> Dynamic Address Assignment with ENTDAA:
>
> I think it is impossible to do that. A dynatimic address must be provided
> before issue ENTDAA command. HCI is MIPI I3C standard defined Host
> interface. we have to consider this.

Miquèl:
	Do you have any additional comments for this?

Frank

>
> Frank
> >
> > Thanks,
> > Miquèl

