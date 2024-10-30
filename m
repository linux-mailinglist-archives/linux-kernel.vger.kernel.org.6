Return-Path: <linux-kernel+bounces-388279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68B59B5D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCFC1F23A54
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F71DFD8E;
	Wed, 30 Oct 2024 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xw+WphWp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484941DF723
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273933; cv=none; b=XLHiriAtK7IYcQsdhhjOgirZnqxwSwrMlw5nJoInB/utLN1W9NojXZCLwPIYpsRwopCLEuK/QrlsKEXMZ2ZFFWHZdDUROi8q+jyYVOY8d/gq+CSvoo2T5xnBBH0ExSut7i+SjU9G+l6OaOjSByiRgVX1Gf9ajKAfqOK9sWe0bE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273933; c=relaxed/simple;
	bh=CIfyIWKyAZopCYXAVJs0OQjdB+bx4WxORWZhQJacI6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOJpOSY+sZTD781Zkf2U6NSRg/c27CrTgAgOgv6sKpooWknQJtELbWU/gKTjR+MQbXCqxiJuYidP9rAps/NkGwzE2VGPpCOa3hhd4fws26gzAnlgj9bUqPgRbcK8UQyOn0BepBbr91AF0ksjJVOe0uX9VPJ43Tkkqn7k+0xoa20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xw+WphWp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d49a7207cso4441572f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730273929; x=1730878729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LhuDhEZJkU9JsxAhgAFW3kJci0MRgq1vPLOeXgFWtYk=;
        b=Xw+WphWpaaVpbkAT9sR8WlI0NKwpkeUg0wdbJkSrmH3ycxUEmCf8739/qim8tnxVYj
         /OgRazOYtUTR2YTantULEXzSvw8aMfQqFmzQpZk7vHti/mvjDgffKxi8N+dafyn3wkIi
         rsGmhzVvM1uCff6MbtTk7dYwrJbHRowtO15CPnhDSOTc36u+0P0oFAB6e+Acc743RzFH
         66TyAk6llaM7AdxmlV1OLH52GNh5MUYw9UfULYtgAKfEw6W3uLN/7aiEJi9f4QY7s7JU
         8/iXmv5XPtqSwW5tf5v/IAMDw/SheW4IRl73aK1AMIrp2sOcMOtBFF9tqOOcbdA26RQX
         wzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730273929; x=1730878729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhuDhEZJkU9JsxAhgAFW3kJci0MRgq1vPLOeXgFWtYk=;
        b=e0sG2h1W78L7ovuuqHa58z5GYsSARB5pu90BgRZOwipeXvu+Ds/Vu7ojaN2luO4uep
         38BiyboYNwAw6Ck1eUc8Lk1Xbyfh+NNa5GrS3xNYktIenJqNknRSn0oRagfKMkSBNkDa
         GLODS5sY6p8DQoYRQl0BPT6v90elNsWhQI01uCiz2pytvXvcabCHrz3a2x++KP70cOku
         KHWLbXEjfyC3em6dMzzo1BctVSn4Hx1PU2YkCEPxYEG0Qnj3uE6ZzZpao+Eibeeeg9Es
         LqgKN1UCcRfU9BHi5DzVgWSuQAkOYHISMmSFN843wkP1G/XtTiZnnpCTyDeCDmole3ZL
         K8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe/hEa03/V9e1d3Nho0qlVjQIhccL0NTv1aeXPRjhj7sqxBdAK30GqdjKEGr0PB/FrL/hj97SRLtKafdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9hHl8pvD5Dou4G4gJKiNeToTQUUKDaVYD4TpOZOF/CgfwPMC
	o7cCids8ielRZ/GJn4ybT0PTXKlEyvoXLNCahY7SGwMUUCftZXeo1/iXci2LZGM=
X-Google-Smtp-Source: AGHT+IGI33jQx6+cHtP7k238HF/+0YJfRR/AYslQCtaxx4oYHXtWzKb8smj2QVp0Aloib/BJCoOhMg==
X-Received: by 2002:a05:6000:1f06:b0:37d:481e:8e29 with SMTP id ffacd0b85a97d-38061159039mr9314149f8f.25.1730273929282;
        Wed, 30 Oct 2024 00:38:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9d008sm14509226f8f.107.2024.10.30.00.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:38:48 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:38:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8723bs: change remaining printk to proper
 api
Message-ID: <0d397004-0bfa-46a5-a184-dd85f15f1533@stanley.mountain>
References: <20241029221544.112800-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029221544.112800-1-rodrigo.gobbi.7@gmail.com>

On Tue, Oct 29, 2024 at 07:15:44PM -0300, Rodrigo Gobbi wrote:
> As part of TODO file for future work, use dyn debug api for
> remaining printk statements.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---

Looks good.  Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


