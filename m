Return-Path: <linux-kernel+bounces-329008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D141978BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5B71C24D39
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD921849CB;
	Fri, 13 Sep 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTyho8NO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00C26289
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271766; cv=none; b=JwK/6I9/U2U6P/pX3hIswZC3zkvw8VbybRc5HRBdhCkETUOxcFzgLJ2MowFSLMNOMizNZq2l/HL2C4JG7ajXQjwybgCpKBuwvBHP1hcBfmiTc97bVEslBtboHqaq760kkGQ3zM+CkbhW19U9Rs0ZtSV5XBalLquQx/ryf6wDDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271766; c=relaxed/simple;
	bh=ZB8dnHGNegWHW0cBZh7J6cvgLzPx54oQl5HFDp/X6J4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/T5C8FW8x7hftcWT7+NP9X0JcXZ93MIqxk1dMN3qed8TWyb8jrj09FAE8QDXsFBozSeUhbdGYDT8u6IkDPRXVGNZuQe9MKUW47iFl44uipHR4t+3n6bYaasFcgHZzTpYs1qUQW5W7b1epPfJSv891NQ8Fz68EaovrT6HCYhTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTyho8NO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so25690315e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726271763; x=1726876563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rJG6Na+vRi1tiGMNv28gUphrrMfY9s3QK2qM/0I1eM=;
        b=OTyho8NOuPtBfN4e4gTd9IXvLJbdLpzeksAOnd9G7Ve6PmoSR22IJTAphK1682/YtS
         Z1qIQAHt26vypQQUNpI9FSDaKTvevgaVOg3dN86t0K1to/SU2gemqG3rPb2u9Kkj0p0J
         zGB6neXTvp/W9tC0pJ2JACRWlVJ3Jya89AN0lvI0Ajcbtvg4z3sHM1mYEhV1vBRwF7sm
         rQ0U3Qx+GGUcNE95qPuaHA1Q30QGLG+E1/O9yxd4mQrIlfmyerv+9R9SoP154Vi9aWOn
         cgCNI6+uXaUDTF4B+6LZ/Tla8Gs4ydayBhjVf8L9pP/xOKyqxKCPkSKQQLD0ZjZJGspk
         tzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271763; x=1726876563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rJG6Na+vRi1tiGMNv28gUphrrMfY9s3QK2qM/0I1eM=;
        b=VaAt4Kg6PIV3VNzErqCjhDLuEE5WmPD9BwMlAIo5GGx2Qkd2olObzJBCfs4Btf0kZY
         kTI/bFVlzjVw0QKdlmM4bnUSpUl1QPjdleVHNHUSWzJ72yRaxQaOimuc0CVj5lHYJ7dP
         GWaWR1nGbNi5i/YGDHwRta388cXPv/lvbOwDNGUqWnyiBaXYKiIFmZ5vnyeZqD0qghHv
         hLoP40h+g664VEswDQCvBaSFK2N5pxQCXe2T5s7+AtcpRobYRtxTCxnhSQoZyFWTWhX8
         UGzgmItfJmsPFnSDxI0O6Tei4G840TKh7ibbagwAXJKjxmwcbFdFidoV6yVTPR+9c28K
         Q82w==
X-Forwarded-Encrypted: i=1; AJvYcCXncyE2ypD7s1j2v2oZeRZEudr6SYy1xacCTHfkOyk9enQN1LPAoEIJb+gVsqDB8Pz5y7kpxR9YEL5FgYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRApLomfqTARWMePwaT+v6crJkOrlAClPvbKQ6I0fkZ13kzbF
	yIpzaNKvoPARiHb9rmv1SKwZhrHWUSNP0rdmOvDdWRcW7GzNPi01
X-Google-Smtp-Source: AGHT+IFZKo1gllweSA4jTQErjOMVja2BiiXb/9dG++Rx6qUBsFjnGQ/IM3WLsQVi66GMyuWbulpN+w==
X-Received: by 2002:a5d:4806:0:b0:374:c0f5:79f4 with SMTP id ffacd0b85a97d-378c2cfeb93mr5144366f8f.7.1726271761871;
        Fri, 13 Sep 2024 16:56:01 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:6bd1:9a24:6b02:4a8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f9a22sm343385f8f.61.2024.09.13.16.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:56:01 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 14 Sep 2024 01:55:59 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] uio: uio_dmem_genirq: Make use of
 irq_get_trigger_type()
Message-ID: <20240913235559.GA33362@vamoiridPC>
References: <20240912235925.54465-1-vassilisamir@gmail.com>
 <20240912235925.54465-2-vassilisamir@gmail.com>
 <ZuQIeVAdC1O2xAM9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuQIeVAdC1O2xAM9@smile.fi.intel.com>

On Fri, Sep 13, 2024 at 12:40:09PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 13, 2024 at 01:59:24AM +0200, Vasileios Amoiridis wrote:
> > Convert the following case:
> > 
> >         struct irq_data *irq_data = irq_get_irq_data(irq);
> > 
> >         if (irq_data && irqd_get_trigger_type(irq_data) ... ) {
> >                 ...
> >         }
> > 
> > to the simpler:
> > 
> >         if (irq_get_trigger_type(irq) ... ) {
> >                 ...
> >         }
> > 
> > by using the irq_get_trigger_type() function.
> 
> Btw, can you add a coccinelle ruleset for this?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Hi Andy!

Thanks for the time for the review! Yes, I would like to try it.

Cheers,
Vasilis

