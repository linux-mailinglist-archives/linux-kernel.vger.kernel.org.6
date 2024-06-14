Return-Path: <linux-kernel+bounces-214726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E46908937
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED561F2AA77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F5192B91;
	Fri, 14 Jun 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="P/KrYiA0"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC21922DB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359314; cv=none; b=BHq2KirbMVoRKi/Fv9ZkQNgIXNEW8+CkBL8BlzR5J31Z5z4aeS2CJ4Hd8qbjVnGnrHxAWYdGEu4BLJBxcBlSGfsmfzvGYhOxY69YcmR8E2L2wI22DOjLiCTYXssAp6Ju2mxF+k2SDb/CJzLKrJqlZoqkugcKMDDn5nqoLq5H4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359314; c=relaxed/simple;
	bh=qJTa0t7bObTfCjOsSPk5ToDKQr8/FSrapP7WtkGtJ48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmZ/nalFiE9IWCGBH1a7xqjTjScUUQ1eSxLl3abTgRvhts2PycEZQO/ltaYkv37ScYA7Ae0KIoD5qrvFF5BpFGWQhtgvsEa6oGB5aIP8j769S9ew6OBjDaT9BZRUZFY7EEkE0Pc7aaKEwHP83M94qkroZnB/D5SndRXHtwvAdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=P/KrYiA0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso225660266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718359311; x=1718964111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IcWtGd9eZRzKtVaUol/ojSmPdnH4QZAUkGyNOHOIh5g=;
        b=P/KrYiA0mWJeW422PKKeUdYBDk/E6Murj6RaWCOATV7TvFJpFqyiDYDw4lnbBqv9Xv
         apo48/dunHFdLRYbizpAoQdTeVnsbr9fZ7Cx2uKmTAo5WLStzzDKH6zgeADCUceDxaQC
         dY7Qm5BngbGHIvtHHJq2K70xeBuFEcBCzQ4kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359311; x=1718964111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcWtGd9eZRzKtVaUol/ojSmPdnH4QZAUkGyNOHOIh5g=;
        b=izK49D+P9zZm/Jqt4y76a6IzuV6TgJC5YxLOcXXFJEeQSRRCQARwW6iDlTpl8r4RXV
         toZuOjtwdknNRh8Ef6EpCKy8eGCKULXVALsuiQtSk+93YeiHtVqYL7zu7C7FGaQ4CmSB
         MvWmztsU3WP7LdVdwTJ8T0KgYVHygC0v5/ZgJ5fV6zy5+OnBM4g44I0sL0JYGan8+nn/
         JF+ZLwXiNjzNTUQLWTriKTMc0svLHw3HVit7z1+0p7TfuX7rYOG4DB7Z14NujC62CGxf
         Va4Wn+vKWVJjDSOHUtb3LU4fEw4TvsO62VIuxHv1G/COtKDKDI2BnXAkEpv1mKSlDvaY
         aSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwjWkW8Gnj3qbfedLV3S8gOVIWRsrECnJfBAnn5a+ynl/i0IUdN6w4AMad/8E4r/c8RT9zYExhfeaJCUprLYNsp0RewGrEj4h7qQwA
X-Gm-Message-State: AOJu0YwypNBuXFgjHpK4uj2i/H1YxsWpHUjVlRetT9TK8y9M5Lv46QfI
	4DsW3pPSLz5irq61jf8/2iHm/J4ZmVHy9yDYv5D6eNMuW6HKlPi2Cp3531WEq5JYz9V+2astEBr
	d1sz4PcH+WjxZRXJvPW9vfy61gBHuUdVPGQZvuQ==
X-Google-Smtp-Source: AGHT+IEgKX7E3k+SiFkKq6gGcI+BVqO1cEyU5VEV9bAavZZ1VOJTWdSg/ASw7UP+4+eXdSAKiLhWTvPrPWhPxqILYI0=
X-Received: by 2002:a17:906:1446:b0:a6c:7181:4ffe with SMTP id
 a640c23a62f3a-a6f60de2519mr127172566b.66.1718359310843; Fri, 14 Jun 2024
 03:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com> <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
In-Reply-To: <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jun 2024 12:01:39 +0200
Message-ID: <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:

> So why the client doesn't get woken up?

Need to find out what the server (lxcfs) is doing.  Can you do a
strace of lxcfs to see the communication on the fuse device?

Thanks,
Miklos

