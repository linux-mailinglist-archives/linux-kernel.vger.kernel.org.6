Return-Path: <linux-kernel+bounces-420639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADB9D7EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF6016205D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79718E37D;
	Mon, 25 Nov 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dr/JP/rg"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0718FC89
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525036; cv=none; b=qbD/xiSBhcAtCmU3W8qnujcGOq9u92lpKpuBhvBmTI/Kl7gLdGAFNBe9HZ0QcbLrHHS6xbLmUvf4ywkAlvrUeJ/rOy9slvf//5io5erFcREHJO4oITKj53gEdukiB1PnBxeqbv1Vk7MI+BN9RlKs3vITyN8RP/gbRQ9nzbws684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525036; c=relaxed/simple;
	bh=lGs7WCnVDsN7XxJSV5nbIsOaHiSpnOd0xbhnLSv2cgw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USyLhLAsB7dzVjYCpz6yLvusdSRsLbdeyLzmlnaFWwQlmavVODQtQ0EqWMsg7Zy62oXLnYrX2ohxSiaW6MSLTuE6tI3s+pIRhvPFVYm81QkP6Y9zX7ZffF4yKmbtxcK7CUox55xJbwMLTtcHpZrc/0GCFgCKZyL3YcdQug6yFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dr/JP/rg; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a9aa8895facso690669566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732525032; x=1733129832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNEkjXcR05MS0wp8vkwMgIPKD9D5sF3FToehB53AVps=;
        b=Dr/JP/rgWuMDD8gXvo5DbToxBHJOsLqp363vitL2SMxDTGSnehP/kOR1YPCBdVCvZ+
         +YQ1OFwBBCfdAoz5/6SGQYV3PufeSxM6fTDvRhebkdp6f3TaBSb+bDvqCmpPH1X5gACO
         BJWyl00o9tsqeOcsE9ufEmEwbF2fxhJXTWK0cyojCBRwkR23UoCOdA2l4lSa/X+vU/dF
         Av/TKXPbHZ+fUHdCWA7EPsGuMuOopLRmnuIGYlp2fydTIf4l74v5lTb3jTDHwZ9sBrcd
         r3yvBMQTItzKpcxIGjhmHRz+T8TiRnSATxt9aLQvdaxhCagZ2rPv4+zLpsKGg7UA6qih
         Q3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525032; x=1733129832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNEkjXcR05MS0wp8vkwMgIPKD9D5sF3FToehB53AVps=;
        b=WvUwFulksOH/558i7VW+h2Mnq7PFn/Z8T2XuC+/AtPEuZOPLe08gbqBDmzJ3vQnapi
         B3kNeAoKiQEFpCAoNtlN7Z3afygwxcYTq2s6ULMJ5rMJ/7Xvs5RRByA5fBM0apZoNrRg
         lyOm/ff4z0UUsQ5w0mw6O15l3HNahcsh7YWLBgcaswGr75obvIO/tQA/o8a5vhMVzucY
         F80HicBKzytCrbcithtvkZ0UPqoAO8o0ytQKYcG3fQl4VmBLAIrfjrA+bSGAuioMppgb
         UnCmmbmS62aYxjRNZ+u1LfZUT3q7d6MUKzuaDU+o9VHDOORPoMTy5KvfAxSvbU2bdgW8
         ODTw==
X-Forwarded-Encrypted: i=1; AJvYcCVbN185b0PUi6ffCPxIVHj1kblD3VyCM1v3AEz0a/KeKHln4ZJ9A8HixEvu9rriUQkzrPQs+xb3a7VC0sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5MKGz0LQUV/tE6BgRNgZtRCc3+/Y2CaHrfQiQAnyxGHwa+PT
	G9pkfyg4qDbu5eGBBujA7qVVbI6MI1qLlUoYNdojKebcdNgwmpiTa2Yp4T3FWnE=
X-Gm-Gg: ASbGncuGWm9TCCD81KKig8ghPJHwX8pjN3IpG9Qha/U6KXPNJiCbbN091/RkhTGOmZo
	2r5i5jegb6P9kewm3JSvpC7EK7eDZzk7lJ92pvYqPp08wH9KUaA7tkIkqlxoyxIVCzreK4MrwFZ
	NQ5qrufsTzTamZcOmcU5QD0TN27Kvk2xU53K1ZRkptB83aD4H9KxwPqJ0mSDQ9Hs0r1vt+efBsQ
	p9NfdLEnk3pZnDRcgW+VKqLpUqwFWbQZ18jp3kbcnPH8+IZeGHW5Ltjr5AJnzwJfjbkct22P3T0
	gWM2ubK+Ei3Fgl95uRGa
X-Google-Smtp-Source: AGHT+IH55hAqFtF1SAZEH6TDiO7aHZVwXL0OCOENrWcyyZFBIRACNLLEe84rTZrGuYqyUatS9TtS7A==
X-Received: by 2002:a17:906:292a:b0:aa5:1cbd:def8 with SMTP id a640c23a62f3a-aa51cbdeea1mr942300566b.17.1732525032462;
        Mon, 25 Nov 2024 00:57:12 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f9b9sm442025666b.105.2024.11.25.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:57:12 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 25 Nov 2024 09:57:45 +0100
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <Z0Q8CekmPV4fAN6f@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <22e08939-fa89-4781-824e-1ea01648fb1b@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e08939-fa89-4781-824e-1ea01648fb1b@lunn.ch>

Hi Andrew,

On 20:26 Sun 24 Nov     , Andrew Lunn wrote:
> > This patchset is also a first attempt to be more agnostic wrt hardware
> > description standards such as OF devicetree and ACPI, where 'agnostic'
> > means "using DT in coexistence with ACPI", as been already promoted
> > by e.g. AL (see [4]). Although there's currently no evidence it will also
> > run out of the box on purely ACPI system, it is a first step towards
> > that direction.
> 
> When combined with CONFIG_PCI_DYNAMIC_OF_NODES and this patch series:
> 
> https://patchwork.kernel.org/project/linux-pci/cover/20241114165446.611458-1-herve.codina@bootlin.com/

That's great. I'll do some tests as soon as I can start my rpi5 from ACPI,
I saw there has been some experimentation about it and should be feasible
to run it succesfuly.

> 
> It probably does work, or is very near to working. Bootlin appear to
> have the LAN966x working on an ACPI system, and what you are adding is
> not very different.
> 
> I'm also currently playing around in this area, trying to instantiate
> some complex networking hardware using DT overlays on an ACPI system.

Nice!

Cheers,
Andrea

> 
>      Andrew

