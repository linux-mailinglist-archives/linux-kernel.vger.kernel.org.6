Return-Path: <linux-kernel+bounces-515648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B40A36740
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494A31896DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3E1D86E4;
	Fri, 14 Feb 2025 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cITCUtSy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA7190678
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567361; cv=none; b=pPbMyiR2fiaO86y3id+5pFbqL7NyIARqgh+kwxoHhprmhvreXv4SJ0Vx0JWZrzxRUshkXkTPtKW5R+uNo9rfsMvpZhkWRvLlPwhkgle/5KuDHW/vDaSupX1VgVACvdqv4HZVxCGC/GZr7Na7J9w7skjVsI9qZwYEftJKyn83HTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567361; c=relaxed/simple;
	bh=vKzXwq5pMf+Cn2O+a124M3vkaAOQZb/uGaicm7mz6VY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zi5kVRP7XRQeYJAVQqrZrYzCjKeKnu+Qfay5/4T9BGyl53nc5ZYLeo0A1GLYL9qEQMAXTO5L9payW2AX0T9BUtJiTmLzoX0nVrqFFPyMd1DdAKPKvrfdYYDnoyqNJ5Eghtb52fDZEswStFGdau3BgyOUuDhcvY3nUyhG6oR4NZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cITCUtSy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa57c42965so5349381a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739567359; x=1740172159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hPVnamJCNklDPTW4DMgrUa9tQl7K5aydlrq75IJUXg=;
        b=cITCUtSytdWUwGEesjtDMhhm4WGCJgsLGfIGv9JS4VJdhXaeIbHV0VR7fWKWX0hz2b
         qzXnfLoVC/TKFKca27F/+5EyftziEfWGrNeVmuVpRY76xCCYPm7cAiOGfBrEs9k2i5Ym
         U4YKuh9Ew+PCOU0s0YAo13x4HnaVw8dCaFxTtSo2elkB8WvqF0omg3C0PMG2UrPi+DF4
         Z2D5K7uZTOjXpFIyXyS7J8YDd3ATBmYmX2LZ7I8wOJCMow6mhkSvkWFjXR3Bsz4J4kDt
         y8O3fDc+xP/FRxSGVux9daV05uJQZw9zK3WyYNBVBTdGyg2A51HeU8GrbhVZT9mTjMvU
         Emiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567359; x=1740172159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hPVnamJCNklDPTW4DMgrUa9tQl7K5aydlrq75IJUXg=;
        b=iP8twPB9SeS+iGqmJRiQtpBE5r+s+33FU7IAMvT8TAoZeZ4KY3RwJ5D5AL8lqn4tqP
         fEEkiZnjOyQTPWaSKAQGC75jE7vEbKUg+FpUrPqKhkUbTBFJ3iNOt2WVyUiUvKvpDdkw
         kkKCUkADOsvQ1fNPeQZSo5VSL58YvmhmpoozjbgTGfLjgr33Idc0DRdzpnm2fy+1nQ8g
         75SdiTOZZIH4tVI1QDIBDOdw8Tjqxd+3fH9S6UUDGV3LnYHe0MtUSlur5CZRkHjNeFU9
         7kOEDzOT56Ntd3f5J9v7hWn3QQvUQg1za7/bfafXL+6oK5y1K3Y31nw1mVCQjLBOHVXw
         0tkA==
X-Forwarded-Encrypted: i=1; AJvYcCUkwnDpCZlV84A40K192257M3iRaBML3sw/TjCYnhedkr77xM72OuuCJQWhY4jZanscJtom8FHXFh7hr60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmI14pTOnUSJOxz7fu60xOgNpuFUBPor1oHKn8oXCjohWn8H9
	fKqAb90rHxSfcGR6QpxrjcrE3YZRF8a+Xtju+Ni2gT7Z8xM8zPj3yhpzqY7vOKLXg1repnhM6NM
	JGg==
X-Google-Smtp-Source: AGHT+IHe2Zt4jhQ5oCR1CIR/oXfd2HFMebT7bed6oW9MBrb78OVdPsdOBQlKD8GD15boRhq2795aeq0Pjj0=
X-Received: from pjbtd3.prod.google.com ([2002:a17:90b:5443:b0:2f4:4222:ebba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c1:b0:2f1:2fa5:1924
 with SMTP id 98e67ed59e1d1-2fc41046e53mr743006a91.26.1739567359217; Fri, 14
 Feb 2025 13:09:19 -0800 (PST)
Date: Fri, 14 Feb 2025 13:09:17 -0800
In-Reply-To: <20240914101728.33148-18-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914101728.33148-1-dapeng1.mi@linux.intel.com> <20240914101728.33148-18-dapeng1.mi@linux.intel.com>
Message-ID: <Z6-w_ZG1LmTYDJd1@google.com>
Subject: Re: [kvm-unit-tests patch v6 17/18] x86: pmu: Adjust lower boundary
 of branch-misses event
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Sep 14, 2024, Dapeng Mi wrote:
> @@ -205,6 +208,17 @@ static void adjust_events_range(struct pmu_event *gp_events,
>  		gp_events[branch_idx].min = LOOP_BRANCHES;
>  		gp_events[branch_idx].max = LOOP_BRANCHES;
>  	}
> +
> +	/*
> +	 * For CPUs without IBPB support, no way to force to trigger a
> +	 * branch miss and the measured branch misses is possible to be
> +	 * 0. Thus overwrite the lower boundary of branch misses event
> +	 * to 0 to avoid false positive.
> +	 */
> +	if (!has_ibpb()) {
> +		/* branch misses event */

This comment is worse than useless, because it necessitates curly braces.

> +		gp_events[branch_miss_idx].min = 0;
> +	}
>  }

