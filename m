Return-Path: <linux-kernel+bounces-348064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34E98E21B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9C0B220BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72B1D1F71;
	Wed,  2 Oct 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBkhD/0b"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056E1D1E98
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892645; cv=none; b=chSZ2dFeySRUbPm1ggZOlPpYOIvsJIDtYXmiLSWmSMzJ+vXgXIeNTAYFHilJciAk5V0q2eOcoyIJ1kyRqRbX6QqSmzX+utqqS8v4Ol6YrGF8Iv7L2y3saCwrCFod7obLhL0UlXUn8PQu80w0fFWf7QlA4srWIDT4F/bM/TX8J5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892645; c=relaxed/simple;
	bh=DK2MUVdAtluMDn/IwETewEanduQqhHxMYakPpg2sRc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK7cKPg2SIsaWZd7R9TLKHDS8ZcgXjSgyeWXAX5RwON2235IqZaS66zZZnCqFEHVFthoj3fWiahYEvh82M9sQodp9NKsSAJjiYQuhRwPpKKdi71MdM2a91zothOQKZmhd08dnkLtxjvHQyQL8CPWTsh/g05Of1qe4aX4myS3ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBkhD/0b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cae102702so305665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727892642; x=1728497442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGG8QMel29fIDf2AnAxKpn/d8hnp2TmaHrAszFN82PE=;
        b=QBkhD/0bHd6wPrT0PPMh6ixOMyQJHb7CoaCfFFXFhHZueDdjLow9Jm+AalUtT1tPMS
         j5WUj/X+Cliq5zbPLdZRpryDQCmDpek7CFzroQsoaO7c2gj1nQ8e2fSKuXqVS1+l0xMl
         VCdN2PYBTbum0CEr7FvG/9iQZnh1SbPqAv4tdLnxo0rece6MX4Tu81HlWKEYpUiN7BdF
         IXCpgcD/6gbsJZQ80tfV55rg51TepV2VsM2Lxv7NrzRYFioKtSYGH/zioYgAsQ9WjIRQ
         Ge+IrGpybmhU4MQcSkGCFr6Cqbh0AgbrLoRISW9z/hAri1uPVSaFsYu2oZoWzfCtV+uG
         azXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892642; x=1728497442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGG8QMel29fIDf2AnAxKpn/d8hnp2TmaHrAszFN82PE=;
        b=FsZJgg0qFyFn4AQR+52yBWR9Ywn1BfFRKIS7JBD7PZmE26N26Q+K9q/iObUgTaY6T1
         XRtg892gy0lYWCYhIpwRHi8xUl2a/MMfBiHTcsGZgEZY6tQIK2lvQQc73LhGB0UJg5KH
         tPvcgncylTHzeMZ5JRkJschUU/klv6uU6Jk3fZ1p09SzVgEI2JUpLfzjhRBvMD1z2cSe
         CeyJiElvutoQxw8X20an/bMyCG15MCl630SpTDUcJWY+exFMLJnF7DGZkLf2RQHUdVUS
         aadMYgrY94nSWCPMoDO71Qht2wCeCppS0bqP9ez5r+0/Ag9aD44IVS8V3hy5z6DuL1Gx
         coXg==
X-Forwarded-Encrypted: i=1; AJvYcCU6PNG1NhyNEaQ3gi2bD5dC/4J0eTKLIu4VQZtHP+/vCD3SVawpNuaCTUhKXVjI7vB8csCFkfZdyrhCp+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyao/q/QP48pLgySy1XZ15jZsJ8OC5JkC5JKIqx0wilRuqk+uZV
	njDk5340xVyQ7AMMczqaCXpjWynYkPlDAFikHDi1Qtd+leMvqJrOQSg7817ZXgc=
X-Google-Smtp-Source: AGHT+IG4L90gOtT2GIPiJck56b9/qGOnFxKwX8Omp1g3PHVDmm594jaN0gFUKmmSK7OJWNmzkks2bQ==
X-Received: by 2002:a7b:c384:0:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-42f778f2bc8mr31431265e9.25.1727892641539;
        Wed, 02 Oct 2024 11:10:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7728b382sm19659855e9.1.2024.10.02.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:10:40 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:10:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waiman Long <longman@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>

On Wed, Oct 02, 2024 at 01:49:48PM -0400, Waiman Long wrote:
> > -	spin_unlock_irq(&ioc->lock);
> > +	spin_unlock(&ioc->lock);
> >   	return 0;
> >   }
> 
> I would suggest adding a "lockdep_assert_irqs_disabled()" call before
> spin_lock() to confirm that irq is indeed disabled just in case the callers
> are changed in the future.

It's really hard to predict future bugs.  I doubt we'll add new callers.
Outputting this information to a struct seq_file *sf is pretty specific.

If there were a bug related to this, then wouldn't it be caught by lockdep?

The other idea is that we could catch bugs like this using static analysis.
Like every time we take the &ioc->lock, either IRQs should already be disabled
or we disable it ourselves.  I could write a Smatch check like this.

KTODO: add Smatch check to ensure IRQs are disabled for &ioc->lock

regards,
dan carpenter

