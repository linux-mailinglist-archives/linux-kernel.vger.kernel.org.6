Return-Path: <linux-kernel+bounces-555777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3591A5BC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A8416D166
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DD422DFAD;
	Tue, 11 Mar 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aaTeGECj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160C1DED5E;
	Tue, 11 Mar 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686495; cv=none; b=BvrCF0LaBu1Uay/hE3xFZhRiKQNBzkZNsfHEUmJGl0OA0jNvw6EjNMD6Nox6eRuIkHQKmD2bWDv0BZ1IsXnKMLCbF5YLCf1hXFOS1mGmLgd7F6l8RPk00MQqDf2q6KGV3DBKdx1K1W3H0wEsYkRbrYRNsevxTfk4MpNaTxb9iIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686495; c=relaxed/simple;
	bh=Bj3MZAkLhroDM6PD5/FlfO6szqYvALrIFOsJW3zG3xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiMrxMo6tqSisQ5EYak+kwDW21hqTRdUJ2PTIMPZVAuy4NxvKSDRJz1KBM2jEWsvXlOERdo22HFA40fXGAkCmrD715Utpr5z1cfCsqnDcJeQSOL6+qOp4tEqq3APba42PNHrQgkYiYwB8nU1qAlmJzB9u9oEnUZUzYzns2ROqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaTeGECj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10079C4CEE9;
	Tue, 11 Mar 2025 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741686494;
	bh=Bj3MZAkLhroDM6PD5/FlfO6szqYvALrIFOsJW3zG3xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaTeGECjqQcWk7jTGHU6ZU3RUYOhZR8DIqHvPc43K8XfN/kA6VT6UV97hQ1PFe7Wg
	 6zLQADArE/5d2v4JSqFlezzgjT1JM0W5ZuElZzbCi3JM4mbkxq8l6yjd2fq9Kxq6s5
	 m7/Uz7i8Rd+Ycxo6SIq88KdlQKEz6OaEAMw0Y1S4=
Date: Tue, 11 Mar 2025 10:48:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Dai <daixin_tkzc@163.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: Fix `us->iobuf` size for BOT transmission
 to prevent memory overflow
Message-ID: <2025031142-squealer-shaded-7ef7@gregkh>
References: <20250311084111.322351-1-daixin_tkzc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311084111.322351-1-daixin_tkzc@163.com>

On Tue, Mar 11, 2025 at 04:41:11PM +0800, Xin Dai wrote:
> When the DWC2 controller detects a packet Babble Error, where a device
> transmits more data over USB than the host controller anticipates for a
> transaction. It follows this process:
> 
> 1. The interrupt handler marks the transfer result of the URB as
>    `OVERFLOW` and returns it to the USB storage driver.
> 2. The USB storage driver interprets the data phase transfer result of
>    the BOT (Bulk-Only Transport) as `USB_STOR_XFER_LONG`.
> 3. The USB storage driver initiates the CSW (Command Status Wrapper)
>    phase of the BOT, requests an IN transaction, and retrieves the
>    execution status of the corresponding CBW (Command Block Wrapper)
>    command.
> 4. The USB storage driver evaluates the CSW and finds it does not meet
>    expectations. It marks the entire BOT transfer result as
>    `USB_STOR_XFER_ERROR` and notifies the SCSI layer that a `DID_ERROR`
>    has occurred during the transfer.
> 5. The USB storage driver requests the DWC2 controller to initiate a
>    port reset, notifying the device of an issue with the previous
>    transmission.
> 6. The SCSI layer implements a retransmission mechanism.
> 
> In step 3, the device remains unaware of the Babble Error until the
> connected port is reset. We observed that the device continues to send
> 512 bytes of data to the host (according to the BBB Transport protocol,
> it should send only 13 bytes). However, the USB storage driver
> pre-allocates a default buffer size of 64 bytes for CBW/CSW, posing a
> risk of memory overflow. To mitigate this risk, we have adjusted the
> buffer size to 512 bytes to prevent potential errors.

Where is this memory being overflowed?  I see it being used in the
usb_stor_CB_transport() call, should we just be checking the buffer size
there?

Your change just bumps the buffer up, it does not actually check any
tests for when the buffer is written to, which feels like it is not the
correct fix.  What's to prevent a device from sending a bigger message
to overflow it?

But again, where exactly is the overflow happening?

thanks,

greg k-h

