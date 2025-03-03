Return-Path: <linux-kernel+bounces-542205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65990A4C6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394363ADF28
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A8B22333D;
	Mon,  3 Mar 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9uUE1pU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D1218AA5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018759; cv=none; b=FdVo8fRQvxNV8ARHaXQGeCqpFih2DzKQiDe8jl3k/rZoWO7O/DQcrwoKHZP7hXenI/OwB0irZarp15KG46FJqslXju5C4ThgH690VbWugqgrhdnCvNJI9sWBafR6dw9Yd7WhNT9hzmWkAyVU1b+ZM/aiO4wwDX6j/Q+hJi1x2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018759; c=relaxed/simple;
	bh=kkHQcZoTJndCnwcbB9E+wpOiprPx3EnYCYUyF+KeBqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSXgqj1x94UIouxau4pFs7MFsx2TacV99z3rIwSC9DI2ZjCjgerTTPbW0DS5twcsl47s4l/P9SRoACJ/R6przEOVguGydWNeNrJCEaLpio5Ga1tofOtl41xOqLAHR/fzO472JHK68NQiAoOLcBn0AIppWdyKp8hNDcqss4BSpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9uUE1pU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L5XdYcpLAdNxNfxY8Lfqw4ebX+gqF0nBQ5UXPPTJPbQ=;
	b=T9uUE1pUD18iaSSpqkaWYpHwrdGdATH1CPVYM+qmx4bMNNuujfK7DiJlNUsX6YFmfGh1bM
	hyNPO26Z3QLO91pllcspaf5UL6bsJM7b2TEoOuY5cXKp4hZN4AgfiIPIGFVcMFWgLlCEFZ
	V5gWcnWZizMiAWS0upo7IyDZozLpHWA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-kinOd46kNaOULbrkfCHfbQ-1; Mon, 03 Mar 2025 11:19:12 -0500
X-MC-Unique: kinOd46kNaOULbrkfCHfbQ-1
X-Mimecast-MFC-AGG-ID: kinOd46kNaOULbrkfCHfbQ_1741018751
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390fd681712so928234f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018751; x=1741623551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5XdYcpLAdNxNfxY8Lfqw4ebX+gqF0nBQ5UXPPTJPbQ=;
        b=MkFvbKMwWOAq7EiMMDwhyQCKUjgST9dePsf56+gNIPyVeCQPrF7dGHjKvs/HA00Mc5
         iGEieS8oeQ8PW6QWPxrzo/cfDa2LEJbm9FyjgVhxQAhIr83ZkRvgafRnHZVug4N1k4Dc
         nuuLYPaBN/s23ryPvc9MFkycUFyMHV0+MeYE8mm0D94GWCkEIYBDmU7tAr18IJbXhe6X
         lTT+Fo2UUEd1M4j+YKY2QUiOLUiD+WjKoMEbgrR3ctB/1E/BT8eqzmG8XrsvMb6ZhOLE
         /9vq0BjlIcq3zQD8qoN95ts6nx41usZyh9hht9UpUY7WtOYscg0ILOF2ikQLXSGj4u/F
         Q4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXn9hBPTvxggcdPwUFgQb3aAK55rcxKxrE6WT9R/N83XhZaJdO1qSlIwTWj7kfuw6Q+rXtFUsb5SIWrZng=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4OppFV+jEqx1cSMMagljKxTpq9xeHL510XVA1Y5nosdHQ5ih
	Dt23tGNrnnbv1S7UlYn30PR1Oi3XoHU34z1NLCqBAXaEDVjRuuRw6Q8ZjI67IsLnQeiQ4Q2yGEA
	5/iNuszKnsRRmrPG1PTSYCjrGYd/odxWjEYO+/hcdpoC05eusGmBc9cYhVEMtuA==
X-Gm-Gg: ASbGncurIQLqNKA9PM1WnZ16VPYik+qFwUvxkuI/XqDhjPBooHDDSkggkOsxiDVWXiE
	EpROeIBg/fWWW5GBuznuqCQoNK1txgG/MfbyfPBPwSRlK4wS7jRb6Beslgh8xRclDgkwFsApj+5
	y+prqpeoUVGTn0P/GkUnyJbQ5uQEDU20y2WF1EGXoUPFSHLr7uVz0AS6ydn90ayiPH32ubwzIQj
	tAxrjasmtqgazP8rCkOVWfbjnhghPwEoLuZr/0whQUdeSWaI6BMcFvQRLAnPjM3K2weJ74HN/fo
	fxr5lHBteAnR+VW2yXNCsSXQCEwWztORHDBoI89N8nBPH2XzeSiVqyo2in1MmiCZ
X-Received: by 2002:a05:6000:2ac:b0:391:42f:7e94 with SMTP id ffacd0b85a97d-391042f836emr4415542f8f.18.1741018751457;
        Mon, 03 Mar 2025 08:19:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNgTP7CW85b75d/hToTcBGfinaj7PcJa9xIMaekWrZFC7WO4fkAD1vXiloSjC5Lawdn0s6dg==
X-Received: by 2002:a05:6000:2ac:b0:391:42f:7e94 with SMTP id ffacd0b85a97d-391042f836emr4415499f8f.18.1741018750944;
        Mon, 03 Mar 2025 08:19:10 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba53943asm193042295e9.19.2025.03.03.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:19:10 -0800 (PST)
Date: Mon, 3 Mar 2025 17:19:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <45ze5sxvcvg2ituxrefw6konxtwjgs4zs5bscrp2khfqkf3jb4@zozeerbmtik5>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
 <20250301002819.GO5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250301002819.GO5011@ziepe.ca>

On Fri, Feb 28, 2025 at 08:28:19PM -0400, Jason Gunthorpe wrote:
>On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
>> +/*
>> + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
>> + * module_platform_driver_probe() this is ok because they cannot get unbound
>> + * at runtime. So mark the driver struct with __refdata to prevent modpost
>> + * triggering a section mismatch warning.
>> + */
>
>??? Is that really true? I didn't know that

I initially followed drivers/virt/coco/sev-guest/sev-guest.c to figure 
out how to clean a driver registered with 
module_platform_driver_probe(), then I saw that pattern with the same 
comment is used in several other drivers.

>
>I thought you could unbind anything using /sys/../unbind?

I can't see `unbind` for this driver:

   $ ls /sys/bus/platform/drivers/tpm-svsm/
   module	tpm-svsm  uevent

While I can see it for example for others like fw_cfg:

   $ ls /sys/bus/platform/drivers/fw_cfg
   bind  module  QEMU0002:00  uevent  unbind

BTW I can unload the `tpm-svsm` module. Loading it again will cause 
issues if I don't have a remove function that calls 
tpm_chip_unregister().

Thanks,
Stefano


