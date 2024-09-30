Return-Path: <linux-kernel+bounces-344546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5EA98AB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACF81C229E8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C7194096;
	Mon, 30 Sep 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PYZm4oaK"
Received: from sonic306-8.consmr.mail.bf2.yahoo.com (sonic306-8.consmr.mail.bf2.yahoo.com [74.6.132.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DF18EAB
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717479; cv=none; b=FSGD5eRyrrNkHeQ2iVpxlIdyenXFFHhhgzO4In46tBzr0jbOxmBIess+DJHGiw7qI9RgEiJ5L8bCgJdsS8JQrWIJTwM5rSB121D4bE0qSpE3wruB9N2ZHdB003bnJIRBPdz063g94UVB+5wD0Nx9e/MMqCNfwhRf36N1sr9XHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717479; c=relaxed/simple;
	bh=jgYmi6n+M3i/tr/TCevHYiAHtA+9DepNap4HrUl3YlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fuaic1B6CywCjTses3TEyDGHV0vcT8O5uEvl9CoA3CBQmiLB//cZl5uAwqTkfEJSGbMp5HAt2YpKLBA/DO8uBzXIlE8SJEJEEnTWKfGtrVx93BB79/ZZX0ur6WHsIW2eiXFrw/OwFVu5a979dveo1iyp3V5JOAZQfuE12Nrja4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PYZm4oaK; arc=none smtp.client-ip=74.6.132.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727717476; bh=ARsJuCXumr0uXibVYrU8bdstx5OSphyqTSvmC3OEjNE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PYZm4oaK+ftBUE1UkhrJCgrUS7k18m+q8Aak8VWIEuOXAjQmtmpc3Ei0W3+vVrrDEh3geUDx/e0V29WTt/Ibde9qklJa7y0Gv95vWD+/GwZqDttdk6PepxVSVYH6KBnQweL4KzTDUpyFUluN3uYtPCzLaOJ5LIVvKf7wORqIDsslGs9qnqA/Q2YZ1+zcITfaH/LRXWfH4s21zkKBkLYDoDUP8OJVuFPWKoHaDGEOO1YRcPYbIUZcn2HY0ynkZQt6Rap0lVa6YXHSdu5Ef9Q1oPFtqe8FXeWdghbpSJ0Rl6jW1sVRJGNHP6i3I3vWvc6hPG6dcyvooyz8ff8p5qWU+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727717476; bh=XJY8h9mmWG0E2f7CcPS7LmEJmdU3awWWW+v+jwf+rbd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fx5E7uebzauMBmEOh4n/fJPa367ziBnyUHyMWVFlon6S2km9qRPUNzMewg1A5qP7aJ7+sy0qbOdP2BEDyqSmvKNnIUgGRP8fB8uIE9+Xp+LJXgucVQkq+UUK1MMVTUG7pURpen6c/E83rXWBWLlP0Sk32iNR0yTYAJtj2CNqzppz5FsZtOphC9e6hEuB2YsFVqom3DLt8b37ChZkUChvT8e8gDfy4qtXLBtBtLA3LI9oczVMQur+nlkc/FfrWvU+POSFcUFFecoz07DK17y002yzIN7EoXKJstOQukQLnjD2WpbAcvDPHbJli7pwnAR5IuUK1uZZrd3apWnnXoxAIQ==
X-YMail-OSG: lSMRYh8VM1nRCVws2jwvaZRXQVozx9882S7X_5lDG.RiorR1U_qtQAOx8KCJFOw
 FLyDu8ITLVOm6AJa1NEboTwguORQUcG6eQSWqHPP2kkuZ7hRXQG6Eth8ZL2Pe3M_AY9err8RtE7p
 foDSLhWf3p247Dq6GFAYoPU7OlPMbWlphHlZKDxXnPfEpRva344RnLT9RgLFJ7gRhSjMCpdBOmN_
 K2OkVNcHPdDumeNhgGeSFzxNkF43piri0hkNoYPEH5.j1PCYv.MzUOey_GsLlHzj8kS7nrJiBdC0
 f9k53YyvQ18BDfGoS1kUDo7RREVawYAnAPYVs0ROTOA6fKhcSAy62wVDyOBKmzCc94Nyp05xPf9i
 oE8G1ZzGVMyToFqAhHaEwVdPZl4XBVnjCxDp94XrjApkkwHbStFxj27EYfUgmKXeP0aQNfI6iszr
 J_OkgJkbHTKudoofLT4fJOOUe88301wg1mX0nCmyO9Kv1Jk5qflUAUyunPAk08PN8mb9oXtlniMs
 OS22qUdR6Z9Xhe5azdpjb2tQfuDfNc2gmLHVNv8i3mpmdjolmkN4A6OiRwKH2o.mIO3o6Vy3xIny
 iunMLIayv1gaWnxXXlJwbAGOIpXl7nuqSba3NNBZAZlsJ4aEqKZIF4KOHeExL8g6mSDZrhlPjn.L
 4MKm2D_ZJ4.jERawl0dYvkk82Wm2NotJVH1rQpy2IAo1eQTJxmwNlETBQe3QhOQGj3AjYwyphU_K
 tHWAep_k9F7lduwjG836lXTezN31YevKmekftV.jJDOiWpj2aGi.7t77AgfPAIXDNbShu4yrqzR8
 v.0bRPaYk_lPOLc9Gg1TBXUvuiYW9Klh3M3WZLTLdAglIJZAsaDq9AxcclbBYGS.Eg1HMGV90ZY4
 eI14oyhTzTpaDXH4I_U1OOJ4iT_e3dYaM66vU1QHi2I.aZmZwZ1yTrsNRhieZc_gcp2.Fb324t14
 95dTnm_aUKkRrXbRohb_0lKTvzI_zIdDS_6ZUvQB8c2kOH2q_WSA79eMulo4I4CgT.KlFTkNpJSX
 k_7DDU_KMLG8lSoZdQZZmaB7OhNdeHZ8NHz4Q77rFSqMJHxbvBzPSpB6ch9mLcCVuj9ZkarEtPG.
 fGKjCI_CMiwlYVTDhbhua2wKYICIQBct3LTmKM4tbCzIW.I33nWVBPv8esTfZO50JnzltIJk6gcV
 E.PhzAx2H3HQfIC6PEKMVkI5H6h17j8s6N8fqZ3SIPt.FVYbctuVRaEc6A1ni.jkKqeE8QVtm6B1
 ksrLuD45uTJMx62mczTc5NGVls0_ivr5ijcf99loop_ytOYyHIoeNoVq7c5c1UHMrZaFM6fR5Zbn
 T1aBY8yQ19mtJXN3vdhvy7OjFZ9xbIoRQmAtE065OKFGwlmWkPtgtMU363z46Bn8ZM9zGpglbBdb
 w6c1PKYkrg6.RH33DFewT8dtHzp5ycqMYYU4ICVfkU8dnSYTQ8gjRGSeeKnOSiDNjgd0x6_8VXPm
 aHj3J1c9eK6xdZD4Br4P3.ph.8ZRTW1.7lwscgGbL2aaVObW2f9foHjsWHWEAG7tGbg0VlN4JN9Y
 wIj1ZJ2InrFRdiXDUW0c79zH6MMVbR_0uwHDSA8_MUTd38GzNt.GPb9CJMbPECE9i2UXxEK88hRP
 BKzp2Z4OtHc1hFogAci5XUP.M0PMpmKPYAkqsDWniCtN0rInLrDetdFFh22p0h_DwYxfv.PM3A2u
 wv6h8CYfUsW.pOhoi1Kk6O1GtUVziDOKPyHFVKS9YwQVP8U9L9JNWgo7S8rAOoQzgjhh2H52GiIq
 WJ1G4g5Wz9n4.xWPdUznrCsVLxE3Wi7i30WjYq5qzOqD16CjWhu_V81XLASOvXejkpvpFUZS7ExY
 qPCjvV5AeUWY51gRGTlNRW6n.CkJCjYsV1Ff6oeHTR.FVjHlEvqyq4gnkemQWHRJInqh1h4eWhCF
 hE_wvPuI9lfgMkynwCmoRtlyyHBBfyH2R2aEWIb4JYc_lWBpclz3_IpAcdWz0gkOlGKvJI_Of5o9
 a2eeI_Vnq8F7niclkL1mNCtAqhJTuzH1wfjBuwwWLEnmi_Gfn1zOGXODA3Ob97J9w09rrb4qmRy8
 aTL1U86D9n8rJWfOdEdU44NXUxTFJPQ1aeTGKEFqhbl6eiavhaEamsBneub6oivBWcq61NiJKTUW
 3qm1hJ0Qw0PI4n22lST8YszcYNR31lbWBDoc1.h9nbL.y3Ur1GXM62B3cEtypjqfR6pSd1cbP.xB
 OKPH9wkxXIeKTXZiXhZ3WhMQSdXjYgeR3g3DxNfvAA8whfHntnwwYQ.t33UsIidWKDhX14m2IhyC
 49r3NV64_uEE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 092361ca-3769-4490-a58c-3f89002ab9dc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 30 Sep 2024 17:31:16 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e3d2ca2c022e77beb9ca5fee9fadd2e4;
          Mon, 30 Sep 2024 16:50:43 +0000 (UTC)
Message-ID: <44e5dc02-9e8f-4939-aecb-cf0e05af8ad9@schaufler-ca.com>
Date: Mon, 30 Sep 2024 09:50:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
 <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
 <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
 <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com>
 <20240927085841.GA3642@wind.enjellic.com>
 <2ea23569-6fb2-4a4e-acc1-e3927dd5615d@schaufler-ca.com>
 <20240930105330.GA27787@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240930105330.GA27787@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/30/2024 3:53 AM, Dr. Greg wrote:
> On Fri, Sep 27, 2024 at 09:33:19AM -0700, Casey Schaufler wrote:
>
> Good morning Casey, always good to get your reflections, we hope your
> week is starting well.
>
>> On 9/27/2024 1:58 AM, Dr. Greg wrote:
>>> From a security perspective, Linux will benefit from providing a
>>> better means to serve a middle ground where alternate security models
>>> and architectures can be implemented without building a kernel from
>>> scratch.
>> Ye Gads.
> That certainly dates both of us, the last time I heard that phrase it
> was from Thurston Howell the III....
>
>> One can create SELinux policy to support just about any security
>> model you can think of, although I was the first to decry its
>> complexity.  Smack access rules can be configured to support a wide
>> variety of models, including Bell & LaPadula, Biba and rings of
>> trust. AppArmor is very useful for targeted application security
>> model enforcement. And then there's BPF.
>>
>> It seems to me that the problem isn't with the facilities provided
>> to support the implementation of new security models, it is with the
>> definition of those security modules. Or rather, the lack
>> thereof. The ancient Bell & LaPadula sensitivity model can be
>> implemented using Smack rules because it is sufficiently well
>> defined. If the end user can define their policy as clearly as B&P
>> does, its a slam dunk for any of the aforementioned LSMs.
> We certainly wouldn't choose to argue with any of this, given your
> repertoire in the field of mandatory access controls and security
> models.
>
> But therein lies the rub with respect to the implementation of system
> security.
>
> There are what, maybe 5-6 people in the world like yourself, that have
> the technical chops to translate the theoretical expressiveness you
> describe above into functional, let alone maintainable, security
> implementations?

Flattering, but a touch off the mark. In the 1980's there were at least
a dozen UNIX systems that implemented "B1", "B2" and/or "Compartmented
Mode Workstation" systems. Five of those even got NSA evaluation certificates.
There's plenty of expertise floating around today. The tools for doing
security analysis have moved from "grep" to "AI". The original TCB definition
for one system was done on paper, with a yellow highlighter, in a bar in
Cambridge.

Really, it's not that hard. It's messy and unpleasant and you learn things
you don't want to know. You find a lot of bugs and discover all kinds of
software behaviors that should never have been introduced. You become
quite unpopular with your peers with other interests. We were "lucky" in
the 1980's to have a US government executive order that drove security
into operating systems, giving us the rationale for making changes. What's
difficult today is justifying the effort.

> If there was the ability to practically implement just about any
> security model with SeLinux there would be no need for the LSM,

The SELinux team did in fact propose removing the LSM infrastructure
and making their code the official extended security mechanism.

>  yet
> its existence has arisen, given the desire to support multiple
> security schemes.  That alone would seem to suggest the lack of
> technical prowess that is required to translate theoretical
> expressiveness into practical implementations.

Nah, the technical prowess is there. The financial backing isn't.
Besides, it's a *lot* more fun to write a filesystem than an SELinux
policy (or set of Smack rules) for a distribution.

> A primary challenge to security is scale of skill.
>
> In the face of limited advanced security skills, we have hundreds of
> thousands of people around the world creating and modifying millions
> of workloads, on a daily basis.

Sure. Everyone uses their front door. Very few are locksmiths.

> I mentioned just recently, in a meeting with technical influencers
> here in the Great State of North Dakota, that we are never going to
> train our way out of this security problem.
>
> Cisco recognized this with network security and this fact was central
> to the concept of it's Application Centric Infrastructure (ACI).  With
> respect to scale, ACI is based on the premise that the manageability
> of network security has to be an artifact of the development process.
>
> One of the motivations behind TSEM is to deliver that same concept to
> system security.  The notion of allowing development teams to create a
> customized, bounded and mandatorily enforced security behavior,
> specific to a workload, as an extension of the development process.

SELinux + audit2allow. CONFIG_SECURITY_SMACK_BRINGUP.
These are helpful, but you're not going to get away without applying
some real brain power to your security model.

And that's my point. Generated security models are crap. The best
they can accomplish is to notice when a system changes behavior.
Sometimes that's a security problem, and sometimes it is the system
responding to anticipated changes, such as the phase of the moon.

The NSA once told me that "A system is secure if it does what it is
supposed to do, and nothing else". If you can't say in advance what
the system is supposed to do, you can't determine if it is secure.

> Another tool in the 'Secure By Design' toolbox.  A concept that
> entities like NIST, DHS/CISA and particularly the insurance companies
> are going to force the industry to translate into practice,
> particularly in critical infrastructure systems.
>
> Have a good week.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>

