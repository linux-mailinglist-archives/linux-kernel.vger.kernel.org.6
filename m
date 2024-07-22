Return-Path: <linux-kernel+bounces-258676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2295938B81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8054D281AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ACE1684A4;
	Mon, 22 Jul 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KQpjxN6a"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B18F66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638196; cv=none; b=FYgM3vhde3gR4JYLN7Q1avrZ+fh3+Cc5aafR0ES+7pbfYdbRmrugWnizLushnB4OQZQEF8Kk3EhHRZU3d9pXHZEB/4CwcLIw9UvAFnHITLlnJJ3dnAaejgBsWVgz/u7A1LvT3hMFOuAp+/UJBkL87XODy8LCrbX2fFcvxVlzJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638196; c=relaxed/simple;
	bh=47VPo2UorIlNZcLnbJEBEqv9wf0h06RjopgrPHwuUC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKK1jNQGxX5lVEf/MZ05OvODrR+ZjeZhUsHRsAlkNG8Dncne/a7pH9WG4Lu7BTsBD22SkV+TThnaDgRskg3wlNLX8cnRevF8UaCb2QUJrFwGG1QJw9GmY1FXFHivi1+TV6BxDz5lLRUul9S9qdGOXz8qbwppiw0DChxYiccwE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KQpjxN6a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so26528655e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721638192; x=1722242992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ow+3TiyVj0GJ9511ydtr5o2dgkAgB9VcYLqHCc+aPiQ=;
        b=KQpjxN6alDCYEMRWCY0UW1facRhmAikdpUe8c1yXpnumPnmFyr2b0McAofXuq5Xafz
         3bRbXWENLIgHF1Mcq9EPyMdnCchI51m2uR5xfSGT7gqTrVeT89g9Lj50Rc49ZVbuFcUL
         w2DthRbcVhyNET6QJBDQz6InO/WVCPoeFCu+SAQLICznZxIs+HbwMuheL2Sc6sD3pioj
         ClRcqyWaN9PsXK9F3/FF/xkPUjNotUMc/7u0NABYdN3UlbwSfEYwYY+6nBgzVgaK/iz5
         s1UsktkmbZkLhwAAW/Y5AweOVBsnCupTyzabxZyuk965jhz7h/h4I/MxQTJkiF7g1X8/
         VhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638192; x=1722242992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow+3TiyVj0GJ9511ydtr5o2dgkAgB9VcYLqHCc+aPiQ=;
        b=jZbFk07/BG24zqX/WmPCAHbj2lEku3ITzJAb/M3P72TxW2lzhaP3gDv6XDd3muD+fp
         CDI+rvWUSqndBU0ccRs/dwK9jukBSFOh76uRss4A9yJN9VFGKU2GukBCW1DkQNGutiZN
         lBnaS9/cx+XdDGeBUdlBHXz8NBGgC6VDRdjFdw856woEPM+ygJCVrzUj8ZaeQom85V3b
         a1H7QBMRLo0mVv+EBmeCv5vmWhGT9yRx1BGFRI4h8wIN087N8/Ip4HB5Nj/xmjJxMTqn
         ZgrcCn3DgQ82evd9kzpF6hpIwJZPIFmHMlfdTeeLDBrMKZJ8wZIrS8tO12sBN26o9FKL
         9i7w==
X-Forwarded-Encrypted: i=1; AJvYcCWqf2GvxtXTW9UCfclmfl+pFU4mZEEwHzfC88Vrg3abHDyDskEqJA/l0l1qxagmbiUoLv7O5cIjh7aS7dQt4rJkNjZNgdT79D8l3KXL
X-Gm-Message-State: AOJu0Yy6pzMfinUgvphyrK1rpUyX2rBorPeejD+ZwHzX4PiMztEzEgR2
	f1q3F/otgzevmRso8s8klvrPyYD8wk2G0No296Fq6OUPWbdIvGuWyXAdukw5r0Y=
X-Google-Smtp-Source: AGHT+IEV6ZArP3dSMTn33w6BUO0/tULLfdMjg6DA7wmDUW0v+Jzor4zkYN97P4gu9T/Bns/QI18YWA==
X-Received: by 2002:a05:600c:4f0c:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-427daa2815cmr36000095e9.12.1721638192233;
        Mon, 22 Jul 2024 01:49:52 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6902a1fsm116372845e9.20.2024.07.22.01.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:49:52 -0700 (PDT)
Message-ID: <82f03be5-b8b1-4df2-8b4b-0cae5d6d67ba@suse.com>
Date: Mon, 22 Jul 2024 10:49:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] net/9p/usbg: Add new usb gadget function transport
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>, v9fs@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, kernel@pengutronix.de
References: <20240116-ml-topic-u9p-v7-0-3a1eeef77fbe@pengutronix.de>
 <20240116-ml-topic-u9p-v7-2-3a1eeef77fbe@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240116-ml-topic-u9p-v7-2-3a1eeef77fbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22.07.24 00:08, Michael Grzeschik wrote:

> +
> +static int usb9pfs_queue_tx(struct f_usb9pfs *usb9pfs, struct usb_request *req,
> +			    gfp_t gfp_flags)
> +{
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	int ret = -ENOMEM;

No need. This will be overwritten.

> +
> +	if (!(usb9pfs->p9_tx_req->tc.size % usb9pfs->in_ep->maxpacket))
> +		req->zero = 1;
> +
> +	req->buf = usb9pfs->p9_tx_req->tc.sdata;
> +	req->length = usb9pfs->p9_tx_req->tc.size;
> +
> +	dev_dbg(&cdev->gadget->dev, "%s usb9pfs send --> %d/%d, zero: %d\n",
> +		usb9pfs->in_ep->name, req->actual, req->length, req->zero);
> +
> +	ret = usb_ep_queue(usb9pfs->in_ep, req, gfp_flags);
> +
> +	dev_dbg(&cdev->gadget->dev, "tx submit --> %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int usb9pfs_queue_rx(struct f_usb9pfs *usb9pfs, struct usb_request *req,
> +			    gfp_t gfp_flags)
> +{
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	int ret = -ENOMEM;

Overwritten in literally the next statement.

> +	ret = usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
> +
> +	dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int usb9pfs_transmit(struct f_usb9pfs *usb9pfs)
> +{
> +	struct p9_req_t *p9_req = NULL;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&usb9pfs->lock, flags);
> +	if (usb9pfs->p9_tx_req) {
> +		spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +		return -EBUSY;
> +	}
> +
> +	p9_req = list_first_entry_or_null(&usb9pfs->tx_req_list,
> +					  struct p9_req_t, req_list);
> +	if (!p9_req) {
> +		spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +		return -ENOENT;
> +	}
> +
> +	list_del(&p9_req->req_list);

You have deleted it from the list

> +	usb9pfs->p9_tx_req = p9_req;
> +
> +	p9_req_get(usb9pfs->p9_tx_req);
> +
> +	ret = usb9pfs_queue_tx(usb9pfs, usb9pfs->in_req, GFP_ATOMIC);

This means that if this function returns an error, the deletion
from the list may or may not have happened.

> +	spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_usb9pfs *usb9pfs = ep->driver_data;
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	int ret = 0;
> +
> +	if (req->status) {
> +		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +			ep->name, req->status, req->actual, req->length);
> +		return;
> +	}
> +
> +	/* reset zero packages */
> +	req->zero = 0;
> +
> +	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +		ep->name, req->status, req->actual, req->length);
> +
> +	WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
> +
> +	p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
> +
> +	ret = usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
> +	if (ret)
> +		return;

Ehhh ? Could you explain the error handling here?

> +
> +	return;
> +}
> +
> +static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
> +{
> +	struct p9_req_t *p9_rx_req;
> +	struct p9_fcall	rc;
> +	int ret;
> +
> +	/* start by reading header */
> +	rc.sdata = buf;
> +	rc.offset = 0;
> +	rc.capacity = P9_HDRSZ;
> +	rc.size = P9_HDRSZ;
> +
> +	p9_debug(P9_DEBUG_TRANS, "mux %p got %zu bytes\n", usb9pfs,
> +		 rc.capacity - rc.offset);
> +
> +	ret = p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
> +	if (ret) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			 "error parsing header: %d\n", ret);
> +		return NULL;
> +	}
> +
> +	p9_debug(P9_DEBUG_TRANS,
> +		 "mux %p pkt: size: %d bytes tag: %d\n",
> +		 usb9pfs, rc.size, rc.tag);
> +
> +	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
> +	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
> +		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
> +		return NULL;
> +	}
> +
> +	if (rc.size > p9_rx_req->rc.capacity) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			 "requested packet size too big: %d for tag %d with capacity %zd\n",
> +			 rc.size, rc.tag, p9_rx_req->rc.capacity);
> +		p9_req_put(usb9pfs->client, p9_rx_req);
> +		return NULL;
> +	}
> +
> +	if (!p9_rx_req->rc.sdata) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			 "No recv fcall for tag %d (req %p), disconnecting!\n",
> +			 rc.tag, p9_rx_req);
> +		p9_req_put(usb9pfs->client, p9_rx_req);
> +		return NULL;
> +	}
> +
> +	return p9_rx_req;
> +}
> +
> +static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_usb9pfs *usb9pfs = ep->driver_data;
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	struct p9_req_t *p9_rx_req;
> +	unsigned long flags;
> +
> +	if (req->status) {
> +		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +			ep->name, req->status, req->actual, req->length);
> +		return;
> +	}
> +
> +	p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
> +	if (!p9_rx_req)
> +		return;
> +
> +	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
> +
> +	p9_rx_req->rc.size = req->actual;
> +
> +	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
> +	p9_req_put(usb9pfs->client, p9_rx_req);
> +
> +	spin_lock_irqsave(&usb9pfs->lock, flags);
> +	usb9pfs->p9_tx_req = NULL;
> +
> +	spin_unlock_irqrestore(&usb9pfs->lock, flags);

Why can usb9pfs_tx_complete() touch this without taking the spinlock?

> +
> +	usb9pfs_transmit(usb9pfs);

This can fail. What happens then?

> +
> +	return;
> +}
> +


[..]

> +static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)

This ought to be boolean

> +{
> +	struct f_usb9pfs *usb9pfs = client->trans;
> +	unsigned long flags;
> +	int ret = 1;
> +
> +	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
> +
> +	spin_lock_irqsave(&usb9pfs->lock, flags);
> +
> +	if (req->status == REQ_STATUS_UNSENT) {
> +		list_del(&req->req_list);
> +		WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
> +		p9_req_put(client, req);
> +		ret = 0;
> +	}
> +	spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +
> +	return ret;
> +}

	Regards
		Oliver


