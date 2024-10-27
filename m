Return-Path: <linux-kernel+bounces-383730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24ED9B1F97
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E0A1C2096E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C392175D4F;
	Sun, 27 Oct 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="soYkb2Hd"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2078.outbound.protection.outlook.com [40.92.43.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328271CABA;
	Sun, 27 Oct 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730052980; cv=fail; b=Ze+JXz+982SBLGeZG2xUuzDicPGrB6aPNYCVgWKDmQj04X/ojTx1Y4/DhtgCeheBU0M+A5wy903ix3jsGuRNvvNBTO9jbcZjwiBhmXqNJMQR5iqO9zwlnGlp8IcoqrNxTLVI8Spy6fUv0lzTFAKc32rj1wqWkYxbi7KYN2/LEiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730052980; c=relaxed/simple;
	bh=cACanpIN+OckKsCauX24L2azFqvQIrL2sp356WXoZd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=inKUpxJLPAEr33IE4ZX16QdToTegYqnlFu/0FWwSOGpA6ApXThI4ZwZXvkTvmFv3qLOt/JJcLJTyBZMwE8lCcJdct2XPkFno8FW2QJXTXi8xeNTl4VHFp/VANVhe661R2xcrrvd2snUaZCgmuG81RFQb+ddJJYwA4RraOBsxea4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=soYkb2Hd; arc=fail smtp.client-ip=40.92.43.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYEuwebuBKKtdHG3G/zKr6Y0qv7xsBg5eg1pA8Bbf35SUBJ2/mB6fs6K4+WZW6QgTqytFJ4RRQp3DPfFGVZJEZtsgpdCAMRonwROyemECHNiADPS+JUA8RzEGTNElf+qVtAG98tDjvGZ81k56DR2V95Kzmp3SZR+thUc5qs3G1hWL2ILWmS/KUxBSHJKMI8Ee6cWGzPr6osO9TmMzhTO9vqCUPLLuIHsnxmSkAuMX2KLgQ5XsTjUCutlNjYuqgvaD3kz9RUKZXaIYDqlHEkyQL6o0cKxPp/dqytJyp902Aso5+Isi2BaIbcF+JmzuAZzSRmeiSvwKDcaQyxjKXo34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF1tZ3DDudgXDMkMtuZrdtfh9spaAuUXzeHLhpNY0rs=;
 b=paC1Sq+N78vdhvme2uGsgDqd7Z4r0NtNotAS0puTVdyIUWNqZlxb35fAVTOkOfTxX+sts0jm504SNLk8G0reh/LgVSAnC0d0y4D0VHsh9TAM3sh6XYqFiivnvtjPqtRqr3yCzwf8qG94bcfjSCgV530IRgYEWjaiQTaTjKyY/jC5pkI40omK3FrZw5VkMn7vZGyKP4+C4P/ryTH0C9W2rOT5BwNkxMtYu6WCM6BJiIIKqJU9VaymVvEJUAXzlr6sOI/w9NqHVoqT+ixS0nWYF57vQhUVy79mtzrv1TSBfjGDOeJQY+7cqiuTUfe5PdN9ckDQKAt0zwsylya10x2eaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF1tZ3DDudgXDMkMtuZrdtfh9spaAuUXzeHLhpNY0rs=;
 b=soYkb2Hd3tXaQ+7RfGCCp66k4idBx4io3JUABiZ4/0wAEbIr1SujbMDw/M+wkKlpDllJ52Xfop8BexKz463TYJsvjfKWyKsEXDTRNC7678EPxo1NfLsiO9ab16m/KIe2elWvH6PO4+364V+apJhIZBC1xqQdVmGvoo3U2QFxTtSskOT2dInnvY4Q+Ug4LADFgqD8PjDJehZEWMXKkM05iA5jFPptxCDsCo0FJ31/vnkCUaOLITC3TvCCux+CRVmMBkkC+dghDj6Tn/H2+7fhev2Pf+58O85r6mYp/ME0Dp6wwTn33RY7exQHNh/Nv+INHWPWo0oWyJ5y2G3bGXSobQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Sun, 27 Oct
 2024 18:16:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 18:16:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "bhe@redhat.com" <bhe@redhat.com>, "vgoyal@redhat.com"
	<vgoyal@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-debuggers@vger.kernel.org"
	<linux-debuggers@vger.kernel.org>, "stephen.s.brennan@oracle.com"
	<stephen.s.brennan@oracle.com>, "horms@kernel.org" <horms@kernel.org>,
	"kernel@gpiccoli.net" <kernel@gpiccoli.net>, "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH V3] Documentation: Improve crash_kexec_post_notifiers
 description
Thread-Topic: [PATCH V3] Documentation: Improve crash_kexec_post_notifiers
 description
Thread-Index: AQHbJvnmbOpHVMum9U6tJODk/l66f7Ka59EA
Date: Sun, 27 Oct 2024 18:16:15 +0000
Message-ID:
 <SN6PR02MB41577D176FD038A3D630296DD4492@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241025162042.905104-1-gpiccoli@igalia.com>
In-Reply-To: <20241025162042.905104-1-gpiccoli@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8715:EE_
x-ms-office365-filtering-correlation-id: b7a42753-cc69-48a7-d20a-08dcf6b3722f
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|7072599006|461199028|8022599003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 G1PYCkGfOb/m5n8vfqyfqbtNvTBEZ/+hyoceaEPuYdnxnY8kojpLO5agMoZbh/LIZjlebQBwbVdgh6vDk4v98+D4dqm6f4OkD7kNFK9D9ySRyocIGasrTDyiF9aCehJDAQiBjOZ6cEGuOGK19itj6XRijYCy3AtJJ3N+7rTwA6Qh1/cCvamLA6zAlRL4Y3S6E9FucywERywFbawDkWxehhtlU14ioo8da++Ttbp2/sBDZ3cZu1FGcOdVnFNRHF/SkQciCV1YUpbA8BWeGV7A149FYw6wGNVZ9Bty506SvA2VoDCEurXjUExHXOOWGHJv0TOtuCyO7zJVDVARhoOyEa+6PyegPBlB8QcbrWKbD7IMZWnA3StU4gbGn36RiisMAsHMC6pHEEopzKd/y2092uWEiNQtPbOU+aOS772shwEt101/nOcODlD6GXtnvyaecM0Jt1GWNh3QZL+7FW9Wh5gDjyZQRxVAIDChfs+A6peWSs1KWaYIYl38VZtLnYZy5oOBaCih5u0e4QS6Son2Tfum+W0RVQd2FXdl2uOpvkd667JIorl7BlECzTUzk4JS3w0P7TsHCtgwURAwfc18YEk+ArSSHtZUTop0RxuxU1rYWdi2rLSAXW4xQ98i8yQG6OBiA9TpfeiAZ+Rs0vpE/EE3VCg3isB97wE+yQP52xapwhTFs7x6EnVZnOujtiLf4LUIYMNv6LbyKRguH94gmDb02ESqfGzQ9ts3mEOTDFH02ZXHg5mimBkwnaRxQuBwpK8fqwnNFPpKH5BBHD9+Dg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/tU0FWjmima2RbYYVkqwaKN8CBQrp0NOeC9HSQ3SrcAVqN5o+93wk0vrpY9n?=
 =?us-ascii?Q?7H8qfUb1gkFO2Yqw0H9LrH12qmV2bBwSB6L6thzB3P4cqdH9qWoR+HQ/WRXv?=
 =?us-ascii?Q?3Vr3CIoaj9v4uL0zWp4fMt58LKKWz2ZinPx80pXd/bObgMfJNJHW8y5lINnQ?=
 =?us-ascii?Q?F5900APL2NDJxFrJIW2Mw25ZJE3x+xghdwbjkwjCW6Ow7U6Na22NdNdTsT13?=
 =?us-ascii?Q?Eg+pl9ZF8Te9YcVcdyhSm5zmjrqhBh/hqwQL2uvP6W1iYcmEZA6VMFsg/DRJ?=
 =?us-ascii?Q?HNN/TOetgg3xGaZloxSPVG/soVNbbfevOKar/AP3kNg/za0FwhFmVGHmKoDq?=
 =?us-ascii?Q?5nucpzNsSuKd+QoG/YvuO6lDMWSXbtYT7dZBPTA5sCfNwwLxXUlOk0auq9f9?=
 =?us-ascii?Q?qofLCNi4BneejcfIscqwo/kttGVNUQZA121luSHMufeDeJqtjxphc/X4rIUY?=
 =?us-ascii?Q?7xcaP1gFA+YOnp0PcMElL1SFT+MLcLzxegi7md/NIqLD2nx3Rbl0YF8wy+8P?=
 =?us-ascii?Q?+AZmXnwnqJ+zMRsE/OnLjjRQVyH8B6V3ekYgB/GeqL/86PKkMTMd4+udDOk7?=
 =?us-ascii?Q?zzcMIPKHpeH7OMCOQ6ZF1R47wPrvzCzdxnUn9HyJ/B4nqaW+KylsoHdGCX8c?=
 =?us-ascii?Q?n4V+OUSwCdkWWRxCRX2U0/5BzcxJAV0CzHRN/kP3lovfmwo08ZtPV5G5txUH?=
 =?us-ascii?Q?3MIXmRlaXTRFrHz3l6k5ypnNGajN0knC0h05tMjA243RUyu2+Hl/38uVxc3f?=
 =?us-ascii?Q?/OdQkaRrK5XN2FalgEwcKfe2dx+hTWMipuGgLveabgZLWAiSWx4bG+9Ll+jv?=
 =?us-ascii?Q?HfEs0pPzJrHWhKd623voinJmSaa7z/A+tSzwX8rS8zEpu+mIU0CI7pGz4Nr1?=
 =?us-ascii?Q?kldFTYY4jVPDW97QnDJjckkkajnRs7G52wrLApStjHpVk9842oAoqy46IsKf?=
 =?us-ascii?Q?FFzZaMk/qEZha5W5T8d130cPmeRZ+ItdZm/wFqv4cNDKEUp3o0e1+npMWRbr?=
 =?us-ascii?Q?J4VK+4dajQOCYcGqwnvw6OAkSYg9ENBudEpJx3TFjh+p+3XNtBCju+sV8ykj?=
 =?us-ascii?Q?9k/lpu0mkPazu+Gd+nlEk/gLgRTGo8r6tk/Hu0Ek5IvHtoPY2pBLyky5TA58?=
 =?us-ascii?Q?0mXC+hK+Riws6Pu/veM8woVURdJaTRbkvIzq8VtqL4y/LUOIhNNHEPdTi1KL?=
 =?us-ascii?Q?9qNipNSAzu6hobf0/H0pJ2LcbULAtmPb8S5d0P2E92Xnrim79Pd5qACFr68?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a42753-cc69-48a7-d20a-08dcf6b3722f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2024 18:16:15.4950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Friday, October 25, =
2024 9:18 AM
>=20
> The crash_kexec_post_notifiers description could be improved a bit,
> by clarifying its upsides (yes, there are some!) and be more descriptive
> about the downsides, specially mentioning code that enables the option
> unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more
> recently, AMD SEV[2].
>=20
> [0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg=
 before
> running crash kernel").
> [1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info i=
n vmcore
> generated with panic").
> [2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP fir=
mware
> shutdown on kdump").
>=20
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>=20
> V3: Improved wording and commit description, detailing more about the add=
ition
> of code that enables crash_kexec_post_notifiers unconditionally.
>=20
> Thanks Baoquan and Simon for the suggestions!
>=20
>=20
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 3978fb704c53..2a7a523bb90b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -918,12 +918,16 @@
>  			the parameter has no effect.
>=20
>  	crash_kexec_post_notifiers
> -			Run kdump after running panic-notifiers and dumping
> -			kmsg. This only for the users who doubt kdump always
> -			succeeds in any situation.
> -			Note that this also increases risks of kdump failure,
> -			because some panic notifiers can make the crashed
> -			kernel more unstable.
> +			Only jump to kdump kernel after running the panic
> +			notifiers and dumping kmsg. This option increases
> +			the risks of a kdump failure, since some panic
> +			notifiers can make the crashed kernel more unstable.
> +			In configurations where kdump may not be reliable,
> +			running the panic notifiers could allow collecting
> +			more data on dmesg, like stack traces from other CPUS
> +			or extra data dumped by panic_print. Note that some
> +			configurations enable this option unconditionally,
> +			like Hyper-V, PowerPC (fadump) and AMD SEV.

This last line should be more specific and use "AMD SEV-SNP" instead of
just "AMD SEV". Commit 8ef979584ea8 that you mentioned above is
specific to SEV-SNP.

There have been three versions of SEV functionality in AMD processors:
* SEV:  the original guest VM encryption
* SEV-ES:  SEV enhanced to cover register state as well
* SEV-SNP:  SEV-ES plus Secure Nested Paging, which provides
functionality to address the Confidential Computing VM threat model
described in the Linux CoCo VM documentation. SEV-SNP processors are
AMD's product that is widely deployed for CoCo VMs in large public clouds.

Just using "SEV" is somewhat ambiguous because it's not clear whether
it refers to the family of three SEV levels, or just the original guest VM
encryption. Since this case is clearly SEV-SNP only, being specific removes
the ambiguity.

Michael



>=20
>  	crashkernel=3Dsize[KMG][@offset[KMG]]
>  			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
> --
> 2.46.2
>=20


