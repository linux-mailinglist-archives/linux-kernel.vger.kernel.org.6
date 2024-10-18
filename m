Return-Path: <linux-kernel+bounces-371774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969D9A402A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE920281277
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF91201008;
	Fri, 18 Oct 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ggrTegPA"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DD200C94
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258721; cv=none; b=MGhwTRjd3idj+oL0BHbANMzeXmQam0b3osPtxJR/arp/Yuz5+Y0nH6QKlz0q1qJzK35w+BY8lQV/uzLBpRzBGiU9amK6xSi8gj24JPMjPQDDOQ63YGjoXPcmgvfTfY0sW0mw/wJ+DPe00sS87iVJhqaVo0q8hS+p5zNJep+6dZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258721; c=relaxed/simple;
	bh=0PH9ZNuHVfDm1Ir0FY5lORCCqHB0yu/JEIaTFjCE54Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFXkjq5aSJSbUX8iV1/004UnXdMWZFpr4sJyCoj+53iCiDE58WG0ES/jGVHmRrYVzA3ycfFnUnPoamO7+VE7uyliYzzsc8OZ8z+WPo6lA5s4FUof4g+BG5fHx5s9RBt5hXnicwmyb9bcS4LxwA9CSwV2QgwLGOU/OBSvrQi9FH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ggrTegPA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7181caa08a3so274723a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729258718; x=1729863518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVQC71FpKRWshBPwUAPRSfOi9KhTjaLXAKPeTx4sMCY=;
        b=ggrTegPAkbe6a2KzhqnrCK/9V0goCfbsmIKkAaMo+LLjk2SlvCyDNn7CN/uGYxhBW4
         fOUZCmj3h5Ny/UwXtlNsnhguzBLkcGisIVGmx7VAWhKfEWXu9n1ic92vW7A0Xl2Mb39s
         2pdU4DmH7ycbzfqrDEEuE0XNDXkgyZUXk6GOtZxZBp73YSXU5uzfZ3zSdflY6Q9vNdQ9
         +BE0qEINVqyEZ9hqfqSSfFohtgmztIOnX4rOtfjgDBfdVnU/MHW0Wg2TCB+Cao1PTi/K
         NziZCV3KGmHhVo543q4L1+yXfmrz2YxI9EgOpNP3k0/OJEZB3ackkh2r3ld5Io7YUuSM
         OQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258718; x=1729863518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVQC71FpKRWshBPwUAPRSfOi9KhTjaLXAKPeTx4sMCY=;
        b=l6Tki0fMELZ5HS+sRGJfsvxh2TbAeUG1U92yrHClgfbEMaXult+I/R44EclA4bjfUw
         7K2REjsjDJiG3PD9619ZE+RYYj9DqI7QRPbB0yzBsKtjZ3iRZFYk2HxfDSvbWaothiQ9
         u6RS8g7/PspalVQeR7IV2brS33gLlpEvmttrdjtYVhyUddBrrkRMqteBZMUrSCVG/UdE
         Hrrw+EcTP8SSGWDWbL29OKTPL4ysacmOMk475f6Mn3qkcOznLV5e738ltZSKywcgU3Rd
         woqAQGtLWiVzB+Ff1vhX7MSmQx9GzVI5YSvtViYCUn/77k07y08y5iAlFMpkivK4Psxe
         9p8g==
X-Forwarded-Encrypted: i=1; AJvYcCUN4JXt1gU5AGHv9fDHSyGz2EHFCkdB8MQahcoDq5hwTQ/urQqT3WWpG95yX7DhTmyqbufQwE9kXHLv25U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFU++xftfj8QHL1VbNuYmqtSHJq1D1/IqFYa69DCPJ34c7cvNt
	OHjrkvXbxjxDC4WUsPPvR29GQUYSV53suiVM/xq0miEf9z6I17NVErDT1y7wF9U=
X-Google-Smtp-Source: AGHT+IHhM/hhdws8NWJZR7xLe9RfCiROWNQkWuLLhXb3EaaMsAeiBTYEXM+95+rEIX3njEZZmQYboA==
X-Received: by 2002:a05:6830:6f49:b0:718:a52:e1c7 with SMTP id 46e09a7af769-7181a81d73fmr1358859a34.17.1729258718312;
        Fri, 18 Oct 2024 06:38:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122b017sm6974436d6.78.2024.10.18.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:38:37 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:38:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, mika.westerberg@linux.intel.com,
	ying.huang@intel.com, bhe@redhat.com, tglx@linutronix.de,
	takahiro.akashi@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJk3RYDTpYkELCa@PC2K9PVX.TheFacebook.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>

On Fri, Oct 18, 2024 at 03:57:30PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 17, 2024 at 03:03:47PM -0400, Gregory Price wrote:
> > walk_system_ram_res_rev() erroneously discards resource flags when
> > passing the information to the callback.
> > 
> > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > have these resources selected during kexec to store kexec buffers
> > if that memory happens to be at placed above normal system ram.
> > 
> > This leads to undefined behavior after reboot. If the kexec buffer
> > is never touched, nothing happens. If the kexec buffer is touched,
> > it could lead to a crash (like below) or undefined behavior.
> > 
> > Tested on a system with CXL memory expanders with driver managed
> > memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
> > showed the flags were being discarded and as a result the check
> > for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.
> > 
> > find_next_iomem_res: name(System RAM (kmem))
> > 		     start(10000000000)
> > 		     end(1034fffffff)
> > 		     flags(83000200)
> > 
> > locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)
> > 
> > [.] BUG: unable to handle page fault for address: ffff89834ffff000
> 
> Please, cut this down to only important ~3-5 lines as suggested in
> the Submitting Patches documentation.
> 
> Yeah, I see that Andrew applied it to hist testing branch, if it's not going to
> be updated there, consider above as a hint for the future contributions with
> backtraces.
>

noted, thank you!
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

