Return-Path: <linux-kernel+bounces-516626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09469A374EF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1226D18902F8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE22199EB0;
	Sun, 16 Feb 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJrAqKz4"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE014156F57
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718681; cv=none; b=a25EB3K7lJI0wm5Y1Pgek78TnLxB4OraOkrBJYhf+yeJO329Pj0EwW2H8Nrp+KS+r/pavaAmLnon8/8R5WzYrAewsATOiO6u18TCFQh6KHm1EEsq85NG8OvYC5VzG+7Qy0gpqVxixN+H1JUz6AR2aSpKRZdiaEBrPRaOCcni0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718681; c=relaxed/simple;
	bh=7WAIv/jydcGvBTgK8OPF3JMDNPpY8FU3evihuDqV3eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKpSoUHvUJODbXhrrDox2D/dtUHD/HV22NiY4tRRKY5AFXnHOnECsbhusOzlhZKOffkobsipg3jydyV9C4o2AXWAqJ74lcbksXUyNBYrAWO5IQ2tuRumzQjhiVWtz3+MiZSKebuJw4XCKlfqV4Zq/kGERru5ijkjSZQ+TndC49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hJrAqKz4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so4294583a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739718677; x=1740323477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TspFxOjpJNNIOaEIYEoqWsypLxhWcsewPPhTBv8nP+M=;
        b=hJrAqKz4iVyy+MYvnGEJ+7/PQHGhur68iyy260o9WScJvc4uDmeFkw/McjuJFWPlWR
         lFuqkt0k9wUKx+jMClS98qpYPpTqI6fcPieEH05mXEr3AjbqIwPyjPlD8hz0sWXmzrUE
         9Wcq7BzJqfp0vkSJoJi2ABwC5mxO6J8+6j3WeBf8cdwS0VSL2vUknlvYCn41E8L6ibBU
         aJ+Rpa0zcrNXHIYTxY0fsq3sQed1EYWqTI8qn45kyiQyK/jx3VWOBRGPZVwJQuDWXQKU
         8GKnWun+hmvA3U125c+U+H/+dIyV7c3YgIGBYHETL4YaXfsOOg8sX3pf4yL6NSQoMZei
         Fp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739718677; x=1740323477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TspFxOjpJNNIOaEIYEoqWsypLxhWcsewPPhTBv8nP+M=;
        b=rz0Ka1SIBMALYaLAxruI+W6ggBd1QTpGe4wtUi8PnwMBuQfPI6wReEFmm/fOz6T15a
         LgkpMZa8bLoj7me8mnsZMICu3BoZvtgMtuQFbpY84tEkZU1PZI4mFN3eVdUXeRYe7Qdk
         JSki6FaHqnf6iVB4QUquISYC0e1eCNnerM3EsRLjWks/64nv3ynxZw5//VGaqQ5hEJwl
         xQcrXeAXdheWOf1yJuaFqVtVNVJv2tuAmkyqZKir4QTTBn9991cDE+0PAHcAMZbo6LZI
         q8a2bMWUgcJPe5TfQsOsjtYdThomo4tIzxVaYJxxTK1iRqiG3VFzHIICEUITrZuHrR2M
         /Srg==
X-Forwarded-Encrypted: i=1; AJvYcCXwHgRZXym0DFYOSVC1r2OUTj7mn/VUbpvkaOXZ4iLiXVgf/CdW5HQUnW7UKei8FI68+V9v01nX5jCcrKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozYMoH6Ecu/80Vi3/CH7RHRvlMQzwXfcn2ckFj1K63cm5Jane
	SI2J02zZuToY5pghZ3SJRkk86JjEraso6VWdsfiEBjS3FqIzzuzupqVc2si2FNM=
X-Gm-Gg: ASbGncvB/1Py83H199cmDJFm8A+WM71mRrfXig9Z79F1DILE+5tRDDlsl3GGMtcJw5s
	Sthbl/NEj0hAjBVepD1RyV8Uoka8skAJMag8McUvcTz0BeFuLcPK2qun7gmXaSGWMn3CgZe8bE0
	dSEdfK9YT9E8ISjuPJVRs9gK/6Q226/lOU908oaiCw8LCrRCdIiPeU5pVRUUCvKHUZE5Pzan0JT
	Wxm2Jv36Yxk3NwEOJSVYEhhbc0QCUbuol2YrwjVvpKjAFLANjgrn27QHItkOz9vUY1Ldqy8XsmZ
	JKjPiLplbQ1XDgxsnHij
X-Google-Smtp-Source: AGHT+IH6o0esJkgkTbUCvIMQRI/0gjQPiw2MQI3TprBRP0yx0cbzYpgZU75xT6HBbS0hknVkKfQMiQ==
X-Received: by 2002:a05:6402:350b:b0:5de:a74c:3dbf with SMTP id 4fb4d7f45d1cf-5e036175cc1mr7121487a12.28.1739718677152;
        Sun, 16 Feb 2025 07:11:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5ded709a92bsm5000065a12.63.2025.02.16.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 07:11:16 -0800 (PST)
Date: Sun, 16 Feb 2025 18:11:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gaston Gonzalez <gascoar@gmail.com>
Cc: linux-staging@lists.linux.dev, dpenkler@gmail.com,
	gregkh@linuxfoundation.org, arnd@arndb.de, ajithpv.linux@gmail.com,
	roheetchavan@gmail.com, niharchaithanya@gmail.com,
	eleanor15x@gmail.com, everestkc@everestkc.com.np, kees@ijzerbout.nl,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] staging: gpib: remove unused variables
Message-ID: <cff414c8-4820-4d46-92c6-09683a005ea8@stanley.mountain>
References: <20250214195456.104075-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214195456.104075-1-gascoar@gmail.com>

On Fri, Feb 14, 2025 at 04:54:38PM -0300, Gaston Gonzalez wrote:
> Remove some unused variables found compiling with W=1.
> 
> v1 -> v2:
> 
> Address Kees Bakker review:

This looks good to me now.  Thanks Kees for finding the bugs in
v1.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


