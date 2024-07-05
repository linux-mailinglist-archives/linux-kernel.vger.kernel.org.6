Return-Path: <linux-kernel+bounces-241873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F592808F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA54284573
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BBF15ACB;
	Fri,  5 Jul 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dadl1uBV"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6381A31
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147568; cv=none; b=tTjR+AkqQ64gvOg4V4UCifb/cOT3I/hFetjhXwW/Df8SbT26hztv7oAjNiXQHj9Xct66sAnKvH5G//GY8JO3Wsv6JSFep4rish0DyXFhFI68bNKGXknw8aNBvm4jNsXPlTgTS5bG/VQSj9m/6TPkXsXM9Mf94Y4plOJrjjooG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147568; c=relaxed/simple;
	bh=uhsLLjzzLMDnpEbbLQn/ddyOf+pwmWtUEhgnUqLy2o0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sKEYYiTjVq3Ixhjhs2rK9vVADDheNtcYrKmGELnq1zBNkeXDazgyE8BOkAXi3pm6ioZUHpyhUAfWMz7Y3YQDKRHD15cJ1iN+vK9z2glgOd+Z4wns6/3O5/CS2wXwrAm+wzl615tErvvNAaLglhzZGW1xxd3xmyZBLahlCn93ZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dadl1uBV; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4652j2B71671599
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Jul 2024 19:45:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4652j2B71671599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720147503;
	bh=X4+c3iaUpE5Y2eBCVYeMl/06x86TxOxdbMscHX9f/rA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dadl1uBVgOGbWXVpBM83xEt51qOvS+OnInqW8mTHpTyzB5Y8w8UBmH1AJDKqeUgP+
	 JIfObt+YZXF3bSiu6+dQUzyxGUiVGDRaQgOBFHx5k+2ncajO/y+09Z15p291RwfZNE
	 oziu18rxYC60UrTVGSzd8rJuhgkXA5Fqj9upCOcLPrZvan1nttndK6ObDSV1JJ5hck
	 0V2VEBAu4VV9Y2/fBNXDrlkVE9IkVXceEGtVgIE35bSd9RxfnunRNo2McNrKXWRVp5
	 isp4K/78L7pTaYCaHIf21BCCh7nF4UVWzS2MPsDjTtLl3mBHC90C9zUWCXDq7gwfwX
	 zgecxYQBh2MnQ==
Date: Thu, 04 Jul 2024 19:45:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@intel.com,
        xin@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        peterz@infradead.org, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
User-Agent: K-9 Mail for Android
In-Reply-To: <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com> <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base> <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com> <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com> <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local>
Message-ID: <DE8FD8AA-35C6-4E51-B1E0-CE9586892CB3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 3, 2024 9:17:05 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Wed, Jul 03, 2024 at 09:06:55AM -0700, H=2E Peter Anvin wrote:
>> I believe tglx declared to use them unconditionally since FRED depends =
on
>> WRMSRNS (and the kernel enforces that=2E)
>>=20
>> Using an alternative would make wrmsrns() a more useful construct in
>> general, though=2E
>
>We can't use them unconditionally and we don't need an alternative just f=
or
>that - a simple
>
>	if (cpu_feature_enabled(X86_FEATURE_WRMSRNS))
>		wrmsrns()
>	else
>		wrmsr()
>
>would be perfectly fine=2E
>

Except that that would be more cleanly spelled wrmsrns()=2E=2E=2E let's ju=
st abstract the whole thing away and let the user use wrmsrns() whenever se=
rialization is not necessary=2E

