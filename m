Return-Path: <linux-kernel+bounces-214621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A4F908731
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3482860B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CFD1922D5;
	Fri, 14 Jun 2024 09:19:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62B7E574;
	Fri, 14 Jun 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356788; cv=none; b=HuN8RsFSsuga9wf+ZZglI5T8xmrN6SIIw6FNg7nNlLx01twKHUj3fI5jj5cWP3PoFIQGZOlZcdq9fo0LrTOdcjK51CiFE1eXye1ZsaJiKW1dEJ05FWYUmwaVL2o/l3aAD55N7TDTcF020t7X2aNQlebo/q76uk2Emvvoa9Ue+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356788; c=relaxed/simple;
	bh=GBUGIbROlFX1OdcaWHEELKAdQiLL5ncUEClh6MLQAww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNwlgHehUruBEjgqZ4HDrd1GM3B1lCWYIOtas3LsRHuWxIHvWfuUY3V7dUu29VkF8XJwMr2mCoSeigpYi03KyJbLaemOpDGvI9UlyFJIlVzzRc9QCwfvEKWUPFIyDbguhyIO6rzkQY8RFl4ftC+6EGMA7g5KWLseHlw0/UEkGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47D68339;
	Fri, 14 Jun 2024 02:20:10 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6730F3F5A1;
	Fri, 14 Jun 2024 02:19:44 -0700 (PDT)
Date: Fri, 14 Jun 2024 10:19:42 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Message-ID: <ZmwLLoh1dbykOZZq@bogus>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
 <20240510-scmi-notify-v2-2-e994cf14ef86@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-scmi-notify-v2-2-e994cf14ef86@nxp.com>

On Fri, May 10, 2024 at 11:19:48AM +0800, Peng Fan (OSS) wrote:

There was some coding style error reported(unbalanced {}) which made me
look at the code again. I don't think we need to splat out error.

> @@ -300,8 +326,30 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
>  static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
>  {
>  	struct scmi_mailbox *smbox = cinfo->transport_info;
> +	struct device *cdev = cinfo->dev;
> +	struct mbox_chan *intr;
> +	int ret;
>  
>  	shmem_clear_channel(smbox->shmem);
> +
> +	if (!shmem_channel_intr_enabled(smbox->shmem))
> +		return;
> +
> +	if (smbox->chan_platform_receiver)
> +		intr = smbox->chan_platform_receiver;
> +	else if (smbox->chan)
> +		intr = smbox->chan;
> +	else {
> +		dev_err(cdev, "Channel INTR wrongly set?\n");
> +		return;
> +	}
> 

If it is OK I would like to fix it up with below change.

Regards,
Sudeep

-->8

diff --git i/drivers/firmware/arm_scmi/mailbox.c w/drivers/firmware/arm_scmi/mailbox.c
index adb69a6a0223..3bb3fba8f478 100644
--- i/drivers/firmware/arm_scmi/mailbox.c
+++ w/drivers/firmware/arm_scmi/mailbox.c
@@ -326,30 +326,25 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
 {
        struct scmi_mailbox *smbox = cinfo->transport_info;
-       struct device *cdev = cinfo->dev;
-       struct mbox_chan *intr;
+       struct mbox_chan *intr_chan = NULL;
        int ret;

        shmem_clear_channel(smbox->shmem);

-       if (!shmem_channel_intr_enabled(smbox->shmem))
-               return;
-
        if (smbox->chan_platform_receiver)
-               intr = smbox->chan_platform_receiver;
+               intr_chan = smbox->chan_platform_receiver;
        else if (smbox->chan)
-               intr = smbox->chan;
-       else {
-               dev_err(cdev, "Channel INTR wrongly set?\n");
+               intr_chan = smbox->chan;
+
+       if (!(intr_chan && shmem_channel_intr_enabled(smbox->shmem)))
                return;
-       }

-       ret = mbox_send_message(intr, NULL);
+       ret = mbox_send_message(intr_chan, NULL);
        /* mbox_send_message returns non-negative value on success, so reset */
        if (ret > 0)
                ret = 0;

-       mbox_client_txdone(intr, ret);
+       mbox_client_txdone(intr_chan, ret);
 }

 static bool


