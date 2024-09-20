Return-Path: <linux-kernel+bounces-334681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB697DA9E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B461F223E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB618E35A;
	Fri, 20 Sep 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="Qg94wMSn"
Received: from sonic307-22.consmr.mail.sg3.yahoo.com (sonic307-22.consmr.mail.sg3.yahoo.com [106.10.241.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84918CC05
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726871730; cv=none; b=q2Z2GSXpwfU1evnXRt6DgBj3L/DdpMwPlYdiItsTVzpzCDdwQ7PYauBG0YWs3k4l7gGR5sQatXnVytrRFWM2H3kgFFvNfSXJVHajPYf/eC95zHqvNcN9zraSw7m8BY/Dc2qw8+xjjWuAggZMfIBaCMgIaLlpPV9eWYDwnR0DXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726871730; c=relaxed/simple;
	bh=ynwTPQt3EEuFM1IltSF7bFvI0pL3GFbj80h+E+var7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+NZZquuSIehzO/0S0zCU/034x+pIm1D06K1fvdVX/m5arl3FDYvgYrFtpzAsw7JsVdE1k+gGJj6rJFmfUUkdVqf6Rjuk/1Q4Ngk3cak6DoCrEqg9yXVNYiS75wo2KDid28UaiXGekGtzBQ5iCV1XLMAqLJi7PdpwuJ2wk3Noak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=Qg94wMSn; arc=none smtp.client-ip=106.10.241.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726871721; bh=bbXD6ZZWAG2QayoHcXFfx6d5jUYxt2bzG+6Vl7rV0GA=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=Qg94wMSnvbkhV7TiI+3IJ60hr67meH84qLUDuHfTAXkdN4WO+n+p1EJltUpfPRT1Xojdm9W6NrPTUk1hMF4asm+PynH/6C/VlQfF4a1fPcAAyDD+yPFZGP2+R6OCKkbuOPxdQ4zjnsn1+NcBbfwzdhtw/NUozGxHoQ4s4z4DVpvlguJCqldYNh5SbzPwl1VFBKripo87q96ptraAKBjQaU/XL9MNNqpIAd/JVBRzMyKQGYd/Re7X/vOpBE3p1OhtILE723v+Qx5X9nSukAUFKy+/DbvKi+eMDBeXzht6lI465FKWZqHZt+v/UDSCXwGgMa3xk+AcPTCVvnUHrJQrlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726871721; bh=Qt9hsrFjIFRMme2LHVz6pVbvAcudommN8wjxaIiGI/+=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=be3uwnABAuQc3zX2HctMuGuOkQsHwl/g19RlUX+GcAdt1ik2aeqRptJW4IG3NLJ2u5oLBXsvj0IqDCUsnHz6dOeoeaw1anRSpfgyqrXNODH7gJh/tqsS01LCEGDWpxVn5NLMYdgQ9rN9/99brEN82mJctwpgbntDA609aT9MUvyisFvfD4GubGaEjvKzMf+xeayAJ+p1XyLlQh3wfvnOXScYxjDALdX8kw9nVP8F40WQ4Ud3JvOoVZG+QB5tfedO0qWDR0W0dQmXKg1o3h+C82442pMBOPGLcO81fdBsQ846HjieMeQhCHxpSnXoMP3HCQESe1IPDOA8Cxwg/QUHJA==
X-YMail-OSG: sTZYpiAVM1ngX0U994miTIUG7JlNGUNfp3zdjJhPm7xp.rWPlvWem6Rf2zpeLtu
 gMT4RHDtmUgqT9ZjLNlJuDLlrPKnOSnE1uU9mExqv8iTawyZeeUraSA3QUiVuoC34uaNW3WRkfHi
 WS3TZrxdv1R7qaZF9HbYeUn0NvcA9M8z4ZfRuRnOkZk_EVL7zHk5ZPdfELuKJl_fFZCHndoDbi1P
 AkBHNQvshRqo3sIEPX0oSLx8eJBKpYx.vKCuRbqTOJKaX.i9XSJNe.YUq.aqxKUB662v4vJoiF7m
 X6CDXE2qw9642sGeZKbA9YKyLBJGdgmBlxAkY3V6XeZ5PICrJTeb3eTdrJXhteAHM1sgpdA9ODQx
 KlUhER3JL5_bY79TK5tqwtP.H92jxTnUlpC6J9mhuCHv0MPspKk3mbZH_quh137JZZpVG6vOMMfQ
 6Q02.67EYloQ.dtywTOqNlmU39.H8dXhXoGevMIMsut6RbkoX0Iz8qd0UJ9_utvsckbJ7PqOMn5o
 cruLxqhl6CiZeF4aNbV_El.ZDEv0WfXkGlrhZc3lMi8e14gI29jPnHeDS8_XesjOfrdqGkt5slZz
 yOBeWhOjgrtA._.tkYh0c6mAUlJkzEvg_sITVhge1LDxRmRwjpCVbFOZtuamnUrT6Xv0BK6aYZeW
 uXZ0L_WjjtilpSpOxK3s3HtFOdOOf07LKfJU58FfdKlF1hgX9g6PmHDosmcS14hUl0mgOppQgtKM
 TM6cPQ.G7bxNQzmoiL7eT5DDSiRhxz4IimASF61q9GFQpBVHbhiHam2spdk0ME1PmaRneodNg3kX
 SZbjfjVMLUrgTt24P2tVn1Subs1kNWDZRSaqco8MAOwEEFY9970tjs3YZFA6zj8Vg7Ghh3zI3QmI
 RObrZbry7Csm_PhNSmx_LMxgy_T7eHAU8Z0TsvQUdaVk1ucmXUYYBsVsvRnL1xPIIUMo3Hmirqo_
 ABGHbBszqPXZ9kUjVHRke2U6iYNPyhyxBRYRhRcBdE23.L6l.f0KsXw4mnfTFNA0i8dnDSQ8wI6x
 bmm0pjTIfW7X_jGodVY2p_lSR.LbVVC3vPGPdY.XeJ2ehx3xVV.WcIcAl2DWYM4j0uUOS33jQmMR
 _BrB0AH.Iua0VmlGl5.OQIc.PYdy10EX2LzsNvU_WaZjHAY0n2QaFjvieFykzaz_WsLdvTMrk4lT
 9e0X2siYuQWu.CJ2DxBUHvaV1JJfi__dgr15mMoOB7cpOuzYebczR5YvAn5Lzwx1XGi4tdzcTm3K
 fQcYPCWL2wzfMbVumW7q1okxTBS9Bp0C28MQr88nx4NbB9GkyXV0RemsJefoHD4JuZ2iLzGtEPIC
 bep2tiEFUYaW221d9VJg7M4agW7jkt_25m__vmjtwT3vimxHZbtJCVVz8falzci6OOaMG3HVyBm3
 foQedkVT8x7icrao6Zdemt0yLloGiZC0ACuDTQDsJHkTCAArAb6HtMwuMZGcuow2cXuP.WDasgIo
 JytjpGOXhdLUjIwZmogLsxcYVObGCBdxrfTnCvDdgRZQjJj4hUUOihnrn7m21kqxdyll7Kv3S87B
 k18ihA4uka0Mc385LBBWoJ8s1f9UARVjJxDrR1Y4K218lkZgC0ooGbcyUHtqOp9zUclUFP3kvkIb
 ckf2VMqD2FcW5Jb2PvE89QPBznZ47HeVHB2WOGVtpKwoxh2PPog9GUGrXODC2Q4WoZ0IzB7a1680
 marlgOqIKbZgmgGs3atroylwYVpuqsAq3aSMR6lZNgyAYcmMRDY45lbEPgFP.0lzRDWno0_QMFE6
 eT_YC4EuUkMrrK1KP5Owsvhotzb_WQGR4WpnaBZeLKojTPnln0dyYjelX.MQDdmfKAWI5YVMJMnX
 QAuQnAemUwxdj77hRlkYcV.1VOpfzJzLID5JwmsrputKZJx6Kx.MCFil7HHTubBrwa166UKtAGGK
 iax8rTO2oSa.sBQoyc_KmSQSVHvlwufdPoZhECwxDu.sawNU3YOaOfxuNy.E71qoCFKDFjL5gww_
 7zoS23B3NiJ6s3I3Brz.I.wdPTzxvxIYPz726s5M6qI7eLY6wFv8piiRJQ1aGjSswUtsXE84L_HX
 ZKUspHryZj3oiYiODLRRjw7uc4cBNQT6RInaDkd9.LlzAMVaNbV0u1.mG.8bJNheWFUJ3XKtHm_X
 v.qHQqo3Ed9Q6QfCAbA2YlmCc66UCEgKNG40DSCUFiZ9Q06cxMloqAwlDR8XTdaZI.WkAD_cE1vW
 hAOQ1Wu_WCW.njrs_pZ0U5HXom9f9nJCQ4o5UKwzk
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 0f66d0ef-a5af-4583-be26-7f5a652f716f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 Sep 2024 22:35:21 +0000
Received: by hermes--production-sg3-fc85cddf6-lbhm5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a265e4ac70651aef09ca596118f330c;
          Fri, 20 Sep 2024 22:35:17 +0000 (UTC)
Date: Sat, 21 Sep 2024 04:05:11 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, shuah@kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: add silent flag to reduce noise
Message-ID: <munzs5vq26hnpcdtadxvjveloouvebohrzakrxvvfkhl2ogce2@gk2laokr2che>
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>
 <20240915234131.61962-2-abdul.rahim@myyahoo.com>
 <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
 <vzrosmbs5x5mmnxwubwljjqxo4m4eih35z26cudshpbr3uue7j@k3v65fkr24rz>
 <087c4ef0-5718-48d3-9367-1d79a255fab1@linuxfoundation.org>
 <62c6883c-19ca-4ccb-ae78-dd3e665fca08@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62c6883c-19ca-4ccb-ae78-dd3e665fca08@linuxfoundation.org>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, Sep 20, 2024 at 10:24:56AM -0600, Shuah Khan wrote:
> On 9/20/24 09:27, Shuah Khan wrote:
> > On 9/19/24 15:49, Abdul Rahim wrote:
> > > On Thu, Sep 19, 2024 at 09:40:34AM GMT, Shuah Khan wrote:
> > > > On 9/15/24 17:41, Abdul Rahim wrote:
> > > > > When ALSA is not installed on the users system, the error:
> > > > > 
> > > > > "Package alsa was not found in the pkg-config search path.
> > > > > Perhaps you should add the directory containing `alsa.pc'
> > > > > to the PKG_CONFIG_PATH environment variable
> > > > > Package 'alsa', required by 'virtual:world', not found"
> > > > > 
> > > > 
> > > > extra line?
> > > > 
> > > > > is printed 3 times, which generates unnecessary noise.
> > > > > Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
> > > > > assignment, so the message is printed only once.
> > > > 
> > > > I would say this message is alerting the user that the package is missing.
> > > > Why would you want to delete it?
> > > > 
> > > > > 
> > > > > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > > > > ---
> > > > > �� tools/testing/selftests/alsa/Makefile | 2 +-
> > > > > �� 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> > > > > index 25be68025290..cd022fc869fb 100644
> > > > > --- a/tools/testing/selftests/alsa/Makefile
> > > > > +++ b/tools/testing/selftests/alsa/Makefile
> > > > > @@ -2,7 +2,7 @@
> > > > > �� #
> > > > > �� CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
> > > > > -LDLIBS += $(shell pkg-config --libs alsa)
> > > > > +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
> > > > > �� ifeq ($(LDLIBS),)
> > > > > �� LDLIBS += -lasound
> > > > > �� endif
> > > > 
> > > > 
> > > > thanks,
> > > > -- Shuah
> > > > 
> > > 
> > > This can also be handled like this:
> > > ---
> > > CHECK := $(shell pkg-config --exists alsa; echo $?)
> > > ifneq ($(CHECK),0)
> > > $(error Package alsa not found! Add directory containing alsa.pc in PKG_CONFIG_PATH)
> > > endif
> > > ---
> > > 
> > 
> > This is a better solution than suppressing errors.
> > 
> 
> One more thing. "make kselftest-all" has to continue even if this error causes alsa
> compile to fail.
> 
> thanks,
> -- Shuah
> 

sure

