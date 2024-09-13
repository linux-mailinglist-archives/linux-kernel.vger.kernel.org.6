Return-Path: <linux-kernel+bounces-328920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1502978AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100A71C2302F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9215B0EE;
	Fri, 13 Sep 2024 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7PIbuFH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB127F460
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263843; cv=none; b=tlOHDuxGefSKt7OmNepIsPObI2vXI0dODOJTdGjatHUMydOFSl46vYb0puBHUO91SIjgdFpnRfeh1VIIflIbcbD6dY7kSd9L+41Qb0Qf03Jfcrll8BZ+Qi+n6yEZD5cCrdg6IorGOuFJvBM8DO8DAEtzdL3xfKos5gmfSdSrCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263843; c=relaxed/simple;
	bh=tfuYSo+KLHIiUv/qhXVqntL2AmcHjqzefmKj7MGAWFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZmfZ1kVslLuQLopYUC8ShQJl85VWNr50CE/vEAmMF9E3PcylLV8544bJbbCC+cB5KWV0cylO8KnLbSUw1Bnc0FOgz3yIGzpF2oD3ueds8gAkZlOsbN8MV4q+bpZ8rpAE3RuAdXxS7MDKAEv7/VW/0kBaLwp6uGG8lZQr9bJ8fmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7PIbuFH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726263840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fKkSG8VqZnRHGkrVPV+pI0HT1H3VA+Urh2h620VqLak=;
	b=a7PIbuFHbiTgcodwX1FPQt0wKAkfloCwnoeEvRXHsyZvanKRNzWLE+VWfIabnGXLOwwd2r
	+oem72N+yWHEHZZ7Ob6AcrmLjYzAILPIcdBG1emymG29yQQw6SfiSdvAfHYE+51i9MM3bf
	bhZ0V/2Fvd00J3BCLIZUHpmaJVJJwH0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-BdzYwGDDMqaNvYqLgzxFlA-1; Fri, 13 Sep 2024 17:43:58 -0400
X-MC-Unique: BdzYwGDDMqaNvYqLgzxFlA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb998fd32so18624025e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263837; x=1726868637;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKkSG8VqZnRHGkrVPV+pI0HT1H3VA+Urh2h620VqLak=;
        b=pYYQ+/HSHy21mGBb7o+c2lwT478cEkWbgtB/uPRMGl+8edjJ7XUpBdz+hbn8QHeP4h
         Tb8jlJHCyFIqzYgkfj5fKNCVMs/r+SsH8//yH3i+l7a+gZAODfAF45X4gIwRtg1BWG7S
         od6IFnDa2LjcN+1uynz4mf5n/zkECWbXKgu6EGcHWmsDKFmXrMnSok7b8YlUm8s9bUSI
         psfM5k8F4y0xBpmUN4NSkdJYlDP/0uwN9WwFJFoBcI9Qfq+4rsmu9EXN/pc/6NLqlvcl
         pG+cJHNEktvuemC/ECfoQ5FuaoYNAb3HYgdlNZhYSx/W0fdcFtEcqgIU1cOMmfPvGS9/
         1Rwg==
X-Gm-Message-State: AOJu0YyE0xdcvyrrWSZL1v6vVrXgphqStqZLTyyaO8AWXDrq2rinszOy
	Y8zlZckyu+p40Hntm/O3jKgY90Vlfb8qXMTvS//cYH2PZj/WdVdzEPZEt9mudGx979dkyBuYGX6
	rkphdr2KrPpLi7w1FkRA8BahVwoa+W8APRbTzxrbai6XgkoeBv9LZ7wqk1lK6Cw==
X-Received: by 2002:a05:600c:4e10:b0:42b:a9b4:3f59 with SMTP id 5b1f17b1804b1-42cdb529b15mr63531175e9.14.1726263837559;
        Fri, 13 Sep 2024 14:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmgVixelwyphAF04b6dZiaPA5Oxiya0I3gktrct+B5i0gL94h0PMPytDOlN/HdvI08wJsm+g==
X-Received: by 2002:a05:600c:4e10:b0:42b:a9b4:3f59 with SMTP id 5b1f17b1804b1-42cdb529b15mr63531025e9.14.1726263836950;
        Fri, 13 Sep 2024 14:43:56 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da242736bsm2598215e9.40.2024.09.13.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:43:56 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Julius Werner <jwerner@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Hugues
 Bruant <hugues.bruant@gmail.com>, Julius Werner <jwerner@chromium.org>,
 Brian Norris <briannorris@chromium.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Borislav Petkov <bp@alien8.de>, Tzung-Bi Shih
 <tzungbi@kernel.org>
Subject: Re: [PATCH v2] firmware: coreboot: Don't register a pdev if
 screen_info data is present
Date: Fri, 13 Sep 2024 23:43:55 +0200
Message-ID: <87h6aj6xgk.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Julius Werner <jwerner@chromium.org> writes:

Hello Julius,

>> +       /*
>> +        * On Coreboot systems, the advertised LB_TAG_FRAMEBUFFER entry
>> +        * in the Coreboot table should only be used if the payload did
>> +        * not pass a framebuffer information to the Linux kernel.
>
> nit: The official brand spelling is "coreboot", always lowercase (even
> at the start of a sentence). Not a big deal though.
>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
>

Thanks for pointing that out, I wasn't aware. I just posted a v3 with
the proper coreboot spelling and your Reviewed-by tag collected.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


