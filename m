Return-Path: <linux-kernel+bounces-535002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C3A46DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2354C16CB58
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EA266EE0;
	Wed, 26 Feb 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="kWFmf5ia"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998926619B;
	Wed, 26 Feb 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605977; cv=none; b=Pu/Bp1hGt0BWjTQw/9xcFqt5ZxqKCjEv0xyaIlHB6O0U0sVBwSWqmZg9WeW+/O2zlcLb2jIzg48VSYGRwsf77SRSuqdNx3h33hhEhW+6jpccDUG2E67J59UduYdzmuXR6Pj8Up1wlQlFZOASXVk6u4l6bdc2nM/nMjy0BhxhApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605977; c=relaxed/simple;
	bh=VETQmyxyjF0N4tZ9I2Egpc42vNVtgQlUq1h/Mf1W7qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk0DtCxxpIMuJ9MR2UJhbXQa4W8BllQlvwNgZK8IFVshw0XLina8e0yHofIOxFr1rW24g3s9XHQSOKix+qNqy9W1GlvXTqXXqL13M5yfoqj72KtokGxmyBmNfxDpufTAEV3zl2QTF9nz1GcoDGjWA8OfimYbpEr722ZwRWVTXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=kWFmf5ia; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740605973; bh=VETQmyxyjF0N4tZ9I2Egpc42vNVtgQlUq1h/Mf1W7qM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kWFmf5iawAEQwRJ++zvc0dZVOkVpZryx0DJI8AM/alTYgy5fcVWuZbravN7jEf61L
	 os6+9TS9rA4IMdEOMb46Irx8AwyiSv0TPE22OsscC+tbGR7kzioeD7ErROPhRPNe/h
	 QkmsTC5v8flCKEVDdMS2yBOB1GMm3m8zfR3LXZaA=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id A416B2052D08;
	Wed, 26 Feb 2025 22:39:33 +0100 (CET)
Message-ID: <7ab2de35-8fc8-42cf-9464-81384e227dba@ralfj.de>
Date: Wed, 26 Feb 2025 22:39:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
 <91dbba64-ade3-4e46-854e-87cd9ecaa689@ralfj.de>
 <CAFJgqgTTgy=yae68AE29oJQc7Bi+NvkgsrBtOkVUvRt1O0GzSQ@mail.gmail.com>
 <6983015e-4d6a-44d4-9f2e-203688263018@ralfj.de>
 <CAFJgqgTJ+GBvdkZf4bPHPoUgJj5ZzENZaLzVV2bnDOEG+3OMtw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgTJ+GBvdkZf4bPHPoUgJj5ZzENZaLzVV2bnDOEG+3OMtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> Yes. There's various projects, from bounded model checkers (Kani) that can
>> "only" statically guarantee "all executions that run loops at most N times are
>> fine" to full-fledged static verification tools (Gillian-Rust, VeriFast, Verus,
>> Prusti, RefinedRust -- just to mention the ones that support unsafe code). None
>> of the latter tools is production-ready yet, and some will always stay research
>> prototypes, but there's a lot of work going on, and having a precise model of
>> the entire Abstract Machine that is blessed by the compiler devs (i.e., Miri) is
>> a key part for this to work. It'll be even better when this Abstract Machine
>> exists not just implicitly in Miri but explicitly in a Rust Specification, and
>> is subject to stability guarantees -- and we'll get there, but it'll take some
>> more time. :)
>>
>> Kind regards,
>> Ralf
>>
> 
> Thank you for the answer. Almost all of those projects look active,
> though Prusti's GitHub repository has not had commit activity for many
> months. Do you know if any of the projects are using stacked borrows
> or tree borrows yet? Gillian-Rust does not seem to use stacked borrows
> or tree borrows. Verus mentions stacked borrows in "related work" in
> one paper.

VeriFast people are working on Tree Borrows integration, and Gillian-Rust people 
also have some plans if I remember correctly. For the rest, I am not aware of 
plans, but that doesn't mean there aren't any. :)

> On the other hand, RefinedRust reuses code from Miri.

No, it does not use code from Miri, it is based on RustBelt -- my PhD thesis 
where I formalized a (rather abstract) version of the borrow checker in Coq/Rocq 
(i.e., in a tool for machine-checked proofs) and manually proved some pieces of 
small but tricky unsafe code to be sound.

> It does sound exciting. It reminds me in some ways of Scala. Though
> also like advanced research where some practical goals for the
> language (Rust) have not yet been reached.

Yeah it's all very much work-in-progress research largely driven by small 
academic groups, and at some point industry collaboration will become crucial to 
actually turn these into usable products, but there's at least a lot of exciting 
starting points. :)

Kind regards,
Ralf


