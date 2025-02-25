Return-Path: <linux-kernel+bounces-531806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7331A4453E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CD817EE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7674517A597;
	Tue, 25 Feb 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wopFDlm9"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021104.outbound.protection.outlook.com [52.101.100.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D894175AB;
	Tue, 25 Feb 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499272; cv=fail; b=SkDCONt4Y9bFKhqoTs0swBG0jCZtJpWh9tr+rKDmz1UiizcIDhCaVYbW3PzjHP7pdRE0MhS+gDjlvVgv/0JOIgtAWkPzZeZChM53RWUFdWbqOqfg+Vl26C8g7VGCQ3UzUrN9YLdQ46xYvC+vVLphVvZ/+rd8uy6e/sNr9iFAKzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499272; c=relaxed/simple;
	bh=1Wk+m+QppP6/IcBBNAVaocutPvgVj7mvw9Pcku0iOn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sweZ0JJDEXa93ywVUeAE36FjiILTDuI7w6ljuufDFXMtBLNwsI0QbcYV2YYEgaT5Bwk2IaUWsFrXBQYJpLs/xOtx6UzxjNRlWJV7K9FLzj4BRAHFjNZNi6TFH8Gqt4fNouZeDC3mqp7xSK8nofQO1bWpyd6BC7LzWScTB2vq1AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wopFDlm9; arc=fail smtp.client-ip=52.101.100.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1PDdguh0FaZ096XT1XWewvNkVDW/jJF8UXDsti/wY2+jw8AweFF/5LikE+h67oDmaunCJ39zxU2IWNz+CZ0GTCQYZUrlA3XKeeo1ZC2AAvRleLVdjche7+QOluw8j6OkR5FwnyL0cct92yur2pQiJ+3n1ojbxn768O199TaSCJQ4hPoRwV4nes5TlVGwCvO1H7eao3DX5nHYviKR9uyD19xfvr9dlcQSnxY27uDPcIOcxXgRIBVoJ61CzB3S1NbAb+5WcXzclON8Hn21uIRBVQBXS3IMGOkS3zhqPyfo8zbrk8Pc6GRtgNu1n6vjM9PYoALadOwDq87QUd0JqKIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENn5k7XxYLlkG0kz8Fq/NVkzSiFntkdJBEqGkdevBmM=;
 b=v6qTWgN4ij2Kwq+NV3eOKdBa3BkTvCY4zwD7LkfnDAD4EW3TWHsW8Zv2BaCiY8wvHTOimlJwhasgxupPpr86TB+qS03xZl+mcQsRi9npWwULN8B6KkKCRZZFQjRsbEgCpMuOMfZMsa+C3qY/1vAQwSHTdc4sYBanScycTix7lmzFJdzeA78aqONTCUuNCE3T45dMgPDgux2Ydo9aZEMmw7eXv5DoYQscscELcSCtK9qIge1R4eZdBTM2wji5X2snMUy1RI4wbu/0cGvtIabptvx3wSVx6TZU8WsKNMpGoM9fIPYpMD8hb9XmRGAXJiXRRwxOUGoj+N4kCGdxiKRHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENn5k7XxYLlkG0kz8Fq/NVkzSiFntkdJBEqGkdevBmM=;
 b=wopFDlm9S+48M+jiIq0GwthxSP573+jKbtNWyCowUZ1azM8F7wClfZi69wAvfAzvavLXSOS1a3sxLznwW2E+FpfH8TTx9m3f6eM6qEUZgK9tl1VoJYRoI6n8L3PlHslHWhiwIDBZGoE23SbZ2tbqP6XhY6Kq0/Q3yaOCsSaCdIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5491.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:159::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.17; Tue, 25 Feb
 2025 16:01:07 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 16:01:07 +0000
Date: Tue, 25 Feb 2025 16:01:02 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v14 2/8] mm: rust: add vm_area_struct methods that
 require read access
Message-ID: <20250225160102.3cb44599@eugeo>
In-Reply-To: <20250213-vma-v14-2-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-2-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: a65adb10-839d-45c2-74a0-08dd55b59d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sf1zAMfKJUaKicOSrIt5/h94sHsJK5CEh4eNpLXvaPnG889GxJkPla4/4kB4?=
 =?us-ascii?Q?x/HtAkkHiNkv7p177NZOhrwQz3M6uvWk7G3Gmxpt/2tyyaq2G6uDMaB88wpD?=
 =?us-ascii?Q?lub9koFiCo1oqC+ImOgJVZue3Op2BOZoDxySTIEFg66U0iEY5iA569komFlr?=
 =?us-ascii?Q?UHWQw4t7ri/FzNCTpJ+CsHI7be4TuxvAvKCQeUaQcS2WLAONBXxcKuU6Im9p?=
 =?us-ascii?Q?iMay2WarPTkTkQGforp78VVzoPeCkFBa4EbMPlmjbciVN5kftlyj2+Ey7r7y?=
 =?us-ascii?Q?EfTBThCdIvUSzhSMXdNKqHkPVhSY7WMS3yKpG/+AW5wQ6Xm+x6sSxBUuU6v0?=
 =?us-ascii?Q?wyt9gXFCvZdL4aM1ACTGZqYb0TGvhjgEbhswvoEy5fkrhpYpn1IfCwY0DBvJ?=
 =?us-ascii?Q?tvcR9OUAZk0Ri+UuTCx66a2vuKsaMUIr6SE5TMmXczARtnwMqpv7SpnetOqh?=
 =?us-ascii?Q?wc7bpDs7nJ+z6JIepvwjv17tuNJ299b9pWVDVM79SQD4EgWprEYCrSwrVflA?=
 =?us-ascii?Q?qbldV7YjmkzxFT/nOdtI9BtnDCL5me0T2HpNUKNTsYfRRnkdOmN/tBtaJtIq?=
 =?us-ascii?Q?cpc6ok3M3lkQJA7aQiFM2obbH47CzlkkfCAvKsp5iXFGXnEDbBPDvRzzZ1L0?=
 =?us-ascii?Q?FtAPdta4TR0kr8Fl5U9gXQKJw2ygdQ/BeOIeuqTdsVIZ5jbFYH/EnAzur4/I?=
 =?us-ascii?Q?ZZfIujg84afstnap84akO+bKw/TP1rSeoTowVLdidBzYB5n4JngZAd3x/brF?=
 =?us-ascii?Q?V6BBUXIKMcIV7wYPT3IIB7hdrxVGm8o+mXdNdM7f+cQsk7HvnWfki/DjNeoD?=
 =?us-ascii?Q?6BXpJxX7esAaNDf91NJknKp62JGzJs3XEFnP/271YJOj82baPw/ADuuDBIiq?=
 =?us-ascii?Q?D3DrC7+xsgTQfu/enaGKw0XA2b/2agVKAL8+ayAteMyg7+MKa55beJ4jbagD?=
 =?us-ascii?Q?Ien4iFCiFQcccJw3+QGVSgnUbnFgV5nYO8W8sXagy4hSnUgQjvLUH95KSFJ1?=
 =?us-ascii?Q?g31qFK1xvyP4Dawe88CNP2N0HgkfWIaOzCG5zVVg97mZgTYfhfcdXI+9iJJ4?=
 =?us-ascii?Q?iVjU+Da3P/UcHDOciOwDMkWMCFfX8OMXvOgxeP8uMReQdHsDAnMmFO6f1UOH?=
 =?us-ascii?Q?qDivcSG+fElVqFtYTIIa7MFEoYBGOE9Rh/n9eX45VxvkPDg3ytJ1yuH8sBYu?=
 =?us-ascii?Q?nuXx+LyNx9zRYSqhjbrkMM5C9MTNcdPHFVxzpYXdIDmXR4foKMbWF2wEKgBv?=
 =?us-ascii?Q?jlyTRJGOHFskw+WtewuggAHVP43ACAntsIqZO7U+4lPmsbSdpLZ1rkXzgrks?=
 =?us-ascii?Q?F7i6Wyf2v0P8OGHXtCUyzFXuwICgPs7FpbDn80RoCsRP2xsvqqR57xq73mjP?=
 =?us-ascii?Q?qI3uX7L2X14DPBcqrz3b2RRYty77?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0UQHaon+I73dYBR3wmEEt5ivXrv5aVeC+w07vur9ZfQSj+XPlVYwYRtbYsg?=
 =?us-ascii?Q?+bn4NMZ1CfgFa+aik5nWvTQ1XHDJU0OnlWgnf3OvT6nLnPOcoyIKwDPvF7Jn?=
 =?us-ascii?Q?XXQll6e0LFQX8Qpc+GJMfajzIhJQAj3seQbndSMP8Jfqhr/QyeYNi+mqvM8X?=
 =?us-ascii?Q?XvhUVcYa3htZ0vVYs0CgamEPeVpCxMYnP9h+rSLXFrUwBEAyDv2rb7sSJNvX?=
 =?us-ascii?Q?cyNJKqmdBhdtjUwrcPCxSaLGLt4b7C1OHrUVklHGqYOcms8Y0mNnsaYQ2pxS?=
 =?us-ascii?Q?VHscghNhSAq7T+KcCj5V0JeSCk12OJSF+KtIkDq9hk9vRXoV4WbJ/v/PBrmZ?=
 =?us-ascii?Q?Pu1P/Q5ivkFabl4mWlSSxOd9+ZLu3bfN1LeOs3lIsCjjPOwDmUm5KUSJppm7?=
 =?us-ascii?Q?7DnF5ZRWghPjSp9q9nq6V0oGirJuQzlXiHqVbzc22trdJaCL3a/o/plOCQ6D?=
 =?us-ascii?Q?Ot/6OSKu37qwPj80ZhM2qnEqcJXjk5EbTBw3xklVwrvBhGSgNINGphGi40lE?=
 =?us-ascii?Q?OB3xQbAqcGjAn7lH0uYfkYEILxKet1lO4GhnSOsZoXAKmuXgsp8hnFB0O1to?=
 =?us-ascii?Q?Al148BjhU9LBbQg2KpS7TXqaiZVtOOCuEXO1laECKdk00GdQfkEbLcuPeuit?=
 =?us-ascii?Q?AVPad9UaQFCOGFqIkvl/FTTSNhpmrN/YJK/7MS8Ig8kiB/jyEYGYav08v8X0?=
 =?us-ascii?Q?JrJiO0vKh0larmHnO9uDS0m02hy2mOKU0x33WgFKPM9p8Il7itrGaFn+lzlR?=
 =?us-ascii?Q?UfKnAHg8PJD3B14P7XXKA7VpV+lsy4Z5FGFZ/psJ7m1+CQUNH7RY8RhlquWi?=
 =?us-ascii?Q?jgZzDp0h7wk9Ikl8j6R/ij7FSepFdGbo1D21RgX0II8dqKeV3L4j+Ua1CSC2?=
 =?us-ascii?Q?ZN8MLtie5cwOnv/dkEifrcu0auLhjL9kVHb+E8KRB2g+h06p3W0zpf7Y4xAF?=
 =?us-ascii?Q?woc0Ya91Bsy6NiBZbbe5u2ZIqvevfEXwaMLX+41W9dTOmBgXpXjlPwN+zDbK?=
 =?us-ascii?Q?F7COltcTe5JaPQhxMG/7xdWLC9c432os+drVNxW2hw0+FH1oFVqaoppWsJVO?=
 =?us-ascii?Q?TVZe1TH8FOkAFNYaQLd1jK2Yd4svVQg8D2orYhNRQgNukKQiyAdiCxP9HEJo?=
 =?us-ascii?Q?d80wCoALPArXLtEDPa9Ecjw0OmHA4LcfS1/QgisiwRhq+XOHsELhVXrvVwIq?=
 =?us-ascii?Q?b/Ss/jtjolA/HvN99M0TIBXxwEoC31xNCd6jFk4/LF5xtkyb9FnG9GZ8EGkI?=
 =?us-ascii?Q?nmC5XDfhgeMTJQe4/IwBZiGTtOWsCezX94z7o1j6kr5HDnVLfH8VZw4S5XF/?=
 =?us-ascii?Q?93dyOW6NYPbALD6jEclbF1TxSJKBkou4vU6KLLmYx+gf5G07bd9+Dm0CZhLz?=
 =?us-ascii?Q?ZPU+BRAcjtwlwakeFwUn1FaxnKWeW9fXuJ2GyMU/pyJu+tNwazkNa61g3oR5?=
 =?us-ascii?Q?bwOaPJifkeiv+HO2iJXRihwtbZgcQRmk5dl1i45/2T+x0smjg6EVMpSqCzzP?=
 =?us-ascii?Q?KlseBZXeSpQ/fwIjC6GBm7xuP0HjzzELJC3+04uAvXBiuyVSm986kkpnnXdC?=
 =?us-ascii?Q?8kj2ZDhUQEsmuoHgbPeR5OsKZCg+YyZKeBagk7i6yFM7dDIyA49+RXS1/BDq?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a65adb10-839d-45c2-74a0-08dd55b59d0e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:01:07.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQFzUiXwfMhVzSJfasfSzJUZB63csl84ledGr2n8WKUUIQVIXF0dAy2BpGmhTkf+mHm0mG4F6kji9tSacgja1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5491

On Thu, 13 Feb 2025 11:04:01 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> This adds a type called VmaRef which is used when referencing a vma that
> you have read access to. Here, read access means that you hold either
> the mmap read lock or the vma read lock (or stronger).
> 
> Additionally, a vma_lookup method is added to the mmap read guard, which
> enables you to obtain a &VmaRef in safe Rust code.
> 
> This patch only provides a way to lock the mmap read lock, but a
> follow-up patch also provides a way to just lock the vma read lock.
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/mm.c      |   6 ++
>  rust/kernel/mm.rs      |  23 ++++++
>  rust/kernel/mm/virt.rs | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+)

