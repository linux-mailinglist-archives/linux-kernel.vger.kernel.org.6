Return-Path: <linux-kernel+bounces-319284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA596FA15
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480E01F20226
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A371D6183;
	Fri,  6 Sep 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="Ry9skha9"
Received: from sonic305-20.consmr.mail.sg3.yahoo.com (sonic305-20.consmr.mail.sg3.yahoo.com [106.10.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F361D1F70
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644682; cv=none; b=kJ+6q0yIygur14VkpZuW1hPhysaRgB+bxBIZEnT61nHUZNHUxmt6K68XwCz27hZ/nLcz0Uckibx0oB7hxWDOUl77G9GAGxmEcUOAeLQuJ7SZbmEYyveeXYge5DsMxtCNnwlIEmRdURPYkSZ6CF8Gvgz7ppPI4vKHN8WlY7Qo8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644682; c=relaxed/simple;
	bh=ZNzSESrmnfYfC8WerZmh7uWbTuXGbUiGVU7tagoPiKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCOuEWNStrSix8XADFZA95AoW6oJL9Ij2EJ/gngfPOJr5ahtUCB6XKi7WqAQ7x3a5kWmVehh/3rn3PCfVQ0IR/LNmrhaDNep3I5VCCGlj9Mm/bm02wUPArW4fal2JZ1ys6NZy0GloqDL6a4b3Q1P+C/EqT3isgTLYnduCvPkbBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=Ry9skha9; arc=none smtp.client-ip=106.10.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1725644678; bh=TemEgEvPZ/peg1vfcBnLLL322AhBvVptPy2jSO3rR+g=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=Ry9skha9NV4cwNs29dCXJfIxj9LQ4yteV1s3u1p8t6v1dpF8f2IR0XBfPmm4S4zX1fsRYpubDn9uifWow8hHtyLk8k3WKR5Y6LH1t3unrsHV0GNVXU0+oKV7EoSsAZ361LUpJ7dQtdA8DNcDQB3a6bl9Z4BGE3Bspc90/BIFdXczUlP0d9IV+SBDG7pvrowRX/r1xtuTd4h1EpOJrSM07N0Er1cik8V1HypF26ay4RzM/N3ShZNON/RgHE/Xfw3x2PpMG5MWO4nKu+yep7/QO1CqQvMHrovg0eOI510SUuWvmlH5qehpMd0klnEKv/RlVVxWbUnnfcUsBqjy4Oa5mw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725644678; bh=hZprPXYLNS5GX2k4fyHSazOnYCdrYrQh23+dBd2vugd=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=rktxCY391Sp6fAhgN6wi3O3SWh9u4mNgMlXbKz80WNSsaDqiqAjn0NSQalnZsN/J4mIqdD8haF4PgcPeSY5CT2DkM2BUr1VT7Vh91P/Mpj0urZ5wYFHo4/wr6wOsUuj0A3RrVA0rkTCq05et6+sk3rWRW3f/imt4iBaAMeKV5F3KqbJ9prizIuZc7i19L/H/BVcFekLBotOtDneeHdDN+2qz0f/VulVx6QKBsIvgOhF8d7sqx05j1mxJ7PD6FMwpcWbRa6f6v2+jAsmhNu1IMR/aQpPGwrAcxDPJXGglQdmXD+4yLZoAfBi1MQVDGS6/RfP6PvRjBGzmvbla0McuCg==
X-YMail-OSG: lGxF_v0VM1lmSLZDM45qMiBLP9r8OnTNbR72Hqc3qrtGR73ys7jY5DTXDBtxCSm
 hPJDQfEwcU1I4V69NjMUp_KsaalxKv7X6GZi_FlzpXvn5zACQAY_Z6ZM3qhsKdvE1Egss9M7K4Nm
 haf0YrbHcXU_rmJ3kY3sZCOvrMwcYaIteegZIbWGw5ABhSoOj6r7a33FGNGY5Ooa7IvwgJrWUwfF
 4epP4YtsVI8QwAtU7U4m0EURprgRsZ1cUusivrh7tpL8LUk66KTuz01TVY.opoJUSt48tMVLnjN_
 pA2gRORrMWphPi7QLNx6fmJLzTFrBNgeih3mneO3LTng.X3hNFMMEFjvmn2XLi4lYJGGl3Ih1Qtg
 8TExc6Z_LufMOV4Q4Tah6po46tBUamSK8V5tNjrKylCFdmeBhAjHsf58Fi_XjOyn5HaWU._nSmIg
 .8Q1Z_4IOwQTtBlnaoVdXdaE87VJmv8OhJTasMUI1nlqFtNwghhWJc5nuB47nI.g2EqciDKZg9I1
 EewQI8.4ABL_AWySPC7nzcgvhhn6ZjwLWqjGKmcRd.H5KJkZxylG9bVg0y2KRlBpaJvf39llOLs4
 qTf97ikO1Hc9lbjcBsRcEq.svasoy3rHgvAiWLwmj0VADA01dRzFi.jb2yy9F3fXuOu0IqZRFYj6
 U4aBjRvru7tUJsfjEOpumemb0Wd99rfX_3vetyrcfZs6xLHam9ZMi_oY8WdJgC0Yk9paQflWMe28
 ZpzTMVQby_wbK.UTJzPJuTBIkOW.aIixIQ4NcQuVmTG4pI.O5MalFefvKUAKdkgHMuj_HUDbQpup
 B9wrllUauj9Q2iC2cmAw9y9Ooe3qGXZ1.xXq1BMtFeHqHJLa3j6mQlbk1KGGYDixVTSP1Pvq413m
 zRUNOF2IQyoIrUFxCOirmRwWDRSFTPAspFazuDsJVe9SwVKYHnyHm3M4i_P3.PHliL5eQciWVKFX
 _ZIFMOryP3QbyqojnNE_Wt1i53DD6ttaqUpNw0v0hh9wzkg8dchB6dXYUpkLpwFyMDz39Ymgdqp_
 IRttIBa9v5RpsGZiVQ.0RhzpaTsu50ruwLBw31R1.2jJwBkMdPh7khDgX6gFuiCwz.sGQ_MK4jtO
 i_NJ6FcQnP9VI9joq36oUNe_unsOkTw395CNO3yudDcqUiLzaUnoc_uoQrZo2OI0AVuPIts6pk6v
 ujiZkTx6z0_0XXBtr5Tsit_c5eDaZoRjuxK65N_O4LVoIqx8QCL803FK.rRfhWgtx2PSma3bYWR2
 Vq.rM0hGJS4gryiujV5It6N7t0xshFZfh47TEo8a2OERci4fSk5nkekjOJy2kmVgp2jZihScXzGi
 jwm98r0sYGCl0.qWX_Uwh.bF6qWFj5kgRnq3GkEKCpFpPRjRj8W_ZMfsobTJwpbqZjelnIg0I_3I
 yb3uZIODkSkgLFef3q98ZuVHwGe6peXl4RGq4UcOB4asgz7mCJRNgMZQwErW2V2ZkYG1qk97rcge
 B4L6z95CGXEMF2o25e4qanS74yymHBEllAXA9DJTFUXSswIzgNwLuffB74LXYbCwRPWpBAuiZem6
 VOP.yqdclxxjpaniGvtfpJIVBwbX2B.UfHBDJFOJ8ga7h7G0GDwS8ie2vf5ktL77lunAaYQHY8yx
 AniNH.2b2K8wuwmnOLKSuVyEXeutRO2NvR9Dco0t6s9FyBOn_Z1qPbT3r7Jlaekyo7Wwhj87T6zH
 CCEBycQg_i8cFrXz4HfkpQDMnByu_fxzvw0Wv6sBfXAhwG6NSXFBJoltrxr2YG97PDByrPWDnMLP
 AqsedQttUQeHYqE6foCgpvwbMwBdiZd97vQJQkd8jO2eJp8GMGAmev__ZvWjkiggMkUd407Dt25L
 2NkRsLySLd7wraWuOjsPbZyt8WsK3gTbHBNAHSGY8NyBtAC31t6f31MWwBQPaQzFY08mf9c_RcA5
 BI7jUjeB_nNAFXr8wp6vrFInuSO5WUebNlfbRbbVQfEvKQJog3eYbE.d1qos2Xix5fW2CjB31lKS
 Z9lR11LzQOH_ZsA4Wy41MUzGEI4yUBTCcawPQXpO4F0PnNKpQy3U3t.wJxpoKqCuHQd1aFgxH17O
 .rC18qZaiz1l0.HcXR36QXDx6bp3jyZOeiWoVbwQgr0RT7l4zudyBpuRfZA9.ct7tfcIZhoh.UGc
 MQEncXMamBZYTuRRmpKz6.vFn4m5X_aAZ4kzwh4vJBiqPOmYe55rhCupXukHMDi0Gxn_de_D03FW
 .QO4O1O7aU6YjiMzLRrUw4qAVyrbf4wS7Y4lCPhE-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 5831fb12-e2bb-4acc-a5bf-07c0fa5aec38
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Fri, 6 Sep 2024 17:44:38 +0000
Received: by hermes--production-sg3-fc85cddf6-tm2cm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 917e767aa2fce9f9c6aa56fa3f0d446e;
          Fri, 06 Sep 2024 17:34:26 +0000 (UTC)
Date: Fri, 6 Sep 2024 23:04:19 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: corbet@lwn.net, bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, abdul.rahim@myyahoo.com
Subject: Re: [PATCH] PCI: Fixed spelling in Documentation/PCI/pci.rst
Message-ID: <i432epqedna43bnow5twmm7bdf7dlms54kt5xjewalf5koamks@6kn4bx5lrubz>
References: <20240906124518.10308-1-abdul.rahim@myyahoo.com>
 <20240906164152.GA424952@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906164152.GA424952@bhelgaas>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, Sep 06, 2024 at 11:41:52AM GMT, Bjorn Helgaas wrote:
> On Fri, Sep 06, 2024 at 06:15:18PM +0530, Abdul Rahim wrote:
> > Fixed spelling and edited for clarity.
> > 
> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > ---
> >  Documentation/PCI/pci.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> > index dd7b1c0c21da..344c2c2d94f9 100644
> > --- a/Documentation/PCI/pci.rst
> > +++ b/Documentation/PCI/pci.rst
> > @@ -52,7 +52,7 @@ driver generally needs to perform the following initialization:
> >    - Enable DMA/processing engines
> >  
> >  When done using the device, and perhaps the module needs to be unloaded,
> > -the driver needs to take the follow steps:
> > +the driver needs to perform the following steps:
> 
> I don't see a spelling fix here, and personally I wouldn't bother with
> changing "take" to "perform" unless we have other more significant
> changes to make at the same time.

- "follow" has been corrected to "following", which is more appriopriate
in this context.
- I know its trivial, but can disturb the readers flow
- do you want me to change the message to "Edited for clarity"

