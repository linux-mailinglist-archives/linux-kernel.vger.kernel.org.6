Return-Path: <linux-kernel+bounces-243875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96337929C10
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C824A1C21426
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739E12E7F;
	Mon,  8 Jul 2024 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRj4H/AB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0FB12B75
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419582; cv=none; b=X33N+z2a7TOTZBqvCizySAuGEk2ZLFb3QSwNTdf+PCRgEK9yKCDXcxqz+GAh20aTfd+kXMhsoCo6hVygPLmZ00SUX5FMZ/DepcKrSWAO5iXwFtATdnShmeCv96BT6CRO301ts1EWyZqtBLIlilbOZ6xS/hsZCXzPf3WZZ5J3sLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419582; c=relaxed/simple;
	bh=FrGPK6EUaCJAvbMMnppTmGDP+dhdPamdST74mTb7oEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIkEKwExSgsTTTxkeEaqu03o8UdzfA4ZgTYGZtwjndRUOc6xWr4GNMDEbhBEAWjEOR//tE0jApVFsLTiB3pQ6j7AMUIA6y74WKbEttFDlGAxI5HgyskB6bH4EYhskTYyiaP5fUW2cg83bb302oxqWa3CrVqeaFJXqJ778B3mJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRj4H/AB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb72eb3143so7749595ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720419580; x=1721024380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGhefo6o5KFmf2E24R1Dpp1qvNYp+Ydk7KMCxppdO9I=;
        b=SRj4H/ABZciDrgepzA4fD53E3imG6QAxtzu9YN/p8HA5pPVh6hDoZ93hkoOk6+BlUP
         yIPnwbyqGYNboKNPEHw1oLRKaHbYsz4DBliXHlWqxLBxBMT+SwwvnedFNoGxD8pUMB87
         QQmFiQ/dLLQtoV548Hl00LL4rBbDX0bBJF2y+UwdLG74cZjpwb8bd+ccu1Mn5v7rSTc6
         Cz5LlSbYlSGfGIifWIp6lWJ7mw6J9thvXFuBKVMWRK0O21A1VdM4TNcwwPlS/3YRqq26
         QEr6pX15PVWiPmL64PwQW2lfoizwo2GPYzIsVjIRw3QaJmsoqhfPo6oyyzvtEfmnmC86
         VlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419580; x=1721024380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGhefo6o5KFmf2E24R1Dpp1qvNYp+Ydk7KMCxppdO9I=;
        b=aXLDDdjAr504c1wSzX5Qb/B61zEsusdonC7653YgprRFab5EoZwIWTKpK08/gYAmQY
         snWgfxdUuaxvEuNno7TTCAKRkcxL9YnXk4LdKm8l32HvHu3R+6Z9FSwi65i/OreBF0nS
         eHlp71MtPJDLPKngs0u0alSVJq2HfL/4IK3wzr+uKI/O7Y19/SBUxtdnnbifLwjjDr7g
         xbNh+rjzaaujjB8EkNG57CoKFktv40CYuyn3GV5H+nbSYtfcMGwYH8Ju7zWXrDIRy066
         4C4qCn7owSEnhhPTcgIOVrVY/5N8eQr50K/Lj0yfL2fPwvpyup4S9aeEeQN+BC4sRkTU
         fbZA==
X-Forwarded-Encrypted: i=1; AJvYcCW240m5ZRORe0MqaZuy/H/aggCinBeYaeYJKhSavOSlKo5c1EWF1EsqQ2xhMUh7l9IF1XFVlX8Xya2+6x1YfQ4OJdcy6p2m/7Qd5anG
X-Gm-Message-State: AOJu0YxsVD5pG4kr54lsep0hCjMtnEdvcjjv1F3DQdYLZKQBXTn6Ur9w
	LFfkjA9avh5RtVlIh/Sb6gF1URak3jHf7981NgbsBsci1CGd87bEFPtr11iO20Y=
X-Google-Smtp-Source: AGHT+IHTWReOqAFX0YrJU/63eWlx63KhLsjYjHVxuK1Cq8ehkjxkTj+FFz9N3vq9Clj3RIXt/EwFXQ==
X-Received: by 2002:a17:902:ea06:b0:1f7:1bf3:db10 with SMTP id d9443c01a7336-1fb3707c0cemr165798295ad.20.1720419580161;
        Sun, 07 Jul 2024 23:19:40 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb8e1ef3efsm14847625ad.223.2024.07.07.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:19:39 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:49:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jian Jun Chen <jian.jun.chen@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: delete entry for Conghui Chen
Message-ID: <20240708061937.p7lhz7eho4dh5bv7@vireshk-i7>
References: <20240706144150.2668-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706144150.2668-2-wsa+renesas@sang-engineering.com>

On 06-07-24, 16:41, Wolfram Sang wrote:
> The email address bounced. I couldn't find a newer one in recent git
> history, so delete this email entry.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68e3ef05facf..55bf8ba02386 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23842,7 +23842,6 @@ S:	Maintained
>  F:	drivers/vhost/scsi.c
>  
>  VIRTIO I2C DRIVER
> -M:	Conghui Chen <conghui.chen@intel.com>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-i2c@vger.kernel.org
>  L:	virtualization@lists.linux.dev

Not sure what happened, my email bounced too..

Adding Jian here, as Conghui tried to make Jian the maintainer once [1].

May be we can add Jian as "R:" here to keep someone from Intel in loop ?

-- 
viresh

[1] https://lore.kernel.org/all/20221214053631.3225164-1-conghui.chen@intel.com/

