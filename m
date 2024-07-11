Return-Path: <linux-kernel+bounces-249590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BF92EDA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3477282936
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071916D9C4;
	Thu, 11 Jul 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTiaVnEs"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236676034
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718464; cv=none; b=iEdCUTPSVHa9oXWJKuJoQteDON/leQEizX82/HFjD3RuTzfcLBploWT6+p0qEir/6lT0G6Mj7X/twit0DwX55FM3pV2sj9a3FpjmzOPRBDPzxF32t081dbXF4f6pWqEQPpIEmj9NCGP/OxRBPurMZUNVs3NrkbNEr2A6dtAQW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718464; c=relaxed/simple;
	bh=xpGGgheFlviCgE/M7jt8++vL5rO26HLRprOV7XDZuZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtJpLWNXplkUM1Xo7Sws+TbJgUUz7tXPidtpm+st0mCE2t/VM3J1754v71wFZbvnKSI5d5BlmBi79CXpryoParWWpU1+zTknT5PQcsnNJiagrSi9+fV9KYy52SsVJusE27h5bI/6QU2d1xo86ssqBCWkgR63vQVU6WiGIVRnYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTiaVnEs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b4267ccfcso1057279b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720718462; x=1721323262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbIElNYZdZe8PXgbU9inEfkvYdMjvy+CKdusfz9bCX4=;
        b=dTiaVnEsiyn1eSXjw6gAdj9Uv8h3wnJTQgIef1DSyGrrNsl+9tGL8zdpDuaa4akAiX
         PenSgKCEVnhKHo9eWz6SJMjg64yHD85Ln2VkN4pE9felvIY6kQi4+C0zSyqkpBw/+fF0
         q8sfJP6xXQJxjsCnB0QUj5dPKzeeTDKjkun6Gdqm7TLWjKufKaN9Gm0+4Hna4OSsmDQQ
         NgwUr7gGk5Hc48cyLz9i7+hiqtCGTgnmSyPbSJDo5zDuC2QosKb8j7wCi7KivZ9SBiXE
         GERDEbSmhCoSuBUl7Gnm/u1lNy8K5QAHLLF5WnMnev4EsUm2At9rkBzFZzBg7LpczTf3
         ygHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720718462; x=1721323262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbIElNYZdZe8PXgbU9inEfkvYdMjvy+CKdusfz9bCX4=;
        b=lyBbIc/ZIZ2W4YZw3sawJCCLnIG+XuwaxH9Rbn83ClWR1oCqAmk07D08Loxc6aCYqa
         TNensUju9Ns9hgDZdeQPl0vfEbgVvxeHNVGcl10ZZ+1Zp+HY5vSi7STIDXpb2lWgZ/rk
         SS3tpOR3xpw0qy0svBs9XV2wc7KGeAbzQWFj5sKoo5dogaafslk2jXH4kAYxFzqEGCQ3
         NM7KNEIkKR4uhGpgTjsVc1ZqV8rnQXRqHscyJIi8NRVRmYobOKkgXUja1Dq9oXrM289b
         pVM3k0UxitFtjSN6HweFXYck1QLTkB8m64Y4SDHuiEoPho47aoRlUBdIc6Rh+Bykbtb6
         om2A==
X-Gm-Message-State: AOJu0Yz2Hu8TuhNSPAEiNGY9sDH3ITRBHZEsm4Dx/Aw17ITm5coobun4
	VSwLrUxZlOAUn/i8YKRYxQ8PyYIpBHtbya8t9F/YnA9RN0SGgmkNHFHYGQ==
X-Google-Smtp-Source: AGHT+IGErUf3jdXS/TG7mXV9rhhlvPbBAK+/EsInJXUYYZh9Qj9wy7Rd5LEEK13/XWFjshZMQuq0yw==
X-Received: by 2002:a05:6a20:6a05:b0:1c0:ee57:a99e with SMTP id adf61e73a8af0-1c298215f3fmr11769666637.9.1720718462486;
        Thu, 11 Jul 2024 10:21:02 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b53a8e7d4sm3572583b3a.203.2024.07.11.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:21:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 07:21:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH] workqueue: Simplify pool_allowed_cpus()
Message-ID: <ZpAUfGD4TNz6oWpk@slm.duckdns.org>
References: <20240711083831.4273-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083831.4273-1-jiangshanlai@gmail.com>

On Thu, Jul 11, 2024 at 04:38:31PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> For cpu worker pools, attrs->affn_strict is true; attrs->__pod_cpumask
> and attrs->cpumask are the same.  Skip the pool->cpu test
> in pool_allowed_cpus() and use pool->attrs->__pod_cpumask.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Applied to wq/for-6.11.

Thanks.

-- 
tejun

