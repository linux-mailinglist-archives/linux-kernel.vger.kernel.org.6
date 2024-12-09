Return-Path: <linux-kernel+bounces-436664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468B9E892C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1456188570E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA3381AF;
	Mon,  9 Dec 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="s7GWbB/W"
Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B459474
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711204; cv=none; b=pBJCMUOA+0fbx+kDpWSdqRb/Lyny2XJBeK+BEOYcFkplBcHQobWNBffdY1QhY5riAXaaBH1cZRn34EnjJgYP8pDnFYI/uqzzlz919P9/dg7jUKfVnUUY9nKDOYbgfpb/ld05/cGgYh8S+AKrGqYb7wnqoAjTcdPLuajDaKiDrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711204; c=relaxed/simple;
	bh=F106WVOj8KhBfa4FqdItlBxQUIfB1SQhJtoWT1EIros=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCc2seneX3Oa6WOmyg7NdP5gmEZN33MusAjTdqCOZ2m7efjpaMRB8cAmsqjZhWsm4NrCiCdvLNGqRsPWdgyW7CKN2x2cWzbcnlvF27QlQf41zx1ueb4jGyatRFbXLR4wwXrnw7BOA/8JxNDdgN91unEM0UuVmtSlUQLOmAF5s3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=s7GWbB/W; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1733711201; bh=tIfemm8JgeEVJD9AqjrWnX1MZ0lyWc5nwE2CiuqFR04=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=s7GWbB/W+oWM8ImTvP7MEBtk70U9O/3Ti/s/mdxxX1pkI/y2uQhNsR2Pm18ZwVonJznlog539foD1oGMxD3uJ6szI8sMxyNIw4Bng3ru/k6zF8N2zhHic85JR8ldMhnmY0RObxlwqN/1br4C07cQBqG6YRKq13hTKrYcM90GxxvEd1VxtTa3YHwW+diJTolbz8liOvqh1iCOaUqJz3g7PODzQ9wtW9V7uMbb+hRJLjP8TSZgSrrHxBOiBLAzb7Dx9TVg6caJ52CG5wk+WQE28wmgXGtnSX/T9O8BuG6Y/64KVX0SrBXhrfnvQ9T5FBF53k/F4Lzr3kNnG6adjCi9iQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733711201; bh=diPI0ENJuiDfMatsTpCznCHfcD7xdMWV+Zvsn8Vgizu=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fUK0HAk0+QeC/Zrh6EYsLHkfA3mQKq5ynSR5VUlv9Z7nR8UCaMaaRN3FLjdyiE1TQwQbqUo9KbktxNZl5DyUW5bz0MrQUWt9XAUbTMdZPW/0WQ/Ukpia5gRYfUKhpayr36cwV+GKiB3TYcsRloK3Y9GpsW4lFB6IjOZ+Sp5TFackG5XlTT64wPtTNYlxOdXEycbkmT1Fq2NiUU97wzXp6VgC2LYyEclVyJ84V7nkif3isEnepMmFNBNKoqdAlMmWvOYuffMy4c5OArDJ5DiyP2Ap/rPBht3f0ctgXr9f1eRqvUlVA+syM3sB4LzQLlwd2jt9523WFzrRrBH7yrh0wA==
X-YMail-OSG: w9RtY6YVM1kfxDM_fpEQg.QN6oT_dIWw5qS1N3EUhX0qIuUjqaVxkLzFfuHOod2
 Kq0a9e5yedcGX11XOxpetT8BzvFHhTos_b5OZin2hSvu.28a2ifNQAU9NPuyAlfUj3Or1vt56dbB
 GWxPGodoqIdKBlpglWJLO0BfrXDco6NTXepkWHiJXTerw5UQomPO6wHe6MxmLGM0aGWNT8zU54Qq
 TJ8T3n77jtKu0ZmxR6u83ifJKabLdDwNFQd6gX.z1iQ05z8U.oRb2PO.uCq06fFZyIEmeEEbGnWO
 plmUaNzvkRFuH.hngJbbe3ox6c.d6JxezXGi4pc7J.RZIC2.p.wq9D5f.i7ECg9n8czydH3JvGMp
 x456UuFqvy3FwZAzljGP9dnOKY33fV8sKY4mdTf1CS719pxGPrxp26WxSFioi0JqtEwVFxYr5AYz
 JZy6Ly5lKNvCtyBkR78kEJVlHEgRymhCzMtd48UmmR6vXmdAdZwRuPRpLjsHEfTW8dnGgG6Mglpo
 .gjAwqUh7og1fmRxplFaC4S1RGFkIEF01kwVifmxRh16rueAPhuvYFy6rrm5yu50RlsdKiKNOnWs
 5DGzhMkT2Xu_ey64ZrMR.x8q_rbyLVbMwPC_CREaC.1IBxAhg0d5fAOyG9XzPnM40bkTmBYZTyQ8
 kVyEvfD9C9wBn2XXECyE19w5PeyMLQCtgoANMSPV72aoiWKYTSFggGunFsKcv9fBrWhs1eRAwDbZ
 OGnoRKtMWKdP9AMBnUHjM4uqpVkiuH9i5RvEbIeD8BgNl5z505ilGCy4G1E6qrwC4bySb9zj6rah
 i1OgPxo6vPGmzkGibjWliw1ZAkasewetC.wgeWVmXejvc9mrT5HQNbiYCZsdU4U0922MT8QeTRq6
 kkd4yAtlu81JW8KrkHUJjY6rThF0NN9JoJeTysoi.glOK6cRdSq559pH5RvqMITO4Dpl6jv13dQu
 yic44xCLItaFYzd0O9Am8GrConf8s_ely6wxULc67b7AIaOtyeEsTehHe.y7I4M79EdAbqtYhVHy
 an.kVx.OWyA_EIEDqKRCMVAAWYFkQwBsVEUgHtJxqTQ0wKs9s3oR5BhLtiAVBYbjcUNX7B9UUoHj
 p8uJf7G9kmqlAcue5ZWgU07jmW7_89AdZY5JFeUJPyIc.NLgT5tpr3.GRm__RE9Pzbt2w7SZr4ly
 SsbYQtNBnJ_Py8pM_XuerblVFVDmYhZaBCqBFlE9PqZo81jTZvy2fNRuYvEaRuiGt2aW8tcEOe38
 563yiXvN_MX3F5_ZJO42nSSF_UP8lKsX2ZE6gzEDvJhE6zljpO.tAwDBKNRy5hnf94iltacBQ6Xo
 PfmLL6EEOMwLlwFgwOO0Tz5J3QZ_O3waFOC1yGDxNpJ2jfcz0AeGTbKj8jZQ6TT9fspzcM4fST0Z
 3uKYET4xNq9m8PgaAWYAXH7oAA7HpBrCBmH6EAesmCa4A05CeBPGpa49fVl9WZD71pYbo2SrLmhW
 vTAdUgo6JCDL59L9gFR8nE_M.afYzQVPON674K.4bO7uZFIio_W5CfaczELbR88THRPWz99cGW4U
 sEyz55.WYA0bftz3IY_FxvtWHHDXO.RJqv9ARMyM9a9Sl42E7bjKLi_LRwWrSs6UHHilUbfwEKBj
 HfOV2z9MQQu6ej3PhvQ2hSjyOOprQa5_oiSqPaTwzxe2hq4C1y4jbJeTquH0YEkC1szRXa.L0MAz
 mHwFYYnlpFAOZqtIIuV.MyvM220iL9XGoDJABFL3_5N0Y9yfBdvXeg_N1FNyD.BNGiajxl10kd3v
 xpFfPAhWmauj92yFUy8ehalkdP7Z1b5N7Am5oLUcsPodpcEMOh2L_23xiI.j0EGM1M3ZpAA1m5Wa
 JYrhLKMgvwQQMHzZDkTqkEcHXoPALA4_UMMP_QzoqtQqTLvfu3aoWbNEsJqkGcwgJorKp0vNFX4p
 YL.F6Rch9UYI0xzw234lrGszvfW.yGAOuASIAAcMUNH8jCDymXK8KJJRp564ElBPJWZwzTdPJKyw
 bf520FZ4Tregskq7IWWrWhMK12HBQTGH5bXm_RSd0.KhonIZbHGsMmAqvYtfda08HBtHz6uWpkXg
 bBn3iTYSiTniZZ7ZvXHJFtBLSsRETZgDFddBQxK24nLYxVywmJFytFrRAAE9I7qNNtAU0RdA08iY
 NKe3vc5XVO1rVmHKn3A61hGTjZKARkIPIFBq92vDej4vfuhME_1CeKOhDtT4xJlTr1LzNeWsenVq
 iF6EQiVuSDqQ7IxKxgIxSc0aisK_UWjCGmfYPNm4VvWbU6LK7s0.rXLrWIQ--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: ed8ef1c2-220b-4a15-8381-57a869d2b36c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 9 Dec 2024 02:26:41 +0000
Received: by hermes--production-bf1-66bb576cbb-d88v5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 981bcd29f849ea07cc86fa337ec6ae6b;
          Mon, 09 Dec 2024 02:16:29 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Sun, 08 Dec 2024 21:16:28 -0500
Message-ID: <2959951.SvYEEZNnvj@nerdopolis2>
In-Reply-To: <2024120803-pending-handbag-4641@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <3271291.vfdyTQepKt@nerdopolis2> <2024120803-pending-handbag-4641@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Sunday, December 8, 2024 8:30:08 AM EST Greg Kroah-Hartman wrote:
> On Sun, Dec 08, 2024 at 12:25:12AM -0500, nerdopolis wrote:
> > On Saturday, December 7, 2024 1:50:50 AM EST Greg Kroah-Hartman wrote:
> > > On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> > > > On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > > > > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > > > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > > > > device.
> > > > > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > > > > 
> > > > > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > > > > real name here, sorry.  I can't do anything with these (including
> > > > > > > > reviewing them), until that happens.
> > > > > > > > 
> > > > > > > Oh, I thought that I didn't need a real name
> > > > > > > 
> > > > > > > I found a recent thread that seems like it suggests that I thought
> > > > > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > > > > Or do I need to wait for that change to the guideline be merged?
> > > > > > 
> > > > > > That change has been merged a long time ago, but as far as I can tell,
> > > > > > this signed-off-by you used here does not meet this category.
> > > > > > 
> > > > > Oh, what would it take to meet that category? I've been using this nick to
> > > > > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > > > > GitLab name
> > > > > 
> > > > What if I made the signed-off-by (and committer name) this email address? would
> > > > that work?
> > > 
> > > Do you sign documents with your bank with an email address in the line
> > > that says "name"?
> > > 
> > No, I guess not, the no pseudonym requirement was dropped, but if my nickname
> > doesn't work If I really have to, can it just be my first name, instead of my
> > full name if it comes down to it?
> 
> No.
> 

Can I do first name, last initial? Or does it have to be a full name?



