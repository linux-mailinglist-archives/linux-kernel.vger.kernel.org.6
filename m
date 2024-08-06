Return-Path: <linux-kernel+bounces-276223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2E4949072
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B6B284AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4731D0DE5;
	Tue,  6 Aug 2024 13:12:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3351D0DD6;
	Tue,  6 Aug 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949966; cv=none; b=GzyoY10Pa2tNT8TCQOaL/e9tLpe5jlzIp8jRY+Hk4jWtxOy6PuO1OywDyHFXrgysW5EdLWQGdyA8IYdcyj8JfeBt/g7szqCVaFLcMzDI/0Ujf5TBi19x8VUBM9DjGQVIoQzyG7psWdvh8uyoHACO70SE5vsaaBD3av/sfGbhHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949966; c=relaxed/simple;
	bh=WCzxqJsVEg9rtGjl6YkaHfTIDToLTT4FYExvDzsVxzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaKImT+YnYl7fuJSdPrl5B9tGeFFy0vRVP1oVTZXoJ196KFq84vLZi1VcDE4Cw2KLfA/kg7Ml+m2TNhewmHgT1xNYo5p+QtyEj463TkB0jrQc0yUOQrP3X7q8r3iupvIJyd/VnBH9wIgbQXhJOp9LB3g2P5DHD11uH1AxM6zEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21091FEC;
	Tue,  6 Aug 2024 06:13:10 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2BC23F766;
	Tue,  6 Aug 2024 06:12:41 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:12:39 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, quic_nkela@quicinc.com, ptosi@google.com,
	dan.carpenter@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 5/9] firmware: arm_scmi: Make MBOX transport a
 standalone driver
Message-ID: <ZrIhR-bpbkwdK3Mx@bogus>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
 <20240730133318.1573765-6-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730133318.1573765-6-cristian.marussi@arm.com>

On Tue, Jul 30, 2024 at 02:33:14PM +0100, Cristian Marussi wrote:
> Make SCMI mailbox transport a standalne driver that can be optionally
> loaded as a module.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v2 --> v3
> - fixed spacing in Kconfig
> - updated Copyright
> - use new params in DEFINE_SCMI_TRANSPORT_DRIVER
> ---
>  drivers/firmware/arm_scmi/Kconfig             |  4 +-
>  drivers/firmware/arm_scmi/Makefile            |  3 +-
>  drivers/firmware/arm_scmi/common.h            |  3 --
>  drivers/firmware/arm_scmi/driver.c            |  3 --
>  .../{mailbox.c => scmi_transport_mailbox.c}   | 47 +++++++++++++------
>  5 files changed, 38 insertions(+), 22 deletions(-)
>  rename drivers/firmware/arm_scmi/{mailbox.c => scmi_transport_mailbox.c} (87%)

I am happy with the changes in the series, they all look good. I wonder if
it makes sense to move transport drivers into a separate folder
drivers/firmware/arm_scmi/transport/{mailbox,smc,optee,virtio}.c

In scmi_transport_*.c, I see scmi is redundant and transport can be eliminated
by moving all under the folder with that name. Thoughts ?

--
Regards,
Sudeep

