Return-Path: <linux-kernel+bounces-267552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291849412BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18FC1F247A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3D19307B;
	Tue, 30 Jul 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xHUGXHcB"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93888623
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344481; cv=none; b=bqU0YuN2tSITSvnYSZAoxnwXhL0bnq1bi4SOz0WCp/DC+BTI7JF1b9kBEs1Il3WtOHTfRni18DDBAyfXEKzKPSZoq3iDNsLpjskkLWkT7eK0nz7tSIV1Izjfs4+ojnS38HVYzT8kBEE4PbVvUyz9QXP471G8z7jqHem4A2tMpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344481; c=relaxed/simple;
	bh=hmhLIng6c059pzvOYv2iZcklNrlk4sp5KvNtRpk3gAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niRXyiz+Z2xMwJf23eqdc1kIKvvpTSkNioS00lc2xd2hITZRLyv9vQdyrJkqf8Fdqi1B4+SwxRO6CDI+FCd5kMK9u8XLq5AjAE2Qk4D/OWnA+vnt22Cpntk9N9M2B5Mor5Y0j88xArgniFtMvvNWqrzutfjyOJRbtc+N4e8reA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xHUGXHcB; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-396675b83afso26019875ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722344478; x=1722949278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9RI/exw0UDuuOm9Ra0mTLdt9ClxNeQNOb2ROdTYCmDE=;
        b=xHUGXHcB1hZQFDJOAWy0/VQ90KtlquSLM7Soag2K7XZEV5b9BKAoW4z0iMhJfYUOEK
         dF3iqq4tAhhNhjG61Ixg0wkxB5bgHp1XJYh9bDsm/OuGPjXWGdfjmCQ+tRhDtGXH2THR
         S8wEqUp92/mc6/ZUNuL3EYb2gWeSd4JSx815bnPzCTgRZSQw9rqqQzu2kTdu+8lZR3Pm
         QqCkXKrflCXmp+5DBxUsihHvAsKySSFPxkxzuOvqpSYtPwlLA+HhgqvtdfkdKjgNAQJO
         FIBC1q7qQ9RNwiBDXlWpsuz7brUl1sMnQSzfi21YJZMVIjYpMHt3GBCc4tu78CYHUypv
         5h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344478; x=1722949278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RI/exw0UDuuOm9Ra0mTLdt9ClxNeQNOb2ROdTYCmDE=;
        b=G/SkEEKOgDbYlwc3Z1mbNfZOVV/xXtwN1npt2XfrWaaZDPBIZ8vkfKx+UfFs44AST4
         MDtqej3f3TnbT12wSdllhrA0LcDK19vFRSDbRl8SJp1BuPlTlJx7qCmjwFgINv3SVahQ
         hcL44tslnDzv2vdw9ygXnD1oI8dKhbueFaSa4DJClIQxmicye0Dxbr88sPdlFQgcQVus
         hq+lMm3ipvetyL+YD4HkXh/MXO5/fhJRDxAnYWehiCO474jWK1Qe1fEySYS5jFLz67WF
         cPKQLy0ZO+Ccfk00ulxwuqo8ErLRA8AHHuD1MZF0b1UexxqtI7c/a1YErz3HRzc63XLS
         Hcww==
X-Forwarded-Encrypted: i=1; AJvYcCVGSDB8omKYj7Zk4xJdoMCDFdHCFXmUgB8ma03rK98w6kgviFUaV80cfya5KoyYjK9PP14qmqXW97hAwwqj4V/e5byvxuYVyPRU1lcz
X-Gm-Message-State: AOJu0YyUXndqqxfZA0Y+TaNpSPQ5YkZ7YHARMqDZwRrdspfbaVcHs28g
	mVuK4ocV5qpWF0doese4Fz1HqBtC4gXeAWoqYSuptGC04JFbPEutB2yZBSe+JsE=
X-Google-Smtp-Source: AGHT+IFgbcLAc1fRk8/4fljINGyXBPTYgpctkSdW9iE6bPdmkFssRuKjeYeo4aPuqUr2D4zXXdux2w==
X-Received: by 2002:a92:c26e:0:b0:385:e2e5:ac37 with SMTP id e9e14a558f8ab-39aec40c9c6mr134065645ab.22.1722344477441;
        Tue, 30 Jul 2024 06:01:17 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22f13f81sm46399455ab.70.2024.07.30.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:01:16 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:01:13 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] firmware: ti_sci: Partial-IO support
Message-ID: <x4y44ajcdi2y2dieaa6oohrptpzyiono3fruvwcdelmtzsh4ne@cgqxsz45ohcy>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-3-msp@baylibre.com>
 <20240730122801.jzo5ahkurxaexwcm@ambiance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730122801.jzo5ahkurxaexwcm@ambiance>

On Tue, Jul 30, 2024 at 07:28:01AM GMT, Nishanth Menon wrote:
> On 10:00-20240729, Markus Schneider-Pargmann wrote:
> > Add support for Partial-IO poweroff. In Partial-IO pins of a few modules
> > can generate system wakeups while DDR memory is not powered resulting in
> > a fresh boot of the system. The modules that can be wakeup sources are
> > defined by the devicetree.
> > 
> > Only wakeup sources that are actually enabled by the user will be
> > considered as a an active wakeup source. If none of the wakeup sources
> > are enabled the system will do a normal poweroff. If at least one wakeup
> > source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
> > message from the sys_off handler. Sending this message will result in an
> > immediate shutdown of the system. No execution is expected after this
> > point. The code will enter an infinite loop.
> > 
> > The wakeup source device nodes are gathered during probe. But they are
> > only resolved to the actual devices in the sys_off handler, if they
> > exist. If they do not exist, they are ignored.
> > 
> > A short documentation about Partial-IO can be found in section 6.2.4.5
> > of the TRM at
> >   https://www.ti.com/lit/pdf/spruiv7
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  drivers/firmware/ti_sci.c | 160 +++++++++++++++++++++++++++++++++-----
> >  drivers/firmware/ti_sci.h |  34 ++++++++
> >  2 files changed, 175 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > index 160968301b1f..ba2e56da0215 100644
> > --- a/drivers/firmware/ti_sci.c
> > +++ b/drivers/firmware/ti_sci.c
> > @@ -99,6 +99,9 @@ struct ti_sci_desc {
> >   * @node:	list head
> >   * @host_id:	Host ID
> >   * @users:	Number of users of this instance
> > + * @nr_wakeup_sources: Number of device nodes in wakeup_source_nodes
> > + * @wakeup_source_nodes: Array of all device_nodes listed as wakeup sources in
> > + *			 the devicetree
> >   */
> >  struct ti_sci_info {
> >  	struct device *dev;
> > @@ -116,6 +119,9 @@ struct ti_sci_info {
> >  	u8 host_id;
> >  	/* protected by ti_sci_list_mutex */
> >  	int users;
> > +
> > +	int nr_wakeup_sources;
> > +	struct device_node **wakeup_source_nodes;
> >  };
> >  
> >  #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
> > @@ -392,10 +398,13 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
> >  static inline int ti_sci_do_xfer(struct ti_sci_info *info,
> >  				 struct ti_sci_xfer *xfer)
> >  {
> > +	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
> >  	int ret;
> >  	int timeout;
> >  	struct device *dev = info->dev;
> >  	bool done_state = true;
> > +	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
> > +						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
> 
> I think a separate patch to introduce a no_response expected patch would
> make sense on which we build tisci_sys_off_handler in the next patch?
> 
> >  
> >  	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
> >  	if (ret < 0)
> > @@ -403,25 +412,27 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
> >  
> >  	ret = 0;
> >  
> > -	if (system_state <= SYSTEM_RUNNING) {
> > -		/* And we wait for the response. */
> > -		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> > -		if (!wait_for_completion_timeout(&xfer->done, timeout))
> > -			ret = -ETIMEDOUT;
> > -	} else {
> > -		/*
> > -		 * If we are !running, we cannot use wait_for_completion_timeout
> > -		 * during noirq phase, so we must manually poll the completion.
> > -		 */
> > -		ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
> > -					       done_state, 1,
> > -					       info->desc->max_rx_timeout_ms * 1000,
> > -					       false, &xfer->done);
> > -	}
> > +	if (response_expected) {
> 
> 	How about a goto?

Yes, thanks, looks cleaner.

> 
> if (!response_expected)
> 	goto no_response;
> > +		if (system_state <= SYSTEM_RUNNING) {
> > +			/* And we wait for the response. */
> > +			timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> > +			if (!wait_for_completion_timeout(&xfer->done, timeout))
> > +				ret = -ETIMEDOUT;
> > +		} else {
> > +			/*
> > +			 * If we are !running, we cannot use wait_for_completion_timeout
> > +			 * during noirq phase, so we must manually poll the completion.
> > +			 */
> > +			ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
> > +						       done_state, 1,
> > +						       info->desc->max_rx_timeout_ms * 1000,
> > +						       false, &xfer->done);
> > +		}
> >  
> > -	if (ret == -ETIMEDOUT)
> > -		dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
> > -			(void *)_RET_IP_);
> > +		if (ret == -ETIMEDOUT)
> > +			dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
> > +				(void *)_RET_IP_);
> > +	}
> >  
> no_response:
> 
> >  	/*
> >  	 * NOTE: we might prefer not to need the mailbox ticker to manage the
> > @@ -3262,6 +3273,82 @@ static int tisci_reboot_handler(struct sys_off_data *data)
> >  	return NOTIFY_BAD;
> >  }
> >  
> [...]
> 
> > +static int tisci_sys_off_handler(struct sys_off_data *data)
> > +{
> > +	struct ti_sci_info *info = data->cb_data;
> > +	int i;
> > +	int ret;
> > +	bool enter_partial_io = false;
> > +
> > +	for (i = 0; i != info->nr_wakeup_sources; ++i) {
> > +		struct platform_device *pdev =
> > +			of_find_device_by_node(info->wakeup_source_nodes[i]);
> > +
> > +		if (!pdev)
> > +			continue;
> > +
> > +		if (device_may_wakeup(&pdev->dev)) {
> > +			dev_dbg(info->dev, "%pOFp identified as wakeup source\n",
> > +				info->wakeup_source_nodes[i]);
> > +			enter_partial_io = true;
> > +		}
> > +	}
> > +
> > +	if (!enter_partial_io)
> > +		return NOTIFY_DONE;
> > +
> > +	ret = tisci_enter_partial_io(info);
> > +
> > +	if (ret) {
> > +		dev_err(info->dev,
> > +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
> > +			ERR_PTR(ret));
> > +		emergency_restart();
> > +	}
> > +
> > +	while (1);
> 
> Why not fall through OR go through emergency_restart (since there is
> no fall through for shutdown path) if it acks, but actually fails to
> enter LPM state after a dt described or a default timeout period?
> 
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> >  /* Description for K2G */
> >  static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
> >  	.default_host_id = 2,
> > @@ -3398,6 +3485,35 @@ static int ti_sci_probe(struct platform_device *pdev)
> >  		goto out;
> >  	}
> >  
> > +	if (of_property_read_bool(dev->of_node, "ti,partial-io-wakeup-sources")) {
> 
> You should probably check on TISCI_MSG_QUERY_FW_CAPS[1] if
> Partial IO on low power mode is supported as well? if there is a
> mismatch, report so?

I actually have another series in my queue that introduces this check. I
just implemented this check for Partial-IO yesterday in the patch that
introduces fw capabilities. If you like I can switch these series
around.

> 
> > +		info->nr_wakeup_sources =
> > +			of_count_phandle_with_args(dev->of_node,
> > +						   "ti,partial-io-wakeup-sources",
> > +						   NULL);
> > +		info->wakeup_source_nodes =
> > +			devm_kzalloc(dev, sizeof(*info->wakeup_source_nodes),
> > +				     GFP_KERNEL);
> > +
> > +		for (i = 0; i != info->nr_wakeup_sources; ++i) {
> > +			struct device_node *devnode =
> > +				of_parse_phandle(dev->of_node,
> > +						 "ti,partial-io-wakeup-sources",
> > +						 i);
> > +			info->wakeup_source_nodes[i] = devnode;
> 
> Curious: Don't we need to maintain reference counting for the devnode
> if CONFIG_OF_DYNAMIC?

In case you mean I missed of_node_put(), yes, I did, thank you. I added
it in a ti_sci_remove().

Best
Markus

