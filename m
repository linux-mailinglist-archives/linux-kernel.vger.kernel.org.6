Return-Path: <linux-kernel+bounces-273541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706C946A62
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD51F216FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286D81514C8;
	Sat,  3 Aug 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KsoFW2vQ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9820EB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699368; cv=none; b=lJP1q0G5Xuk55h2uE6cMXAcNJpKUXJ1YZXVOklS7WlwZnKND26iIf5VtdjZo2656FTTaCqSlR86r+2Tc3SeklnzhfDpdS/AgLR3MbpepRGi1bw2tijjAB9UnVXqDd0WAujhNX4Ka/tYzxKuptC7+L2HfRIb3e9rC7YmFh/jeKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699368; c=relaxed/simple;
	bh=BiY0iEGJBbTuluEY89BWkR0jpjM4WqBleX6WGwJyQoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2xqulT0zpu7sTrVoSWoPgC0MhtJO0L7VPGQU1meln8vNuSXDG3MSJa2KMh3wQRcn2jXPMVnVeyk6zkNl+MHW3xS0mPLobAK0xRCvJQMlsRMwysY0xeiPpqVL+DZNbU+uzJNaHU7MUbUaNV7qmFoGlOLFJDdTBwWgG2kdvBSQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KsoFW2vQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so135283701fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722699364; x=1723304164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8s99Bt3lWPdagqO77UFMQllhbvmi0CD8sZa5cYosA4=;
        b=KsoFW2vQr6eGd5L536XyR9kW3hDocZhLxiUOkikQNrC+4hvVXtwvIus8gN9DeBiL/2
         f4YtYC0U51OrGkRSw66VVY7zfYXkTeLcY67SPird6hZqVSeiyQr45F0Fsr5gUge6cUSB
         SYOBu0/T/haSjG/RquzjnLgWuoloLqx4OCAo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722699364; x=1723304164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8s99Bt3lWPdagqO77UFMQllhbvmi0CD8sZa5cYosA4=;
        b=bILQXZpyR17DYRRgBlG8s3Pz9kjwf4PF6Vyz0h7YXaq82v0qEdU4Ck8CLLLbt7ziIi
         Z3r65CfwMCmO7FPIiP05hgACunM77oCiTlMOu6/gjLpkvMwm2mPeoPcBGJFG2Bb72cdZ
         m8oXFLKqKkGqX9BdkRwbyK2qhFTC7yTEOwB0KGSEKFRsx/YY8M1iyFH5cG6nepC1v7k2
         +p46DRsUB3Z520Jbzgyv8ZLdG8f/2V5eUPp6ACX+EeMgwWtIY2hotg98YO1cPausLEbp
         lXfHlPuM+f2Klj40vrW/GHuBnhwfZIYZKOvAmi7kSPOQAP00Qioq0DYl7VtFtpvY88cO
         XGsQ==
X-Gm-Message-State: AOJu0YxwIbnmaQbpHW/kXK49Pi86p1zEht9+YWHz4O1Y8GOqo9QlKJTF
	UxLwyPLCi9i3TiysizFcZ/VEDVoDrPowU+WtFXzPEudndIuraHwH8/ZVoC7N5tVEDzR3GatUyl3
	VnJAHIg==
X-Google-Smtp-Source: AGHT+IEi7aoFY+XzIo9KbFUtHMUyZC5won54ygx6yuJCL1UMsbwh6l7fabH7eXjov+1lmVLqJlvi2g==
X-Received: by 2002:a2e:9cce:0:b0:2ef:22e6:233f with SMTP id 38308e7fff4ca-2f15aac1dfcmr40886371fa.21.1722699363813;
        Sat, 03 Aug 2024 08:36:03 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e25092bsm4632601fa.77.2024.08.03.08.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 08:36:03 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efbc57456so8721146e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 08:36:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3c98:b0:52b:c27c:ea1f with SMTP id
 2adb3069b0e04-530bb39bf01mr4630021e87.55.1722699362522; Sat, 03 Aug 2024
 08:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802114518.GA20924@redhat.com> <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
 <20240802221014.GA20135@redhat.com> <CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
 <20240803120136.GA2986@redhat.com>
In-Reply-To: <20240803120136.GA2986@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 3 Aug 2024 08:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2rjFNc33JPFWfOQ0b-6J812L3Qrrv8yir4Z1pf-cwLA@mail.gmail.com>
Message-ID: <CAHk-=wj2rjFNc33JPFWfOQ0b-6J812L3Qrrv8yir4Z1pf-cwLA@mail.gmail.com>
Subject: Re: build failure caused by RUNTIME_CONST()
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Aug 2024 at 05:01, Oleg Nesterov <oleg@redhat.com> wrote:
>
> it seems that all other section do
>
>         . = ALIGN(x); name : ...
>
> was this change intentional?

It was intentional, but you're right, I should probably just do the
ugly ". = ALIGN(8)" syntax to match everything else.

The ALIGN in the section definition aligns the output section, not the
input section. But I think that's redundant, with the "AT()" thing
specifying where in the output it goes. I should have used SUBALIGN()
to align the input sections.

And the ". = ALIGN()" at the head should be unnecessary too, since the
alignment should come from the input section itself, and we should
probably not specify that in the linker script, but in the section
definition.

Honestly, our linker scripts are basically voodoo, and the ALIGN
pattern we use is part of that voodoo. Part of it is that linker
script syntax is just horrendous, and part of it is that writing
linker scripts is so rare that people just mostly do it with the
"monkey see, monkey do" model of programming, ie cutting and pasting
things that they don't understand and modifying them so that it
"works".

IOW, the right thing to do is really to not have any ALIGN directive
at all, and have the alignment come from the input sections by
specifying it in the source when the section is built.

Except we don't do that either, unless it sometimes happens almost by
accident (ie when we tell the compiler to use specific section names
and alignment, then the compiler will actually do it for us).

I'll update my fix to be the minimal "don't rock the boat" fix. And
we'll continue with the nasty linker script voodoo approach.

Oh well.

          Linus

