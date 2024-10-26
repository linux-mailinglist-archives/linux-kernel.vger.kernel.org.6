Return-Path: <linux-kernel+bounces-383350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7850F9B1A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD4D28287E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38651D6DB6;
	Sat, 26 Oct 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="jw2jl0pw"
Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7213A86C;
	Sat, 26 Oct 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729968663; cv=pass; b=DxGn/AYAR4gUZ1PKXx//2MzoOp77KEaPdGbNMXCZlgzAektnbgUEQ7Z3pCTTsCIrXEta0oY05p2lks9uYWC8CfR8bubpKQm86qkQPAKSS0IoJZ45OMk6ZcEIFWuHdOkMg2r4QnQoH5hjv9pY70HhmjlFdbfedOW/WnCVt7rinFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729968663; c=relaxed/simple;
	bh=r2Kgzwh40ALEs5pjId9K+CrMliI1JPnSVZ0hm3hjH2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaRoUhTXvNYRdZpyK0uevM5dGm3O9d+Ir0osJhdGZK9jQo2x9VxfK5fgc+6RWGPqLIyQCtaFszYqzP2siYzUYe0Z2rmp8FYRLThcwxskuktmxF7JJ0ZuEOOYVH8aRRg6H29Gartvl6WvTBK4ya2eg+ApMyz5boZAjswnnQgOPg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=jw2jl0pw; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C5F6682099B;
	Sat, 26 Oct 2024 18:50:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.103.140.206])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 661748213C8;
	Sat, 26 Oct 2024 18:50:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729968654; a=rsa-sha256;
	cv=none;
	b=CmIDo8pKBo/bTqqW5EZ14qCWDJEwGDlDo73lyX73IM4H3vdFgmRzIv0BJ8jH3l0gDYpSbu
	+v6FArOs8IPYScGGjNilqx8wT5k6IfKQ82COGGzNSf+Rg6b4dBF35KqY8anv2FY3L56qde
	gdgDa68con58YVrAuFh/7+TbTlShM2hBHxW8yvQ4ThmaY40o1YA5y3Yo4wn4kWZBbH30cf
	i3vYg3SzuEL8fDwqGvFB3mNQdtfopTv6oPJ3eu4L54oi/aqvk/L69cCIcqt67xkzVry86I
	784bsrp/NZeLLdo85OXiHAyhOIrFRmub2mA45rtio1h5a9p6/B/DDfFN2NQHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729968654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ml8iaVUgncA8nQYmmhVgiYsM1Ph8DMykG1CIWh1XX0U=;
	b=PINrw4soogQvE7v9EPA2Y1UEMHH5DvHljfASIpGG6AeLLN4dtKWNyfcoy1Ahf5l9UsDQzJ
	EnPAOFzQmiamuyGAQLwTaZX0fhczlsX+omj+TFBX2y08nPqfrAcaNq5Dy4vy628TPLh+HX
	hNwtNV3wwmfQa8mAEoVMJgvzTd63Xars2gykAaaHZ007JX+D0iZz6AiwGmX9AIH92b2xil
	BJhPqX9yIo1o0X5UEhhnsh6dePPdsqMPJnm38h2lqS17XWm0ngkN3Y9Xm9Hww3Bkhb6QBP
	37kJqI/AzsDx0C32giSFC/lhOMq3pfzasofNTm/AcPos1lWIhIZ0APrOpvlRuw==
ARC-Authentication-Results: i=1;
	rspamd-7fb5679c85-f69n9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-White-Chief: 2416300111b17c2a_1729968654658_3139018223
X-MC-Loop-Signature: 1729968654658:470921833
X-MC-Ingress-Time: 1729968654658
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.140.206 (trex/7.0.2);
	Sat, 26 Oct 2024 18:50:54 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4XbTHx6GQcz67;
	Sat, 26 Oct 2024 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1729968654;
	bh=ml8iaVUgncA8nQYmmhVgiYsM1Ph8DMykG1CIWh1XX0U=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=jw2jl0pwMsmtQJID69u/+XI6jj+L597xj17MzfxWONUvKeJQJNzPLBRVC8cSHzHZ2
	 suZ3e9jigqapSjJqcKMA+wt8RbhQSG6AJE0vJBphmQ43G5bmwKf9QLISqKTYAF4EA9
	 Vi86Lj4LcR1FkMdE88ocqPIxaCJY13AzVO4h+B+4qPVcBmwecpzlCXjWvKYtCefd1K
	 ++k02l/gp0dm/ATchJoSqnO74hDjwZKt6QzlQvSkxUxcKpLQF0BpPsd5JV7a1cbTyv
	 GyRSteq+KlerijSQQNs+mdpxkPwb8LloXJoauT+Uv9eFKOco072vH1HWUQvWutq3Io
	 j7qjZTLriSQuw==
Message-ID: <932f1203-ec01-4a58-9281-ef83e537d62c@landley.net>
Date: Sat, 26 Oct 2024 13:50:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Boot-time initiative (SIG) thoughts and next steps
To: Saravana Kannan <saravanak@google.com>, "Bird, Tim" <Tim.Bird@sony.com>
Cc: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/26/24 02:36, Saravana Kannan wrote:
> On Fri, Oct 25, 2024 at 11:18 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>>
>> Hey Linux developers,
>>
>> The response to my request to form a Special Interest Group for boot-time reduction
>> for Linux has been really great.  Many people contacted me by e-mail and on LinkedIn.
> 
> Hi Tim,
> 
> Thanks for organizing this and moving it forward! I'd be interested in
> contributing to this effort as a lot of work I have done aligns with
> the goals of this effort and boot time is of obvious value to Android.

I'm kind of an edge case for this project because my mkroot images at 
https://landley.net/bin/mkroot/latest mostly boot up in a couple 
seconds. (And faster if you feed in KARGS=quiet so the kernel boot 
messages don't take time emitting and scrolling before interrupts have 
been enabled. Although "quiet" doesn't seem to work in current vanilla 
kernels...?)

The ones that _don't_ are generally because qemu's bios for that 
platform twiddles its thumbs for a long time before launching the 
kernel, although there are some slow drivers in there:

$ for i in powerpc m68k i686 s390x; do (cd $i && echo $i && KARGS='quiet 
HANDOFF=echo' bash -c 'time ./run-qemu.sh > /dev/null'); done

powerpc
real	0m6.154s
user	0m3.689s
sys	0m0.341s

m68k
real	0m4.220s
user	0m1.142s
sys	0m0.212s

i686
real	0m1.986s
user	0m1.709s
sys	0m0.209s

s390x
real	0m1.644s
user	0m1.378s
sys	0m0.228s

And that's with qemu running on a 10 year old laptop that I'll have to 
switch off of when debian drops x86-64-v2 support. (Even that i686 test 
isn't kvm.) It's running a recent-ish kernel (binaries I had lying 
around)...

# cat /proc/version
Linux version 6.11.0-rc7 (landley@driftwood) (s390x-linux-musl-gcc (GCC) 
11.4.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Sat Sep 14 01:36:19 CDT 2024

Built using the kernel config files in the "doc" directory of those 
tarballs.

Are you trying to optimize the kernel boot, or more trying to optimize 
userspace? Because my userspace init is just a small shell script:

https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L102

And the above simple test loop just told that to run "echo" instead of 
/bin/sh so I could easily collect boot-and-exit timing for the qemu 
process...

>> I had hoped to push out a script today to start to gather data on boot-time on different
>> platforms, for people to run who had expressed interest in helping with this effort. But
>> I got overwhelmed with other tasks, and I may not get it done today.  I'll be in Tokyo next
>> week for Open Source Summit Japan.  If you are there, please try to catch me and say hi.
>> Given that, I'll see how soon I can provide the script I'm talking about, and we can
>> discuss the goals and design of the script.

I regression test under qemu because it gives reproducibly scriptable 
results. I've even got plumbing to run canned tests on multiple 
architectures in parallel (part of my release testing):

https://github.com/landley/toybox/blob/master/mkroot/testroot.sh

Rob

