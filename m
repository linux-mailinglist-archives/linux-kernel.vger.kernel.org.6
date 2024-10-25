Return-Path: <linux-kernel+bounces-381059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB09AF9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1C1C221CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94C18C030;
	Fri, 25 Oct 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sz4/wsCm"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65618C346
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836965; cv=none; b=daH3bZJQqxMwXmAjV2FEqOVnvET1aokBU9gHEJeNLbFbUFed6MFti0AgyzFDiRma0nLQBqlJI6enNdhvO75a22m/5b+2zWzU75BWNjGQ+f+BjRJOfiBSalAOABC/qVPDnbV2vlfEwYfQpYtzKwLRIiwnr6A/QwEmqtEuMAwORBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836965; c=relaxed/simple;
	bh=jwVXq0sXiqmFlXsfxWjGRVzJcwpWFkSN+Aop/9DUACA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIqVgi7bV2rVDl30Rbs0sOWm2NF1aLKOzbBvHNunKOKngaHAdS1IjwCgou0gg74mSERWHCdkX/czn7UaW/cBEEaVGJaFai+iD6kJxuniTdq/eTWm71dEvmVSh5AF854QqEd+0YxJERiahqXeIooOUkEKQQ3enJZuvTGWgCWQaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sz4/wsCm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb443746b8so17064151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729836962; x=1730441762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fW4m5+Alc5+U/bpiXfBbEwyDvB1oVdKKXqHaL1Wh1jQ=;
        b=sz4/wsCmjphY0ddRcp39wS/134k7H0qoCurrQonwi9ElyYefxuteyOLYKZk8HN3RMu
         RMjnjpZxwuoAKL2grFu6ZIWj7xm35MxD+zWjv0mJ0Z77hZRk0rPOeEZgDgqKolRLf1er
         CPVD8A5VeJciYUz8IwxCdiLmf3TrjhmSjnqJ7nLIl+SX9qf2Bft4NLHZRIGbrTcv9tHt
         RADWprCHmHr7gl61tKOcokTIlWM8HJza2Lzo10Z7mv2c1qgIa8E0AN/yHxvo0KYh9jjA
         W2geNE2jzK9HJ9/jZla/6MBWE4rZJq86KWGCJFlHXZ2r6p984h9+NpN892DuWoci/1h+
         RbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836962; x=1730441762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW4m5+Alc5+U/bpiXfBbEwyDvB1oVdKKXqHaL1Wh1jQ=;
        b=YzcAJWiSdiwObB6p4+1lYTidY18//KPL+Zb8+PVwBHHRSXw7r/dhgyT66pXIjLsvbI
         HYJEdQhiywpzBCtsbeWzuxhkOqXxdDR8FbRf2LVcRfC7HmMRiZPuNY4YHjitpybGZieR
         uSniwiaiAd/oK7OiQvcWzd+M3TOW8ndCQW/bm42iwBMzvF2imfWHmRfbrvObP6r3Z5r/
         EUrwctzqhaupO/Tl2CqzyC1Zz4napsnNDpF/1KHmpooxcRIysAMsj/OwtL+iQbkKQmsv
         d2y3jQW9pSQJi2mAeAhgtGKKOHdBJj1IwKy+GexuMZsW52ynceNklqRy5I2akWuYIrgS
         gvWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+5Nalomz88d4SlG2B00TnqZvNJWRUnT36dRhTmbCTdswPfdcOX+Q/NL5oxWVFL+doi4K9EkWCLAFSxXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzq4ZMUSE4KSZTD9X6glACgPG5y1ULxqBb9BWzgMm9yzB7xhbB
	TeMdhegtJi9+rGkPrJdGRdsPdONQl1OcF6PQvTY5wjeGX2YfOSE4DlKw6aCaaQE=
X-Google-Smtp-Source: AGHT+IH1R1a5paHiMJuZWc2VC76niPOAzN1UkvOY+GuCu2Vas+9MsuU8FAL2cFI+5QVsPyLimIOW9g==
X-Received: by 2002:a2e:b816:0:b0:2fb:5060:7037 with SMTP id 38308e7fff4ca-2fca828bd24mr21472121fa.41.1729836961690;
        Thu, 24 Oct 2024 23:16:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb453ea75sm662871fa.67.2024.10.24.23.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:16:00 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:15:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: shaojiedong <quic_shaojied@quicinc.com>
Cc: Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] um: Remove double zero check
Message-ID: <qstfwrz6kvjfldw2lisgcrtvlhi7ltuyc32ygsqtoqfykwxmae@irofaqfjjg3a>
References: <20241025-upstream_branch-v2-1-072009bfa7d0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-upstream_branch-v2-1-072009bfa7d0@quicinc.com>

On Fri, Oct 25, 2024 at 02:03:32PM +0800, shaojiedong wrote:
> free_pages() performs a parameter null check inside
> previous code also does zero check as following
>     if (stack == 0)
>         goto out;
> 
>     to_mm->id.stack = stack;
> 
> therefore remove double zero check here.
> 
> Signed-off-by: shaojiedong <quic_shaojied@quicinc.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

Clearly NAK

> - Link to v1: https://lore.kernel.org/r/20241025-upstream_branch-v1-1-4829506c7cdb@quicinc.com
> ---
>  arch/um/kernel/skas/mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
> index d3fb506d5bd6084046cf5903c629432cd42b5ab3..0eb5a1d3ba70134f75d9b2af18544fca7248c6d6 100644
> --- a/arch/um/kernel/skas/mmu.c
> +++ b/arch/um/kernel/skas/mmu.c
> @@ -46,8 +46,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
>  	return 0;
>  
>   out_free:
> -	if (new_id->stack != 0)
> -		free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
> +	free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
>   out:
>  	return ret;
>  }
> 
> ---
> base-commit: fd21fa4a912ebbf8a6a341c31d8456f61e7d4170
> change-id: 20241025-upstream_branch-06a9ea92948d
> 
> Best regards,
> -- 
> shaojiedong <quic_shaojied@quicinc.com>
> 

-- 
With best wishes
Dmitry

