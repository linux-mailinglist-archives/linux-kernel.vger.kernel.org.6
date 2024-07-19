Return-Path: <linux-kernel+bounces-257439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB4937A12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB4B2813C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B746145A09;
	Fri, 19 Jul 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="e9VrrzST"
Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAD1E4AD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403680; cv=none; b=EF4lM8CFmeoQqP3s8+E8uxgkhIT6VoVHEX5ghkpZGWUZNn6vA3XULOWYVsNQLlVxF9PksqkCfq+8Q1QChyK85wk/hq6UAPxfZCawEz5fE0bKOdLxEua+vC2pNhHcYuVABFWx0UApvME3pP//LK5efIp7nj+8LeJSBAbhRgIjYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403680; c=relaxed/simple;
	bh=eRaEN1aOt+u7nKXrm295ulDxCo9yBZlHmbdL0KgunG4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Py7bzM5uVRtyYCHl1oi98cFYefkOtXf6/Z/MvEnIWwDzNrX04k0Ia9HmNu7AP3qUFBxY4sTpfzdeg9WQ+BH0/fmX2jsXOPrGKsAEnsZDWCyi96KWNyBig3uWOEnBjj38D1MgQnW5QlD/WbRrK33QP9lVNt9lrCha7iwrGA9Lrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=e9VrrzST; arc=none smtp.client-ip=66.163.184.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1721403677; bh=vUeE/GAwsERwc9DA8t3B+A8RkXjckadWum8zOaM3JUs=; h=From:Subject:Date:References:Cc:In-Reply-To:To:From:Subject:Reply-To; b=e9VrrzSTcGzF5d3APLzPr312egbvMqgLIXIQLR0OkHe96aTqxNaIpTgaPOSCjk6pmEcPG0XKIEhykQ5oe0+pmX/ekoY8XXY/rqVkunz0r649TZoRi4insUVXoM++JEu4lqNQyoClxcLcjnwVeWpV7wP2NJ15LrQzyycNPWHXy39k84V/Fo5u+e23tyObbsifxin5S9B91c4sDTcvoLIz0ok6qsFPgUGhQSNCuqV1BU65ZkLSE1PVi4yephH82YTffbsmbyFkl7Hif/6RxcRT735vx7ELdW9vWgui18rJMoqYq6mVvMOukzDVhOBamzhwAy326fFqwl4wKDImCWEgRg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721403677; bh=WKL6HzKrpW5T7NAbViDXniYak6U8dU+XgrdgQviNTtf=; h=X-Sonic-MF:From:Subject:Date:To:From:Subject; b=Fd5DqhkaDc8ct476/EKYuehBLK19KZqxWRRnjspXQ2v1paMWlFWSFVI+MlErxs19apP7pqQfrZj/URPfUrzTGkvTPSeUUBsOc1hpXVMtf6FnlAj+zoeuoTBznIIk3qSHdR81sqax5f93txNQKszDpjLr4yJm1NF+FWvXcdfy7Mv4fdI3TJVfdtaVm5y9zByQAeYFgB3qDBw1rAliQcFaOeAWO1TdovHwVlP03AezSAoJM3iCTNKTEyLbeG4WVJwW4jzqLKdnIDBSmXiw2ohukYaa0QkHz2SLFNZ4faDetpNVAAVJfrS+5hv6eFc6VIyICkp0SzKjJ1qPoVsjoG3CYA==
X-YMail-OSG: pXZDVZwVM1lbER2c9CpZKTZDn105YRK79WOZzhE5Ki6Tm3WQCKmgxFrofa1X2Bm
 xiL0Q8aFtA.TvB6IAA38jZ4VOFW1feE.Mwt9GAqQ5cVWDCONMtcuVksIleohiKtXCh.sQAFHHonN
 yYmHp9BhyIFcnr3cGonzAPrr59DLFHKX5Bmh1fqlvofvZjp5zuSF71AWIXSvTqLluu6jFWEnva.s
 f7DTNzvze8FQtALdmHOmelJo2X8cybRVUycZjzddxlTwJkVnIuCOaOfivbzBveWzmBeU8af7x1I0
 2Lzbr9x0txHNdVzBwo.zTj_rkkI97FjeHg976Jip5fomUdP6lQpQc93PaMp5FxvxDNM3qQEBLvRG
 KhnBxngb8D_EN75T5ZlOLDYTrh1Bgl_2N9Rck59gcomwcv.CIniSHSMdy0INlh7xvZj5GXS71VE2
 YpIqDY0LH9ZtFLnX6JSMBXFi2fbT7N_0wiZJb_1pgOVXkIyNav2I6NU1kxi98_s2rUoHfZeDMlNv
 Sjb0LSK1tulNW2BlMnSYpjtimuc_y4EyDXREhvlwbdAm.0MZIUQQ.zVr.F3_zpYdOMAGPhT.ir_W
 cjrSaxf0UhLe4hPKx15w.HqsH.0RARs5MvLBh6qRZFV2MPUiPjxbY08MaI_kRgYJDNJrIblclYGz
 .uqfCBnwEID7uSZ3Oe4rUlWtYMOKY1jZrshk_.T9VDp10gxB_BXBZqFSkazyHMFbMeZ4cpy79XZB
 fgiBKsY0Dm4JCUl6LZWqLI4GTCco0oXVmWvsMVyMRrdIep3B7OivK3mEJHMYfbCku4xrYjsG.mWC
 239uUtgfRGwiW_7W94x0rcEVpDVTaECuY4aAbe1emc3z9fPXl78tmcItNPFYJUuikAOuEyPPuCwf
 .zbEUespKzMnbdSPZR8YeCkd2a1oFyjQm8MTjXv47KE6TO8EBafbGN6NXUfHAoPlzGuNbT.1oqW6
 ZyLVFwtb39B_R62iTmEbPKgGtW5MfAMrxQIIyS1LBlHS3TB27Udtb3CIvc2CidzZAunidJKG9Yxu
 OXB5yoUVTnejZyByAPUopWG.XIcxv5UPMz8leNLkk2CwQyF_Rp6C9WyVT4qewnvPYx5HPmt_zjWv
 rr0ccJPHiX7HsG0IStrXTrEpB5WNOBfkE9rBGRx4lI76qUwL8QtagmNyzmq3RRlLwTJRLTYMbcK_
 OjYsh06Z7KtFU0FCRhlcTHUwbO.uy5qq0GM1yCH_xfsDfaWnVnkP7rkmMecd9txbIuVecd5B4L7w
 T3lqNoX5NLljY591c2NlS1aI.MvlLxRjM4NCVBORVi93AHTZTK_5vi7Rz7laR__Lg.wTAFtjx_Ds
 soOBUCvutLQulvUC_cPP5MO1a4ms9FuCjU9a5ta1OLGjUT.wYXyO3o2K5mTPZ7lM.hyz8omdo2aW
 4anVulOx_HqT9v268vtz7_JAfHdHtvUSvK3g877nyun98ojpf93CLQpw4gdF38uGjhOei023kH82
 yAFWp48PzR.nzpZOnl6sAwRT_GcfrIH1nYxdOVnA8rwkj2VA.MEyjjlgbg_r4sa.u3VWBfFPUOm0
 DLOIMabwwyIdKwBt1wb0sHH5nU3ySTaWMfaRwNN7zGlRXdf2h1QUMQEcMUKmBHM.BcFdR4zNLOyC
 QROazo3rebqTgUHzOSRjdTFOHo3YHQ5w8yWUBUizQFAiq_ioaH3JIbIQlk0c8b9Z.iwKOiFeKqWL
 zrz09Dr26RWv3_KS7DHt2bCsUCYv7Twd9G.9DS_7WDB7.US6GytngH_offKdDSy4MXNlJiyOPKQY
 _l5t1z7EGzCvASmzx20V0oeBb1s.wSUfkFwcIDjEAsaBv39Wozz6w4eWAPyHbovH8od9jSags4sY
 pkSk6sbD3l6V_ng5rTHV2JfY2FKtvKyVjxfys9RdUttvWYsjYLeMq_s6rx5lJe2bG_kpTRRCUkUi
 UQ7qRaJgpr8Rx5faKFepHHd4ZmrK8rEJXXUJyi1x01k5GKA2iJeVFfoXMnqqSE4VhU4vtKO3X2gm
 9joGHSp1GTuKGlCzR6NxjJTl4lHFfbTGfyQ8u.urnx1fEgRy1TeytzUp5fls2OEOR00mHVznUAbZ
 .anYdQknIuYaedfggKm8381Dy2n1OhSBhvyeDji8eBzQG_7.dtW0JcsqkcLY4NVKT_GIWlYQKfSN
 2O2bp28nRWTmbtIE8St_AUYIovsSDAFAruXtIkuD3LuanzNH76FrZdU2s3DMfPZ5anOdq7Pci00l
 hCfVIqXVX5nmn6TalBgubWtyRq6Lmq4snTjQ3xqMsNG0-
X-Sonic-MF: <makemehappy@rocketmail.com>
X-Sonic-ID: ba846122-2fe9-4f3e-8fb6-67a1abcc5cea
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Jul 2024 15:41:17 +0000
Received: by hermes--production-ir2-57d49df6b5-m9r8s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fb3d04436797f3f06ac410f0d79e8a07;
          Fri, 19 Jul 2024 15:41:14 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Max Dubois <makemehappy@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Bug related with a 6.6.24 platform/x86 commit signed by you - Enormous memory leak
Date: Fri, 19 Jul 2024 17:40:59 +0200
Message-Id: <CBDDDC2F-34FC-42B3-84EF-5F3BEA5AC480@rocketmail.com>
References: <9b0e7f6a-0432-46ba-bd75-7ba324934716@suswa.mountain>
Cc: =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
 Dan Carpenter <error27@gmail.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9b0e7f6a-0432-46ba-bd75-7ba324934716@suswa.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: iPhone Mail (21F90)

I=E2=80=99m sorry, yes that file i called =E2=80=98working=E2=80=99 contain m=
ultiple kernels instances becouae I had to do a path to find out the crash h=
appened at 6.6.24 level and that the last working kernel was 6.6.23. So I di=
d a try to a lot of kernels over and under 6.6.24 to isolate the problem to 6=
.6.24 and everything after.


If needed I can try to isolate the instance of the working 6.6.23 and I can=E2=
=80=99t confirm it does NO ERRORS at all like the kernels before it.

Buggy 6.6.24 log it is corrrext, the real 6.6.24 log with buga on vmalloc.

If needed I can confirm I can test any possible fix and/or patch against 6.6=
.24.


Thank you

MD
Inviato da iPhone

> Il giorno 19 lug 2024, alle ore 17:12, Dan Carpenter <dan.carpenter@linaro=
.org> ha scritto:
>=20
> =EF=BB=BFOn Fri, Jul 19, 2024 at 10:01:14AM -0500, Dan Carpenter wrote:
>>=20
>> The interesting thing about that is the working kernel had tons of these
>> allocation failures as well.
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D219061
>> See the attachment which called "This is a session with the last WORKING
>> KERNEL 6.6.23, NO ERRORS, everything fine".
>=20
> Never mind.  There are a bunch of different reboots in that file with
> different kernels.
>=20
> regards,
> dan carpenter
>=20


