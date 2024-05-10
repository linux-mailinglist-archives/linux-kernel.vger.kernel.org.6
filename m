Return-Path: <linux-kernel+bounces-175768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C120C8C2496
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9CD1F22DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0916E898;
	Fri, 10 May 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Nyb7eTNv"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BB416E87D
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343186; cv=none; b=X6gIOn033NURE9YFIgy6Pe1uB4FimUbfG0gwVg1HZ2+cRQat6kUtrRnDM8RoT91P7L3dlZtsOFer9CsAnBh3roK7Q34aA8jdFap50hoadhUQWD2VTyumsVQda9593w43C3iuWUo2xV19Wf0eMUW9GPztwGYiZ9SoEtDKQhJvHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343186; c=relaxed/simple;
	bh=860vc7EDeMsi2h0cfciZJJggMSckKs+q0Rj4TXZkHWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI8BqxmjAgHVVNyvTclRRcg0tV2p3bvBeAEBvV1zWC2YMLC8pUPCjDM7csYLaLFUXv6lrPKguIbQdVRkLMPfS1z4U4gkh7WygAAgQWACXMlnCwbgLnqFVDS8Uc2vQ3/y6BMosrMQlqSiLKTvzNCk8Lh+MRgyqVr2i47I8xfa+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Nyb7eTNv; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715343182;
	bh=OpDRLzmyyX12mJJWamt32hf+O2uzAL23YMcEm8ju4jw=; l=613;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Nyb7eTNvqMnqFxXuHhH0OSCAZ759IN5tE/R+JYWLaPdiq7QZ4W5rgNdrpbkBwTPzf
	 NCXjBjafjCng5e7bsgKRVFW+HWLehcxLCscCjQLE4NsUB3DF+e/McULSB7kNLpIWrg
	 OjWecU+6mh88TiOmWckiXGRHqRbsPnD0VW6aTc0VI15loEwTmMTNzxTdU22WHnvZ1h
	 pOKqe1/W2pTsEnxVB2N8JLRKXeojCppTy+sp54T4sFgcgrYV+q4V0D3PQYkg5eV4mu
	 njam6yBncJLq6zPVRdcc1txGVIUrCtbTZf/uqAXiEXfsP2CFdoBSigvr5Z5w2FAHC+
	 SCMHyi6armYSw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213203:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:12:54 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:12:54 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:12:54 +0800
Date: Fri, 10 May 2024 20:12:54 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <20240510121254.GA31299@linuxcarl2.richtek.com>
References: <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
 <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
 <20240503073536.GA12846@linuxcarl2.richtek.com>
 <ZjjwFTtiopqsYdeJ@finisterre.sirena.org.uk>
 <20240508065402.GA7462@linuxcarl2.richtek.com>
 <ZjtnvjlJpfNn7qVT@finisterre.sirena.org.uk>
 <20240509091503.GA32333@linuxcarl2.richtek.com>
 <ZjzuY6RZ2ar7ZI_N@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjzuY6RZ2ar7ZI_N@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 09, 2024 at 05:40:19PM +0200, Mark Brown wrote:
> On Thu, May 09, 2024 at 05:15:03PM +0800, Alina Yu wrote:
> 
> > Or may I add the following condition to check the constraints.min_uV and constraints.max_uV match the specified fixed voltage ?
> 
> That seems like a reasonable check, though I think we should just do
> that in the core any time we have a fixed voltage regulator rather than
> doing it in a single driver.

Hi,
Mark

Thank you so much for your review.
I have compiled all of your suggestions and implemented the modifications for the v3 series.



Best regards,
Alina

