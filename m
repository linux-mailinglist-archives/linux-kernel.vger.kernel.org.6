Return-Path: <linux-kernel+bounces-556651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A0A5CCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EBC3AABF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8C8262801;
	Tue, 11 Mar 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X202CRt+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D83262813
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715725; cv=none; b=YM9iSTtXk3HZ+Ze5AQbYDHwS8PBF06IkMS5LCNBASIrVbgrlnfUyaw+47xPUrMUaqASWVhBQnH3fHzEPBhyVxHLP4uKYJB+gU3RwIzVjNnG1dZwyEeZsiP+wxw00YBeos3iqiz94qirHvwqxTN+yPl764I1UJGXmI/md1HoFxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715725; c=relaxed/simple;
	bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHIPkUqJAIMKDfGspZvV8C8tSCA+8UZXSAwT0MHxuQMnFNzEfhcaHnkGESnshU7HP6iIz+ukU0loumwtnK9FeVRlLQV3O+1WrG+qjePrgVaLq7q2IGku2LVkT9hJX0TmK5ryBBlurcDYrHfV16sIJASjbZ7n2MEi5L7ZD81qQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X202CRt+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so1280a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741715722; x=1742320522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
        b=X202CRt+gCMHFjrNYwR/xLe0GLUo/cIc6w/r0Y3k8guDb7Vhqig7OiDvO8ow5vD2MO
         70mQ2g/Y6RaW5c/3sE2h2DLgEpJy/R0a9OPAiF3lTimp427NstZcgwl3Fpl/bl2y/bvT
         lqEEaSqq6K1EXPKasJLKNyPdjOCqWxXwBnWypE/5o2hD6eou7zw0koW0+Xtpz4YQTgVX
         PqNprvOj04eOAlEkcwPnOzVhTA270inymS4W9SeVM/4+FcquAIQNIzZWP2YkUGHpaB6R
         cnxm5YIVMhLHPrIXGPQPix3sV8MtKpHR/DIrrTwUu2iBXb3fRdjySerg4j3sdQAjoB15
         1bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715722; x=1742320522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
        b=dJGjnSUYJw32bQogYFsnkNn8KhndMm8+ySvJ2BVZkR3Kk5W6vwmH31qcPNlD+XotvJ
         kB8bCjoptduOrBdh+sLPwoWutO2x6To47ZzlXgzr6iom32R+rpO8GizGHHBFYa0sbwcP
         1VRjUiDJPqz3Bi75o0ZMbfNwHlNBSX7vLzbkx9vBmK7TPyB+NyiC2e0dKm3khlNXhI+x
         KnrTvCCvMnfYex/uiRinC7fM8LQ2qHHei7MrHPWJNOj9c5OGlFnf4KOkSV+gz5kVPFs0
         vJ/Pdam5MuVHuwHnCNKSVK7qoVwRxa9lWhX9/dF+FC0nSAzqh16qsZbdh7AT8vU3WoEL
         0WMA==
X-Forwarded-Encrypted: i=1; AJvYcCWwKRW9oFWaIawEHIXsq+I3hP93t8bqMdzogeCLCsVD9muqRvhLlV/jFmA+P6vk8vbzuFNtctOz/TjcA00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYKbkzrcw6GiYJjLTC3PKwdfZeNH6yle1EjyVBfn6zZdERohl
	I3TvTo0yTIQ0CY3EmGx+/gXNa3dxBS7eyA+yIF+te5jr0SCl1CQ0gYhHJgjgWiTJOVv+OaNnphD
	P+AIow4rHKOxXasl1sDo8UZ33+C0F8TjKjPda
X-Gm-Gg: ASbGncveWkrmmPrrDsUXoJ7og514X1s2bZRuOPjYqBDsM4BvQ6esWqvmixDDJdyexee
	HiFEf36ag8oHnkwJGjcd4DR7mBqwHwNsbsK7I95N7wg9iGs94KEKn3uyA7SJAJm03cO/V/XjSL7
	1ue6HyFmsNLSgY5elXpW3RmOGHKSSaJcQiHgxXqMQn86s2X3TG+uqMAkY9jUvY
X-Google-Smtp-Source: AGHT+IHBou0AMnOc1wlERmQEiByjC9z6tx0SCc40GDDV97vQKc68PhQO6ik31ktuvMGhrIBUoFtdSF1c+d39GaMkrhc=
X-Received: by 2002:a05:6402:2048:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5e7b2684877mr140a12.1.1741715722207; Tue, 11 Mar 2025 10:55:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
 <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com> <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
In-Reply-To: <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 11 Mar 2025 10:55:11 -0700
X-Gm-Features: AQ5f1JoKKBbJ5USMaxKYhA8jhl8TuOZ3b3iaSIOxkea3mVVta9KFMFOusPuFh1Y
Message-ID: <CAE2F3rB-ACt2rdVFYSpSap=t_poTi0-PxhgrYGg4vzjfic7vqA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:51=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
> I am working with the android kernel. The more recent setup enables a
> minimal setup of configs in a core kernel that works across all
> supported arch's, then requires further support to all be modules. I
> specifically am working with tegra devices. But as ARCH_QCOM is
> enabled in the core defconfig, when I build smmuv3 as a module, I end
> up with a dependency on qcom-scm which gets built as an additional
> module. And it would be preferable to not require qcom modules to boot
> a tegra device.

If you want to build arm_smmu_v3.ko, you'd have

# CONFIG_ARM_SMMU is not set
CONFIG_ARM_SMMU_V3=3Dm

in your .config. I don't see how this would enable ARM_SMMU_QCOM or QCOM_SC=
M.

