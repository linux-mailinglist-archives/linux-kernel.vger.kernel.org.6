Return-Path: <linux-kernel+bounces-355821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECB199578E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158501C258C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D24212F1D;
	Tue,  8 Oct 2024 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zmEyZPKG"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AB8F6D;
	Tue,  8 Oct 2024 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415447; cv=fail; b=RXGInU83kYPtf1QAhhBjMatZeVsoYNRXnCZitt8ZUrGHnnJvoVy9IXd58PG0OlCrX/x6+iq/AOVW7OIqdlTyQlyinrAq/r09ZoPHU7tQZGxhGv0o3EDdyPE2EBB0RRw3tFs73cJGl4ZevoBbnSfYAs8aq0wUqSGM6swIHbyVU1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415447; c=relaxed/simple;
	bh=iqNB3HaEBq6TT/kYZTvnNcuPsG6qj9X+Sxh+Hv6LkD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnQVMqy5ns0BzlPbDdOXtKMzrDE/FDbZKb4lRr7cqie/QZACqw8yc7pX3N0BEUvcLyxnYg4rVR6HFzoDfxd0cD3crGEtQmPFWcwhNVteHNF0ydpND8UWbyl+dRKzq7MpStgSmcvftwty76ZnUgHudDv9/MxESM/Xk39GJ1OCsqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zmEyZPKG; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9Y2gjD1DggTQjEDSQsPgFCdGsktKyCxBNm5xN3KX7zWST+Ncn84AdNxB6+dHQE2eapAUdDlktzuzcxotKtMF+YQknm/ZXaqGEZy1Wv/d5/Jk84aQM7w1hZ9b0bHLb0FYi/71OGVjCpiD9mZa23dMg5sVdvgMg20/+/pp+fCrcXgkqnJTZ3vvYD2HdG5zx3K7WEd0DoxBiEnBRvI6wmILeQFl7ZgvHF21F/4AyOTfnQ6jZOewce808HtnVdyVD9oWs6hYXymTuHSQOSlr4LNr6QTTkKKwscuD/UuIuDbFr8WD+wHGO1R5qk4yjivNMwYBQZlyhG/ykYjlukP9diEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBGujJLi3cBH9642jZxKQZC9WWxHDjQpxW/rzyZMk5Y=;
 b=kJGAbzAgCdkbowgI0+qJPniZlIk77EZstS6I3QOQuDZazczrxlPcAKhzdJVb8h1SnZ0GeSIR+ffAH59V0gNizsN42CiYF4SNhM8+B4qP/zL+eJyDWlX68iD8VsRTUPHqC8ZLyW9pUAaoUWoY7AUAF8rKr58ccvLGo9zJ+1gfAWZL7FwHn7OfSippme/QE7GCnpcTChh7rDky7AHP+IFW7q+DfJkVopplKgZIrq3iDrEk0NiKAFHY72VDr51kdXlzQi/Z4kG5fWRhL7OEQkd8IV9zeYk9ufvcMqYSs4R162Nzzb27Zp77h3uGxptQAQ1BDHj4NcUvXIh900j/EAq92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBGujJLi3cBH9642jZxKQZC9WWxHDjQpxW/rzyZMk5Y=;
 b=zmEyZPKGBZ4abDEujBS7uBPnWp3sVkUeI4waZ3YgSgBb93MFeRFNeIOOpgvrYWiceEi1xsKLbS8QRYR5+4a3iotUEkzWctfjhcNkn68Q7Ty+h5X3rU2BooiKE9Ue3PtIlLJgqk+yszTMXbJlPl+Xxkl1Do8Bjk8WhwoWT9sduZI=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 19:24:01 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:24:01 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>, Jonathan Corbet
	<corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>
Subject: RE: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Thread-Topic: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Thread-Index: AQHbGbegzRZsFOFa5keXyvP1YFB3hQ==
Date: Tue, 8 Oct 2024 19:24:01 +0000
Message-ID:
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
In-Reply-To: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=35c2ebe3-bbe0-49a9-9f33-bf7e33a94f5c;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-08T16:27:05Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH7PR12MB7793:EE_
x-ms-office365-filtering-correlation-id: 13d83350-60ad-4ad4-7aec-08dce7cec3db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8nDIy0mONHh3P5B5SDhNzcpTnXTyM9Rq5wNDLzNy3IfiEkZvQYnvvx2220mv?=
 =?us-ascii?Q?ChFVsDPaznIxDf6lgcLL6tYLMl0w9RQid/MHPyFkj+DOagVCAvZ+FvAstz/U?=
 =?us-ascii?Q?f0z2tomKImDp2htvQu93QJ7QulWbcvwDMnyWE4BFq4wnTVb7tw+4L6+8Dg2e?=
 =?us-ascii?Q?r+0CwFzLtwk1RtMX5zPKS3TfVxeBP9GVrla8rgmUu4pW919oWjQNqlcJW7mh?=
 =?us-ascii?Q?5wPJkiI0WcX3rYa3giTAOgj5BFffyszO6CP6MXa19ycGWijeUFYvFevUN42m?=
 =?us-ascii?Q?ove2HZDhG6LsB/lrCcOLtWIP9phxpcr5SXQSjo2R3rt1sonORXVcP4638o6t?=
 =?us-ascii?Q?ns0KtXT44+0QLWFtBGS72Uww8KtPXuOq+V1oRtzM/rczHBGmy/Uh7l03aYTP?=
 =?us-ascii?Q?iLrdcNBi1o59QpAqWtdMC0EcNgdtGoxyfgCY0M4/kzEdFu9wzSuqi3YY6vjC?=
 =?us-ascii?Q?bhqu6JqdA9I90fyItgM4unMEln5GEAHvi5I2RUplg/3b8185yTZiuNKuxPp/?=
 =?us-ascii?Q?xT2m+trDSzhKGuRmf4M2b99xE6DHVEcl8jDjFwooto60NBib0K5dowbRwta6?=
 =?us-ascii?Q?ng7cMuS5Uq8icpo3uMGnRqJcNR5Hnu6gJBMbCk6HyiY1LJJV+roJpCOz+EIC?=
 =?us-ascii?Q?+gq1SmK7Jg+6nwDXBPrsySTztvg8v93pw+auASwpLP+LuS3iDhjRGqjvIhpW?=
 =?us-ascii?Q?qc7rZ7uDS3J9iV41oMJqccj4xv0q0cgRWNrnmf5VeZY6rTqKbgSBiLqFYOlC?=
 =?us-ascii?Q?Bjp6ITXwVOlpwD37HbMhVus62JAQtjVNorEpIXX97OFdmWZyfEZeAw5NINIQ?=
 =?us-ascii?Q?xJAUFjAJY4Lqljm4j0mGWxP55VDGp2qNzcubrHlcoqGJm7JOMr3q3EemT9Di?=
 =?us-ascii?Q?KvHF9D4kaGBHlPJniQyCUNNlZlJ04+tvDUrd8mLlc1Ws0ZQF78MdPihr6L84?=
 =?us-ascii?Q?5+YO4fKOkELUhJf3fJekFVKJnU/BugdvaXHakx3vByRtX+E3wj7f+IE6PRDB?=
 =?us-ascii?Q?YcxBltpB5RbXKPUL7hChSFulhK28e/eP+501cqXpw+moVd6aRbzJ75m/8Qbf?=
 =?us-ascii?Q?loGwVlOhCa0oyW3zZb5q3Df4ruOJK77xxkrEMPttNftuBV/cLEDoCkYoX8gD?=
 =?us-ascii?Q?AyhdpNbKKkLo83s/JEQ6VTYoig7lGYpmRZ1Bywc9Sh5X0c1qGaVGTJTN4UJu?=
 =?us-ascii?Q?H10p6bhu96p/65hkljFTlsz+HiT/CbrkPJ5XyPs6zENZBoWpPj0zWkg8Schh?=
 =?us-ascii?Q?9L67ue/Z+7t4Sq9YGE/deP+xGxytEMGjfqCwgBQ0VFz2LTri1aasbeVWjfgi?=
 =?us-ascii?Q?BTecLvo1hVnvOI6yt8NCtpVMWcS9ZgTX67i8tg31QupCGA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q3OpQoxB+bKdwVr/0uD1BMyw3rPKfjRPsSV8CeCQoShnojzlOMG4vANH2DJ+?=
 =?us-ascii?Q?I0oivqO9cAYs/W6k4u+9GdaUKCBKemsIQ1QqnmpHuEU0hW/87h0/Ly8qg1/A?=
 =?us-ascii?Q?0kUGkkFPYlUC5/aJWRimOUKEl/rBJkr77LtafuNWeEV8YIr7AoHXg6X+j+hQ?=
 =?us-ascii?Q?vJt0JZx85V9w4NV6waKDSIxr2liTpuiZ5t+dc1hHylmt6LmJfoh2AGfGnBsh?=
 =?us-ascii?Q?x8udYu7Chd1BNfczSTzPvvQ7mCSTy5l1ujt/ntvZjQ/i8ILinDne2hoJG3do?=
 =?us-ascii?Q?dvddHI8iMBZYCfGIt2Yo8OWkwEbHyHjoltaXKJRuBarG3cyNA7Cd0tzlD3p5?=
 =?us-ascii?Q?iMybPfbY38SBVTiGf/Iyp+Tdv/+Uq+X/co8WmJcryN4cAd7vsBRRm0NiTp1c?=
 =?us-ascii?Q?wfukPR90EK0+ELSo0SuroOr5BS+oE2qp0gDs4ZaReLiyQlSdjT/nzhLHyaxK?=
 =?us-ascii?Q?Ue1QYQDK3FN908VaqZptxRez9R7Z1ENtBvSoXogwaDjNUy32gHCtemkU2rZL?=
 =?us-ascii?Q?MVZcGYVqYJM2omgDEx1AdRxdBX/BGbHBA8caBXmVa31E4JgXg3IvbCVtsAHj?=
 =?us-ascii?Q?o3Gy2aK4R0YtoKXaCfKDUok9kj+qOc7qz5e5LeGk+tSj0rxMUbvwH0+UtBpP?=
 =?us-ascii?Q?rv7E2AZ+2QHHtGttDDl2BcWkksZtimcjvnbeuhjB3DNpTNMncSaX2VHs1KNH?=
 =?us-ascii?Q?GR7K5tBgfB5MzwI28xaqistonwtATnSP8swIVwIGyAlMpl4UMzkA8zj2Aw2Y?=
 =?us-ascii?Q?9h7/LwrhbBamZPjWOPYfBizaiMqvswjmsck+vJqHDXPu6I1lhuTuRPV2hHuL?=
 =?us-ascii?Q?8kT8b1KnyIUzEbKCa/p6jwB9+D/FzyLaaoY1AKnof5+Tt9r3HisBsZ4C9vnj?=
 =?us-ascii?Q?cx54oYPpmQWrjRfx+cwTeHzFxSrNU2CFV89LWfsgI0Bz20l61mpzXjKubdx/?=
 =?us-ascii?Q?QaqXILTyzPJjiRHq+yAM0Ge6ZNWBDUIHLcq2GJxEb2OAZgoDaczu+3PeyjuM?=
 =?us-ascii?Q?qs341K1lgOTtFayw8FVrmgygIuSsbLmh4At7YyXhXlLlEKVCa8bCpv/wIte0?=
 =?us-ascii?Q?cMO0YJtuNc3+6dP5HHQN2tS5DpnxCP4B6B0ou+YC7Hmrz0YdP/Cl5Z62mzsW?=
 =?us-ascii?Q?JmlZiZMS7E6rHKOyGDaaDmoANeypTUpWEob522PcMFrLi/52/5aTW0GCvkzk?=
 =?us-ascii?Q?3aq/avuo3OjvvTC5mwF4FFdU/M788pkbW6yonVxuZlodEDbEn8FF263wHX7o?=
 =?us-ascii?Q?yQMr5DpkoYnp2aWCBYss6j/uRVrMuKxjiix7leAyOOS8WfFEktvQ98hMTdO+?=
 =?us-ascii?Q?ntPdMGKqOTCdeIrvWdGyh3bgH1dSutVedDbFAPomi7JYXp4FuHSbZ/IzF2EX?=
 =?us-ascii?Q?hWBFy63aZBoxTVhb9Thm+TqK+u55sfQwBstuoxtH9JnJxgSwqpdPy0vUZKrA?=
 =?us-ascii?Q?f+2dpZfzZnGRT7sW+CU+UXCS3siW+tuidgtb3dDbb2kSLGnjb16SHbAZqIw6?=
 =?us-ascii?Q?8/HmL1QI/eNbTDSQt8lWs0APoDJ8EiLurcjgkakgzarIiuSCJjx2Z9FDMoPY?=
 =?us-ascii?Q?FbNueStKVpcakxCyQh8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d83350-60ad-4ad4-7aec-08dce7cec3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 19:24:01.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c69Bqic7TrEcNWpo/tcukt7qcetRsGZW0UjXIuCU+U1XbQTpaD/KIY1eowBbHKEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> Sent: Tuesday, September 24, 2024 5:32 PM
> To: Jonathan Corbet <corbet@lwn.net>; Thomas Gleixner <tglx@linutronix.de=
>;
> Borislav Petkov <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Jo=
sh
> Poimboeuf <jpoimboe@kernel.org>; Ingo Molnar <mingo@redhat.com>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org
> Cc: hpa@zytor.com; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.or=
g;
> pawan.kumar.gupta@linux.intel.com
> Subject: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
> mitigations
>
> There are currently 4 mitigations that use VERW to flush different cpu bu=
ffers. This
> can cause confusion when trying to disable all the different VERW mitigat=
ions.
> Simplify enabling/disabling these mitigations by creating a single parame=
ter for
> controlling them.

Just curious, what is the use case for disabling the different VERW mitigat=
ions (but not other mitigations)?  Is that a testing/debugging use case or =
a production use case?

>
> Future work will focus on combining similar code used in selecting these =
mitigations
> to further simplify.
>
> Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 16 +++++++++
>  arch/x86/kernel/cpu/bugs.c                    | 34 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..66b567c4dce5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -628,6 +628,21 @@
>       cio_ignore=3D     [S390]
>                       See Documentation/arch/s390/common_io.rst for detai=
ls.
>
> +     clear_cpu_buffers=3D
> +                     [X86]
> +                     Controls the mitigations that use
> +                     X86_FEATURE_CLEAR_CPU_BUF, namely
> +                     Micro-architectrual Data Sampling (MDS)
> +                     MMIO Stale Data
> +                     TSX Async Abort (TAA)
> +                     Register File Data Sampling (RFDS)
> +
> +                     The options are:
> +                     on              - Enable cpu buffer clearing
> +                     on,nosmt        - Enable cpu buffer clearing and di=
sable
> +                                       SMT
> +                     off             - Disables cpu buffer clearing
> +

At the x86 uconf at LPC, someone asked me about if we should have command l=
ine options that were mitigation-focused rather than bug-focused (like to e=
nable STIBP, IBRS, etc.).  The feedback I had there applies to this series =
too, which is that I'm concerned this makes things more difficult for users=
 because users are reacting to bugs, they're not experts in mitigations.  A=
 user wants to know how to mitigate CVE XYZ, and the bug-specific command l=
ine options support that.  It's an extra step to say that to mitigate MDS, =
you have to figure out that MDS requires clearing cpu buffers, and therefor=
e you should set this mitigation-specific option.

My general concern with this series is it seems to tie X86_FEATURE_CLEAR_CP=
U_BUF directly to these 4 bugs.  What would happen if hypothetically there =
was a new bug that required X86_FEATURE_CLEAR_CPU_BUF and some other mitiga=
tion?  With the existing bug-specific options this is easy enough, as the n=
ew bug could force this feature and do whatever else it needed.  But with a=
 mitigation-specific option like this one, it would seem to be harder as it=
 might require multiple options to mitigate one bug.  And could create conf=
licts if you enable that new mitigation but disable clear_cpu_buffers.

I do get the point that these specific 4 bugs are all closely related.  Ano=
ther idea to consider could be a single command line option for these 4 bug=
s, but is tied to the bugs themselves, not the mitigation.  That might be m=
ore future-proof as the scope remains only about these 4 bugs, not the miti=
gation itself.

--David Kaplan

