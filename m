Return-Path: <linux-kernel+bounces-248947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E66192E43E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0135B23878
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0FC1586CF;
	Thu, 11 Jul 2024 10:09:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894801474D3;
	Thu, 11 Jul 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692576; cv=none; b=B/p4aPrsHhWL552em7HM3wTqT2TcE6Q5saVhDfv8RjvQwkE5Ls59xosKiKoDI2UqMYC0qhc47DxieovEiGcucsedsQFmGLVmozCRCUoSbWsyTJRp7q9zhCLynPay6UJErwHkOXGwMwhd0fYqA7SuG3YrGlQ3vq7J3gi4SGTL1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692576; c=relaxed/simple;
	bh=gmfKIjMLjCkezg/bgKSOY27pDO0jWLXHmiAidpZn2ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFZp9FZmA6hfXgogCVzq4HbrOHWdy5S4/hWyN1fwas1hz02yUPf3kkZMbbXptDaqY5Ih+rNk+V5pXhIjGEvJnqE55Rvy95QBxsmOcmg2OFsy5XO4U/nhH/VgdtKr+VZx2fYQfIxGR5pPo6DcjLBjKZvn9ZEDbiEyfbi5fRX6P8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6D01007;
	Thu, 11 Jul 2024 03:09:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D15E3F766;
	Thu, 11 Jul 2024 03:09:31 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:09:23 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 5/8] firmware: arm_scmi: Make SMC transport a
 standalone driver
Message-ID: <Zo-vUwMFbnzh8DVr@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-6-cristian.marussi@arm.com>
 <71651677-3aee-4c14-9ca2-14fd575cdca2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71651677-3aee-4c14-9ca2-14fd575cdca2@quicinc.com>

On Wed, Jul 10, 2024 at 02:04:16PM -0700, Nikunj Kela wrote:
> 
> On 7/10/2024 10:31 AM, Cristian Marussi wrote:
> > Make SCMI SMC transport a standalone driver that can be optionally
> > loaded as a module.
> >
> > CC: Peng Fan <peng.fan@nxp.com>
> > CC: Nikunj Kela <quic_nkela@quicinc.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> 
> Tested-by: Nikunj Kela <quic_nkela@quicinc.com>
> 
> Tested this series on SA8775p Qualcomm platform that uses Qualcomm SMC
> transport.
> 

Thanks Nikunj !
Cristian

