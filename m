Return-Path: <linux-kernel+bounces-389873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480829B7253
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BB31C232A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA57581F;
	Thu, 31 Oct 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="U6/41/ts"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD61BD9F7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340013; cv=none; b=jJX88XN/OQUh6t6BBUuLlxMIl4Rm8l8ceX2z6NKvQA8ZntG7Ux61v383Z2W1IQhIapwjUrHqTkjt+vyMwWeP/Z8xlN0EUx5UorM6w+k7S1vtaIN7UA8AWqtyUUQevA0ViSVNV4e/nfPgCfd+xJWCVi8/QelVvHpICQI4KEoSDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340013; c=relaxed/simple;
	bh=5/9Bf38jWpUc1sB2BMaJK5i5eHSVtQz9Hk+KmwAkHZY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YT207D3IpfMqD5R8jRbczp23uwieakwXKMLKfl05Al7YZRLiKqJ4graAEFYAA8IEhxF+0jgN2bq+lU+RROp06gj7LuthSZB4QfsOrcLLNjKvekI9V5P9sIpIZ/YSkVwaNagxOrK8IxTQK3Vq3TwoUgcB+iAxIwxPo6xGimCPdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=U6/41/ts; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49V1x41R1245834
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 30 Oct 2024 18:59:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49V1x41R1245834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730339946;
	bh=BdSS5F+Lwp/NT4DvaNBs5FbYuSucnsfNLc+OHCQB+2s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U6/41/tsDGo4xUJUSMy0RcX3J7ZfolpHGazRatga4+R3LixtnfHsOAdyZ+v08fx5+
	 VNk1c2RJhJofJ7QAgb+jyphqOvqBC0aD2CEgKnG+jTmbUrzyRY5y7Spx/w3qQ9glx9
	 MBhHqKQ9hpFVxF5Rrx8h1avX6EdVPjdd+MBOmmJI9/XR/2H6k2Y4NlYifVbIE4lFWw
	 scIUXvKMwBmnIXF93HbQ4vvja6CVpbxv58xUEAxQyHLOZtZAEjySt+04baKNB0dlOz
	 q7iI61P87n85lAoXnNJVAe2vjjPba6VdxX5d/8RmURr1n1rSubm85D8HloArUADrj+
	 D/Sw8fWb2AmnA==
Date: Wed, 30 Oct 2024 18:59:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Eric Biggers <ebiggers@google.com>, "Li, Xin3" <xin3.li@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/cpufeature: Add feature dependency checks
User-Agent: K-9 Mail for Android
In-Reply-To: <SJ1PR11MB60836BD27B436E3E8B404AA2FC542@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241030233118.615493-1-sohil.mehta@intel.com> <SJ1PR11MB60836BD27B436E3E8B404AA2FC542@SJ1PR11MB6083.namprd11.prod.outlook.com>
Message-ID: <84E58634-C57A-4841-BD52-2E15BD9DF592@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 30, 2024 4:44:59 PM PDT, "Luck, Tony" <tony=2Eluck@intel=2Ecom> =
wrote:
>> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
>> +{
>> +     const struct cpuid_dep *d;
>> +
>> +     for (d =3D cpuid_deps; d->feature; d++) {
>> +             if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
>> +                     do_clear_cpu_cap(c, d->feature);
>> +     }
>> +}
>
>The dependency check found something very wrong=2E Should there be
>a pr_warn() to give some clue that Linux papered over this problem?
>
>-Tony
>

Not necessarily=2E Linux is free to impose restrictions that don't necessa=
rily match the hardware thermometers=2E For example, letting LAM depend on =
LASS=2E

