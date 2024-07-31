Return-Path: <linux-kernel+bounces-269266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB7C942FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7227A1C219E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1661B14E9;
	Wed, 31 Jul 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9FK417R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92F1DA32;
	Wed, 31 Jul 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432094; cv=none; b=ekiLqTDy8GR9r/RsBAsnB+IuoBU6Xu9pUXyeGoV1S7rsjsVYZlv2Z5NVBvrcsSJm6Rnt/IAjypVW0gqyBOSCIhbTRtx9CzW2fCQutshEYFRvdJ25+TKEeV5vYl3MPfKtM81Z0ejgm+idHfE0uSnz6MganGkqkkSvpQKVrOMvNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432094; c=relaxed/simple;
	bh=4pKhzn3viZ4A2g7dqBTFjYMUfhTUiR+ezhfeiO/rQL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNtWirzpNCBXod1RRJ/EmXse9nAW6Zva7KCv+aMEsA7HqI3PqNjJ1LOBH0OmC38L62AxMioMJhpYb87CGttd0RqbSSxdHxAXSO/FdKcz5cv9QvkWYZLmFiJr3Jkkx4c8FgHf7FOAg5EnAjG5q8ZsWrw7zo3vEh6HTChYf2rFSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9FK417R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3B4C116B1;
	Wed, 31 Jul 2024 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722432093;
	bh=4pKhzn3viZ4A2g7dqBTFjYMUfhTUiR+ezhfeiO/rQL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9FK417RYzBCZgfHJ/rdRaiLwxrkrCRrsTMon5+7TW6cOOoa/sqxBWkVrZ83/ubC0
	 /2PbH4fH/h+PP0TFDFZG5AVsCFtayy50BkUaFhY8/DrxvckW2W9mvrj0DkTujeKqT1
	 O3WTMvEpLB9JUwzjqOSwtKD576XPbiMt+pYTSrUvOdd3kCrO0C3ZLkKyzuv2rSzVyB
	 k2HOR3ixbDImeSaN77tUNwsIdZzFv4ovGfJp6nZVOuxAxxeSU13odZrqO0npYYzdQy
	 TJ87BLcOw2iCt+xQlaHT6aHFWvzT0NbYMi3M/3bPjY1b2rvJGIq94bnrk4l/HEPqsk
	 q5A9OC6xS9D2g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sZ9Gy-000000000tq-2uQK;
	Wed, 31 Jul 2024 15:21:44 +0200
Date: Wed, 31 Jul 2024 15:21:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:USB SERIAL SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: Change usb_debug to not echo by default
Message-ID: <Zqo6aBRw15Rf_3Gh@hovoldconsulting.com>
References: <20240715104456.1814444-1-marmarek@invisiblethingslab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715104456.1814444-1-marmarek@invisiblethingslab.com>

On Mon, Jul 15, 2024 at 12:44:53PM +0200, Marek Marczykowski-Górecki wrote:
> This driver is intended as a "client" end of the console connection.
> When connected to a host it's supposed to receive debug logs, and
> possibly allow to interact with whatever debug console is available
> there. Feeding messages back, depending on a configuration may cause log
> messages be executed as shell commands (which can be really bad if one
> is unlucky, imagine a log message like "prevented running `rm -rf
> /home`").

This should not be an issue as canonical input is also enabled by
default (and as long as no one outputs random commands like that on a
single line).

> In case of Xen, it exposes sysrq-like debug interface, and
> feeding it its own logs will pretty quickly hit 'R' for "instant
> reboot".

But this sounds annoying enough.

> Contrary to a classic serial console, the USB one cannot be configured
> ahead of time, as the device shows up only when target OS is up. And at
> the time device is opened to execute relevant ioctl, it's already too
> late, especially when logs start flowing shortly after device is
> initialized.
> Avoid the issue by changing default to no echo for this type of devices.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>  drivers/usb/serial/usb_debug.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
> index 6934970f180d..91150c050637 100644
> --- a/drivers/usb/serial/usb_debug.c
> +++ b/drivers/usb/serial/usb_debug.c
> @@ -76,6 +76,11 @@ static void usb_debug_process_read_urb(struct urb *urb)
>  	usb_serial_generic_process_read_urb(urb);
>  }
>  
> +static void usb_debug_init_termios(struct tty_struct *tty)
> +{
> +	tty->termios.c_lflag &= ~ECHO;

I disabled echoing of newlines here as well when applying. Thanks.

Johan

