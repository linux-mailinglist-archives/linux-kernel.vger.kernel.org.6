Return-Path: <linux-kernel+bounces-297084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D89895B2D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC7B283B24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3268317E918;
	Thu, 22 Aug 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z6KnSMSU"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A7364A4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322236; cv=none; b=uw3miBzGPlSiYUnSKjUWUZmCrHPf3cq0RyFKXpOv82wFlJ9NIy2wcP+VV90rjZ0Q348tCjVAlK3cXD65Rd2eGHlBzkW7A31UUDHZj3rUgqHballNTDcf6KaEucVHRv8P2lFfZzI9Ecozp50F8872X5zMdY8xW09DqHOHI+yj0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322236; c=relaxed/simple;
	bh=R6FvxR9deCLG09yOCyp8Lj2MV+f9zFcZ0deQ+LYWJoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qmql2svmZysjopd9s5WqmWs+nmohAG52RUomldf++1BPASoASzA9F+15otDuddrUfpLlkIYDGp3PgZJyyP62hpQGdyOfZwUJjQ6VC066VUAu43RFA0MmgzxYXcWndXnAk8/IQzubIAIvHo64EbOv3yLi4+/9+yPnUWwW3vAv6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z6KnSMSU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso1015008e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724322232; x=1724927032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e45XsMuvKuKXGP1RO13hjtFbIaK2zumMe5ngPJfelL0=;
        b=Z6KnSMSUh6nxpXhPlRBKlpIHYtjyXRxk6PnapH9DtP+RzKS/N9019eIbmD36SYLp9g
         PXADv+sNXU+CM+5bidqr7AMHaPzFwI9XTDHKHSu1q4os7JHPyIY0F6A+/WapRcOnWihU
         Z/J3GCWPzHzelZTC94Rw6IzcH83En5l7+6KXzJDQkGS8Ztu38Zka0znkT7rFXwBL3zBv
         KVMC6UoYnqGuonEUC1xjHZGiT/OGkU2UB13UzpjHvX5yWKhon7Bz3dCj/LuXpK8LdKvT
         U+aoW3Vf2mRRi6YWcWQYODVLh4/vxP8Rh8PL3B7GJwjaD0LaVJH1B44320YBmfO4WnOu
         jLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322232; x=1724927032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e45XsMuvKuKXGP1RO13hjtFbIaK2zumMe5ngPJfelL0=;
        b=FGQVyxHSBjNHsQ+A5+K/LLB8eqxOypZYyQ9EGdZ7mBVPcanWNxDVmvsG0/VpikE7py
         4jXU6ws9LhrJ6r94D2xWas4LUhszIS41Udeju6znmktHr6BQ1unZJBxNG3MkSMDDDgln
         gXwbmxSV+5f2a97pll39Bl3QOOYKLIkVECiA8U7C1fnNCll/k7gWsNQxerewWjRG+/EQ
         pgxo9MxcTCBwgxd96ew7I3oe4dUiTjJW1fA4eMu2cqVMUbZCf9F2F3Jmbeo2d2cFDyqM
         YZyxxa7KFc41bzJOqgCyaEclBNB390n3H0W4IrudyskRqL1BavvF9oB2eBDI3DZW0zos
         cT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpn2ZBHHmdgL8rvIqTPfwNRS2H0QUe1ZxKLR0lAib64H6EPcDhc3HfkZOD+w1v269ZsajPgH0zfT+lKaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2hFI65DmFlOYhRFjFyondakNL3j3h6UtBVjmV4p5Q21S0iRK
	oJgl5LboU4it18caSXENcuHWqUXfKkW4j1BrDDP0kXAum0tBPOH9l13kNiK4Q8eFV0fwFyW9Cu9
	Fze4yW6y2Da9qi/QJEuLHkNzd2nAVqvHCYsrZhTda6JfYQJPPCYc=
X-Google-Smtp-Source: AGHT+IGL791QYbF0kzcxMmzPYHGq/lMsQK/STAf8o+ZpSVkQmYBqMW+XKfd6iiKtJPMEaRUNe0uqRDFd0YDgbwU1M7E=
X-Received: by 2002:a05:6512:15a8:b0:52c:9383:4c16 with SMTP id
 2adb3069b0e04-533485ae52fmr3332766e87.22.1724322230982; Thu, 22 Aug 2024
 03:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819082445.10248-1-brgl@bgdev.pl>
In-Reply-To: <20240819082445.10248-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Aug 2024 12:23:39 +0200
Message-ID: <CAMRc=McD=3_+XqtPj8Jum5Pz29S+NAZn=M1yJ=z5bQ8CympNRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI/pwrctl: fixes for v6.11
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Here are two fixes addressing issues with PCI pwrctl detected in some
> corner-cases.
>
> v1 -> v2:
> - use the scoped variant of for_each_child_of_node() to fix a memory
>   leak in patch 1/2
>
> Bartosz Golaszewski (2):
>   PCI: don't rely on of_platform_depopulate() for reused OF-nodes
>   PCI/pwrctl: put the bus rescan on a different thread
>
>  drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
>  drivers/pci/remove.c                   | 16 +++++++++++++++-
>  include/linux/pci-pwrctl.h             |  3 +++
>  4 files changed, 42 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>

Bjorn,

We found another issue that will require extending and modifying of
this series. Please disregard this iteration and I'll send a new
version shortly.

Bart

