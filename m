Return-Path: <linux-kernel+bounces-254168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9608932FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED3AB21153
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF8111AA;
	Tue, 16 Jul 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OlsXrQcT"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88454BD4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153334; cv=none; b=IIR0EoqAJEj/cfacMuCV6A1PlKZZSEXrRzQVCk0VyFC5FVa/qcYoOR50a4Klo3JOzySLc5z01OXiC+3dx/b2SatS68HOGJpzRNwoJotMrnnk1UBPnjCX0fghXwCrrv8BvrTqnprFxFqcg31GPOa9P+uDq4n9wkKSAJDBjHHIg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153334; c=relaxed/simple;
	bh=qhvpW9ySp0c3Q3YTMvLYSq349/2CtNUgGU8+Fc3TzLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYmiP9rV65C6BU/zw081NcGSmyBgc11xjmGDC6/OWNUI0OD/DJOwXjKVrTJJkXdlwLfYGqgTfE3LTQTrfkd3yeHpgFWOuGFWFNCxMKlOrKJmnkIxjta16rZkjnUu+w55esI6QU60JlQgLf6hdObsYnjBsCGnfV05xhsoy+p6mIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OlsXrQcT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e976208f8so6345764e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721153330; x=1721758130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KOjYz7yaXpRDTT5QSfg/sdBFbTuHViu6MqiHwYD6nv8=;
        b=OlsXrQcTw3YmwbV8vUTIhDfhRjflVdUKWDMGcYEC/b4EW3A8bh0e4CTU+nbdNfyKpT
         VxOBMPXukfUG/bVrPyvYQuf2eVOrfc3OYQqbY/0jnqVGY6BCoJqh2aGZTv3M33vfmT+G
         Dck2ys6z68rHiFzrAiSagq7p8uqWwxqDrahYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153330; x=1721758130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOjYz7yaXpRDTT5QSfg/sdBFbTuHViu6MqiHwYD6nv8=;
        b=FwdBgU4po1VYxDIJyndFYhOM2ix2j6xKaa1FLV7Ij7+szsXYUrw2nQ8cMtpu89FqSG
         Nxeb+pGgaCG/KvTRrGTzlwa5l2pSuKxdiviZu2Ike28ofTboxmWld4EGLMiiAZCwGp+Y
         CxC3vfU4GThfWXM7nXdY05gGOoE67xoz6Ddnby/ddr8NH0HcU7oLsuVhhaHvECpIJdAE
         Lokd8Qcw6ELgCFInS4OZQUA5lH419yxr6z8mVIFMckqIVwtZld/enG4kqesQzRs2NIYW
         Hp0nHm7NFy2rnFLeHVR0WrAUT06UBk66w1/KE5zKoxklIDbEEj+rX/WaUuDVo+oGfJT4
         TcQw==
X-Forwarded-Encrypted: i=1; AJvYcCW1Jnlhi0Q/DG2WX0XEJF1rSD+NhBTRvLXcebghYxjz4U1aL1jGK2OYIpTVwe7qeO35HVo54Gzw262LQ8ugA8oFaxJCs+IhXS+nnZjT
X-Gm-Message-State: AOJu0Yz+Z5C/b6laXspCwZ8iufPpE7uxiT2/zAVkzsmzaMV0sQlX9+fj
	TQzeJkDAA0sZfD05WeIREVXrYrK6Y721g4ZzGl4nNdVu4aiW9Zplbh3SfPsXv0MlP0lEq5k51r+
	/UPHq0g==
X-Google-Smtp-Source: AGHT+IGPFSs3JI9uwr88GwZHNK/okWXFTdQTCEab01hmHMyz1PuS3N30xy/j9ltLR7Ni+hvhifLFIw==
X-Received: by 2002:a05:6512:1254:b0:52c:e133:7b2e with SMTP id 2adb3069b0e04-52edf0195f5mr2003537e87.35.1721153330148;
        Tue, 16 Jul 2024 11:08:50 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed2532da7sm1227896e87.239.2024.07.16.11.08.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:08:49 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so40180061fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUctvhT9/5EYQ/gHgXBKJZSSzdOmb8bfMstsPRlowT+pkDRmVvU2vi5etYZ0CYvoELmDcf0wCoxcLNNVbude1eJj/wt2ycvTPlrDrC
X-Received: by 2002:a2e:9acd:0:b0:2ee:56b0:38e3 with SMTP id
 38308e7fff4ca-2eef4184785mr22070261fa.24.1721153329186; Tue, 16 Jul 2024
 11:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl>
In-Reply-To: <20240716152318.207178-1-brgl@bgdev.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 11:08:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
Message-ID: <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 08:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Let's remove the public menuconfig entry for PCI pwrctl and instead
> default the relevant symbol to 'm' only for the architectures that
> actually need it.

This feels like you should just use "select" instead.

IOW, don't make PCI_PWRCTL_PWRSEQ a question at all. Instead, have the
drivers that need it just select it automatically.

It's much better to ask people "do you have hardware XYZ" that they
can hopefully answer, and then we enable all the things that hardware
needs.

In contrast, asking people "do you need support for ABC?" when they
don't know what ABC is is _not_ helpful.

IOW, when you write Kconfig entries, your rules should be:

 - NOTHING is ever enabled by default, unless it's an old feature that
was enabled before and got split out (so that "make oldconfig" gives a
working kernel)

 - you NEVER ask questions that normal people can't answer.

For example, we have *way* too many questions that come about because
some developer went "I don't know what the answer is, I'll just make
it a Kconfig option". And I absolutely *HATE* those questions. Dammit,
if the developer doesn't know, then a user sure as hell doesn't
either.

I tend to keep on harping on Kconfig issues, because I really do think
that it's one of the biggest hurdles for normal users to just build
their own kernels. We make the rest of the build system pretty damn
simple, with a simple "make" and then as root "make modules_install
install".

But the Kconfig phase is a complete disaster, and it's because kernel
developers don't seem to think about users.

              Linus

