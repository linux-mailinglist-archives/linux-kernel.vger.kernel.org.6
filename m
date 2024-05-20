Return-Path: <linux-kernel+bounces-184303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C834D8CA50F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C971F21DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BE4AEC8;
	Mon, 20 May 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cOeoWDyq"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEE93611A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248077; cv=none; b=b5ujACmknWcITej1dTmHXOWbwpeWXO3FtjLIKIctdyHE6h9M+sS8IWzLFBRh7l0Jxw3n+95KCbnfsv5V8KCoABYDez4ub4jrUv7OZ+D3a3GsnL4phUaNBaBnzZQlCMNDtjFe2JN8TzBoOG82qa/T/z1zTcGcrvbPAKzwzUpeAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248077; c=relaxed/simple;
	bh=saWUEh2uRj5tPYq6Oqo/SXMWeqs6jwgcuDZjJrDuUJ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hPCdkb8giJNEvrvpVCiHKQLDt1oWeh29Ya32aDKSO2+ushP2sWxy/5xB9ZUmnshmd7BBfITRNiaqVW+WxARQ92yyyY7jFgs+iE81UOCsGqU2LxcKHi5efHKZ3puq8eCMLG0GVz20KHmznrml82YjBqzTmMSYxQPzXBGWrofdnMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cOeoWDyq; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 44KNXTlW3973431
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 20 May 2024 16:33:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 44KNXTlW3973431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1716248010;
	bh=saWUEh2uRj5tPYq6Oqo/SXMWeqs6jwgcuDZjJrDuUJ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cOeoWDyqzDF2ij0gEQOs16dIrHWwtLGdNtHW+VvsASLftUAzRWEVdwCHnv/3CBBaP
	 VEOfsT1yrf8q4qu9ZySN+Y0ZqomHz8cDeG5XgDEQJ1MIHWiDxELj4+c9FkOug3eCR8
	 9SaeJ7AOGcgBik44AGZ8V/YmWAaOBxAQOD3tKcJKF70Colk/QHSpZjpabSVxSYSh4i
	 5aAPNtF55x7ztmORDrRx9tgSXEFBsIkIh8aQDE7ISdQUz4OcfIaMCf31Bzafjpyrjp
	 SEXrFc84jBdt3ErOB3K7wvUFvPWKdOVm7mbA7pEYnxKfbFMOEY4EFrIsG8reHszOMB
	 IbmNmswMzB8JQ==
Date: Mon, 20 May 2024 16:33:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Luck, Tony" <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC: Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Mateusz Guzik <mjguzik@gmail.com>,
        Thomas Renninger <trenn@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v2=5D_x86/cpu=3A_Fix_x86=5Fmatch?=
 =?US-ASCII?Q?=5Fcpu=28=29_to_match_just_X86=5FVENDOR=5FINTEL?=
User-Agent: K-9 Mail for Android
In-Reply-To: <SJ1PR11MB60835EAF2929D72D9C245ACEFCEE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240516162925.79245-1-tony.luck@intel.com> <20240517144312.GBZkdtAOuJZCvxhFbJ@fat_crate.local> <863D0F06-1217-4C94-B2CA-816FC4ABB103@zytor.com> <87h6ewjhn2.ffs@tglx> <SJ1PR11MB60835EAF2929D72D9C245ACEFCEE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Message-ID: <509BDCB2-5203-460B-8317-043A07CB38B0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 17, 2024 1:54:33 PM PDT, "Luck, Tony" <tony=2Eluck@intel=2Ecom> wrot=
e:
>>> This is particularly pathetic as there already is a canonical string
>>> representation of the vendor ID!
>>
>> I agree, but that train has left the station long ago,
>
>Is that "GenuineIntel" and "AuthenticAMD"? While canonical, 96-bit values=
 seem less
>easy to use than simple small integers=2E
>
>-Tony
>

Not for internal use, but for exporting in strings=2E

