Return-Path: <linux-kernel+bounces-405481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F869C525B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F33B23435
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989120ADF7;
	Tue, 12 Nov 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTk/j1Pg"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156320CCF2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403597; cv=none; b=tVgNpPJWobahsgrlPqXuc2luLjglgwSGVT/lAR2NRqSjlLEvNNtsCdqhsNbm44xH7efVLVzU5IFAtzZpbZMu9zAfl0boqPbP3tl4Ov6J07IkxDygy9bbSg87SnZLfs9yAIK89iugK5nWi0Fa+PSUPMOlDCOwZv4wp/Aj8Tz7Pg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403597; c=relaxed/simple;
	bh=+kDIQLpWOAJrdT0VJOv1P4HLYT7ZhsY78MMEfYJjgzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZtmi/h7N6Ein4IFEHEr4USvqey+VeIRyXIvitgMBv6QfEAFgcmzw1/mLJWRp02PzDhLU2kxzeGPtIjtCbsgyAl7vZpfPDcXwO9wIGxqA35j+oFR0sJ+UmMIS73cSRQ/BQNVRJceLRqB1JfXNU0dgTDoKEk9Bt/a/DBoOj26eHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CTk/j1Pg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so4386220a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731403595; x=1732008395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=neEfcsmYwWR1TZN8OSygR364mITFwbMFoBamEQa+xj4=;
        b=CTk/j1PgVcsedqB5hxPpDIKdYlAicUK3XXknLTUCEeJLvuQ2cZLNVkRkj89Mgn1NB9
         jabgOae0FQoYkbNsy2Os0yx3xQRUaSLFBfA7QdzwfcKeKRl8Q310c6E/oRuWMtb5RhID
         Jn5KHzjBl67APDqE7FR2eKfsAbefdtjXzVNZh2NxRRikd1YOcu7r3yDonlrOILoOaeay
         J/JvpBn/WDU8r40rfNUxLyxz1jxpFEhTQNH31Fg+HmxMXUKq7SRBF0OURR8IOLG0jXRq
         cf3QdCdJfWADWIZAb6SVeC39IY/Vn1pHBUudCSOJkmk3OIOCwih4xhufTRuvDXR7vfA0
         G+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403595; x=1732008395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neEfcsmYwWR1TZN8OSygR364mITFwbMFoBamEQa+xj4=;
        b=X/BK04mRDNk/eqIDOp5g8mlLUS2KTE0iuLoobbYdNH+/GxxBpL09MSZ9sfBFa9aaJh
         WLqCLsc+WCORBWybMETdtlYh4VXimSOe1iHYEEUfcKfIoU4jdOn+HuwjMDwllEcGnXTE
         6AOIAt6lMK+bCSVwkukI7obOXrLc9gQWE8agwCtIxMHbeGhNKNQ5rNulEBXByodoAuPf
         3zr7Q6NykKCAfFkXfYpVwoDOftTHqaS6rtQFRLQxfiAY6lTNSRAAqbwkNKpA/RKzW/n8
         QgHFj3cQwKTDLP76B1CBkTteArLoB32FiCGXhuSz2xqnOnWL4TTKWwmxlm08n5k/0pG8
         BAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKGdk6CiaJN2ZwSp1TgLsfZGPRe4tQ2EOc043DMT+XzQ2CM4t3LD5ud8AbLeNZ3kv49q5HVydS0/nxmpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sKYAAqHrQKud58hE5q7br1iGQpXrD/LhWUDfsHbvnfZnZA8Q
	lo5k9VQoUApqYlcxiXJUS1hDYcC6djKTCxJV8pNjphRy++6U1SPSwzlhfYulbi0=
X-Google-Smtp-Source: AGHT+IHcXyqu2j2PaAR73HECUuaJ0QnRAysFXoaVxI2tNJrJDuAJHUTPD6v5KyKDtf7mAXJ/PNPOUg==
X-Received: by 2002:a17:90b:3883:b0:2e2:9522:278f with SMTP id 98e67ed59e1d1-2e9b1748229mr19548653a91.32.1731403595212;
        Tue, 12 Nov 2024 01:26:35 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5feb50bsm10027153a91.53.2024.11.12.01.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:26:33 -0800 (PST)
Date: Tue, 12 Nov 2024 14:56:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] cpufreq: maple: Remove maple driver
Message-ID: <20241112092630.imled7fmhqgkjbru@vireshk-i7>
References: <20241112085148.415574-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112085148.415574-1-mpe@ellerman.id.au>

On 12-11-24, 19:51, Michael Ellerman wrote:
> This driver is no longer buildable since the PPC_MAPLE platform was
> removed, see commit 62f8f307c80e ("powerpc/64: Remove maple platform").
> 
> Remove the driver.
> 
> Note that the comment in the driver says it supports "SMU & 970FX
> based G5 Macs", but that's not true, that comment was copied from
> pmac64-cpufreq.c, which still exists and continues to support those
> machines.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/cpufreq/Kconfig.powerpc |   7 -
>  drivers/cpufreq/Makefile        |   1 -
>  drivers/cpufreq/maple-cpufreq.c | 242 --------------------------------
>  3 files changed, 250 deletions(-)
>  delete mode 100644 drivers/cpufreq/maple-cpufreq.c
> 
> The removal commit is in the powerpc/next branch:
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=next
> 
> I can take this via the powerpc tree if that's easiest, let me know.

Please take it via the powerpc tree:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

