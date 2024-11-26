Return-Path: <linux-kernel+bounces-422112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E419D94B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF7161D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDC01BC9E6;
	Tue, 26 Nov 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="G4z152eA"
Received: from sonic308-19.consmr.mail.sg3.yahoo.com (sonic308-19.consmr.mail.sg3.yahoo.com [106.10.241.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6951B87DC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613998; cv=none; b=QVyTlWbwhGMcZlKY0C3dP97n5qFoAPSUobZppvvgP7V74DzesqOTkv28SfqAFP2PTxA4Hua9XMFl7mfvfj6Yp7a+YQVJKkF8YNVvrFRgi1eGZc+ktYTXjn5xM3a57yY7xRO6HJboW5fir5l4f5Osqroazjb/BedOK3UlfHQsk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613998; c=relaxed/simple;
	bh=/3JFtc5ilzfuQxNvEAKYkEPQZ/GWWCpYses97szP1s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXnNeFpJ5pAX2lIZOMjF3N0uJvveO768lrKH89aa4IT56P7cptqIcIhXMlvQl5rcl14vPcJTCzv4bPnANrTqIrZ+96WvyIJTAaonvghypMm+wHnbCv8fk2OegR2W1ra3lwxauhEq0Ze2Xll6vCXgZXeXZmY6OArM2t4ZL6MQ/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=G4z152eA; arc=none smtp.client-ip=106.10.241.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1732613995; bh=5frkb0XG/CMLADYqVkEH5JvrRwDk+BB/26kXN7gU5wk=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=G4z152eA1dHGhCFymYesui8VILkum1ztQAjQUpTBqkgSmPJdvBKeQbrkwdbwa57WfSiv2caB9IODcYpGJAMUrkSeiobI//JThU0mjEJ3npDKW/m8Qg6etUYC18vfpasO5N+S0kE8r0XraXDlOaJhU9IeSVI7kZ3AF1lDE3ytWGSv3AjrFaiihn2KtnvjCsBdtZ3a5jcVWv91oKxGyUp9JHulEzLsXfbsKN4F1Ah8G8pQdh9K8JzUBVygu4ti0LHDeguY/l5pp3uAqOuFFJHYDLXJtE2TfFZooACDv5MPt85U/1G7kEdB7KFxWuAzsYif/D1Tmt0qgVIHVaTsDztfgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732613995; bh=b1pAme0v3HUxwI052sy+2st4jS6x3tyXbcYB+2KU4ZD=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=IvPAUIWEvYBDGOgrt6pDs2nyEba1g9VoQdUtl/IelStwQUnkcZnbjDiejqCd4ino68ykn29q+IX+k8vYYUrOYCGa/V2PQA0JpwhTXbpsH5bSlzSWr3+vdvykpCndPTMurP6kVUjQYs0phwyFzxXHKL+A3yF9L9kkAH+pnruOTvLY61C/3DlBM+FoUySlr0IjXiyWtRRHWeV7c6+amIxnvMD1kF/aXYz1NPiukEb+RuJLtG54cUn825Enqr9QjOzjzAa3XtC2AHGx4MZswOOZOxX0pSBzdByiQurgvZ+y3e8BU35yPwWRMFbG8Y0dX+zW0bpv0Ov7FD9cuc5CLJoOEQ==
X-YMail-OSG: zDcBc4IVM1mPN10C4jJ5z5pb_rAlefofE6KUzkKLmbe5prFaNmHHEmj20VBLaSx
 m_Ks95U8AjNoKpUdgfvxgIxpZhZk0cBwawjgHodwc3Z83_pxEaUB27LTWtlazbp6vIucFiYx5jlM
 _8qIWeZZdUxA0_D4fB8wSZuwAl2lffVmrp08IvNG42ZiGqesOnrdKMGMXKIY.I1AVvyS_TnNSwv0
 VmjIcRk1J9o6nMzBBRyhg8oxisJUF6dSuVeaIv_IY.jsKFkqP6kUeW4S.paLogAmfP1qaO6gxmMB
 OjXMjQai9pSyzLg2sCJ.Uu1lAyj2H25IV6JZ7VtHEXEmY0zrxLd3.sIm1R757pF6t_aTudzfXnMo
 g54fBUmmhlXZTcBRwt2m07pgw7S15FaUW159qi.sbt8_fNiP0ZS0fWwMlGUVVygGCMa0J4dUmEoE
 caVFzoojDTOCtpXzESFhn4v0xWTMQIgFmY1fRKqz8vlw2zBSLf1VSlT3SpXotOYdiFblpuwkxJhI
 RjJZtWsr8ydvhKKsVWcOX4OaI5UGhemAPTxA52Le2dUKL0IKI65KaRf8MPIYOB8sQPX7pS3YgjvD
 5OdegaNdgftuzYLm0tOn0n7IVnXcanYcvXUd1Uv8vekIKDXLqwNcbW3KQbmmwD8HKObxUDQ9EgzA
 TG5MrBkXs9AucvMERH5Kl79GlTjKXXq4Jxc043CtphFv8GK23mfYV2NTnquH5ibCIms44jTG1.rL
 1bH8zx.se4thAZjsaE2.ZQlD2MFa65i5cCf8pNueGEo9jvLzIzfzKnEXofK14aaPEZez5lTIblFq
 cUEB0V0bAgT1FgEaWpqk7LwvUjxJ.OMl3cZVdcD1gl3cT39i61ks18fXDNwchxQHhkcu___daafg
 rnlJRHKWeoc3.YuizXUKeGUmuIGkPv73IhQHxCBNYeQ8KnBWOG7QIRLMeesDR6tQwUxnsM.OlPuR
 Uuf0Qi24N8bJW_8Q9w1dDHD3LiUZrB1.N42Vj3OaLlMaVBagZMwJoHZa3WFCmPe6.0ejmBzqtWBN
 neG0zps2yPEgS0xV6lryXFZg5hq233l5785tLC4hmuJHFQIjhxaWo2imiPWXCNWR5cMlSn6DQygZ
 ZpjDwsmZO2bczr4efiooAmGA4Am_2ZQOrPnMiBC1hXkx1q4GbH0.uTHcZ_rQaXCETDOGWLa8FY0G
 gPmZld.tXl_MwLoKDIVm.BnKaUEuQ3NiYAxuwCOsV6xUU2DmNKKWSHkidJZUW3s32MnfVYO_lM6L
 _yirblmXUaxMip1F5l2kt7Nab_bBGmaPD8eqJpq.bJMBO1KSBYooQba9xMykjK9rb.qbArUtI86.
 4yziUtt4bQa6eLww.RtvYnpz0KbHQl.iBn4wgxkIzN7jP3OCM28GRaeQxdZ7.yrpu.O7hQZIpEP6
 Wh5kTUX3108s6Rfc5pD1Hzl_s0Ii8Up1p_uPHWZx8WScePrqDpHwiFvBAeyvgdsCFwtxiD1Waee1
 OUK9R2.0NH1.BWvqAfnyeiq7tbyRagteOaH3iVJKLXQjP00UvZEMx7xlE_fLX2M5wvH1wdIwRm9O
 pKk.iR5Kys3Ua0uK.bUvYtNRUHgtxLupI2HXunbK4Y_b6WD_cwQtsXo2RrJRQT1_qCeO2Bt.sCqC
 9kYrUh2WW0_IyrAc2iPz6EPUEASX_iiJG8QzIjeOtKOQRfeSTaWeFB_QBv.Em0fkUmhVEnIu8ZXt
 KJOOTTjXN1h3B7_gzyjHRUFtJbfgtuleC064lSiLFdoziARxeApPlyvywK_DHoqatv1FGOdgINKx
 OYGwrjU1XyvIdCcDwIY7KLRWkCE9TVu43fRw_BCUvm74KsuSRWunKEUmxdDke9L7p1Ict57uDKr3
 GuLSkG6IU00VLQKH5f3VbPn7ctX6.fSaHXg9CnercrmTwNe26tqI2B_E937AEvJ6kcuuiJbozNB1
 kxCEMVun1a5c_ZY26h2nbNt6_J6N3dbnHFbOalD5HHgUKnN7E5hE4ImAF1GRtScjmuPjjb1cJ3fp
 wOxnVhzEQZMoFn1pLX3O7BjgHfHNGFfDOggQ0a2OBNv7o6hw76MTjpFPmPZbDwQdk.YhWU.PyQmq
 ogvGe6vH62xJv.4bawezWFqBSAcRBo_AVbnRfbBCEsATP_wbwhPWlo0rubAEFpWYZNVrNZGht3Zd
 JxUUf8yXI0i0CszTXbD66KBPb92sncQK411nxZmag7HGrQrq0T08QQK6pyEkEPPP65GJcKoY0qud
 1mJJCWSg2Fsw5HB6pUPjedb_klfq1Sw--
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: f2a438d5-bda6-402c-86cd-db3b61718e3c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Tue, 26 Nov 2024 09:39:55 +0000
Received: by hermes--production-sg3-5b7954b588-4m5wk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 39eae54d0aef5051dd25d7dd57dafd92;
          Tue, 26 Nov 2024 08:49:13 +0000 (UTC)
Date: Tue, 26 Nov 2024 14:19:09 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] nfc: s3fwrn5: Prefer strscpy() over strcpy()
Message-ID: <myr4qk4h7pkvvsqzn4rpp2dqpuwkqwqllb6jgblkhwrzfy22r4@hozqqltux5om>
References: <8e68e02a-2c58-485c-a13e-a4b52616e63e@kernel.org>
 <20241125204111.39844-1-abdul.rahim@myyahoo.com>
 <47915021-e5f5-4104-88ee-229a04ae765b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47915021-e5f5-4104-88ee-229a04ae765b@kernel.org>
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Tue, Nov 26, 2024 at 07:38:43AM +0100, Krzysztof Kozlowski wrote:
> On 25/11/2024 21:41, Abdul Rahim wrote:
> > Do i need to resend it. What additional information do I need to
> > provide?
> 
> 
> You cut entire email, no clue what's this.
> 
> Best regards,
> Krzysztof
> 

Do I need to resend this patch [1]. You gave it `Reviewed-by` tag. But
it's not applied yet.

[1]: https://lore.kernel.org/lkml/20241029221641.15726-1-abdul.rahim@myyahoo.com/

Thanks,
Abdul

