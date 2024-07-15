Return-Path: <linux-kernel+bounces-252867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450DF93191D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD0B1C215FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566AB446D1;
	Mon, 15 Jul 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkW3vl5G"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146920323
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064022; cv=none; b=WZPTXgR+I1J21jVObjLZNuMOgEyd/YJW85VgLDZyGxUczNzIfrUIN7b2bZCWrmSHh6x9U5wBA6xnNEKw9Ia5LLaIoYUVpAmHanZziW/pKPst5sZqbahSdO1Ocz4QdW4MYYQYIsPy0ye0U40nDQwQzuKJlRbWphZG9g66jTILeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064022; c=relaxed/simple;
	bh=Sf/n4QnUBT7UFeJXh5ABZXWyXDeEu62SSkzHw7vFxWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dceq/3lroszwzGqMLPI+0hZz1iRMrfUpwgYUoWjF1clY9TKTqX5/S2eiBijH/GvqsEMzin5+GvVuK7c1Lf5T9qhNGZixcGzqWMh95jxuw473+cmk/nhsMKeO0PV0ZeyV4QHRU9ZycQ/CRaYRVyt/j8FnwwgNAMRpUSVOK5Kz93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkW3vl5G; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-250ca14422aso2565703fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721064018; x=1721668818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoAukMm2zMn5UhOwGy0LspCYay1XjMGwMK5Pu1UoA64=;
        b=ZkW3vl5GFRdOopZELRgcfYH1Ou5Lxy4QMowV7UzENXcsszJx1bRNyBLDBa+E80w4CO
         wSVc/jOU2vJbQtiO3bEIVJ1Lx24hg3bzJh+kQzpFCLwItG7ETp2MkTlfRq9xK+Qn2u6v
         5TH2jesptH0vE0DLDzs5WbMUAou6SAjZhI7w+4R7SYjbarppsQXqIYwTArGiBpcjqvzL
         dDmC+475cvtFHoF1EK7WeZz7hTeKSAb/8EekrjIstEJJUIPXCPznYOFCGTf0Nccp7zwh
         CRUh4MQuF2ybyDFgnX6k8Afam6JFdDEiY9GzvofNrDO5BnClQm2TyXg6cBv/3w5TlPMx
         Ijig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064018; x=1721668818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoAukMm2zMn5UhOwGy0LspCYay1XjMGwMK5Pu1UoA64=;
        b=YguyE5Z+FTNgUCjdU7fH/6jS2vXNRSON5mFDCxXkOem4NabU2VKCIFLmZ6kWanzOEO
         8lcoNh/l6JPl98muqIPQkE94385ojL9uiNYdL5DtbxdYUyIYnLVKjeic/SmXkdnKF8OO
         AkIQSip62uB9oFdNaOivSt82QNitwCiHcDsmBTkAKHg5ch3el2lTum6dGSCnxS4iYAlD
         mHfIEPhdmo+iwsPquG8zdZtXkPO8+76U5v5T9jFuN6p5QzKgG+GOnQaRh3XNspOza3MF
         dQNP3PvJvQs9e+ZTfwOhDyYVxJpUfQHb7Zt1GUirxkODGUPrkcLGd4Th2bceYX5Ivgfl
         4dTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsa0astJ/GxcdA/j8sOzxz/DxLfhhJPcRMOrt3wxC2MA78miUk14nQFdj/4+5c1OlDoEISeVFjq6Oj0NhMvAU1pImvIKM9As4GR2c7
X-Gm-Message-State: AOJu0YwXpi2+wDL/Agkgq/eyDVqUk1/NlUKUcpZTIsVMDOqIQAjaMGq5
	UgMQWkUWRj1Qi/p9SZ2i3XMyD641wisLeK4kRE2vpN7ENgod1hJivqRnOQ==
X-Google-Smtp-Source: AGHT+IEYigfaVcft+pSjLcRTMH6OdObPyoMchhIn51xfiAq9kwqNzoh+7XbUlPQzXSAFR7/ZkxN7Ag==
X-Received: by 2002:a05:6870:fb94:b0:254:a917:cb3a with SMTP id 586e51a60fabf-25eae872980mr16147368fac.28.1721064016757;
        Mon, 15 Jul 2024 10:20:16 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eba037esm4770629b3a.17.2024.07.15.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:20:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 07:20:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] workqueue: Changes for v6.11
Message-ID: <ZpVaT67QamgjFY0t@slm.duckdns.org>
References: <ZpSo08Nd3QXNFK30@slm.duckdns.org>
 <CAJhGHyBMeUXoV9UaNJp8zgFiPaAVVnU-zBOFH_-BD8zre4=QUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBMeUXoV9UaNJp8zgFiPaAVVnU-zBOFH_-BD8zre4=QUA@mail.gmail.com>

Hello,

On Tue, Jul 16, 2024 at 12:03:09AM +0800, Lai Jiangshan wrote:
> I'm writing a fix to fix this change reported by
> https://lore.kernel.org/lkml/202407141846.665c0446-lkp@intel.com/
> to remove the unneeded lockdep_assert_cpus_held().

No worries. Depending on the timing, I can just refresh the pull request or
do a -fixes pull.

Thanks.

-- 
tejun

