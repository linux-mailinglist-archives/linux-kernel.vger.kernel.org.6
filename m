Return-Path: <linux-kernel+bounces-223117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD23C910DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F71E28630B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5461B3735;
	Thu, 20 Jun 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="SQ2wA1Uv"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626421ABCBB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903126; cv=none; b=kEgJSpjaIvVLnQfmVl5oPOgJzfsi5mxl52OqkQL1qOQSnikwRWvPrBAC6PqJ7otYnKzgUfZsTSr/sOuLqMnQN438aBygthNOm3Kxu5jYmqu1ts+Wt59RulMVlCMwajo3yMJTppl6spqCM36HEBpgrvH2Y72e3yWR9FFClj3tML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903126; c=relaxed/simple;
	bh=V9vbedrO0h4dfaGDqH9asqdRuXK1RwmHacUkIr2CNKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFa2fGZ7NOuM2U0A4NN+PJUpfF11yukqSjzVTGPAsmV+YzqeJFZ7sRuDG/aCUXJdRiOH2GM6QDkmiBZHELk75VrdIn4qZMDrxkUyraCnuqcEXoGjLB4iLVCOZmYHW6jY1M+VGSIPL3k6lZ+1PMJcKcqiHfMuEqQ6u3a5Ov3ZvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=SQ2wA1Uv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f8395a530dso8967545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1718903124; x=1719507924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4E89UTgs/5r5atSnFCInRbSVBNWxc0zHVVFCoSblkK4=;
        b=SQ2wA1UvJo+FxGdiQB820HLc/ezBD8k0bFseMWkqbCWGLNf4pGZvFKbSKpIc4adzBg
         XyBw4CiaSU4v6PpIgY9r4d8adyWCjzCjhLAJfLSY4cph0WgzHEQc93JRlxUDAkGGOzfj
         rWTaaaqtVdet7lygYfrTvATC4KAFZ6bNhW253aPn0K+7kkJ91I1ucWCSGPuCRnmd8dba
         WJsDkMaKDr0i+i4s5GZ7bMBk/vkdf5PRRP8iqm5DvvdAYrI7nrG0HwvJZA98wfI/QfjP
         aa00Yf7KaWfHjXwUBJ2hTPzAxPlsyDGpfnlFiotE3yQnQR48vUhyLw4zcosQGHfLChI/
         fBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903124; x=1719507924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E89UTgs/5r5atSnFCInRbSVBNWxc0zHVVFCoSblkK4=;
        b=iqfuLLGO89QGFMEF8RVh8j5aB8L5pE7302L3Zp095wdVVwKPlLBIbVXNJnFx0rNOst
         tEEEEAdGLRWKC+c/lmkZPCXZoChvTvzXmCVgBUgWKAq4TtEZ2o6g5qEaB1mBSK7v5sJb
         PwTha6FnPboxMRl1hyNAhc66yOuH6YYHGckWX6AmMU+FM5M+B5tzuvfbspEh+fJU3EeG
         the4KI5tYs++leo1OGybxNzd5/BDG6bT9bokHukwzY4x0HoiEmQSey0OqeLrpSOb3rAf
         l9Vk6QSYaUuY02T+bxM17E1J6yaPYFnxdQ1nxnSKk4ESVDZi8jwCXqaJ+qfkxEpayHb7
         7bjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtdL797b0CyyqQIBOEEcMwDXBa2XKPAmudyKqe5Ic5hAZaPlxcWPcmK5CX0qiNtwslmeTngYUb0MyI7tXFI2r3QnWiUYMOcQoCYCj7
X-Gm-Message-State: AOJu0YwXy5y23eryFyTG546FrEJQI+aUkBHCVP5OQxQHJb7h9g/inlqd
	qxIzngrFrElq9i4cRSPSlsjUs/gOERn8PGtaSunA0Mz8MJywShpapL/foobGDxI=
X-Google-Smtp-Source: AGHT+IHnO0PhojcD/q5JTTxQb+zxwVYaNBwpbOMTUxU2qhG2GuUiEPiNiJ0WLvWdxuAzdO/MlAP2Kg==
X-Received: by 2002:a17:902:d4c7:b0:1f7:17c2:118b with SMTP id d9443c01a7336-1f9aa3e9e49mr59538365ad.27.1718903123621;
        Thu, 20 Jun 2024 10:05:23 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:4a35:79ce:6499:e43c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9acc04adcsm39635605ad.204.2024.06.20.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:05:23 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:05:20 -0700
From: Drew Fustini <drew@pdp7.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Drew Fustini <dfustini@tenstorrent.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: thead: update Maintainer
Message-ID: <ZnRhUOSB+/hMSs2x@x1>
References: <20240620162522.386-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620162522.386-1-jszhang@kernel.org>

On Fri, Jun 21, 2024 at 12:25:22AM +0800, Jisheng Zhang wrote:
> Due to personal reasons, I can't maintain T-Head SoCs any more. At the
> same time, I would nominate Drew Fustini as Maintainer. Drew contributed
> the sdhci support of TH1520 in the past, and is working on the clk
> parts. I believe he will look after T-Head SoCs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aacccb376c28..b5f5506815d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19315,7 +19315,7 @@ F:	drivers/perf/riscv_pmu_legacy.c
>  F:	drivers/perf/riscv_pmu_sbi.c
>  
>  RISC-V THEAD SoC SUPPORT
> -M:	Jisheng Zhang <jszhang@kernel.org>
> +M:	Drew Fustini <drew@pdp7.com>
>  M:	Guo Ren <guoren@kernel.org>
>  M:	Fu Wei <wefu@redhat.com>
>  L:	linux-riscv@lists.infradead.org
> -- 
> 2.43.0
> 

Acked-by: Drew Fustini <drew@pdp7.com>

Jisheng - thanks for your efforts thus far and I'm happy to take over.

Drew

