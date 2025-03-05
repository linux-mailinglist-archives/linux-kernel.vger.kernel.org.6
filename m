Return-Path: <linux-kernel+bounces-547023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595B2A501D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2EF7A3DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB424C09D;
	Wed,  5 Mar 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIfVq7Zz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D124BD03;
	Wed,  5 Mar 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184697; cv=none; b=n1sKjn1mTYaPoWKILJRcJUTEQNquvyhF2XYKexOFCBx9wKXdrBT1VN5hmTUUTIcvEUy9z86LVY9kKPZE9ff/wADEdOCXPoANo83Wn6k7t8tENzaO/uHstL6xUWYQdkvAYlgWCUDWnNUFcfu1qfHKz5P3t9Wjd/Na9QA3B3mua88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184697; c=relaxed/simple;
	bh=RdrC8JpMPbq4iRjfidFPlFhX8tB6nCx0HHU1SIDbDz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM2oSsTEOhYuytci6AwbvGhW+qBMB3qptafgur6afVnXH0Z/6fzppumfgrE++xyrLjQ9OBXrk3tLRNOs0FS/e6X1Ip7D4KIjR1V1H1NNIAo8XhhgKXEq5a0FYaeC24QfaC5Uz1dSEoV8x2gRsQey/N5paj0QcwjPwNwk3d0L9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIfVq7Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E68C4CED1;
	Wed,  5 Mar 2025 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741184696;
	bh=RdrC8JpMPbq4iRjfidFPlFhX8tB6nCx0HHU1SIDbDz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIfVq7ZzLZ/U+V/zRiI+W00RHdKb1L3HG3gEObvHZt0fgg7u8Ww8FDGAkM0bJGHWv
	 KWNLwAG2xqWvdRoiTKjEa8Nx+qSXFXfnAlkdlESje7Y0epYxSwZiTn/ovQd9Wy3/XW
	 xPA8Aeg6zBBpS2yLFwuXhckJju9oMD2yJv6uoK1g8v2ciF5R2xfjPdSPrkdF5hl3+W
	 Q0YgE/8aXq0eXfMtQdZ5O9PrxYNYR3zsNQs87C2oK3KbryLi0wOUjn3LPTNVyxlPfE
	 vt9LzSgIWqiGHpNRYnX6ueR+WgCm2v0kaHvRedTb+oQxayq5FH8i7diyPhew/TbTa0
	 0yEr550bLUsFw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tppg5-000000002m1-2owT;
	Wed, 05 Mar 2025 15:24:53 +0100
Date: Wed, 5 Mar 2025 15:24:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Boon Khai Ng <boon.khai.ng@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tien Sung Ang <tien.sung.ang@intel.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <Z8hetcRinFXXVAdy@hovoldconsulting.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203084822.18356-1-boon.khai.ng@intel.com>

On Mon, Feb 03, 2025 at 04:48:22PM +0800, Boon Khai Ng wrote:
> The Altera on board USB Blaster 3 utilizes a FT2232 and FT4232
> chip.

I assume it's either an FT2243 or an FT4232 and not both?

> Add VID/PID for the on board USB Blaster 3 so it can be used
> as a serial device via ftdi_sio.

Can you say something more about these devices? I guess they are used
for programming FPGAs? Are they embedded in other products? And can the
same PID be used for more than one type of device that they are embedded
in?

Or are the PIDs tied to different types of "USB Blaster 3"s? If so this,
should also be reflected in the naming of the defines.

> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> ---
>  drivers/usb/serial/ftdi_sio.c     | 14 ++++++++++++++
>  drivers/usb/serial/ftdi_sio_ids.h | 13 +++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index e07c5e3eb18c..3edce9c62213 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1079,6 +1079,20 @@ static const struct usb_device_id id_table_combined[] = {
>  		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
>  	/* GMC devices */
>  	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
> +	/* Altera USB Blaster 3 */
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_6022_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_6025_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_6026_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_6026_PID, 3) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_6029_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602A_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602A_PID, 3) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602C_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602D_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602D_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602E_PID, 1) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602E_PID, 2) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(ALTR_UB3_VID, ALTR_UB3_602E_PID, 3) },
>  	{ }					/* Terminating entry */
>  };
>  
> diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
> index 5ee60ba2a73c..673e0cf84bdc 100644
> --- a/drivers/usb/serial/ftdi_sio_ids.h
> +++ b/drivers/usb/serial/ftdi_sio_ids.h
> @@ -1612,3 +1612,16 @@
>   */
>  #define GMC_VID				0x1cd7
>  #define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
> +
> +/*
> + *  Altera USB Blaster 3 (http://www.altera.com).
> + */
> +#define ALTR_UB3_VID			0x09fb

This is a generic Altera VID so should just be name ALTERA_VID.

> +#define ALTR_UB3_6022_PID		0x6022
> +#define ALTR_UB3_6025_PID		0x6025
> +#define ALTR_UB3_6026_PID		0x6026
> +#define ALTR_UB3_6029_PID		0x6029
> +#define ALTR_UB3_602A_PID		0x602A
> +#define ALTR_UB3_602C_PID		0x602C
> +#define ALTR_UB3_602D_PID		0x602D
> +#define ALTR_UB3_602E_PID		0x602E

Please use lower case hex notation consistently for the values here.

But depending on the answer to my questions above, either these defines
should be renamed to reflect the Blaster type or product they are part
of, or just be dropped.

Johan

