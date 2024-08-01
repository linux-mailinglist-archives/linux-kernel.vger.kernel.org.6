Return-Path: <linux-kernel+bounces-271792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC78494533E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7EC1C22ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38438148FFC;
	Thu,  1 Aug 2024 19:21:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058214A4C7;
	Thu,  1 Aug 2024 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540110; cv=none; b=uHayynDVyTK7PC1bUcqWoDOgDwl08Kr3Y51Hm/OpF4pPpseD9SLgxjj/aZUzo6JKoMGH7Wg+80IPk7fhZjohGU5wL7w4SiFwgAMwPo+IjuzfeVRw0KhKy3eVi50UwpG6EuIMsyIIjjwuwCgKpqMgKH7pgLS88cKUoVxsIJfHv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540110; c=relaxed/simple;
	bh=mI3N5oRFKT0g2BpjzqJ2P6U5Zf4g29kMf9dJhor1nIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vABt0ccB8hx/Kr0uil3NB5dadXL6bw00H0/6Buk6v/Eb7vAA1WiHyo3iHL4jrl0wXEFCzlZ1IY940GJaYcR6hqEDeDtEiPKK+p75y1iBEL5dcBDZ+YxEjeM9D5VlvwJVZvUpAsGACfIidGXVaNxsqX9TGeC6xQ5jjmBHJJlXXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E6701007;
	Thu,  1 Aug 2024 12:22:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0B703F64C;
	Thu,  1 Aug 2024 12:21:45 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:21:36 +0100
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
Subject: Re: [PATCH v3 6/9] firmware: arm_scmi: Make SMC transport a
 standalone driver
Message-ID: <ZqvgQMXXPa6_aFAR@pluto>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
 <20240730133318.1573765-7-cristian.marussi@arm.com>
 <04d0cf9a-dca8-4952-88fd-f7979a22602f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d0cf9a-dca8-4952-88fd-f7979a22602f@quicinc.com>

On Thu, Aug 01, 2024 at 11:46:03AM -0700, Nikunj Kela wrote:
> 
> On 7/30/2024 6:33 AM, Cristian Marussi wrote:
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
> Tested this series on Qualcomm SA8255p(to be upstreamed) platform that
> uses Qualcomm SMC transport.
> 

Thanks a lot for testing again this series, Nikunj !
Cristian

