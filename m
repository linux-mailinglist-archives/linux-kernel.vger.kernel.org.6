Return-Path: <linux-kernel+bounces-230026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBB917778
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438921F22203
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6E13B28A;
	Wed, 26 Jun 2024 04:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eZMwmba+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF07F4FB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376715; cv=none; b=psWMrugo/1fy0jtNLG4oqGkp5voxLOgxrjSlrOHdjDLCfAiBnfR61o1R+H5PWqYx02hw6cH+wrBkyScO/YlSf97RZGtzuVsG5Uj25gqVPOlhgtv9Nd/F89mjPo3dyq0Kf9q59kKe6C24vpmZgW/xfP1RvGSpHnVlF5ewyLZvtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376715; c=relaxed/simple;
	bh=urO9PF41hgll0dRPTGLkmriEDOf5ydq979P37U8+EZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4Y3sCgHaVjchSBYxn7KH6sdcQ1wzTMGe7ofsIL2Q224uvCcNF/S0HQLBjSPbzgt3nfKS2N6SnIc4FNRDB2By6Z6UBGY+49/JWIQ1pv8eUAVyFIRtZ1fo/mHK3bZtQC+bRZEh11Sxn4fq5KPtbrT2SqylnEZBgVklWHDuFKJPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eZMwmba+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so5821126e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719376711; x=1719981511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqcce+viBw5891cRDW3KYK3GO/t8otW+H0eaejzqnZ8=;
        b=eZMwmba+Li7E9LcVjeWDlSsUa8HGXgXveRdYgpMxxv+xBemiw75vBi8cBXqfd4OHbx
         CWvVhfDseMdVWGeGnvyxpWVLXDe9D2fz7AbrJuuhDvRr36pp23wlKZOryx9R37UmuPzs
         AZBH077PBILZXsVj/IOUi0CLkpa0/c1vDr4rIDim4VOxzzUq6q7nkKk2lmbTSlKrWa4v
         ulSuqMGtFcoQAWUICwwRB8CZLTToxjPR2fw2M2PR0KN97/DH7YjNyZWKNmfCZDzRTM6S
         2DESFasT2RCFcBpqb8ZUp2kdF6YfjXZ7ZVeLkZuMvkul42PrtoQaBznx+zdwPPi0qu7u
         HIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719376711; x=1719981511;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqcce+viBw5891cRDW3KYK3GO/t8otW+H0eaejzqnZ8=;
        b=TnoStBpW2J5UYhWKokGVU6W0M6pYjBps0qh77JPEEaLITAX2CVIpXL2wf/f/SEQ7vZ
         fYB1IBPRs02CINq3e26mU4otictnvzGfplOJ7nowNDAdlzWNgXHk7Y6lXvTRhJDfKFIa
         rh5O42WPdWOboCgxBoPeI12HqN8WRCAMfy/Fob+5qig0VQcAMsFD6BxR5CUJT5NXOEhU
         RaV9TsAQ8vMeFnixREJY3Pt8lsKC9C+ZXdC3jv7UdmBl2g5F3pzhmkXCO+/87EataSIL
         CYdIAs96nzxO6g3CXyM7rsiyzLaAlcKgMFS2RYfr5wxVAaO6UrXBBs7vf8rWn0tfBLGQ
         t75Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVV3GMahjXSkaGZCjSWo94hCfgX1DCAfro38GsO3iE30NpS6FaA7NbXAI4Ps7M7llfSG/7YDBwne6nXjgY1PBPQLN3+PDStWb99NGM
X-Gm-Message-State: AOJu0YzIJwpRrYq+yGGzu0HDLfJN4SW8++EhqjiIlcROV0NyR7+NGgvI
	ycvMwIeWQF28V4iGMGCRtLnXvizHzavVD3Wd+PiCTTg35fCELprbVZV/aqpXHVH2iKkoBM5WUfS
	m
X-Google-Smtp-Source: AGHT+IFmIWttdaTJRAvIH8UrjPds8xvnf85HM29QagGQ7d1YSELkyFRIvS+iI6cQUa86E2mDA3DxXw==
X-Received: by 2002:a05:6512:3da3:b0:52c:e728:cca1 with SMTP id 2adb3069b0e04-52ce728cd5bmr6009512e87.39.1719376710614;
        Tue, 25 Jun 2024 21:38:30 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8285f5csm9826695e9.25.2024.06.25.21.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 21:38:30 -0700 (PDT)
Message-ID: <0844686c-0108-4267-87e0-a79531dbeaf3@suse.com>
Date: Wed, 26 Jun 2024 07:38:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Chen Yu <yu.chen.surf@gmail.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240625125403.187110-1-yu.c.chen@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240625125403.187110-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.06.24 г. 15:54 ч., Chen Yu wrote:
> The kernel can change spinlock behavior when running as a guest. But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> The static key is always enabled by default (run in guest mode) and
> should be disabled for bare metal (and in some guests that want native
> behavior).
> 
> Performance drop is reported when running encode/decode workload and
> BenchSEE cache sub-workload.
> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> is disabled the virt_spin_lock_key is incorrectly set to true on bare
> metal. The qspinlock degenerates to test-and-set spinlock, which
> decrease the performance on bare metal.
> 
> Set the default value of virt_spin_lock_key to false. If booting in a VM,
> enable this key. Later during the VM initialization, if other
> high-efficient spinlock is preferred(paravirt-spinlock eg), the
> virt_spin_lock_key is disabled accordingly. The relation is described as
> below:
> 
> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> PV spinlock                    Y    N    N     Y/N
> 
> virt_spin_lock_key             N    N    Y     N
> 
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
> Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

