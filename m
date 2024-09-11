Return-Path: <linux-kernel+bounces-325698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D9975D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33200286181
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF84B1AE87C;
	Wed, 11 Sep 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t/UV+lHG"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2020.outbound.protection.outlook.com [40.92.41.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B911BB68E;
	Wed, 11 Sep 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094695; cv=fail; b=NMNh4DhZahnGHtsPivGW2iEO04Y2q1Q5gOmIeWIcg9/IMZCX1H8+jTh1uRm4D9Li3rDlW78YBDriNO0LQwAN5CXsvEcCElQozvZWt5PZiSCJLPjG/66agXsnIIl8IOIm/yfjWehdBx0Ji+F5GnfaC5m9gx/Toihg+U7xHNxNnsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094695; c=relaxed/simple;
	bh=talHXsgHnbybQDU5I9Nmk2AfMkD166ubxs9aCX83pYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DvH7cqID5HVXqX3SsJGBKwnKckQg/2hxNNBv6qFbBXisAZN61QgbNsZWLhf7iT/6Fq+5/HihpeGhpIZx2boiSBNu9mnZZjopsTUxAvZqS2aExGS84IgYfqE7QCi2sO0IxywouR8l3iZD19eQaSv1/YHBtwe0DxP652SCGlJGnqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t/UV+lHG; arc=fail smtp.client-ip=40.92.41.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFdk/jZy6rLMSytmC6Y/M5y5h6WjKQpyP9RLAxxOr/ULOKe6LgS98TCNBGpUf9XyBgXLpHwVHseUXoY14Haw4TJ8Wfelmx1oIfQmvHs9mVnYkbVAc3UoZ9lu1Fz52t6x7ZVlkILFsXjOKlIjbd88tslGSb3+M8W6b/emQpAo5mHHFlanwfOGNXtlWV7rLkonkHIeTIkos5aV08R/s2aKvaQsmCfUWNa8g/7YlX3Ddn8PBdg3R/rC29IQbvhU5a6LNLCJOlOja5cH/nWzPewDeR4UNQbC9KmolDpUQ85bTqSMABoau9vqYPFx5KIyTQR4d/Wsl4NXeluLzY9Eav6mIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWkhfnzDeXkjemyReXaYq0CIyPuNtgCRYDMJlbiyciA=;
 b=rcF8eeLVS807I0Sxx8/JE9ood/WeWnt2GKPigaJw5fCCPAq0zSOeTbee2lBPSPuht+bjTAIf5UY71chYOZQKcp5WxbSqwGo1wbD/jtrgGWeRXe7sc7lMMsaRRLmmGa+BO8boKS+0658zGjZDIq73c21MJlCeE+L4yMltyb7n8iO+9ZIlMhNRa3cAwKvDI4YL1rulFBWOIY22zFRzkI99tL0SD3RIXYUiNDNEkZPBYetcZXGE17Vau4LsF/dMfX1ZptcdXWBYeypVdYAzakcxEV+n077XQaIoDUgJWdmVbm+I+9PdunVAZuXzmY4D9/zZ0QEZNBy2wJPhrtnXCdnIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWkhfnzDeXkjemyReXaYq0CIyPuNtgCRYDMJlbiyciA=;
 b=t/UV+lHGS21QXYLLnYYpoC22RTiOxcPCledSgwVXsI5pDVE9lA2RGY3Ut0EhFsvbr9ft0D4PR3pTUiNX9OzViVcB0+63wUORHJcnRHCBXcNGAvEO7t6E+za3yKpSAgGcxVSW98/UGNsNhkAuStwJTiAjEIftsBqU+coZ4g/LzSkdoNRgL/Mbmw+d2xCuRwOGz7bkA1afyykAd/01AL0/4gyUZKNRB28lFZEtBNhbFt6AOG4BKVAQT7vPtJLFV1bmb7yAo4rGV+MsBpDe278bR0ZlqOibWg6BM54MslAYcJew1dpYyQOJoJMTlK9R4d0jz81+9gyHfu4N1dZuixCqgQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5877.namprd20.prod.outlook.com (2603:10b6:806:34e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 22:44:50 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 22:44:50 +0000
Date: Thu, 12 Sep 2024 06:43:31 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Haylen Chu <heylenay@outlook.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] riscv: sophgo: Add pinctrl support for CV1800
 series SoC
Message-ID:
 <IA1PR20MB49538A046810421A8F24E346BB9B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240909-prowler-renewal-0592d820ccca@spud>
 <IA1PR20MB4953A0D6A2B73D03BF162671BB992@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240910-bust-mulled-e45f6f6ef29d@spud>
 <IA1PR20MB495316205F5AC588867FA8E1BB9A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240911-perfectly-buddhist-0c79aed7bb98@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-perfectly-buddhist-0c79aed7bb98@spud>
X-TMN: [mNlVG69+tLiiC43Rrnjakc9JId8lf7pJOb+toIV8j38=]
X-ClientProxiedBy: TYAPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ectafw6c63u6es7fmoxhkptodcmjwmdl4fnjstrosyhetmvwuk@dqpfh6vwj5zo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c60bf3-e13d-4fb9-2e6d-08dcd2b35848
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|15080799006|6090799003|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	CWfBq68l0k8ocmURB77UVl8TI0HQDPY26nrsf6/mcXBaZBxawLV7EOppvGXfdzhR9Oj0Witch87xEJucBowdCpbHH527LgmeL8yUPwfDzPrSfKgWU+QLH3m6IpXkm3Chx46hdwfi9NAxGM8QsmabajAprE9tVMTvzJdqfVfv4inXeRU4aO8fDV+Kful/YSOvf94t5VYzTp/OgzeiS+mw+9avaLTG8jP/F/c1OA/5bO1O9Omz4lzWDYOGGBteJmGaToVEZ1T9Nbl4LsmgIJvblN3wDLX7z49x1FPW6L2o4sur8/QA3YIScVdK/LOoLLdqFVRcuhOHTWTzMLJWaqlr72zXCfHioJvxsSzezoDUybcass6WIQkpF/J5B4DwLflQ8acF3jRvTiTBt7xDgRXPBhdx323U4TFWnAP+1WGZJIo1AQ1xmqsgobi6lB90vhcwLwDOX0XZg5lcryPcEI5qXvZYT/GJSAkS1WKIuoQ7JDs8hyal2bTK3HL2fwKqmelo5x9+DgO2Jq25oktayjFFKZR4zvDhXhNJJl3SQ+wuk3krlYxsplP++Sd3jcZ8qcO8m/3zMz13tYaAqa67o9L4D7KcUUDKwxMTMCVM9oI/hKccRA3nRbKtgqhR0PkXeiGLvWB8ooPget3lHc95gT6qttfZJ1ulU/zh/yGhGDpUCnwLGvreKROhXx+CR/8HQZjTJ8IOIFnlxLGk8Hi4G/ZXt2K+L7nhcc0Yc/eKa5p/vCg+S38A6z0J/46/1rOmPIYXDu97ShSr93haOaiUXWTQKg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2390jj/AtBfSwHjtyGXz7IrOYCMhh1yuzTPUzxNjVSHy1wVrcO5vEew8f2YI?=
 =?us-ascii?Q?4xM5hUGCW4lwd4yHTZxFXTNrB+GBO4MVCJX1k3gHV4DymNlLbIgRPZVOGm7D?=
 =?us-ascii?Q?ZnGRtUvtvUEJIBt3aNPAQVxr/k8YHghEJNiXXgBrwfGSUIJUoUxAUxrsr+R9?=
 =?us-ascii?Q?q5abrcIzRzTdYDvspdZwEdgloH31HEEn7mKbpywGWFtdB6vEhJHmPA3PyXyK?=
 =?us-ascii?Q?WE39zmpTFGOimLYeybVcjosiHWGqAW76fmU2Ef0NrXM9MFqMiTqxV5WiU0RK?=
 =?us-ascii?Q?qX2mG0uoHSbwKv0z+V51o3MWrBq1QK2FFCNJyjTL09bSoSmwL7tZLVUfBHiE?=
 =?us-ascii?Q?EoN1Ge6il2HA+0c+8YtJyTy0tF/AW9E/zTQoSSPH0pm2qzQrf99eOe/0uXYi?=
 =?us-ascii?Q?mSAgW4iDWnD0bCAHgpV0+oWo7pwNd6xbDsOCi2jZEHKzJAz0YYaMJeL8Fh4Q?=
 =?us-ascii?Q?Vp7R3/yPeh45CFe/79ZbMEXI0hjb84DfevxwAD7IPv+far+iDoaKgo1Vvalm?=
 =?us-ascii?Q?NcJh/H3ZDAyEOq6bIS9F2KXkPNNo/SMRa+Y/mIS7utqdRqk5D+hTYqtap3XC?=
 =?us-ascii?Q?xM6f9BglQfmW420wjFHzwj1kVAjWbL6BXBtjrXtaYVfq249AmPK7avg4b9zD?=
 =?us-ascii?Q?7WkKyaeUmQNajghLJhz6neJNZbXP14myEaryQXcEe+LYCoNtdF9OCqA/CGN8?=
 =?us-ascii?Q?4QnEjy4B3jZfP6hmZz16IvQK1NG1lXz7YtJhHIGsbHSYjvrhqk0u3o2gKAJi?=
 =?us-ascii?Q?Sr9tzvXNFZFcWN1vXBF46OnzcTaYUPDGlgUOi6Iw1R5WOg1c6HkYXsETYEPD?=
 =?us-ascii?Q?4okw09/NwAFKLUTlF+UCUUc10gmW+vmlHt1ZiQ1ljiVCIb3B/qKxASSegOQD?=
 =?us-ascii?Q?OKuiHdmCW7lcFaHh2ZHP9i6u5kdcQr4ar4w0YTQ/71HzOzDXukc5fhKy38za?=
 =?us-ascii?Q?0c1viu8DIXUMWrln51OlFMjdl0BlWtfXgQyXu/LlCDVYVZ4tHpqlgBBLBOyv?=
 =?us-ascii?Q?AnVCvDGqTe12OiCPfhIRE9c15PufIc6ZxDaSip1IMliCPgYRGSZeydKX1lIp?=
 =?us-ascii?Q?1KFKkJqn0VMtqPHG4bXHHyNEVSdXlehZMnPFMRsggHxv3RImupZKueqPuoLM?=
 =?us-ascii?Q?Pgv1xelKR+Sqmeq+BR57+fy71Pj+IwcFBXHosJDy91cV4MiPWJ4ylshToZcB?=
 =?us-ascii?Q?Zjp1T7ImtF3owzaJkZqoJG69EmL6IDEFl3sI2MU9log8V3nlyzEK11q3wcYS?=
 =?us-ascii?Q?PFl1AvjIXNHnDYwJ/09s?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c60bf3-e13d-4fb9-2e6d-08dcd2b35848
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 22:44:50.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5877

On Wed, Sep 11, 2024 at 08:11:15PM GMT, Conor Dooley wrote:
> On Wed, Sep 11, 2024 at 06:25:49AM +0800, Inochi Amaoto wrote:
> > On Tue, Sep 10, 2024 at 05:13:43PM GMT, Conor Dooley wrote:
> > > On Tue, Sep 10, 2024 at 06:24:34AM +0800, Inochi Amaoto wrote:
> > > > On Mon, Sep 09, 2024 at 03:41:10PM GMT, Conor Dooley wrote:
> > > > > On Sat, Aug 31, 2024 at 06:38:40AM +0800, Inochi Amaoto wrote:
> > > > > > Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> > > > > > This patch series aims to replace the previous patch from Jisheng [1].
> > > > > > Since the pinctrl of cv1800 has nested mux and its pin definination
> > > > > > is discrete, it is not suitable to use "pinctrl-single" to cover the
> > > > > > pinctrl device.
> > > > > > 
> > > > > > This patch require another patch [2] that provides standard attribute
> > > > > > "input-schmitt-microvolt"
> > > > > > 
> > > > > > The v4 version is from [3]
> > > > > 
> > > > > Which version of this ended up in linux-next? I see a link to v4 in
> > > > > what's been applied, but this v5 was sent before that code was
> > > > > committed.
> > > > > 
> > > > > Either way, what's been applied and what's here produce warnings:
> > > > > cv1812h.dtsi:19.28-24.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: simple-bus unit address format error, expected "3001000"
> > > > > cv1800b.dtsi:18.28-23.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: simple-bus unit address format error, expected "3001000"
> > > > > 
> > > > > It's just a copy-paste error I would imagine, but please send a fix.
> > > > 
> > > > Yes, it is like some copy-paste error, I will fix it.
> > > 
> > > I'd rather you had sent some follow-up patches, than rebase your tree at
> > > this point in the cycle. I assume you hadn't yet sent that stuff in a PR
> > > to Arnd?
> > > 
> > Yes, the pinctrl dts needs binding header, which is taken by Linus.
> > So we hadn't sent them. This is why I sent a new version to fix this.
> 
> Oh, I'm surprised that you didn't get a shared branch from him for that
> to be honest.

He did provide a shared branch, but I am not sure the right way to use 
it. He said it is used for SoC tree to pull it. So I think it is just 
used as dependency. Is it OK to just mention it in the PR and add the 
pinctrl dts? Or need some other git tags to tell the dependency?

Regards,
Inochi

