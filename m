Return-Path: <linux-kernel+bounces-185964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A08B8CBD73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C071F22801
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4480023;
	Wed, 22 May 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="nt7j1rC+"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8918EB1;
	Wed, 22 May 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368610; cv=none; b=bzi4l17bOkqgTtKCIG2g5hM6Ueh/Ow1zI8VXD1kVTTN/1Ryhz/6/7L4L7IJ64b2W+TN4PhVI3IF3/kwox9JeNo8yv5JpBTTV4klcpqSlEhrQBxoNnmetYdDwoVD22aUxWH2d85IKpMkSo5s9xRXUCd0JlNcsI+ZzBq8QOt76AnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368610; c=relaxed/simple;
	bh=+ThGKGBlufLwjddH7F1fYBE9I6h37rlkJDDJGwx2tAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyJ2kgOatzXGgtA9kW7tF+FuJhNCTqAOC2kLAlQ9zjEKlSyp9kFUW8wQZihsMzLdNPCSihi6/G7ZoET+BXkjZy2SMv7LYuBrIq+U+UIIZz5Cv7KBwBSU8eM/xt2lbazGpoU3NQn+GxS8C8cKTbnCE/6uaxQH7M+KQ3XUf0S5+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=nt7j1rC+; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716368599;
	bh=tgnLczqIZPIw1RRjYhcOby3l9JBMPnlryBl/aTxvZL8=; l=905;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=nt7j1rC+WnReYr5AJLO2DGopygHPzW6qPJwCWSyagMWGuWDxm85XT+r1Y/qix4MHO
	 W9lVVueygKx8DJN4h3dhJWPTwlo1DFWIRLSCjg1krFxclu7bOjPhFJkBsoif/oLgIW
	 tM56S0gyf7pZmzVqRcOpdu5STVPuv6YxwLBs/DzwB+fQ0Hzi6ZEDpRZA7yXoMm7jbw
	 HasprX3/slmRX/lfjTLWAx22O8o326liSJQ+Vi3yejvLgREQcXVJsg/Zh1mr5CX88E
	 38+0NYzPbViDpoyuJd4D/7fHL1ISKuRqXTv02q6jInEbkeKKaHYLhJiyhaPAtvGvsg
	 JgSOLdpbF/XiQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213195:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 22 May 2024 17:03:03 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 17:03:02 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 22 May 2024 17:03:02 +0800
Date: Wed, 22 May 2024 17:03:02 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<cy_huang@richtek.com>
Subject: Re: [PATCH 2/2] regulator: dt-bindings: rtq2208: Add specified fixed
 LDO VOUT property
Message-ID: <20240522090302.GA19548@linuxcarl2.richtek.com>
References: <cover.1715846612.git.alina_yu@richtek.com>
 <9c1bbe4b38a4ee5650d888478f1ce2cec2733669.1715846612.git.alina_yu@richtek.com>
 <5d26b19c-7679-4dba-a9ba-a7368d39b474@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5d26b19c-7679-4dba-a9ba-a7368d39b474@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 16, 2024 at 02:34:02PM +0200, Krzysztof Kozlowski wrote:
> On 16/05/2024 11:20, Alina Yu wrote:
> > As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
> > the constraints for this scenario are not suitable to represent both modes.
> > Therefore, A property is added to specify the fixed LDO VOUT.
> > 
> > Examples of fixed LDO VOUT and adjustable LDO VOUT is also added to this version.
> > 
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > ---
> 
> This is a v1 but I am pretty sure I saw it somewhere and there was
> already some sort of discussion. Confused... :(
> 
> Best regards,
> Krzysztof
> 

The discussion regarding this matter took place during v2 and v3.
Due to the fixed LDO VOUT being outside the range of the adjustable one,
a special-use property has been added to avoid overusing the constraints.


Thanks,
Alina

