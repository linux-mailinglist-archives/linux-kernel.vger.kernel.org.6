Return-Path: <linux-kernel+bounces-335083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27CE97E0D6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0352814EF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74313149C6F;
	Sun, 22 Sep 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="QKcawqKa"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACD2AF07
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726999625; cv=fail; b=O6svDzWFDFV030NA/ukTDBXIr+D+3ch5C2HkPpFMtmxd68GUmOmbAC8pmEuAC48yQEGrDYL3s4opf+8Wthwlh7BntuFwi3Enqu0JfRh9oXoXYT7atV8X0X0RJ4TkNcrHBbGf/Se4GyUARw3bCIoqr5UB8y1xvfGHz8fFPcZolOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726999625; c=relaxed/simple;
	bh=XOHR2/cEWxEj1LFmH56sEKyRrbln6dZJaHDydXubipY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T5L7Oc/RzY0H9T4Fj3JXwlg24k+dz2vdTaOc8JqsiIt5qBkoupovRwFtUCHLRir104HaBVmREN0Taur7toldlkI6UbVbTLkIirXD0sA1HC+emzyLkdVqMSCo4G5nfHqiVMunHoDbAI+x3nunHkWBeRBsxl7/te4pu1bMK0dXOzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=QKcawqKa; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIBC2zmnxv495ZNjvrrsZ/oGHoGtcJYG33fi1tkO90aIgeol4rwGwO/4KqB4cO+t9QJRsW3ByQ4jRE0RQZBm3KalB/uKao/EMRy+0E2xZnqEP/Dct+DrIEirwh1o+jsReZqRmmFoQJXR5qrHlRgFb8vfqOgonxW1kO2QnxuF4ET5FDhvMZ7Pb9BvjfCCri5iMAk1VTVHp9F1SkqjS5NpLz5OnYxeeo4pVpWQwnCX8YIDFWjI/Bt2DQNx8Unc+nYz31zUdbihwBtgBvP+fIPNFcmQZzsMGR97cCkMWxTuSbO4pSiSk+yiPXdnqefEpTFqsZ26qyW3MSXcsofquY3PJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0VH6/UARiyJuBJpxlK33AX/OmkIZ/SWlVkZz/z6NLE=;
 b=QmedBlLUOHRDeC5eWsp6JaunJDOU6X+LDilkgfudEqbHfdF3rm98ik7e4qH9PfCW3JYD9RvVPeCJ7gsC0aQodygthLsK+mnA5K+ld7w6gSaeCWVRXo2f5Zzi1zdObj0myP2ajzwboh2IFqMql/YGClAdpXSWAWbmPlTOz8504MbrdYwCD58u+2JYj9q4t50r3qDnCGIsgV2Y+yW8lzxWXbRs20Lb/LUHf6zognTZ54BrTMYyR9VrkKMddVRgczNHXScQ4gPfpZa2SggBeRkGNGB+oujrOBgVqyqSuqAh3PvWJ0Fiv1eCebEbLKhB4SIEbJh9lOQOz5dj4CyNZDWFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0VH6/UARiyJuBJpxlK33AX/OmkIZ/SWlVkZz/z6NLE=;
 b=QKcawqKazGDaOdLiTP0n79aBxlCFy6+VZDIZYQJ2j+pumnnorqUT8/nW3P9tI37/HE+mpL5uXTtWRUzoUdK70lbU09esl6NioxITKbmQlrmGZPlSJv3J/w2YH4o3UP8nbdNkDlqYLoB6sJLtvvsgDm712frDB9lUMCibwZdl0ho=
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com (2603:10a6:803:82::16)
 by DB8PR09MB3738.eurprd09.prod.outlook.com (2603:10a6:10:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 10:07:00 +0000
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7]) by VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7%4]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 10:06:59 +0000
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
Thread-Topic: [PATCH] riscv: make ZONE_DMA32 optional
Thread-Index: AQHa+HVuldY7EPjBp0OcGqR5BRwxW7Jg2v4AgAKWfGA=
Date: Sun, 22 Sep 2024 10:06:59 +0000
Message-ID:
 <VI1PR09MB233391A7544336FBD06303CE946E2@VI1PR09MB2333.eurprd09.prod.outlook.com>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <Zu2A1l_cX36sOVcB@infradead.org>
In-Reply-To: <Zu2A1l_cX36sOVcB@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2333:EE_|DB8PR09MB3738:EE_
x-ms-office365-filtering-correlation-id: f7da2c6e-6909-4ec1-0a17-08dcdaee4bef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LuQAW1NsxLE/EhmDtiVUQsI8N5znz6x2DNkcr2yivgH6+gAi2ODbs05pZj?=
 =?iso-8859-1?Q?E43J3MFciA0LUsSv5MzLIZ6y4LKTMfVkU9QIF/zjmKq4P+LK+5t0Ik9ztw?=
 =?iso-8859-1?Q?EvTtqsO71lkG1XuWVfkyu8/rSSH1UGqqq64N+OzDnevUUdwBnXet+xeLgs?=
 =?iso-8859-1?Q?DPccUn3iNlvyenRIL4YhY7bmMPArV0Fq2uYxVoiDd6vp5lpk92o0HuK0v/?=
 =?iso-8859-1?Q?5v/2g+fL8+z9w1avUn6lozVqSj/ZvKaIpp5i9Itf0RGNiCw+h5G9HhRAxf?=
 =?iso-8859-1?Q?CuGvqseLDObiUZ0VsyJxk2Pi+MgHmr1ZwarU0rV06WwTMAfnuT/CjLJAan?=
 =?iso-8859-1?Q?pTMonchk3muoEv0p71wPeapHIrFyyidWrSePFCLR8el4UCBeTW4YfM/1UE?=
 =?iso-8859-1?Q?GvO4RPkgpwsmR280hzSY0+vBORQebM9EFSZ0MIbou7uN5nbKbjp7AKG25L?=
 =?iso-8859-1?Q?AvT3bjtU6aRU2zFqljI4MqrnqtO4WVR06akvzvwNcm4rjCjNLrxSEKyUO2?=
 =?iso-8859-1?Q?iapngyZcx5V1vUwq84gGMBacq/u4AsVcSJhc01X8QJI/948CQlJjWsrzrp?=
 =?iso-8859-1?Q?7zkLpjvZYcLktzqJW7IvrUGuT1SS2zQpps+omNc9VsQdXUVag84eEkUWnn?=
 =?iso-8859-1?Q?xj8Jw76LlHkm+IEgN1PSjPqMnVy1oassq1tIL9YKZCvQu9o/xuH59TeZXH?=
 =?iso-8859-1?Q?T/NK//94+TwbVjSHFV1d3rBsnof140dcNUhr1ywnbJ6Cguopd6MV/oYLPx?=
 =?iso-8859-1?Q?/pP7MjwUjvS0tAPLhd5ZTje+QoJQgCyXlm6IU7JqbWbDQXb174tVZr3UUJ?=
 =?iso-8859-1?Q?Yt/eqPgZaEKN7XwgMIUmnCnqa3SoSosAOKPZzHLfkBisn7Z3i2npzDNKGz?=
 =?iso-8859-1?Q?0YT3OlNThsTrWMP68TdG+cUVDGoyVcOyMhv7/oQ5HDNWffURRKSkkzvEK5?=
 =?iso-8859-1?Q?TUDCxEFFWA6BNryDqA+fgE/6EPGQglzirKnaFudBMu45xP2HALaxoSQVUT?=
 =?iso-8859-1?Q?TUHijmSJDKsR8DqPu4f+MqK50ANjKqfQtN0vZyvbtuDZFT4gB7z1eT26N/?=
 =?iso-8859-1?Q?/1dDBrij5TVxBbTyX67rdjIq5z1aVCEluejPUI3UkYIORC5OJ0u9a0E3yN?=
 =?iso-8859-1?Q?U4tf2biFXHzuhwtLbV+bz2VSaE/8IHSajCdtkARXahMPeKNUqclohtbrjL?=
 =?iso-8859-1?Q?8PHJlytEoYzyyDBh18C/AEW62g9llC8B7OArBjBGGK75bTd1OXc/TeNeUL?=
 =?iso-8859-1?Q?IAipVT3LcSbz2096G6zPVlbrugzsr7T/SvG+74Wf2uob5X+J9Wv3aKuWbZ?=
 =?iso-8859-1?Q?eF9gjZ9H9vu/mZUrVEE+JIAl/XCPnsLWiF6JRGUyY4YCHoPyOJb9K6pYUZ?=
 =?iso-8859-1?Q?M+V/6Yz9bf3bjtCaLe3ussxzhxsV9mPOP9LFh+fL4igVnZNiMTcjSniuJW?=
 =?iso-8859-1?Q?MM0eV7MzO0vDhJZOJiNtI2WWfikxPa5B5wCUGQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB2333.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PYjz8QbAWtZc6sCxsi/kWnWiTBeiyA0tYNudwH6LF+21xAmGcbCR/UK4vs?=
 =?iso-8859-1?Q?IKY+EV8q0Bnn7RGaMYMRLJp4CvGoBinQNpe0cgRtBFQHPz/W3BhgS+jlwR?=
 =?iso-8859-1?Q?FLNFdiUlqvP+SkS2iWMZz3X2G7yhNvOEeKtfa3H6bqoiK+e4j86boGUj6o?=
 =?iso-8859-1?Q?cwbW9Sf7POMz76ptHuyB7x0G0Wh06ubcnQUMjS2vjOZmZBq0Q8lVtKGJqc?=
 =?iso-8859-1?Q?eVRBJkYlFSuOrBIYaK6Ks84rzwHiZqDz6l89FG6SXGTm8FrZOvyMUqML/8?=
 =?iso-8859-1?Q?G/dt0I6VpUvyk809riNpM6hRGYtzTwPNap5vCapWnnEfFijrcohp6bCMRP?=
 =?iso-8859-1?Q?1COk9uhZMhvstdjpo+3dV1rhAplieXYozywiDEBo8K+j1/g/WdDchkIN8b?=
 =?iso-8859-1?Q?fhc674uAif/QXiyLRui0iEcEvKgHXCj78Chsbpk+6lG1YBP1xBwnfk2RX9?=
 =?iso-8859-1?Q?5C9bKIyb7a5ksYX8B+yWd+L5YQiEGFiPTUqI//ZxR2vvitTT5+scsGPB7G?=
 =?iso-8859-1?Q?rmyG/1I4sB5U0s2bnrq7VLdzuWvLtdLO3Ie2WCj6pOMqQP1y9PDipN6fCT?=
 =?iso-8859-1?Q?rUTBdEBxuRHb8QoxMZ55imNMj/qvbOPlN3khxh/cS0wCTNpdaqKD110bjZ?=
 =?iso-8859-1?Q?gevQ04cPZPES135MoAB5Xrl0oYJ4tTBscZDa1ej8JzD1Pco+6EscuejgR/?=
 =?iso-8859-1?Q?bXILdvI3s+JocvQhjDORDdkA2Qlt1ziZNhBwM9Mmu6L7t/cqN/5yhdlLiH?=
 =?iso-8859-1?Q?NCzgD1wVqnNwdoJm8HoFnweefsBAajsJzhAfuUoJsluBcT39PHcmz4dWl7?=
 =?iso-8859-1?Q?XnYseXBNvReMLZ3zOc621VC6WWnQjZuZOZ+1pzrPNQ2UN9YKOCnPr3XFVU?=
 =?iso-8859-1?Q?HQECUedNyxJ1k+6NCG75O7S8/P3vTtXt9c8f3d/HYXupt7KAcKyYlLWtdR?=
 =?iso-8859-1?Q?Is9hn/vnKIirYoYfmlaAjKsV5iWhnThfZBFanRL0+Pw2FDPVmVHrxC6GN3?=
 =?iso-8859-1?Q?TfCj+Cpoqb9lv82djc9Eoj251q3z9PHMdW2oPBniuQtDASqiIe2eKqmli2?=
 =?iso-8859-1?Q?yYAtZDbiTbqGWGg6VihqUAwr8/kRZUMPeq1Pe3tsxHCxAdzUproqgmnlJr?=
 =?iso-8859-1?Q?3YFH3G0fNrhiyyuagmlZPutNfNTITZEaTx2OqVX5QgadzpFj4LMYVcHQya?=
 =?iso-8859-1?Q?1SkGZk/x4dT/2MUz4ci1Y0WmwSzRv/gQShIS/w9gfiIaNP6pA0sAKPZXcI?=
 =?iso-8859-1?Q?3M0MScrf1YdReMRbtFJR4DT2Oq6AoTJcC06LFr4okr8aOoTV389U6Z1+dJ?=
 =?iso-8859-1?Q?6IkF4HCU8g8uSK6YuErKRrHh8rs+nZYU19oKKU9jp2dhW5GX2U4/K6n6Xs?=
 =?iso-8859-1?Q?yEFh9Fu0rm9fkp32HM3H5JYh3eS3wT9GEma8JgEFhIA1IP1W4vYEmRZws0?=
 =?iso-8859-1?Q?k9+s+F1fjBN7ov/829a141dkMyYvSopkcYvOF9KvmXvJMdIZ2kjYiyprzG?=
 =?iso-8859-1?Q?83LwTJ9Hr/dSKKZq7z/3PosUUvTJsAN4a+oUU1SInkzEfdJ3Tshhhx+XBG?=
 =?iso-8859-1?Q?QclQMfyry0XPCHdyoh/jZ22UEDmQWyqtOvoDlbOSCktLXM6LBL6XiXADiX?=
 =?iso-8859-1?Q?ZIUvQb0qjSDQWe9re69cHKCEXpFFSqia9z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7da2c6e-6909-4ec1-0a17-08dcdaee4bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2024 10:06:59.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+hbhTxHYZu+E2jKhnd5Lr/thuUxLBF80kaMQwwnj9AOwLOjQg/vXZwtrS6RqZ8k4VFu1iV92OTuwWGnT/Tlpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3738

>On Tue, Aug 27, 2024 at 02:36:11PM +0300, Vladimir Kondratiev wrote:=0A=
>> It is not necessary any RISCV platform has ZONE_DMA32.=0A=
=0A=
>That is an odd statement.=A0 The point of ZONE_DMA32 is to make sure=0A=
>that drivers can always allocate 32-bit DMAable memory, and without=0A=
>ZONE_DMA32 that is very hard to provide unless you always have an=0A=
>IOMMU.=0A=
=0A=
This is the whole point - there are platforms where you can't allocate 32-b=
it=0A=
dma-able memory.=0A=
Unless there's IOMMU or some platform specific tricks,=0A=
DMA address is same as physical address.=0A=
In my example, platform has DRAM installed at address 32Gbytes.=0A=
32-bit devices would not work on such platform, and attempt to allocate=0A=
ZONE_DMA32 memory fails and kernel prints warning as in my original post=0A=
=0A=
>ZONE_DMA32 is supposed to contain the 32-bit dma addressable memory,=0A=
>not 32-bit physical.=0A=
=0A=
>Take a look at the changes that just went into Linus' tree for that.=0A=
=0A=
I re-evaluated with Linus's tree as of now (commit 88264981f208), same erro=
r reported if I don't apply my patch:=0A=
=0A=
[    0.191514] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocat=
ions=0A=
[    0.191524] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_=
KERNEL|GFP_DMA32), nodemask=3D(null),cpuset=3D/,mem=0A=
s_allowed=3D0=0A=
[    0.191546] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0 #2=
=0A=
[    0.191553] Hardware name: ????  (DT)=0A=
[    0.191556] Call Trace:=0A=
[    0.191560] [<ffffffff800059bc>] dump_backtrace+0x1c/0x24=0A=
[    0.191571] [<ffffffff805d1a3c>] show_stack+0x2c/0x38=0A=
[    0.191578] [<ffffffff805dc1e6>] dump_stack_lvl+0x52/0x74=0A=
[    0.191584] [<ffffffff805dc21c>] dump_stack+0x14/0x1c=0A=
[    0.191589] [<ffffffff801a8eec>] warn_alloc+0xf4/0x180=0A=
[    0.191598] [<ffffffff801a98e8>] __alloc_pages_noprof+0x970/0xd94=0A=
[    0.191605] [<ffffffff8008d2ae>] atomic_pool_expand+0x62/0x1f8=0A=
[    0.191615] [<ffffffff8060d6ae>] __dma_atomic_pool_init+0x46/0x9e=0A=
[    0.191620] [<ffffffff8060d79c>] dma_atomic_pool_init+0x96/0x11c=0A=
[    0.191626] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2=0A=
[    0.191631] [<ffffffff8060127c>] kernel_init_freeable+0x214/0x274=0A=
[    0.191636] [<ffffffff805dd9e4>] kernel_init+0x1e/0x10a=0A=
[    0.191644] [<ffffffff805e6eba>] ret_from_fork+0xe/0x1c=0A=
[    0.191709] Mem-Info:=0A=
[    0.191714] active_anon:0 inactive_anon:0 isolated_anon:0=0A=
[    0.191714]  active_file:0 inactive_file:0 isolated_file:0=0A=
[    0.191714]  unevictable:0 dirty:0 writeback:0=0A=
[    0.191714]  slab_reclaimable:26 slab_unreclaimable:742=0A=
[    0.191714]  mapped:0 shmem:0 pagetables:65=0A=
[    0.191714]  sec_pagetables:0 bounce:0=0A=
[    0.191714]  kernel_misc_reclaimable:0=0A=
[    0.191714]  free:1014355 free_pcp:0 free_cma:0=0A=
[    0.191727] 0 total pagecache pages=0A=
[    0.191730] 1048576 pages RAM=0A=
[    0.191733] 0 pages HighMem/MovableOnly=0A=
[    0.191735] 30264 pages reserved=0A=
[    0.191743] DMA: failed to allocate 496 KiB GFP_KERNEL|GFP_DMA32 pool fo=
r atomic allocation=0A=
=0A=

