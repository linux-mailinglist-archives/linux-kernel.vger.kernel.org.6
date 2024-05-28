Return-Path: <linux-kernel+bounces-191796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3F8D142E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FBE1C217D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC94F5FD;
	Tue, 28 May 2024 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="LA4JevOo"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4263DF6B;
	Tue, 28 May 2024 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876464; cv=none; b=g9BfAIAcd+BTmI52es6fWoZmeykLHFGgvNAF0VkJTMYiMQO6OvNXvKc2dXQopuDxUbyy++NOvt78M4FUASO0UVgy176ehNfrAWOLS1FBGyWZWVOKWM82JmdWLJS0gzfxe0Tclri5pe3f/A16B7/VGqTDp9VZBPLOJljwucFY0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876464; c=relaxed/simple;
	bh=YgEFGeEPZxT8s1YqnsK/q7F3fNmn1mUVIATqD2QD4Zs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMnfJDD4eTFsEIybg5aCEGLszhi8TnHZJ/bTsZ/aY3OSGj4qmCqXN7olGolNdK/Z+8J9nOPP7avzYIsDMSahwF8fL9omXlelIEZ4H383M6shyiRpgvICF4nzIRnk4tjVCxoFas6j8QbxCcXVKkeE+EfUIE+Pr0CH6+q1Hc5Pcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=LA4JevOo; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716876460;
	bh=bmYKOtO6JYSDgXLf6T9Jhwa1FRSIr29gYNytPNeRSvk=; l=777;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=LA4JevOoc6pR1oBoS21xHhXky4ADt13fvE623gJ+o8plPn/QxxysbYe1ztfras7ry
	 i5VroJ2cr9J7AVYKIB7H8YXkxaF+POr8ex9omf3tpbhNsDQ0lE6VqRx0bVEWw0ZY09
	 rnR+c4xDd99UHeTPQYSAebvSdGogzu2p6a6dOcPGUq7ZTVN+DDJSy2/wv89ZZdqg6o
	 WKp2yjYqyTasa5aRjbOj/mJsJGL3sVFTK7xxIfPPglWn8+URk/LYOR+YBxNxqDWCWr
	 AUO4V3NhGzQv+xEaBR7Tu185jLHQnawkpimf6Rz28Xmr9N099C0EO0ahxUODfJyxdY
	 nROc5fB0iwC0Q==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213223:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 28 May 2024 14:07:32 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 14:07:31 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 14:07:31 +0800
Date: Tue, 28 May 2024 14:07:31 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<cy_huang@richtek.com>
Subject: Re: [PATCH 1/2] regulator: rtq2208: Add fixed LDO VOUT property and
 check that matches the constraints
Message-ID: <20240528060731.GA25526@linuxcarl2.richtek.com>
References: <cover.1715846612.git.alina_yu@richtek.com>
 <7c28d2e61d2fc13066ba4814d1ecfab8f344aaad.1715846612.git.alina_yu@richtek.com>
 <c0c7a63d-e435-4778-ad4c-3d93f0215116@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0c7a63d-e435-4778-ad4c-3d93f0215116@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, May 27, 2024 at 02:00:47PM +0100, Mark Brown wrote:
> On Thu, May 16, 2024 at 05:20:33PM +0800, Alina Yu wrote:
> > A fixed LDO VOUT property has been added to specify the fixed_uV of the regulator_desc.
> > Additionally, a check has been included in this version
> > to ensure that the fixed_uV matches the constraints.
> 
> This doesn't apply against current code, please check and resend.

Sorry, I didn't notice these links missed in linux-next tree:

https://lore.kernel.org/all/a1e19b4026d7fea27526ba94c398500a3826b282.1714467553.git.alina_yu@richtek.com/

https://lore.kernel.org/all/ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com/

I have now integrated these missing parts into the resent patches.

Thanks,
Alina

