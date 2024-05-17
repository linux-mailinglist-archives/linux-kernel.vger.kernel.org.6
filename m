Return-Path: <linux-kernel+bounces-182145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE398C8738
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5E21C20B04
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4065491A;
	Fri, 17 May 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hAEOeEH+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488F548F1
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952695; cv=none; b=K9G6MvoYQCyja0s6Y7mlP7w07wNNPxYfwPxx/qeXQk0AoyOq/De2hXnsIkGrVZfPW8Rxi02PYv1eQBx/zhVMkOKHe7jx/ImEuGwOGymE3KF/mA6qSw/d5dOLWWMfrGi167zKWemdMyEHaVbbY7X19XhUn0Cs28eXRhjNSvlbUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952695; c=relaxed/simple;
	bh=seWcc0MWUj3mawXEmiKxhpsB8iwoElIv69VZ0U4458s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEjjcNWHzNmR5DA0eEevJZffT99jyonIW43KvR/TFwtAZeV+wcS9GlqrDca/1m+1zZ5bAVg+dsZEkVgRDFb8qwy40CFl/PRp925SqgjHWR5Q8K/CfK4bFGGil/a1YmieyiHDN3olVoqUnuPliFZ+emEkQr24wwqAdiRcuZ94jAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hAEOeEH+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so426092466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715952691; x=1716557491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bT4brb25rflwO2YLF2w597w2OnxYptjFB3yksoj7XdA=;
        b=hAEOeEH+utWfJJX8xOCvGU2VId3RwOa/JEXOswKuje1BeSovK8VkoQsQeKDc6IYo8l
         6CpHfRJHo0kzFIy2tEV4NmuqLP+RUHN0bN67INSJqMTHw4scEDWFeT3iqE7Eu1R7Ec1E
         vzv15EAbRRD69FmmtIHILE4UcV+I7jjmKYCCdHO05hOyESTGoeBippVQ91F4XHb/mY5K
         To2RcBAYCOj9w276OQEdcX3cIgPLvpcGyQWhsj02VHCbn6eBvEJcGKPbk7gI0LEQhARy
         1OyakBnS7slSGeLWlLvOhlA1031Xij+A52iCDesd7moa/MLLGLcHsBvt5CNaCBQQN4t+
         oyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715952691; x=1716557491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT4brb25rflwO2YLF2w597w2OnxYptjFB3yksoj7XdA=;
        b=o1u/uaDBxb8R4k7R1y3U285pnM7vZpLxmz/d0RuVYgCkN9yvDiuYUjYnQMHUK+WBmV
         CNvNGRlPO54JfWYuHba6Rwm8018k2H19GngEdnPwjNQU84YvY8Vc8NLeuB1EkAy3VsRk
         4C4V4iLG+uvq0b2rDz0CB5++HhPGdMGX/aIk1K0pizMu014zxl6ikv9LJAx3w+I3Pv6A
         unakhUHPtL4XnHLLLbK1Qhd9WONqt3hlEB2fJ0zKZPUZW2eT3xZqDOmVwPqkaB+aR/td
         nGMef0Tt40VyDywQJp8to7x7dRNjqQVDW49CbLIu7r81Mpe5mRBOOOg5X7URiHbmNPHN
         ky7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEuETxS888OHwYOFU6/1EEbXvG7/jhh7PvWS6o/s0lbj+pfwbZxIWGoyTDgGvdh7Ete1VaaeokBWXo0PR9w/mfbXEDhqXDSbbWX3W3
X-Gm-Message-State: AOJu0Yw3kbHw8ehsR66DqIpRzk9qUM4vDBcofOGo0xV1S2TLPhcou22m
	EaMRkLsMBZF3V7KtegWsLctyCFw1EBPnPw4/Qn4Xi3tyz8hmlAgeKO2wtZkmA1b3WlZ+b2hgV13
	s
X-Google-Smtp-Source: AGHT+IFPnsV1IVk7GsGhVOaKMy5fGwWG0zvNBNiHMoCZwvPx6J0/HPp5ehMtsg7+hFWZv4A/E/9jCA==
X-Received: by 2002:a17:906:d159:b0:a59:a977:a15b with SMTP id a640c23a62f3a-a5a2d680d23mr1364784366b.68.1715952691272;
        Fri, 17 May 2024 06:31:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d87sm1117940766b.104.2024.05.17.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 06:31:31 -0700 (PDT)
Date: Fri, 17 May 2024 15:31:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 06/30] printk: nbcon: Add callbacks to
 synchronize with driver
Message-ID: <ZkdcFxW-e9LVmMd8@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-7-john.ogness@linutronix.de>

Hi,

On Thu 2024-05-02 23:44:15, John Ogness wrote:
> Console drivers typically must deal with access to the hardware
> via user input/output (such as an interactive login shell) and
> output of kernel messages via printk() calls. To provide the
> necessary synchronization, usually some driver-specific locking
> mechanism is used (for example, the port spinlock for uart
> serial consoles).
>
> Until now, usage of this driver-specific locking has been hidden
> from the printk-subsystem and implemented within the various
> console callbacks. However, for nbcon consoles, it is necessary
> that the printk-subsystem uses the driver-specific locking so
> that nbcon console ownership can be acquired _after_ the
> driver-specific locking has succeeded. This allows for lock
> contention to exist on the more context-friendly driver-specific
> locking rather than nbcon console ownership (for non-emergency
> and non-panic cases).

Honestly, the above paragraph is kind of a puzzle. My first
understanding was that the driver-specific lock will always
need to be taken before acquiring the nbcon console ownership.

I believe that it is actually correct. But the right meaning
is hidden in the wording. I had to read it many times to get
it correctly and I knew what I was looking for.

I have to admit that providing a good explanation is probably
very hard. A proof is the long discussion in v4, see
https://lore.kernel.org/r/20240402221129.2613843-7-john.ogness@linutronix.de

BTW: I wonder if you use AI for generating the commit message.
     My experience is that AI produces longer fancy sentences
     which might be good for a novel but they sometimes hide
     the important details.



> Require nbcon consoles to implement two new callbacks
> (device_lock(), device_unlock()) that will use whatever
> synchronization mechanism the driver is using for itself.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

My attempt of a more strightforwward explanation:

<proposal>
Console drivers typically must deal with access to the hardware
via user input/output (such as an interactive login shell) and
output of kernel messages via printk() calls. To provide the
necessary synchronization, usually some driver-specific locking
mechanism is used (for example, the port spinlock for uart
serial consoles).

Until now, usage of this driver-specific locking has been hidden
from the printk-subsystem and implemented within the various
console callbacks. However, nbcon consoles would need to use it
even in the generic code.

Add device_lock() and device_unlock() callback which will need
to get implemented by nbcon consoles.

The callbacks will use whatever synchronization mechanism the driver
is using for itself. The minimum requirement is to prevent CPU
migration. It would allow a context friendly acquiring of nbcon
console ownership in non-emergency and non-panic context.
</proposal>

That said, I could live even with the original commit message.
Eitherway:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

