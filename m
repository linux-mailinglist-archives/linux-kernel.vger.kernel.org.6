Return-Path: <linux-kernel+bounces-248941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B892E424
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6751D288533
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BC158A27;
	Thu, 11 Jul 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk7HvNY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B47157A61;
	Thu, 11 Jul 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692247; cv=none; b=dVRuoqa/6zcJbMAec2rSxdGba83iZ7zd3HB+tNpTvc7709ku8Nuj/7cBLYRjXTw2cSIxuwYdFJXD2q03aUCTGLarbwftockpVlW4DrSFsVEaFc64oK9ffSri/lc//stHRpfQzESiz6DtetzbmvzZEvSz5Y0HEqXlT5BgYlE24Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692247; c=relaxed/simple;
	bh=T2hZAkVdwKJbOWQnDYuPe62AFV+qUr4L58kAwGO8POY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnAbyCFR3mdPd49VlxP2RJAx8je/C+YAIrtwuF71HyRRds+4gBYHxR7tJ3N8XvCG0BJ/yeDFcT5osV08g73VS0NfgY1JeY6NxoFtg/H6+e3dFrAvl+OmBlUsJ+3aEaE6HFt58YBk4a5ihaSjiZaFEPHcUbDfj4S11I0SqEmhCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk7HvNY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E120C116B1;
	Thu, 11 Jul 2024 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720692247;
	bh=T2hZAkVdwKJbOWQnDYuPe62AFV+qUr4L58kAwGO8POY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qk7HvNY5gjdeGcY4B5UFzLa8h4RjoLwU7iwK2sM19nAQTCegEc824z5Q4xCY6IzSX
	 PNpK2fGaSgcKBTJe4q5vULQpw2sWYEk1QDrpBB/4W2hLvGQNI9zeqYyDQ+6CvKfmnE
	 JGiPms8jcTE05fdiUPvzn1PZL8syD7CLGgDOtsOTdvvIX8hcFRCGVVtpLfmJ67aHuR
	 w/vziUaSUC1NOcUrYvmQyoHl+mqTf5Qs4s7/6yzgBaDaaVjUSDWHsQi2RspMFZdPpk
	 QfKsHaGa4L1WHGDcsPk5UhELzd1gLnzrgPkMdenIH+Iok19GOgGYhW4QqTFZd3QWAB
	 gSP+xzalWpaRA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sRqei-000000008TY-1WtQ;
	Thu, 11 Jul 2024 12:04:04 +0200
Date: Thu, 11 Jul 2024 12:04:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: enable GICv3 ITS for PCIe
Message-ID: <Zo-uFGK7Ge_9-DJb@hovoldconsulting.com>
References: <20240711090250.20827-1-johan+linaro@kernel.org>
 <f7e74a6f-0548-4caa-a8fc-8180c619c9aa@linaro.org>
 <Zo-ssBBDbHRLtAwG@hovoldconsulting.com>
 <bf41aa8b-6a49-4610-8a8e-c2dab8ef4334@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf41aa8b-6a49-4610-8a8e-c2dab8ef4334@linaro.org>

On Thu, Jul 11, 2024 at 12:00:50PM +0200, Konrad Dybcio wrote:
> On 11.07.2024 11:58 AM, Johan Hovold wrote:

> > What branch are you using? Abel reported seeing this with his branch
> > which has a few work-in-progress patches that try to enable 4-lane PCIe.
> > 
> > There are no errors with my wip branch based on rc7, and I have the same
> > drive as Abel.
> 
> linux-next/master

Hmm. Ok. We may need to disable L0s as I did for sc8280xp as well, but
that was not the cause for Abel's errors.

> > Also note that the errors happen also without this patch applied, they
> > are just being reported now.
> 
> Ouch.. wonder how much that drives the perf down

Could you post the output of lspci -vv for the NVMe controller?

Johan

