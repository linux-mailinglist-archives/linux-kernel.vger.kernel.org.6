Return-Path: <linux-kernel+bounces-394457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADBC9BAF5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C151B1F2137F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01541AB51F;
	Mon,  4 Nov 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLak1cwQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0636382
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711718; cv=none; b=FgK9KX7wYWnuVYeOwAPpCrrPIkofnRjkBTYkqsvIYcCDrEPM9NSgojdGK9qmuKGUhLwV5Y//fBnbnMnigH5WFs2RlyO3NuHkeS6oVCq+oHGCePBWx07P5VX78SBL4ELirERKX18p++x9CgjYQYAyXntlHaoq9VJ/7joTd6AkW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711718; c=relaxed/simple;
	bh=dYVkoC8qQAE2PBdJGIGIvHnVo6H9gaMACJ2ZD4GkPTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDt4WKkTttlp/YH+ftZabl4Dc7z4pZAcPGGzlxFCl0u7GxTH1yxB1i3MgvCcfSES8LmCyKzxQeUjxdZCfEcPvikfyYsXzR9mB7TeBKXfKqTQUfFHxfCkVkg7hHr084zTtFpjjdBAywtYtPSiEjDBqfpS9fV0hEPOob32VX85gY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLak1cwQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99ebb390a5so910422366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730711715; x=1731316515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYVkoC8qQAE2PBdJGIGIvHnVo6H9gaMACJ2ZD4GkPTQ=;
        b=nLak1cwQkMsgikLT3BpGmHLoglmJMlGUUKCYJ8h4H5D0PFEM93mTn8jfW43MRM16Df
         bIGtnE22JQL8WRTNcjcS/u9hpk0ievJpcBPSIp1MxnGYCooiqzsqZ7Bg/I6vawGqMG+w
         ScJmn5JA3hMXVDdH1PX3hhm1fcPDSo7DeBQzr7gfIUydd52Iy6LcomHovmExIvn0HrYV
         2hjg7BJgOmpPEumb3sXujwfQLgO6JUHshtQ+8Zv0Zb2fxvTrHR0o9hwubTd0dbnO9HPP
         jt9Oct2zw27xZmMCdsUtXsRVhFT7EeVQM8dT8hjFuOFzEwO2vs7gVWnHeDuTqF1sTBMj
         Trew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711715; x=1731316515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYVkoC8qQAE2PBdJGIGIvHnVo6H9gaMACJ2ZD4GkPTQ=;
        b=QNtWtwAZdyOV49DVhGrEgcDWckO8yqF3coluPEPARFsaqfSaF2hqdkgjal5ZMMvmMY
         lQaoeTRPR8GVRnAapiyE9XzHfVn/semuPEXxFu9cXyfMnTavrK0BofnOvFx7yfssI5dB
         YImY7wVo/9vl5rDwhb7ihw4wvnV8KMNX38v592YGmKJZpAINfgSi+7dCfsTn2X4VE4Ln
         aSR9v5fxRiHzcfnwZKJVGPF8jfsJVqTrba6wXJNlEHN2+NUSSP58pR0q0IdMhP8+ZZjt
         gJhWmjlrBOaLH2YZ8nW9JPJhf6kXrscmFH0W3c1uFGs9+VRCOTmomDilQEVwSKNEDrBa
         eJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCVT76UUTo63XUelZ232vKumPdd09SGwWAs7JiyTX8KJwORVzjVuGp+KyezYPxPCyqYbSFwkWIELa9a4Y6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmcgYmC0WRJFA2nS5mqqILvnQjSJx/YhnwibAt/uaKkIrFd5c
	+blldfYD8RU3IdImmTnFXWFtUvuXNdEL7mOE9IdG9Am8tCW/uGl+yp25vXs6yA==
X-Google-Smtp-Source: AGHT+IEvXzMmWnK2YXMCd9hjcHNO93GnMVMN6VzlMlbNRo53oIfLHWGpTiQQ4J66GXfSZmVa6UQBeA==
X-Received: by 2002:a17:907:82a0:b0:a9e:85f8:2a49 with SMTP id a640c23a62f3a-a9e85f845a8mr437389966b.8.1730711715040;
        Mon, 04 Nov 2024 01:15:15 -0800 (PST)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564cc5e4sm525678366b.89.2024.11.04.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:15:14 -0800 (PST)
Date: Mon, 4 Nov 2024 09:15:11 +0000
From: Quentin Perret <qperret@google.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	daniel.lezcano@linaro.org, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: EM: Fix uninitialized power in em_create_perf_table
Message-ID: <ZyiQnz4jbB5ChNxn@google.com>
References: <20241104090351.1352997-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104090351.1352997-1-ruanjinjie@huawei.com>

Hi,

On Monday 04 Nov 2024 at 17:03:51 (+0800), Jinjie Ruan wrote:
> In em_create_perf_table(), power is uninitialized and passed the pointer
> to active_power() hook, but the hook function may not assign it and
> return 0, such as mtk_cpufreq_get_cpu_power(), so the later zero check for
> power is not invalid, initialize power to zero to fix it.

Sounds to me like a driver bug? We check the return value of
active_power() first, so if the callback failed it should tell us.

mtk_cpufreq_get_cpu_power() should only fail if we couldn't find a
cpufreq policy IIUC, so why can't this return -EINVAL instead?

Thanks,
Quentin

