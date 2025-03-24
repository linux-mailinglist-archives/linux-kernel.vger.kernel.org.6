Return-Path: <linux-kernel+bounces-573895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD2A6DDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAFF3A9172
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4425E45A;
	Mon, 24 Mar 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7WFxw+Z"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C59450
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828549; cv=none; b=Mra0XUowaZlKJ0PTY3bsVX7nqnodo5XqQEI0CKF0lvZuAiQPgOyiD719eR0RGEoqglJFYQ3WyDvfZIV09FZOu5TaT5zmETomxA4JjMjjMPr25QBAZugFl2uSZm1SYCJlVgjaxThF9a7PEbOV8bmmPNGx8bAlIuwGU4ENSj6LaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828549; c=relaxed/simple;
	bh=gHJgB9sut4zMdePkaly+IvIbVFS40V1VctFvKxx3P8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqsZVjXZhoQmTI5Pk9YObMut1dPcGP0blnLH0S62epOt1O6lQF+ssm7khaPNbba4I2KRezMGWp0xBDezQFh1FySkV43/WjfztX/3nPBzEo+06fz0OzX/9PSOpu6l46xu/sLwHXtlp0o3VZJtKBuibepnLj2PnsTbZ7x0Siz1OkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7WFxw+Z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2243803b776so9650955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828547; x=1743433347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thkoKxykLsETroc6mn87fVjpfe6Eo9+STWnHf3GGcRM=;
        b=T7WFxw+ZzZUMi2vk0RjN/W6crl+ZTqGAGhtlFqGLNcocBVNPHJrUCnZiTYlDZKB93+
         kIAY3h8XvxTzxV5foOXZTnFXCyK4LXlAxpUSa4cHno7XXH/VOUJcwGNcpcltbK+y08dV
         QKeCfG0yxyBHd8OAVHq2pNe4I//uWzAoT8bSNPz+/85dBsucdv39Fo3yEcbToxBZbUhH
         NLfZz6LnOjzETlP9xZALaAPdyZXU0kG3vPK8yymKNOSO6572+EgC7C+R/2SY0JM9dD74
         ayoiQotmqBCaGf1H7yshE78yN3PoZzoTPaUZMpmxxrCq6Xo7kdZXmizEDgDj9LOJGOta
         CT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828547; x=1743433347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thkoKxykLsETroc6mn87fVjpfe6Eo9+STWnHf3GGcRM=;
        b=EnnsxOArn/LTX/qQqfjuKu/b1klGA5ine+K5aSvstkrK3cJA9aZoU+Q+vT00tdXhVZ
         +cXJMUs3fLUK2nCjcpS3wn+TAaThgI66cPYxjJkewlDTEQQv2S+3+lqHqSm4t2kI/ACc
         m1fOK8h3I9OmuPU3UG7voScq4II+LbIQjrIzeP9Fn8fbwr7qg9tYWo1psgq4IOWFIxIZ
         akI/ZNl4HIEOnUxGuUE/spi1coXJM8/U08trQs8W57tPUMgL5RYv0BgF1sVT/gYzikHj
         S9xdJRDUOliZSrziTayP2DmYiglMHYLnNG3/aeGde2h3JK0zePdaqPf+8QZaqWYzLZFH
         ADkg==
X-Gm-Message-State: AOJu0YxwxwO4De6eYSzV4hX411he9V5mwuCNCN7SGqq0oo3RHGUeFn3S
	4PMl6vT3JqdIlIBSAD2NJmrsr9sJynnrkr4cGZPuUHvpxiU29hHcAAuNlw==
X-Gm-Gg: ASbGncvQp69wdQZNtH27xMbLZmFC8o6wAdEMIlbEizmej2buirLNVMt5OWRFJCd5Bp4
	vbSZ0t6CpacunWp20jEEIHQCYnRWW0Wtx5ZOh4mKBQBcbNjWhamN2nza/GfOOv3v1TQJlaePPaJ
	nyO6KK3O//QjoSoTBWoYv0YRW1boNstAhVodglwPSJi28xxHGh+HKZSdjQCASxGqUlTS8nDKt0N
	ociWPY54bcErA1h8kdsoyDjVQqHJz6Cj+cZXIUwdW+x9NA+xeTLhbqPHs/FjbC7cnzHD+8sh8ja
	PZocAsW4FKVt1fRbqL1wdvjYo1DhcFiwsnSjJOOOEqu+s5eXt9mZMndT5vrPylvLNbaw
X-Google-Smtp-Source: AGHT+IGr/YRRu0sAJ7wEPqi/mxNqtNffODibXjrYjhkvWCqcaNcg/AbPXQN+biMqZTzAtSh2Phrdxw==
X-Received: by 2002:a17:903:250:b0:223:635d:3e38 with SMTP id d9443c01a7336-22780c76135mr219585055ad.15.1742828547184;
        Mon, 24 Mar 2025 08:02:27 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b287bsm71697385ad.124.2025.03.24.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:02:26 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:02:24 -0400
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 0/4] cleanup dead code in nodemasks and cpumasks
Message-ID: <Z-F0APn3eisfC0lC@thinkpad>
References: <20250313021953.86035-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313021953.86035-1-yury.norov@gmail.com>

Ping?

If no objections, I'll schedule it for 6.15.

On Wed, Mar 12, 2025 at 10:19:48PM -0400, Yury Norov wrote:
> Cleanup dead code in nodemasks and cpumasks, and while there, fix
> set_icache_stale_mask() that misuses atomic cpumask_assign_cpu().
> 
> Yury Norov (4):
>   nodemask: drop nodes_shift
>   cpumask: add non-atomic __assign_cpu()
>   riscv: switch set_icache_stale_mask() to using non-atomic assign_cpu()
>   cpumask: drop cpumask_assign_cpu()
> 
>  arch/riscv/mm/cacheflush.c |  2 +-
>  include/linux/cpumask.h    | 19 +++----------------
>  include/linux/nodemask.h   | 19 -------------------
>  3 files changed, 4 insertions(+), 36 deletions(-)
> 
> -- 
> 2.43.0

