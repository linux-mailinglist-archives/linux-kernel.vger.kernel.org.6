Return-Path: <linux-kernel+bounces-172776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD08BF6A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B203B20B71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4F22301;
	Wed,  8 May 2024 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="JmgCuc5S"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909B1A2C15
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715151254; cv=none; b=q8WDzePiEjhd0+9n+ziz/1X3mYi0VZIR/lBFEf+90vGnykGqEHyWMp43o52wa3Duyvl7EvktGlmOgcXXV7EFk9Rj6tMnYdESQ+Jzd9OZeqwpfH3H/XyLSkU3+7JZ13BXmpwTa6GbHlXNism4R5y7NKPEIsJKsWxxCOmgol/Nmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715151254; c=relaxed/simple;
	bh=xIoMqmffSxPfV5FjgBtnb8T5GD3hvIO/IaP81W2cQv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC1JvSQ2XlwLr9tQFq3Jbs0qBBhdd7uUpUSvDAj51G22XDj3rLtyDucvzsrmsjOJy2EzWAGo9WJoeniyEqGZk4DIynwYAHCJbgV9mhFvXU7hgdd5gJkskKw9KIStkbiXnsfzwK2SW/AzkMt85NEQTGzUvSLu+BR0HkB1TVvJ0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=JmgCuc5S; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715151249;
	bh=1918jXL9WmtXTEmb78kSJ5QpPXxlughiocyx6brgFtk=; l=1360;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=JmgCuc5SAvkMpGEleZPhV8hOBuIXm3vqeZzrV+YXOpO7RDW0NjIBPjKknt8/YDrkz
	 DEdPPAU9UEJrR0QH5EKNoxt4RVmM/PtdM5RWTAcENxp+/8j1LOYLJ7sRNhEm1tTo5D
	 bx98dHed0zeNEgepLp85kIWkcVhbQxRi9GfuWUic1MGGg5uY6j39NoX9+t9Bw5kPlD
	 yNPRaSlyd+TFZ3sw68GhYiHUnp9RJx7cggCgyqDrQn5Zcc4/Fl3Wt4h+jl/7B+kPW9
	 0BVJFKYm7/AojiuFA/iZthTkOHZaQqPPCq2hy1FcnUQWlNBJnxqZywOgcbpfk3YfRX
	 IpLSUIPkqr8CA==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3885208:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 08 May 2024 14:54:03 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:54:02 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 14:54:02 +0800
Date: Wed, 8 May 2024 14:54:02 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <20240508065402.GA7462@linuxcarl2.richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
 <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
 <20240503073536.GA12846@linuxcarl2.richtek.com>
 <ZjjwFTtiopqsYdeJ@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjjwFTtiopqsYdeJ@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, May 06, 2024 at 11:58:29PM +0900, Mark Brown wrote:
> On Fri, May 03, 2024 at 03:35:36PM +0800, Alina Yu wrote:
> > On Fri, May 03, 2024 at 10:41:04AM +0900, Mark Brown wrote:
> 
> > > That's a substantail reconfiguration of the regulator, it would be
> > > better to have an explicit property for these non-standard fixed
> > > voltages rather than trying to do this using constraints, or at the very
> > > least have validation that the values being set are supported by the
> > > hardware.  The code should also be very clear about what is going on.
> 
> > May I add the 'richtek,use-fix-dvs' property back ?
> 
> It sounds like it might be better to add a property specifying the
> specific fixed voltage rather than overloading the constraints for this
> purpose.

May I modify the code into this ?
I'll add 'richtek,fixed-microvolt' property in dtsi; remove 'regulator-min-microvolt' and 'regulator-max-microvolt'
to prevent fail caused by constraints->apply_uV.

+       u32 fixed_uV;
        int ret, i;

-               if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
+               if (!of_property_read_u32(match->of_node, "richtek,fixed-microvolt", &fixed_uV)) {
			desc->n_voltages = 1;
-                       desc->fixed_uV = init_data->constraints.min_uV;
+                       desc->fixed_uV = fixed_uV;
			desc->ops = &rtq2208_regulator_ldo_fix_ops;
..

Thanks,
Alina


