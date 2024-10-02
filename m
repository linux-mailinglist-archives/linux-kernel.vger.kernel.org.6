Return-Path: <linux-kernel+bounces-347349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3D98D186
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9506284C51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888E1E7676;
	Wed,  2 Oct 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxS7cprL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219311CCB51
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865970; cv=none; b=MhLmOI/L4mlr0DkTdhr7oxsPjxPW3xPKJcU2Zy5es4Jzqi1cETZ9Fsf0Ja8ufbJQsM1OxboUf/fAvcQJI9MTRqB6N/kfGWmhBqlzG8nEsYScp4M/rEhTictJOFC+UV4BTS9QuoXItiNfQiiE3k8zLcDac4dqxQEpeCUHu/6obB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865970; c=relaxed/simple;
	bh=j1jipKhBpX/FlRTd/1TIChevsQmJqofboK5tmbX95yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjMKceK5KsGYv2cwk+fHhbG4Ox7DiT6hMcNsiupbuAdEG1c8qb9jsX+SgEpER0P+3RdEMYN8LHbbc52maqnfEYKlWEeLniwRyDxOdK7vDOqkg3azdvms4SOTJCiFV7QazR6x0fBOlWwKF/0wvwj2W0W8HhjHPgOMwUAp46U0is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxS7cprL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so2875020f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727865965; x=1728470765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk5hvgS0hGjJuo5sxC+sNtdExW//wukSgwsI+Pq5YRU=;
        b=zxS7cprLvBQqL3tgqg7e0S+2wKvbGTQEfS9z9nNGe2Tc3IizJEbNAEnVNV1BlQhLSz
         RzcYh04yDi87YUbNQrQdgPB/hN3BYsIlQdX0270iJXOAO3+DTIkRHEC5VrVKAaZfcSnl
         ZeHwu8vVY1abgPLG0XT2rpOdiK+x8PlmiLJKONsdnjBDBg7gC6H3AApIkigiBxg1sLZX
         q3rxSdJWExV4PaR7hOqY8bjdNpB/2BQ6IhyFM/1EEeNyOPeCPJSmOByi60JatiPKt+24
         vZXCHgG0j4F2I/I8S9uW87H8AqH98d2luVrGd0sP5gmFmDQFibnI4Av8Mumkl7zd/2re
         ohbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727865965; x=1728470765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk5hvgS0hGjJuo5sxC+sNtdExW//wukSgwsI+Pq5YRU=;
        b=sKWrHgcZ+BUxs15acXicZgg42okk8jxEbivzeROp7x1v7KIWxkP4IfzkqA6Cl3rJZf
         BVyUCqgySyao1E85X2jPBgMKXuT5gy/Bet+CnWS4sOTJPlfu429AdPj/sS6fsNUnDMMz
         DV0LacOrzcEaT/ZK3RgrAS/qLSw0QKJps6ywFsP1jHJ1uT9b3QGBbTV/gtIAxFQ2v2fo
         wTJ6vAN7FZrOPYiXFbGGKgb81I9+UfNiB8nDN50xp/vVcNpmmF88ULA6Wb1tfvoWC9DF
         8HrBQHTPXA8I95DHc20oQtvxMxzxo8P7Txx7ne4QBTosLj/dgjcYxx3YdV83CR0S3jCt
         u7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU74V1bnkZ5hSWPTPymNS1vCHxZBKJSd3Xifdj6tEDMTcF6LYKNZx73FvDnASzuMeR6V6brwdqME/HRkRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtt7Pd0dOAwZAGWT+T4LaJOi/bHPggXA7lEE+vt2aCcitn3Km
	HWWlf9z5QICrlVDd5g5CrfxLH03uMP8wRHmuQlhmduUOPncYbn8iJZvUUX2Q9Xk=
X-Google-Smtp-Source: AGHT+IF/EJDPE+HOPHXbRDSTkeiUO+hzHFC+iz5emuBJaiUOpXAfIJKgswRfUyuHfngLDtPziZdOUA==
X-Received: by 2002:adf:ec08:0:b0:37c:d1fb:82f4 with SMTP id ffacd0b85a97d-37cfba0a6cbmr2320172f8f.36.1727865965374;
        Wed, 02 Oct 2024 03:46:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a00bcb0sm15117345e9.43.2024.10.02.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:45:55 -0700 (PDT)
Date: Wed, 2 Oct 2024 13:45:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] blk_iocost: remove some dupicate irq disable/enables
Message-ID: <7962c626-87d3-4c6e-8fac-16653cd2868d@stanley.mountain>
References: <d6cc543a-e354-4500-b47b-aa7f9afa30de@stanley.mountain>
 <Zv0MtvYFTHlff_zT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv0MtvYFTHlff_zT@infradead.org>

On Wed, Oct 02, 2024 at 02:04:54AM -0700, Christoph Hellwig wrote:
> s/dupicate/duplicate/ in the subject.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.  Let me fix that typo quickly in a v2.

regards,
dan carpenter

