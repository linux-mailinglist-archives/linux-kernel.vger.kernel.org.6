Return-Path: <linux-kernel+bounces-347305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3E98D0C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08DEB21FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE671E5000;
	Wed,  2 Oct 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c16mpe1y"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C0194A67;
	Wed,  2 Oct 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863489; cv=none; b=olHRTwu7mr+3VgqDObPKXC4Znvm3Mi4nqswI8sEh2uTfNp9BDRjdIvhCaVYur6UrQOV+pwqLkTbyZwpuv5VVd3r0aIRYcwnNb4unCR+lfo5qehHqUh66zh844ryvyAxd9jcvpv62cr0wYGsgDFk62tkk94Tocbs6dqgo4qnj49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863489; c=relaxed/simple;
	bh=fJc9vV8gI5k6M6PxFXD0s9yqXw92V7Acdvf0rZmyf2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=U1UljrRqB2slZIUJ9wzpSZw93nESlHRDzboKMAQ0nbu1UvO+soaTRjyautADtCzsYjxFUTLLjnsUPzXbG5IaslXExq0A7R2nPXdOX6FGHR0xZ1B/UCaHho3+PBG5aneCEmhOyewdspMvXS61s14FLTjlm0HTTHbIQUhnyzI+Ju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c16mpe1y; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so4644499e87.2;
        Wed, 02 Oct 2024 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727863486; x=1728468286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkjqrOL4x76Vv3+CE0zybVVmdJ/QHdT5VFP4DcsC72Q=;
        b=c16mpe1yWg6VNMpWJn+ZgawkIxkMwI4Ib6ZXqgmJlqCnUkwKoegSc6v2BN1LmUqdru
         airp8PbA3q3XeUbQshzibNw8wwLH8oObY3gC5QhpTwYuiHRbw93G59+jbemRuOBLo2Y0
         LTEAtLJcalichuEFJb67hxQ2OErp8vKeymtGLpSE6FloXOFNNZts8DCkb5RFXbe4Q+q+
         6/nrsIm3fTtw32x3lsl3wT+Q890DTalCl6TBIYwykYGGIUpb1hsZTCgCqEuL67YZoHYu
         p/lMoTzJ6Tx8n9JupDuFAn8p8mH36ELp+abytDP8nMJQwdtLDGo09/PNTK1rRmiYh+2W
         zTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727863486; x=1728468286;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkjqrOL4x76Vv3+CE0zybVVmdJ/QHdT5VFP4DcsC72Q=;
        b=qjfBihHvUhsgBNwMhw0aDyE3PcB0+6vS2jzuO7fctri3HlxlMF9IygQgqFG1h+0GGv
         uGbDjJwyK/cAHBfDfLG+j3mSt4ifM4o95ONddtn+PDG2Vy4cQ7xazVuS7HkKXKWdBbwl
         nKBI0QSTBqoQExmlKw+vVVa3iQkPqYazAzBGpojb85ydYczNQwy/bo97CQm/OWfT4R+R
         ov3nsbPGOeK/pDaIgG7e3vrgopUG8jVe5VcbW41f5tjrZxng29jHzhm4d+LMf1TgQVDi
         mAzjOsXk+7i4ETi8XsED+uwwlZ6xHNFAfE67XDe+4mfqYsblTQ2ZZ6U9L0+HfWJhHZm5
         hR4A==
X-Forwarded-Encrypted: i=1; AJvYcCUaw8mIhZ8AI0GqmaO6tv2UCTVBcvD89hpVGyd6teKpDmg1Ketg72HWx7dl2VFOBXCpQ9N3AWB7Fo8Tw48=@vger.kernel.org, AJvYcCWGlh13Fmxr3zGwuvRn6YzrFcpLenntldFwKwsemYxaJGKMcUIWIDYzMQUYJ9Tlws/OXsGnzQQEE7Fj@vger.kernel.org
X-Gm-Message-State: AOJu0YxLi7wyeVhsmDkvOKri+MqaMaicff75/KiR9bJwuyUItolSXFhP
	5mKlYACqCVdQ/rIjohB5GKj8T2wWU/jbbNPLNsIWCSz5uKX8xfCX
X-Google-Smtp-Source: AGHT+IGZtmAPeFh2cKRRVSJwfBZvvqMG77MYKub0AvmtHhjwAxc6HNVQm2rlWcID6p8CuO7VUgqwFQ==
X-Received: by 2002:a05:6512:2348:b0:536:54db:ddd0 with SMTP id 2adb3069b0e04-539a05fffa9mr1422560e87.0.1727863485656;
        Wed, 02 Oct 2024 03:04:45 -0700 (PDT)
Received: from foxbook (bfk18.neoplus.adsl.tpnet.pl. [83.28.48.18])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd539f2sm1860264e87.36.2024.10.02.03.04.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Oct 2024 03:04:44 -0700 (PDT)
Date: Wed, 2 Oct 2024 12:04:39 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: islituo@gmail.com
Cc: baijiaju1990@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com
Subject: Re: [PATCH] usb: xhci: fix a possible null-pointer dereference in
 xhci_setup_device()
Message-ID: <20241002120439.077afc90@foxbook>
In-Reply-To: <20241001194526.25757-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> There is a possible null-pointer dereference related to the
> wait-completion synchronization mechanism in the function
> xhci_setup_device().
> 
> Consider the following execution scenario:
> 
> in drivers/usb/host/xhci-mem.c:
>   xhci_mem_init()       // 2381
>     if (!xhci->dcbaa)   // 2431  xhci->dcbaa can be NULL
>     xhci_mem_cleanup()  // 2548
>       xhci_cleanup_command_queue()        // 1888
> in drivers/usb/host/xhci-ring.c
>         xhci_complete_del_and_free_cmd()  // 1619
>           complete(cmd->completion);      // 1608
> 
> The variable xhci->dcbaa is checked by an if statement at Line 2431.
> If xhci->dcbaa is NULL, xhci_mem_cleanup() will be called at Line
> 2548, which eventually leads to complete() at Line 1608 that wakes up
> the wait_for_completion().
> 
> Consider the wait_for_completion() in drivers/usb/host/xhci.c
>   xhci_setup_device()
>     wait_for_completion(command->completion);       // 4179
>     le64_to_cpu(xhci->dcbaa->dev_context_ptrs...)); // 4237
> 
> The variable xhci->dcbaa is dereferenced (without being rechecked)
> after the wait_for_completion(), which can introduce a possible
> null-pointer dereference.

I think it's a false positive, because xhci_mem_init() is only called
on driver initialization and on resume from suspend, immediately after
an explicit xhci_mem_cleanup(), which would have woken up any waiting
tasks (and likely made them crash), but there shouldn't be any.

By the way, is your analyzer not finding the issue that any call to
xhci_mem_cleanup() wakes up everybody waiting on the command queue and
then sets a bunch of things (including xhci->dcbaa) to NULL shortly
thereafter? This race looks like it shouldn't be harder to detect than
the things you are doing already.

Of course, all of that would bring more false positives too. Basically,
you discovered that calling a cleanup function while something else is
still pending, or having some work already pending while initialization
isn't yet complete, may not end well.

> To address this issue, a NULL check is added to ensure the variable
> xhci->dcbaa is not NULL when xhci_dbg_trace() is called.

That's still just bandaid and not a real fix. With static analysis one
must always review the output and ask if the problem is real, what it
really means for the code and what to do about it. Simply ignoring the
missing pointer is rarely the right solution.

Regards,
Michal

