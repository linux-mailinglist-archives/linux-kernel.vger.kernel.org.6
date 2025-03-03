Return-Path: <linux-kernel+bounces-540921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F705A4B674
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22823A9200
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884861B21AD;
	Mon,  3 Mar 2025 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bAv4NuPa"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8D13A3F7;
	Mon,  3 Mar 2025 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740971996; cv=fail; b=ayLSKp5P566S0zc0RmlQf/il+DDxP9ej1RuuRYTcRwc85Y90hB1/ithh94XD+hd4SiwLz27rB1WZLop5caZqbwJrP8oguH4We+D0gS9jWkMk5Uyk7HSEVJs3E0m/MuIUIdOiEZ/n462lzStTW0x7T/Oskthf4V3n4rzMFv/TSEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740971996; c=relaxed/simple;
	bh=TQuUaEfsbvhnETOIHYBpGgFA2tp+Oy+2wMM/kEiJrhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uuyO6BVNutrJA6J8DCMFc9P1Om/yGdO1kL1BUer1t1OJOMxZ8xcYuxkeEMBwILAa6k1XpKz0rxlXTe68fNrMxK1AKq7ddDrVSyuTGpd+c225YNkGBaE3zkFi9bgk6DWg87sp0J+q+baQ6eaEgaamZOM+w2ZcwYB4voJWvSE9RGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bAv4NuPa; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqZkqbw6fbTfboemMn6rC35KJQsd9hz7PpxUrVhxuOGH4HpJ+mlC/gPzCMBotgiMXePAk6ELvD5Xc4TiFwLShxrkOHtVaF+tekEfDSO4GYVz0RKA4tY5aU8lskg+po35J8JdpU9qiRVlCeaQPvVSJ0pGRn81jdGOVQgbQiP0TRJUa7uS9gfDq5faMry/zgq7L+Ul2Fs4LGZrLNkNgrFWMZj0JGWR/iaQnxX3FA/shunr1beDD2gLw1qRy6elx/3yLWfc6JkIFf5FvT4HRkP1GZCBStk+xJgi6hcvIFc42pSLRvDCYRNOGkPF2Ztg2fR4D1is0i38jlmfx9iMmYbJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAmT4m+Yr4qdj0/9Pa4K6C4iKk2NWeNt5HhySlySlb0=;
 b=i8Jf6pZI85VpMHM1HzSgdtiSwCYqxR/tqUL3Dd+9TmY1c2lRab7zWtEFyjMXVyKlhCQ2P22gvZWK+EprOlPIuHlBd3iIctXmBPUbXmhAuXJzXx57MOHPnwTTX0Lwm1RqMtxwXjsGj3fAYr7XOJnCzfLqztbXODxcwFlXjZQ7dFWCd2qBBbxzT69WcRBSd++5A9+ZLzsBnFrwVjz4ls+dDN4oZCglO86tnlFBQg0FxysU8PfHX+/ghB9HzKGAosi2kX/WldmTF2rdsmBrletWnmWT369a01WdQPdcDnpA8tjAW+k5AD0tixxP/BO9lZbb5nOXxAaujwP7RNYLotP6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAmT4m+Yr4qdj0/9Pa4K6C4iKk2NWeNt5HhySlySlb0=;
 b=bAv4NuPa2QRA8SWdZ3olUEj9I58Z3Gt5cNiMcdAYLhAOqOg5DO2nFOV07hFG+3R0bnt3gHGWRVkPEIyqw/+mDtgvg2wFGMW/iiq8R14Wwy75lOk11c4JUweO9UbOdlCMUnFfMp4/pQDQbNTXXE+HguS3joa6CXXqZzWnUwwpAwIC83jfxZgB7yvqSbyhf5xpUCvPgYhOa64TC4+9tCQ3pQwMvwvaBHQHfelYfvPX0d9O/dXOz4B7qzyIMkhWfrpfPDptKi2G2pcjRxZib/Yu7hXn9v3ksrgfVN9fmHeSei5iTHwOfZLHmN2yCgwP2GgHU16ZGOTVUsHXDEA+U4jJCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 03:19:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:19:49 +0000
Date: Mon, 3 Mar 2025 12:27:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: sudeep.holla@arm.com, saravanak@google.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <20250303042714.GD13236@nxa18884-linux>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
 <Z8BRFezgiWDtmdd4@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8BRFezgiWDtmdd4@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 3223810a-8869-4b22-d067-08dd5a0241be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UNSbQHLkVFj2n/moNJWp9UYWp6zpi7dsQwSSIa13pOQnkdw8kEtXCCo7AVHq?=
 =?us-ascii?Q?b5gnFGMMCQwIOqfGg9FUxrIjZMw/wyrKODHQSW/2jbK3YKfoLtkk+/ZgGSdZ?=
 =?us-ascii?Q?5Ff1bywQiQ/ob8GiolJ8d56QfqgD54AFp52t7qI2tIjIfxQYzBcNQejgDm5A?=
 =?us-ascii?Q?e8gFPTXbyTUXsdBFU/fndDh7x4/OxXGBKz5vHloyTtZovBMFU7aQ79RovEgz?=
 =?us-ascii?Q?u1GTnYz9g9vwCV7atHi+rFXm3lNuwLjp+3YzTZSSH2KoODVHXvWWffdGZiPN?=
 =?us-ascii?Q?xTc8TXfFeFD8oroVzsgcFmEIL9hVO4/vi48PMEGz03clDOCxJsDVA4bDaTpU?=
 =?us-ascii?Q?LYvAznOqv338SRMr74p6c10EezFKjXQlwo+iom1a+/N677x1i3GqV86BWod3?=
 =?us-ascii?Q?27CyTRodJeW2JnZRxSr6/a8e7p0FZbsB8yrG9Wawl3Qk3nsQF6ray7fjtvko?=
 =?us-ascii?Q?Z8PP8qHkZ2kw+NVhNcFrI37UBM29ejvYLVztiZcKW5tuZUiQU40HOu8l88V2?=
 =?us-ascii?Q?dEFOK1vriLjfnmYGG1yEUZUB51bOwsydpTJsZu5cRyWa5rvYe6ujnESZ+O4M?=
 =?us-ascii?Q?9JVKUgO3UTSm/T3fzpe9i5c+5rQpseOEL6PEKp9DQ8eOo9qG9kX8bU61FbsB?=
 =?us-ascii?Q?ML+DmmhiFFQ65tCPzFiTJ9nLJ7vJwaBq4qsOZC8h1irrpQtbJHTYJpOolTT1?=
 =?us-ascii?Q?Dyde8AjeHfjBMwLfym5UEOGJ4/jlIQAYLwyWKktnzj25K9Qj1xSfZJf6eZsi?=
 =?us-ascii?Q?ZzXHYlmXYHBKyt/5vG4PhXj4OBDxId4TCXc2VCn2FPfgD+htAlTqJMs+HMUB?=
 =?us-ascii?Q?ZAlnscfEV+j1o6yJr2A8+nZ7Yns6e5BzFugXdsD42KD3fVZ37pUzjJtQwlfR?=
 =?us-ascii?Q?FWlMMpcTWSh7eZXoiVxm57FYALtKlQpgHKug6+qYUEk5ZsZbpM/qZSX+mfAx?=
 =?us-ascii?Q?IbBMstfmpclkwwHvi4RIJ1lUONVR+OQHhvDupmM0HZU2sJ3m/9948jaJAFcM?=
 =?us-ascii?Q?kbsv3vEkg98KD/sReNvXFTcZm5YPhMOCythH5nnVXaOu7vxefvRV+NE+fXES?=
 =?us-ascii?Q?uA3GF5+tGILxiEi+3sToaWx09oGr1hUGs53V9VUBw50qOcxDTbx5mJIcAtF2?=
 =?us-ascii?Q?JtaeGbNks8lM2MMCD6je38VEYTV2VpH8r3FvSeDOwWGTwRCPu0AjVLl6xBMh?=
 =?us-ascii?Q?OWz+R6O17cYUlwrmVu8vdsOxvedf84Dqij0F718IuPnXlbppY6r7yQALwrOg?=
 =?us-ascii?Q?08FyYpPZY/FiNqbVrLe4B4wB4cruGkh4lYf9HTZ9/pJmZOJEWsoSnfsJ4s3y?=
 =?us-ascii?Q?G6Nx5o7QR9SrlKHe9VTh86qYS5jgGoNGjcCPl5CmQSGT2gb6KxOICUfAh/z1?=
 =?us-ascii?Q?KEr1d/ZHOm27SVDupbgG8PSEfoHoAmaej6gKVtyP8oXVcA2VD4Y5n/ZvNYBI?=
 =?us-ascii?Q?qaRevV/Bshlwn/ynv6XfhqoFwY8qLPya?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5bJ4C2rBYqCSUf0GHbqcp83YS9EsMw4cvGv/tMQeu9YMjha8l1ZjqkNvotkL?=
 =?us-ascii?Q?ok1VBjH/Y00xDFD7M2jpaQ8pmk1FeHOB5oCdFchOt5ioMLqidwBJbRiZv2O3?=
 =?us-ascii?Q?JNchBvouywelVdyLawy5SaLLRxA8ZKEsTC1q5mJ0FyR5acc84LeBtnH/EMO+?=
 =?us-ascii?Q?DcG/581g5I3aF+WvMbVzmFd/IvfCGYz3OVxc5yYPIFs0GRpzyuQPelag4mFl?=
 =?us-ascii?Q?wbmAiWE3n8uff24v6dkKxjlbbr156ut5GzFaP8NJ2ZzqBuHhtDxrDfXmcpAB?=
 =?us-ascii?Q?OjlfLbeLu3RSr4Yskz4TSW4aOwmdzvnmfeAycbc/a394Ixv4QCDyR26cM44u?=
 =?us-ascii?Q?2I1DeXVDJu3IBq2LF+wo8SJcyUvJRyfvxTPFxEtBkefZ8dTpKa0AJ5LByjfe?=
 =?us-ascii?Q?D4L1Ib64W7cIx5cuVQXlmjIJyONoxkEdhIG/yt80EMJVqyv+/oees+Y787pc?=
 =?us-ascii?Q?MMQYBQx6oLn5iIQuvmCjUWthld96fW8WNArRYobv6dURYLKP9fB1mtRHP+04?=
 =?us-ascii?Q?UHMrZY9jh0ch/w7D+7jXelUQbeYdp0+SmRr0RXWy6D3JxPQ/M5mCaI6TpB0y?=
 =?us-ascii?Q?iYBieKJrepQK8Gf/EB/E28qyfZ9JWFmuOPU7Wx0bY5gjf+glIcdFxXSCGVfw?=
 =?us-ascii?Q?OJaXBXMEvdVRZZAWKiKrnEYX5K2T9+oE6fNfcBDzxytBkKhU27WTVgfURUL6?=
 =?us-ascii?Q?bEZeMEA3SWB1fN8FKWuKM8sm37ozUAhJogaCWQlAiiaA1kC06uzbLZGbxt8a?=
 =?us-ascii?Q?iHI9jYhW4oD6uqeW9+ENF60eiVAc8/c5+A8mKr8zIKLER2UQs6zTabJD7ZD+?=
 =?us-ascii?Q?T3PqOc386TWbaHeiSY603Q9KkXJVS7imrwcL91EPSO6quyVfaAovfRH5jNEz?=
 =?us-ascii?Q?zdMos0g80yw4cKnWApCh91pijsdk3rWEMTUQa+927hH6cQgfG7bVaDCrhTjH?=
 =?us-ascii?Q?owqx4+D7NNIPJymamgkBHW0wAuPIZfFwi0462uxZUMsC+0mI/tS+L41xFMco?=
 =?us-ascii?Q?CPtdQhpnHRqtG51lx4s+fZaoHtGcNpJWX/5e2GTe9tjxBWFAtdulQzu9JAnR?=
 =?us-ascii?Q?1OmljptgCxRYy+CHsjWDA53EZIfTbo6OUtBD6BVWrXTTdDyf/F9lea0l1sbA?=
 =?us-ascii?Q?61V5J0TDcDgrygBsdSNULlHGNAjJsEYESOtz0iQKMgCQhU6re0DoEu0jQvOM?=
 =?us-ascii?Q?8niNNzRPwBKrh1PYQ7Fw322yTj79A7Tmrcn2gjDeWJjqduTbwDMSu/+BKHNy?=
 =?us-ascii?Q?jKrXlkL9Swyrshd154OWbS6y6e8XXzSq8WVco58/OVuYd6FhuwGHqOYiXCX0?=
 =?us-ascii?Q?QuL1Rryu2XrEtWJt8bXVnBvYrLOh8fbSmXdzSUvCV2zf3S4r+nbIOhPJhK1u?=
 =?us-ascii?Q?G1kjBSJh1vuHlILJsLjSGvh1Q9AHQs5Jgtliymp+2MusOZeAgPVtqlu9wJ5c?=
 =?us-ascii?Q?uuWYIdvXOc8dyWvrgdQmkwKyMCh6Y2kl1w75H98suumpMrCaKMnUlkvgL2nl?=
 =?us-ascii?Q?fK1wkALMjYxVpPBah4JsGdhOJXCSSCCmHYE3wumYfBFkktz0nQvkePLDiQLG?=
 =?us-ascii?Q?l8WyvEWAoZnRAWPk9TnlCELWrAslPTv1/GDvRVj7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3223810a-8869-4b22-d067-08dd5a0241be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 03:19:49.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/4RWunVJeIBuxyDAEckKU/Q72Obl/12QZFMk4HlH50VvLTxxPlDb59Y/rhGLeGzf4jjt1kGIzD8lu+LxNinAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101

Hi Cristian,
On Thu, Feb 27, 2025 at 11:48:51AM +0000, Cristian Marussi wrote:
>On Wed, Feb 26, 2025 at 05:44:56PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Add compatible string for the protocols by adding new nodes
>> The current nodename pattern is "protocol@[0-9a-f]+$", the new node
>
>Hi Peng,
>
>> name will be "scmi-[a-z\-]+$".
>> With compatible string and new nodename, cpufreq and devfreq could be
>> separated into two nodes. And fwdevlink could correctly link suppliers
>> and consumers.
>
>beside the backward compatibility issues that Rob mentioned, the thing
>that worries me most is that, while the current bindings describe the
>SCMI protocols because the protocols are WHAT the platform FW exposes
>(and that is all that is needed by drivers to refer to a protocol and
>its resources)...here you are getting rid of all of this, and moving to
>describe basically the various devices that will use a protocol,
>potentially the same protocol, just to have a distinct fw_node ...
>(...I mean my understanding is that there wont be any protocol nodes
>left when the scmi- variant are present and, once, somehow, we will
>have transitioned into this...right ?)
>
>I haven't really had the time to go through properly your proposed
>solution to understand fully all its possible side-effects and how
>many SCMI features could be destroyed by removing protocol nodes
>descriptor as a whole...but...off the top of my head, as a quick
>example, how you will define a per-protocol dedicated transport
>channel in this new scenario ?

This is an issue for current RFC.

>...because You wont have anymore a protocol descriptor where to fit
>this AND you could have multiple DT nodes describing drivers that use
>that SAME protocol, so using this new nodes to fit the same
>transport-chan descriptors wont be possible either....

The other alternative would be

protocol@abc {
	//
	current property not change.

	// Add two new optional subnodes
	cpufreq {
		compatible = "arm,scmi-cpufreq";
	};
	devfreq {
		compatible = "arm,scmi-devfreq";
	};
};

protocol@abc {
	//
	current property not change.
	//add a new optional compatible
	compatible = "arm,scmi-pinctrl";
};

If compatible exists, the driver could use compatible to match.

>
>IOW, sincerely, I understand you want to resolve the problem with
>fw_devlink (me too), but nuking down everything, while loosing, possibly,
>a number of the existing functionalities of the SCMI stack just to make
>it work with fw_devlink at all cost it does not seem to me an acceptable
>trade-off...
>
>...killing the whole existing protocols descriptors structure seems to
>me a recipe for disaster, also because, it just goes against the very
>essence of the objects that the FW exposes and the bindings can describe:

no. I was trying to bring backwards compatible solution.

If compatible is there, use compatible. If no compatible, still use reg.

>as an example, the SCMI platform server manage and exposes PERF_PROTOCOL
>and its related DOMAINS (all fully discoverable without any bindings),
>so, THAT is what is described in the bindings and referred by SCMI driver
>users: SCMI FW does NOT handle/expose TWO distinct perf devices, like the
>cpufreq/devfreq-device that you are trying to describe...

I understand, fw only provides one interface, but linux use two distinct
drivers. But this depends on how to abstract the interface for OS usage.

The interface supports CPU freq scaling and peripherals freq scaling,
I think it should be ok to add one node for each, as below:
protocol@xx {
	cpufreq {}
	devfreq {}
}

Thanks,
Peng

>
>As Sudeep mentioned, IMHO this seems mostly an *unsolved* implementation
>problem more than an actual issue with the bindings and how we describe
>SCMI resources that we need to refer to..
>
>> With compatible string, and driver updated.
>> - Differnet vendor drivers with same SCMI protocol ID could be built in
>>   without concerning vendor A's driver got probed when using vendor B's
>>   SoC
>
>as said, this is a corner case that is easily solvable with the current
>layout (and I will post a patch soon-ish to addess this...)
>
>> - NXP scmi pinctrl and ARM scmi pinctrl could be both built in, without
>>   concerning arm scmi platform takes nxp scmi pinctrl node as supplier.
>> 
>
>..the only real issue is the general fw_devlink issue as in cpufreq vs
>devfreq...

Not sure iiodev or thermal has same issue or not.

>
>Thanks,
>Cristian

