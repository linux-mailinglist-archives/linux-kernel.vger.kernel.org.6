Return-Path: <linux-kernel+bounces-276619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE13194962B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A9FB29F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E15762EF;
	Tue,  6 Aug 2024 17:01:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD5373477;
	Tue,  6 Aug 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963704; cv=none; b=Tq3yWTs5nBm4Bn2JvZSooGz4nAqsFwM1PZflvsclnRiWQeDemMe9hv9OM+7gI3mYA/piATClxKb5G4Pf1Y9AbOiwfUZQ8nXoAaToreTtv7YizgGg9yGTf1yfj6JvNvBBxuZW7vvoBXHfZLJ7XDp/InZHAF7kZbCaQ2Lmwmbdn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963704; c=relaxed/simple;
	bh=5RWDjTmwNTgpup4d/mqJrgRvr2zTsNEdi9R2l0PPZ68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhJxiTy0YuOez1na2VVPBKI6EvLU+oJOiCn1sk9hBAFfHxm9QcvpcmjY8ha9+GKGZqnOsLmKKfPs1EFELi8DKZ/NstG1oAMkLbu45rRzEotzhhcRJ4TmnbKsIup8LP+cmbhippmqhBDagSR8Jksm2SJlBSs0Jzrx411hEp4dB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8ACFEC;
	Tue,  6 Aug 2024 10:02:06 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26243F766;
	Tue,  6 Aug 2024 10:01:38 -0700 (PDT)
Date: Tue, 6 Aug 2024 18:01:26 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, quic_nkela@quicinc.com, ptosi@google.com,
	dan.carpenter@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 0/9] Make SCMI transport as standalone drivers
Message-ID: <ZrJW2jFpNqJDXMTh@pluto>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
 <6c2b185e-42d4-408b-a7f5-972b2099067b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c2b185e-42d4-408b-a7f5-972b2099067b@gmail.com>

On Tue, Aug 06, 2024 at 09:47:17AM -0700, Florian Fainelli wrote:
> On 7/30/24 06:33, Cristian Marussi wrote:
> > Hi all,
> > 
> > Till now the SCMI transport layer was being built embedded into in the core
> > SCMI stack.
> > 
> > Some of these transports, despite being currently part of the main SCMI
> > module, are indeed also registered with different subsystems like optee or
> > virtio, and actively probed also by those: this led to a few awkward and
> > convoluted tricks to properly handle such interactions at boot time in the
> > SCMI stack.
> > 
> > Moreover some partner expressed the desire to be able to fully modularize
> > the transports components.
> > 
> > This series aim to make all such transports as standalone drivers that can
> > be optionally loaded as modules.
> > 
> > In order to do this, at first some new mechanism is introduced to support
> > this new capability while maintaining, in parallel, the old legacy embedded
> > transports; then each transport, one by one, is transitioned to be a
> > standalone driver and finally the old legacy support for embedded transport
> > is removed.
> > 
> > Patch [1/9] is a fix around the chan_free method for OPTEE transport; it is
> > really unrelated to this series, but included to avoid conflicts.
> > 
> > Patch [2/9] is a mostly unrelated (but much needed) clean-up from Peng,
> > which I included in this series to avoid conflicts at merge.
> > 
> > Patch [3/9] simply collects the existing datagram manipulation helpers in a
> > pair of function pointers structures, in preparation for later reworks.
> > 
> > Patch [4/9] adds the bulk of the new logic to the core SCMI stack and then
> > each existing transport is transitioned to be a standalone driver in
> > patches 5,6,7,8 while shuffling around the compatibles. (no DT change is
> > needed of curse for backward compatibility)
> > While doing this I kept the module authorship in line with the main
> > author(S) as spitted out by git-blame.
> > 
> > Finally patch [9/9] removes all the legacy dead code from the core SCMI
> > stack.
> > 
> > No new symbol EXPORT has been added.
> > 
> > The new transport drivers have been tested, as built-in and LKM, as
> > follows:
> > 
> > - mailbox on JUNO
> > - virtio on emulation
> > - optee on QEMU/optee using Linaro setup
> > 
> > Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
> > testing commands, replies, delayed responses and notification.
> > 
> > Multiple virtual SCMI instances support has been tested too.
> > 
> > SMC has NOT been tested/exercised at run-time, only compile-tested.
> > (due to lack of hardware)
> > 
> > Note that in this new setup, all the probe deferral and retries between the
> > SCMI core stack and the transports has been removed, since no more needed.
> > 
> > Moreover the new drivers have been tested also with a fully modularized
> > SCMI stack, i.e.:
> > 
> >    scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor modules ]
> > 
> > Based on v6.11-rc1
> > 
> > Any feedback, and especially testing (:D) is welcome.
> 
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks !
Cristian

