Return-Path: <linux-kernel+bounces-190328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142608CFCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458131C215A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9113A40B;
	Mon, 27 May 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="lyUtwL1h"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D2433C8;
	Mon, 27 May 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802322; cv=none; b=aYImyEpBlyyroKvAafTboOPYfCuR7sOOZo4fYfghma7foOznwGPrV6ub38i6xoS1zsrBQoFdOvKJuSqne4SsaQ1e5BooGzE8mhe57EoPYNQSk6fKfYdBnNrpaWUPBqBfUuEa+FHHUTZ6xIMYErzgrLhgN+Kp4hWAIgjY6kgk8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802322; c=relaxed/simple;
	bh=ApRD/JV5DjBsmTo/BHbms3Pr4YCRltiPLcRFnKYLCcc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoJbxiiCpWePOfVMfQguFDf6UFZbukdzAlzKaiEGL/CKFiEg8ReFumSlqRfGzYsDTnj7u5D3zXAtQJTxz7lCL2NitUe2tgywJLDD2f5K8cuXU31QHbfGfhaknitnXpnl7PP5VFG3nrxB3Pket8U8/134D1pzOpWb/KSrv8yDtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=lyUtwL1h; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716802312;
	bh=zg/jzvmgQoPtADo1lTMA8ByShlp6aURw3wEJVEo/JCE=; l=1034;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=lyUtwL1h2ETU7az/7YvnraxroBTWkvIC2EYyLyWNBEuetxARlBF/51unkrYhR8iIe
	 D1EU7Ru5C6smRWzqzf+3M2a5II69Z0qw92MLtSLdtHOAWLBDYBJss+CDmktvCOxgxH
	 mSTMjiB6N+nGTOHHlPmamjh3Oqqd/fxP2AihEI/PjXApRI7Xfhuv17PASM5HajcIPa
	 LiCcUqDEDHZxjX/3Lgfo+8taKd8XDWU+tSK/jeMaDqVy8NqiXRup/bqFaXdkaiMhs4
	 XNoxiC+CCGgppqBdTwI9XFBSZO2X3RcSv+yT7yLRIYYefmdrEqYXxfcmNcvV4aWObs
	 SIwPpOyUpSBOA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213191:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 27 May 2024 17:31:36 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 May
 2024 17:31:36 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 27 May 2024 17:31:36 +0800
Date: Mon, 27 May 2024 17:31:36 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v3 1/6] regulator: rtq2208: Fix invalid memory access
 when devm_of_regulator_put_matches is called
Message-ID: <20240527093136.GA18009@linuxcarl2.richtek.com>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <636cbe817ad61a18f291b5ec8938e79043b8a646.1715340537.git.alina_yu@richtek.com>
 <f86923b8-a8ab-480f-901a-f29b0dbb0df5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f86923b8-a8ab-480f-901a-f29b0dbb0df5@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 15, 2024 at 04:47:37PM +0100, Mark Brown wrote:
> On Fri, May 10, 2024 at 08:06:20PM +0800, Alina Yu wrote:
> > In this patch, a software bug has been fixed.
> > rtq2208_ldo_match is no longer a local variable.
> > It prevents invalid memory access when devm_of_regulator_put_matches
> >  is called.
> 
> This doesn't apply against current code, please check and resend (on
> Linus' tree rather than mine at this point given the merge window).

Hi,
Mark

I apologize for the interruption.

I've resubmitted the new series for review at the following link: 
https://lore.kernel.org/all/7c28d2e61d2fc13066ba4814d1ecfab8f344aaad.1715846612.git.alina_yu@richtek.com/

This series is based on the previous submission found at:
https://lore.kernel.org/all/5d56b79c94de63fc86b5a70b7e374da4240fee8b.1714467553.git.alina_yu@richtek.com/

I would greatly appreciate it if you could let me know if this will be merged in the future branch,
or if there are any mistakes that I need to address.


Thanks,
Alina


