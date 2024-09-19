Return-Path: <linux-kernel+bounces-333706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCCB97CCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28351B20CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C221C1A01B4;
	Thu, 19 Sep 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fVYp9B6m"
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436918EB1
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764456; cv=none; b=HG8VHLultcyPBV8xJykJr3J4ZMUr4dbF5YtNE9JxUsPUFR5Ohr0GF4Iuq1RgGRpz5/FELJ5/TqveTD5Nsz8zu5xJRQHUykUbZTyORLSGVmbfqi9S9YBVlIq2SYwBC5dqZdWoKh+1TXtZxCCxE29niFwybMHx831hUuVvKNwS8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764456; c=relaxed/simple;
	bh=s6dpP8TCSV6IMkh/sXJtSdJX6jRTNUzsaaCEGL9iuoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wz88c8u/rcxeIf3UbrUuCAd8pq1CABJjemVL1ZJI4KyJC5977S54RZL1XG+oL6it6ULfY5x/fEDom1REPYyQqJLwQXhySqTQ77GpnuC5+Q8HLF3da5Lb0jXCGeGDN8LUh98pHxynQpOEOpQ6etZfpFfvLlRMQFC6IfJAxoj2usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fVYp9B6m; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726764446; bh=tWBQybOl3FT+mudZjl+fbkJNchg9vZbkctoIw4///uc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fVYp9B6mm5okDa/OzJUKP85qQKai5OpwqcgbBLip9tayUgQ4dEnUtRvB4w5NHMkkKMV2/dngsxrDsSAe6xgYB2t59HmnYeCfn29E6bLzeRSBMqkwW3HFPOCBjBxLe0MjkT8S8BkskIDOcFpZ2vd2RRlJXmBKrVBh4JmegX8s4Y0xBamc1JvtFzhFmBMDmmoeXhS+LkFHNUy8rlQCGK/qoUYhqhynDN30oOO0whZerPDAm6aNIMrCVHaqFFiAzrW1NKWFUucDlgnnOK1bgScBM8PGhKr4ecp7dMEmx/vNlwEpxhcVSkz1K6obuKG9MspsIwCbW9b/MSiQSXZ+l8TQtA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726764446; bh=ClNkvxeawCUU0ZVBwbD6yLiuGJW2m9es4X+AgZKHMAp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KbwG9ih+k8rC7geiQaiBB0+MIq8xW5gSLd2rmxvpVzIeEbGkZGI+yv9XFltLiK1MOChF0MGDO2MoTe9pvzeHTUEOA61RY/n88zo2JDcclWzPAU4qlSqpoCtb+Os0K77HuOLimtQpEY+nD5lKel+A6M7ZFpdzC+AGTy8F/BfMR8FOySWrnkSpHmAdbJpiNgGZTqFi2ShbZtIBvXu1Qs32RSjbplbBevAzishET7xpICAcZ59bZ7pk+NCoY6ejgMMfMJ/AkYeafxAMDIzs8iWZdNSSRDaoBmDPbw8nlS7CWjinH+qGoi/UEpVQrVTBBZEAlxTG4/P6kSbF+ibB9Z2bXg==
X-YMail-OSG: lhgDsYIVM1ldXeGLHXo.hMlxhMWAWE75l0jD_OdxCFnweh4ImU2HnTB60Zo3np6
 lMF75rzgcRu_2HtWTQu_qXKjrTBj4m9znuw9W7sgJNXyWbQ8IFdH9VgC9v0sEmX2yaMRKVD.WlWp
 KtE.Fk.0sTSZULG26b167sSVmB_VDPQ_5wW856hqgNxvPAcJ2kD3h1b.7FNemdF01dxon.h8st_y
 Y4EMZsDwrVHGXXU19RLTTCuyO7THML6.dMXcbvoSawIGx6EiP2BLUaogYkWsAd.qyqrFAFDNEry8
 kbmywmL6cEJo7ntqx6C0.Fjfn_J12dWxhpKxUqjKs5rN6Grbr3PeOAF.Lp2pJtryFakmLomhslzJ
 dnyrJTztxyKjRhc6ESecMS074DjjA2VrF7tvHqk9e6Cx8oEVRdPmQ3LY6tMi6cViuCmhjJAefKId
 o.SvkGRXCIEean7lPmCB1Ls17bfHrgIl4JyeA7aMjBtYUsX8BaIou2hfP52JEpmVtd5Dbjfb56C4
 ziYanxU38lFoBaymT7pveHuqU8RbjLwjTnKkxmB3zleMTto7knfaPZvMc7EDs9TW9jT4nBhYXKJi
 7yna2NKhLlnt9bkb.xGx_fD70M3bZAYIDa9ROu1W1a.KO3Y6W9UWBXL2DqOzOhmlQrv8P_0nqfXQ
 MeOhxpI5iRzSb_oT3oHqxHgcN6FPJKwFbS5UbqZnwcIky6Wmp3To7yGGts4V2FGKMR6ALk75a0uh
 LqFBmRxRIQ9f7.u9eEJryPXQi02OTIVg4CzibVEeYVfJok0ezSlcmle4_yoztgJM9Nj4B0J7jiD9
 JEtiQ8pHSGNhFVTpGp8A7v.squytLRMsW7K1WRrdxdUIxe.y4RZXDGdb2YAycW5IM9205DlfDcjW
 gjAI8DHBVANfWA31moTm6BeVab7Vhw5jP5kpAK_ux4lag6ix9VYFdF_SIfNQztsq8DY0rg6MsGwz
 I4R.vjkxLD9iI1zGAj0reVeZjm4cdivYwgo20Obn4zfAnrqZYokGmQjKkKIurDO4fKqQ7q1rz8ZT
 Fg_6TXzLPFz_qLSB8CCxFhlXjWbD4wxL_6Ut8NwooPB3b449Gfn_ccPSKqxJIyHhHHf.EGTaxzo_
 H0A9pHvmvvOPKxB.lNNOI8uWC_ybPu_H.bYNsPv4JSSdj2lBxA.fMCesYVNC.ULYznj4GLghU4ok
 qHATxOcdt0Uxho5GSXzqSArl3mom9bWW7YzLciafizMOffOA9k7bHhN_78IMd_qje8bHNvoLASUK
 lO2XqHQTtADG.vRGlwpxnIhTEHSKUce34hUJ5aU12FfAbfCM5yaOBlyMy9qnozIL9G.tU.Yxp36w
 sHJGZ1AI9B6jWSSAM.iOnW9HoOtaZ7UnSl6NNlZXp3iC7yY4ENyIBq5UTXyZ7Nf6nTCW3sIX6DgZ
 zfaBu2O.hxN6A3JuDj8KhzZOjECECF_ssL_LeHSODGMttlOg4QLt8o2U2GCFdtziZYP1P0jcPbBY
 9sQCxPYwgFCkrCwqB67nsq7_D5v2qlwUObCMpW340saHohQ7HX5RImpQbOpFrakQLGa_T9UDHP0V
 GVebeHqbgh4RW8YDoUqm0avOOnaBHKyuIjx_wcAU6O6ZeY3CT1rUhpfLYbiGxIWzR6XBUDNSsRLF
 Be1jn6m78kQOELGmnRnuabs8lrnm3wLaxxoCXTHLQ5TlAHhzjs9RoeukaeqwhHZzzYwQrgub4iYY
 9_MfRe4iRh7IGt8SjCRMBVrPNt3HcaaoGBSn81olYZ5QiYzb4AVdSoJmYGQraRKleAXUGsvB3_g4
 kCStkdsWOblkNFW9F_Q32.Z3S.udXAKYhw6vCwFUcOYTCYjGXVwecSzoUSOl6KbQWrEsW1oyqoqb
 CID5hwO3oS0S0sDj0BZFqdQrIj7gYb4o5vhwc_rNWWt2dofu9l3Jbui5BwD93VVWzA878K3ATdZI
 Ry6tTHzE3sxY_CL2eIon7vwgaoeb5zbCAzlO7rJjkKRukKjbQ6aTAYYr37sggdCHDY9gvfsWQKqv
 QWT3xULax4ffxbsvCBeJrn_Wci3QmcL6Mqa7v75s7pyoBkn3_LEudWaSfqDUGMklb3nH3L0NLUbl
 ESSFOF.yE2g9oQaBZK_X23MmwUNYniyg2GNEC1Ecu77bcIz6PLSE2wJct4NJvLnQRKn0bnGJZ3ne
 x3b_H.cKUKx6v87y6in0_l9KsvhGQMkfks.ycrDfladTfNOO9sGdCbYPRUuX6lcyK_DTlRU7wwUa
 7szHj_v.tZAqFHK_JbMVlmyRRqEvTBWJoi9EH4FgYOrWLjmrmo2KAAh3YUSEMtmv4TSIhsZbT33d
 gnXAwlyUoXRZeSs97GFVvz6LKqCKIZCY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f29536d4-e4d7-45f4-9d3f-96fc955a69a6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Sep 2024 16:47:26 +0000
Received: by hermes--production-gq1-5d95dc458-4hqnr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4f620351a53c03e30d3a3c39e442e2df;
          Thu, 19 Sep 2024 16:37:13 +0000 (UTC)
Message-ID: <1a38172e-ef03-4a87-9200-cfbe20c3bb77@schaufler-ca.com>
Date: Thu, 19 Sep 2024 09:37:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [audit?] general protection fault in smack_log_callback
To: Paul Moore <paul@paul-moore.com>,
 syzbot <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com>
Cc: audit@vger.kernel.org, eparis@redhat.com, jmorris@namei.org,
 john.johansen@canonical.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com, Casey Schaufler <casey@schaufler-ca.com>
References: <66ec25cb.050a0220.92ef1.001e.GAE@google.com>
 <CAHC9VhRpDPTopxgOEbDt1d_XyDVNzaA7++6UojWXidbpBHjeVA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRpDPTopxgOEbDt1d_XyDVNzaA7++6UojWXidbpBHjeVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/19/2024 9:05 AM, Paul Moore wrote:
> On Thu, Sep 19, 2024 at 9:23 AM syzbot
> <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    bdf56c7580d2 Merge tag 'slab-for-6.12' of git://git.kernel..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12584b00580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4540f5bcdd31e3de
>> dashboard link: https://syzkaller.appspot.com/bug?extid=044fdf24e96093584232
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155cffc7980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ad24a9980000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/cec9f3c675f1/disk-bdf56c75.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/21e06ae5b159/vmlinux-bdf56c75.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/1e936c954b8b/bzImage-bdf56c75.xz
>>
>> The issue was bisected to:
>>
>> commit 5f8d28f6d7d568dbbc8c5bce94894474c07afd4f
>> Author: Casey Schaufler <casey@schaufler-ca.com>
>> Date:   Wed Jul 10 21:32:26 2024 +0000
>>
>>     lsm: infrastructure management of the key security blob
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1124d69f980000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1324d69f980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1524d69f980000
> I just posted a patch which I believe should fix the problem, but I'd
> like to get Casey's ACK on it before submitting upstream as it does
> touch Smack code; lore link below:

Thanks for jumping on this. Your build and test cycle is faster than mine.

>
> https://lore.kernel.org/linux-security-module/20240919155740.29539-2-paul@paul-moore.com
>
> .. in the meantime, I'm attaching the patch here so syzbot can verify
> that it solves the problem.
>
> #syz test
>

