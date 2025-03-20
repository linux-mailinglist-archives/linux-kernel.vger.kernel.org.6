Return-Path: <linux-kernel+bounces-569564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BFDA6A4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F6A7A45A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D213621CC40;
	Thu, 20 Mar 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="fHT6j0P/"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BC2066DC;
	Thu, 20 Mar 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469471; cv=fail; b=aWNmZ5ya/fMOJylUVbsGODsgWaX7QEVroSv6vedeDLWYN5z0sBqGBcSb5lC5yKlmY6iVdUungrYfzqe37dAjoLptRu6hA6rvPYoLI9VcSomkCuLL05szpyDk2tfPC9gLEp0+y48Pa23agwCm7CK2XzA7Nlmi/pw4sZE7yzN56So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469471; c=relaxed/simple;
	bh=7YYIYZfci3UQURUqIrMkYzAhQsdXWJCtNu9ZM/HBFvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=CvRY5fOv+dgnJ+zGNGyftO1+TUsqMTxky8ia49ChEXUiItQ/J0fhr3koqmU2BBGLmU/Jogs3sFPsmI9g/xQDtSlHBPUU3JBKalShkylVZXRT0Hnfg8V+mwg6ejaI81dPYv5tPGcmdakUQCOWeI1B2/SqXKLFXVSWlBkcPziRX5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=fHT6j0P/; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geZ0DC9+VCXFL4CTMlZ4Ff4yTZcC6ZASVbytalE1iGYEtzutvbDivhD0rxSW7TfuFHGw/nMum7j8CSzov749ihzWVgim7pQNUH4puMj3GV7qZcBUkDOZbSBGaXSGBbIBgPfOfj5t0buDcRxVBypUdxSHlrvACtSUnRtXCL0qQqa/kLH4XPTfEak5UBqzhuMTsH8qheGTWB5XdzEGH7WrlKPsMycqJ7v2kneUoadMyk6O78NoAiIi5r+7IxvkUNhN7M4I27IdkUb6IhwpQQ1vHvI8lK7v8jy3ATJISWWvpkQD9eylCOnn2s2BmTz5c8xm1BxqlwlTLa4M6DuaCpzgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGbh+egDdPCq/c9Sf8/fqrXU/XnjMTUIap8qibP2ztU=;
 b=XqgvUyHjU4s40NN7HeQhdowmeADaUsvRu8p8mwseFNitEa0b7Le0hg6MWdBSFTpuJeXVTH3GqAw2Ax1A9Miw5PHNH16xQSYvx54QAJZd0YkE14eLpDuIWAZf+W0OtL94Gt2iLVvj30x1U4oyjAw0Txij55bxM0XR/msDj0CVKo3lrxolsoKOduPAjNuh9xQA/PlMxhvd+jvTwi3rcUKP9UKgsYPFm8IzRqrpR7ZuMAAnk2OTNBVNLmsa9HvzKeIwx1Lk8Krc13cwO3OU274racRRnGwbOYrFi5CCQ8M0K32Shu9zN31CeBIvSB8jpT3/TVrZz/Qutp2aAlMspzfauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGbh+egDdPCq/c9Sf8/fqrXU/XnjMTUIap8qibP2ztU=;
 b=fHT6j0P/2KVO5IGrqd5bP8pCAQ30nSlrvNrjoeUw+VfVl/3DsNAwGKlJDVJWx2GsP1o16qjYSmxwlEX0kWixFMgzkbU2jT1YWC8tqowrovok1w5BPKHr+vyfzlzNPts7xaVORUeFSOUkZofxxigTKGK0fNRx8tecSF4vaYSoB34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by GVXPR10MB8379.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 11:17:39 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 11:17:39 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Lee Jones <lee@kernel.org>,  linux-kernel@vger.kernel.org,
  devicetree@vger.kernel.org,  Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 3/8] mfd: ocelot: rework SPI (re-)initialization after
 chip reset
In-Reply-To: <Z9tASE2-adiEUT-3@colin-ia-desktop> (Colin Foster's message of
	"Wed, 19 Mar 2025 17:08:08 -0500")
References: <20250319123058.452202-1-ravi@prevas.dk>
	<20250319123058.452202-4-ravi@prevas.dk>
	<Z9tASE2-adiEUT-3@colin-ia-desktop>
Date: Thu, 20 Mar 2025 12:17:37 +0100
Message-ID: <87v7s4rlwu.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|GVXPR10MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d528de-0028-4cd2-491c-08dd67a0d361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xro4GB2I2EEzvGkhOy46JL73fk4TzcH8Tupuff2cVQGpDVcux+QiOjNIvQ9y?=
 =?us-ascii?Q?OiVDUWTVB4jkoFKZp4wnU30ugFyUpFt3mKSKG46TZ/ZbiofXiKphPtcQ+90T?=
 =?us-ascii?Q?s4pBRBZJk8HEE3tQzLczD/8xZMZnLzhUsm0NTwL00vMHhBUmJ8s76MlpcfvS?=
 =?us-ascii?Q?alujHNo84Cy17Z2WCc38dAmxvCpLZ8IfKSJcFLAJhXZLfZlCPn8bB4DqAISN?=
 =?us-ascii?Q?eYvi/dl3+9jJaotYaEH0RuWZiygTRr+hOFHryGx/NimYfes3O4N95lkyZcSP?=
 =?us-ascii?Q?H9bC9B05Td9E3P/GcTyR2FLSV6GRknO75jD8R1zJU/BEVbkPzk4Pj70BmvTr?=
 =?us-ascii?Q?9x5AO73edCtPDrPelzAm3EOoFTA6++5G65P9+N7kjXXjvtFRYhMXpNi1GhX2?=
 =?us-ascii?Q?/Q0AskK0bxiTqOdg5BBM5bxslamN5bmWnighxvcT0ogiDpI5bSl+aPVRqch9?=
 =?us-ascii?Q?gq6pWNaWv+3GEQn8rLzFxsZTmKJE5ROKnq+PsXaPFIpfl4WSfZy8QZM+bj3N?=
 =?us-ascii?Q?idsYLUmMQaaV3M0GdE8GIXCM5wA14zESLtfpILsEz3VT9nvYeMy8JDGX8DV1?=
 =?us-ascii?Q?LEcml6+qJLB4bZSDKMnSzFrpDKOIrKK9drY2II8gyG2yoXsyBI0vdK4n0Yvz?=
 =?us-ascii?Q?dZ5VbxUve2hV8Uf4T5RqephtmPqvp7aj1cj9ymsNJNLQXEIZJEknGyfq5J45?=
 =?us-ascii?Q?xgnO7O3EH5tCsxdTbwnO3UXvLdr5TzkYUwFZxe9rvtiHVuSTDJbG4dVy2HgY?=
 =?us-ascii?Q?CeK1Gk1+o/eIx6/bL8phmLICHdUtEPG3Qhiu4wMHvp9EkZNlQXxIO99XT+Kb?=
 =?us-ascii?Q?phSZ2fz3Z6UbfYANhmi25GV1RsjV4IVLlrgrQGiMveQkrr6IxPoPHaPTbJqP?=
 =?us-ascii?Q?zg8rJP5jQq/cnRaIFN2SHrg2fb87pULTbVaguPYcNYBylZAeCOojLUuFMApN?=
 =?us-ascii?Q?e8eFyoyhDG4PmfCYRYtUH7J16a0PgdHdD/GWfPUSjAUsioFFSawwysdK2eIe?=
 =?us-ascii?Q?eI9Htm/eVuq3aiuElvp/XqKuZbzKW+s6QUEZgX6FXFoOWq/DQWxYrpGd0Igu?=
 =?us-ascii?Q?NuozBCu3ld572/vpP7R5Cl3+l72NvqU0Klol7OaXZEbclelXsV0A/C2q1nQU?=
 =?us-ascii?Q?cttfIMoZN5jEMB0FetG2M1Um33luyraHjxRDrVpUaTiy6pWgOUtpk5B5qaZW?=
 =?us-ascii?Q?xEC8iTDUhXLueNz5xluBx+YIkazs6ZX/FwpackUcsC6M7nIPkiDMkkFN6zJK?=
 =?us-ascii?Q?60UBBnv266RXmfvKhfVKZ7uaMX/ChPsTKjR8OXMR0W61bB4pvHaaiw3qEG8T?=
 =?us-ascii?Q?a8YUJS5dYsHN9K39GQICs7mkvfD8B01Beb7lbIG7zrENAiHLwSzI5UOv6AGZ?=
 =?us-ascii?Q?vCbZMSFOS4sXrljliqt5ee6gPVRhrAzIDJTbu3qIKu6cDfhOST3cFqE40IPm?=
 =?us-ascii?Q?jN1gQ+cVV29RwotxQ59p435+CcUtTjcL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zu0BZaC643oGSbzHFPafBCMy3naFbzhWIpCobpFhvpMQvJLKh06LwOHAx8nj?=
 =?us-ascii?Q?M3JGNJPaPVlXfB90VAaCJQtloYXyJnBK7GIn/Wqp6G8fuBqe8f1P+8vgWWF+?=
 =?us-ascii?Q?XhSsG5cbbzVsg2nXMgXdNqiHuYotFc1elncoAkH3jI5FF5vD+wzPK68UArTK?=
 =?us-ascii?Q?7/8R/uFKAYIejisjVrNcfTRA8OiUXdv8YrpBXuaQ3TuoL+GN+v1hbs0fuCPJ?=
 =?us-ascii?Q?UeiH+79TrhiKrWg32DZVySROMFDoQ/Vyl21DuJM0mwMsZTJkvpEst9fucZeV?=
 =?us-ascii?Q?aux+s/qjf4AmCrF+Exzst6H2xXavBb7WZh7kdjjfYWhR/PKhGvL49KTMZeDc?=
 =?us-ascii?Q?zTELmMjs+WYvYs8+k2W7fVildZmJmR67rto37J8bwrpzc19JvS3ZdkH/07Cx?=
 =?us-ascii?Q?ONrGciZY5tFLB0unAk42I0c8G1Xtnx7ZdprsISIESySlgP4bh3O8/AplnJ01?=
 =?us-ascii?Q?YneLm7L2gACeKCRXdFJ3DyqcGmvgPZnvtjbJj+DcNhSxaSUXrg6AmFphidL2?=
 =?us-ascii?Q?tq5H5NOD/yy6JWI8ha7E+tcz5nZgndq9kY3SmMWgb2i4qW33zmHxT6QBO81L?=
 =?us-ascii?Q?Y7v+Sb8IO+nFW7eWLiExyLCydriD0GtMXzucJzbAmfcpUkLiJ8g1Y4Ijt14A?=
 =?us-ascii?Q?slxxcLm/S5Qrbl7hVJMoPRSgjxk94qBY5A7/XW5TUD05WcBmDNtZA6YliTGK?=
 =?us-ascii?Q?FOKgK/dWoS1INXB/EsONOLaCsZ/6z9QSH6iec6PL706uDlX5GImKAgWBEBZn?=
 =?us-ascii?Q?I/4lqq/9UaWlnAE31T4QCejP5CH1AIJaYPS1nSVIZLfD/YZEomNY8JFSime2?=
 =?us-ascii?Q?tsRe35yCUFNg0C7qV/e23G3BYF6hYEVQ05NnyCLn1P9jw5irATBJl7N2IKLt?=
 =?us-ascii?Q?4oWzisudg6aV5VZXZDPk4PqKlOU1kVDkzaSEK7v3wAR4P8HCsMfsDxYNuWz8?=
 =?us-ascii?Q?/+OvdJdPmc7gWjY063VMERsq+c0rrBfk2xwHoRpAJW23W6lmx2+rA4DgLjVX?=
 =?us-ascii?Q?vRsn3hn+DIfg04Rm2z+tWmRRNqymQLbmudWzJzXBGkbprEuV0g1+PJnTt+RN?=
 =?us-ascii?Q?34O8p2rhvGjNB0df/u/hEzW0I3IBgztx+0UIhSLwXuu/02vuPxd6wSJTb5XZ?=
 =?us-ascii?Q?U4/WsvOjsrGGWTi6rtJGWq966GcF8Sx7itSrVJ8KhvUEiyOYCcVdui0WUvAj?=
 =?us-ascii?Q?rS8H/hFlF8T9Ss1gFasqSGo0+HG2JMQbSm1HgBp2iNovUm85+zqtjauZVUBF?=
 =?us-ascii?Q?1OmdkDXuk2wm8/gKavpt0BwZVvYePau/VsutO/aLmDJK06fkQEGGksJRck7l?=
 =?us-ascii?Q?ndaET7hKmmssEZIz9DaXVlklzsn35NS1vlllAbHfo8jDzi2g4LZGqaqtshrf?=
 =?us-ascii?Q?2IdJGncY8c2tfCBA053bF26OFgMDBvhaIld/WZvSkTfTX6MBo8n/8m/b4NBq?=
 =?us-ascii?Q?MPJCIRO4XL3248LUgwFSHXy7muQoO3Y4iNWctB4lDfCBLLPdPPnnRM6tBCBp?=
 =?us-ascii?Q?tjVZcpLfatVkn4b7ScfWvMXK1O9D1EZEiJp5vTwaFptDRwF0NGzAvJ+gwKSg?=
 =?us-ascii?Q?1T/HzA9IDMMjZboX0eQaGlJ02RR22oZeO9m1nVNp0MlNGjKFzil3dgFvGx0J?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d528de-0028-4cd2-491c-08dd67a0d361
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:17:39.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO5lOlLM1Eez+Nl503Z1RNo5aZI/8rAqvWvikJnhUHGzBvoxzcyq86degBaSociO3QTrYffaZ5p4RvezVfjl2ktushaZT6cXt9UD/tQHnXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8379

Hi Colin

On Wed, Mar 19 2025, Colin Foster <colin.foster@in-advantage.com> wrote:

> On Wed, Mar 19, 2025 at 01:30:53PM +0100, Rasmus Villemoes wrote:
>> As the comments in ocelot-spi.c explain, after a chip reset, the
>> CFGSTAT register must be written again setting the appropriate number
>> of padding bytes; otherwise reads are not reliable.
>> 
>> However, the way the code is currently structured violates that: After
>> the BIT_SOFT_CHIP_RST is written, ocelot_chip_reset() immediately
>> enters a readx_poll_timeout().
>
> I ran this new version and everything worked - and I've not seen an
> issue in previous versions. I'm looking for guidance as to whether this
> should include a Fixes tag and be backported.

Thanks a lot for testing and reviewing! As for backporting, IDK, I think
we'd at least first have to know that it really fixes a bug for somebody.

> Great find, by the way! Is there any information you would like from my
> setup?

Certainly I'd like to know if you do in fact use a SPI clock > 500 kHz?

And if so, could you try inserting a read and printk of e.g. CHIP_REGS.CHIP_ID
immediately after the fsleep(), but before the re-initialization, just
so we can see if my theory that the values are off-by-8-bits plus 8 bits
of MISO "garbage" is correct? Because that register should have a fairly
easily recognizable value.

Thanks,
Rasmus

