Return-Path: <linux-kernel+bounces-381129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02829AFAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45A22839F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738C1B4C35;
	Fri, 25 Oct 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LXGUCjFJ"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2F18BB9A;
	Fri, 25 Oct 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840390; cv=none; b=VVNDuA3Jq9Ht5TxTZOF2i5su1iQmcBkFs4X2ecAy/iIz88lS0Rpmz6hWSGwXvr+MIwVKn0YyE6XDmv8GI0y2evwPj4dUpvg0qQf659fdMctpwTGZ3xbYun8+smrWrqV00jxGI9Rd+3ZSEHevtmg01A5nKjrtbVn54AYkdPyNZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840390; c=relaxed/simple;
	bh=QN6EjXcY2irVhc13Aq9jpxf7X7SKqK+KDUybD8p3cHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnBiIfe1383LGAqWyZmlv2vLZ/2e2BoedZ6/Mb/AkL7FN/JUpZbIeB0PoYZfR/CNkbcmXXBsRWTyqifIYbry1IoiLiNgZ6VkGEuwbRTtv8VfKfKteKmHL/0Szbfq2v5/TA+EzmoJ0UiwyJeQpcaZIybQ4pGVXWey4vzuiNU7Ocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LXGUCjFJ; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A7AE4C1537;
	Fri, 25 Oct 2024 07:09:20 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB8E61C0003;
	Fri, 25 Oct 2024 07:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729840153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvVGBYLCMZmK8swdEZ9GMYvRd6cHQ6uwFr7LEEGTPho=;
	b=LXGUCjFJjDv6wg8yDbBEttD8DW5YNr1zomKDB9ZId4eAZ/Q3rkE10TtibB8Pklu6eYSOgL
	hndzLsixy1lEpoHrCNLxAdy8BCEjHKQjZE7lTMW/5Pi5IOaaVAeA1JNX2+vKlPg6XKtpB7
	3TVl17ssImmy10l3I0sNM8TMefhA1DSmojFtJ6IzdzDkZeCD15U1k37wARyOfM2b1FAaHd
	dyUdlG5r8C9XSAD9EwCI9Z8ARs7NPuFfAJzXGR5Kwc5cY2YTO+mdeo7SEGNa13wxhEuBkr
	vV1pJqMETwjuFbh5yc4R3Td1sOxAbvS6UrWqXunWjKd065+EQK+Ek0zSq2KRoA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 2/2] usb: typec: mux: Add support for the TUSB1046 crosspoint
 switch
Date: Fri, 25 Oct 2024 09:09:11 +0200
Message-ID: <1945710.vURJNgTSzn@fw-rgant>
In-Reply-To: <bgqmq4kehejgud2eymcwusbu6ks4jnaeasr6ad735czxxazyht@ppzrbmce5mog>
References:
 <20241024-tusb1046-v2-0-d031b1a43e6d@bootlin.com>
 <20241024-tusb1046-v2-2-d031b1a43e6d@bootlin.com>
 <bgqmq4kehejgud2eymcwusbu6ks4jnaeasr6ad735czxxazyht@ppzrbmce5mog>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

Hello Dmitry,

On vendredi 25 octobre 2024 08:39:54 UTC+2 Dmitry Baryshkov wrote:
> On Thu, Oct 24, 2024 at 10:54:17AM +0200, Romain Gantois wrote:
...
> > +
> > +static int tusb1046_mux_set(struct typec_mux_dev *mux,
> > +			    struct typec_mux_state *state)
> > +{
> > +	struct tusb1046_priv *priv = typec_mux_get_drvdata(mux);
> > +	struct i2c_client *client = priv->client;
> > +	struct device *dev = &client->dev;
> > +	int mode, val, ret = 0;
> > +
> > +	if (state->mode >= TYPEC_STATE_MODAL &&
> > +	    state->alt->svid != USB_TYPEC_DP_SID)
> > +		return -EINVAL;
> > +
> > +	dev_dbg(dev, "mux mode requested: %lu\n", state->mode);
> > +
> > +	mutex_lock(&priv->general_reg_lock);
> > +
> > +	val = i2c_smbus_read_byte_data(client, TUSB1046_REG_GENERAL);
> > +	if (val < 0) {
> > +		dev_err(dev, "failed to read ctlsel status, err %d\n", val);
> > +		ret = val;
> > +		goto out_unlock;
> > +	}
> > +
> > +	switch (state->mode) {
> > +	case TYPEC_STATE_USB:
> > +		mode = TUSB1046_CTLSEL_USB3;
> > +		break;
> 
> > +	case TYPEC_DP_STATE_C:
> These are only valid if you have checked that altmode SVID is a
> DisplayPort SVID.

I did check it near the beginning of the function didn't I?

> > +	if (state->mode >= TYPEC_STATE_MODAL &&
> > +	    state->alt->svid != USB_TYPEC_DP_SID)
> > +		return -EINVAL;

Or is there something I'm missing?

Thanks for the review,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




