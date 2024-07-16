Return-Path: <linux-kernel+bounces-253562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B1932308
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBDBB20D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C56198837;
	Tue, 16 Jul 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WOBrzKTv"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D4196C7C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122890; cv=none; b=HGcAwz52346LrP5wxsl87XM+bJ9olNsUN37g5D8oZUPO9Oo38DtmOA4fMOLBS9oY6Uu7fASbaLo0aRVV5YsmCvDqqD0hshmV7V3RcJs2PVSDdESFwimdH4O3xvBaDCJQVnDfNJz7A52hRkPO9pK4VFsZDSWzUmAqc5dxGITv1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122890; c=relaxed/simple;
	bh=kCu7ViAfFTGSKcKtYOk+BTvymK6HJm7ucHLA5Hk7a2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/b1PJ0H0KFZLJoJHyD6kvQxnl1xgfWw7W6o6hJRy9TNZZG/kPeTLQwjdlcVyXYU08cqGRnGFled+RCsHKyI1+Nt5uOaCRkcZ9+Kw9FOqVAtK5zUFH5Bmh46FTREl+6AuE0QorYXNYWrcBo2eudm8yrenJFw2Mo3xuDDNTcgMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WOBrzKTv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so3187668f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721122885; x=1721727685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o81E+eA+Z+/fUswD0Gf7vsI8TV/mwuIk29bnHZ+1qkg=;
        b=WOBrzKTvfSgVvogj3DWgrZakZ4EWTf+LDt4PHpp1S4FSVqBbZpweBj188hiXwRCY9W
         c21xS8N9avVMsl6CrB2ZQVn6CUcw44l/k9PICnfktvVuWgqhbQJbrJpy9dq9+FI6uolg
         ggZPnZJrg5qvzfnx9L/PlNvmFvrEUEndDjMj9hPtodo9QVLHm+yoYCi2uFzNL1khSYav
         90QVZ9tV4inA8dMVikbsWHKm7nikdpRIAZcmp6ZdQOtl5/omNTkTMinwDhqdJlfpuhRP
         TgReGLWU0G61ikyNRF804J1Y8FKt1ZVlFhriSk9pJufP4eO8v7dMe8vOsgWEIJg4EzzS
         5UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721122885; x=1721727685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o81E+eA+Z+/fUswD0Gf7vsI8TV/mwuIk29bnHZ+1qkg=;
        b=Z9qXu/V+effOiOlxwn4E7zjyk1DpAiQdeegU5ziJ66TEN5f1HJ1NiwWqOpUaPvK7UH
         a2aa65dz4+D5y+kvbOXr4OodIQVmmh62uyiHzSxIlR6ncYAR3I0T7Pkt9YF+30gfZh6Q
         0Voul4zj6xRHLFwOmRijNb3yVdUbSt3fFeVMaRmUr4CNQVYRY9CbgivtCXpXrQwLuLuA
         OwGwW6cYJfPUZSO5NS0ceSaubuKeoDW3n+514rFTwAKK6DJEJE8fl5nbUwdXCL5YIVT6
         gJfz7id5ri706TBcrQmOOPkEdCjLrK412Zn20vHYCPfUKicGOd0Wlob5Ku8kgKKR3fSd
         0CDg==
X-Forwarded-Encrypted: i=1; AJvYcCVJJHiMHhOonS3NyBM2avoog9ZFJjq1x2Ol55Z04TgpW91Rod3Vc2liFf9rDDhp7cVfuxUGklnC53AHDogmQ0GCmCrwqiMO6o0Yi09a
X-Gm-Message-State: AOJu0Yxr/1MLUCa7xIJcFhb6PoslZAbaZNSzgCx6u3F7zvHwBCxlcGrw
	GDf554bQ4hrofOUBn2r6G+5olah3Jhwr8mGB783nhRR2cRXa+Aw336cw0jJKulC5dqT5C/XgKQ/
	A
X-Google-Smtp-Source: AGHT+IG0Kx8xJOaY6IxpoEaszZNktRf0EV0xzYAg/ECs3Y88UY/gcbJ0VaHAqm5UxeAS7nF9vBAWlg==
X-Received: by 2002:a5d:66c4:0:b0:35f:1f8a:e69a with SMTP id ffacd0b85a97d-3682633c1d7mr937679f8f.49.1721122884912;
        Tue, 16 Jul 2024 02:41:24 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db048b3sm8443856f8f.109.2024.07.16.02.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:41:24 -0700 (PDT)
Message-ID: <3e8f7fd6-72d1-41dd-a7d9-914d7f73c46c@suse.com>
Date: Tue, 16 Jul 2024 11:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86,spinlock: make disabling virt_spin_lock_key
 contingent on CONFIG_PARAVIRT
To: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, kernel-team@meta.com
References: <20240715131853.313c3bae@imladris.surriel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240715131853.313c3bae@imladris.surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.24 19:18, Rik van Riel wrote:
> The existence of virt_spin_lock_key is contingent only on CONFIG_PARAVIRT, not
> on CONFIG_PARAVIRT_SPINLOCKS.
> 
> As a result, a kernel with CONFIG_PARAVIRT enabled, but CONFIG_PARAVIRT_SPINLOCKS
> disabled will end up disabling queued spinlocks when running on bare metal.
> 
> Making the disabling of virt_spin_lock_key contingent on CONFIG_PARAVIRT, which
> controls whether the key exists, results in queued spinlocks being enabled on
> bare metal again.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Cc: stable@vger.kernel.org
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


