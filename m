Return-Path: <linux-kernel+bounces-556269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CB0A5C366
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67A71897C94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039025BAC8;
	Tue, 11 Mar 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="wQfCsdhL"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138E25B679
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702360; cv=none; b=YalRWmCri4qEZAtpN394R/2ISSNXjt1UJ1Ilaz8P1JXcQMmOayUL7EWgk3jfNvoAXHeCzA5rDsKz0ikOFnuJGa/0/ldGcisVx1LjSefcLegEZjrPqKmCts0LxoTYzOaUF0Qxf0s5HfWMCfTqmo6yp8vl2SxUzHPvyhygUn5AxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702360; c=relaxed/simple;
	bh=aSiRFGz9D35mrAPWQkuBnfHc989qYrNXBTYMoWctP7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTgOoFcrrjw1PVJHWTQoeLFPVgDzJOsIeR7lZSgvxMKT4s2sL5ODdO5fDqI2cAioHPNf3L0VWvYrfvW8yBaadutdQSodv8tYRbVnAI0ht3VoW4j0/CI09P6UFBk5vbFYXssqOzzi6Fa+Jmg/tLzPpUE1QnC5WPd/n2iihSijOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=wQfCsdhL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47662449055so16714761cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741702358; x=1742307158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqS90eFGJ7/q/06uqKRGMnqOqUkTAtZXlVsfnwLorTA=;
        b=wQfCsdhLiwERXFdv6X6BsxDRjN7B6y6gxFpkIbbfNEGZOn5ivp5LJ4GquzHbL3y0kg
         jZ2aACKE+SJts4+SV8yQbCbJFaqXrM8wMeAsXBQwl0CrYH1ULC9tUUBJGh5Dl+coQ1uT
         hl1KLrUZPnaT1PV7aX/2qqpkmeJxr7//Y/yyLsdYk0WsXQRphb45T9A4htaBOKCidDrK
         jE6RX/eTn49A8PpDf5np0hQwG6Yk0CdgSA/Iv3nsxTAff7G4ejg3e19F+0txXKH5XO+3
         BzZ/ZJJI+gZONWbKgyGwiKs6tReZb4DHwkAMDDJH81nRGZSXmq6jilOZHXHux1hTWFN2
         c4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702358; x=1742307158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqS90eFGJ7/q/06uqKRGMnqOqUkTAtZXlVsfnwLorTA=;
        b=aoB706pPBV18vFnFdewxdItFRs+90YJq6seAqii01CdqLv+00FI77qokozHqDu+HQ2
         qb9TntBiittq1JzBjGwhaIRtnf4OstEWXe1FG7b8sIS0yZ8stGvh4J+cGuvl6+JLLaTw
         OLe6NbT42Gr+HR9EqYiOKDWABzLhq9mzAlvShGTJnPbIggyS6yedZO0B/nq6hI8zUfzX
         S6d1KFHiuk9UIpnD4NdH/wTolHsnRMPec4oarFV3l/VxmIvaxfNXzJsYODdhRICAfRqi
         1eXIK8yugH6kCjr2tFQPnqg5BRogWgX1AQ0w3Ojxd+/7L+SWX0awS10kN8xAQFhrjxIj
         qRkA==
X-Forwarded-Encrypted: i=1; AJvYcCV6WCEVkjV8tb35t5l17/EJXN7eMr8FVmONKiwu2HNBCuI+7oiyTYEx9u7DVnmrIWTmyhaN2FVVcJ32hwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+2+iFVE4B0/cUwTniquYDwIHJceQF5Zrx8DrMRmT1+FErdta
	JjbHTO4DLjbKWJBksFH/mBaTweGUzaxTxGVVGtRZ9sf/CadCBZzdwf0PuPvHgw==
X-Gm-Gg: ASbGncsdIVrwZbaGY3Pw2n4AyOCy1tQcjRCqNvqWzKGqzeS7CdMwsa6FgRdyvHnBxjI
	cvRxmLotw2ITyGOY7dlVSdsEkTnFgz2fg4QQ6vofKyaWsSQpLUhEFbUh727WFWvPG50xtWukMTt
	CvsoXfCeZhAHami5YitEBfFEDmqCVW/hVr/NLyWwrzyui4Ocz39Voku7C5Jg0F+BV41OKs+Gs8/
	wePArLDGm1azsAPpH4DHeOjqYe4u/vWOotjdfFeiM99D5jd+AnbLBrpqdpRLteM2BUPR4c9WGLK
	LMmiPnWy4QN1FOIKRmDBGBGWL9gO4P6yvZ0akv9f5Sl5ZbdZCwK2uvF/e1zKI2M=
X-Google-Smtp-Source: AGHT+IG9OcRAVr85+6mryYW0AABpehp6sfpdYUxay7oilkgQGXomiBnCuZqNDdPtDuWmRcmZHyKWsw==
X-Received: by 2002:a05:6214:4113:b0:6e8:f60b:9bf8 with SMTP id 6a1803df08f44-6e9006c8774mr209755866d6.33.1741702357937;
        Tue, 11 Mar 2025 07:12:37 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf47sm73501706d6.25.2025.03.11.07.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:12:37 -0700 (PDT)
Date: Tue, 11 Mar 2025 10:12:35 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Xin Dai <daixin_tkzc@163.com>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: Fix `us->iobuf` size for BOT transmission
 to prevent memory overflow
Message-ID: <6a266eb7-0150-43e9-a712-b9e6fe8c71ea@rowland.harvard.edu>
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

There is no risk of memory overflow.  The length of the transfer for the 
CSW is limited to US_BULK_CS_WRAP_LEN, which is 13.  And the length of a 
CBW transfer is limited to US_BULK_CB_WRAP_LEN, which is 31 (or to 32 
if the US_FL_BULK32 quirk flag is set).  Therefore a 64-byte buffer is 
more than enough.

Alan Stern

