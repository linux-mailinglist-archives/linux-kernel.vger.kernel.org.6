Return-Path: <linux-kernel+bounces-194485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E08D3CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF73280339
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F0194C96;
	Wed, 29 May 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T1FiufcM"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50F194C76
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000710; cv=none; b=pGI7ebrsmt9SzhnYo59aFoDP8h9pkSp24AJ2kEQ4cbNKgzoZmQ58vA9P0zHeuQKjXtxq29Gv/A3Y/HJjnX3pg0DoS510ujD6dAid6sfQAeMLaJAyEtJtmF/ZE+wfsRQzddv8KQKvXyrFamscf6W8qJiWhTBgdXnuIzvqhSnsNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000710; c=relaxed/simple;
	bh=n62JW954QEMEN8kU8631qHanrwdqcccUF5S3VBPtOqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tq6ugkVea+1aEe8LA0bLrZBB/Kx73jlpAO4OMjjRn3vp4wLf3ALysEZHwfOYJJw6quVPmfXzMQ+bRgjgMJ22nRX+zfLSjxoXvBsxdrQJObnZAZD3qlcxCn92xY/zFim6WQAvWoyIao9fbewA/SCM0XFpWtYQN84sUXCEQfuOfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T1FiufcM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso1400659e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717000706; x=1717605506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RCN7EOEnVC70hLcRtdygQ9XQdGWocXnG58vuARKxgkQ=;
        b=T1FiufcMMm4zpzSdzPwEE3GVl58aEIJGOyc/n+g4gJh/Y7vTNkFGo+Nf9d8aa1pTY+
         COs3EkuwdTbVq7lkBgTvPOXA4KZL2EXre4QblrvUCCdPC7vUh0uHLrq7ifBLh/++betb
         SpoIZf7vhuC+CgWEL/hyV7W4m+02U7sCVBD0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717000706; x=1717605506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCN7EOEnVC70hLcRtdygQ9XQdGWocXnG58vuARKxgkQ=;
        b=V1TSFc2TdzdGNvSElrqGf86KatKIvMz9w6D41Bk2v62U5iTZHhaWGPPMKd0O5zfuxz
         Ub1raBqDdnv5Ij/TDVo6KvxK0VFsZi0Skbx0O7I2gsVCx+d/jmqxt1N7sqXpFWCUYVwi
         Vdj1MdwH6goz4RJj7ZdMLryc8xCOqC+TddaUKUECwQt0YCOqfU8Fvhyqa0BG2v7x1FUT
         5qFPRvc1J2qf/NoE0gpdbtv+17dFRwOIcUnM02j8mhyXzGOA5vUcHZWblghO2qhrHwjn
         ceGlJyGQJUcvnQMfklJOgWfDUdxu9h1zmY5JP4GuDSOPvIKSZ+4MlwQ4WluaekoJ8tgv
         FYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVarfCfi+9uZ9PfXff60WQ3UXp6eI1P11W0i4JcIu3ZhXYjceN548B2x0RQULWcFVeWQSAf4O68aa0Kya5B2UHdmZ+hW5VdY39E6aHE
X-Gm-Message-State: AOJu0YySu7xs6KYt5t3JTRScNiFOCjtpHyivBeoEoPxWsNayDWcfZ7pt
	vsgYd+C62KenbIew2SJPM1NZ/Z2/Pg/TEekPnZKRyOziuEiYsJqJvTi4EPu0q89vJGIBAjwj1Y7
	bgXEcnQ==
X-Google-Smtp-Source: AGHT+IGUhMUb8vrMvAq2ztWWZMiSwlLY0ztGVMLo3q6ngs+gIr6DzFkzi0CfOrg0CroSZEmrrnE0LQ==
X-Received: by 2002:a19:760f:0:b0:520:36ea:9375 with SMTP id 2adb3069b0e04-5296736ba45mr11540092e87.43.1717000706253;
        Wed, 29 May 2024 09:38:26 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529b6de681bsm782046e87.39.2024.05.29.09.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 09:38:25 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso1400611e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:38:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrSgZPAHTMdNTkTbGFPB84AuWttZJaBdFtpEfeOVkYS6zIN6R/VjBp+fJ/hJqTRpwC8kDd07WEDPpLJ7Q8Byr9bjzgAFfj2x/qC8Yy
X-Received: by 2002:ac2:454e:0:b0:521:92f6:3d34 with SMTP id
 2adb3069b0e04-5296594cf46mr11225856e87.22.1717000705215; Wed, 29 May 2024
 09:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405291318.4dfbb352-oliver.sang@intel.com>
In-Reply-To: <202405291318.4dfbb352-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 May 2024 09:38:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg29dKaLVo7UQ-0CWhja-XdbDmUOuN7RrY9-X-0i-wZdA@mail.gmail.com>
Message-ID: <CAHk-=wg29dKaLVo7UQ-0CWhja-XdbDmUOuN7RrY9-X-0i-wZdA@mail.gmail.com>
Subject: Re: [linus:master] [vfs] 681ce86235: filebench.sum_operations/s -7.4% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 22:52, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a -7.4% regression of filebench.sum_operations/s on:
>
> commit: 681ce8623567 ("vfs: Delete the associated dentry when deleting a file")

Well, there we are. I guess I'm reverting this, and we're back to the
drawing board for some of the other alternatives to fixing Yafang's
issue.

Al, did you decide on what approach you'd prefer?

                     Linus

