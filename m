Return-Path: <linux-kernel+bounces-353345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B3992C87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF72B23F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217D1D2B14;
	Mon,  7 Oct 2024 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="TJ9Ies8f"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF918BC14
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306203; cv=fail; b=gP+h4HUJ4WyjOh19kMeXmqYJGphIx10ryM0Frwqa0pPxDFjsCfN8ndrM2CbYedxadueUX1xisX+s94UrCLldpePWC1Qz7GZxoga9hRtmPU1+iIloe5QJxXeJMxaVmY1kByw7e2RmEJLabb8SZ6HEyL7rJ2uVfG0qWc3aKYg/dkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306203; c=relaxed/simple;
	bh=7WOJXWImxp+DQWwSBct6RCWd21LDSv7qB/t0DATypvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kEnefERsvoccljFy97JURfGQNc+IaQI2RTrZTQf+lhnLP3XfuiQDTThYk6+tqd135KGaK+Uwh4XJcapz23eCp37IcLyuZx7Tl1IJDnQzXH5JbQ41F/GAMUnLNCaiR0kN8LrSwo/RORKsEjp42ce/J//mWrYz7R9Bnuvo3IPETkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=TJ9Ies8f; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko/qXZjyGZUQyKQH2P3WBhgY19+PRpKRe9KRvd2fa7TSsFbLXxOL2G+2bsrLWCtKZmQItiqBdWcqPmG9yK8+/71ZA6o1xpgI5ydKg50DwqC7B8hySA9H6YOaR6W0tN39QMBaspAK2TRPhsosfIEyHgw+FBdwRbxPrxm3fYz0NvOdE10vZmCexPEtW9J4oWlF7Cr9lhMotysfZKSK20du61wPApRP6/QxZPlRD2X3R9TIoLJxnyVzSVzTHsNBcuEPyHkRwWR7lNx0f9LquwLhztm0euIGPtCC30DSB8Nbm1NQF8qIoHLQQNf9oiM7y4aVgQ9oRzBL3mgHWKDD2+smdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bt0XrPqQB1QSjqguC8HdZ9AbWOtYNi0DT/z4KY8tVw=;
 b=J78tzBjc7ec8Kohx+8uUW94UTpd+cxIjBdS1e/zXllQyBsMkwAczfBPEp1tHX0iVcVXnYM5dFPmx0zfPRHN4FZHG3lP9C8mm3TlJ0q6OEDhgjfnH9IIpBnBdLuuJ2GBwRUisFMQ/s2KBxwB/SBfF9cz7UEj1eJybCZmUN5LiCmDrUrxW8k6FzDUB71IiCFHynQc+iZU4HH2Xpcq29UQKerZfuy0Z+zEoV582U1qw8/y0G6zJvNqj78ARxrV9zytZPOJnQRormwzSRwdDd28ECrfVVUW5ybcmXWfHY5t/7nbQMe3PV8Pg29krpvIsf3kV561SIkhiyEYOPC4a/2k7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bt0XrPqQB1QSjqguC8HdZ9AbWOtYNi0DT/z4KY8tVw=;
 b=TJ9Ies8fRv1qcLwPvs6OEHZZkTEjcTB/gtWn+sydK5qqq/MLKh9FttoY92o5eIt3+ikcBZ0PZBVEq8HdZalaY01p76gcLp4hGn9cdcVqQTXYXnv7DyF34ySPYrd79EeQm3frhQzsXDAkYNQjnjnsmwzsopLNTcQsqIY3UMMkumk=
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com (2603:10a6:803:82::16)
 by PA1PR09MB6911.eurprd09.prod.outlook.com (2603:10a6:102:45d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:03:18 +0000
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7]) by VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7%4]) with mapi id 15.20.8026.016; Mon, 7 Oct 2024
 13:03:17 +0000
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] riscv: make ZONE_DMA32 optional
Thread-Topic: [PATCH v1] riscv: make ZONE_DMA32 optional
Thread-Index: AQHbF95IdP/goVPehEObmdWyR1OJkLJ6x3GAgAAIG4aAAAMzgIAAUkNl
Date: Mon, 7 Oct 2024 13:03:17 +0000
Message-ID:
 <VI1PR09MB2333E5C93A7925E4518959B0947D2@VI1PR09MB2333.eurprd09.prod.outlook.com>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
 <VI1PR09MB233370D7BD8553E7891EF46F947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
 <ZwN0l0Y_oUfDX8jl@infradead.org>
 <VI1PR09MB23335FF3B1274ED13F24AF06947D2@VI1PR09MB2333.eurprd09.prod.outlook.com>
 <ZwN-E279o4bUQG26@infradead.org>
In-Reply-To: <ZwN-E279o4bUQG26@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2333:EE_|PA1PR09MB6911:EE_
x-ms-office365-filtering-correlation-id: 22ebafb1-78ba-491a-3310-08dce6d0699d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?swcfhKBbyexRaz6KJJlJldlSB3s6xpRt3Qi2HdJD1El0RABCrpgwxkdrQk?=
 =?iso-8859-1?Q?lDoWyn75ZhrkZc14svBSZnvll9yz8fA8WkPsQY4DFpRsvoTM/0IUfWa7/v?=
 =?iso-8859-1?Q?nFB0MiFx6s9lo7DFvSj07P15bxND4YS6+vOBfS6bnVmh8f/zlvoqPftHSJ?=
 =?iso-8859-1?Q?Q2dmzt5XqScxPmfk8EjrvYzKPCWTSw3TY6/57DwavrJ3gPIBYghx/e0GDh?=
 =?iso-8859-1?Q?BZlpzhlSYsbuKZo4wMOo/N9EoqYEQXDnFlTXo3jX0UrNRRGlUw8SK1VvI5?=
 =?iso-8859-1?Q?Dyx5zx6a9sPk7CTVSpNtuaUjWtOxkyu7ApY/+ZA2T4xHEEOqgMXYnmeEy7?=
 =?iso-8859-1?Q?M5vJHdSmvTP8KmPoBWxYBXOK3YjWTzZ33WIqpssPDakxkzePR2bBIKJoQM?=
 =?iso-8859-1?Q?XIEuhR+DN4TG/veKBKNtspFIDg9kSuZnshn3tUyxfjvA3/sL5TLQa2fFyT?=
 =?iso-8859-1?Q?/V7zUrOp6Je/dizhHjEpvFy2Q7k9W27D2BrJUNw9562Vdo/IcF2jbWQc6x?=
 =?iso-8859-1?Q?fDLkhnSf1yddmEqSGbtfz3Kw/AkNOCFXcGo8ttrZMssqjRK8DqnKWFqa9L?=
 =?iso-8859-1?Q?JX7BMmfEJHd32aRnk8kela3nQuZqO92aNrnhmeMJigla8kmhtU7dMpAVF5?=
 =?iso-8859-1?Q?+NdCj6RLqFmp86sNUV85PmuUfTfLeUbdxfS2ChbsRporhlNlsHCrzPIrx0?=
 =?iso-8859-1?Q?WcGlvgJxS6VK22+Q/JFArh89h1A02zFzt+0+JgjFhUZwl8f5B6Yiw2hrJw?=
 =?iso-8859-1?Q?FGJuvOl1XaDBWt7cRdyvCm6OMJc96AAWvoelo0E+VQ3xjk+5UaQMdGySeH?=
 =?iso-8859-1?Q?gqKEGAporMlzDtRn/0aOwJsLJsLmek88cgBikMTMD/rmgXB/KTtF98peJ3?=
 =?iso-8859-1?Q?8JLKV6SRDPooKDlIlveN+ogkZ3CJh5OW6BoVig6b6Jl7E9Sw65yu1jvk0I?=
 =?iso-8859-1?Q?DY6kRTmJ8s1+Ql4VQZ8fJrvMCc+6eFdr6JNgFUkKhzFENghRbEi4O0v8kf?=
 =?iso-8859-1?Q?LgwMxRpWrvKDRRqbNQCRN610rndSO5pkBtaogVGGP+O+r73tBDGXY6RRPD?=
 =?iso-8859-1?Q?Ymh6+HnxFJPNJU6mMmXkTV1MVQ0w++L1VPZjIiA+2jCYy5aAV7Ga2xV8xO?=
 =?iso-8859-1?Q?C3VVuS8cOvDEERYa1/njK6pJMoohLpZfNb6AJ7rloYqx0HZWJ6itDGJjKX?=
 =?iso-8859-1?Q?lmfs67DX7SquJcy8nR1732fOvwRnDvOff/PJKjfe9+8xOEnUIvzXIdUaCt?=
 =?iso-8859-1?Q?uimOmLw5JQ0itTmXdR8BMXnumwpzMzydq9ycX8qIhM53hShTF9PxxeSRYS?=
 =?iso-8859-1?Q?7zL5DIeCpoBHEHT5/PJRGjb040/qQ2/OPzszyH5GwpAJjm7bOHx6StWT8p?=
 =?iso-8859-1?Q?piZAlpYkqhdk+7xzLr4lg2zzMQVOSKhg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB2333.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FPRy6y1RYH/nqAR8H0ZPGz8xOKuT8NTC+IM3S5mgE5Homti4vlZLiYNIsj?=
 =?iso-8859-1?Q?094ck46vlTqGV8DRYs2BPNa+gCvFUDjyUdRaFZaGZf1MtKwVeI0d1BeV9N?=
 =?iso-8859-1?Q?ijrXXSk+HyD5Ji3dURkyXcdCxWqZmHpr9qzM/YRB0BBRFU7yHNejC23Adx?=
 =?iso-8859-1?Q?IrJKypJY34gfs9go3/ephRaTtYUe97vksNBqtJMM9hH8KgRMpB7R/kg8Fp?=
 =?iso-8859-1?Q?sQ6V9haPbEXLbEcKnSMEBvSBoLGGR0hgMykJfNWz7eyWys8+IaWz9ke+X0?=
 =?iso-8859-1?Q?vnUnEdV84HxURks4jA6RFtm7h7/hmKDX9n/Wnv0i6fV3+tnOciCTrNSZO2?=
 =?iso-8859-1?Q?E0w4rmv90RYWwuYSJk0vq9cRGNpivTvvQwCBq2L5INMtJ9xRxjJXuyVLYm?=
 =?iso-8859-1?Q?qqKmL8k/iOL33TMIqlISV+UXyG7QWZRPcxMI5azA7YpQ+hrxHoFAm8Z+OC?=
 =?iso-8859-1?Q?R9X9OHiuCu5iQNcpX7tm56sHIFx/l81dDw81RvdiGsa7xjGyVjEBq/736V?=
 =?iso-8859-1?Q?mV6sNoKj1mrZFFuIai7kjfFA0H5SZAGAHB6KdT9gY5ifw3cgNsJpxQLhsE?=
 =?iso-8859-1?Q?/AzIGvqyVHS7faoQoCq9Ds7j7SLNB7hxPRCewkU2tqwjd10MwYdQnMbwrh?=
 =?iso-8859-1?Q?twvoAfTYqpFDKKGIDPp7EDCAVYyP5L1ThPE/zkqS9j4B8dyhplDxZdHUSy?=
 =?iso-8859-1?Q?snWuGhW9rQgGYNojW3fJTScr7fKR4jgHlTPneqxDK0OxFTM8F/jM1TWaTz?=
 =?iso-8859-1?Q?EBeLmKUljIsCz15U4Y3lmUppEKq+FIDyIFX0xrS/gekxmXNzcWov716k4V?=
 =?iso-8859-1?Q?9ah0YfS+cT+lJ04kflu9p1GVCSjdsS76KV7Av1CJijAy2QddGyhEyvBojG?=
 =?iso-8859-1?Q?LlrOaaylP/pTOB4dfrhCsg2QRpUn8VHD+O98X3MEZB7iO5/z1QHTFNQe1o?=
 =?iso-8859-1?Q?k++FNsYlkgEf8zGXdNWT5+IPGAgpYI6vx57dmSK1HV5cQT2l+xHZlwcYJF?=
 =?iso-8859-1?Q?r40XXG5vhyd0CFnw+dA+ShYGI1Jzuai5/bSg3G8f1lAq9LZpjyNyltPar7?=
 =?iso-8859-1?Q?LTHW6zlwi+6Io6QLspbrZrtHp2PhK1fcC1nWeJEfrpsVfCF2IIsXz1QfHC?=
 =?iso-8859-1?Q?KQQ4j2hpvU1+a8NJko6S7kMsCBlaaWWZMJaIPBbjNpWpjDolBvLD8vleM2?=
 =?iso-8859-1?Q?ZmXx6w8ZMs/a2h7Jt4MGDY8+3vbWdd1HReCstFEhrvpzt2cpHmQkwA2DmY?=
 =?iso-8859-1?Q?4wnHWHVUCrBdKCJLn+eP/8QqQuvD5+wjAiHQpblnk/7wA/eK8oGTJjz5iL?=
 =?iso-8859-1?Q?AHx4sAlKX+dahJkjts5if39qdraRkp4BTxRtjoQWj+deKw6frQJPH9Jjq8?=
 =?iso-8859-1?Q?ILUiKbmzqWMLOGxnAZSkSDycJc+Ke2N26bg0OaYLkScU0Kpc0JOTQuNtvL?=
 =?iso-8859-1?Q?fEfsrkHCAw4YFGgb151Vsf1nwH1R/9/lOOjrwPuwsFYUdJ3kcnubkCl+Ly?=
 =?iso-8859-1?Q?MI7PsK/e17EFbmRaW/yULcaJRxlVUJJs1MFu7iKVmRntw0i+o61TGQW75P?=
 =?iso-8859-1?Q?/8dDWUJVmqfyj6TaG+o+uyA3engK6GT9VvSN10AYewCgWBONoXdDfJcZ9I?=
 =?iso-8859-1?Q?ftaikxcFdIT44AgbnjMXnEG5cNlBoZ2QsA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB2333.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ebafb1-78ba-491a-3310-08dce6d0699d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 13:03:17.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOceHOwfGThaSCsWo0Ww4lbiNw/JOKEEKrcqj03c1NKZxtoJ51XP8bjV2KVtd0/k9VPE+ekAYjuUCAz8haogpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB6911

>And if there really is not way to provide this, the right way is just=0A=
>to stop the runtime allocation that triggered you to do this if=0A=
>ZONE_DMA32 is empty, not to add a non-portable option.=0A=
=0A=
I think there's 2 different arrangements:=0A=
1) CONFIG_ZONE_DMA32=3DY means ZONE_DMA32 exists but empty.=0A=
  Currently this is a bug. dma_atomic_pool_init() will fail.=0A=
2) CONFIG_ZONE_DMA32=3DN means ZONE_DMA32 does not exists=0A=
  In this case any code that rely on DMA32 should fail to compile, and this=
 is an intention.=0A=
  Such system can't have drivers that can't work without DMA32 memory=0A=
=0A=
I understand your suggestion is to go for the option 1, not allocate atomic=
_pool_dma32 and later=0A=
fail all allocations with GFP_DMA32 if requested by the code. This may be v=
alid option but I don't have a vision how to do it properly. =0A=
Instead I want realize option 2.=0A=
=0A=
SOC I am working on is not a general purpose system, it is an automotive=0A=
SOC that will run very restricted software. It is designed for purpose with=
out support for the 32-bit=0A=
devices. I want to avoid any code that assumes DMA32 as this is just not va=
lid on my SOC so I deliberately need to break all such code.=0A=
=0A=

