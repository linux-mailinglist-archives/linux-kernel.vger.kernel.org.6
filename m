Return-Path: <linux-kernel+bounces-249386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795FE92EAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA821F224CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9AB16A382;
	Thu, 11 Jul 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="iD9gWC1G"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595D5477A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708916; cv=none; b=J/SxqBoh1K3Kiwrwq76WRGWnZh3WXjO05qVU655ypL4tUIr2qdPJG21KwrX2KiUT9HwIQBzz/JMLQkFArHWnTxUvfxWio8LqomRo17cOJAYE5FBCYhU3pm3QUTV8e55XAsBVVaPwEW40SMYRp/vcXTkp4VMDil0cDVnEL3PravA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708916; c=relaxed/simple;
	bh=bumUfNtZX7zKc1PGX2lQso+2aukmr1DgKwJdGhViIm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG2U4fSk5E3+bKcpkoo8pAjHiBVOYzGvXPH1uYxqKv0v6IOvN2oo4AAGEmZBPy6ot4bopX5P6Jho1e07SI36X+g8NU66jWH+DfLRurUykunsRAh3uWVZ0aqzgzhA1503lkIANL8imXfHNdDYL1PgDqJZJj1jLSQ1BNxwxMKRYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=iD9gWC1G; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7035c367c4cso545783a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1720708913; x=1721313713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn5M1hLYtpFruiWyFR2wbyMwFhBFuceObgrjMoeSEWY=;
        b=iD9gWC1GpJVV8Ri4G3HpL+H4wQ/Tfbhk4zOoY3DilcjEaZqgAshxXTDI/s87AioflT
         EQsfPCf8ZNIlTe4HtljrfpFlUO5RiTF+XNvT/2zFk+c+eB9Ov7JV7gjSUyF7p102xo8u
         Ik6PYgq+WyXmktDI7d/h9IuLnOuo7pHhW5xkdKdxsSsuIyjF44IShnsW2J/QTnt75quK
         agMX6OmucLYC/maO2UF+y/AcaBBMMqtMwqI60cvBv56wqHPCzsamoJSs6a0ZuzKbU5Dm
         waqqyvB4tv0ZUpWx9Nk2Ev7L4iiP9HvpREweSB1P01UjVF82YhlyX9jNnkduc72BNx/u
         TqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708913; x=1721313713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn5M1hLYtpFruiWyFR2wbyMwFhBFuceObgrjMoeSEWY=;
        b=pUiTDBy8V/9LM/EH6XfMryp8ardKfVrv7DNAEIBc/IySH99sm07HOe0WRTwSH+jcVA
         Mn6IWZMvvyUxW2lmamgLwF1v8raaZy9hSqIi3LAms1COKHvqRCIvv0cKTdGuT79e1sz0
         qir/e33WD1G0Y9lbZH8kM2tdkvLR/vXniCDcCr4I6Usvlu8bdI4xNQvCsaSS1EEod5FQ
         K0YwvrwpLQ3plpb1TM5D/oO/MS454z6UOSdmEWyArntDcDmr4hhJuRqWyRobaxI3rrKP
         mN3d5/7onJQHw+dilYKiyy5za75/8BhDCx97CrxQViuCNaj6hhUfNKJEmEMjIu2ezcsC
         tQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUJK9M4tlRJfhotZWv73tu4OidpQd3/dpeErOO7rsV498Em67qOBoo0s2Pb/7EGmlBxLMMM1mq9+smVzB4ICDtMfmQbUxguW2kpy7tP
X-Gm-Message-State: AOJu0YyS1KKUD78m5qBhbrzFQvgXdqfyyzzdOwvRn8ujLoIYGto1foCS
	oVxKYUQTCxFqzgcbmtD8249BX9kpSX+Mt60SX2qCq2D/IJpLYNLlvzk2aN7iXw==
X-Google-Smtp-Source: AGHT+IE7angxxeLKZr6AHNasAGDfXEnzNLp3R8D/Daoxso2P5Y9YKBHJIk5rV/6aHJBt5fVOr9/wkw==
X-Received: by 2002:a9d:6842:0:b0:703:77b1:c653 with SMTP id 46e09a7af769-70377b1c771mr7899342a34.24.1720708913607;
        Thu, 11 Jul 2024 07:41:53 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9d56bfsm26230136d6.32.2024.07.11.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:41:53 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:41:50 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>, gregkh@linuxfoundation.org,
	brauner@kernel.org, jlayton@kernel.org, jack@suse.cz,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Message-ID: <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>

On Thu, Jul 11, 2024 at 10:59:56AM +0200, Oliver Neukum wrote:
> 
> 
> On 11.07.24 10:43, Hongyu Xie wrote:
> > During hibernation, usb_resume_interface will set needs_binding to 1 if
> > the usb_driver has no reset_resume implimentation. The USB interface
> > will be rebind after usb_resume_complete.
> > 
> > Normally, that's fine. But if a USB interface has a matched kernel
> > driver, and a userspace driver or application is using this USB
> > interface through usbfs during hibernation, usbfs will be
> > detatched with the USB interface after resume. And this USB interface
> > will be bind with a kernel driver instead of usbfs.
> > 
> > So add reset_resume to fix this.
> 
> The device has lost all settings, yet we continue like nothing
> changed. That strikes me as a very bad idea. If a device has undergone
> a reset user space has not requested, we need to return an error upon
> the next interaction.
> 
> I am sorry, but this implementation has some fundamental issues.

Agreed, but the solution is pretty simple.  Because the device was 
suspended, the userspace driver must have enabled suspend via the 
USBDEVFS_ALLOW_SUSPEND ioctl.  

At that point, although the driver _could_ try to do some I/O to the 
device, the safest approach is for the driver to call the 
USBDEVFS_WAIT_FOR_RESUME or USBDEVFS_FORBID_SUSPEND ioctl.  So those two 
places are where we can return a specific error code to indicate that 
the device was reset while resuming.

Alan Stern

