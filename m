Return-Path: <linux-kernel+bounces-545458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699D0A4ED67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B017A9841
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7A24C081;
	Tue,  4 Mar 2025 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeQAr1zO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969181F4722
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116817; cv=none; b=A12YCNYQTzMp4IlADmIEcLOtCMSGJazEscW62xMSbizBhFRyoXZCpROGRR/Rg/fKn0KF8Bi/7qlBWn9MMo4sBE+gjN3AgEstWVBva/zDnKSCL3VmpYNXilpgKMJyCzXOuAPUUHnZUeEx2IXVQX5Ocik5zwuLWaJQtbPnkQMFJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116817; c=relaxed/simple;
	bh=Fyz3JfHHOvuotSLhbCETLSUbx3X7uzkobiKMeoVFgUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkoZZ6dRFU/MVFeuPNzA3FdBnbzGd8E8Tf7BXPXlqLpveGFVVfq1YhVk2AT/DWSpBc6kXpeM9bfXFqkerV4oPSJFZWCMZb8NpPy4wXevDjhgwvq0Ib/jk2+JOkIBFK6KVfGDaVSCjD4y7ViovQ2MnqcQTWbPbVL9zmHejdUq/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeQAr1zO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2235025322fso11899295ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116815; x=1741721615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtIegLy+r+GMqADIrfnswa2mJO1assc6TIqGWvq1Thk=;
        b=LeQAr1zOXY79/K+1GB1zwA75oVdJUTnL4Vmo7XyEVQ1SIo6Ji4MrA1vafhsat044ym
         8UHWqL4leldfY1K332XOQVtV1B9CEGBaWvYo45TMb5AIKkFzixzC+pAqQ0zH4gZg/wS3
         87P2Wdf8wPI2zQ+fG80t18F6kxx52ixVcStiS817fauMo+IRTSZQD1zSFRa/ywrwIl78
         cif2teozPeN0o/rEK7hHaViHG+BsoYBya0OzI0nytY4GXSOsiFlHfF9rIUEKlIJj6piM
         lzAFIYG1WddQvhD08o3fhpSRRw21SoARrg+wLqW9bL3eRnkuTrpikDllTfxfx2YBHYFC
         tjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116815; x=1741721615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtIegLy+r+GMqADIrfnswa2mJO1assc6TIqGWvq1Thk=;
        b=e2pB9X0AmZk17BRDcxolrcFTzfw0s89KaxS8iTXCD3vsWJNznfLvy2HKm0QvXtDsf+
         Exp1A1dDJNuJcMsYbgzXg67b71/mwGcU7CHQFWvXlHHZ1Sk64WNShNc7liexne31R73h
         PyWCwi/Ug82QE+DYO7Dkq0QEdrzu+pr0kBz27xUPVVdxmayFRcl/I39AyEvo8wmHmRJk
         RXU1bHkY8Ul6VgItZn4TO1mVv6oFZ31IX8dqxiFrXT3X4mk1E8048kCSlKKpGwdUEzzy
         0JAJSd/s9VnPzQnsY2SFd/ksOu/gri5A7GxXhx0UdohjuUP4iV18dQueBoETwV0f0jRk
         y46g==
X-Forwarded-Encrypted: i=1; AJvYcCVIAcYYwgMEUMEm3hMWL3gkitGyhsepl4mR3l8qiqTEquJhSOG4oNAFt9f1/BkpfJLZHABZDUjfTk1b4oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNyDnkxM36bYTb6iXS4cxzrgCbe2/rbXFt7NWDIRMbDUq1k7Da
	a0H4lHMqefCN9CNuCfBUSrq3fqrH8+UTOa5cJVAPoB3P5XpZGE9z
X-Gm-Gg: ASbGncucR4WrbXgbnomN/CnbqXsBUXRw61vwH/jhZ8YXPVUrkhBoYFLSa8Sr0uZx9xw
	zxqdmFKLZk/np1n8BrY2QCTa/JqlSvlEU5ujlVG/1za4ajpGlN6AVtGbQ9NJvGoPQnZvaC56ARQ
	pqD44efufjTpkd5ehVMvYQ7Zt4huz/RnnLXCjb/LPVzG4CEyInfOpwQ3CuSWSUS9aUtzDfNrJtp
	mgvok9Ns1gMM/OewqCzanTR1SUYb0slpcHmyM38/L2nJfqC+hhNPeupEa8+rgQscHcbQqslgQR6
	/HYDy8KDkFo5EORFzhubhlFHduNkWpBG2zWyvpunAHg1oS8wfo3jVqk/31R5uJ4m3X6DuiXKorI
	=
X-Google-Smtp-Source: AGHT+IGOO8Q+oMRYcQBpw0l9B2qNi9FXTCKn0LBXiMRpfwxOYA9XY/0EpSQI8e4oPMFBQPO2/mpoiw==
X-Received: by 2002:a17:902:ea05:b0:215:8721:30b7 with SMTP id d9443c01a7336-223f1d33a9dmr2163445ad.11.1741116814849;
        Tue, 04 Mar 2025 11:33:34 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 ([2802:8012:1f:3200:f1d1:c186:ba5b:8f06])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003dd19sm11660791b3a.131.2025.03.04.11.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:33:34 -0800 (PST)
Date: Tue, 4 Mar 2025 16:33:09 -0300
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, 
	dan.carpenter@linaro.org, arnd@arndb.de, niharchaithanya@gmail.com, 
	jiapeng.chong@linux.alibaba.com, linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: Re: [PATCH 3/4] staging: gpib: fix kernel-doc section for
 usb_gpib_line_status() function
Message-ID: <mcagpfhzrwlvys76ketpo33l5yn2ij2csshrzz3tgufrdr5lg3@i4nmisbi3l6f>
References: <20250304192603.40565-1-gascoar@gmail.com>
 <20250304192603.40565-7-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304192603.40565-7-gascoar@gmail.com>

On Tue, Mar 04, 2025 at 04:25:41PM -0300, Gaston Gonzalez wrote:
> The function name field in the kernel-doc section for the
> usb_gpib_line_status() is defined as 'line_status'. In addition, after
> the kernel-doc section, there are three macro definition instead of the
> function definition.
> 
> These issues trigger the warning:
> 
> warning: expecting prototype for line_status(). Prototype was for WQT()
> instead.
> 
> Fix the warning by renaming the function in the kernel-doc section and
> by moving the macros at the beginning of the file with the rest of
> macros definition.
> 
> Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> ---
>  drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> index 090857824d07..f7dd0809b06c 100644
> --- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> +++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> @@ -78,6 +78,10 @@ module_param(debug, int, 0644);
>  			dev_dbg(board->gpib_dev, format, ## __VA_ARGS__); } \
>  	while (0)
>  
> +#define WQT wait_queue_entry_t
> +#define WQH head
> +#define WQE entry
> +
>  /* standard and extended command sets of the usb-gpib adapter */
>  
>  #define USB_GPIB_ON	 "\nIB\n"
> @@ -131,6 +135,7 @@ module_param(debug, int, 0644);
>  
>  #define INBUF_SIZE 128
>  
> +

Please disregard this patch. I noticed this blank line after I sent the
patch.

Will resend.

Gaston


>  struct char_buf {		/* used by one_char() routine */
>  	char *inbuf;
>  	int last;
> @@ -644,17 +649,12 @@ static void usb_gpib_interface_clear(gpib_board_t *board, int assert)
>  }
>  
>  /**
> - * line_status() - Read the status of the bus lines.
> + * usb_gpib_line_status() - Read the status of the bus lines.
>   *
>   *  @board:    the gpib_board data area for this gpib interface
>   *
>   *    We can read all lines.
>   */
> -
> -#define WQT wait_queue_entry_t
> -#define WQH head
> -#define WQE entry
> -
>  static int usb_gpib_line_status(const gpib_board_t *board)
>  {
>  	int buffer;
> -- 
> 2.49.0.rc0
> 

