Return-Path: <linux-kernel+bounces-297373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80D95B707
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F4B2833A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907991CB32A;
	Thu, 22 Aug 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="leY0vOD6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAC1CB30C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334103; cv=none; b=cfoySiw+hjrotNow27m3/nHmaJtgU5ggGdE4n/+1+0EMty8Sl7XsQltyG6TSFKzdZG7h2ax+KKp4J+DzSn5phcuHkZ29ooNds2suifcchkPNz67N229VNIgEiV1LZuMPozY0KdszHRFQ3cM4a+Pmd+zIvXXbSjOfMu7l+WDJdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334103; c=relaxed/simple;
	bh=O8xaZOTuj5ce8Wj2OeH273OxcvlRdNasHXbOjSdFy3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4JwVi+dpMUz8HOrmnVnzQl+GQXHtriBe52kkz7x3uYZ8G7bq4ocIsQGxWs7lu+Kmk5UDKPO0ZUrqfgh8NcdXm2/FFqQCBdfPud1ikkW04bE72B4pF5QDZDy3sIMrAIC+FjzVaLXyey3nsJI/soVBwJo77EXaiYh0XCGLZU7Jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=leY0vOD6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efdf02d13so1093709e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724334100; x=1724938900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imZf6FTHHFv1jc8blHwhJuknb8qH4z1prHELoYZxzpU=;
        b=leY0vOD6tVLEWSVgn164KtdekXejhKKBiHh2n9G9rtdLH1pso+gw2EwyWmDLugWrbk
         908wn2inhm6y/gy/20xEqvWWuX2sZUbNjQpfU0LfzIJto9Yt9jyB6b5A7Wt/zJrcUy/B
         7wl/90iW200YB+G0lQZlT52++Rhd4PG0GkStGDS0DnHOnd2WvGTDX1z10o4WvguPXHC+
         KQx0ona0Adu1utGHyGvqJkhvWU0PMuk1Zb/Gq76+IHG5JgWeCN6bYkiVa8ibCmApvlR6
         ZFsQzRIZTLqoDWx3l9xiflQCPT8TIWcG31WcWhwh2vRdATswExjVeQ8WRcKOWSJGw/Qu
         oR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334100; x=1724938900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imZf6FTHHFv1jc8blHwhJuknb8qH4z1prHELoYZxzpU=;
        b=sAcbB2X0M0N33YbjCODPfGxfjrGnHOlsF9e34buoz94QCmspV9JePGD0SIM5KWRE0x
         ZKzISM6Vd/aj6FZoxdL6evSJ/cYdbkwQO5N2fc4jIf4QPkpiRdL6+yPqDN66rJ17ym6Z
         8tuTkt497Dv9Tz8DRalwf2HJKm0rwyjD14LvFx2SdKZvYx+aQa3NK5Lax4lLyePJIfXd
         7Ap1QURm0JLj/Rg/xSkE8VA+5mNNnDhxGU7rxKPDTjKkK3HxdurnkwaGLQC4ufDO2HxO
         JI97ni2oB+TFN1YNk+z8auRyuY2sPDTo+mtve3jATbUB5VtRBO3zDIuR9uS5vnf4tgUx
         M3+g==
X-Forwarded-Encrypted: i=1; AJvYcCWCG/mNum1HKJ2/+PNURvX1hZ7KnTLBg0a2hkA4nS6V/KJjdsVyp63fUQY/uVcMm7pp6bGTy0dPtcFcwj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrkv4aokabvO0J5eeGUWgaXbXuTS/lw66T9A/fzZpoWoeXlI+E
	0tC6YvF1VrqH2VMxrcSyvU31YjzrA/FU595gn0WmlRWryOqoyyy8uSf9KpgMCaM=
X-Google-Smtp-Source: AGHT+IH32O883q08dUa5KOEo4YvEjt3Mp2Ar6drhkiJlCswVQ0XO6rq1iTaTl5tp3/AuAH3rpAo2EQ==
X-Received: by 2002:a05:6512:3c89:b0:52e:d0f8:2d43 with SMTP id 2adb3069b0e04-5334fbe593emr1743888e87.17.1724334099444;
        Thu, 22 Aug 2024 06:41:39 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220ccbsm123140966b.36.2024.08.22.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:41:38 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:41:38 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Quan Zhou <zhouquan@iscas.ac.cn>
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: perf: add guest vs host distinction
Message-ID: <20240822-a03a7c96ebceb658325e7fce@orel>
References: <cover.1723518282.git.zhouquan@iscas.ac.cn>
 <3729354b59658535c4370d3c1c7e2f162433807b.1723518282.git.zhouquan@iscas.ac.cn>
 <20240821-f5e1d6afb0d2230c1256a75b@orel>
 <430f3d38-b12e-4ac8-8040-33bab40380ab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430f3d38-b12e-4ac8-8040-33bab40380ab@iscas.ac.cn>

On Thu, Aug 22, 2024 at 02:38:44PM GMT, Quan Zhou wrote:
...
> > > +unsigned short perf_misc_flags(struct pt_regs *regs)
> > 
> > I see that the consumer of perf_misc_flags is only a u16, but all other
> > architectures define this function as returning an unsigned long, and
> > your last version did as well. My comment in the last version was that
> > we should use an unsigned long for the 'misc' variable to match the
> > return type of the function. I still think we should do that instead
> > since the function should be consistent with the other architectures.
> > 
> 
> I agree with your point that the type of `misc` should be consistent with
> other architectures.
> 
> However, one thing confuses me. The return value of perf_misc_flags
> is assigned to the `misc` field of the perf_event_header structure,
> and the field is defined as `u16`. I checked the return type of

Yes, that's what I mentioned above.

> `perf_misc_flags` in other architectures, and I found that for x86/arm/s390,
> the type is `unsigned long`, while for powerpc, it is `u32`.
> These do not match `u16`, which seems to pose a risk of type truncation and
> feels a bit unconventional. Or is there some other reasonable consideration
> behind this?

No, it's just historic. I see three paths, one is use 'unsigned long' like
the other architectures and assume we'll never have flags touching bits
over 15, so it's fine. Or, same as the first path, but also add
'#define PERF_RECORD_MISC_MAX 15' with a comment explaining misc flags
must be 15 or less as a separate patch. Or, for the third, add patches to
this series that first change all architectures to return u16s.

Thanks,
drew

