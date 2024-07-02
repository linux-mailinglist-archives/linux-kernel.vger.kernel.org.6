Return-Path: <linux-kernel+bounces-238374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A9924983
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF711F22F6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78A201247;
	Tue,  2 Jul 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bewMYo6f"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F11D47D9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952989; cv=none; b=mLTUYZGEddAMemn++ebHJuMTfUKt2d5aDuGCRDWM8U3sHxYGS3cMQsmH2IK4VQZpxu46bvaTNgV/98aulS0L6t2HEfk7N4Fb/+EzUWBJ0paGth0HBhTeROYdHPGp6qgRFcxoInApNsFMIfkMZvXdZmYkMExCovDg4gMJlDh57uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952989; c=relaxed/simple;
	bh=6LNyVKKBMDAeeCTDCW+Q7xzEdYm5alFZdgDwqZcfDpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5pTC2/pgqTDFus5+dTSSmi8dwUOF10XkZ3YDbukEQOK72I6eyqUfQOF4qzT+ut7ZHtTE/7+QXszFgl11v87UPGkyCYDXjrhVmLOlj6usRNk9K4PD1zHniwKt2kySQoW2NWZc7zxJhWN/untIb/jblxRbEjc4dumWV2lM6JoZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bewMYo6f; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7245453319so737627466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 13:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719952986; x=1720557786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m06DGl+JsSnB+foAEKorv4GRJLNuZ2K+S42zJ3Ubdg0=;
        b=bewMYo6fkfqBZxysZZOHmFXLymINyxOtnfy17+bhDwAFZonTgyL5DTBQK3yV4v45l8
         rQWRwNsA27oamwvdEnqhjv7xSOjeuw3+r5dMp1kEFSTKDz6RXdUWSmMn1qRqSHOSphDp
         MyXNupQkPM3ijmgJcpne/mbdXI/AonFm+QXM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719952986; x=1720557786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m06DGl+JsSnB+foAEKorv4GRJLNuZ2K+S42zJ3Ubdg0=;
        b=TjiUSvV9WjfDbzj3qC+SL3LwOrPAutf/GgWO+1r8RWyAdhIolbV0OJ1N/cKxWoyeCM
         hp7SOYWZoLyQHsj2fAZyx27bORCv3iXRRycScPth9sZeP52bpcX3DwJWXuOxIMeM+0B2
         HhtJmiK82nTLEU2MYoOTtdkbIsB8fuCj1zka4ISQcVuMDKB2a+v3dsFvrirOgSm5ktUf
         qYe1HucmXZ5l7/TM9OP1rWpH9O76rLMrnTTBk6D/7a9O+c6bE03pB5nWEIghfI273IBD
         04aquP+i+0nPWR8GgJ7eiFIxE3j9dFJVVuT2AndQoB4FRUBlN9rsXjyr1VWOx1eDEgDH
         D/6w==
X-Forwarded-Encrypted: i=1; AJvYcCWbmqPn3Bn6+DE3jdHRpVH4pY/HD9SANdLDlQOtijOszBRcd/uB1DA/hRD+QMiK9micHvTRRA92L/us4b3OXMFtiKJfdOsZxm8q0qfM
X-Gm-Message-State: AOJu0Yx7ItFmmNTHNxGNTaBg3HyZL7+L4elz/KxTLJpK1/am34toBaid
	y0bP3FB0yxr2sZ2+mr5SCWs7/HgBzxXiXwmTb4sA4K5zpTPRpMtVNadQ9ekOxrVe78cgJMCuAEN
	+YuvopQ==
X-Google-Smtp-Source: AGHT+IFedUSNuj1+/NjVNzWmBLrNNUJXQGz3zzDVz1qk4xmVynmP2R+kcPU64gSIBcDqL9tbApQXVg==
X-Received: by 2002:a17:906:329a:b0:a72:6442:d53a with SMTP id a640c23a62f3a-a751388ed48mr600131766b.9.1719952986060;
        Tue, 02 Jul 2024 13:43:06 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf651d5sm455615466b.90.2024.07.02.13.43.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 13:43:05 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a729d9d7086so897779966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 13:43:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWX1Q3J/1c6OgIvHvAjvzSYfJehsha7J6x4/PTmiGCaONSt5Yrk0zz+mD6fl0xapiRW/AIntPZUfgITCcCKSLNaYkGLYY61O/dB4pfn
X-Received: by 2002:a17:906:eb4c:b0:a6f:935b:8777 with SMTP id
 a640c23a62f3a-a72aefa5ab3mr919607766b.25.1719952985057; Tue, 02 Jul 2024
 13:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
 <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
 <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
 <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
 <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
 <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com> <3g3arsrwnyvv562v2rsfv2ms4ht4mk45vwdkvssxkrjhfjtpdz@umyx5tl2du7o>
In-Reply-To: <3g3arsrwnyvv562v2rsfv2ms4ht4mk45vwdkvssxkrjhfjtpdz@umyx5tl2du7o>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jul 2024 13:42:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com>
Message-ID: <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 13:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> If you are politely by lkml standards suggesting I should probably drop
> the idea due to unforseen complexities

Oh, absolutely not. I'd love to see how nasty - or not nasty - the
patch would end up being. I think it would be very interesting.

I'm just explaining why _I_ never got around to it.

I do think that the 'stat()' family of syscalls are some of the most
critical system calls out there. And while I suspect the benchmarks
that stat the same file over and over in parallel are worthless, if we
can do 'stat()' without ever even dirtying the dentry at all, that
would be absolutely lovely.

           Linus

