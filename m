Return-Path: <linux-kernel+bounces-332916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7297C0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA755B219D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04BB1CA68D;
	Wed, 18 Sep 2024 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hwr4y3gg"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2105.outbound.protection.outlook.com [40.107.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424B15C138;
	Wed, 18 Sep 2024 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726690341; cv=fail; b=Ije1kYXmGsym7c6Uc3OgPGmF2Eo88Im9107l9qgjmWlucKQQhrfdRn78F2SnXrP7y1MrAyUIKjOoj+tqy7Kbs5nDrU2wGs3Kgt3hH6NG1YERxYaz5IJ5j0/CNXsR3DoARFbhqYT33ldRnGill/DJNu/KG7S+CcDu0n0c7I4S4uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726690341; c=relaxed/simple;
	bh=XoxX87BMloiHEDPPxbWyDnjCyTV7HERAcPKN+7MYFsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUu9CByDUX0pkS4vzmt4aewIOxB8C9NEYOwb37xL57FD3qTGwCJ1s0Wc0zzAm6nQ48ZRVgWscN6L4XSQcxV6+Nujco685uPhFiw0weSnszyqbnHW/Bd/9TgsRgS3emoNevUTZpo4NxoS93mXHhPhW9LmC863iDCr9trnN/JCSnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hwr4y3gg; arc=fail smtp.client-ip=40.107.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsqMXn+ne+v/SYyQ+sPAFuwU8ITBLpClITwH8R9SPL0rDHe/9PhT+BtAEai2fzMroXWLDFA/pITkBYc24ZdSvcjuYX4V+VOH5qm2qJeokG55LyVfej5m013rV0zZ1LXzgFle3MbFLVHlNOdnfvvHAvrxxobltJTZxUKCfnb7o6BDpYY8kfj8YOgD80L5/fFgO6NyiKRAxMerNrCzWmmxEo6czW6+4HuGurrmxXayxOg/j7ZgXgdaPYpySySZX6E9uRgyX60lQujEIyo2p3zkE8sQWGamTrOLye55PYP3TjO7cFEJauc+8ihnEIiBfPpfWQHvgu3juzJt5dlPbQ1YZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSI7EvIecFwSDJ+PK3MQmFyycjVu2AaFlDXBADwX/us=;
 b=i8gLwM8eHST1DmIMTNxWfATgbnbVWntqujLty36lugm/mvGYc6SaXBWlrunGWfLwkw5QY3N5Vae3661PpB5sGWWRVO0Qre9LwRv+uUVAN+u67Ah9L37TiOlwQQVmFpFVuTQl8+QFFoHrLVeqAXHID4Y/5v7OsUlugEONApjWEjKbKi5trrvQcGOb0mvXVizMW6pVyDAquTX/udlNvgLKAqg72/oSC4K2wrPnf10i3vGFlhVplE3t3/sbJQunRrAHOvA6Eclch0xi8IJz6lt1NstQUv2ZskuVExaF5HUVFB6HIljCD57fuiqAxDEE6e1kVZCggFCLGCEP00rLw4hnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSI7EvIecFwSDJ+PK3MQmFyycjVu2AaFlDXBADwX/us=;
 b=hwr4y3ggIzimMjrpkRz8pfiE82XDyY6kVL+JWmUnO+cyrPlhVLou/0I0TatMjQsA9CE5ekfv+JKx1ggXAFhWf9oWQmo4m/j2Q5Pv7UuJDZx5PFW3iMCFha+cY7iTbJxBf4k3anBtYs16kBJg/uajn3BBlFNx/mWejgLJTPBSLPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7394.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 20:12:16 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 20:12:15 +0000
Date: Wed, 18 Sep 2024 21:12:11 +0100
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
Message-ID: <20240918211211.73b1324e.gary@garyguo.net>
In-Reply-To: <43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-5-a.hindborg@kernel.org>
	<43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: 14def1b6-b70c-4974-a105-08dcd81e30aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xmY3K76Bpz6Qv+/ISzdUQiWApWFwcy6W3gVR/8eXAD92sl2gNUjl59RBsmtu?=
 =?us-ascii?Q?Vh/Fgot3QAhiyYsV6Nqft3hRf9V/sNYHuhFCOtUzBw0SRolAHZRVo96GHUbi?=
 =?us-ascii?Q?IOAoD61Og5jdY7Ouy6z8F+JSFyNnVMyT6Jo0ZzfkvNpbopaWjf6eDr7YZjMP?=
 =?us-ascii?Q?vfBYqoHAx8ck7w7X9m3QygAfiSH7H1IweCmmVG8PeIzRKfvH5vitOc8UaAVw?=
 =?us-ascii?Q?tnTwoH0vJKPVDTli3b4V52nzPxLa6X0V1qiugYENCX5tFQvCjTH4EpG3gglZ?=
 =?us-ascii?Q?qbsh/ILI04L8W8e3GdxQ0Nu1cvyM4LwzsdMBLy8dAPeg4iZsvonQZF4ZaNio?=
 =?us-ascii?Q?+u8HDaLkOsVxgATP0CfzAD49+Udxpw6kaecNuq4SiUQNeLmyiZEreZuTt465?=
 =?us-ascii?Q?T1OSyt3z90Ne/xIgsqRdyMUewp18qfhOPXMPRnUF1tSXNkRN+Tn56/t1Mdo6?=
 =?us-ascii?Q?bfi0CW2CD3ZT9GvtRxtnYkcSNfxFRgJMGw88BOVylAwVRzbpJBE05AdJudvT?=
 =?us-ascii?Q?9HeFWeNelaWa9D7fCvdPgAIGVCWSwjlJpvcGkh+X0q88eNB68glKe3YFZtCZ?=
 =?us-ascii?Q?TIH+qG5S4hnc1MIe31lV0Tm/1MyhVJfWtEFkKvOR66UyOeG3OluuTkYubDco?=
 =?us-ascii?Q?E2xplLYyEIU0bapcSK8fmZdCyf+1p3tFna6rOZbxW8jtQMX/PhkcVLVyMepC?=
 =?us-ascii?Q?MuCoamEUqzHwu+poqLbz5sOxXhd1xTFzuv285TR//sKZrAWOqCKx+3H+v0MU?=
 =?us-ascii?Q?x88kTOVVaC5LGMBxB1/9iL3g4WsU8VFoQ28ylt+0n0NyglpDWk13X4WlNA2t?=
 =?us-ascii?Q?Pyafuf8vyntT8M4p70QHSUxw7Vn53vRoSJo/L0RNOCgJ3Y+rb7O8v4UKEOuj?=
 =?us-ascii?Q?rk3vgBgAZ3JwiDRic3FpqJI0c3TvPA2OlcwcouiOJEoeXsmH3GnXw2AJO6Pj?=
 =?us-ascii?Q?NmB4q3LSuzDZHQi00E6dZI8QOfyCAc5xOgfzFvSkc3To6E5xuGWYMRhnlKAM?=
 =?us-ascii?Q?QwPbJNt4hpBypEcNq5xzMSrKqyJqzsOyaeA83gUbQ1080DRKlGWKW4+vAyVQ?=
 =?us-ascii?Q?Z8tFZoE9vjKVta2IMFGFCV5S1QfxeR7hxOXMJLETDHpe6i1pChjPKAQap2XA?=
 =?us-ascii?Q?PovlB6cTJEnXEpgXorhpcKCIfPNiysFgKq13qkqQOBkZ66AeMiBLtTh4sFm9?=
 =?us-ascii?Q?gblNWTbHIpcZYt/R6Sskz60V6EYpoAj11LGujbCdWHwqL1GFymBjFFAP0eyj?=
 =?us-ascii?Q?KyUXtcSrv9tyZNvSWCawo3VwgovmQZlVkzhIE9NAyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQsxMN18BcfIztlKCqy25z5vpnoebwU1ahE9SzAb+/sbIxn1zQCc/Y6No3w+?=
 =?us-ascii?Q?GDMvPGkQUEwxC8ZLNA3AEzBcmlh3eWfef+B8iYRz+byECDRWcapR4N2Q8s53?=
 =?us-ascii?Q?AcIRrmCdgYryMIkkWCZ3R+Vpj8dJhD9ErCc/YHLf8yTX00x2ZA2R4yOqBQ8e?=
 =?us-ascii?Q?aYfqjR/8nruG9Fr6pL3GLjG/FcMsyfEBIdjbIf6KjUkZ5bcwAi4DcF6zN4kc?=
 =?us-ascii?Q?gfysX6GhTN/ivZdPh4OI56Mnnk+hOGuN4YRa/qC1N+oXV5tyYk4nXbqnY0Eu?=
 =?us-ascii?Q?o6exUDHlFW0h9TFzKkMQTfJKnCT2zbRwMyRXA6kTvd8GF3KlmOeYe6NxXStQ?=
 =?us-ascii?Q?Z7bsYa2/mmHtDurIePhE+EqzfL9V+nL9x5LYhlzC9baZhFUinTQzwn3pfCoz?=
 =?us-ascii?Q?EC7933OKm0a2r0PjGAp+kWll06sE1d9Eh57wX4cI0SVwrRgk/SuheqZhq5aT?=
 =?us-ascii?Q?WYlBKf6VyKUpgAMDq1jZQhN7Is+1FrWiBvCuWq7N7JYvQwwd86NlXQ3hOg7c?=
 =?us-ascii?Q?/1uSvh8LwWBEJJtGL82AhM7kg3HcWp324jDmdXSIk+f61BSWgnW0INYypsa7?=
 =?us-ascii?Q?B3LYik8/X0CZTtrhyHYiNWOdRsaxoQpsDsrBKTB3BVCeKEgDrpr1rsXmP5iL?=
 =?us-ascii?Q?I5JtLdrVTyKjOlV7m6XgOfIB6rEpPf0ALwgKJwY4n2bssEmDTNPkClbEb9aD?=
 =?us-ascii?Q?LSjsMLlV8Su62QyxhNijE22z+GsOQW24GqBAZLzCrWkEjdaVA6yB43L4+0JT?=
 =?us-ascii?Q?HIZ4lsONGR7sV70j82/+w2QX15fpTBnTzXrexFtg+CWbp73HSOVeQl4MvaH/?=
 =?us-ascii?Q?cvSDeAFc+ETuOnxaY1qCkAgje5gdIoyGbaQq7FueCbBnTCyehCDJs63v7xLj?=
 =?us-ascii?Q?crajDQeW2xBOjMX4KnINmfyOitWCKcfmGLIF7whyVt+UcpEOhbPS2zeYjvia?=
 =?us-ascii?Q?h+p1TL5q6Qct5F1W7RuL0jLOgy84c5WaX6k3Hm3Iu/0uNpSXdlwQCEDVIhk8?=
 =?us-ascii?Q?bWCBpbGKcybgzMmD3JTKjQdjI56SQcMS54eSMVWbG1y7tpWU4Q9nNRDPSU3j?=
 =?us-ascii?Q?AIYxMsnA0XMIK9szzN/2ux/RZ7L8CQFHzZJ3lubvawD+QJjsuxY0PFQ/ZAUT?=
 =?us-ascii?Q?e0GSJcyfLyEpd32kz8fZYk2GyW5lpJOfupViKPULdGLEW25ManIANpDtQUbR?=
 =?us-ascii?Q?M74bZnQ1wZi0Meyzks3p39Nqc3Vf3rWOIoTQMT6CcMAC1cgnCsVmV36RFyS6?=
 =?us-ascii?Q?+MrklDDL6+7m7ISehu063MlwBHqy16nAxk4NroUqlBSfCj+6To31AI9C+ZXZ?=
 =?us-ascii?Q?OJHGrGpJuLdKTXHD2T9Jpc5HpuuGv6MfRXDlXnF4mvSOXk6pw4EJ69mZEVS7?=
 =?us-ascii?Q?ERai/tS4vbipPffhUZLZym1gXC8EAIAVLnk+XvUaWikjaK+oMe7BGh9m/sot?=
 =?us-ascii?Q?jnGq6+Avw5692iEOHYZX+dwsYxR1aB17vyrUZxXrlxEFwlZ29E6W4o6qaNIb?=
 =?us-ascii?Q?Qbr0UnQX9WwS6ftuc86vZc5an9dGTsh4677KaeUgV2gh8sctANFbL+sUV9mb?=
 =?us-ascii?Q?2KpcYPLrBACybA09rp/19Ix6mjQQhe2Ue8x/ckvp?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 14def1b6-b70c-4974-a105-08dcd81e30aa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 20:12:15.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3GRgYHaeeFQZjkzgp8u3jaJe0oM6CUfxVTxlkCn/IVl8VhxoPRcyU6YqsUilLeJFl5ct/XonDxCFm0u/gv2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7394

On Wed, 18 Sep 2024 18:19:20 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 18.09.24 00:27, Andreas Hindborg wrote:
> > Add a method to clone an arc from a pointer to the data managed by the
> > `Arc`.
> > 
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> > ---
> >  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index a57ea3e2b44c..2c95712d12a2 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -282,6 +282,26 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
> >          unsafe { Self::from_inner(ptr) }
> >      }
> > 
> > +    /// Clones an [`Arc`] instance from a pointer to the contained data.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an allocation that is contained within a live [`Arc<T>`].
> > +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
> > +        // SAFETY: The caller promises that this pointer points to data
> > +        // contained in an `Arc` that is still valid.
> > +        let inner = unsafe { ArcInner::container_of(ptr).as_ref() };
> > +
> > +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot
> > +        // overflow to zero. SAFETY: By the function safety requirement, there
> > +        // is necessarily a reference to the object, so it is safe to increment
> > +        // the refcount.
> > +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
> > +
> > +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
> > +        unsafe { Self::from_inner(inner.into()) }  
> 
> The implementation of this function looks a bit strange to me, how about
> this?:
> 
>     // SAFETY: this function has the same safety requirements as `from_raw`.
>     let arc = unsafe { Self::from_raw(ptr) };
>     let clone = arc.clone();
>     // Prevent decrementing the refcount.
>     mem::forget(arc);
>     clone
> 
> (of course you would need to change the safety requirements of
> `clone_from_raw` to point to `from_raw`)

Wouldn't this function simply be

	// SAFETY: ...
	let borrow = unsafe { ArcBorrow::from_raw(ptr) }
  	borrow.into()

?

Maybe this function doesn't even need to exist...

Best,
Gary

