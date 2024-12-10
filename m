Return-Path: <linux-kernel+bounces-440325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005699EBBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5C168695
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68023236C;
	Tue, 10 Dec 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nz4ozdC6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BF232362
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866069; cv=none; b=hF4ciSTgSF0qO3WTtym3fgBlPe/7n0o0fi2KDjio/p3A8CcTJYrylBJ46blVZacE1hd6tKvIbZUxkIVPq5y0AsxOo6lg5wXxzK0w3XRnLYNmupPDGNrYEyKS8yQy1ueo51kkr5xNu+Y/O3sUILOjJDrjFLP/iq2YDkChsLFG0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866069; c=relaxed/simple;
	bh=Wj6GJ2swJpdXPIA55sjM7Y0DDbLPXovMHvENa2EydwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPjxzr7DWbWCnETP3pd7+TWjBMQXBIZGYF+VpZrDwih3lh16ydCKvJUmbLoiHja/lUJmE/b2QJ31xYwSMNeBcYBVBgU1LbEOiegvMpAaei87x+E0as9huf/+kp3PPefbtdahB/hrFQM2Ub+NZAgeCCN6GUR4zeFtG8qj4h5qPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nz4ozdC6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2162c0f6a39so578345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733866067; x=1734470867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/YuPzifs9jEt0j1RwPUAZ3kuyk16V3hz+9XJwFbKNE=;
        b=nz4ozdC6ontgr2MU6OQ/R39a6clr+p2/WzUQioBRErt10N0NOaHA0MG3m0XR/p97Hd
         Mh82geW7j48sm4JZLTCVUbviodO4qIr9Q+/l6iAzf3WHXpWlEDQTduvjBRZFgIQ5BTgu
         h+KYWJsSqjgFnBg3SRL6Fm7V+gOVN1Au53XV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866067; x=1734470867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/YuPzifs9jEt0j1RwPUAZ3kuyk16V3hz+9XJwFbKNE=;
        b=l4X+W4c1q8q4PFMwyQGVy7zstsDmR9m0VAW8g7MuRTDiqPegGc82nFy7qRQ430mNFg
         t6QOxVH3l+h9s7E/FTQi7QE7VKbGknZohcW0tny9Hef3qWRjraYg+Kdo7V0FM5SMqHUi
         u5pHYIycR4Bs5wNGdK7KISrYd7JorkHsVIYs9DLE9KfotxtUlIsR0nD7Vi2wX4DuoIhh
         1EkNNIy1/icd0yFk2x8u1HU1lecs9vUbPRCxrTJ+URkGOd9gWYPf+kMAUxCCe4+Madjr
         9uGdso+8Pj8eKPwbMHB+cfYePAwGh7u9tMaQXHfCE3sfStZqDbgGAI51jxW/G/NKkr8v
         yXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv1CyfiKPXcFhDieFekmz6S2Yy50J2ah4+uVeHxcvm3bZ1iRQ6bMMm60dTAjFrcrSZNBULEFOhcr6pMGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PxdDbmC+YeCPKcT8PVuPysK8u5uZ+6VxYhqnHPZh4AWraJ4M
	6hN5+4OVZr7baUa1Jpv6r4UkIC+OTOMDbX93RM7EoR5AUVAhJricSkBB16BcYFMXUFGa2JThTKQ
	=
X-Gm-Gg: ASbGncsowlf7sRYJ2dXPK0ht5ZZ+C2jehS4j7/4r7Eed6DEATTVoqfVyec5+qr0u1YC
	GpOxt/LNrKCV3GEi2dRNLeZMgmuR5DIVTPp/jL8iOAv4/uwnRh6qhIUCbyeYv2SZZuS1h1hwwmm
	ipkLg99mRck5mTQsvJB24DhmNbrVRPDN6cICCzekZOmcLhiljKYvGFGNDkxmh7EVbQVPuGWbqWC
	fNEkIdT4wafEiKXKBnUc1UuYNp8/vcqfvkXVp5HsyV4cT1u3H3YDWd9QZtV+j1kF+3GHDsUZ/lR
	yrXInh7HCOjwNrc7x5DY
X-Google-Smtp-Source: AGHT+IHOAzxnXNiY0ZzNBa703/wI0CU6F2qIZBXNP5Kx+nbaQ4B3KRoT9SjXldr3aTHh5Qaf3qo2QQ==
X-Received: by 2002:a17:903:186:b0:215:8fd3:d1b6 with SMTP id d9443c01a7336-2177a55c01amr3947085ad.23.1733866067088;
        Tue, 10 Dec 2024 13:27:47 -0800 (PST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21779e0f7besm887085ad.115.2024.12.10.13.27.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 13:27:45 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fc93152edcso53950a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuXKrqTzIUNy2fygDiL5lW9IRYniA5xnbMrZS/SY0lJE7FRIoklpKN4nZy85u55O3tOMBQrL/3Blf8WxY=@vger.kernel.org
X-Received: by 2002:a17:90a:b389:b0:2ef:ad27:7c1a with SMTP id
 98e67ed59e1d1-2f12878d1d1mr437693a91.2.1733866064580; Tue, 10 Dec 2024
 13:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org> <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
In-Reply-To: <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 22:27:32 +0100
X-Gmail-Original-Message-ID: <CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
X-Gm-Features: AZHOrDm_vFiL0dGEzWST540Nxq4R6kmbJ8O_IagFBELPZMZsnuRVzRl-QCxx5C0
Message-ID: <CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 22:04, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:55:58PM +0000, Ricardo Ribalda wrote:
> > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > throws the following smatch warning:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> >
> > Fix it by replacing the condition.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I've picked this to my tree and I'll take the last one, too, once the rest
> reaches the media tree.

Thanks!

If you do not mind, I will keep sending 1/7 when I send v3, to make
sure it is tested by the CI. I will mark it as duplicate in patchwork.

Thanks!

>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

