Return-Path: <linux-kernel+bounces-436243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E7B9E8326
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 03:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3915B1651AC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 02:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26451DFFB;
	Sun,  8 Dec 2024 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="UkiUAd4c"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2051.outbound.protection.outlook.com [40.92.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E44C9D;
	Sun,  8 Dec 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625139; cv=fail; b=YGq6qHJszXyVEbqcuK5WqXSujfmTPcwCNF2lL0bBc5YCKkhTvC5zWkbShR6VKvOrLoyy9mbo7lXh6sXBiL7q0b4eg4nqjGreSnECYvxP5AiuY2PU54Fof1Revm9/9OUF/eSYjsxp0fDoFQ5osiJJ3+wILfT46WaKYNbnDkzN+FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625139; c=relaxed/simple;
	bh=yXuNib+QNPB8s8HSvOgTkHq8fPSlr/ZcD6Q4eVZt16w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQqDjxpf4ktohXTbIm/1+HoSYJVFFtmBvmomrXLz9rJTtrHmgksnFjM8+2eciV8BGi6D+nCZx67IEY34I1wEerhxU1BAhqYoiB2P+PWsJ96r/9HaY1c6HCSdp2bbLTTpo2247nSNhkadl6NAN6sAHbBKgsLh4L025iRveQNIkA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=UkiUAd4c; arc=fail smtp.client-ip=40.92.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biajo9MNc/znrZjzdm5lz7MkCWXAIxO749WlNNrivfWnLO9k6oulENSkWh6Po+d83NetM7QlXZVCQxXDmLUEW7FQLLj672BP/2+VS01QQWmYO2CVg/rOUb82NyuP/6+shCRF0LWrwQq0GM8GbmGXgkkDJPJ+9UoAbOLTK92M/GBCVVoZe7hGR3AYuvNhQCkhFzt6Iafj6Pq1ulpdEhehBb7wAuYFStTGGur/V4dmDg0Va5V+t/d4jq3hL+nlNZgceTsJ2oOJ+4G+V4c1S3z3TmPaQ0CZKiRM2MqiyQq8d37DvfstWXu1b9ygMA2pl7smOTJrRcjoN+2ob9f+BiuS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr1OozNAKDWcK53cPMeCfAh7pKZ6dopUYdnSBlciWUU=;
 b=v8AcJgqVwDICaTU8cLOZ3E0VllBRTIRpPZr0xd0WhrTzWTXuKJtSIxS4FKa0imW9RFJEhzNpR8s8haAmry1xzOCRz5d1Z5Tjly0Fn+yD4HAiIMF4VkC0/+cRho8gr+vtntRUA82qeuB2jYeKVnU62K6lC/fg+WkyUg1nXAH0til/36zehK+2+kA3s7uZ6EgiNuJzewwzxWfZsTAs9+1G6L/ljwqUMZcBh89LCGWl9jzU3+d1G7v9YFBll+kZexF49C+POJ1LLLKPas80cm7aoht50gfBqecuay0oC52deKVRQkNIYJxIfeU7iswN8gcC9h4maHF2k/Xv4d3q02ReHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr1OozNAKDWcK53cPMeCfAh7pKZ6dopUYdnSBlciWUU=;
 b=UkiUAd4c60ElxnTLkafE5dIjdWP6l/NumCYxCuOLL6WI1Xgm8RPm9LGfkUq2cv2ZApsRtEwpbkC7wR2lsorkEE/nbyjKJL2MMe8KtUPl9qxt+0FtCY3kRlboYmhlzjkNQ69f6oJmTuzgJn40YEr0OBoXdOTGdbVpz8NlMmBLihbXWMg2NoP90R2qvNi8TK5OhTE0QBMCndcZbLXzNDfAGh6g9ZhzXGCdSNmHQRRpBKWT9bomy0WYQtdwoAbt4hsPpnaswsEAxoYaTyWcQW4Ce1DycPpwCZa2nV6hld0xnGoytmJeYq6xEhVVabnnG6zTjoGwkfR0DFJ0oz+a9cBTew==
Received: from SA2PR06MB7658.namprd06.prod.outlook.com (2603:10b6:806:148::6)
 by PH0PR06MB7606.namprd06.prod.outlook.com (2603:10b6:510:52::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 02:32:13 +0000
Received: from SA2PR06MB7658.namprd06.prod.outlook.com
 ([fe80::26e0:1879:9fd6:d111]) by SA2PR06MB7658.namprd06.prod.outlook.com
 ([fe80::26e0:1879:9fd6:d111%6]) with mapi id 15.20.8230.010; Sun, 8 Dec 2024
 02:32:13 +0000
Date: Sat, 7 Dec 2024 20:32:09 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Philippe Simons <simons.philippe@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: Re: [PATCH] Update H700 opp values
Message-ID:
 <SA2PR06MB7658AC3393BEB29D946EE508A5332@SA2PR06MB7658.namprd06.prod.outlook.com>
References: <20241128154556.2743839-1-simons.philippe@gmail.com>
 <5b07cd47-868d-46a3-b365-ccac2a68b792@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b07cd47-868d-46a3-b365-ccac2a68b792@arm.com>
X-ClientProxiedBy: SA9P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::26) To SA2PR06MB7658.namprd06.prod.outlook.com
 (2603:10b6:806:148::6)
X-Microsoft-Original-Message-ID: <Z1UFKfxGI8lca_vz@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR06MB7658:EE_|PH0PR06MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 108153a0-5112-4298-091e-08dd173085ae
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|15080799006|7092599003|461199028|6090799003|19110799003|440099028|4302099013|3412199025|1602099012|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pCdUwUvIdvlVMEomxGKMVmEto8j3IEhLsEpPDJaEhRxt7z0gwpVx9HOqvUvs?=
 =?us-ascii?Q?SQCA48QxzCmWVO6iCxnYiAF5EH35ADwXnL6dzvFCeFf/bT7gJEbjuggWpGLK?=
 =?us-ascii?Q?Yjs/Tk8IWTxWbSjVxNjknGSBrAWntj7vpCawWEN/ZRH/v1MUd6HDCIHd/fa1?=
 =?us-ascii?Q?Pmvezy/pEUbNhWyK+uN1ooj1qWS2399AFb1qtnr+NPB+Cwd+aDEECs4uDlPM?=
 =?us-ascii?Q?mc2060+K36eLFaXs0E5wOcKiklhT6/Hqb89P8NRWTHEN3tlpK5MCvZ2QQcbw?=
 =?us-ascii?Q?vCUhkp5sPdxnJ2LQNxq6p43JIfYTEatmKPBqMYePbsxjS9M8ybHENCKpKJX/?=
 =?us-ascii?Q?4LOKNHp77Az751Uq66ULxpm90mR1h4RAJ6Ap3iVVz2MYVuI0WS/ezvkGxn8W?=
 =?us-ascii?Q?LjSHLchQ8hiFWK8zDj8Ef7HZqxb5W5EoleyQKOndNe2dB1+NdKfjlBoEqyAq?=
 =?us-ascii?Q?UVkbQKDsFNKSeZVPlc/6yI1qyerKYhpnAR7SLCpWIwbXirLYluIzDtHpnlk/?=
 =?us-ascii?Q?4uBBidOm1r5KiZ24uuncaO5kYLPwui64FX5Nw9mXOfPfFrrmaK1+VO87FQa6?=
 =?us-ascii?Q?wDjWvBIhxjrdkpbzkIHz0sYbjX9/fLLqAwx35JvX8VlRuwlzVIvS13XW0177?=
 =?us-ascii?Q?woOgnORvSi0x+s0wYysEet4FjMXWn6U/xzAvYbp//TaiuCz4/p582bq/2jSi?=
 =?us-ascii?Q?GLPmrkilldlcbm8Qf/3U0WYC5Sb9n7a73PREJ6sY2FMFdZKA3VVgntkCgHjh?=
 =?us-ascii?Q?86Yg97u7lRzZbfzRaq8VSysGg81UI1AyI10mGZb5l2BpIy2D42HUUQj7T5uk?=
 =?us-ascii?Q?WYgJBRF6KZspQa6Fe8AnyjtSaEpujGfJrB6Hl2xrlhJQteuuEL9tswpuHp1B?=
 =?us-ascii?Q?7DsrBKNp9w4mPRqKWKwwfa2xN5JaFDIgkADr6KHOUjWYRB7Mfv+i7yGBCQ6K?=
 =?us-ascii?Q?N1SiO9bdqjVVZi/xiskru3F3+uCxiJlqWZiZTPbjuny1j+aANseGECILnLre?=
 =?us-ascii?Q?rixQHN+24NoJIQjlzyWUw2ucRfySOauo7Xslcggap4aogaOr6o9cdbA5O4N5?=
 =?us-ascii?Q?G5freg/ggZZi7ioX6PD0kCtb2jLHXLzF8IPaALKN0NIsuBRlpW8nSsLdLksd?=
 =?us-ascii?Q?rRji+/cuJziSnHQbyYpPXDvvpQ5zooq93CW8pxW2Vk3d7vIxSZpNwUdgIDZg?=
 =?us-ascii?Q?El32fWc+0BgRVNguwUlqoVULpbEWuKGE6uuVtYXRWvXZCRob9KxftXWteZY?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mfv5ja97S+mQ696x8lnIETD+28xuJLfJ534xVaQEP23redKRvgNg38dK4HCc?=
 =?us-ascii?Q?BSbwtwOUlN7Bf5u9FsPjpHURAO0I/1LCoa6KmwI3EX1a9B0Kyu3B2GEt4S8B?=
 =?us-ascii?Q?A7BBDRMpKYN4aLe1u2fu9rXhUSYGIKuJxdb0IH3l0xa1isEn5s4gvA5XXRlW?=
 =?us-ascii?Q?zPXqKuJs9tfA+6H9GvvFVoDwU0e83wD6ezMuV06TFmg3i1PPhczZTL6q51he?=
 =?us-ascii?Q?/zbGMIyScoEM5lTLUpM5ueerbYkquf1pexM80znQefUQ7IGT6oMK866ydbhP?=
 =?us-ascii?Q?wyjn4eq6uAkI1vsVYox0Nz6WMMpL1Bvk11WFzapttYpOIQYrTlIqX9h2a0Rw?=
 =?us-ascii?Q?4mBCF2rWzmrtINL1FUBI1XSCyuMu+yJ1RnQuiT5ozYr1AIvb7bGG/bFi07s/?=
 =?us-ascii?Q?J8bBJhYrXBGNzFIPe/k4uD4ENeGaTLHX4tUG90l6HPx/pkQmckF2mSBsQylx?=
 =?us-ascii?Q?WR+xZsV4b32dPEvTBtVRFxZFozLB2hjkJgMbCHT2mhCIWc6vwD7pEXAh+hoI?=
 =?us-ascii?Q?VnJcDPjPm+8gHqBqaqct5IGgfrzbZIQQh9VcE5jZKLKt+HvOCPqG/Seh8pVw?=
 =?us-ascii?Q?U/lmgIejDsQZQemusMmtKEeaf0ejiZ04A/stRmks3IZu6aTjzxXB4eRRBC54?=
 =?us-ascii?Q?I0zBmKWJHQQZ9dv1kOqjRgI9mdrifLtL6me+WhXWmPpEOOPg/ZZKCwergarh?=
 =?us-ascii?Q?bweBtkPD3jWGI6/nZ0BXMASYdBw76MGb8YslDDPui7b0cprxOlv9cGmI3rwF?=
 =?us-ascii?Q?EiNPDCWjhxfFhf9N9kyJYHA9qV12T7xQULXh/W7309OauTe7w8dYZ4nxR6OZ?=
 =?us-ascii?Q?4Irp6A1qtQL0YYCVIA4XAiWjtidSuUlrPRTK6wsNzBJqHGV0IsXvAXGOgx4v?=
 =?us-ascii?Q?94LmgORfkGbrNFkDXieZcJL/WDlV0rlzjHAn16UqhicSN8oP2OuJRFEzofXX?=
 =?us-ascii?Q?kU9af1YqSuPfYFAfJjHrmjDsAIb8fgnfl4mbC5BJpajWuX4XOodMfx8sZvid?=
 =?us-ascii?Q?iRgxol8nDKDi1Ge+SDP0ceGplIcSOYtoHLc0IqQw9a4Mjw4c6AfF3ZWLW6dJ?=
 =?us-ascii?Q?bp7B28Mc6h3fa8FGwR5vIorDQehtulxBQEEvFO6VmagKN15LRwSw7ulL89wB?=
 =?us-ascii?Q?w/fVqa9dVQeL5xap38KXkiA3WoxqFaiQdZSNOUNz5VwTRVW9Hzg1pV/iNsEP?=
 =?us-ascii?Q?Cda/OFCLTNOOUamYMjNI5l4ZwXrIbdsBBYC8jhmMs3MISYRiw5NSaMgQzCji?=
 =?us-ascii?Q?JGk0kR5bm2sDLrXTk9VrV3wLK4D1/z7p7bUEJ4PRvd8GwfRPcr1vW5I640A3?=
 =?us-ascii?Q?dqA=3D?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-46441.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 108153a0-5112-4298-091e-08dd173085ae
X-MS-Exchange-CrossTenant-AuthSource: SA2PR06MB7658.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 02:32:13.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7606

On Thu, Nov 28, 2024 at 11:23:31PM +0000, Andre Przywara wrote:
> Hi Philippe,
> 
> thanks for taking care of sending a patch!
> You would need prefixes on the subject line to point to the right subsystem.
> A "git log path/to/changed_file" would give you the prefix of previous
> patches, for you to copy from. In this case it would be:
> arm64: dts: allwinner: h616: update H700 OPP values
> 
> On 28/11/2024 15:45, Philippe Simons wrote:
> > My H700 (RG35XX-H, RG40XX-V and RG CubeXX) devices are very unstable,
> > especially with some OPPs.
> > Crashes were fairly easy to reproduce with any dynamic cpufreq governor
> > and some load on CPU, usually in matter of minutes.
> > Crashes manifested randomly as simply hanging or various kernel oops
> > 
> > Manufacturer (Anbernic) is using more conservative mircrovolt values,
> > so let's use these.
> > While using performance gov seems stables at 1.5Ghz, it still crashes
> > using a dynamic gov (even with Andre reparenting patch), so let's drop
> > it for now, like manufacturer does.
> > 
> > Signed-off-by: Philippe Simons <simons.philippe@gmail.com
> 
> The change itself looks alright, bumping the OPP voltages by 50mV looks
> reasonable, and is a no-brainer if it stops the issues you have seen.
> 
> The loss of the 1.5GHz top OPP is a bummer, but stability comes definitely
> first, otherwise we will just fail faster ;-)
> 
> I would like to hear opinions from Ryan and Chris (both CC:ed). Did you see
> similar issues with say the ondemand governor?
> 
> The patch itself looks correct, so for that:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> Cheers,
> Andre

Issues I've seen with the crashes seem to have been resolved with this
series here: https://lore.kernel.org/all/CADomA4-xTcPyFcX_qCYJwoi7y5vfYmzOfF9iO5MKgEzZdpbJCQ@mail.gmail.com/

That said, I've tested these changes too and noticed no issues with it.
It didn't fix any of the issues I've observed but didn't appear to
cause any new ones either. I'll add my tested-by since I don't see any
new issues it introduces. I've been running them for the past week
while I attempt to solve a new regression for the AXP717 in 6.13-rc1.

Tested-by: Chris Morgan <macromorgan@hotmail.com>

> 
> > ---
> >   .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 19 +++++++++----------
> >   1 file changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> > index dd10aaf47..ac13fe169 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> > @@ -50,24 +50,21 @@ opp-1008000000 {
> >   			opp-microvolt-speed2 = <950000>;
> >   			opp-microvolt-speed3 = <950000>;
> >   			opp-microvolt-speed4 = <1020000>;
> > -			opp-microvolt-speed5 = <900000>;
> > +			opp-microvolt-speed5 = <950000>;
> >   			clock-latency-ns = <244144>; /* 8 32k periods */
> >   			opp-supported-hw = <0x3f>;
> >   		};
> >   		opp-1032000000 {
> >   			opp-hz = /bits/ 64 <1032000000>;
> > -			opp-microvolt = <900000>;
> > +			opp-microvolt = <950000>;
> >   			clock-latency-ns = <244144>; /* 8 32k periods */
> >   			opp-supported-hw = <0x20>;
> >   		};
> >   		opp-1104000000 {
> >   			opp-hz = /bits/ 64 <1104000000>;
> > -			opp-microvolt-speed0 = <1000000>;
> > -			opp-microvolt-speed2 = <1000000>;
> > -			opp-microvolt-speed3 = <1000000>;
> > -			opp-microvolt-speed5 = <950000>;
> > +			opp-microvolt = <1000000>;			
> >   			clock-latency-ns = <244144>; /* 8 32k periods */
> >   			opp-supported-hw = <0x2d>;
> >   		};
> > @@ -79,7 +76,7 @@ opp-1200000000 {
> >   			opp-microvolt-speed2 = <1050000>;
> >   			opp-microvolt-speed3 = <1050000>;
> >   			opp-microvolt-speed4 = <1100000>;
> > -			opp-microvolt-speed5 = <1020000>;
> > +			opp-microvolt-speed5 = <1050000>;
> >   			clock-latency-ns = <244144>; /* 8 32k periods */
> >   			opp-supported-hw = <0x3f>;
> >   		};
> > @@ -93,7 +90,10 @@ opp-1320000000 {
> >   		opp-1416000000 {
> >   			opp-hz = /bits/ 64 <1416000000>;
> > -			opp-microvolt = <1100000>;
> > +			opp-microvolt-speed0 = <1100000>;
> > +			opp-microvolt-speed2 = <1100000>;
> > +			opp-microvolt-speed3 = <1100000>;
> > +			opp-microvolt-speed5 = <1160000>;
> >   			clock-latency-ns = <244144>; /* 8 32k periods */
> >   			opp-supported-hw = <0x2d>;
> >   		};
> > @@ -102,9 +102,8 @@ opp-1512000000 {
> >   			opp-hz = /bits/ 64 <1512000000>;
> >   			opp-microvolt-speed1 = <1100000>;
> >   			opp-microvolt-speed3 = <1100000>;
> > -			opp-microvolt-speed5 = <1160000>;
> >   			clock-latency-ns = <244144>; /* 8 32k periods */
> > -			opp-supported-hw = <0x2a>;
> > +			opp-supported-hw = <0x0a>;
> >   		};
> >   	};
> >   };

