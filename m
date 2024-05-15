Return-Path: <linux-kernel+bounces-179592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400CD8C61D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21E7B225B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175C446D9;
	Wed, 15 May 2024 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="vO+tq9RC"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86C4AEE0;
	Wed, 15 May 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758736; cv=none; b=cg1iOvnLgKv7/wC49XbMI/5cwCNJE8UiG8hu8IuE0ETgRMoPINGuiZTOf1SV3CXE0rJenrRltQ8HDt53g8fAwReY/5H+BcIR9NHIgeBsOWeF/GJNu6xxtkBzjBlAzJeknAj6FD1yzySY7enN2b9FWnUUpY7Ye2zxV9HiSpIpnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758736; c=relaxed/simple;
	bh=4d0uaBEjVNmvkfM4mJMzvSq0r/7/PBeHYB8VedtD6gs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBUi06XilXga2JHWNkC6VerNLxJ3Sfd0SAbFrI+hHJZEGH6suvtk36T/mEhkJ7pCc3RYg6aOqqkX+VFeRUXCsNJE1y9irk5VLWTAYJfBaTprI42OOp0FyIY9NTcQnLsvvam/QIQfQ3RtojbvTJ7o5TE6uP/tSx9X3UIwBO60Syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=vO+tq9RC; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715758726;
	bh=+i05s0vfQF52KYdcA/nLNxzi8Hql3Pfr3u4ywn3T8Oc=; l=2151;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=vO+tq9RC9w3Y0UI9h0i/kh9u0XGEaO7SKhjvj7tlhcqnnv1y1le4rPMwZ6WZo4j3H
	 Uw5ve3ogg6NL6ohDudPum+BPz/9HSYzEZkS1MTY/tFpVQBg7AAmZVKLMhD7CzSpdZs
	 5hSNPBwi+HbD7yLxWdeXLh2jHR62IZ8Vld4cSfgQI4wBe/6bN5Z9Qk6RsW1OPh5tNv
	 oUw/CGKU8vWqsKYIfoUyJuUSlV6uiABYEk1aL8kK+awHfV3JP7zOcpA0zMYPEAInxf
	 vjSVzTA1Ywyc+tb3WhoeIpdEdbYDbyigjedZowIaGeraTpZ7N+JIAWfoX/SvHbVv2A
	 DbORCGXwiaJkA==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213218:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 15 May 2024 15:38:30 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 15:38:30 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 15 May 2024 15:38:30 +0800
Date: Wed, 15 May 2024 15:38:30 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Conor Dooley <conor@kernel.org>
CC: Mark Brown <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <johnny_lai@richtek.com>,
	<cy_huang@richtek.com>
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240515073830.GA12525@linuxcarl2.richtek.com>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240514-plunging-chair-803d9e342e6f@spud>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, May 14, 2024 at 07:01:21PM +0100, Conor Dooley wrote:
> On Tue, May 14, 2024 at 11:34:29AM +0100, Mark Brown wrote:
> > On Mon, May 13, 2024 at 05:22:54PM +0100, Conor Dooley wrote:
> > > On Fri, May 10, 2024 at 08:06:25PM +0800, Alina Yu wrote:
> > 
> > > > +            richtek,fixed-microvolt = <1200000>;
> > > >              regulator-min-microvolt = <1200000>;
> > > >              regulator-max-microvolt = <1200000>;
> > 
> > > I'm dumb and this example seemed odd to me. Can you explain to me why
> > > it is not sufficient to set min-microvolt == max-microvolt to achieve
> > > the same thing?
> > 
> > This is for a special mode where the voltage being configured is out of
> > the range usually supported by the regulator, requiring a hardware
> > design change to achieve.  The separate property is because otherwise we
> > can't distinguish the case where the mode is in use from the case where
> > the constraints are nonsense, and we need to handle setting a fixed
> > voltage on a configurable regulator differently to there being a
> > hardware fixed voltage on a normally configurable regulator.
> 
> Cool, I think an improved comment message and description would be
> helpful then to describe the desired behaviour that you mention here.
> The commit message in particular isn't great:
> | Since there is no way to check is ldo is adjustable or not.
> | As discussing in v2 series, 'richtek,fixed-microvolt' is added for that.
> | user is supposed to know whether vout of ldo is adjustable.
> 
> It also doesn't seem like this sort of behaviour would be limited to
> Richtek either, should this actually be a common property in
> regulator.yaml w/o the vendor prefix?
> 
> Cheers,
> Conor.


Hi Conor,


Should I update v4 to fix the commit message ?
I will modify it as follows.


There are two types of LDO VOUT: fixed voltage mode and adjustable voltage mode.

As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
the constraints for this scenario are not suitable to represent both modes.

In version 3, a property has been added to specify the fixed voltage.


Thanks,
Alina

