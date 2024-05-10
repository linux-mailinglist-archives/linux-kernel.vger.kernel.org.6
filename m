Return-Path: <linux-kernel+bounces-175470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7454F8C2020
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D3281C95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE015F3F4;
	Fri, 10 May 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="itOXm8+A"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F91A2C0F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331434; cv=fail; b=uYImJbYxtvu+FLt2t5RyZcJGNzj7lTMDYwqfcyJnZ0mnV0cj67pJaLygewvro+3E0eyWM18mG7EBrW/mcBxwK1MxkRD8MbsiO5XvPJhVbHvcjsvttvR1qw0pABNfTNW+LohC7HfIkOl7dp/UtbcX3l8cz0MU6ctRd6VCC78VyYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331434; c=relaxed/simple;
	bh=KSY60N5UUcsCiojEMVsm9HQumfHr7mcO9caft518G4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=bdEyPz8vGO6yCC54nawBb7r8cNwJJBmbiQJCAMpKwTAExXAfoiaFYGQZCvUecMpbvG+p2Wg4YaDDRSPO35Zg5P1nZYDha73z4yJ1FA5iDOHAo20NQMLv5Zu6S7w6SUcihe+i9T4nLKf68RyL15tjhK0V8DY0esiEXDoonzovsG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=itOXm8+A; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A3BM70003442;
	Fri, 10 May 2024 08:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=KSY60N5UUcsCiojEMVsm9HQumfHr7mcO9caft518G4g=;
 b=itOXm8+AltB7xeFElfgotN2eG2A/K9Wvfy0XRFQnS6p14FB4120Fmfy1iHtFUPc5d8EN
 RR8pfMyod0d0DElSheQJ7w/kgbuGySF0UU2Co6QVCocrtU321ZMRln+hgxtnasnrdnIV
 40duxSd4T6f0j+7DXXbMoKLpjZj9GBVdaKTGmmw5D9xBNFERB8vgA4DUpKAYMxn/2dcF
 jtuQv1VM1HbOZ34GTtqSYPKRU8ZiY5D6LnKvfF+4pydVj1f0pzx/As4MlgYkg6xHJD0p
 AAt5JEeXCME7AFiNVKp3gh23iagMKkvrFdN0aCVQNEmByU0V8CeopQhSK6LtWAeQDqru +w== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3y1707gj8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 08:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdVeIORWAOtaXNMjk7+hD8aMAyebWPy9/cr9LVZNiAnV8LuQ0DL8zG/AHqM0w4kxG8ecmPgarXq4pUv9DSSaZqVFXWOWIBHdeX5KfwNSJNfCP/NA/hSchKOhMTVqYRKmnRPM5dbOx40mKQfewTJN/IqTYEs+q6KI/0j4unvJbuTJSJtSfYPqnpL5NjYn7r0bKKz595cBnLupcrqUhbpobWLLY3mgRneM+b8dd7Cr1RdiqMZBw9rgfNhVcpBrnJeHXkTi6QxtFWYjH4hKBZBtvNFJwSkvJRDEPqef36m5SYOPYPmMuFxfhOmYrvDkHktgw3POD0lGKQgVivp51ZLMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSY60N5UUcsCiojEMVsm9HQumfHr7mcO9caft518G4g=;
 b=Dq42CnLEOf5aWNZn3n3OD/FK0/vRwDtWgaJvocYxbrwNnpytJv/iiIgy8EkyqZ/DTdrjLF5aU9giSntLUMmbRHvA++QUpeoXAy6v0LhV08VBI6puWiW6ph/3X7lgJiW4vW0eLqCFo+5iUh9UwjfBXnHlqdckKcl3ILaYmOWogFUTBep0qEPAjs1SKya1/+tWCTeyU6pluaMq4ggtzUYYYP4pLW41OrgDOrtGgZKL0GzTu7/0QKfucQszSZCZ+fOT5GmUQqLrI8Xg5L7ktYU6AQPEoC6dmG6nv2Ij6jjOENowwi5Yym6vRxJTg5JpAzdSATOT2IiGQArSqtcOrbhu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by JH0PR04MB8185.apcprd04.prod.outlook.com (2603:1096:990:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 08:56:12 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::6bcb:d0e7:297b:8fa6]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::6bcb:d0e7:297b:8fa6%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 08:56:12 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "andy@infradead.org" <andy@infradead.org>,
        "arjan@linux.intel.com"
	<arjan@linux.intel.com>,
        "dimitri.sivanich@hpe.com"
	<dimitri.sivanich@hpe.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>,
        "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "mhklinux@outlook.com"
	<mhklinux@outlook.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ray.huang@amd.com"
	<ray.huang@amd.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>,
        "wendy.wang@intel.com" <wendy.wang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch] x86/topology/amd: Ensure that LLC ID is initialized
Thread-Topic: [patch] x86/topology/amd: Ensure that LLC ID is initialized
Thread-Index: AQHaoYF6sl9mVSiLREuzchxgtaS19LGQK62A
Date: Fri, 10 May 2024 08:56:12 +0000
Message-ID: 
 <TY0PR04MB632822E9948A75C79D9F107E81E72@TY0PR04MB6328.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB63168AC442C12627E827368581292@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <87msp0nkqc.ffs@tglx>
In-Reply-To: <87msp0nkqc.ffs@tglx>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|JH0PR04MB8185:EE_
x-ms-office365-filtering-correlation-id: 865fcc74-ac80-48dc-3d94-08dc70cf0b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?/q2ZgmBDx5dqoNo7xhQktYe5JPpNx+FLLvm31x4zsp/fMpN5X8CbrOuGfb?=
 =?iso-8859-1?Q?akAIC2hvJqPae7FxKXpwkouW64HgrHAa85TSfTLI0li6hF/DwYJWr/AbXh?=
 =?iso-8859-1?Q?2JQ/LpSbMi8a/NL8gJK9EP3IyqcR+QUfOdKiimndsS8AYnyX9N1gxYWIWG?=
 =?iso-8859-1?Q?H1piAuHh8SF7qZxI/bgoHKO2lCBDTRf6Wyp6nyKvhuLBJxl3PxmHdA13zQ?=
 =?iso-8859-1?Q?Sfv81kH0ac50rWqHkral5bBG2VzXTmc6sLVONkW0Qzpf4LgpSGj3IYyee9?=
 =?iso-8859-1?Q?eZR5Lu3zirjAI/TGjqoZ5L+euh5PLjCHqqGFhvNg4qBmUCEGuY1HRrtl6d?=
 =?iso-8859-1?Q?SCsssznB2HMaM8gtDfNdJAsl1/0VP59ZlU0egLQlQDP/3xWkFSywlhnk7A?=
 =?iso-8859-1?Q?gQ2655S8zGCMViaAxyk2COa63VcCgEPqphd/xrycnHnKTINWHc9omcHqP8?=
 =?iso-8859-1?Q?r0gfRAaGc8YDy4GaWMbs2M1QolkACoahxB9HJ8AnrAT4ctdSUPBeVnngxV?=
 =?iso-8859-1?Q?qfS/NhUOJRXazLVRgXtWXxSsieOIH0ivfQCr7/yohQxIE2SxT7oabI5nfr?=
 =?iso-8859-1?Q?O/XSy9dPDZqozWQaPVMk6tQOB3tgMSrdTeYqqip44mI/DV+5EOYJk10FDR?=
 =?iso-8859-1?Q?DdcsRHKoSozsLgh4PRMRq/krrYSpUMOPb3/qSHDfUdWzP7C4ZFd+n1ZvDF?=
 =?iso-8859-1?Q?kgQvVOKssNP6Mtl0NJndHdW70w1FiTL+VXtyLOwMh3f3KDr38sLxrfiySq?=
 =?iso-8859-1?Q?v4h3KQTfKbk5L5nQhzjLU8vT+R3WcRLBxO4Bl0rL8OOie7iQqWwwHrlIG2?=
 =?iso-8859-1?Q?e+NfOKdCgTGm1ECrq4dKNpb9NMN1keWxwEx1HVw6FqaXeJqHaY2/frGy3+?=
 =?iso-8859-1?Q?QP/jZQJdZC5VuiYWcW7DdXg4jx6jvVy3y6xuJMMpDF7Drf6n5bd6eQ+Inf?=
 =?iso-8859-1?Q?QzgZjl9dOybicseiriITxiGgvcz/0kAYEvjEvwMbocvO1OJ3vsnyIChcAl?=
 =?iso-8859-1?Q?RsWYVk8sJbfp5gcAvxmUoWHC9od/FFpefp7G808NpIHCggxwY6Ilj8wwNc?=
 =?iso-8859-1?Q?YEhgcICiy6WueAVh0MSHV64sDWhJohFUunwLYoO9m5wYzQoMNZpO5YmsBR?=
 =?iso-8859-1?Q?hHB//px00nKz/2hSCIAfNbl329uy1k7AZ1qtEwaxNpGux39UXnlePTMvvj?=
 =?iso-8859-1?Q?NuGj2SxUqPMiSADM+etMfaP5Q5EIFqE5oOkJ0L2+HGcn0fZ4OQxHVz1efo?=
 =?iso-8859-1?Q?pERoyYsuGnnmX60OWAYQn/QqNBScxEQtyrY+TVGagYh8UF4PvAezcDHxx2?=
 =?iso-8859-1?Q?/T9G95hBHNH46kQsaAMZ9trjObQCeSLl+MIKTeHBjrZxQHtcYZnXDZKEq9?=
 =?iso-8859-1?Q?p4V48s+eLc95Ku79jTgGu8vfLKzATo0w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?SB0RF0DJaLCrf8v4oM0CzPtwPVfwfkLus/tPDKsPyFHCvG2MBSwD3ENAA/?=
 =?iso-8859-1?Q?POvblHiQhyNfwWfkvdzGeyCcvbu02r2U6c7Z/nFRDIsJRyAWd/zCvdk19o?=
 =?iso-8859-1?Q?DcxcpftIfk3Yt9En49+m0xweV7zq2VfB3tsRexcHWc7hC2n+5kMkf4RJhG?=
 =?iso-8859-1?Q?3Rx8IPmZF07dUM5GqkPGQs895OfKvx5KngfZiq2glMKJmnamGGfMP0bN8s?=
 =?iso-8859-1?Q?NnS3ofFlC6IzBKXVLeN8Eyr5kDndPiAddfN7FpV6gB0dN3avDNIY+squk1?=
 =?iso-8859-1?Q?ee9xly/Wr0KgaCYhrasstKaHe/JKMiNMZMefA5cyKAW7GsLjM+TAGovPLP?=
 =?iso-8859-1?Q?dmolrRsptnXe8vLmtoj3bcXhtGXLnKooY4O5ThX+FDXcBavW2jfb0I6crQ?=
 =?iso-8859-1?Q?1VHM0zOLlh7eVsZoQauoTAXfvmYQmSwjFtvvgiixp9e5dXY9Z/d3st1tIq?=
 =?iso-8859-1?Q?Vir/gCplT6sGNcoGakRKQH9eFzY2Chkzg5o9wAewWoLqOsgefMD2Rmpfso?=
 =?iso-8859-1?Q?5CndU28/j5om0K4sa0nE2r1bFc8Rtbzw3feRchb9GhmS8XXeVFvcw66gc2?=
 =?iso-8859-1?Q?7EIO0rnsW4IRg8+TUdoYRLx56NkpAtw1WCTpFeukqxS7jnO1omnJuGvCkl?=
 =?iso-8859-1?Q?2qPHs1/npGn/RSfrljeV4zS37wGOdMvkcy9r2hY7tweovcatn4WxXkDaJa?=
 =?iso-8859-1?Q?Hq03YHZHz8u1ws81AehTO4ktDud9qFQ/LlrBHAWiJpk29JBFA0gpuzPRsT?=
 =?iso-8859-1?Q?2Zu7rZSFuE68SddbZrgwlSxJorkNBg4LjOLLxKVHCteZXpHGHBX54cWkXO?=
 =?iso-8859-1?Q?rKQJ8+QqSDOIIPhPNu2DsG6IuGKqS1u5pZbqBKF6Ud7BlQQSAyNW9kKQGj?=
 =?iso-8859-1?Q?RKpeKEaJ5kkP1dNxRvPWb78de72zbuFKxdVNM284bIkntzsNiTc8lGMVqm?=
 =?iso-8859-1?Q?AjHiwyskrVZJAIDCy/W6WsVWgttIn2AWB8aqpNBCFnn7BfSqIrxkeBIQ+b?=
 =?iso-8859-1?Q?D0PX1RTzTvqo3wmDrrM+ZopHdVJ5Cxdnod9W6IEmBQflI3Zd6EltSvEEw3?=
 =?iso-8859-1?Q?ELjiewy/N7kwLf1QD2u8qE4IAHPLcG+I6DDW73/lOxCbQOyGQoKvUhuCY+?=
 =?iso-8859-1?Q?DrrswjN5WHYK/5CDX8G7I/oLo1Ad2stLiVrT3poP5Dd7jC9eYQLmm3qX4+?=
 =?iso-8859-1?Q?GR+FqgEnpfuOOc7LPyktcqZq9zgp4ArEx18PAdNdYMGSqz08dUTuY1ZPTf?=
 =?iso-8859-1?Q?Ew6xf4pdlCf9YasuW6cmvt9Mz+hdxFm34s3g4GASpIeaWEAfbQIf/obfpb?=
 =?iso-8859-1?Q?lDE4FQXorp1NI5EpLH9KuUFtik3ia53gW1SZSHzh7w7/KVP2hNp7dNgb06?=
 =?iso-8859-1?Q?6/03sm0lRouwXL3yLTqgpHuXE7XeIY6ena/VJgf+G7/ow1wmf7IJ06fTWN?=
 =?iso-8859-1?Q?xmNoLtJpkRFc36YsJruwAPy3DryvrM0BIcyeTFLqY4oTbESo4JsXiD7F1X?=
 =?iso-8859-1?Q?HYW8mSuej2/egt1lAcOQ0Ysu+W86r28BqOo6cYqv9o20ScgkaRM8oDR01a?=
 =?iso-8859-1?Q?KIasuEyisWqYTW15mLZRypV42uFqI43WQhQzAtqnnbOMEQEdWvilftZuHr?=
 =?iso-8859-1?Q?ek+fiVQBxlPN3rm2cXDTpylahnzQ8h9iGk+hUL3gON6NuIJmxVbXM+zTrb?=
 =?iso-8859-1?Q?e9O7p4Zwx6fHj3ClwN4=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1y5HNfx5Javd3aEq+8kbHi3/d8GqBBcaw98VHXT8QUaPbFS4nL3GI4stXw50Oy7+c8pGVdtlugq/x8/P40Ez+AqQdinegU9eIDr4QygjKg/LFiTSyduMVHIWdWHnwwaBQ4zC46+AhtTNY1jmYywWwm5p2SEAH31ROvasaXq0vv2kab8gqfS/9MNI5EmDg6bzTvD5p0i4jWvzcCCZfwQt0d6uzwiCjArLrM5hbO8AHZB9tQZlzo887tt8KV9WGvtNU+VUsG0amDvKI0kd0GYLPQ5Tta4smaNLzDEP4aI6R1mqlcUx0osIeP1BBH7pFy8HZomuHFmlHHwW1Ysb/eZVBUgqYfy7KfhpKcDJCFMieq4a+rRkxn5lCkU/PzTaJ8prP9uJ3UEQ3VTlZTMM7iiHodtN0spW00cB7h1JWQepz2FY7d2OiV6wJQv0202YMifPOh3cEdFTHMnPedItaOt3wDqk3OYycRfIw25fHm2AysZDlJqFTiLJ+9pbjLYPduWHuSzWHfP//3ApUAkIvDfE3DMQYy6Imqh+A8DHHTjSC57u2c8NXylplzyuwZq8ziBJJu4p1T+eTkA//WSRrOjse3SRUjRr6U9LKf7ZcshC6SNBZhvaEuuszgjYpc9Nqbfo
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865fcc74-ac80-48dc-3d94-08dc70cf0b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 08:56:12.4928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54Nhl/faOzTtZoC7UC+XVwJddFsRZXn4wHSmDD69pN742WTEoncsav7IE+BRf9U/QLQ+GdbFU3A3LKVhajylZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8185
X-Proofpoint-GUID: HGcMqBTRsJNy5UVIPJ1Bl0F5xCApJ2f5
X-Proofpoint-ORIG-GUID: HGcMqBTRsJNy5UVIPJ1Bl0F5xCApJ2f5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: HGcMqBTRsJNy5UVIPJ1Bl0F5xCApJ2f5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_06,2024-05-10_01,2023-05-22_02

After applying this patch, "BUG: Arch topology is broken" no longer=0A=
appears in dmesg both on booting and running my test script.=0A=
=0A=
Tested-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=

