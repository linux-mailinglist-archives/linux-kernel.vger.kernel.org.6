Return-Path: <linux-kernel+bounces-274250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7449475A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909551F216F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEF148FED;
	Mon,  5 Aug 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0buGd8nR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C41109;
	Mon,  5 Aug 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841316; cv=none; b=S3CWpcNjAxhUrFigi5ggl7FJX0p4+4EivEYyh/kIG3awlbDj8bkBKIzNHLjYbS8GotcFRHdeKceJec5S9PQTjGhG1dxsGsTj7Sd/6mlgNDmatnTUBPm6hkt3bpIXCTleAT6Rr7CZL0A3UPwxj4SrUEn/g8HpP0RDzR5o+38m36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841316; c=relaxed/simple;
	bh=4QoMugMLw5W2gcbxvuUgAl8QFQMNiCPWsKLkbOyrOLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3U5i5vL4jdvNYrcVsdACDTNO8tD8LAnlV98SrHzoAZrvJFwE2iKBnA1C+fvMNsh2OyfexjnmpEeutzke4QZjqPDyFHqCyL8p7ybpJgVoy3BtCrycSK6MbR8VHeehyVsyoqJ39as342xWmGM6Ku4TI5c3qhIAf+3cCCmO/b65eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0buGd8nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C649C32782;
	Mon,  5 Aug 2024 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722841315;
	bh=4QoMugMLw5W2gcbxvuUgAl8QFQMNiCPWsKLkbOyrOLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0buGd8nRim4xJJhU+SHdKlM4+iHzqXu31nY2OG4VJIJzXv5bWLETiaXS0EjKKZXfr
	 iyRHzEJq2x+xdkvQPTQrOe/mVGp4ctLU81iiBG28BaJ1Ygr8I+6WUlHB6xOSxrfug3
	 0bbNGBVHxFZ/LY/vRh095nwXhtMyuK8/UYjQeW2U=
Date: Mon, 5 Aug 2024 09:01:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: crwulff@gmail.com
Cc: linux-usb@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Cercueil <paul@crapouillou.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Farman <farman@linux.ibm.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Sands <david.sands@biamp.com>
Subject: Re: [PATCH v4] usb: gadget: f_fs: add capability for dfu run-time
 descriptor
Message-ID: <2024080516-flatness-humorous-03ca@gregkh>
References: <20240805000639.619232-2-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805000639.619232-2-crwulff@gmail.com>

On Sun, Aug 04, 2024 at 08:06:40PM -0400, crwulff@gmail.com wrote:
> From: David Sands <david.sands@biamp.com>
> 
> From: David Sands <david.sands@biamp.com>

Twice?

> Add the ability for FunctionFS driver to be able to create DFU Run-Time
> descriptors.

As others said, please spell out "DFU" and I do not think that
"Run-Time" needs Capital letters, or a '-', right?

Also include here a lot more description of how this is to be used.

> 
> Signed-off-by: David Sands <david.sands@biamp.com>
> Co-developed-by: Chris Wulff <crwulff@gmail.com>
> Signed-off-by: Chris Wulff <crwulff@gmail.com>
> ---
> v4: Clean up unneeded change, switch to BIT macros, more documentation
> v3: Documentation, additional constants and constant order fixed
> https://lore.kernel.org/all/CO1PR17MB54197F118CBC8783D289B97DE1102@CO1PR17MB5419.namprd17.prod.outlook.com/
> v2: https://lore.kernel.org/linux-usb/CO1PR17MB54198D086B61F7392FA9075FE10E2@CO1PR17MB5419.namprd17.prod.outlook.com/
> v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419AC3907C74E28D80C5021E1082@CO1PR17MB5419.namprd17.prod.outlook.com/
> ---
>  Documentation/usb/functionfs-desc.rst | 22 ++++++++++++++++++++++
>  Documentation/usb/functionfs.rst      |  2 ++
>  Documentation/usb/index.rst           |  1 +
>  drivers/usb/gadget/function/f_fs.c    | 12 ++++++++++--
>  include/uapi/linux/usb/ch9.h          |  8 ++++++--
>  include/uapi/linux/usb/functionfs.h   | 25 +++++++++++++++++++++++++
>  6 files changed, 66 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/usb/functionfs-desc.rst
> 
> diff --git a/Documentation/usb/functionfs-desc.rst b/Documentation/usb/functionfs-desc.rst
> new file mode 100644
> index 000000000000..73d2b8a3f02c
> --- /dev/null
> +++ b/Documentation/usb/functionfs-desc.rst
> @@ -0,0 +1,22 @@
> +======================
> +FunctionFS Descriptors
> +======================
> +
> +Interface Descriptors
> +---------------------
> +
> +Standard USB interface descriptors may be added. The class/subclass of the
> +most recent interface descriptor determines what type of class-specific
> +descriptors are accepted.
> +
> +Class-Specific Descriptors
> +--------------------------
> +

Why an empty section?

> +DFU Functional Descriptor
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When the interface class is USB_CLASS_APP_SPEC and  the interface subclass

Extra space?


> +is USB_SUBCLASS_DFU, a DFU functional descriptor can be provided.

Provided how?

> +
> +.. kernel-doc:: include/uapi/linux/usb/functionfs.h
> +   :doc: usb_dfu_functional_descriptor
> diff --git a/Documentation/usb/functionfs.rst b/Documentation/usb/functionfs.rst
> index d05a775bc45b..4f96e4b93d7b 100644
> --- a/Documentation/usb/functionfs.rst
> +++ b/Documentation/usb/functionfs.rst
> @@ -70,6 +70,8 @@ have been written to their ep0's.
>  Conversely, the gadget is unregistered after the first USB function
>  closes its endpoints.
>  
> +For more information about FunctionFS descriptors see :doc:`functionfs-desc`
> +
>  DMABUF interface
>  ================
>  
> diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
> index 27955dad95e1..826492c813ac 100644
> --- a/Documentation/usb/index.rst
> +++ b/Documentation/usb/index.rst
> @@ -11,6 +11,7 @@ USB support
>      dwc3
>      ehci
>      functionfs
> +    functionfs-desc

That's an odd name for a DFU-specific file, right?

Where are the Documentation/ABI/ entries?

>      gadget_configfs
>      gadget_hid
>      gadget_multi
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index d8b096859337..ba5c6e4827ba 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -2478,7 +2478,7 @@ typedef int (*ffs_os_desc_callback)(enum ffs_os_desc_type entity,
>  
>  static int __must_check ffs_do_single_desc(char *data, unsigned len,
>  					   ffs_entity_callback entity,
> -					   void *priv, int *current_class)
> +					   void *priv, int *current_class, int *current_subclass)
>  {
>  	struct usb_descriptor_header *_ds = (void *)data;
>  	u8 length;
> @@ -2535,6 +2535,7 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
>  		if (ds->iInterface)
>  			__entity(STRING, ds->iInterface);
>  		*current_class = ds->bInterfaceClass;
> +		*current_subclass = ds->bInterfaceSubClass;
>  	}
>  		break;
>  
> @@ -2559,6 +2560,12 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
>  			if (length != sizeof(struct ccid_descriptor))
>  				goto inv_length;
>  			break;
> +		} else if (*current_class == USB_CLASS_APP_SPEC &&
> +			   *current_subclass == USB_SUBCLASS_DFU) {
> +			pr_vdebug("dfu functional descriptor\n");
> +			if (length != sizeof(struct usb_dfu_functional_descriptor))
> +				goto inv_length;
> +			break;
>  		} else {
>  			pr_vdebug("unknown descriptor: %d for class %d\n",
>  			      _ds->bDescriptorType, *current_class);
> @@ -2621,6 +2628,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
>  	const unsigned _len = len;
>  	unsigned long num = 0;
>  	int current_class = -1;
> +	int current_subclass = -1;
>  
>  	for (;;) {
>  		int ret;
> @@ -2640,7 +2648,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
>  			return _len - len;
>  
>  		ret = ffs_do_single_desc(data, len, entity, priv,
> -			&current_class);
> +			&current_class, &current_subclass);
>  		if (ret < 0) {
>  			pr_debug("%s returns %d\n", __func__, ret);
>  			return ret;
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index 44d73ba8788d..91f0f7e214a5 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -254,6 +254,9 @@ struct usb_ctrlrequest {
>  #define USB_DT_DEVICE_CAPABILITY	0x10
>  #define USB_DT_WIRELESS_ENDPOINT_COMP	0x11
>  #define USB_DT_WIRE_ADAPTER		0x21
> +/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
> +#define USB_DT_DFU_FUNCTIONAL		0x21
> +/* these are from the Wireless USB spec */
>  #define USB_DT_RPIPE			0x22
>  #define USB_DT_CS_RADIO_CONTROL		0x23
>  /* From the T10 UAS specification */
> @@ -329,9 +332,10 @@ struct usb_device_descriptor {
>  #define USB_CLASS_USB_TYPE_C_BRIDGE	0x12
>  #define USB_CLASS_MISC			0xef
>  #define USB_CLASS_APP_SPEC		0xfe
> -#define USB_CLASS_VENDOR_SPEC		0xff
> +#define USB_SUBCLASS_DFU			0x01
>  
> -#define USB_SUBCLASS_VENDOR_SPEC	0xff
> +#define USB_CLASS_VENDOR_SPEC		0xff
> +#define USB_SUBCLASS_VENDOR_SPEC		0xff
>  
>  /*-------------------------------------------------------------------------*/
>  
> diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/usb/functionfs.h
> index 9f88de9c3d66..40f87cbabf7a 100644
> --- a/include/uapi/linux/usb/functionfs.h
> +++ b/include/uapi/linux/usb/functionfs.h
> @@ -37,6 +37,31 @@ struct usb_endpoint_descriptor_no_audio {
>  	__u8  bInterval;
>  } __attribute__((packed));
>  
> +/**
> + * struct usb_dfu_functional_descriptor - DFU Functional descriptor
> + * @bLength:		Size of the descriptor (bytes)
> + * @bDescriptorType:	USB_DT_DFU_FUNCTIONAL
> + * @bmAttributes:	DFU attributes
> + * @wDetachTimeOut:	Maximum time to wait after DFU_DETACH (ms, le16)
> + * @wTransferSize:	Maximum number of bytes per control-write (le16)
> + * @bcdDFUVersion:	DFU Spec version (BCD, le16)
> + */
> +struct usb_dfu_functional_descriptor {
> +	__u8  bLength;
> +	__u8  bDescriptorType;
> +	__u8  bmAttributes;
> +	__le16 wDetachTimeOut;
> +	__le16 wTransferSize;
> +	__le16 bcdDFUVersion;
> +} __attribute__ ((packed));
> +
> +/* from DFU functional descriptor bmAttributes */
> +#define DFU_FUNC_ATT_CAN_DOWNLOAD	BIT(0)
> +#define DFU_FUNC_ATT_CAN_UPLOAD		BIT(1)
> +#define DFU_FUNC_ATT_MANIFEST_TOLERANT	BIT(2)
> +#define DFU_FUNC_ATT_WILL_DETACH	BIT(3)

Wrong macro for bit fields for uapi .h files :(

thanks,

greg k-h

