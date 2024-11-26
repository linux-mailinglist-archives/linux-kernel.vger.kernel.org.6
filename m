Return-Path: <linux-kernel+bounces-422577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930069D9B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A71283889
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59D1D88BF;
	Tue, 26 Nov 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aHfa7Xbg"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010007.outbound.protection.outlook.com [52.103.11.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00918BE46
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638344; cv=fail; b=PQ+lLBOg2mil4mrfr0zhEIEmGAuw0TLMecKrG3fYjgLpxPaTlMDFFArdVJzxGv7O1QCOD+yvCDBuJDp5YBrhv2JHricrq84x1CgTCqcl9ylbGbinQiVaA2v2lTZmRJ3ogNz+9b2nhcU6knFKx76pVypo5CVoxOG/HDSdUNFFE9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638344; c=relaxed/simple;
	bh=5SrVMorzE4PHK3aIoNBCD2x1xoYiNH4s1ddaSVc/Bhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=olYKShf6k1ptlnHGPWflSrI+iY1XMXUxg9W2pd5niZtGFkNODW7lrLbJ1SO9EruoCLhERTiSgZ7YoEtzYYu//sqe+KVHSg0F5mWSxXZ9KfEs05oxVzWQmyCBHFHHxkSLPYUmolUpyM9TahNl9Y4fTYBJjKskSRMHNcDD1jtwEWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aHfa7Xbg; arc=fail smtp.client-ip=52.103.11.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRPImrE2+ghKA3Wb402H4i9N/Hqk685rHGB5LV0h9m/6JK6t9DYnPCOmlWqm8brXQ1mILrFxaZ0QeuONGWcJVjqGYfz5QkZUO5Z6ZMVBM7bquS9TFoSjyGk5OOn6EXNt/fd30zzFwkpzidGiyVzHWS741eSb31Rg26SYghj1erle0WwIvh8isXVxvBT1Y/F3kioevkpuRE9nJaU5v1DrHBkTVl7loF47oiVv2/p1ParS5t2s4XEjw9D6w9m4dXJYOCBAU99s8xEvRxgoaPDLtYh/Dc/Dk4YFqnRoEpdgtLVjmTr+zB8cw75ZJ1iN3yD7DR9U5qO73Pll/KkUSTBM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+JZMhtD0eTQxFo2MDJXbJPB40Y/9TN7VHJ0nmw1t+U=;
 b=dDSTA2SDyP7ni3+suzB7ARMi5e4m0orz6HGaEZlxjQ06ts3z3N+4d/m+KEHuVE8irGjOAWgz7KZbV4Fi1Gz2cM/DGcQOkpLnebew/b1bULcmNXwu+5vW0b/IlL8PzZMF/pZLru9qiwVIN2eMHVgYyBOotiz7j8yWe+IIooYdlbFgoAR63t5HMm1OdPOd5PaufEO4LqsYShGzAVWVILzLJ+ST5N5jOkrf+Xv7ktu0TxAMs/elb6Wdbwv7k7YArtkVikyNuvS31Zfij/onC+j+rBaH1YUpRRt7LZ5YeqXFk775PCCLJs6PJQf06F6UYelplcxv9Nzdk1WWOlCR5pVCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+JZMhtD0eTQxFo2MDJXbJPB40Y/9TN7VHJ0nmw1t+U=;
 b=aHfa7Xbg028FtG+N+7PeCX+dncMQc+Z4l1YvP0+gvngQ+uRc+vgMW1tUEvy8h0eJX98X/S3XAJLiMihv+4cyalQvIxOghJYjLP7mCsZvPgU3tLNMBR6sqji1KHIGNrvMIMpHuXxNvGzvDQ1WjAOI7BJdYYNIC1sZxU6Bd3n2uoPAtmlDkAxFzIajE3exHymJ4Xr4uOrAUAcYE7Xuf/gZ/aKceJ0oM6hfIVOzH/OJwnatVJdAxVA/yiXXhJ5fwEAKYvWpBRZu0DdjUpuw2mHVDAqQVgqedoJzEPegzIHHqV2RkRxUziU1n0ybtAUeU0/UUKdeghI9EVBFNnXIwUWhHA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6502.namprd02.prod.outlook.com (2603:10b6:a03:1da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 16:25:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 16:25:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>
CC: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: RE: [PATCH v2] sched/topology: improve topology_span_sane speed
Thread-Topic: [PATCH v2] sched/topology: improve topology_span_sane speed
Thread-Index: AQHbK9UxGRUfYyJZJUmyjFPUnGtxo7LJ5JnA
Date: Tue, 26 Nov 2024 16:25:38 +0000
Message-ID:
 <SN6PR02MB4157493E8AF5661DED4D2A1ED42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
In-Reply-To: <20241031200431.182443-1-steve.wahl@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6502:EE_
x-ms-office365-filtering-correlation-id: 0e76fd96-18ef-459e-f6b8-08dd0e36f6ce
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|461199028|8060799006|15080799006|3412199025|440099028|10035399004|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rtxRqGXkzvMa+BTNu223x0hmSQd9ldIcIM3iv5v7s8xKuzze2UTU0atf6b+I?=
 =?us-ascii?Q?4xFXQnbz12Pc1IDycWrY7Wp1UBCu7rpk9SMlVcEB0M6i6v533Ju8KxTnTKRz?=
 =?us-ascii?Q?j47gFsO/PMwDIF2Xegm411+FVP4VfnN5c6gv5AytkZQBW348ydB4+dF6qTXc?=
 =?us-ascii?Q?PIYtgvxTcdVMw411bzQyQOa5IPDwg1tselyXNBwFSJeyR0vV02yQNfl96Nmb?=
 =?us-ascii?Q?t4j/QRwTVkm4r0omulgGu3YE5UhYnRNsRWaLa/Imx847gY1N1BP86Wy0FJQu?=
 =?us-ascii?Q?uY4PtmNS0hVFf2WgXcelQkiavc7dps9kBa5iOqbitmX23MQbhwc5XzmltEnP?=
 =?us-ascii?Q?/4IOy6XfU28DA+5fcvBG+mFMFdkgAqc88D5BnVcheYYmvjyICzz9QGUt+EAE?=
 =?us-ascii?Q?8gLTDU0/aABkWZoX6DjkOysIRUoLow7iHkJPuX51sl4oAaF2WlsjXtVylFCm?=
 =?us-ascii?Q?60CNN43pjwntZsCDDuz5UBQVIf9WB5mZxLupEE5knRhX98Tktf/LzjsmTZje?=
 =?us-ascii?Q?hg+DVjcie6MmFA+M+HJ8/w3tncLeyPV7zQuNrpXMnVvkobHl8lDs5ZaC5ThE?=
 =?us-ascii?Q?t2sBP9szkDQXK4edF/MIITerVZ9Nt0qjJNn19ZBOQEg+SJdJ50kDmluoZgKs?=
 =?us-ascii?Q?BqIynzV6qPmIgfEvsk17ktlfaf9tsSpBwKTE2GLTE1yyEJKWcpuZpYz2lFqy?=
 =?us-ascii?Q?coKjkx9t7JsH6+OqiPQQrlMRgQN9nnUqy9e0FY8DhvPKoWsG+6vaZhcro9kg?=
 =?us-ascii?Q?GnVjIJDWk8HN8XD845R2rwTduqErhr2ukqZa2+tXAEM1nkVdU/BI0BAYAgT/?=
 =?us-ascii?Q?ADlbRuyh0jEATQYjAbwsSZXZm+mSX3kx8JiLHpBqgqxXtz2lf5OsO95g99Gb?=
 =?us-ascii?Q?ml+to3xFXk04/cNQO2hwHqCqpI2uG2j1q34n0hm1FriwBF6YIDXhuVYpNh1C?=
 =?us-ascii?Q?it2+gnb/u3tZXp8sZvhuLnJre9BOEWkw36MfpmRNjW1GtadCp+hG+WhM/n/F?=
 =?us-ascii?Q?NqrN20TGcsxcCLldyFO7boYmqTsMQ3jxTB/UeWm4kXRxvJ1U+cMPd2NaUfpn?=
 =?us-ascii?Q?dzQaUFFKpzaoJ5wK+DhFnVd+SgI2KJH4oh8KvHeKlFYmR6mMgjk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cpeI0GVbLawquh0FCT1EsUMPdava3mLdVV7V3i5w8BQ/pSjw3svHK9Bl3PfP?=
 =?us-ascii?Q?AI+VvTpzYrz4p+4Y6RYtyV7u9v433wg5qSzfcWWYorAJeviCfjBtXieLdyfW?=
 =?us-ascii?Q?QiiPYx3WvFoYsZE3SFtdKuiwwF0dKOcEtzKp9wALSJMefHtyXsNvY21Rbtyl?=
 =?us-ascii?Q?g6qjSQbQXVL8LvyFxatnRTPDU2JjKAkVgs0sujRwyag0fP6oBGsvyFgL3isu?=
 =?us-ascii?Q?YvjG4uaYhORg5ZJJk4BnXKeLTtHclDDzY1X9qxafj6kamumRqwncjbkj23Gq?=
 =?us-ascii?Q?MHnT+mPAPQfVfSGxlaEqghVqlHqsv3FtThEhUg2vdINhGBveFB+YRlzt2tY0?=
 =?us-ascii?Q?qS7vHqU0lY7hdhPBYd+Gipo7+E4uiG0ouvYua1KV8IgQQEsdHgOPcKF9VhX4?=
 =?us-ascii?Q?xZbiWIQRGYSu+OL5ryn0FQUsct1om2wwAWhdJ+oSPPPy/+yZYvDBF5/czK+y?=
 =?us-ascii?Q?diF4uatbIVBI6V8LRDk5OncgdAOiX5CLPWCQN4Jj54cMdhdIopGO+FYJwtdm?=
 =?us-ascii?Q?ejyPnyXj+PevTO8e9MaguSEFRn0IOYArnMa56eE7kQvWZ74CvayS7+px6AeV?=
 =?us-ascii?Q?/gXcKR2HRyT19xnN45lYuos/6392bbweAVmHBO3QhxeTSXFQMUjjphO5Au+e?=
 =?us-ascii?Q?QPtYJzIKjTwSt0ex/Mdn3/rVX+5jhez+PwHJeM9g/Px27/H8GKbraYCbqysP?=
 =?us-ascii?Q?qGlwhICFH0HPaD5Rhw6HTVt/y2VY0+7Ry4i++HNx8xsoyX6INMOiq8LqFCm+?=
 =?us-ascii?Q?JaDIY/lbx/Z8jV7QuLVKTemnRj/9n4JjxYXipR71CCQPcC7Q+5+4ItNVWxuX?=
 =?us-ascii?Q?oCGVP/RcDo0SiwEyhSrPXmEQnfxGVidK869n8cQJCpyrxMLRIC1oa5L8wwFh?=
 =?us-ascii?Q?v2o/sCZZ4aX9HAcqxC5/N7mPHX9Th2NDwPsUS/6F7vi2ecwmQBoIdAVZ5cGi?=
 =?us-ascii?Q?Zl8NXG8JYtRsOCLU3+21KW4lXDjFxZ1kCwfIbJOx+Z8Q2mMBDD9RDDVv68He?=
 =?us-ascii?Q?3ySaSUbeEIVHin+Ix5RmteNc18YDd9PmHViUCdvJM8HtdBw+s/CGlzINmh/3?=
 =?us-ascii?Q?v1oEQVLIo/2/BuscQo+oK/N/sjlgHepB21wRVD5a9WI0AA7joimTVBo1cZrh?=
 =?us-ascii?Q?4KxJ3yZ4Y1Fmud+8EK3ydngW203YDCb1uI/YohZJ/HOdWUo4u12+Bfi+z2uY?=
 =?us-ascii?Q?ALMD+57bgrVTEOGQVotZi+AcFideiGsQ/GCncgTfchg9js0H1Fram4CvNg4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e76fd96-18ef-459e-f6b8-08dd0e36f6ce
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 16:25:38.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6502

From: Steve Wahl <steve.wahl@hpe.com> Sent: Thursday, October 31, 2024 1:05=
 PM
>=20
> Use a different approach to topology_span_sane(), that checks for the
> same constraint of no partial overlaps for any two CPU sets for
> non-NUMA topology levels, but does so in a way that is O(N) rather
> than O(N^2).
>=20
> Instead of comparing with all other masks to detect collisions, keep
> one mask that includes all CPUs seen so far and detect collisions with
> a single cpumask_intersects test.
>=20
> If the current mask has no collisions with previously seen masks, it
> should be a new mask, which can be uniquely identified ("id") by the
> lowest bit set in this mask.  Mark that we've seen a mask with this
> id, and add the CPUs in this mask to the list of those seen.
>=20
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, identified once again by the
> lowest bit the current mask has set.  It's an error if we haven't seen
> a mask with that id, or if the current mask doesn't match the one we
> get by looking up that id.
>=20
> Move the topology_span_sane() check out of the existing topology level
> loop, let it do its own looping to match the needs of this algorithm.
>=20
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
>=20
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>=20
> Version 2: Adopted suggestion by K Prateek Nayak that removes an array an=
d
> simplifies the code, and eliminates the erroneous use of
> num_possible_cpus() that Peter Zijlstra noted.
>=20
> Version 1 discussion:
> https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/=20
>=20
>  kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
>=20
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..6a2a3e91d59e 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(st=
ruct sched_domain_topology_leve
>=20
>  /*
>   * Ensure topology masks are sane, i.e. there are no conflicts (overlaps=
) for
> - * any two given CPUs at this (non-NUMA) topology level.
> + * any two given CPUs on non-NUMA topology levels.
>   */
> -static bool topology_span_sane(struct sched_domain_topology_level *tl,
> -			      const struct cpumask *cpu_map, int cpu)
> +static bool topology_span_sane(const struct cpumask *cpu_map)
>  {
> -	int i =3D cpu + 1;
> +	struct sched_domain_topology_level *tl;
> +	struct cpumask *covered, *id_seen;
> +	int cpu;
>=20
> -	/* NUMA levels are allowed to overlap */
> -	if (tl->flags & SDTL_OVERLAP)
> -		return true;
> +	lockdep_assert_held(&sched_domains_mutex);
> +	covered =3D sched_domains_tmpmask;
> +	id_seen =3D sched_domains_tmpmask2;
> +
> +	for_each_sd_topology(tl) {
> +
> +		/* NUMA levels are allowed to overlap */
> +		if (tl->flags & SDTL_OVERLAP)
> +			continue;
> +
> +		cpumask_clear(covered);
> +		cpumask_clear(id_seen);
>=20
> -	/*
> -	 * Non-NUMA levels cannot partially overlap - they must be either
> -	 * completely equal or completely disjoint. Otherwise we can end up
> -	 * breaking the sched_group lists - i.e. a later get_group() pass
> -	 * breaks the linking done for an earlier span.
> -	 */
> -	for_each_cpu_from(i, cpu_map) {
>  		/*
> -		 * We should 'and' all those masks with 'cpu_map' to exactly
> -		 * match the topology we're about to build, but that can only
> -		 * remove CPUs, which only lessens our ability to detect
> -		 * overlaps
> +		 * Non-NUMA levels cannot partially overlap - they must be either
> +		 * completely equal or completely disjoint. Otherwise we can end up
> +		 * breaking the sched_group lists - i.e. a later get_group() pass
> +		 * breaks the linking done for an earlier span.
>  		 */
> -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> -			return false;
> +		for_each_cpu(cpu, cpu_map) {
> +			const struct cpumask *tl_cpu_mask =3D tl->mask(cpu);
> +			int id;
> +
> +			/* lowest bit set in this mask is used as a unique id */
> +			id =3D cpumask_first(tl_cpu_mask);
> +
> +			/* if this mask doesn't collide with what we've already seen */
> +			if (!cpumask_intersects(tl_cpu_mask, covered)) {
> +				/* Really odd case when cpu !=3D id, likely not sane */
> +				if ((cpu !=3D id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))
> +					return false;
> +				if (cpumask_test_and_set_cpu(id, id_seen))
> +					return false;
> +				cpumask_or(covered, tl_cpu_mask, covered);
> +			} else if ((!cpumask_test_cpu(id, id_seen)) ||
> +				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
> +				/*
> +				 * a collision with covered should have exactly matched
> +				 * a previously seen mask with the same id
> +				 */
> +				return false;
> +			}
> +		}
>  	}
> -
>  	return true;
>  }
>=20
> @@ -2417,9 +2440,6 @@ build_sched_domains(const struct cpumask *cpu_map, =
struct sched_domain_attr *att
>  		sd =3D NULL;
>  		for_each_sd_topology(tl) {
>=20
> -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> -				goto error;
> -
>  			sd =3D build_sched_domain(tl, cpu_map, attr, sd, i);
>=20
>  			has_asym |=3D sd->flags & SD_ASYM_CPUCAPACITY;
> @@ -2433,6 +2453,9 @@ build_sched_domains(const struct cpumask *cpu_map, =
struct sched_domain_attr *att
>  		}
>  	}
>=20
> +	if (WARN_ON(!topology_span_sane(cpu_map)))
> +		goto error;
> +
>  	/* Build the groups for the domains */
>  	for_each_cpu(i, cpu_map) {
>  		for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->parent) {
> --
> 2.26.2
>=20

FWIW, I tried this patch against linux-next-20241107 in an Azure public clo=
ud
VM (x86/x64) with 832 vCPUs (8 sockets * 52 cores/node * 2 threads/core).

In a simple test taking a single CPU offline and back online, the elapsed t=
ime
is about 0.61 seconds without the patch. With the patch, this is reduced to
0.29 seconds. These times are stable across multiple iterations, and the
improvement is consistent with what you reported.

My test is pretty limited. I mainly wanted to confirm that nothing unexpect=
ed
happens in a VM on the Hyper-V hypervisor. So,=20

Tested-by: Michael Kelley <mhklinux@outlook.com>

