Return-Path: <linux-kernel+bounces-186003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED08CBE71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68ADE1C213E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDC81724;
	Wed, 22 May 2024 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="NocNKk8x"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED619470;
	Wed, 22 May 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371150; cv=none; b=Nuk7lDFyr5XIyHET4R4W8JmHrrsqRefur1IfxnMG2e5C9o2OADGjgiIAi8wP1FGJ3P6lARl/ao89NWCN51ZkVMWZmDChrStPdkMNVJs3VxxNX+DKwL9TKvWJ4l37rGBQ/a1tM84ZLIBZTNlXQ4VX0qwExzkQU/lfZAnX7LYtZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371150; c=relaxed/simple;
	bh=aYA6/GwGXTOxStDL3CrE3iLD+7zCga5XYorfKEhclCI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5YfXV3wUu/69HNhuWbXNrZp+y7heIF7ZjfUU0KPzKFW5u+U+OwsugNDmVeD7VgnajlelbmUm3edhl5MgbFONkrdE/K/ETWRBpqBNXp9XL48ZZH4ayZfRv+mPKZIpqJ70U1evsqI0csjiwWAPqTTMkQ9Lo/ZwUdPwNpD9Mh8Le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=NocNKk8x; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716371145;
	bh=D2gJWDdN6XlnceVs7J1C8EIKdWpmV/r/rS+czmPgl78=; l=1495;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=NocNKk8xJLzZbvUnG1yUx4fQ9Kz4q9lSPOtyStXaoBFzWM3w7qjme0/cHXj3T/fvK
	 /TaMsVoW4Bg+tcUab1zD+MGiVv6qY3jFYVYh0QmgxT2sJWWbIXaFX9wIcYLglz0GB5
	 4oh1h+ZJnBJpkPcM+Ck3dnWg07a+YaTujRfMoXZdwTaijqG7Carg+UoLodJn/+94Oy
	 nfDlqehZjRO2cRTvwl3WB1/z7irvhEA9cMufzo9ld99OYYpnDUDZ16+zJRbTFmdjKh
	 FD1zIbp0q5H5QO7A/pvjcAGDgghxY0D7tiZygJ/9XEpNX+eL+4FwPJynyNWKyWAyCR
	 FqEKmqLFRSWdQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213212:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 22 May 2024 17:45:25 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 17:45:24 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 22 May 2024 17:45:24 +0800
Date: Wed, 22 May 2024 17:45:24 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<cy_huang@richtek.com>
Subject: Re: [PATCH 2/2] regulator: dt-bindings: rtq2208: Add specified fixed
 LDO VOUT property
Message-ID: <20240522094524.GA21859@linuxcarl2.richtek.com>
References: <cover.1715846612.git.alina_yu@richtek.com>
 <9c1bbe4b38a4ee5650d888478f1ce2cec2733669.1715846612.git.alina_yu@richtek.com>
 <5d26b19c-7679-4dba-a9ba-a7368d39b474@linaro.org>
 <20240522090302.GA19548@linuxcarl2.richtek.com>
 <b094ce68-9ce2-411d-99f2-1f143e4c3347@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b094ce68-9ce2-411d-99f2-1f143e4c3347@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 22, 2024 at 11:27:06AM +0200, Krzysztof Kozlowski wrote:
> On 22/05/2024 11:03, Alina Yu wrote:
> > On Thu, May 16, 2024 at 02:34:02PM +0200, Krzysztof Kozlowski wrote:
> >> On 16/05/2024 11:20, Alina Yu wrote:
> >>> As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
> >>> the constraints for this scenario are not suitable to represent both modes.
> >>> Therefore, A property is added to specify the fixed LDO VOUT.
> >>>
> >>> Examples of fixed LDO VOUT and adjustable LDO VOUT is also added to this version.
> >>>
> >>> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> >>> ---
> >>
> >> This is a v1 but I am pretty sure I saw it somewhere and there was
> >> already some sort of discussion. Confused... :(
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > The discussion regarding this matter took place during v2 and v3.
> 
> So in the future?

Based on the previous discussion, it is scheduled to be included in the linux-next tree.
Will we start a further discussions on this topic?

> 
> > Due to the fixed LDO VOUT being outside the range of the adjustable one,
> > a special-use property has been added to avoid overusing the constraints.
> 
> Hm, why exactly this is not a bool property? What are the benefits?
> 
> Best regards,
> Krzysztof
>

As only the user will know the exact fixed voltage,
the property is defined as a u32 to allow user customization and decision-making.


Thanks,
Alina

