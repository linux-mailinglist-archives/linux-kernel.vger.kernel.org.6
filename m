Return-Path: <linux-kernel+bounces-417315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A49D5266
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA78283E06
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED781BC070;
	Thu, 21 Nov 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ppFW6lQS"
Received: from sonic316-19.consmr.mail.bf2.yahoo.com (sonic316-19.consmr.mail.bf2.yahoo.com [74.6.130.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD31A08A3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213094; cv=none; b=HwEMawJ84+y8TakhjT4O9W+JsTfGtMx8Vh/oqbVR+R98PANDnl4QoLReyAdR+K1idlQVndy6X3M7l20C2vQn4gvmM2zTESZ/7yvrNrVa5qAY9QK94tJcEufEgZOX9bsHMEcfBWs9ImmvLdkoQZZdC/9hpxs7lUq0uDTtUyyWntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213094; c=relaxed/simple;
	bh=1nJPrORecUy9aErlkXc7diFWNOLRy4mY85TL66J12KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfzM+vD4Hz4sxX8KWRGspFQdRV+hxvLlcxpFn5wlilN7AMpQZhefpPSQp1APo4fyPlKiEfeJbA6lMgGe2cJh206jddV2K5qtxru83YDMqHJD3TGKCvcsB76mxWIR6bjysx9QZL1qCLlMSAfIQm3dxq+aHU/uJ7l2+lsG9/QQU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ppFW6lQS; arc=none smtp.client-ip=74.6.130.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732213091; bh=EdrPSyL442ItgVmRGJmr9cZU2LuODB87mu487HPxUuk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ppFW6lQSbXmMKkPoMWA5F8afzy7Ntg+sgEvMyFk3UnixGE+5JYz4mWyQf+4FNeiRkHxbVstq/ujQ3f8XqLITrgNS5SZ2zTRMu5un6w7xFSkP4HWeKf5vzvEb1PeNcpbXai2rtePMOq0pwo4LcGJZH6G5ULfJlB/l2FkmlI/h1MFTQuyIYj2Hv8c8icROIXGduAC1e2Xc+NbQ6dAmT/0tYjGsvQBlCreac6vIE2g6NoxcaPSBhqImUw6Ky6X2QjLM1AFIHWj0j0f3J3Fspk8R1/4mkNuCdh38viYdlJ0okDww+eWKaE/b8Nq8E/VjyRNp6Rmduz/Y6rmVLEe4ziG6Dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732213091; bh=jasu8/lwIQAhGCqJBJy7vDfWUE14x8K9zQsBlavdrVc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=W0NNanIo1FtSCaGlxsBy3JAi34yEjTbY9GaR0eptnQt7sx3qj2NdMDs9gmAq0fDeDFROfk0g2MFsE/TjgYLS+Q4hegUDl5M16iNL4lTp3Fdle6DheifGhCr3q/YkGhKiuVYFllQCzL3nMk7AAEy0PzCDo6+JnnzHb6aTVI7RxvrsX7Y70DUIcNzAO2QQv9WYl5z4VkPd2dRlNLgoualv1A0tK59+50/DOA2DJ/6CN2ZGHpS0rGQVK3ntiH8P6Lsuu2l9JMRNzt3YrrcGbmDMvX16k2rgM0MOPS6ydpWUQoSGEJAzoAZIftHHQ67LGAXIzd98i1hDe1q6j+yEy8u2aA==
X-YMail-OSG: 6TEUD8QVM1lZm51Lkjdit6WAWg2I3gCVCoI5_UcJq5yicKZzg6U.dgxiI3JQ3zf
 SlglxMTk_jsrjEdp.OhqBJTggNEaU3foxKNCbOvGUFf_cj_DTPyfPQLeoDZsJJpn7OOe3YFggBOS
 lYtBNgssX.XODjTh.pyr0.gO5C_digkAP7.Sc96pc45KjiYaq3Q3oQaKjdmKITQJXJPWw.VYEPOe
 dKfm2YC6F1IV4JQkp6UXTsvujKChBSyVwzpWrlAlbJVsmUaSisPS_BfA8xoAILT5iB8wR0rZyL07
 pMD2MpK6STD1yeB4kSAf1nF2xdW4PrsIdyIqDtm1vCQs3IgcCjuF0sxLoQLmEqHWZ35heGr6Is8k
 1c6UiT8z1GwqAsCn9n66VH7bHmJcxSa4ug6KrX8aPpWTFCUCT85wZg8aiKO_JCZNnrfm.I6.5Tsn
 MzH7UcKSFrER2yTvsVmYGYGJddFrsenEpCPcMNUBJIUEKfEg6bxHdjLBsEnJdf_RTgVUfwPEfrWy
 7KhXvNXkSpcZ64Kvg509Yie4oAGuhi7EtvxgbuTj1A3EV5pmhTaoMSkzOamOIgAqF_wtgXaZ52bb
 5rU.SRuw_X5MjBK2cqVsNlc5v04QH4E6aiJ1HU2nT6JhuWCT1xlME9MPoyhW_w3IO5fWSbERPr9P
 wrkNJY.Re.nHkQiI9tYvV_AWFEEDltD_u1PVhXNjqxUXxeKBdTj36RfdvsrMSWei4ZR4_q8tT2Lo
 o6TPbYC_W_Mg6Euk63z.6b5U6Z3zlfxKOni4Y4ve8fSeRX0Qge0jmiorCAqYppCxWdkREUkNznZj
 KGJQSDp2D.GE5yg0xkvSpt073PU3Xn5ZXCFESVQeCHK.YrVTG2Ac9chiFD.KUWfWFwdrdn5sk1yM
 BaO8KUdl9r24s4Yl2ClfCx1pRx47e8.aFGnzwey42Hhi3QWovcVpacqbuWc5Xz3pZg6b9Dl9EqFZ
 mh_Su2T5O8ZCBHSq5pU1Xk4PZVqAMUeiiVWK4s7uG6mXz9iulElz0KevGaKXGDEtnA6fN9dMsY9S
 q6l3keyHtvYnrOtg5dDu.r8pXHf38P16DL9xZUFWfXg9mxDfCw3kTrQ6B4b1phPhylawqWkzPIUe
 ZAXXV4yBaKl6R19Ij0wNL_p_DOCTcKGXFYKagKe7wLdGlaSUmjWUyVUH8bSlfLkdxqDOad3vZsYH
 C0zm5Yn2Gu8uNY04lANmQrK5kepFod097XE5Isy3tVqamgdlhDPbEyMpXaficV5NPf1ibOwc03mG
 0EBZ0HwRrJAtyM41izEVHy0X49mAa6SkN2Qg4Nf3SXY0w1qfto.fh6O6C_DPy7hYe.dvRb4hJScb
 MEhMfXbfgcxyJ6LkWEzmfWvXDC2DlZCGLMhejybjamuBMh9rUUQ4T3r8ANVkdK67lzW1mFIDGGt3
 vCrOkB_dkWJT2CAD7zxvNRQT0ML8E6tINfE2hRvdwuKyjhrT5_yFy4SsZXyTX4z5gJdtI6nZlYpP
 DJ3WiFbVEeVkS9o0mfa7Ymdz2LpR3FDLIn4spU0p6OSgeVEvpmy8hCYEY.SM326.wA4Kwo_RYbNN
 tSNRNqTtSrq8SuFIYA_6krV3GRm4Cx_T7.ghnUe.xL6WcHri3afhA.DVfVIpOX9dePnav5J1fMfs
 HDUhlmLiMoR0K9clkFwylAT7CMeG76C8.6NssAKL9XFo0SAokq7UTN1lezNBFpd1rLg0ooEo0mfk
 a1imFJkX_DdjYHTM4oPo2jIXL4i5sLVqjWljr7XAuWAzobYYRPXVou1k0KKhBdVP6hYktUu0IhE6
 ijLlCoSeD1Rot89g.diWrDSlfeAO2ehrybsWGSeEKCmc3.ui3lMeX2YZwieIZm9vM26YpHfgT92a
 jObjkAABBy9HhZg.P.rPKsGqDftQvYSbjl2PLzB62A9OeNLD_UfqIxDL16nAcClB0vwbXK.rayYb
 QCrZuudvcVj9jfbKQMKwdKM7i.mAEXW3rCQ9Ig4qUf1QuG9IiCtbWBmlwMeohjQerEFaQPRJdhOt
 YlqtmI828b3.N9L5M18frpUaA7lNtayA5bJTrRTktoKplVDR6mQAzXRQAqycTL4jqJwM19hR.jNl
 Gl0jHHYmvBB07aAnFWlYoQOctmh_KCCA01GIH1cCbPpbu1rjxtPEeVt0b..NoRcMniipAGAds9K_
 RgbhVzM0WlSkZb7MXee3ggaHuk5yEJmUGtybJAo5SGhJpovKzZLBERoYAb2ZdkySd6kA0cJFbmRK
 eWvJvxyeR0RWWXWuedpCiJ9brsxLWzFqHUsXhyG7e66gNQNZGK35yFHzbH9ROGErYI7GiKYtzWYN
 cug--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b3fc884e-23b1-4fbb-ac7c-8fd641c8110e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 21 Nov 2024 18:18:11 +0000
Received: by hermes--production-gq1-5dd4b47f46-bwg5p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a4874166160859949530f5aeaf2c67e;
          Thu, 21 Nov 2024 17:47:42 +0000 (UTC)
Message-ID: <9d020786-fca5-4e96-9384-fa1fc50bfa44@schaufler-ca.com>
Date: Thu, 21 Nov 2024 09:47:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: Song Liu <songliubraving@meta.com>, "Dr. Greg" <greg@enjellic.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>,
 Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "repnop@google.com" <repnop@google.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>,
 "gnoack@google.com" <gnoack@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
 <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
 <20241120165425.GA1723@wind.enjellic.com>
 <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/21/2024 12:28 AM, Song Liu wrote:
> Hi Dr. Greg,
>
> Thanks for your input!
>
>> On Nov 20, 2024, at 8:54 AM, Dr. Greg <greg@enjellic.com> wrote:
>>
>> On Tue, Nov 19, 2024 at 10:14:29AM -0800, Casey Schaufler wrote:
> [...]
>
>>>> 2.) Implement key/value mapping for inode specific storage.
>>>>
>>>> The key would be a sub-system specific numeric value that returns a
>>>> pointer the sub-system uses to manage its inode specific memory for a
>>>> particular inode.
>>>>
>>>> A participating sub-system in turn uses its identifier to register an
>>>> inode specific pointer for its sub-system.
>>>>
>>>> This strategy loses O(1) lookup complexity but reduces total memory
>>>> consumption and only imposes memory costs for inodes when a sub-system
>>>> desires to use inode specific storage.
>>> SELinux and Smack use an inode blob for every inode. The performance
>>> regression boggles the mind. Not to mention the additional
>>> complexity of managing the memory.
>> I guess we would have to measure the performance impacts to understand
>> their level of mind boggliness.
>>
>> My first thought is that we hear a huge amount of fanfare about BPF
>> being a game changer for tracing and network monitoring.  Given
>> current networking speeds, if its ability to manage storage needed for
>> it purposes are truely abysmal the industry wouldn't be finding the
>> technology useful.
>>
>> Beyond that.
>>
>> As I noted above, the LSM could be an independent subscriber.  The
>> pointer to register would come from the the kmem_cache allocator as it
>> does now, so that cost is idempotent with the current implementation.
>> The pointer registration would also be a single instance cost.
>>
>> So the primary cost differential over the common arena model will be
>> the complexity costs associated with lookups in a red/black tree, if
>> we used the old IMA integrity cache as an example implementation.
>>
>> As I noted above, these per inode local storage structures are complex
>> in of themselves, including lists and locks.  If touching an inode
>> involves locking and walking lists and the like it would seem that
>> those performance impacts would quickly swamp an r/b lookup cost.
> bpf local storage is designed to be an arena like solution that works
> for multiple bpf maps (and we don't know how many of maps we need 
> ahead of time). Therefore, we may end up doing what you suggested 
> earlier: every LSM should use bpf inode storage. ;) I am only 90%
> kidding. 

Sorry, but that's not funny. It's the kind of suggestion that some
yoho takes seriously, whacks together a patch for, and gets accepted
via the xfd887 device tree. Then everyone screams at the SELinux folks
because of the performance impact. As I have already pointed out,
there are serious consequences for an LSM that has a blob on every
inode.


