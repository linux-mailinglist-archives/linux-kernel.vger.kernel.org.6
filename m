Return-Path: <linux-kernel+bounces-172051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E88BEC74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4F9B22815
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4716E88D;
	Tue,  7 May 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R10zG5mD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbz7ouKb"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5216E86F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109508; cv=none; b=WVxLFKghKQdZL3THW4MDn2tmGabvE7U2ZHMeSc2wqYO8P/nOccH78uKsUBgFmc7LWgkc/2pBKcM351rwZpnhBcF5J4k61hAMockVTVIGUdFxrZyAunxBH65W2jNoRX83CTn2kUQalqG0MslBEuquDoIbJ7+f67jy2zT2VhQ4bjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109508; c=relaxed/simple;
	bh=1m7qQGZDZTwTSY4qQAcqlU7hls2n11/gIl5PoQLknYw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=U53JPehcFLEMaaFpPrWL/kDH8C+Dr0AeTKq5t4du1/Fv9Iv2MiFpyUHRgam3HH936aSIsFZyEJk8I6N1LrzKxSDjPmye5B+o49d7nsafHlmYu5iZUBUrKa72xpgFjF2DxnnUJi6J4HVXzSvA42QYb/Uuj/PFuIHYKGX4iVQSQ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R10zG5mD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbz7ouKb; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5C08F180009D;
	Tue,  7 May 2024 15:18:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 07 May 2024 15:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715109504; x=1715195904; bh=qkhcd0EzeV
	RqNWjeFD7V/543NgW+3/vWJ3D7DjxHkY8=; b=R10zG5mD6DDA3k1WaN+hNv87QW
	KFA8VvdXQpoo4uPKw9UgkIe3QINtIxxhEi+OsAoStZO6ZprhThuwHoJby9jjkhrB
	mgCOyiKdQslP1F3i6UYM9byTVBkwInj+jUJhaSbks+x8qyW/O7DmLR3UGEKZ5IpV
	Lj4wm3uSe+u+4V7HwOiAE7edq+eN6rO0D7RTqVzbNO4Bty4ha9ZobvXSOWzRABz4
	6DFviYfPfC529g/wfACCzFOzyVbzLsaqUlcrTNSlWX7t8BsO345/IA0Kdwgs0imN
	zWcq4+dWlMYbdtOQIPSHimM7dv6zm8pESUY/BE0V4wtAZ4EUdUxMA26Mw4hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715109504; x=1715195904; bh=qkhcd0EzeVRqNWjeFD7V/543NgW+
	3/vWJ3D7DjxHkY8=; b=fbz7ouKbnJEHtfOXPzYP0wrmae673QspVK8efMRUfkgs
	qNbjAV6FgkcghfLm/Bs07i8UIuTYrmDX+foLi4tyXuRhMaZe/Pf3PyaV1V5+bDSF
	1OTVaALKTwS2eDNESdtxm572oJVDpv0/tH0adrYnepLzxBCTzXZYXQW6LBDWq4/x
	EGVl80yrZTXwZzZPfo//nnv5RD2Cvj4LwyTiM2cnqm+BkaMN4EBlUVisoG2Ft1zG
	OlABPS52FO+j9e6KahseYyRPYeV8S4fRv8DEltcr7ttVPJhYpJncOesbxXfVSntT
	Smgejlzx+gBZNUHNu9vravuF74A1hm/mHinMWe59UA==
X-ME-Sender: <xms:gH46Zn-wWj9o1JLRyPxAhiqYFSVdPneqEYqBMX-jvONFaJlygJPr8Q>
    <xme:gH46ZjtcOZOV_MeGGPrBeNoUEhUUlagMDdbSMVd7OqAtZ5j7cGgkXeHRLl-IK1ChB
    WXnggmbVceQpRlTolY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpedvffdtteekfeeikeegheeigffgffdvkeehteekhfeghfduteeltdevueff
    leejhfenucffohhmrghinhepphihthhhohhnrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gH46ZlCfDWCxDOEZfLvkr81sZ13anO3xlEhUGPDcH72Rh66VSd-emw>
    <xmx:gH46ZjchkqWiSDusGSsK7zi8wok0DeWDyeew1Ka88KbTMiClPJ7eSQ>
    <xmx:gH46ZsNSB1bcYToYMXf6pKGWCJykOY1Y_V7kCCwjsgj9BfZs459dCw>
    <xmx:gH46ZlkLJBz4SkPEeIXY7We4aoXIktTYWrV6-TnZVl7MCyku5qPcHQ>
    <xmx:gH46ZoAzYRAEKwQZ8ejHfem_wqTi3t3tjwwBgHB5tp1QppINQZUii2RL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A883BB6008D; Tue,  7 May 2024 15:18:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3013f57-0d0b-4e3c-9658-7cc989b77c73@app.fastmail.com>
In-Reply-To: 
 <CAA8EJpp5TO9CkwWCUy_OL5T4px9gTjmB-pKPr1dNPgudVc78Tg@mail.gmail.com>
References: 
 <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
 <CA+G9fYs1F=kO11-+DtAOsNwZGEd8mmojXEfXfg431JG=Spubcg@mail.gmail.com>
 <CAA8EJpoMwy2w3a9VF3ejGkcxFK905DCczZOdD4k-cd7ouKHYcA@mail.gmail.com>
 <CA+G9fYuGLz76C9F=onq6u2hk9_YYHhyjT+bvwXmeN8U6bhejNQ@mail.gmail.com>
 <CAA8EJpp5TO9CkwWCUy_OL5T4px9gTjmB-pKPr1dNPgudVc78Tg@mail.gmail.com>
Date: Tue, 07 May 2024 21:17:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: lkft-triage@lists.linaro.org,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>
Subject: Re: arm64: defconfig: gcc-8: failed: AttributeError: module 'argparse' has no
 attribute 'BooleanOptionalAction'
Content-Type: text/plain

On Tue, May 7, 2024, at 20:19, Dmitry Baryshkov wrote:
> On Tue, 7 May 2024 at 21:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> On Tue, 7 May 2024 at 20:58, Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>> >
>> > On Tue, 7 May 2024 at 16:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> > >
>> > > On Tue, 7 May 2024 at 17:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> > > >
>> > > > The arm and arm64 with gcc-8 builds failed on Linux next-20240507 tag
>> > > > with gcc-8 due to following warnings / errors.
>> > > >
>> > > > arm64 and arm:
>> > > >   defconfig - gcc-8 - failed
>> > >
>> > > Anders bisected this build problem and found the first bad commit:
>> > >
>> > > 07a2f8716c41 drm/msm/gen_header: allow skipping the validation
>> > >
>> > > Steps to reproduce:
>> > > -----
>> > > # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
>> > > --kconfig defconfig
>> >
>> > What is the python version on that platform / system?
>>
>> # python --version
>>  Python 3.7.3
>
> EOL.
> I'll check what we can do, but please consider updating the platform.

I don't think we can rely on everyone to have 3.9, 3.8
is not EOL yet, and we do want to still test in distros with
older compilers that may also come with old python.

It should just work with a regular optional argument instead
of the BooleanOptionalAction (without the --no-validate flag):

https://docs.python.org/3/howto/argparse.html#introducing-optional-arguments

> @@ -538,6 +538,9 @@ class Parser(object):
>  		self.variants.add(reg.domain)
>  
>  	def do_validate(self, schemafile):
> +		if self.validate == False:
> +			return
> +
>  		try:
> 			from lxml import etree

This bit may have to become 'if not self.validate',
since the flag in this case is None rather than equal
to False. This also improves readability.

     Arnd

