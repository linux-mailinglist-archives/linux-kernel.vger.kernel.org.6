Return-Path: <linux-kernel+bounces-247352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100D92CE59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCC61F22341
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1E18FA23;
	Wed, 10 Jul 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Aha13ut8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B418FA0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604382; cv=none; b=VEWafUCcakf1UY+25KdT6i9r6leAYmUj9UVOMVKq/c5IEkTJz0gaLRa9Anc+wGDymbZUTxtMwxD5ZYKBX9Crtr9P41HTK9jSpbVZPMfQbPST+CA85CKP8WjmaGzEzLzXv5xfHz4ogQ6MSHb4a5tJ3JIEIGxSqO28xPxtgM7FtG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604382; c=relaxed/simple;
	bh=cxtEiy+7tR/t7lkZzdUeJaDgyf2ynisU5m3GLGZQV+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOTYfj+8IUrC0yqEw4TAKzzwMzqWmVbrHPnOsGLHceDwwMBsYpqzn7qOtkq8M9stRdZRwVXPiCE9oKqmh+ArlVQlu8jX3d8VKQyGa+1ZxH8pR0fMwwvP3Bm5DNI74lj7tmHDvHWj8ZwI65FZiErEHX8fxsQKIpP+srNwwHnwLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Aha13ut8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea952ce70so4246190e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720604377; x=1721209177; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARVuzbVHjxxG9dv9mtR/lCDpdt7FDrvxjkqdsUuuHF8=;
        b=Aha13ut8dblHu0ABPDwI2kSoZ9SFD7Bvf9rgZkld4VATzEQYgx0eqIQzx/2VdTHpF2
         1px2UkPPqR7oAUuqUcxiU6tjPtw0R9od6D5NJUSad2M5uHptuV15ayLc6vU7kw1umRkn
         O3BMOBo0OiXN94YsZyal9FZI5gFK3HCxit87kyQns7z/skvTDwEb5UlKw690vhHkTCFU
         iDLJBU5KTYS/kUcljpKezM1pkCXLUDTUkCMxwsl+FbmBvIYwskC7ww82+kRng0PuPI00
         mbGXVe9M8464iY2JEH9UY9ZmqLseW3zx+mC2r+NlRIHfIQtsLEZvpW4q7s2OTj3HsPQ4
         EsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604377; x=1721209177;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARVuzbVHjxxG9dv9mtR/lCDpdt7FDrvxjkqdsUuuHF8=;
        b=UTsDspGy2ZUdM2qEzEukvpvk9OvmuxcoCA5goH0AI3flAf+OMxw/HQp1xWDtAUkLtw
         S0ZvWZpoukVwfGbkW1Cr/jfAiz946WlLAbdjVHF1cqjz50dZLZDBwHawlv2/y+xZK3rN
         Ik6pCPRi8tabr2sam7iSAogCNvdK7xUyC/PsKS5dUkTiHf5Sey7AXHhDf5xmq+OEfuqM
         0lvVTnggvYeabvEnEfX1mq23cgNWmyDYNwbcp2eOwSkomErcUjoyuoe1XRGTVu2+y+23
         QB5p1cKNd0aBdz6x0rp1vkYMNXGapfRfy6Iuz+cFKRJJgonkSKYXSKDmFr/FhnQW/bt7
         qE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnynFcUIJAfpOiPQBitdw5axgA3V3AUyjbKpCrupl4XtJrSWH3uYd1EsMyBzqmOEVjz9E3NodycMBVvj/BQ44x9iiJTWJSkFaJ6ofl
X-Gm-Message-State: AOJu0YxNxqvAP8Va8A28bjIjspTgXidm7/XjHu8c6cbo8iMMFetsXioX
	b/e25a63O4mXA3MqxqdZ+mgfbfLL/8wlnzLeWSMLgacDijoxmij127XXqzxNYJs=
X-Google-Smtp-Source: AGHT+IH5HuyWqm0xlysU+IQkoWroaRhheIPJ9ojT9MNnUnqo/Xdu38e9HBXnOtzD4O+1giys97jgbA==
X-Received: by 2002:a05:6512:3b82:b0:52c:fd49:d42 with SMTP id 2adb3069b0e04-52eb9990d58mr3224222e87.14.1720604377061;
        Wed, 10 Jul 2024 02:39:37 -0700 (PDT)
Received: from localhost ([149.71.16.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74159csm73618475e9.42.2024.07.10.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:39:36 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com
Cc: punit.agrawal@bytedance.com,  sunilvl@ventanamicro.com,
  jesse@rivosinc.com,  jrtc27@jrtc27.com,  corbet@lwn.net,
 aou@eecs.berkeley.edu,  cleger@rivosinc.com,  evan@rivosinc.com,
  conor.dooley@microchip.com,  costa.shul@redhat.com,
  andy.chiu@sifive.com,  samitolvanen@google.com,
  linux-doc@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Anup Patel <anup@brainfault.org>, Yunhui
 Cui <cuiyunhui@bytedance.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4] RISC-V: Provide the frequency of time CSR via hwprobe
In-Reply-To: <20240702033731.71955-2-cuiyunhui@bytedance.com> (Yunhui Cui's
	message of "Tue, 2 Jul 2024 11:37:31 +0800")
References: <20240702033731.71955-1-cuiyunhui@bytedance.com>
	<20240702033731.71955-2-cuiyunhui@bytedance.com>
Date: Wed, 10 Jul 2024 10:39:35 +0100
Message-ID: <87jzhtmvqg.fsf@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Yunhui Cui <cuiyunhui@bytedance.com> writes:

> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The RISC-V architecture makes a real time counter CSR (via RDTIME
> instruction) available for applications in U-mode but there is no
> architected mechanism for an application to discover the frequency
> the counter is running at. Some applications (e.g., DPDK) use the
> time counter for basic performance analysis as well as fine grained
> time-keeping.
>
> Add support to the hwprobe system call to export the time CSR
> frequency to code running in U-mode.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Acked-by: Punit Agrawal <punit.agrawal@bytedance.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 2 ++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
>  4 files changed, 9 insertions(+), 1 deletion(-)

The commit looks ready to be merged. Will this picked up for the 6.11
release?

Once this is merged, we can send out the DPDK change relying on the
newly added key.

Thanks,
Punit

[...]


