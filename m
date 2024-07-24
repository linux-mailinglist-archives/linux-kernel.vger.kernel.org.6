Return-Path: <linux-kernel+bounces-261469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A1D93B7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEA51F24F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0F16C6A5;
	Wed, 24 Jul 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fvbiqh6t"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E81514F6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721850755; cv=none; b=YPZMKmSQOZ7hac4Nz9diXkHFk/orNnAvJlOu/im0aLFByUPswQGOqcFyLwLanwk96cvPFDHpkVVJxgPq0htj+3H1XOoGjUeKPfD/wOqhLb0cmGtTYLV1ZhutAQllouu+rxfxLL9v70B3L3y33pgtT1/XvyYPyHTMc3ImAVGkxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721850755; c=relaxed/simple;
	bh=YV/FJArHK4XHw1CfOtP3ZbloKPbydpXO5KwL/uEgRjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTYOBBdinDDJyo+odte+i33465S16/ZwvupRTgetZwGNZfjma52WDepKFqkcv0iOMEOrH/msW1fT0dagiIeKqc1+O14z9ACwg6oLX+ViDdmmulnYtdY4VkuKoPOlE1cEpaMU/K0494etykcpJsD4nt4BjeC6QCHTSoR4i3bz684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fvbiqh6t; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso26814466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721850751; x=1722455551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7JcAEcAAGSH/Vwm48mQCH7JL77mTwpetHzT5LsEik9w=;
        b=fvbiqh6tggbl9Qbt6085VMJi6CZshmwIq7+lt7xMdYx1GJ9BLU96ladzupKQFLvjfi
         Bn9I83hp+3Y3Jy7QHHdws2tCIUR64BoUFZyfwPdGP7oNRns0x3AkwcR+z6a3cU4w+K30
         1DkeE0cvBYHWmUjw1rYl1ukGKOyXN2fB6vsK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721850751; x=1722455551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JcAEcAAGSH/Vwm48mQCH7JL77mTwpetHzT5LsEik9w=;
        b=SEwlHgGxMeIhTGoS58FvZPGPlVo37idvRsoQP7P7xHn64IpbG6ZSsb4KeuZzLNsMri
         WVYBoFWML8odb6jN3gL1sKFiBv9cjL/roMWum7ZCwQngQZ/HHjqiqCCc2f9vh8J3nIYv
         911Yz3VPa8t3V6pcG3ZXu5hOO9diysFrmSvFUejnNFs+9I6jXeTTSxIUFquIrRCioIP3
         WFNccus8WFF0KiQBqkDFgmKFTGg2puAptXhWe232fmbybum8Ydj7Z0s+gAj2VxYWIFyx
         OLn/uksCXppVAj1fZzJRcx9Yui4vALS1X5YbRdfdKm2FULlYCbs8xwM+nIMfqxHKyNp7
         2OBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEq0z93CQAaix2Be7ytbMfX7FtE8eZvi1qStlA9wS3Jjv3PZkXAgtpvVStr0wJPcpuTxOy1VNh/keItXHSjDxdxKnAIKMUqRinwiwE
X-Gm-Message-State: AOJu0YxI+kkegqzCGUYrotk5tp4EpmOFgZtlwrXJAO9FylALv010MrqR
	ttHFmxJFHwMVPoFCIWrlnSFY6S+VCBRk8jVFppsQpUPOKbSsXK51QMIlg19JDygjKTp89/YYkYn
	+jGY=
X-Google-Smtp-Source: AGHT+IFww+tWtF02kpeoejCKcaAVe2NrAgdACG4oYVhtfTR+fJHR+Q2j+HIwEKpbb6xjuWVwaQLPyA==
X-Received: by 2002:a17:907:988:b0:a7a:9144:e24c with SMTP id a640c23a62f3a-a7ac4d5bc68mr33024866b.9.1721850750931;
        Wed, 24 Jul 2024 12:52:30 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785ba3sm671490066b.22.2024.07.24.12.52.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 12:52:30 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf7cfso303299a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:52:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVafu/deXcHHhdXURmR2qCS5tlNKXjT2/BrE5ciCoBlM0SJN3xRiK9Y0J0Kr09O18u/NmrDjpiP/tmhs4GSG5FRBxGhxB1HwiMjwH9V
X-Received: by 2002:a17:906:c113:b0:a77:cbe5:413f with SMTP id
 a640c23a62f3a-a7ac4d5bc37mr30498366b.4.1721850749532; Wed, 24 Jul 2024
 12:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com> <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
In-Reply-To: <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 24 Jul 2024 12:52:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
Message-ID: <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 12:35, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> My rough numbers below, on a 32-core intel i9-14900KF box using defconfig +
> a small number of debug flags I use for compiler development:

Side note: I think better than "time it" would be to simply generate
all the pre-processor files, and look at the size.

Because to a very close approximation, all the overhead from these
things comes from the deep macro expansions.

And unlike timings, the pre-processor size is going to be (a) entirely
repeatable, and (b) will also perhaps point out other worst-case
scenarios. IOW, maybe there is something else that looks like that
"min3()" horror, that can be more surgically fixed.

                 Linus

