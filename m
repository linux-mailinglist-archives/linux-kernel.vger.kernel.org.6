Return-Path: <linux-kernel+bounces-417380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12449D5338
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7785D2822E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3D31CB331;
	Thu, 21 Nov 2024 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOuF3T5G"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C021C8315
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215342; cv=none; b=NLdBd6XSn9yAT38bQ++gRTDu3YH1z8trsQcQ/PWVhu7xhM1/8TdaeIgVzU4TgdKYGOQg43EPHVUeLTW8Y35Nw+AiFs7mzFkNFKN8xA4/N/2WRXfuHA8zqeT8sd5uXRDFZYMcI7HQdatUqbstmw/MsJTAXDLLvE7sMON4EwBrnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215342; c=relaxed/simple;
	bh=utNGoZkjgvglt/ZQDAjDh2iz+WWusLLFgdqTAHc9ZcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEiHoD9JittaiQtj7m+w1fL4xhflW3PJpjzjSM6VclCXhaNMupxxHip373y35NCAdYEShIYeZXn6bE0krXiOXyM26dd1KfmkXMu2oeEGaQfFFUZlCnzhbpjVFFRxnjRhRxkLlCDXHsrM9SOhBMwsMlGBB9TxC/BgTLZkum+oDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOuF3T5G; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so10731425e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732215338; x=1732820138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzzPxQcvikn1NUF9cz7KZrPBlQYcHbkUU7Sgh4Ie0Vc=;
        b=HOuF3T5GF/Y7HcLIqq+mNLznyqJnDnVPuYEkDn8/pyefKbBweUFDaQWNDINgDku/9B
         gi1b3rK7a0IWFrg56TSTMl9PYsyZMn83V+LaOCdQTKn0tQLVVsjOAsUg/C+7r2OQ616b
         kuciKMR16CzDhnpjjDn9y7RmgMgudpa5+FuL74nsxjz7gOa/0m+EpfWwdc/ManOe1oDw
         SvPSKXfz4Y8g+j8odZ5wWbfbmompZmcRukBnrg59o6tQ6l4bWh9y8VGmt/3N0WzqFkJ1
         XjXKOmSn+12sMx5SZcyOat7uXs+hMrbRVTif7rdtDSuM1Tz+H8EkjhD3Ti1M8AuMUuYY
         0mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215338; x=1732820138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzzPxQcvikn1NUF9cz7KZrPBlQYcHbkUU7Sgh4Ie0Vc=;
        b=Isz+oAIblreadYn35+LGE4mr8C6oWphp32J+hcsppSPJ27FpxV/xDkqQXRrxcHTXdl
         c1fZLMhgL5S67WTeJjIu+oYfPwfjsPP9TG1OZFV5mniYdEt9DmaLFYUgqtTT0U2AuGII
         m1S27btHabUm9yuMPKLtPVm+X5vpGslC3JeHEMr67IYnjJvhfeY3tcbH4qBfUbpJhDS5
         U6yd9yzp4DyrEUpaX//ouYD+IKfnlD1MB5btNsw8/kljjC+VCv6ebVb+VTXGMFSaIb4A
         iuHYWu4rtb4hdRK36R287Zu+r3ILHOoGvyppiB9RlbyOX3/iesjEO+j4tIuHVu4LxF+y
         bjEg==
X-Forwarded-Encrypted: i=1; AJvYcCV0TlmJmFhmb26RzqMEXwbg56iOZ6pjjE+NDCrugyNbQLRetlSLGKkeOLPY4F2X/uhlM2pj7nd08zhBY+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAv9LuQ/XWFq2KwN34wJK5L9CcZzflZPsQdPItLHor3rBfTEUj
	MSU4MSJCcTLWzXD1pxDxviE2SdTdo2++MRxHUfTTUtTnJeG/oy4MQkrnPTkafqA=
X-Gm-Gg: ASbGnctiwOtbxeoRxbgDxGCi+mJ79PClE/dkVOLEymvqXezOUp7WXtMPh91D9iC5wtC
	RtfLy3imy6VlsQap1hGei6CwctTRG+bpeLkFHui2P5HSF1aQUCmdRkveM/25JtUzH9FPbCVf8/g
	eI1mOAnacLIGG8oUvGkHbyqLq4rKyeBIR9C7StKqe4bOfcoBmnia4+k3L7PavfQfr2u5+hl7Cft
	kDUutHEp84EXfBXJnbuPDLbth/AJh/3fmv0YjDFJwmUb52Z0GlG0e4=
X-Google-Smtp-Source: AGHT+IFmXIVpqP3HqT9KlJLNs+gw8NPLRwz++A/b/6fhrRW6TBSJRYOt2LadxPAG05FPEhMGpniIPg==
X-Received: by 2002:a05:600c:3585:b0:432:c774:2e24 with SMTP id 5b1f17b1804b1-433489b2389mr71992225e9.9.1732215337852;
        Thu, 21 Nov 2024 10:55:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde8c8c8sm1441095e9.34.2024.11.21.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:55:37 -0800 (PST)
Date: Thu, 21 Nov 2024 21:55:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Perego <pperego@suse.de>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Bakker <kees@ijzerbout.nl>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] staging:gpib: Fix a dereference before null check
 issue
Message-ID: <dcefdd75-643f-4492-9e65-8b289cbf418e@stanley.mountain>
References: <20241121152221.6415-1-pperego@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121152221.6415-1-pperego@suse.de>

On Thu, Nov 21, 2024 at 04:22:21PM +0100, Paolo Perego wrote:
> This commit fixes a dereference before null check issue discovered by 
> Coverity (CID 1601566).
> 
> The check at line 1450 suggests that a_priv can be NULL, however it has
> been dereferenced before, in the interface_to_usbdev() call.
> 
> After a discussion, the NULL check is useless because private data is allocated
> in attach routine and freed in detach routine, so in detach routine the pointer
> has to be not NULL for sure.
> 
> Signed-off-by: Paolo Perego <pperego@suse.de>
> Fixes: Removes a useless NULL check

This isn't how the Fixes tag works.  It's supposed to refer to the patch which
introduces the static checker warning.
Fixes: fbae7090f30c ("staging: gpib: Update messaging and usb_device refs in agilent_usb")

The patch has a couple checkpatch issues as well.  Please, fix those up and
resend.

regards,
dan carpenter


