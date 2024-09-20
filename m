Return-Path: <linux-kernel+bounces-334680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9697DA90
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FBF1F2218E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395218C93D;
	Fri, 20 Sep 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="O9WAWhAx"
Received: from sonic310-21.consmr.mail.sg3.yahoo.com (sonic310-21.consmr.mail.sg3.yahoo.com [106.10.244.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2D136341
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726871513; cv=none; b=Mj89bniBErmxaUmSEC4+8LlgIC+QoziivzBNa1U+o5URl2ImEBHyF4bMlifNF2XKyNFz7UI4K5uYM96d5FQLhuJRxXnFlHLEYvpec16fZ2J8roxvoAf1U8ck/Uw3PI8ZQ7mcO/CtYnrXmwed6DGbWmSvpZY/Y5D1P/ZpJR9RXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726871513; c=relaxed/simple;
	bh=S3EUaGvQSUGjrMQM6Dkcsg3qCg+FcExmcLudME4TXrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgp/U8oNbrA5c5HeaNMJJLTv/o4bZafVxtkUB9yJCt7mu5nFwovoOPJgu87TyzqNhh6uTu4ZwPzi80kHsSzWr2Ub4w5VVpsgGDI7gR8HQ5PtY1gxCz5Tt555QeiAqP7OfVyHnTJsgHsgWQt8cjJ7sg9sVlTWpR7CC4pIUqV27d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=O9WAWhAx; arc=none smtp.client-ip=106.10.244.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726871502; bh=9u6ESS5Lcr/sJjALlRUo/j9k47a5Jeb/37M0+Yd7Im8=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=O9WAWhAxavccdt4uSNZKBeC87vdOLcBoF5KT2sqHFehiJs+jvXix3/j85bN9p4W7gAY397lexwaNjB11VA7KFUdQdVmPIwlQHrePQ42T7Wks5RoDeUkAKq5jxMI3NnWG2jBh9M5BJ+rSR6uP8Wum0HiNxO3rP+5Xyz18pu+cJzdv9aTfFg/OrkC2+oZBMoslF0LnuHuMVw25jTvmAP99GrSzRAdfk8RDheaXAgaUSOx1jylkglcM5lcAJ7JPShlLnUO38Zy16USuj+1ORzkauLZWU/zoXGV0LmT0mWrAKqEQuusKoYTFNDESdsKVEZ/aMUrVHa1//69LELRSOn9Y9A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726871502; bh=DmH3nxOTtRSmSOj4XUP5cRTYFEFV5pq4rTsrmY/9Zg7=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=hPBFIZuD+kzuWlSi53FPXBBTGkITaPXU2r2Gypi0s/UiOYuQU6z5KkAp2D5koLziD7xtKm/uv0TeLwpmT5QVhaT/bLykTa33dwz4jteLt5NP9gdDyX/7Wxjeo6knLTpG9FfydSmYffv9Dpl0CDXza+8daf1BwSIDqcgfEsnVYT60970NpSetV0CVM1W3iaGNp5v0uMPbt6E9IdGr6HmFEgdpI+WKjOi5NzaFULUWVD0etidBh/yPgQnSBgCWFl7LEz0wYYtTw4Hznt1LYVW8tvXSK6T3ZceyztnoFXegztoikYR7nLVpHH3teG/NY518JKvZNC8+zDY2gSls9s8qdw==
X-YMail-OSG: KzAv4uEVM1mCZvXu6Noi9gp143SNSMpo3y5ouJdcLDAmBMTyJJTTEKWnPdS.o27
 My50MVr9Au9rXy55x8gyqOB11zrllRmRnnBYwLQwMwYVCCYPGnjQhvl11JYMbr5mhDdliTA8OAH.
 uQQ_4gKSnWWlj8GdUd7NXVF.7L95NuqJbID4pwP3WfG4_ska.A0jYKIgO4b0W_nzpAjvVpt2fgYA
 xmxYwjpBFM7hGLUapxPawtKDozaVcU1.1HTi8CoOpM5nYU_Te9L8TB3YMxGZhVLkqtMwJXHs42O3
 Uqi8gI5UmJf11Eg1Wr6ToCIGfhxFKvtSJuQrTGsNFY5777x_gbVq9nXC3zRORjuoc_9oDCN4uk4e
 1MSeH1ss1VUeuj66YG4zisfF4pUHBgAKH3jSCQ2ZJ9xu.YsHa8vucYOmoC3rP0g0e5f2gvKTNpEr
 FBTdpbb2ymrFGg8eHKjBlgU_c33.aET8wtOn_BKgiqV6LYo6AhkIyM7IWJ34KrKxbWFdzb010qhW
 VyqINHzoIOj4BFHsIuJt7rNcJ0p6Af_dANuFtnRUnRNtW3lmjx1dfbqk6fuONT0DmU6XdaB8rpWT
 OS8Q52IvCd8lwadw6dTa00Jp3iazNlWdtu0IMFnJZyxFF4yI5kRatXdRL8pLnBVqAkVGoi2a.g2Y
 kkymSxEMvBP6IQ7lxf4sVUp7TpgFNfLwIBwk_ci_P2aF4M0wX5idDyUGyh1CY0KIHmX5mmQ4yx6Q
 geZjT34PeWLPXYB4hj5AogS.KpRWsD45cIBSi1SJlWDe_IBGlvtchqtLzJbQD1Pw3F61mZjzoLyk
 sHYFNRWKoaRaC4rnqcRBC_2no7JhMUOOS0bgA2Tc3wC.YoEtKl3qTLHqhncEGclgjOwEMK7auWDW
 Dpb5CxW3MotKFDdLyFroZc45tmISbkTaetjciJZqJhwIanoSmzTN4U2zyTWUBk_z68OGX1ds_N1w
 6LY3bq.CzMQoySkBYWv2j6aWD3hK.pyFnaq8SM8mr89i6yJ2KGpok3WwpOdgYuW2TXoRFxYpBbfZ
 qhWPcMcI6UlKPRnPPJDy60ELfKrnR_hi9Nt.QUJFQ2EHKa9wNnV.axjiHl60BncEcwPlCWQDwRm_
 CTefPMV11mdARY39.R_iC.P5CRtHwcJwX26xBl.BCPpmQ0Qx9Fw1QS.nbPfx27cpP6p6dSwpkChA
 gwBXANEycfAT3bC9cqccqHC1kvPSdIPH.JdTMr13lUUPGtXNve9BwTGqXrUW7aJu.7nnb5Cj.2PA
 664g2GdsceJS3Ur2H0lK_FQSvuOZWaHDzuaEKFooGJTudlTe3ycQSQgNJ4tIpzDldLx5wFk2XGpF
 TPkwtwpRQFWQkqxAS6qc9j6FkioweXhA9gbfDjt_ZE1thFWj3lHn8WDFj9dug0Jh5XC0zwPlFP9K
 Rzfxces9BQeIb.wyZ.enJ8tdtiwIO6Gxk_gtk06T8nV2LLU6ACFLGXLjv91v1LmPOqnByqvZbk3l
 aNwqvGjidh9ZbLY9xhq7Bujq0ZIQxpfej6S0kMJmO6hznUnilPnoaugJk3X8BCWVA5djlsBro0zA
 YM8kOCdmFA2ki6ILsCtfxYrs0iKZpNOwwArFm_eBQ.kaC8bvlFX_7GAIVAtG86JpjTYGAq4h0wCY
 CHn.HTl20BKz2KZqrtQyvOgLSZzcaEbf8ZvQVJYW6Lm5laNM_K3.uCHISArD_Qpg1yw30HmAp2dG
 0gxHgVfIfQsvq0qOmrLdR9GxTSBE7dDd6LcROc.zkBojxRWcKsRqAUIEZ2G6mNJeNJJLzsBeFOoO
 QDClmR3UaEeFfDMGqM5YevjyA3VFt9rh6zLabkMYKpBEc6a.DkBIHe5txmv._QMnNK3lq6Fn6.FF
 zSYbTMmwMk07OmBf.blaKt0TnNae0DtyA2TtUxv_NjtOFeXpRPT_q29NnkZ82e3wsDYk5NKmeTCV
 .7V6YWViaUwtJ5e7fT8fKKFiC9Lo3YyJ1XhrN0F9bzqZUgn7tkGNAysA2LFIYUQ_OY6v0Bnc40dP
 RH.u1TkfGRGnEfPO9i6ymrZdF8hIlciacADcszEKz1duT5AHBeNaGWn.t7fO.NO2QTZexHrgVj37
 rRsSLPilJBFlI0OkfTxozHkPAxd6kATZvuKwnWLU5Up0oFNEsV0VeU7T5iQaeBVCLWNJS.fYBCi8
 JyJcXrNMseumnVkhUCEWi3P0IOPtuqg4VfHFyKlrkZZs_9.wqQZfUEGBoBgv91jTMHn5ddPi6HTm
 K.3F0sqDO1kGJJVo1dUoz4EMSAfc52jtsbXbmjaJE
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 8f480c15-3224-41c4-a621-37a91a9b51c9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 Sep 2024 22:31:42 +0000
Received: by hermes--production-sg3-fc85cddf6-m4s4b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e680406d2f7b2a53297f7fb694c75ce0;
          Fri, 20 Sep 2024 22:31:38 +0000 (UTC)
Date: Sat, 21 Sep 2024 04:01:34 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, shuah@kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: add silent flag to reduce noise
Message-ID: <y6a347udrtudmbfsq7erk7m3dt5smasqg3mffaazwl67zua75d@sl57aj6rwa3g>
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>
 <20240915234131.61962-2-abdul.rahim@myyahoo.com>
 <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
 <vzrosmbs5x5mmnxwubwljjqxo4m4eih35z26cudshpbr3uue7j@k3v65fkr24rz>
 <087c4ef0-5718-48d3-9367-1d79a255fab1@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087c4ef0-5718-48d3-9367-1d79a255fab1@linuxfoundation.org>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, Sep 20, 2024 at 09:27:03AM -0600, Shuah Khan wrote:
> On 9/19/24 15:49, Abdul Rahim wrote:
> > On Thu, Sep 19, 2024 at 09:40:34AM GMT, Shuah Khan wrote:
> > > On 9/15/24 17:41, Abdul Rahim wrote:
> > > > When ALSA is not installed on the users system, the error:
> > > > 
> > > > "Package alsa was not found in the pkg-config search path.
> > > > Perhaps you should add the directory containing `alsa.pc'
> > > > to the PKG_CONFIG_PATH environment variable
> > > > Package 'alsa', required by 'virtual:world', not found"
> > > > 
> > > 
> > > extra line?
> > > 
> > > > is printed 3 times, which generates unnecessary noise.
> > > > Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
> > > > assignment, so the message is printed only once.
> > > 
> > > I would say this message is alerting the user that the package is missing.
> > > Why would you want to delete it?
> > > 
> > > > 
> > > > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > > > ---
> > > >    tools/testing/selftests/alsa/Makefile | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> > > > index 25be68025290..cd022fc869fb 100644
> > > > --- a/tools/testing/selftests/alsa/Makefile
> > > > +++ b/tools/testing/selftests/alsa/Makefile
> > > > @@ -2,7 +2,7 @@
> > > >    #
> > > >    CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
> > > > -LDLIBS += $(shell pkg-config --libs alsa)
> > > > +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
> > > >    ifeq ($(LDLIBS),)
> > > >    LDLIBS += -lasound
> > > >    endif
> > > 
> > > 
> > > thanks,
> > > -- Shuah
> > > 
> > 
> > This can also be handled like this:
> > ---
> > CHECK := $(shell pkg-config --exists alsa; echo $?)
> > ifneq ($(CHECK),0)
> > $(error Package alsa not found! Add directory containing alsa.pc in PKG_CONFIG_PATH)
> > endif
> > ---
> > 
> 
> This is a better solution than suppressing errors.
> 
> thanks,
> -- Shuah
> 

Yes, i see. Because other errors can also be silenced.
I'll resend this one

Thanks mam

