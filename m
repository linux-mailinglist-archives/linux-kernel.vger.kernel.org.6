Return-Path: <linux-kernel+bounces-279953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D794C3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384BEB212D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19253190489;
	Thu,  8 Aug 2024 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn0+rqgC"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7213D8A3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138505; cv=none; b=TGGXmOoOI3TjhEqxUZl2Muo9RFjc5z3SKUHy4NjCGiPO5zV0KsXELqUP1u/XpUSMPwPuIBgKewJ8wL9R4AZYB8xXShSSg8e64QHEj8wC5QWZgylzPwP4vHoYnx+3LHJzazj/+RzsCcZQggkKpvYX7NojPoRmsU1//0eWzn4lkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138505; c=relaxed/simple;
	bh=8KYFidw8hrpQOyjPQf5i8Ok/To5dJrpwoNzBWE2dnNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4e6TZBB1TEP/m6vgw4hUjUK44gi/PNkrabeOFDXi5Hk8ezyhv6iZgxgfIU+RNtRuiQFAopSIYGL6u7H5FCgXbu+NqodpjcDdmA4nDy+5m34dUiC81KSMeqcIlj2tx/ciSpDmwqDOXBgtWhUe9UWDGP+Fdm1DCyiGm23fjcPHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn0+rqgC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso1083743b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138503; x=1723743303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=diwD1iCrpHXumZkgAMloBVGIf2kIwgitsF/BakIzCjE=;
        b=Bn0+rqgCrMjEC+RMKKvyCzH4PHQGUyZ+wYJk0phqp5F/LCqb5sh1lJ015wdfC+uKi2
         90HLohzrpRN2TvHuky40PylAIppOScgsjI3uJ6G5OOpD5AU7Dh3v6A34yImKR0S1tDFu
         /HvsqogoBMmewykzdAbmoJZZZvXC71pOBhu7B/9g3CSNHvhaqbrZ3HyIVRkpbLY9ktfu
         hKJXFkGjYDO39MCzmp/C9q6CrrAoqZUIL+X/Fp1iAEf8dXk6tqpnI3h3fYv6DJoo6oPP
         Ce8rfYmTfalQd7t7m7iwDyq4UHTbq2Oadv7Rs/sCaRxc9nNRe+jfCQdb60v77uMbR58+
         ilew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138503; x=1723743303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diwD1iCrpHXumZkgAMloBVGIf2kIwgitsF/BakIzCjE=;
        b=dMJrAChD9Vu3cB4GNpsDT1Ycihzi8KhAF38Xwb4vOneqU8BChXn0M1hoAxTp+MCbO1
         7BaZbD7Da6cXQxUJD024JdKZHdkgrjTZqflVMB8wjtNlKEdMgJUdFdke0A5J8U7J6Uu3
         JelxOQhg30UWLn9rUmGShEAXLAccvBYU6+1p4kVnowd5SWJrZrthKNlJsaGJ/Hs55WFR
         tgSQl9wevCfzBWvCjrUka4kTUznWNJyBFXihmQXHTrJd5hMsr5DzjZOyS7ZVDoIsUsvO
         1aMQrN0B1EQ76FNQZpxUZcZYOSKa7ylvYwaLmEIjIfx51sQOsAzVL0RDY6K656cbAVFm
         jmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc8nKhAVA+lpN1y6iKmegGxFlhvVDn4ZEK4ZavuEX1yrUM0gXuAP+NjnELNrve7WP58KCuKTHHj3vqWSLg2graopswQj0msmtIFGWU
X-Gm-Message-State: AOJu0YyRefHFjA829kw8Z5NXy63YceWZ+vdeU4H88KCYGcZ52vpRTd07
	qLODIBx3ET0Zw+8Ot9uWPw5FAkG47nevE9p/n8pEetWqGPKsGUxT
X-Google-Smtp-Source: AGHT+IE51YiR1kStYj12rpo+NUS09VqpSsVkvxnS3g7oMwKAgam1hLO0cnWbZ/U3GDmrQEv657ePjA==
X-Received: by 2002:a05:6a00:2d95:b0:70b:cf1:8dc9 with SMTP id d2e1a72fcca58-710cae7174bmr3204310b3a.25.1723138503114;
        Thu, 08 Aug 2024 10:35:03 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22f29asm1363716b3a.63.2024.08.08.10.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:35:02 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:35:00 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@rasmusvillemoes.dk, Jonathan.Cameron@huawei.com,
	salil.mehta@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH] cpumask: Fix crash on updating CPU enabled mask
Message-ID: <ZrUBxOggWNlt6lP9@yury-ThinkPad>
References: <20240808040808.647316-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808040808.647316-1-gshan@redhat.com>

On Thu, Aug 08, 2024 at 02:08:08PM +1000, Gavin Shan wrote:
> The CPU enabled mask instead of the CPU possible mask should be used
> by set_cpu_enabled(). Otherwise, we run into crash due to write to
> the read-only CPU possible mask when vCPU is hot added on ARM64.
> 
>   (qemu) device_add host-arm-cpu,id=cpu1,socket-id=1
>   Unable to handle kernel write to read-only memory at virtual address ffff800080fa7190
>     :
>   Call trace:
>     register_cpu+0x1a4/0x2e8
>     arch_register_cpu+0x84/0xd8
>     acpi_processor_add+0x480/0x5b0
>     acpi_bus_attach+0x1c4/0x300
>     acpi_dev_for_one_check+0x3c/0x50
>     device_for_each_child+0x68/0xc8
>     acpi_dev_for_each_child+0x48/0x80
>     acpi_bus_attach+0x84/0x300
>     acpi_bus_scan+0x74/0x220
>     acpi_scan_rescan_bus+0x54/0x88
>     acpi_device_hotplug+0x208/0x478
>     acpi_hotplug_work_fn+0x2c/0x50
>     process_one_work+0x15c/0x3c0
>     worker_thread+0x2ec/0x400
>     kthread+0x120/0x130
>     ret_from_fork+0x10/0x20
> 
> Fix it by passing the CPU enabled mask instead of the CPU possible
> mask to set_cpu_enabled().
> 
> Fixes: 51c4767503d5 ("Merge tag 'bitmap-6.11-rc1' of https://github.com:/norov/linux")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  include/linux/cpumask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 801a7e524113..53158de44b83 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -1037,7 +1037,7 @@ void init_cpu_online(const struct cpumask *src);
>  	assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
>  
>  #define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_mask, (possible))
> -#define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_possible_mask, (enabled))
> +#define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_enabled_mask, (enabled))
>  #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
>  #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
>  #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
> -- 
> 2.45.2

Thanks Gavin. I'll send a pull request withing this week.

Thanks,
Yury


