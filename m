Return-Path: <linux-kernel+bounces-310867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF9968237
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F58284755
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F4186601;
	Mon,  2 Sep 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GO/WB/vC"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297951865FE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266496; cv=none; b=c9YDq/6RqJDS68AC4fcf37IiZaNMW1VHKJWKCVIkOmSbHtUxu5f/m4JeJX0ysA/vLzpyWXnKzdON1v5+6rJL+RzbAoHbUhnL+aydnjSzdwOJxszw3oPfVEfJOLFKfljnSgoGE+Qz4hu+eSzNkAEJwMAOOqaPRz4WYk+7xql8IhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266496; c=relaxed/simple;
	bh=U4pH9n5opeXrTqy96OEvKqqGlgFtHFsAUi+KLg73r+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcpnvTCHy62y55kGQFSSF7LiE3hMyNnrwlPuC46e0mpxT/MovDC+5oT9401K+Z0Pj36Gkb5w8nzytuDd0eKdQnmu6vpcmVSJ9EwpTuIAJ2RGebUVMKKbb+ayUOau9TLlzIrnP53s8dwS+EOv7zXDtOk5JrDos5QQQAi4vvCPTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GO/WB/vC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a81bd549eso325280666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725266493; x=1725871293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Utp1RoWfhaGakPbnKMVk3xSbFrGMSY4DPD6Mxcnr7vM=;
        b=GO/WB/vCGGjNzm79oYQK5rjK14AoxVVXyRbSHsv+UDfpqclVn2OXYVfU0mT4Un6ATu
         E9ikzfDEiM8/b60Rxp5ByyPv8kMv+1tAQCf2do9qpF8MoXa9Ks4W/wQQcYE9gjO/8pI2
         HI2p7tCZTrXM9OGLI8UGhkaMj9zHjEg99SDnQy8sj+2RRswxa7RE7ny3pMBAebsza0fa
         q3OFXxILxNuRgK2Ldqbj56nCd0qbsaSivRp1Ut/K1o6XE6u3sDBUatpBGHd4SrAz3Aa6
         i0VnIziTb/CP4w6oSKlMCILJexkykGQf7VbCJIieezvN9x78c81dUFlcZGMYlxOq+lpi
         nZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266493; x=1725871293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utp1RoWfhaGakPbnKMVk3xSbFrGMSY4DPD6Mxcnr7vM=;
        b=VZj2j7W0zmazNpOvIwNWlExP5UYBERci13ghBI+Qkzpbkwdf1MIrFh3yBSYz0KxHEY
         kQTNHvITf4K1uZobzPSHeqpAC9tEjP6mj22x+80+8I95KbALRxkMVt7d/izNHLAiyTFq
         sYMO/7YKakA3pe7wf8nJVCQsB3G4oQPfgslCiQ0RQhWwyeNTbpIGVhrucY3eOHKHnttG
         zG3svFfcLwV1FCVI8RSt/o0txNBignqb8QVti1aTjpJqoNpefSe9ZHxZLzhlBNxi1nuc
         D8nKegnXyFbRfZGtTVebod+VvmZZb5t1f1oMi15UG411xH61VtEfat5OZEjCDSUI8zOn
         YZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWycmGw6gL30Jv8uL492de0/Hi/COFOPp/SDO4zrpgakUn5X9/CsUBXLJpq3fj8QOg2QH0o9PR22RYfMj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqad5Q5cBdCKLusbs/7speMdNuH6ISFs6/8l1JDw9N1YCLsyXR
	gvN2Pv/LUoAqlXz2uw/n3p6bGWKL+BL63qvptN18yN3jPVPnVxo08Cyg0f5+YYE=
X-Google-Smtp-Source: AGHT+IH0oa4HGDBaWmEW2YFqYs/c/VIYcD3KLgtz3Ns27MTTgp0m3AKBLw/5R/bF6mlCHND1zKa/NA==
X-Received: by 2002:a17:907:60cb:b0:a86:8169:f3d6 with SMTP id a640c23a62f3a-a897fa6bb2fmr1161343566b.49.1725266493202;
        Mon, 02 Sep 2024 01:41:33 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d36sm535496866b.149.2024.09.02.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:41:32 -0700 (PDT)
Date: Mon, 2 Sep 2024 10:41:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZtV6OwlFRu4ZEuSG@tiehlicka>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>

On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
[...]
> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> in the case of bugs, because that's going to be an improvement w.r.t.
> system robustness, in exactly the same way we don't use BUG_ON() if it's
> something that we can't guarantee won't happen in the wild - we WARN()
> and try to handle the error as best we can.

We have discussed that in a different email thread. And I have to say
that I am not convinced that returning NULL makes a broken code much
better. Why? Because we can expect that broken NOFAIL users will not have a
error checking path. Even valid NOFAIL users will not have one because
they _know_ they do not have a different than retry for ever recovery
path. 

That means that an unexpected NULL return either means OOPS or a subtle
silent error - e.g. memory corruption. The former is a actually a saner
recovery model because the execution is stopped before more harm can be
done. I suspect most of those buggy users will simply OOPS but
systematically checking for latter is a lot of work and needs to be
constantly because code evolves...

I have tried to argue that if allocator cannot or refuse to satisfy
GFP_NOFAIL request because it is trying to use unsupported allocation
mode or size then we should terminate the allocation context. That would
make the API more predictable and therefore safer to use.

This is not what the allocator does today though. Atomic NOFAIL
allocations fail same as kvmalloc requests which are clearly overflows.
Especially the later could become a risk if they are reachable from the
userspace with controlable allocation size.

-- 
Michal Hocko
SUSE Labs

