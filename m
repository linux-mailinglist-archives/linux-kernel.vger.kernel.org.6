Return-Path: <linux-kernel+bounces-568733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70810A699DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8997C19C2C31
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39791214A9B;
	Wed, 19 Mar 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="Dfx/Q6pf"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D752139C8;
	Wed, 19 Mar 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414127; cv=fail; b=D6DoYhHLJw6UnmsUwOJSpoY64OHT+fNVNQmN0NeMbfn+nmVYEEsTj2lc20MFicDs9kiqPwkpyRRkc3FwllT3FTOHUBWHjmJIMcwTkSWOIkdsGsvnc6ZAag4S6zVcFFcg8cQph6w2o/gq/LjJH/KrVtanPEnhmVJsd4Z1g/UOTpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414127; c=relaxed/simple;
	bh=1Ixg6R941o3PR3nzqIhbiC28PvWWog0V/BnMlcs2Aw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LcTyp37AtFPBuoIdR1gkLK2kIjQkLWKPVgOiAWkw7wxnNlrM2qNfmJLr+4LNvKKgs3eoxuUgZtlqQT9gQVEAcEbKSyyAAomHf5Gftqi7JQsfkGWoOZVXyaPU8fo+54EMbh3gkGvtQ6EPIv5BGZGqqH9bDKPU3mIVdxHEjWUtEYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=Dfx/Q6pf; arc=fail smtp.client-ip=40.107.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGg1aPc0H7ZIlk7rjuL2fK2XyzwQdR9N46PbygbI3iwToAnbmo5P2jl6wr+74fAPIXamKX5TuPxuF+NAqvyJaUssDnhdpVSNRD/cYid/5UtCN8523VsbhLKelYdIGN6qgKvMA4kTTvHP766bpnebkQ0cqOfN6D/cfoUnSokRYPfMrHOxpkPLF1NkqV6GmlPYUbD2FSENHuOk6yXAXqsLwr2XqKugJqpiFKaSClbCQzA2f9s3lHmIpIvFH1ElpAzeRkhwQ3FxL0rzsyXVjOvF3byHYiwnc2dtbtn0/87o84D/GsupnA5Dsy6qazEE5J/kSUnVPyFNNoKwZGkblC8pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ixg6R941o3PR3nzqIhbiC28PvWWog0V/BnMlcs2Aw4=;
 b=NUvY+3c9lHsl78ckMqzpkrxnSGcyb1sy8gQ5ZVREmcRaVXENtEEln8d/pVx4mSrKkmB9/ggI4tgtvwInHAd+9KHDZy9T8ZPWN4hIyi59shR9lnKYq7G8BwO/YoF2m0ShbBGClc+A79B7lFrd49cvqjhW91kKSuazHosHJZP0FGcAWvQnop2raYE8a8/+EQsGqZMdQ49TOOo8MsWSxr9z4t/KJ26ANkqqOAcR3Mcd0TTIQJcmnLDAsLgERkrCWWKAbrhcdvjto6XbyzK6O58NRu9f2wZ5KADrRss715Mi2ahgKocAcDtK33R5172Nt0ZaBvMxzcSjPhadwQq0RFCQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ixg6R941o3PR3nzqIhbiC28PvWWog0V/BnMlcs2Aw4=;
 b=Dfx/Q6pfLPm8Dp19/VKPjYzbhkHDWM5p9VsyjJJS+eLbqi5eOwv/6g7gSp3W49H0UCk6CT4M+RS/vETCkmvFE3LFbjtvuhkqePil12256V9HRZm0ylrJnXHB6cke/mqx3XTV+yMttARZAPf3BDHCwtXq7dj19LpgvOovbnoZaUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by SA1PR10MB7664.namprd10.prod.outlook.com (2603:10b6:806:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:55:22 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 19:55:22 +0000
Date: Wed, 19 Mar 2025 14:55:19 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 0/8] mfd: ocelot: add support for MDIO managed switch
Message-ID: <Z9shJ5_ixKMCGPyy@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|SA1PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f71c2b6-eb46-48ff-07ed-08dd671ffb6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YLkouwzxuJkYAMDJDYaqX0GvkzDW9AfFPshL6duFXlTHS0wj6hg6bMbepABF?=
 =?us-ascii?Q?hI2PZBy25VHHixSBjk64kTuLas6ZBsWnlCjmUD3lq1d7hQYsndGnTccdA5nO?=
 =?us-ascii?Q?3SFrdjsHI/Lgg9B/iWsGFQrDsoQo0m+k9K0hJYThj/CEcCYbYKlPNKzY4gVQ?=
 =?us-ascii?Q?cvNEfTwqaURZjICwyjcOcAV74qsNMNF7ToyqT4krukj+jUEwuJnUeBdrDxHj?=
 =?us-ascii?Q?C9hehIq9/qzLfy09+19QxX9rfYDNnaKipC1aEY2pnCLdxBq8mHZOctrl0tjk?=
 =?us-ascii?Q?RxfXf+GIfFj22RvHwvRVTxaeb5ep+TH1beWvj/0E11bxVlUrHS6ACTC0Vcx7?=
 =?us-ascii?Q?Z96+3b4wsNA4UyG4r1Mc/LbiR0jEkjavDk/x2K43bXbPFziNZZetP8IgGZkF?=
 =?us-ascii?Q?3eY0IHUFFDVQb5n2O+DEfJAPCAPr78MboSlfHeGJNyKiJMoCmgifW7/o7zrl?=
 =?us-ascii?Q?AcHzhzE9yJoeWTc5/DsksBpCrAPGiFDaTR/tRcsSKlyDtE7LqQsRnmy767+J?=
 =?us-ascii?Q?QABN2YrOm/dMdJK09nEAdiGUPB1a3qmWUvGwiawCRlBclcRZbg2yUjCsXW2X?=
 =?us-ascii?Q?xYSuCkQ8jFBMByXoVs45SXKjGb5fuYxUf1khGkJhZJ4Ljw43pNp1TmpI7rWG?=
 =?us-ascii?Q?uylE6I59iCBZ2dHhfkP+kZbl4OvMz8SiiEolJokA8I/zDlaM8nuRze3b/68O?=
 =?us-ascii?Q?jBYE5v98xlWj88hW8bxLcm7DzZaxoMF+SiQ7gyxenbR/WD2RVmqoO0p08UXQ?=
 =?us-ascii?Q?5A8Kl2b206cLM6X1vOuK32S9NNRaDZ0aRXTX1Mph3epb92tLIzvfHNXjcZlT?=
 =?us-ascii?Q?sqoPvUWUYOOerAmUmEtNY72027H9BEaMVb22xQvkj5xE0t3gkDeWACs1SAix?=
 =?us-ascii?Q?QWrrPQ76EOTfSj+5R5K2IqmmbMZpELLjypTffk/gJAM4uZB6gKm7Q9yMxa2U?=
 =?us-ascii?Q?N4Hr7IWE7BtWgJ5/eHcg05KGeYFa3sIOCBQWOnwd2ASK1RfZ17Zn7agpL8GS?=
 =?us-ascii?Q?7TVvap6fACcHWwPjX2mvJpYFIw+8FNRIwKz050fZp1W0TaJ2mqhz5x/51pyS?=
 =?us-ascii?Q?vgfPYWby2zpaGtAp3gTnytY+AMlfiUfYz+Bl+qHatsGkz8RrCNdczTcK+lSh?=
 =?us-ascii?Q?6y1ji+dE9L2vgGq2/h5a71+LXOhjfX/kHH8gzWVpfV44PPXDEvTbvQv+Vr2a?=
 =?us-ascii?Q?yVLO1a0twq6GrFhTkXhStMYHOOW9k5MJ/DeH+LSiMMXEiDqYSvvtgDggHYV6?=
 =?us-ascii?Q?MwRW87lKBn7idfXTFgUqnHb5wCn0/G6AWfGcerCsvnMqpY6Vpne3oYw0I/jw?=
 =?us-ascii?Q?bjxF3m0JgXML2FBKD3CB4GKeLMYTOX33StfJGHrSBHWN1qyGzfPA0YPcUofU?=
 =?us-ascii?Q?HzEmAyvOx9JzqlsVAp/7HflSNuSY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OIiHb0WXIotXs2npWwSAK4HFOIhHML1qBX0vyVF+EnwYDf/V/adS4kzHl1RU?=
 =?us-ascii?Q?h5JzQXwJp61954w7GsTL7qmShMgDaq8VeahC4An1jg554zKRgYLPwzwiotcT?=
 =?us-ascii?Q?IZPcQTByAgpT4dMBi7QvMkBLeDAeeKf+v4d5pwIR8CcqcfTMIuqOwN25RKKI?=
 =?us-ascii?Q?VefjfWGTKGaapjWET0KMQfbyZFoUtyG/8voajqTC18FuQ08yR6NFgoRHhT21?=
 =?us-ascii?Q?s0aRkDTavAgll+FMpPmA+qTv9D7SijWVtj46ZyOisIV+ME42zD521fq6Vn4x?=
 =?us-ascii?Q?LpYG/PXbGh4RnE80mtT3DroBOtbXAe+4Y/DSX2vLbigAtzM4seZFoFfVr4WO?=
 =?us-ascii?Q?qvnBhhLvoi1ho3QXwpgORHvF6yfBdtUyywdT/EcsaA0+uFveJOJrIjChFyj8?=
 =?us-ascii?Q?2AjtQbrqKrMK6pxMVUewXz5kI3eikaVUntE0uDA26CgDtt/X7Ncudpww7HMb?=
 =?us-ascii?Q?slcljdOSOFGt/pHohigG5bReSDHW7/+6xpSx3DBIgr7+kDEfu8C2IQmmJGUH?=
 =?us-ascii?Q?+rABxAHDiB421Smokq3hczy3TR+blQvs/wnaGgzVmxzgKWyRBeguwMN4pF3W?=
 =?us-ascii?Q?rPnS96cPXxX0Dc4tbkxdfuaTDMNlH4+nHLtYDCGzmoUZmzaIKKZkS4Y2Mpp6?=
 =?us-ascii?Q?76cItxSNrC01nWrwSnHIoWUDJXDBkzCQKnc2ozbUiD5k7OPotZV7A3YyHff7?=
 =?us-ascii?Q?d5Rjusv3LC5rgSOUjX5JT/Lz94o2V+vjJC4WOejD6XJlwp+x8Hj8A3xL+7vR?=
 =?us-ascii?Q?Ug7jHfEpNxnwGSI2GHez0WPLZJ6f16wz1u0CQUQ0Vf9EdYqyaWfZMk2/APsV?=
 =?us-ascii?Q?1aYBzwUg2BwZVEcjI50v+2ienNXq/p6Fn4z/ixn8bxdIWJEtTjm1t+1Yzp0v?=
 =?us-ascii?Q?UIgFQhSCsUjNXBR84hu6X3/4vq3uekyQHkC7TdQshXSHH6CFv3z7zvCMNBid?=
 =?us-ascii?Q?jf8fdwOBl3xajufOV8n5GfCz/GNoneggKGCmFNGzQOHAFZoxEvoITY2kRK0C?=
 =?us-ascii?Q?kQF+VfxAL/sRXi5hs8WlekMaZGUW6DnKy7nkLDIOb/gW2jUp/I+TuYp0OKvS?=
 =?us-ascii?Q?Ommpir2dARHR++pl34k6VpbLyxA2Kbx8kl1NJ6sG5VqvbVCYxV1CY6aiWEIm?=
 =?us-ascii?Q?OXQBHOqsP61Z2KYxiHovquBSP3CoktEZirlVjvFad/EPRRDuSQ7cIOt9Dlv7?=
 =?us-ascii?Q?HB5FeOnIMvJKYAKdBXhJiYdZSMmPqyyqt0SqinD3Pbg6Erp8fG7fA0CNxOys?=
 =?us-ascii?Q?hluB9ngtsLoL8Sxgx9hQ2Sx9xUvAcXtAh6TlM3qylWqsTAytN+V/KGjlIdVg?=
 =?us-ascii?Q?lASI40k72d/8Cs9rSV5gqQoqxw0N3d5jHh0dJbPMnXJypysvp12ELCvc70Lz?=
 =?us-ascii?Q?zZ/uKjqHOyaCvGkiYhOJRnfrmg32GHTesT4mMN0PDkt00VFitwVtN0jKTiH+?=
 =?us-ascii?Q?kCNWatjFHQl6qr8Bnb8mdQfrHiGqQMDHtGVOZLBPSNI8xB80FlENkqR5k9tG?=
 =?us-ascii?Q?PvRPc0sX189s/FR9KDiteDWh9pbXHM2blY8Ct39eikc9ZB81W7f9LdQVYRsK?=
 =?us-ascii?Q?lxWjKF3kacu/T86UidqnmulWAD6RRPDuW9jB/wzioOBKt6ks5UsxtXLa/I3V?=
 =?us-ascii?Q?jSZCRgXQAD8gSwh+vE60+s8=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f71c2b6-eb46-48ff-07ed-08dd671ffb6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:55:21.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or6pKZoWJuThhZgo/Mz8ej/W2mD7mcBAieuFrpO/OIB9DpxImRt82gxTRHZ7rDOed5RSkZqF8MSaIYMJrSTaslAn0lOyKVrXgXb0QCiL4k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7664

Hi Rasmus,

On Wed, Mar 19, 2025 at 01:30:50PM +0100, Rasmus Villemoes wrote:
> While reworking the spi and core files to allow hooking up another
> underlying bus, I found what I think might be a bug in the SPI
> implementation, for the case where the SPI bus is set higher than
> 500kHz. But as I don't have such hardware, I don't know if the bug is
> real, nor am I able to test my changes.
>
> If desired, I can drop those changes

I ran the patch set on my setup and everything worked. I was hopeful
that it would solve a power sequencing issue that I came across a while
back. It didn't, but the logic works and seems sound, so I say keep it!

I'll review my parts and add the relevant testing tags.

Thanks for the update, and I'm glad it is being used!

Colin Foster

