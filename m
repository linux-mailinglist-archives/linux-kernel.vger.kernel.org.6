Return-Path: <linux-kernel+bounces-363296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5FF99C023
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532B61F21D62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8F1448E0;
	Mon, 14 Oct 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsC/mUOC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8233C9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887991; cv=none; b=INX9d4Wv6ti2tK0arDEYASz7UmgxIMzaWgvFjB3oRUYZ/oXd87hdkXxjoERonneccsye9iA5Y8rjiO2IgFS22TnZ/1yBMB9WkB9NSCKDEvIWAJ/TC34GHOQOeX+cQO1T5mOLxhq3bfpElC62wBmHpYZnOkxIB40eANMQ99rycec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887991; c=relaxed/simple;
	bh=FQphEFLBshXmaOE3JlV8b4bsc8E8MCSy4Ag9EHta9/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czG8U5s5nnbqDZoK3+YLal5eg2mCXo2FtCRS7C1vmwe4KzNPhbmV+FfyaqF7HshcHLGyqHUnGZhFaYOalM/SkpPvoNUIG9K7ChddWHRGUzsGZ20+chU2QMXWtNjl1cWu0MjlwaZOFiCGc9Sv+l0SMFzM4JIuTqh2GcDxE9y8Xmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MsC/mUOC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so457752566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728887987; x=1729492787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRglJQJqC3kB/kH32ye3qji7yvxN38IgBxBdJmfg+rI=;
        b=MsC/mUOCd+/tH4VAk8FfvGu+bkjTDSY7kAb4HJPI0M/gD91bivIC4zecikPKHSZFjP
         8X+a5e0ZPRPEGhrVWolYW1T5iKJJyhN4iUrrtk0b/hA0KT5kndunjTmiEQaqL3N0osbL
         22SvV4+0ALZpEOUPw4H6qhdD8irH8tXp+HhsdPLL+SsAo9Te/4sDTpEodzRkHliEnQlj
         vrL8K2yU8ShMFDXE4aYKcURn0G4KVNfJaBwUNCxppwAl+KQX1Q/qw4ctu+H3sD4IMh3n
         7LSP42BzV2nDhqAlt4hqfcy/eqImuvCGaia1cYn23vfmQamcngqYze8wcLlHgbit0uZ1
         BmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887987; x=1729492787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRglJQJqC3kB/kH32ye3qji7yvxN38IgBxBdJmfg+rI=;
        b=c1VU90eq6MbGh2TeOmpxGFl89kq+ATnsBpXxNMBc0diQgDWabDOotrjQ93kK7SfseG
         Ah5tO2pHzQxiVp/L2OeWpUsZ/bjWPCSKXpLQSnMNw3Q40Qt/qOXLW2mAWWdf9ZUJVTjz
         4FoQtMeX+OpvQIZPgidOd6KF9O9iV7BBtZXvY4SMg9O2o1OhPGAJ0DewZdYu5dbqAaGb
         ZN+Qiw/uhJxdKR3lfIR3aooAGRnvyDXPjGuFaWx/uiT5iMJyLxQ29X2lrwOj/YX8wXab
         T1PE2ELwkxtu7n0MsQHeunfZschPRImv9/urwAqmuLcLNdmxI0nVqaLgwHblDSR54HLY
         5oWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJbsbHbXjujebljMgXnpArXUCXpSaLFeHC1fKWIWlflLZ5cYpgdZNWmi+j8Ba5ptv8749U/369FtYGO8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMH6XPS2xXL5I4s9Etp4zSPWFf0Kb7HcGhsGNoVG0FOEaSRLYF
	57YyBb02X07+CzAei7psJmHMu60gwY8D2la+LXQdgquuErLr0vkbxUA3mZgze3Y=
X-Google-Smtp-Source: AGHT+IGEOBmGpibQOzzCmzYJ/UdGfI18YNbVf3R8nb5+9YuL5TW0UD8qfNB6tNPfAZALkQ3UkrXf3A==
X-Received: by 2002:a17:907:3f99:b0:a99:f4fd:31c8 with SMTP id a640c23a62f3a-a99f4fd33b7mr460434866b.22.1728887987168;
        Sun, 13 Oct 2024 23:39:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99e97b13b6sm294033366b.151.2024.10.13.23.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 23:39:46 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:39:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vchiq_arm: Utilise devm_kzalloc() for
 allocation
Message-ID: <43471db1-f34b-4e4c-af58-4fc0f45248bd@stanley.mountain>
References: <20241014061256.21858-1-umang.jain@ideasonboard.com>
 <20241014061256.21858-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014061256.21858-2-umang.jain@ideasonboard.com>

On Mon, Oct 14, 2024 at 11:42:55AM +0530, Umang Jain wrote:
> The struct vchiq_arm_state 'platform_state' is currently allocated
> dynamically using kzalloc(). Unfortunately, it is never freed and is
> subjected to memory leaks in the error handling paths of the probe()
> function.
> 
> To address the issue, use device resource management helper
> devm_kzalloc(), to ensure cleanup after its allocation.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---

Checkpatch warns that:

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

(I'm the person who created this checkpatch warning.)  Fixes tags aren't just
for regressions they're for any bug fixes.  So the Fixes tag here should point
to when the driver was introduced.

Even if the Fixes tag points to the first git commit, it's useful information
so, please, always include it.

regards,
dan carpenter


