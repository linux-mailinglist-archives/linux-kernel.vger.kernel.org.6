Return-Path: <linux-kernel+bounces-569166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35573A69F72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DD642782C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E941E0E00;
	Thu, 20 Mar 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mH/nYgnZ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB981BD01D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449171; cv=none; b=UyHVbECsLW92ObFxKiTLuUH411jvWgiKeR6cYpnpKT+W9uzZLXPe6Tal6a7x0yoWJBUGy+2oxvrkFFBzJvLgTcAWYBDaiCNBfUe4rZ5gevRv1qlrF6f2WIDm3Gn1U+pv5sIFuunWS8JKhdiC6qdugj0ca3Wl/qG45Fk4wK1voWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449171; c=relaxed/simple;
	bh=HSCSKfhfDD7I1zTxBolH/tzZ9w0jNV+XNDv1/LCD76o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaXoBejeTS+SiYxgbHunHr309KqNRtoOdSAaG5buTkoRyn5qrvF1b76QvNa/SH278jKOtxTUI1U6zQNi0iZcGpv6aNPk1Ks2JfTrTH7pXgpo4wOoM9PvZjyPCAbtiF02Doq8LmbDOrNxEejwcPv7ioU83vNvu37DNw5Z66OEJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mH/nYgnZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-394780e98easo177039f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742449168; x=1743053968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1xfmCIlDCLZv6ta1QqTTHp5D0zhqGln1AOW6eZ+4nQ=;
        b=mH/nYgnZW/DbN1VRYVvFwzepXqzkrut4fgO2GX5Lsf6Nk2+Ixby17BeC8gr1cftnDi
         jKfx26DnI4yq82lZXLi/i20RUM+sxeWxLWyp9D8Gx5tIGGfhN2rLsvSEQElg79EOyPUC
         1rnQD/4ermbWGgOFNJ2WRBGR2lf9zUJng/gQGzuHyPQN+qqcgSkJVUla+GHN7rq2bd4A
         Bgo6Wy8nMkfhREskXKc5Ily/bZsuv9858HvUcXuIuP8yWXi9aeGeOwtOO9kHukpmWbBu
         Mwy33St28bzsb6HlIpPoqOA5i9Zfnevv0OxA4QIuqZ15wZzO5ELhR3DtbpNwPbbofuu3
         v7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742449168; x=1743053968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1xfmCIlDCLZv6ta1QqTTHp5D0zhqGln1AOW6eZ+4nQ=;
        b=hUAjB9Yf145xEY2yEI2mNjxCPY0Imoa8PdZt0ga1rdPrXdxiUoQoylv44Zq9tiO5X+
         SUjJYI8lsDWI6cYJzZmntFbL9cmoir2ffrsjyRgQYF9KvOuJlMWG6f/39rXrky+on0fr
         XjYy9kvmUN+ZyvvVxnY9A4b+tC9FsFY+dFlfCrkc3hpQgwWWWyQuLPx0ZyY7Rfnz84sB
         Yf9mx7qtSpPv1uV55ANhweNTmPhR4jIMxj16HisUwBPsGDgS+Tbl5gsIhINRj9jO2iej
         ahCQLCypC4mDdW+f06jnG3Akme0Dv60rhTazisEeTUBEam3GIrfN9Wd98//jO2njvUSv
         WSjw==
X-Forwarded-Encrypted: i=1; AJvYcCXVmLAq65NKaohfIVq6Wd8D1cyvrO0aGnthTPVw2TWdm/Fj63ceGe8ZB5lkl82YpCtkd6x8cv4iAIAXqbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNnwBkWAEiGarvr9d+lWGcOgEXeyM/CIFMcjbMEhyVyACTMGk
	jplooHraaV6HYiMDEeG8qg+k9aPPRU60LTWPIljw5t3KsAQOlvieuTqFoxhdHWQ=
X-Gm-Gg: ASbGnctNw41P4vX5VJNGrim9BpLAIZyoL8dfKvAKXiY83VgDDznVaOqVB77FiaxAkGn
	Q5M06UjvF9ql9Yngw85/B1QlkDUxc/USXE4Teto2jNghhQWUnWqXJCdeR8h+JHSEycq0/M73wMv
	FMrkY7ajRneObvzoZGpEY/ZhuljxmCHFW98QyI643FwgZNJ0W4C/5uAjLSMe2GWEbKL/pxIj6Xt
	lBGeDVo0b5ey3KqWSSY5arDgr5DYr8EqGczeOMdz10HIDhv1pZDx0g3VfNyTAILtw+0i/PE4qSC
	XgcVqAPJdLmsBjHXU/R0Yj1D40rXBwXyia2RALN/jXcR4IuAEQ==
X-Google-Smtp-Source: AGHT+IGQzpC9EimzyS/t+4sa9m1WxjhJGJdtlCwpcWgQVOt2GkYCyDGik+tts44dUuzfVSiwyZSIYA==
X-Received: by 2002:a5d:5888:0:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39973b32bb3mr6150923f8f.39.1742449168214;
        Wed, 19 Mar 2025 22:39:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c83b6a10sm22976809f8f.36.2025.03.19.22.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 22:39:27 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:39:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: brauner@kernel.org, tytso@mit.edu, jack@suse.cz,
	viro@zeniv.linux.org.uk,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ernesto.mnd.fernandez@gmail.com, sven@svenpeter.dev,
	ernesto@corellium.com, gargaditya08@live.com, willy@infradead.org,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem support
Message-ID: <541236f7-adb5-4514-a888-19fef74c14f0@stanley.mountain>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>

I don't think this filesystem should be merged.  The real upstream
is out of tree.

regards,
dan carpenter


