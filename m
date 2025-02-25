Return-Path: <linux-kernel+bounces-531801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9221A44524
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB71888CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289041632F2;
	Tue, 25 Feb 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qXGctBeX"
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392A16C684
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499134; cv=none; b=ZeWwTLJhSSynx0CmQOoFGYY5Ng17e+5OppcraC4xqy3yYyfk1OTJwJKMfS6YkDQwaweRI+vMWc0Hx6q6Q8PJrxEilagTMBPZYuC2RZ+Hm2+yeA6gOPv7JzmhKH0+wH/azuSSWUuYVkPaVLyOc10WbF794pjMcbjvH0kqVIaHtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499134; c=relaxed/simple;
	bh=isUJVpB7vLx6ftqAFHOxrSEVKR45s6UkFp0QzJ/3qn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSI+s4IpOWCa65ThFetwc4/lTdMnRzJUT9PB0MXDAcDRpHiY2Q2wkcip9p23/vSYRDbi+33gUl40kv+rGJ/H9TMA+PePjSqF6dSmPFU8ZcaIl/VMYo3H3RRshMYfm8mo96mM/ozRDOQ1q08ijceelx3bQ3xVVw4mi/B5Z8tXX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qXGctBeX; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740499121; bh=isUJVpB7vLx6ftqAFHOxrSEVKR45s6UkFp0QzJ/3qn4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qXGctBeX+2KDiw5xbMXW5I3Cuy1F2XHowMV7DwnqMhYTqvxNigTy9N6M887zwPNuqVTzANR8NP2PwUvT53GCZEfXoye7EI4hOa/YowXBKGzk3b0rFRUe/IbZOZ6v/7wr643VRxn4NXpPWf+aP7oU/jp9CkCKYTAgMIueuFGH3yjrXB4JCtJzc9XvSrdpWpsgox4fR+BHeWLufPEIdQNapvgK1XfZMV47Y0R5hjh1IHDnKB8+1ubyp3vcFMZzGARMRE8vgo/ySAegirLmandrhG0HqsLWPahCkrKpDhlNGHVZ7Cm4gGzWKUheYCLydUw/wjJj/3CrhknQzPLnuP75nQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740499121; bh=AO1MpB/K96YSB+86CFrnN+DA0LQzjy9d35DnScmeYnP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KkMbhxniCjO8o3ZmwDC3vAkDzKpyHLngARDW+Yp84tv7eJzy916s5tjND18x5LUASL0YX7LjyLkP5oaVK++wyghyB+Mrejd/XKotQhH7j1pJoYLCR7bIDlOCJx6DcRIpVshI3YwQb6KIqoVq6OY0gI7Y22vfcD4/QWZDeaJeG6yB8tAqBpnfIiZsgNf8fmikwV9WIsx3vA6o+muiHSQ0UrtKcKpoLAeOcLwsxVSScvexQbqXNwf6XVRmIFaAl9gPS12BjoDYiyoym+hIPPAbvVw6zhlFBgq0AQLc1OlUKoWBas3umuFl+M0d/BdXMNIvQ4ljO6qfBFZAHQvdfNr46Q==
X-YMail-OSG: fzvQ_4cVM1nPtzbGJGoLkfxTfnS6FPl8sn45HBK84msBcbEDONm.FJsfmwmNsVB
 s8YY8kObUwQ.1cIuPXFhz8_a7l53b51UUcOx_rUyyEFU_iSUTeIZlso_cVf4tl5Up8L4eUFFNBW3
 8aJP.i.ulZibjg6ZITeFyVECzDbS1I3A5nIJGjp2yWaU5T5x0ZxB2i5SOCpe0ZeFulAQBSyoRjGE
 RePKdlcAMX9qBAohC9nB19VG1zsm8rpn49wczv_1UzCS_Y3c.LZvc4pG96Doj.H9sVSvzzUaUmTj
 HmYPFhIcbKrz2Bxo.JFhZQ2b5MdovEl06zTP7X5ilNaTa7whMP5fLjZvUwsoufz2lmNBc9ShVQ3B
 S3RraffBZ9NeWO4Xx5zgv3IKQvRdA5w1NKbVX2xFC00KYRK6U8SeLxM9EoxR.tVw3E._0sGfZADm
 t1W8AHgt.cFz4zpuu10B7kV3azM3DJNhdL9ZfP0fk.gTGwgkKuOoR_._4LrBiArK8.TVgFg3oleX
 kDRvl_s_sidmNQ.6Z25QNGhiLHkA3Xr.sXx_HhjhET2XlCzVaWIfwiYI1nVTKdyuVpos2KUEA_ZG
 QDQ4vKQj4l0RklJ8lJR3XU6oM_LcEqXwv5.dHh.deku7bQNYeuKBTmlpMCPvWv1g098sqjucRkII
 XFpCVaGBla4IddxsxPSmS4VQsacLC._CQoFc9SiUqCPuZRpQNMSviauYOJe6ncPqEQn6QEcpgSmJ
 GXsKJC4lcSI1A3lW8dWaZn0.d3Lek2NJwaXhsyWsZZlETMkoo4qbAvPVEbSVfY3Zt.zGxCshlkj6
 SUcbNNiDCeKPsku0DULC_GZdlxbVRRIJmItQbJB7FYHXZ_gKehUt.FRIWy_M0Sldhlo93nFPxB3I
 hsvsD.sOa8LLEimzzfN2GzrAefFvuajFejMvjU0O6XvlWoAHGOVMpxzfy8kPI4vNNQrqrKVGqeVh
 E0ofc8tfSaoi8BhF67KcOMqbRAt3WsMgaPuni4ys5Iso0BQPYs_2MmijNQUzRcHVVFB0IG3rxcC7
 OmAzwpxIEEFETzQBO2WkSffbHraH5Jt4nakV6gu9FaiACg5Ss1lNO_bD0l9O.gpxvlZvmQvRLJIM
 8..qydCk8VyRpzNUFB7HkeBvpO16QW9TuMjc6nXLp8ivZrDko2Mvjn7Jo4D.eeViM7vyqxloGEyf
 S9LZOt8ll_Cav9BepSJDZB6Bb1HJYg.NuBt2jeRbzC42wULv6IGXYV7UzRyzHXnquXHa.RGygqny
 neBeYMNxVSW5DIi6HeYIcVc5TcXmd0Bb2FAyzxJssEXbRlOyvfMxFYvePhN.KgU39DAWtbvIjzGU
 xjua81kqfLJjxzUM.EpX_LrKHse3ZLnZpyuji086BLd3.fcvO2uMMGAxNmzqBVklnQOGLnS0rT86
 BkL4uaRZnQABnyOpW7So19gWAaYaiMs4m_0QMb7Wve8F0YaNdmZwzpFm0wl37QKANHTrk88G2P_b
 z7Qlq8iLnzixukHID9PmXig.gzxY6z.gb.YytYHNcKOHg6DS8AWUJ0ZIvfGbbsKAWiqb42JGMpaD
 FvO3_uOX2Lmk6UzOleURjkWKgl5DfeSlHeJ__QZhtuOkBTMoVYqS85rtfrDPe4XDJfOO4c7ueWxr
 S59ZF6FNjzd7Eh0qDpuZlmmr7gxW7hynwJFaIq.duHcbssp3GnO7aSnJVXTEcXxJBbem4hodLNNv
 lPuGnrttmZw63COYsx7V5vHV2jLbce9OZ1QZ.FPw.WQ_5hpHagePa4I8piNLwpf8eWQjpYyeK1Z8
 ownpRWRQa6SD5yEoz7G4TtOIRfBVVN10IgMxNMW9HWiCyLIVaiwreO.rPjrPaIGtAzw41sLDDWPh
 PA2BlI6xTFbHlD6rBTxKVFk_mZYUt3zFumGMIJ84r3LFr56VHxSpApp_E5irHo63qHbZxRzvWrL8
 IBOZCGt.ohrctvehJwiufLYJkXXe0N_iVmDDwCFeuaFkgtF_THNRdwQVyroXj8zd1oWY1mCOnYDF
 zYbRERrZPcQn6JdHMTnMRwW9CS9sHL53RKe7sITwIxTJfmFLsCaYIv3FiEhIoBVZbSzIcjR2xK.R
 xCVDNrEqepFC41WLGIqpidBVUqYO1IQ0ckPPhhMajQKkDPG5iXBjhTyBnsxIkmxDxpGZ3NIFAhjG
 DmiXFd7lf4sl.wFx8B99Z10abpVdL_rEvNxtPHkmVYMnj6_FIWvhVF1RTX.OnoplgMgZUiFlGUr1
 eZOTjPLwNtS1PVSIUiFe0vyvfwhzcOiJ26pf6wU0FS9ImdN1ZC30_sIhCKvHe4MNpUJBX08uzPn.
 ZyT.w83YjAYhV
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 33680ed3-58ec-4515-93b7-4677c0ac0137
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Feb 2025 15:58:41 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f2621ea26d3b9ecd3258da526e13a385;
          Tue, 25 Feb 2025 15:48:31 +0000 (UTC)
Message-ID: <2b09859e-e16b-4b58-987c-356d3fffa4fe@schaufler-ca.com>
Date: Tue, 25 Feb 2025 07:48:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 jmorris@namei.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240826103728.3378-3-greg@enjellic.com>
 <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250117044731.GA31221@wind.enjellic.com>
 <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
 <20250225120114.GA13368@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250225120114.GA13368@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/25/2025 4:01 AM, Dr. Greg wrote:
> On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
>
> For the record, further documentation of our replies to TSEM technical
> issues.
>
> ...
>
> Further, TSEM is formulated on the premise that software teams,
> as a by product of CI/CD automation and testing, can develop precise
> descriptions of the security behavior of their workloads.

I've said it before, and I'll say it again. This premise is hopelessly
naive. If it was workable you'd be able to use SELinux and audit2allow
to create perfect security, and it would have been done 15 years ago.
The whole idea that you can glean what a software system is *supposed*
to do from what it *does* flies completely in the face of basic security
principles.


