Return-Path: <linux-kernel+bounces-218855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD890C712
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8FAB23ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D514EC6A;
	Tue, 18 Jun 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pgwnvjc9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1814D71C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699089; cv=none; b=YW94dR3N6SqmmG9J1IuzQRyHeTaUSZFdGjCIPj4j78H6RecMAxYegEGT0cUep8tGm3Oo3fv5GzmVznb/7TuoCjVQ6fPrVX/imCfK/Dr91JqfoZ/j9jj4ZeUL5iIwaHOvEQ8HBE97FSbpvl5A5nlPrMk9gihHWU9zU6ISnUHmuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699089; c=relaxed/simple;
	bh=pbDziqPI/WoS/orp534a2HtadGyFK22CpztY1tUbZh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISAWnaxzqRwRZ0W+m6plCc77DPUj06FTcGDuHcoouEd9Q9vF18rJRcY4BZOhPFoy4JVoIsU+MmrRsEIT043lv/6vOHOiaIElUm1H60AEWFu0nSXTZCMhw1xE0tuNAcP0jKJWQGDdAz3w07hKql60tlDOL4tLFTw7hl8a0ZwGNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pgwnvjc9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so32020415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718699085; x=1719303885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdSZOLQOwQN4pDV3GxSPxLcKEx0R6yJdz5wU8m1ZtRM=;
        b=Pgwnvjc96RWvYm3/aEZOWZpjmpB9xtFn0eyFBMswHyjG2Und6C/4QiDf+5yWHL0fqp
         yLWTdaU9Qk85o3jaWTwJFZxs34+Vw9WzsAY26J3KvIWEFxSUhvpfHHIACZwbzopf7zOA
         IUjksoOoOdLDShH24wSn8w7wdE0jZ74IWR9KF2vTbg7Rqf4tayk3XGptTQchhj8wyuJM
         K7KGVkgGtJVfCTUGZUi1LNfUoeTNJ3hE5VraM5qOU08MwS+VypJg5E6ezzGHBqJBIBp6
         Kqy/p8eRQFFRYJlgL+ST8CucJwkH5ZEW2t7UnKTfAiXD+f5NeBqzUKd9ATsWD7cZ7En1
         Nfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699085; x=1719303885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdSZOLQOwQN4pDV3GxSPxLcKEx0R6yJdz5wU8m1ZtRM=;
        b=QkxqGJudFjg/lMM63s2DR73nacbQ5too5c+ircIuGsokVuFI8+slptY5k1q+ZqZFMT
         BnClJBhlQ/pvAe8BSO8jx6gH+KQAPu1k03sksi/lq/0Wa0BOPiRkCEMfIxCor+FCNXlt
         esByaYJnX56oZ8Dn2Fp2ujVjWGxXHt8+YrExkFFSICTEvWDpjEMzoOkh5LVsbMwWlEX4
         URBrX0hJm20C/3zHiIlyNNGWTgDYqFF9qofeSNc0G3HKU8q5CTe40fI85OioNDuBF+aS
         TodkTHzbhFPhzOKU5wtIXAQJf+mMHqwcBHU9AT7OST7jqrvMRaX0hb8i986EBcUF6J0S
         mTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg7zn2wxnYQ3970HxENdv3QXTyjNYHmn+8FfFsAjUBFu3JiAczbReInrlxgiBafMRHGfh5CG01mwo2pAawHShDhnsP3s7WDzTppVkA
X-Gm-Message-State: AOJu0YxaPmQ2d9kchImSmCMYUunswmX48YgR/WYdRGwttRMvVi8UKt4I
	I6Le3ZP85ekXfnf9B0DLUHilvqWs11JJJ0Jj1w4Tc0sfMNyQWOSiCGJXdW3eQNg=
X-Google-Smtp-Source: AGHT+IEMTh472tGg2TlG1vDvd0yUcn+uDzW2Pp6bl99LkVV30JyfLW2jhEBMA9p2+F9DdNBT2sENKQ==
X-Received: by 2002:a05:600c:4506:b0:422:291:6b3e with SMTP id 5b1f17b1804b1-4246f56d2b6mr15871505e9.1.1718699085348;
        Tue, 18 Jun 2024 01:24:45 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c7e5sm13717250f8f.30.2024.06.18.01.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 01:24:45 -0700 (PDT)
Message-ID: <c83127de-b59a-4475-8d20-e3582ee2e6f8@suse.com>
Date: Tue, 18 Jun 2024 11:24:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240526015847.14142-1-yu.c.chen@intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240526015847.14142-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.05.24 г. 4:58 ч., Chen Yu wrote:
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
> Fix this by disabling virt_spin_lock_key if it is on bare metal,
> regardless of CONFIG_PARAVIRT_SPINLOCKS.
> 

nit:

This bug wouldn't have happened if the key was defined FALSE by default 
and only enabled in the appropriate case. I think it makes more sense to 
invert the logic and have the key FALSE by default and only enable it 
iff the kernel is running under a hypervisor... At worst only the 
virtualization case would suffer if the lock is falsely not enabled.

