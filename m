Return-Path: <linux-kernel+bounces-388284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31849B5D25
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C741F243CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F41E00A1;
	Wed, 30 Oct 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuwJ1/cL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8E54BD4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274207; cv=none; b=qsfhq/lb+MR65C84BWj7siwiLrsmthQ2fwvnvmcHYYl834nzFIo47a8sjyTs2lv8dxRg8g4lza4Utg1uBUudd0xs/4Vkq3jDSp05cBiavdHLl3HoEp/PiH5Uq8gYfw5IGd1OqKBuf26W3boiOVPXE/P+dntAuDMO73ZnSRWrBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274207; c=relaxed/simple;
	bh=aK3JFmOfrvS+WYS31AQmFD//9Yu+/FhtPay7G8FPYAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK8m3tfKJhZP4UALrK4m904mCLS0iugJTSg++BN9pQko/ZgYyvwuDLAq3rfL9Xvl6myxtsCZzaOCzjh3S+Ac/uakHS71rXietKwfUt/ZaPo+pJjcIyXRZ0c5OmMPlrpxEA5keXb9maIHMVuwPAIcCAcvZQdq0ppGWylrgqoAYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KuwJ1/cL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so63531485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730274203; x=1730879003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YArs62SLFVbBhxDoxdcxEnSLD2gqspuosa4yM1X4YqE=;
        b=KuwJ1/cLRQ0MjXwdXU1Ce8m4BEZSckQK/oCW5nP6LYqfLi+hatyMx4vqcKr+9d4aMQ
         Dyn5MSlzNNqrDd5ojZN0J3Z2fXoJRgO9v72L67vZwePcVgNNWuBPf2lUEaBJzrpkkcn4
         jhcj50MeZIYfv2orqJla9fxGKAsPZKh+zc+3vmjRao2eaUUFQTQS8n/cNcUExjGUTslS
         8TUHlnlp2cGOBfHsbE4VZKeCoPlFUqqOGYILO2DlU7YNKRi2rwz6ldofXoiR6tGgPFrB
         Tt/2gWDQVa3msN6OIb4XAzqLvh34qu0k2tHiSuPtYCzn2IJ5WSnVhhbirzhnzXEzCPc6
         f/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730274203; x=1730879003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YArs62SLFVbBhxDoxdcxEnSLD2gqspuosa4yM1X4YqE=;
        b=soQUaJVx4/76f5kVWvbrC/leVqv5sRTfioZJEGp+aKInMlwt9kORh3zegk87+IggeN
         tvaiBaY+8Fa2mJLqZtY0afDPB4fjzuLzVNLOucxgEDGG/jzItXU4oVzJqv5qKku6WJUR
         n/n16hAdltozx0avn/CzfDeZrpVZoObVxV5dsA1weHUl4idfc8dn0sR0usg8arl7m4ge
         cOw7UzxcMbmbu/h8iM6i1odwj69LsSgYUgVWW9fYb7383bq2sVsYzaQoFJVbMg2HS37j
         Zrdrrh/KyAEtpqZ/yJKHHoMH80PHVxubaMJYJMYFDRvrGxwzaqHgZ9QR75cfzWe2Kzd1
         1/FA==
X-Forwarded-Encrypted: i=1; AJvYcCXGqDOubJz9/IT33QyAUOdbHIRQ8ZMxWRLNFrekMrzqZFabY2EQ3Y3MXrlwoR83Dygcs1NZ+/RCtBtWhrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5ulTNDvkCTxWonOfAz/YpofjQFwy3zHlTjuPOMXaMJOPZGoZ
	1b/9rVXmSr+bEtUAICsqlHwWrhJbNTFosgSmSMd7HoyPBUDhu2ruDgYpMPTJBx8=
X-Google-Smtp-Source: AGHT+IFWQRjUTiGM84bWIK7VbEw3CFseHHrAQKgIOZUGcHD8dS8vTtszQXMb8MBg3SYqNXqy5EEvLg==
X-Received: by 2002:a5d:4c90:0:b0:37d:370a:5248 with SMTP id ffacd0b85a97d-380611e0c2amr10320365f8f.39.1730274203431;
        Wed, 30 Oct 2024 00:43:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm14591895f8f.49.2024.10.30.00.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:43:23 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:43:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2: remove redundant check on outpos > pos
Message-ID: <a81d5fbc-e66a-4de0-a015-e9a6b73c2ed8@stanley.mountain>
References: <20241029222015.3069873-1-colin.i.king@gmail.com>
 <cf07a880-1429-cc75-657e-55b32841cc00@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf07a880-1429-cc75-657e-55b32841cc00@huawei.com>

On Wed, Oct 30, 2024 at 12:45:42PM +0800, Zhihao Cheng wrote:
> 在 2024/10/30 6:20, Colin Ian King 写道:
> > The check for outpos > pos is always false because outpos is zero
> > and pos is at least zero; outpos can never be greater than pos.
> > The check is redundant and can be removed.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >   fs/jffs2/compr_rubin.c | 5 -----
> >   1 file changed, 5 deletions(-)
> > 
> > diff --git a/fs/jffs2/compr_rubin.c b/fs/jffs2/compr_rubin.c
> > index 556de100ebd5..9854253d0108 100644
> > --- a/fs/jffs2/compr_rubin.c
> > +++ b/fs/jffs2/compr_rubin.c
> > @@ -276,11 +276,6 @@ static int rubin_do_compress(int bit_divider, int *bits, unsigned char *data_in,
> >   	end_rubin(&rs);
> 
> Maybe this check could detect the overflow of 'pos', I guess.

"pos" is a number between 0 and 4.  It can't overflow.

regards,
dan carpenter


