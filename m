Return-Path: <linux-kernel+bounces-555617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51164A5BA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D9A3AB03B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1952236F7;
	Tue, 11 Mar 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSZaGWjb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5111386DA;
	Tue, 11 Mar 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679890; cv=none; b=DLYESjsl0EEKnCK4evsSMffyPOGLulQ66Ucn+4nPmGcpdguIBmngBWHkkSfe/WyZAgqlgasl+n6+uY1gpuznzuiY06krT6aU9XoKBKbLylNWWqjd5+BjPamHCbvTQhUhJQcIXGALZ/91FenHwqlkqHC2bifAv2H9hYsRX2mUkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679890; c=relaxed/simple;
	bh=2WbVJoFf68m1W0NkgahgwhwEdneyV1dwcI0GcRVm4kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH7okryve5O57vdiSk5MZ34/0fC5wxkvBMp3eqwUAhorf3fCwAu+7bo+AZRBHI+2svtlb7t8Wch/asBxM18ZM/8Lj+eLBUeSCjO4GgIlN/1EEpKeXaXOx0BMeD4j1PRfTsUuafhSf7On+KQ3U0CO6VH9MLNws1VbsLLyKWcnCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSZaGWjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC6DC4CEE9;
	Tue, 11 Mar 2025 07:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741679889;
	bh=2WbVJoFf68m1W0NkgahgwhwEdneyV1dwcI0GcRVm4kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSZaGWjbz6+Vx96JFfeyErCOa+yl//QyJzpD0Mp8W5DnKHg7gbfBvXOmJLLs74Qcd
	 8+pCaB/J0hfNNeZKNqNyksuXtfrNe8vDeNOSBRjr3SAR78lff3ofPV9ZAMDqLSSZEl
	 dNoMK5zyu2mOyJqVyIlkd8EUd90vN18MWRmxwsp0S99VMoKnYQWFQ+xVz5qSWQklt9
	 +x3IeXPiXTiZ+b4zb5mUsmvCPunJDBZDnHx1e5J3XX3bYrIgq2lgbSIuTrAsBLVD4J
	 T+dkCWcdHaWx8jZkAVKJ/C2iscasW4MavhbXpiJY2BeWqrhnk7NH7HWl9lJ2keEvqp
	 7swMtzt8AJt5A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1truV2-000000003vJ-0yFg;
	Tue, 11 Mar 2025 08:58:04 +0100
Date: Tue, 11 Mar 2025 08:58:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Boon Khai Ng <boon.khai.ng@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>
Subject: Re: [PATCH v2] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <Z8_tDGssqs9DBaPU@hovoldconsulting.com>
References: <20250307154355.30772-1-boon.khai.ng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307154355.30772-1-boon.khai.ng@intel.com>

On Fri, Mar 07, 2025 at 11:43:55PM +0800, Boon Khai Ng wrote:
> The Altera USB Blaster 3, available as both a cable and an on-board
> solution, is primarily used for programming and debugging FPGAs.
> 
> It interfaces with host software such as Quartus Programmer,
> System Console, SignalTap, and Nios Debugger. The device utilizes
> either an FT2232 or FT4232 chip.
> 
> Enabling support for various configurations of the USB Blaster 3
> by including the appropriate VID/PID pairs, allowing it to function
> as a serial device via ftdi_sio. The configurations are determined
> by the hardware design and include:
> 
> 1) PID 0x6020, FT2232, 1 JTAG port
> 2) PID 0x6021, FT2232, 2 JTAG ports
> 3) PID 0x6022, FT2232, 1 JTAG port + Port B as UART
> 4) PID 0x6023, FT2232, Cable USB-Blaster 3
> 5) PID 0x6024, FT4232, 1 JTAG port
> 6) PID 0x6025, FT4232, 1 JTAG port + Port C as UART
> 7) PID 0x6026, FT4232, 1 JTAG port + Port C, D as UART
> 8) PID 0x602e, FT4232, 1 JTAG port + Port B, C, D as UART
> 
> These configurations allow for flexibility in how the
> USB Blaster 3 is used, depending on the specific needs of the
> hardware design.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> ---

Thanks for the update, I've applied this one now.

But for your future contributions, remember to put a short changelog
here under the cut-off (---) line when revising patches.

>  drivers/usb/serial/ftdi_sio.c     | 14 ++++++++++++++
>  drivers/usb/serial/ftdi_sio_ids.h | 13 +++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index e07c5e3eb18c..9b34e23b7091 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1079,6 +1079,20 @@ static const struct usb_device_id id_table_combined[] = {
>  		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
>  	/* GMC devices */
>  	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
> +	/* Altera USB Blaster 3 */
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6022_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6025_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 3) },

> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6029_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 3) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602C_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 2) },

These configurations were not mentioned in the commit message. Are they
also used for embedded designs?

> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
>  	{ }					/* Terminating entry */
>  };

Johan

