Return-Path: <linux-kernel+bounces-357002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835D996A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4F0286618
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A01B194C90;
	Wed,  9 Oct 2024 12:37:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F501E4AE;
	Wed,  9 Oct 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477467; cv=none; b=FhUHJ5OZpo0/bqTCzyOQVp+TtLbA0PSXKb2gxWKPa3pbjujv7CRlhM3JBqdcFHpUSNlLBdugNNAgSManGz/vPua77P7RS6XTSapgXcFXvjAvXNZMpyxXGVh2SwAOJ4IBo7IHUI8J8zz+lRO2t4NaMVoag5vvIMDOt+PAXWsmfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477467; c=relaxed/simple;
	bh=QlJ0EzVyTCLvsGQ2C6oOHepjFhpSg9ykXkd/E+cRTnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUtlALIKUPAVtf8qDpUX5ar/K2bdk4cKTfZNL4aRBXi8A7UwOa0WWv1SoEFJ4txCghP+ef8ioCR8CQY5ThCAN1IqOAdkx1BZJlYDznSGcYrAXKGDnwpJcYAx7hVKCD8GGvEg8CEmWAxkia0vQAWK2uQ7fRvvgwcZiWy/kuU1cHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C684FEC;
	Wed,  9 Oct 2024 05:38:13 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E49A3F58B;
	Wed,  9 Oct 2024 05:37:41 -0700 (PDT)
Date: Wed, 9 Oct 2024 13:37:38 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infread.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	"moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <linux-arm-kernel@lists.infradead.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] firmware: arm_scmi: Give SMC transport precedence over
 mailbox
Message-ID: <ZwZ5EinIhUsXT83d@bogus>
References: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
 <ZwPLgcGeUcFPvjcz@pluto>
 <a4f403e8-44eb-4fb4-8696-ca8ad7962a00@broadcom.com>
 <ZwUuSTYkWrZYIcBM@bogus>
 <ecc29852-37f4-404e-b22c-817cb7cb0cfb@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecc29852-37f4-404e-b22c-817cb7cb0cfb@broadcom.com>

On Tue, Oct 08, 2024 at 10:49:01AM -0700, Florian Fainelli wrote:
> On 10/8/24 06:06, Sudeep Holla wrote:

[...]

> > IIUC, you need to support old kernel with SMC mailbox driver and new SMC
> > transport within the SCMI. Is that right understanding ?
> 
> That is correct.
> 

Thanks.

> > IIUC, the DTB has mailbox nodes that are available but fail only in the setup
> > stage ? Or is it marked unavailable and we are missing some checks either
> > in SCMI or mailbox ?
> 
> We fail at scmi_chan_setup -> idr_find() returning -EINVAL.

IIRC, the original intention of code under if(!info->desc->ops->chan_available()
in scmi_chan_setup(), is to just handle Rx case and valid Tx missing case for
non BASE protocols. I wonder if we can add additional check at the start of
this if block:
	if (tx && prot_id == SCMI_PROTOCOL_BASE)
		return -ENODEV or -ENOENT;

just to better handle your scenario. But IIUC it may not fix your issue as
we still return success from the platform_device probing with the new
restructuring. It is only the probe of the device we create from this one
can be made to fail. I think I know understand the issue much better than
before.

> I did check that
> returning -ENODEV, which arguably might be a somewhat more accurate return
> code (-ENOENT being one, too) does not help us here. Cristian suggested
> device_release_driver() which sounded like a good idea, but will deadlock.
>

Cristian mentioned in private he will explore other options just in case
we need solid alternative to address your issue.

> The reason why we fail there is because mailbox_chan_available() returns
> false. With fw_devlink=on Linux will parse the Device Tree, find the
> 'mboxes' property pointing to the brcm_scmi_mailbox Device Tree node and
> puts it on a list of providers that it is waiting for.
> 
> Because we are using the ARM SMC transport however, the brcm_scmi_mailbox
> node is never backed by any driver in Linux and this causes the system to
> fail booting since we do not have any SCMI provider. At the time, because we
> were under pressure to get a GKI kernel we decided to "break" our older
> downstream kernels by doing this property rename and put in a patch in those
> kernel to treat "brcm,mboxes" the same as "mboxes" where relevant, which was
> mostly in SCMI.
> 
> Now, assuming that we revert that DT property rename, that still does not
> really solve anything anyway, the channel is not available regardless of how
> we shake it.
>

Understood. Thanks for detailed explanation and time.

> > 
> > IOW, have you already explored that this -EINVAL is correct return value
> > here and can't be changed to -ENODEV ? I might be not following the failure
> > path correctly here, but I assume it is
> > 	scmi_chan_setup()
> > 	info->desc->ops->chan_setup()
> > 	mailbox_chan_setup()
> > 	mbox_request_channel()

[...]

> > OK this sounds like you have already explored returning -ENODEV is not
> > an option ? It is fair enough, but just want to understand correctly.
> > I still think I am missing something.
> 
> Yes, that was my first start.
>

Now I know why that won't work or its not so trivial as we have some kind
of redirection to address various transport dependencies and the mechanism we
have implemented to avoid probe deferral with additional platform devices
and associated probing make it difficult to propagate the error of DD model.
We need that to handle the dependency better than relying on probe deferral
which comes with its problems(like initcall level adjustments when using
some transports like OPTEE/FFA/virtio/...). Your issue is not an issue
in normal case 😄. Anyways, I will queue this as it is not affecting anyone
else. Hopefully no one has any objections.

-- 
Regards,
Sudeep

