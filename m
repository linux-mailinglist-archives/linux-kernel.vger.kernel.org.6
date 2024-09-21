Return-Path: <linux-kernel+bounces-334864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4066997DD81
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07554281987
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355E22094;
	Sat, 21 Sep 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvPuGy5H"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7361FCF
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726931551; cv=none; b=Q1K6eG4bsBi2kEXn0dY5k1UlAs8RCxqwIYnnZ8LFJ2jobDK09zHV+KiST/vceiHbjFP+ZE+XQ3YwCRPiHAlMPneE73fZgrmurgiSzIuaKLVPerVRVluL/aYdr6vdF+7KGoz4m5AiiJL8/GfKx2huvFjaD4fwCv4FF/I9y/OyeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726931551; c=relaxed/simple;
	bh=PIuHJgFhaEQLPU5bBInkAjhcvbXP1F8JOOJTlHmlSAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl2pgyw1/WM2jTuh8LFUpq15oEXsVZxVsJ9uAwlr0nRnQdbOGSSmqv2e+c2hkYIT07hmy4iOxT9FiTQuVSpYYH+mV5mVfN5kccldUuSWD81vrJj0wwDht3yG0bDBhwv3kGPssrvgtT6Eq8LA/e21VPVCFd7FKcxZZx2vu9L0sVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HvPuGy5H; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f7502f09fdso23971631fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726931547; x=1727536347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+cCIhgS/k2vjc2OUhYMT2c4n8qzUt4Bozql4xrd8IA=;
        b=HvPuGy5HabJ3VZEHXKXal07Vwcv9TK+DWGOv/iGE1jXu0MJ1RNOop5Susm1BPWXP2m
         pC80hDaeE8KKiAlBePW36M5jxuLbcRvGUBs57PjdGJ18sXEL1wREpx6UgOqoR+PE5UoU
         DwBFdar63KQLvnPs5/ON9mnb79dWv/PfM1gtyaKbD7TaS494jHLFEfQBXTPA1BJFaZnF
         Pk+8OA4q8gIbXROWIIusCjoTIFZ+aRNupwrqzoIpRB8YUIiI/vDEEgz0NcRs+G2bhx6g
         wXrXIr8KURTtqvtJLpHZ8yIqk/qvZKQDp2G/LZYflAxe8fpbWt//tLR2whR7Xv40XulW
         RYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726931547; x=1727536347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+cCIhgS/k2vjc2OUhYMT2c4n8qzUt4Bozql4xrd8IA=;
        b=IcEJKMS9bvfLJZOT0oxbg9OKErDWEf3XejtP2qd+RRG5sSa2VKF5v/bHjYjRoh4oEe
         7bNj+DKlkYigx29n5MFW02K6yF8SIb3AQRkHOpSG2UJRQ+g1yPN3/B8l+mU2WnYa0ShW
         HpUAR1Ao/YoZlFPcDdHlM43sZxyKZjUYvBn2x1BIrWSRhH4cYLQ6REKGrddsUBCsaDpo
         awG1SBRM1q/1A17bi+NlLAkvajByLXENa5odjVXOEYzQVpNeHdRr7sw34wzvHkJK1aXI
         n4CRIBCXmH9VXuwa13Z8w/kCFJ/zMRwbW3hNxEZL6gm4TYEeGYtgEYmo0jTNSFUsUbA/
         3yCg==
X-Forwarded-Encrypted: i=1; AJvYcCVIZGlfbgGz58ZeexR/sKAO/AHO+GiJWrSnS2FUxfwdfKCnW76EH019jukZXHvs4NERCm5fG1sn8Zi+hfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTXgFjqtNhh8TtgWjJxKRJKs4ChHhmPgmhAui1T3LXHN5wrcp
	Br2uyDFMRIkjWQfE5PMOStLoXBf6MkxGOLYPDzF2QMoAV7y9R/7a2Pmpj2ez/mY=
X-Google-Smtp-Source: AGHT+IG2Tisg192cwSwUCwOYflL4dJLDoCgZm+4DdO8LkZdejNGKkqxArpzklyjiPrrBO968mtBbGw==
X-Received: by 2002:a2e:bc13:0:b0:2f7:cac8:9e38 with SMTP id 38308e7fff4ca-2f7cac8a1a3mr21993871fa.18.1726931547503;
        Sat, 21 Sep 2024 08:12:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d3002e2sm23862131fa.31.2024.09.21.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 08:12:26 -0700 (PDT)
Date: Sat, 21 Sep 2024 18:12:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Andrew Halaney <ahalaney@redhat.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] firmware: qcom: scm: Allow devicetree-less probe
Message-ID: <4vlcyqkxs5qagckqcqnyvfoq2ay24trcescp3iomenhswu5gpm@kpvuee5itnxz>
References: <fqdmcct5b5sxv3rpxiksmzpjbpcwmyuwpb5epjnhgpzxh344pp@pxggownwv44n>
 <547C76B7-8E41-44C3-8433-374B4E6BC341@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547C76B7-8E41-44C3-8433-374B4E6BC341@gmail.com>

On Sat, Sep 21, 2024 at 12:45:19AM GMT, Rudraksha Gupta wrote:
> > Which devicetrees? I assume that this mostly concerns arm32 machines,
> > but I don't see if you have tested this on any of them. Also on some of
> > those machines SCM require additional clocks, I don't see that being
> > handled in the patch.
> > 
> > If we are to manually instantiate SCM node, I'd prefer for it to be
> > explicit, e.g. MSM8x60, create SCM device, using this-and-that clock.
> 
> I believe the consensus was that we will be using your one liner fix instead of this. If I misunderstood, please let me know and I will happily test this patch.

I belive so too. Just commented on this patch.


-- 
With best wishes
Dmitry

