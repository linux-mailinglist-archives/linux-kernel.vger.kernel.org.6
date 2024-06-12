Return-Path: <linux-kernel+bounces-211539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E12790535F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F761C23108
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8A17A930;
	Wed, 12 Jun 2024 13:12:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8683178398;
	Wed, 12 Jun 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197924; cv=none; b=EZXmyD4NTA64ZWaThIUOYsTVTF/qQhZMT5ANKhQuEPgEseI2c+HnUkf2OVDfpC6E70zPBY8sTMbc7ifsxsZXoBB0JAsfW78LOPrQ2+FLz0+yVjJn+TScy06cPokIs3TvUJtc6f0xVNX+WYChtZn3X6sTXymAvaAsI6QbIrQk+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197924; c=relaxed/simple;
	bh=05E8YIXcYEKZbFBmH7OWTFPApHry0piYXwzmqZ+ohLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJkh3vVxyJEtLKfIxlfLQKa9scajPKBgPpd9Me/ShAPomF7LMoJndtVdX0CRmyy/TQwZey9QMsbCjyUx8TJ0q9kC2kiJ8DUJ4glKPtf3WgfaOyZ8yg91nAZMRof3CxevWD8q0ZH0g3LC069dFah7E62Faza+9hYGX0XlIrawoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C81971595;
	Wed, 12 Jun 2024 06:12:25 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC0D3F64C;
	Wed, 12 Jun 2024 06:11:59 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:11:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document
 FPGA syscon
Message-ID: <ZmmenchJPyxrbIXi@bogus>
References: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
 <171741897752.2195655.18414699008765504203.b4-ty@arm.com>
 <47ddbc43-889a-4def-8e39-e4f166eae667@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47ddbc43-889a-4def-8e39-e4f166eae667@linaro.org>

On Wed, Jun 12, 2024 at 11:13:32AM +0200, Krzysztof Kozlowski wrote:
> On 03/06/2024 14:51, Sudeep Holla wrote:
> > On Sat, 18 May 2024 22:39:02 +0200, Krzysztof Kozlowski wrote:
> >> Add dedicated bindings for the FPGA syscon registers on ARM Juno board,
> >> to fully document the block and also fix dtbs_check warning:
> >>
> >>   juno.dtb: apbregs@10000: compatible: ['syscon', 'simple-mfd'] is too short
> >
> > Applied to sudeep.holla/linux (for-next/vexpress/updates), thanks!
> >
> > [1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document FPGA syscon
> >       https://git.kernel.org/sudeep.holla/c/3e295d8b4731
> > [2/2] arm64: dts: juno: add dedicated FPGA syscon compatible
> >       https://git.kernel.org/sudeep.holla/c/2e84e7ed7b02
>
> Thanks. It seems your tree is not in the linux-next or this branch is
> not in next, because these patches are not available in next after a
> week. Maybe you need to update the branches being fed to next (including
> pending-fixes etc.).
>

Done now. It is just that I missed to push the updates to my for-linux-next.
I got it ready when I responded to this thread and forgot to push. I didn't
queue anything after that and completely lost track 😄.

--
Regards,
Sudeep

