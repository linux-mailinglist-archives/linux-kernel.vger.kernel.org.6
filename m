Return-Path: <linux-kernel+bounces-361472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63A99A8AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54C428481B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E031990C5;
	Fri, 11 Oct 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="crhQ5nkE"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED0198E63
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663305; cv=none; b=Csfq6x6JoVlxvjEoBsqTliNmokyMJFLPiTi8wDhU4j5GA14iYGUPnIFlEgVZ3TExwjCwIHUvzLkZfTWw0Ho9Gv4X3gGc7nlwbUypi61xI0KzxClJxq3iNB1JnwEV3/obe8YJomRvBxwMwK+yQUIQRAB9H1HJqMIscvcs7IdT0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663305; c=relaxed/simple;
	bh=gn2zJ+ebSzEzA9tLwZLGJpSONvEA/ifmwQ7Oc6MF1/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ8AbTbPvB/6vXcw1nspsHheVNU/8H4AkdeD8tZJQ7ghUYa85hFp5iHDkGve/pNrr+0Unk6IPRGwNG95dhALsSANgW+kuOkEjSfvi23XudaKVCNsWtZgRfIemEbtzeuPf7mzzJIzd1WmSuan9xJAHotB8TMuTSs5V3CvVb7qhgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=crhQ5nkE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e053cf1f3so2033337b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728663303; x=1729268103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wXNrkmIi/YQObyo/IyUy/irrJHMOY3CT8kXuXephfo=;
        b=crhQ5nkEGszbGLlyOBSGE4czsdfglUooHPAMey/hp8wJdaM6rv3fJCFZJMnVzxG6LC
         D/dngUIXMfqhJVkiJTmc8BEdlRoN8MYP40CWKFC1PlumL5CZFe/srQxRjIZgs8zDYm+d
         0PCLN8RQ6j9VUiiGtt/oOLGc1gSvbb3o2rTSKQjvJbsqXgnxD4bEsjm1I+6eTNeybVDa
         le+8I2JcxT4RWBkbE4QpRwefl13TrjgXTfVCRMZ9wZPHOIyMI4GEsqfuOUYE3/CfdcNn
         W3YWZZWmJtyR70oov6CkorfFuOykXccjEbF7M3BbgfyqyU2h7KxHOlN90WovgTgeuxBV
         xrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728663303; x=1729268103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wXNrkmIi/YQObyo/IyUy/irrJHMOY3CT8kXuXephfo=;
        b=cQMlLubFyn61HcJ19BNMaDVh/0qutZIu6VifQKsLWgYCF9qglHAVIKdFbwZCMtoUr+
         AeKbmrK6eRAnexfCssClxrY3DHXbPMV4s7qZA6hvqth2B89FHFXnV+F1XJA1x7s6nJqH
         h2xk2R7R+9KXvaenlXcYfYiQQXo+O2Jp9bHe6zcji3xkZciuGHURcM8RjM61X0SPl2um
         v3hdExhijhHa4WBxMPdWav+P6f0b4/HSPvLKK6Rm3fE+t/IvcQAhoPcweRMHkbFGWQ9Y
         63b/hSniGhsGHcRRNLar/Jm1hYJr2zec03xuKB2zEifyFL81LyTOMFjaVtoysXF1C8YJ
         ImIg==
X-Gm-Message-State: AOJu0Yy0xqR7QcejqeeUtZiT76/3wc+I8BawRtPsXfOSqWsnR1LHuV15
	ocCzLqCZe95QmhjvuARAouRl7lnGQ0+bIpKHy7hAGqp7nPuNJC4VB5tBZdD35mY=
X-Google-Smtp-Source: AGHT+IGvkNkvub3vSjul9cHLNp86zogPqdkI+zsKo8/knPvD0t1400lP6okGXqYs+UwbCewenEv0oQ==
X-Received: by 2002:a05:6a00:10c5:b0:71e:4bfb:a1f9 with SMTP id d2e1a72fcca58-71e4bfba31bmr136932b3a.22.1728663303614;
        Fri, 11 Oct 2024 09:15:03 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f5403sm2739854b3a.58.2024.10.11.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:15:03 -0700 (PDT)
Date: Fri, 11 Oct 2024 09:15:01 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH v1 0/3] pinctrl: th1520: Unbreak the driver
Message-ID: <ZwlPBXfCyPxxYGkR@x1>
References: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011144826.381104-1-emil.renner.berthing@canonical.com>

On Fri, Oct 11, 2024 at 04:48:22PM +0200, Emil Renner Berthing wrote:
> Hi,
> 
> Here are 2 important fixes and a code improvement to the T-Head TH1520
> pinctrl driver that was either introduced or missed when Drew took over
> upstreaming it.
> 
> It is based on Linus' pinctrl/for-next:
> 
>   6dbd1577b7dc ("Merge branch 'devel' into for-next")
> 
> Emil Renner Berthing (3):
>   pinctrl: th1520: Fix pinconf return values
>   pinctrl: th1520: Update pinmux tables
>   pinctrl: th1520: Factor out casts
> 
>  drivers/pinctrl/pinctrl-th1520.c | 52 ++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> -- 
> 2.43.0

Emil informed me that the out-of-tree USB driver is broken when trying
to use the pinctrl-th1520 driver that I submitted. This is because I
had changed -ENOTSUPP to -EOPNOTSUPP to silence a checkpatch warning
without realizing the implication. I've just been working on the
dwmac etherenet series [1] on top of mainline and I didn't realize there
was a problem with gpio.

I've just rebuilt and booted okay on lpi4a and beaglev ahead with this
series. For the whole series:

Tested-by: Drew Fustini <dfustini@tenstorrent.com>

[1] https://lore.kernel.org/linux-riscv/20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com/

