Return-Path: <linux-kernel+bounces-330766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39697A3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC05284B75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2AD15748A;
	Mon, 16 Sep 2024 14:14:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAE154C14;
	Mon, 16 Sep 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726496068; cv=none; b=TpA/HbcbO/ppCEmt5ZSlQSfXKj0mJIbC3Pno4SwD41RZIslDdMcFYNez9HZJrOmVFllXspnsQQ+iS17rCNoqLfwM+ZjgcHq1CcM3ejM21lV6Blgr7OHg8Ymg4OTQ/FLddDeVqUg3zxD0PTEd9o6mCa7WBJHSbKtuvmVEw/o8ex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726496068; c=relaxed/simple;
	bh=nt1m40jmC88MUerazYaUKG2gZRYSURzG5v5u3/oziQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO12h/uSQmscF/010EO7AdgZ6e/rS/n7LTIt7jV1veCqt7311tBYpHM49WExVXoviLll5Th2yNiLq3qqFv93HqotHUykOSJL0l+7OkkgxDvY//pSuH/tyyLFwbQ83qJaUwLkJ6xwRxR8BqEF27UnYHHBot0Z/TmT1Qpcth5Xwaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90E6311FB;
	Mon, 16 Sep 2024 07:14:54 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27C03F64C;
	Mon, 16 Sep 2024 07:14:21 -0700 (PDT)
Date: Mon, 16 Sep 2024 15:14:08 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, devicetree@vger.kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, souvik.chakravarty@arm.com,
	robh@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v1 5/6] firmware: arm_scmi: Use max_msg and max_msg_size
 from devicetree
Message-ID: <Zug9MJj_3q0kSgAM@pluto>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <20240730144707.1647025-6-cristian.marussi@arm.com>
 <ZsSsq_Do-KEyy7vU@bogus>
 <34d1783c-8b0d-4337-8169-1c41cd02a6e3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d1783c-8b0d-4337-8169-1c41cd02a6e3@quicinc.com>

On Thu, Sep 12, 2024 at 12:22:48PM -0700, Nikunj Kela wrote:
> 
> On 8/20/2024 7:48 AM, Sudeep Holla wrote:
> > On Tue, Jul 30, 2024 at 03:47:06PM +0100, Cristian Marussi wrote:
> >> Override max_msg and max_msg_size transport properties when corresponding
> >> devicetree properties are available.
> >>
> > I am holding off on these changes to think how these max_msg and max_msg_size
> > can be used without breaking any platforms allowing space for the header
> > and the message itself which is around 28 bytes. The binding itself looks
> > good. We may have to adjust the value passed to the core driver taking
> > the above into consideration.
> >
> > --
> > Regards,
> > Sudeep
> 

Hi Nikunj,

these additional patches of initial series was still not reviewed by DT
maintainers really and it needed some rework for the reason Sudeep
mmentioned above. This is in my soon-ish todo list :P

Thanks,
Cristian

