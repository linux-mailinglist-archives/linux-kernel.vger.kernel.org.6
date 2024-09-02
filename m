Return-Path: <linux-kernel+bounces-311714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F215968CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14421C21901
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5171AB6D2;
	Mon,  2 Sep 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncNlHyKc"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633411CB508
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296631; cv=none; b=Wgm/Q8iNXOkC/+iyYerrEeNiQLgIkO+FaEJXQyBMWkLmqsRs1+c/h1JlE5XadQlw1oVbbGHTeI0TgQ1wY17uisiywgYCe2mgBMy9f7kvJ5f/0SUwmufoaTaL9pNb8dpHlxxBUuzKumk75OFTVU9cC2GHcOlW1QZoodrGV+u8Zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296631; c=relaxed/simple;
	bh=RVhK6oVxb9rHevdehYvK0PT8VfORytPW7qLfaGFu2FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+Vq2Bekh8D+25wyLdzwvzA2kjkopB8ml9UxwyTWzvEu+3pVWTq9eInoC8MxrbWvmIO2k/IqHHasN/1wcoiazqOSLhm9SQMf3hdpF8HzCW2O5cAbHupD5cPogmV5q/BMeQbuU4OMStfFqMYq8vSrdGoENj+ZTYrgTSiyz5eiLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncNlHyKc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a1acb51a7so46805466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725296628; x=1725901428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr2EaA6QCI6ETZOp7zoxni1QI5uJww9igE8exAcP4vk=;
        b=ncNlHyKc+kWmhyr5gT8SmikfL3enRrkYU4Ddk8p/WspCiAhn3Bt37N7Qr5Ee+27jMD
         +P1pfAzbPO3MHZgcTwN6lA5+XfLHjZbNuAQbm2B3tfVWWnqXZoj4jxmOLp9DII7lIIWp
         S/C2fMeAQ7KU78tV0KD7rVc7d9sk3q8hfBqTeY6fzp1kXz4oNtQHdzOJvb9P8ZFtwxFz
         L8dYvTq/Og1Ft27roCEBwI6j33Mcmh+Dv/6hwQI12nsA2srkKTo9CFjgWHmiJC/+RcFp
         qoVDkcjiaLbG7FgCY11zsLWU+O4j6mYYDOJ+g5j+Qa1lZu7QTzlMHsNQJomYLfXyNqBz
         ZSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296628; x=1725901428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr2EaA6QCI6ETZOp7zoxni1QI5uJww9igE8exAcP4vk=;
        b=oqw+mEx3N/WsdBhZw8H92n5mfavG0Q0eEEffse2xPNVcJ3cvfzTXXH2H33qWDEWe0p
         nUON707yCL+2oN9+Sf9ASDbMZXOPZhjlR8zJUE7iA3Qpu+T++d9rdrzVH/8ohsCfBhBH
         albq2enMNUY916XsVq4YTcBMRNYOyRDQt+CsfMmnzUkYVIoYeUd01dBRalpzMc5N1q+1
         Tk2j8pd2bjuxbx4RFE82jWxxPwr96VtRR+a+FgtMTXQUq67pWGxNxel+nMMhhZWCFvJL
         ZJj+0xTrUFzqXuMW/x77NiKeHlXLqd5cFia8TNstgFhrwBivNbN+mCJs46nMRksh7WTq
         qaXw==
X-Forwarded-Encrypted: i=1; AJvYcCWWqd5oySPE8ENomgPS3oBp4BoPGTje5PO7IdJeqKeO8r3nHEK9qOvs6MOY0rEfDVBb7DfrGONVF942xPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVqGZ7a6YHM6oCpIdqIeiSrSDhsLy40p/sEd+AsajPwRWxiNW
	aceCyLnacYoher2SXrXLY7Sh7lySFWAbzhH/pr1h6q0D1Pf1eZ+p
X-Google-Smtp-Source: AGHT+IEIBNkt4TeEXGNIp613KVLnYLHtm3ip13Kvei9M+Y3uD0vIctuOu5isNMR4BT5nAf+LgKJfFA==
X-Received: by 2002:a17:907:2d87:b0:a86:8169:f3d6 with SMTP id a640c23a62f3a-a8a1d4c36aemr49441966b.49.1725296627239;
        Mon, 02 Sep 2024 10:03:47 -0700 (PDT)
Received: from collabws.localdomain ([188.27.55.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89890229b5sm586597966b.51.2024.09.02.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:03:46 -0700 (PDT)
Date: Mon, 2 Sep 2024 20:03:43 +0300
From: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: manivannan.sadhasivam@linaro.org, lee@kernel.org,
	linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: atc260x: Convert comma to semicolon
Message-ID: <ZtXv739pO0hoeomj@collabws.localdomain>
References: <20240902085019.4111445-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902085019.4111445-1-nichen@iscas.ac.cn>

On Mon, Sep 02, 2024 at 04:50:19PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/mfd/atc260x-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
> index 67473b58b03d..6b6d5f1b9d76 100644
> --- a/drivers/mfd/atc260x-core.c
> +++ b/drivers/mfd/atc260x-core.c
> @@ -235,8 +235,8 @@ int atc260x_match_device(struct atc260x *atc260x, struct regmap_config *regmap_c
>
>  	mutex_init(atc260x->regmap_mutex);
>
> -	regmap_cfg->lock = regmap_lock_mutex,
> -	regmap_cfg->unlock = regmap_unlock_mutex,
> +	regmap_cfg->lock = regmap_lock_mutex;
> +	regmap_cfg->unlock = regmap_unlock_mutex;
>  	regmap_cfg->lock_arg = atc260x->regmap_mutex;

Good catch!

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

