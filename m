Return-Path: <linux-kernel+bounces-376187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9C9AA14C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4329C1F23BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D4154426;
	Tue, 22 Oct 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w3pkMXVB"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904B199EBB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597441; cv=none; b=WwKF5OynIC951UX9pi+twJyptJIORO6MD5kBzVfCH9P3UMb7XrVmMbMYGkc91Jhrxf2/LFQnusIDuUwq91eKXL/xPT8tanNqWl++h/tCUFMxnRUWhxTvamZ+8gorP9koe0xjoOSXDOWSw5uMzXxjXQHuzpsVjjggW7ESK/W4C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597441; c=relaxed/simple;
	bh=eBU03LmBOctVGp3oQT568nIvHtsc4hRjT+IESSBuhGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJU+37Nl6b0HF4sRlLeEshESnXMoY4QlcYxnX4pPsNX3Nu3fV9ioWx8AVwgsd5yb6dE/1XTgMphUNf9OKAnMhMNf2JTS+oqsDxjn34T2g7BW1XsRs2mBE357NWJbl6/iT8ArdVRqQoAiQ1Q547+kb9cC0bdYOjVEr4owqjhMel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=w3pkMXVB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb58980711so56909681fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729597437; x=1730202237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBU03LmBOctVGp3oQT568nIvHtsc4hRjT+IESSBuhGY=;
        b=w3pkMXVBMOj8FFJsS1BfBAs6LPmi6Z5zx9/+7Td3p8ahd7GgOnAD6ftGnQRAryDK/x
         qKPAHLFHJzNpIBNGPPYNWqObSKIpYbBC4zkP/xWgmN3/KESuEiMxE+cZOc1rcw9lzNCV
         YdvC5mfrrpINcgRLf2cx6lzCoU6E2ZYNqjqiQF6TfTMEC0yQyQzx34sK3oyHvgC8bLF6
         tNBxRRq+57pviehJChEmgAzAjM+z2NE9RvtcAEWCvLDGZH71CJRB2wAqLQQMsPN9PpBX
         EuIh4EJPnc3KzCGZdq56LrtsTvLEwrWZGq5QYcdCqwtDfrxFW4sgBaCMZ4lbsEEFry5/
         z8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597437; x=1730202237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBU03LmBOctVGp3oQT568nIvHtsc4hRjT+IESSBuhGY=;
        b=gKYVUePILG6s1kYU6PMXlfa7Fi5lrA5pXjirRNgfF7+rQ7XGi4znWCYLfBlrg6c+wb
         3AIpy77O3Tv8XNC8rgtYj21/tw0cykYz319IF5BMRsuN8LOqlYocFlF1cOEuvRqvTzbY
         IM3fRp/sC0OwJX3RB5OMzuZVOjDpXcPdHAWbRJOHmowhuZeS4IbxlEJvE8u5Xo0wI5V8
         8XNzG9XMiYQddErnt1kEBVAn39zC0jP846w5OICbxPOatcW+/q4CtBCI3Gn9sZLSMNxD
         qEGbs1ZnUeufXFWcZsVJ6Cv16yiZ3j+cJ2wFMWSgmzKJn+QcRqFMg43nIbwFRHFEaKgD
         bIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkmLRvoWx9pHrFSmlOg9vmQ6gJ6NVXs/am+oXq991cYksqtKIPNNUcSzecC5wP/ieJHm/NB0OwLIfPDK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBL+YScmhTRGiJez3sm/lxmWv4DRtyq+XAgVxO6wUqsv9F8fE
	5OxFtRH2nnjxpbwFC1/EA5cwAUQsJDpc+55o6ALMgvfb1QUAw4L5Q/WUdDfCt0CCgnnJqbmcmxn
	iJShxxD0RkzZua7P8yNKJpnX5S2Th8lUVTkka+9GEmjBxTl5W
X-Google-Smtp-Source: AGHT+IHv0JU0J9PGLy6ffpUD6D75+O0gIi950/5GHBOoWR6xI0HvKP8Mmi0qw9gOuB95udIKzZNZU/BQNe7LaDl6Z0M=
X-Received: by 2002:a05:6512:b01:b0:539:e776:71f2 with SMTP id
 2adb3069b0e04-53a154d04a7mr7743012e87.52.1729597437395; Tue, 22 Oct 2024
 04:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008160947.81045-1-brgl@bgdev.pl>
In-Reply-To: <20241008160947.81045-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 22 Oct 2024 13:43:45 +0200
Message-ID: <CAMRc=McL8DzSeiYm2C6f8NeyGFtZ6FZ2rycx8y2OrenNCEH7hQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: qup: use generic device property accessors
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 6:09=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's no reason for this driver to use OF-specific property helpers.
> Drop the last one in favor of the generic variant and no longer include
> of.h.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

It's been two weeks. Ping?

Bart

