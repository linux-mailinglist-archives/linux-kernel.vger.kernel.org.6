Return-Path: <linux-kernel+bounces-174337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E514E8C0D56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141B81C2119A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E6714A605;
	Thu,  9 May 2024 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="SOByTSSB"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6D1474A1
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246128; cv=none; b=BwN4vEVkuVi1y3ZSFzJ+9IcaPMNnS6oms1EZdvsqB4JAIOLhfs2CteVqopgVczNDjlx/zegALTbK/FDJVig/9KwFjKDvMe+S3fYzlDU2/BifoqThUdNZdsS4THjhOCB5r2YyW9Bamv40FDq+YOND1znCjogekDp533Ifg3Bi6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246128; c=relaxed/simple;
	bh=P173fWMVNHTR1ZQpRlogFXq6/3I7t2uQTLPwTK+qyTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR9cEmyNe76d4n/WD0L77FthN83MPoSv2ebxh9BWJ/vUgEPvi7mIwgA4SSQ8x1O5QnYLEwF7uYywpc13prgmAQx5OPpiidPWDStiQM17V54cRtxtcDbfep3oxDqjGrR7iaK+2ddgfU4cj/17eS61tfh/RKMApL2Xc1bwx12x1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=SOByTSSB; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715246118;
	bh=uCosmU2s3pdhSW4GMXoslxKx+KxLesjNk36SXmel0xs=; l=1204;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=SOByTSSBxi4kpdDIyz27PxS02QHCcgwpBFTi98o8JIfw5pVHUPPyaTykH4cE6+Hsh
	 BwhBzvzlbzeh4C8/qfVYlduQCW43UxgqLz1LjTv0t6Z6E4Z26uw7SIiih+Cz8uCXyY
	 ugTKlD7RXARnvl8Vt7FrJJ6W2fA3SFE1lg53iNHj6Ptp3h5USjeVlTJlr3vQYxu+lo
	 RNccTSQTwbulleBGBDaV8NlyBEK6dnBGfIgmNtReoFj1cGxvTwANo0a3KbcFa23VxL
	 0gGJmcxweYcu4bO/KDuiC+g32k1vIW56cnJZcypAMtgkqGsP9IGfXwiWxN82hOJ+6e
	 kJBSs2MdZ/g/w==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3885223:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 09 May 2024 17:15:04 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 17:15:03 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 May 2024 17:15:03 +0800
Date: Thu, 9 May 2024 17:15:03 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <20240509091503.GA32333@linuxcarl2.richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
 <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
 <20240503073536.GA12846@linuxcarl2.richtek.com>
 <ZjjwFTtiopqsYdeJ@finisterre.sirena.org.uk>
 <20240508065402.GA7462@linuxcarl2.richtek.com>
 <ZjtnvjlJpfNn7qVT@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjtnvjlJpfNn7qVT@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 08, 2024 at 08:53:34PM +0900, Mark Brown wrote:
> On Wed, May 08, 2024 at 02:54:02PM +0800, Alina Yu wrote:
> 
> > May I modify the code into this ?
> > I'll add 'richtek,fixed-microvolt' property in dtsi; remove 'regulator-min-microvolt' and 'regulator-max-microvolt'
> > to prevent fail caused by constraints->apply_uV.
> 
> Adding the new property seems fine.  You still need to permit the
> min/max microvolt properties for the case where the regulator is in
> normal mode and can vary, you could write rules that ensure that the
> constraints line up in the case where a fixed voltage is specified but
> I'm not sure it's worth the effort.

Or may I add the following condition to check the constraints.min_uV and constraints.max_uV match the specified fixed voltage ?


+       u32 fixed_uV;
        int ret, i;

..

+               /* specify working fixed voltage if the propery exists */
+               ret = of_property_read_u32(match->of_node, "richtek,fixed-microvolt", &fixed_uV);
+
+               if (!ret) {
+                       if (fixed_uV != init_data->constraints.min_uV ||
+                               fixed_uV != init_data->constraints.max_uV)
+                               return -EINVAL;
+
			desc->n_voltages = 1;
+                       desc->fixed_uV = fixed_uV;

..

Thanks,
Alina

