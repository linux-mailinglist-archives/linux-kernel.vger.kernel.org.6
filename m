Return-Path: <linux-kernel+bounces-179688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01E8C635B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DED01C225D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E457CB6;
	Wed, 15 May 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="FoY/q1zS"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ADC43144;
	Wed, 15 May 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763769; cv=none; b=suslMWzJuAQ4ISXlBUkN4+R4OHmm5ieZZHN++3XqMonWteboPGgS7PuQ2eJ5aKmuSSan6ec/wtN+yDFyfBHTVtUWG1dEfFfexypQGzaCnAN2OUusNNuku33j1RC6zifavPBWHTSmRcpEvMXlC9NaIKMJKzwGeLqjQGuSvWieTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763769; c=relaxed/simple;
	bh=/VuNJcv05SfTwBFyWswb2YfPZ2EOktMAj3D+B5OcUcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwenUxk98gR269Hz5q+fgLt7DzpxIHR+Dnk/R/saKGEbmh4f14mjYtFGTCX0IbbaRRoJ1Pv+ELgEVGMKOGhuq/AoJOgZtoiiXcylXOUtOufpWHshoj0O6AADJeXXjLcJf98o9ieQu/uI5SdNqi7YT1zlFAc043zdrY+A36ROFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=FoY/q1zS; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715763762;
	bh=i1+/WjWovmhqSn2DxEiDFC8cbnMZSlltFGKOqzlSZhM=; l=3603;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=FoY/q1zSUCCc9IUMYk6ImKvSdKjx9ZZrHgFaDChb98bTkywLjSOpHWleq+D7K2kJD
	 SejbRdi2lff/JH1J3EXAGgqIIAVxJFxf4C7Gqv+0TdTQu8eyKT8NeJT8xs1vP1OzHL
	 y9eec8uzBHSGnKofLCjxNMiBxUH+rI5b2ljG4sbpzqa4ucWZ4L6xZGabwTpS7I7oG2
	 khQ95Wis63Ldw2ObRnoL5eBUyGBAJ9oj5CF2fM3BcXUmvMzEHIaXDP9P+XwSW7djZy
	 Y9OrWzDFOMQwT6V6Zd0MYFgK75lkfPOQMnoJIMzC5tzKA4pgkzrsYbqhvSI1V74kR+
	 5r8f6jey5jcyw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213217:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 15 May 2024 17:02:30 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 17:02:29 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 15 May 2024 17:02:29 +0800
Date: Wed, 15 May 2024 17:02:29 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Conor Dooley <conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>, Mark Brown <broonie@kernel.org>,
	<lgirdwood@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240515090229.GA15889@linuxcarl2.richtek.com>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
 <20240515073830.GA12525@linuxcarl2.richtek.com>
 <20240515-wrinkle-engross-ab6b089baae3@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240515-wrinkle-engross-ab6b089baae3@wendy>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 15, 2024 at 09:06:06AM +0100, Conor Dooley wrote:
> On Wed, May 15, 2024 at 03:38:30PM +0800, Alina Yu wrote:
> > On Tue, May 14, 2024 at 07:01:21PM +0100, Conor Dooley wrote:
> > > On Tue, May 14, 2024 at 11:34:29AM +0100, Mark Brown wrote:
> > > > On Mon, May 13, 2024 at 05:22:54PM +0100, Conor Dooley wrote:
> > > > > On Fri, May 10, 2024 at 08:06:25PM +0800, Alina Yu wrote:
> > > > 
> > > > > > +            richtek,fixed-microvolt = <1200000>;
> > > > > >              regulator-min-microvolt = <1200000>;
> > > > > >              regulator-max-microvolt = <1200000>;
> > > > 
> > > > > I'm dumb and this example seemed odd to me. Can you explain to me why
> > > > > it is not sufficient to set min-microvolt == max-microvolt to achieve
> > > > > the same thing?
> > > > 
> > > > This is for a special mode where the voltage being configured is out of
> > > > the range usually supported by the regulator, requiring a hardware
> > > > design change to achieve.  The separate property is because otherwise we
> > > > can't distinguish the case where the mode is in use from the case where
> > > > the constraints are nonsense, and we need to handle setting a fixed
> > > > voltage on a configurable regulator differently to there being a
> > > > hardware fixed voltage on a normally configurable regulator.
> > > 
> > > Cool, I think an improved comment message and description would be
> > > helpful then to describe the desired behaviour that you mention here.
> > > The commit message in particular isn't great:
> > > | Since there is no way to check is ldo is adjustable or not.
> > > | As discussing in v2 series, 'richtek,fixed-microvolt' is added for that.
> > > | user is supposed to know whether vout of ldo is adjustable.
> > > 
> > > It also doesn't seem like this sort of behaviour would be limited to
> > > Richtek either, should this actually be a common property in
> > > regulator.yaml w/o the vendor prefix?
> > > 
> > > Cheers,
> > > Conor.
> > 
> > 
> > Hi Conor,
> > 
> > 
> > Should I update v4 to fix the commit message ?
> > I will modify it as follows.
> > 
> > 
> > There are two types of LDO VOUT: fixed voltage mode and adjustable voltage mode.
> > 
> > As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
> > the constraints for this scenario are not suitable to represent both modes.
> 
> That's definitely an improvement, yes. The property description could
> also do with an update to explain that this is for a situation where the
> fixed voltage is out of the adjustable range, it doesn't mention that at
> all right now.
> 
> > In version 3, a property has been added to specify the fixed voltage.
> 
> Don't refer to previous versions of the patchset in your commit message,
> that doesn't help people reading a commit log in the future etc. If
> there's some relevant information in a previous version patchset, put it
> in the commit message directly.
> 
> Cheers,
> Conor.

Hi Conor,

May I modify the description as follows ?

        properties:
          richtek,fixed-microvolt:
            description: |
-              If it exists, the voltage is unadjustable.
-              There is no risk-free method for software to determine whether the ldo vout is fixed or not.
-              Therefore, it can only be done in this way.
+
+              There are two types of LDO VOUT: fixed voltage mode and adjustable voltage mode.
+              For fixed voltage mode, the working voltage is out side the range of the adjustable mode.
+              The constraints are unsuitable to describe both modes.
+              Therefore, this property is added to specify the fixed LDO VOUT.

Thanks,
Alina

