Return-Path: <linux-kernel+bounces-371819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D69A40CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDDC1F24418
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D171DFD9B;
	Fri, 18 Oct 2024 14:11:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74224A08;
	Fri, 18 Oct 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260709; cv=none; b=UtDQ8HJExo+6EDRoC8SwvXqqLSsnH4z/4IsZVDJmzIonOt0odIojBSfh55LAYkmoBtW4qlJezUuxelhMOzzN6h9Y/Uc/ZKoB2TJKHaFsFj9CcraEH1P6dVNW8a5QXyCGQUN1zTsxw5MYv4xT8oVBT7zult+y6tL7rBbrW/Mmoms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260709; c=relaxed/simple;
	bh=k1WG95/4HYH0Hx+TL/rTRQtVBegdXuBQLKzL30NpeUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6vMEalHLuY7Hyn1NkcNpprxp/9w2vFqRhDApJbsbysGeov35U60CV5mgMBXimZPxJVJKpmJfwXv0KYo3iC7NR5it1z3bMmH0G3o8ye6eDGfDXX+iykI8c6DK7+PuY5bGJvXdKdAnRManMSOrFKQ+j7Y8euEahwLnzB8xKfM3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF621497;
	Fri, 18 Oct 2024 07:12:16 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B383F58B;
	Fri, 18 Oct 2024 07:11:44 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:11:42 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, dan.carpenter@linaro.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: firmware: arm,scmi: Introduce more
 transport properties
Message-ID: <ZxJsnswE6bg6PsPu@pluto>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
 <20241018080602.3952869-4-cristian.marussi@arm.com>
 <20241018133725.GA77066-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018133725.GA77066-robh@kernel.org>

On Fri, Oct 18, 2024 at 08:37:25AM -0500, Rob Herring wrote:
> On Fri, Oct 18, 2024 at 09:06:00AM +0100, Cristian Marussi wrote:
> > Depending on specific hardware and firmware design choices, it may be
> > possible for different platforms to end up having different requirements
> > regarding the same transport characteristics.
> > 
> > Introduce max-msg-size and max-msg properties to describe such platform
> > specific transport constraints, since they cannot be discovered otherwise.
> > 
> > Cc: devicetree@vger.kernel.org
> > Cc: Rob Herring (Arm) <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Also, you missed Conor and that not the right address for Krzysztof. Use 
> get_maintainers.pl or a tool that uses it (b4).
> 
> Also, no need to store maintainer addresses in the commit msg.

Ok, my bad I ahev not checked with the tool this time but just grabbed
from a recent commit log. I will fix in V2

Thanks,
Cristian

