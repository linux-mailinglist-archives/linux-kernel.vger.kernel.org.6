Return-Path: <linux-kernel+bounces-340814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C998782D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EAD1F23458
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E38156880;
	Thu, 26 Sep 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OQve8U5w"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA1322B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370783; cv=none; b=FMpfcLuXTb1t2p9DcZYDdaI4gfJmJpqieMqYmuQ3y6EiTxndCzbTiPkmkEle/hWLIy+CnB6DdCgVdlDnWZZAr3a8P0bXWDCp2KM7rX0iWkgpj62r1PoHpOnH3N65APOzr/BT8VftiRtF/iXq9Rrg8xO5Iv+M1apjKWRhVge4zHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370783; c=relaxed/simple;
	bh=N5GYRW2kK4Sk1U6wx8a4qoB8eB6P87hfmAa7TPF1LAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wiw7ecIWFjng/I76l0/awqI7xL/9fBiNAVgHJM45kIfwJX5B1xDSedymR9HX1HihhxuiBClavyHlnPTctsqpqDLm+EQOEDZqQ41RZdMxf48D/gZZmZEQDkRNyQdDuxHZE8fPnSPiLSVb0IlmsTabJqT2yjRoaAJGDNL/1rf/2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OQve8U5w; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53659867cbdso2041155e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727370779; x=1727975579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6G7s64usSiZNWYyG5MPpFmmHwRBdzlgmN1JXfG9V5jA=;
        b=OQve8U5wrickvRlD95avCst0MCTjywu8ruUttIrgF/D4EP4Bt52fxkfKzYTsGvTs8S
         TCpR4mUUGiXo06dhWQ7VEL5yM0M+yEbcXIMq3t7cKW5lagpkvm5KKJJ7pkP6XHDaHdcg
         +2Rk12iAowRJSQoqpRt8Raqy3Ew2lvLeTjDos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727370779; x=1727975579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6G7s64usSiZNWYyG5MPpFmmHwRBdzlgmN1JXfG9V5jA=;
        b=WN6TM8s0m4porTWK3zjftajmnmGk4774t5YGwRcFYR8p7bNQvfLAOQOriRxbBnE78D
         B5JtXbV3I9caodLlcDStVq5M2gdwmvrV8ji5P/wdicgKqlIuX/YvxB0JnNE3dkmZ/05W
         4xkvX0UMNqPuJsoSjo1cHSMO555b8ruCWe5RofxGTAY1JXdD9cDOYPP64ytO1GJqzh4I
         Bm+Azw57mKalvAojkwDyGUiaZiNUGtqMFY3WaUGKCdPIlvroIaY/kQzC7a0zNsJZnh6I
         CCDT+B9dUHYeHBeZ6mVWFeyAr6UKEGQ1Ht9+zFU+iNFC49aP9eaqYMJgad4me00WTt4B
         dSLw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZ60xNcrMB4ogz6Ox3DLmJ5/8cW9SKyfHFcO/A1ZpkLLkccGsgJsypsJ1mUrujU4WxkG8zYtSfmwSpqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpBxws9YyjJ+OpLpW/DT3ETZCZoP0HfWq9JZIJbTbPPiAaveU
	vS437zJFJTFfR614GdVlA6tTM9c1N3jNUdoLJrSCJN3Gw7WfL5fTtjiXeWHyeeqHo1VqYEb/7cw
	Y+FtunQ==
X-Google-Smtp-Source: AGHT+IFlEkSxAd8G4cL73wgLO2G8xwOJIyGlldx4qFIB/UX/OhUxCiLzj2x/NIJZafax2ZoAhV6K7w==
X-Received: by 2002:ac2:4c43:0:b0:52c:e10b:cb33 with SMTP id 2adb3069b0e04-5389fca3ae2mr277537e87.50.1727370778766;
        Thu, 26 Sep 2024 10:12:58 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0432386sm13764e87.126.2024.09.26.10.12.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 10:12:56 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f761461150so19445671fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:12:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgz+/AmKZNUMztDGyzECYU0O2wFSu+3A83zwDcuFNXXquSMTUu94fg26OOZ0hHlINvKHT6fjng6x8vuVA=@vger.kernel.org
X-Received: by 2002:a05:651c:54d:b0:2ef:2905:f36d with SMTP id
 38308e7fff4ca-2f9d3e4966dmr4375061fa.16.1727370776405; Thu, 26 Sep 2024
 10:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924123141.16962-1-zhangboyang.id@gmail.com> <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
In-Reply-To: <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 10:12:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs70xZ_F=3+52cuhXNsK3eDWVp3PJtExbCAQrUdhcRwg@mail.gmail.com>
Message-ID: <CAHk-=wgs70xZ_F=3+52cuhXNsK3eDWVp3PJtExbCAQrUdhcRwg@mail.gmail.com>
Subject: Re: [PATCH 0/5] rslib: Bug fixes and improvements for Reed-Solomon library
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Zhang Boyang <zhangboyang.id@gmail.com>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 10:03, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
> If I were making this patch series, I would send it to Andrew Morton,
> but if Linus takes it, I'm certainly OK with that.

I don't feel like I have the expertise of something like rslib, and
would actually suggest it go through one of the (very very few) users.

It's just pstore and some NAND chip drivers, afaik.

                 Linus

