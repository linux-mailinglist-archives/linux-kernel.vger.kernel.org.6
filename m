Return-Path: <linux-kernel+bounces-357739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65139997501
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DA1F216C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D591E0DC4;
	Wed,  9 Oct 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="koMqZ1BX"
Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5F1714A4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499221; cv=none; b=mxIFEMYPDmqMpr7cL87YVGHc+i+r6Gb+UWBoyGj8TBvYYKur9XeWpsV+CgancfNmejxua6SJ+Lh5HUo0jdqbY2rx5rbwD/E5hYXDFB1uTrP8twYzEHDytWu5Rq0QLDDPfOkSMZ8Xd/pvW9GAJEQomkMoFuh7CWvdnmnEHFeBHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499221; c=relaxed/simple;
	bh=+5Tf0XUpVLTPt1CDBVqo0LkBUpV2cksSkBE45st0oiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niNkK9JEkztIC2gHu0NWttpjl+X6tpCx/+0TizEwZ2HEDH862gKFyL/6PkS7X5o24uN2CkRFtxQ+R2dVYyeU65ylUOX4bvNZGfBP2QTPiyHPt8RD1k3NLko8P87WshL8i51ixo4vqeBlnR+DGZyPxp+whD9dvhviU6duyiERB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=koMqZ1BX; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1728499213; bh=ytuaKBFQZyg4u9EgmDqqTnquCK/59ghrQiGY2KRjunE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=koMqZ1BXFL3j9UnkvYtDVuTOTUGNzyn0yTkX2Te8A6eARLUik8xXCjd9utpMK1E9fvjernPnYBV+u0nBq+yN6yzRQcNWrzJI0qG6Cr/imNK+JxmL6gyQsBaMCLhYY/DSE1kS+KRE74pcwIqYF/jmfEw1PEkJ0S8JpqXjqrkjHuR3/5+GM/enbWSg+uvUPFMyAdVaDfE24bLmg8hKlYxIt2BxVH9JfOqW/H0ae1HPxc3SbTfubA2O6vwAQdSDB5x6+KTHb+HdtyGggsscsPbX78GXkf5cMyEPjzgL5Q52JNYSluv3hxlevp8Dj+xge4HitZ1Z2snzsFe8T//v0ZPF2g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728499213; bh=lEMEiTvIEsJ1G2FfZ/gzTJWExlPq2p5MpHoxwoI9VvD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OimDzqWNcSUzC6sHo+jRKByfitBPW5clGMIv3ePwqguNj/x7s4CWCsnTUGU5u9DCqhvFcSHI5owRG81/pnK/nJuGFg+pPTdM3vyHhPWCV0/15gqIzHL2cAmpvMrtGgASrcvdRgAOP+Kpx6J2h9DCqd3vemJnZRl+9MmZxWhL+xhsYcrMiC6WUP4tM0c1ls9DcDDaZjeGU++4yJGL3RJGRxCIxVpznthE42fcNUll3O+4ILhcJzVevTmPa68COEHoPAkRUzOklQT80K5HcHVFh25mqtoB4N9PSWwl8e6Uo+FSTEahpImWbbtmH8ls31/r5rhZeS+cNYAHiDDGKZLvOQ==
X-YMail-OSG: kD_EZnkVM1m5uQSAXMDuqKQhDwyzxoP5_R49AdyLhB0jWesRtaSCnQPB2PnE5yL
 0RIM_WkGdKPiNSzZlXo8ZPa5zZITE9MQq42MNLVJ9GUq6qH272HA6Fbaooeh2cSxBnGyDPY13kjq
 3ZjO1UDKhl4KF6E_3.9c5BCPWgmYFSOZBUfTMCFToO00aBpV6YMOSD2FIir0hdNrs.u0yi8vsPl_
 bC7kC1.KWTXSBIFtcdScHGOt0.4f4Llbha.DNQqNkAAfZKvaDKWGYz7rglhfohCQT__T1Me2n7ax
 yevMs80ErwlghJhF3HFotwFqhJ6MWfNQPdk3aVH2rNEKUebpKlrsyIZrp5FRJcXoMiFw8xM58UkH
 aTyUMuRGr9CcXXw9.GYZ4wyVY7p6l2mVz4orZiwpfeR2BUyPOCUMhBFqIjjQPIPpt2aJAinodxoq
 o3oRwinb4ri5rC_KXHYJK5LjW54ZW_.xBIye5ubcfRs_k4pAoJ6LhmFeA4V9wK3j2aNppQk9QuIy
 sybKnN_uhhitnqnU_oJwcR5vzlMwXxfxM3hKG0Fm8ER9QZ1kKXMERwar2GCZuCh3WmNwvp2ggazA
 jiB0m3FqO44xDi5tvUWdOp90HPE4zvQt6XooJ0E_dK3kG01ZeMjZylLlVetiqCe_bzYQu5r6V6Wu
 BghFo3C5F.AsmXorGKLZeBz_qjb3phK648PWhMDeyVVQcGbqiRQEX6jFpv2rHz0J_qeNLmvAMvRY
 QKF1.A62vWjfY493Ctm6Xx2NUqkb3kkcNxY0Rnw.Vjd_t1mDAQ8h7lPtSC9NcfKixSRzdiR2jCjp
 Sc9C3s.fkSFrBXpTIZmypjF15t5JcwwPcD59VmRmjun6tw0adfOuS0S192fRviWBwQ9HFQbpA07S
 pXOjKao47Rb3jOGithKfucq5Zduz2HNG3Psjvk4d0AhCXhWo2tr4VSjHTLnMxgRwFOlcbm7aTgHG
 k2FkeR3xNIqDyaMNp135shyjT1BIllNxbHZU1Lhr4BJkJJycGFYcHAyJ7KhDZn0FsZhY1_2j7DAf
 w.XyMY7jo.zTf1oBkKwsV9YvLWeouP4uhQhjvloHswoNHt1Hukw85P0CivO4wZIIrdi86Te3f3CH
 jydwd8pZG4sEYuYQ2VQOJQ1gqDBphYkdBCAQQemoeQjCdj5wgDr9IMRqkMwEgh4HeVXTdsa2AepQ
 xf4JSGOZ4GonXJ4s5e1wXL3y13_YesGtlCGLG9YKrNkZW4W_c_5ahLsLj94gfFfPsGjB2P8HqE2H
 OKJSQnKMhUqHSUsT8jCI4QYz3DlaPglvCwRbpqfsttEsI8m32DoR8wVQV4Rc5ecTVcNb5zRuETr1
 gMRLjsu2rThwqDzH3c517p9NI4itk3iHs6S94eloh.GrkrMFln_BpixsFjiwiXuOXltl2guluKjo
 _HmFvhk5iswYVkADQtL8qIIdUP5WenE2fM5CRhUXxySSIxlLueixDd.65vrmlULfPUZha8mBR5Bv
 92Wu0rbM2GVyABz.NECX58QGZBcXjKAOo8O2M1oFDWTRHoV8cO271xte15zbKTlqjGYqZiCdBx5e
 7A5tEI7YhQCOeSQn1IQlJVGX0_iL1LI8BafyvpmLPijWGBuMZvwh6ZOtgeYo5iP_p2rGpuYhBwz1
 m3I1w8Wv9vux5FMG55zbS8RcyknHPyz0RmMT.mpTTLDiNghwgDS9C4r37ujxFOsUnQw5db9LS28b
 2ZmRFG00tMMk3ipP3wpa7mdk2qiNA_z_8aQ9H7.eCFpWW6nwL9c8FftY6RNNOaalxBFWs4AQNtJq
 6AS7Yx_AhfCZZY0jeZ_7o2eCdpNT_Navw3su2XTuXiA3eaH6foe9JUHeTvJfhzABvz5Aq4I9iL5p
 n4Vm6CUKJrUB8smG7i9sGVEFBQymlz33x6jZRUlsHQOwMNjK94zF203Ziw4bz2nPEAfASnQvmtn6
 nDQPoqWbbr1fygtWHdlnct6ucxfoQ6ni2wvnuJmioCQaBCUi2XT698jfClUq3rL7i13Cvo8bXRDd
 s7YmVjffo5E6pRdG5a75n6Pg9gyNefzlqDIeuifQ4sbtRQiv_tXLKmJMbtxZvp53s.8PAT01_deA
 B4ZIkcnyujLV3sQzi3a4MWmLJamwYVZ79yo9W2vlnGSqKYIyNFhsFc7Q9JkV8RA.ZfFem.u.TUIn
 vEUtegez4zDQPEU6iXU8dBYo7P.jPCk_A2tRQdV6.qrsCV8HBr9UPuExYxy1whQo.kwGotm7Ii5Q
 NB3LuTH6Ytmq4dbdJ86_FgNrM_eW1nJpXZ88KnVwWbi_Y4l_.9fJ31b0Wc3u.kOHYm.igHSH6
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 08c37137-32be-469c-bfcb-3cda3b03315b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 9 Oct 2024 18:40:13 +0000
Received: by hermes--production-bf1-774ddfff8-nvh5z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a3a692438eea7aa176cadaccea5fd48f;
          Wed, 09 Oct 2024 17:49:34 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: pmladek@suse.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, gregkh@linuxfoundation.org, tglx@linutronix.de,
 tony@atomide.com, senozhatsky@chromium.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Wed, 09 Oct 2024 13:49:33 -0400
Message-ID: <3250581.5fSG56mABF@nerdopolis2>
In-Reply-To: <93b4c53a-9f15-4c35-965b-ac889b3061c8@sysprog.at>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <2669238.7s5MMGUR32@nerdopolis2>
 <93b4c53a-9f15-4c35-965b-ac889b3061c8@sysprog.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Wednesday, October 9, 2024 5:24:49 AM EDT Bernd Petrovitsch wrote:
> Hi all!
> 
> On 18.08.24 02:09, nerdopolis wrote:
> [...]
> > I originally brought this up on linux-serial, but I think it makes more sense
> > that it's part of how printk console device selection works. Without VTs, while
> > most software is able to handle the situation, some userspace programs expect
> > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > refuses to write log messages to it.
> 
> What's wrong with fixing systemd?
The change was rejected, as they want the isatty() call on /dev/console
despite it returning false due to the i/o error

https://github.com/systemd/systemd/pull/33690
> 
> Kind regards,
> 	Bernd
> 





