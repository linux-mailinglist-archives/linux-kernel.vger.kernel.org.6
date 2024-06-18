Return-Path: <linux-kernel+bounces-219585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE9D90D4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70FC290C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005CE1581F4;
	Tue, 18 Jun 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Yh4U1CQx"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F913AD1D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719565; cv=none; b=SP1/vpqPEwsN/rPb6WNCLAdnfNufHWwG1t9BLtcZtmM+2s3qumJEcGUs+qYaK+30wy5feLxfE0BfEe1Ttw5/7XjoEZQLGF6S31e8tFb2zkP3bDpBnOzmfAAq2QEYx3AOQc5IepkENrUcIxnUzIDsxra4LXTYqWqNgbUKfsbfX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719565; c=relaxed/simple;
	bh=04/tbEPWIlzSSeHU9wlvxwNF+LmoJL2+5nJuBYusf84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTFLLT4+yInkXmYKhoTTVORTK27SxHj316/oqefD7vhP/XM9fbcL74XSrbux/J1u2nNttGfvAHip0AkhVrH/YKX1SOxMNU5Fay+oLgTY1mHYQKn7xuRe7DZxu8CMpUTIYxF46zitRvNjtg5aYxy0+u9YthurAd4FxsEwqohLJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Yh4U1CQx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f06861ae6so4764833f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718719560; x=1719324360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04/tbEPWIlzSSeHU9wlvxwNF+LmoJL2+5nJuBYusf84=;
        b=Yh4U1CQx0Lgye9unT0e9Ud406zDkIjSjOopSEG76qMtAGf79pJA7+FE6orwSB+cBSA
         V0qMbMVVGfL+UUpZ1ah35gF+0hkGTxV0kjnS6zR7y3sstPBOQfwq2MZclsfVuO96vpc4
         0JOJLTa6eLKEoJMLcD4qokl6/y/mVrUBYtUDtNtxRywPMGl3u43fvMd9BwKHdSQMKdxc
         ehEfWOSz9VuZSV1MJVvKxQLm4gFaEXx1yKBL39i9zFAoN163dE4Hpir9aExcxHnbFxOu
         rsYs7Xe0Q4lx9hApNHk9O1xZJSm4maujl49Xfl+Icw04kgQH3rfNhtCzmS4uV8v9RJa9
         lI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719560; x=1719324360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04/tbEPWIlzSSeHU9wlvxwNF+LmoJL2+5nJuBYusf84=;
        b=HmJ/xuMVu/L9+LnAMr3lPp6mqab6j4BQsIVdzuSz3NYTz6txkRu0cfpFt/N58Dkk9A
         +WgUp/xUy9WehXnHmMbWl89v1MoW+JrOhr8UWImJNR7yJAnDqcn+m0RVDwvtxblfg/Cp
         rfn9w54qVQZ6HTCSonpdd2hAGixhNr/5mqcIqNQ9AlWcV6+B82ZaAs1LeKU2VXUjQtZe
         hjwNQKF4kdhK9gFNwCG9tQ3FDAGHbr45oPwj3tjD9j+/R11eojyPGzmLE2uWtjPGzppx
         bCmAecIX+F38UvfQbvW6egbLKzzzB0wFKQPfnU7x8wquuMp8a9EFtTapbCdfqq3LJqrN
         qy+A==
X-Forwarded-Encrypted: i=1; AJvYcCUVDufBYZ0xeqKX+YKQN5S50NiLyeRByMlqBl8nXx6l+WuFsb2r1UefQNQj8imGJocJil3f8zcmJLH/O5hEKSG7htX+ZkIGvMYYHAQW
X-Gm-Message-State: AOJu0Yw9B83mIATBoJXSTTwV1Ka7pOo+/V5agSAvdA97u1nN3rhRb8pF
	rMbOSl+NE0EUgOjslSaS7a2tcJChunvWUwCy50ympwe/xVvx3XrBRb6Ok4VmFIkGxsb0QVPXFBj
	oT7s=
X-Google-Smtp-Source: AGHT+IE7bMWr/KjUbc0niKCiWMXu0LbpQKaj1GXm+QhhAO3g7QpNVncrgW1KSZOUIgxRobwzYgfe7A==
X-Received: by 2002:a5d:424d:0:b0:361:81b9:bfe3 with SMTP id ffacd0b85a97d-36181b9c0dbmr1185057f8f.24.1718719560595;
        Tue, 18 Jun 2024 07:06:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c79bsm14361744f8f.41.2024.06.18.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:06:00 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:05:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: core: Remove the dup_errno parameter in
 dev_prep_valid_name()
Message-ID: <ZnGURZgU5sRkTvPm@nanopsycho.orion>
References: <20240618131743.2690-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618131743.2690-1-yajun.deng@linux.dev>

Tue, Jun 18, 2024 at 03:17:43PM CEST, yajun.deng@linux.dev wrote:
>netdev_name_in_use() return -EEXIST makes more sense if it's not NULL.
>But dev_alloc_name() should keep the -ENFILE errno.
>
>Remove the dup_errno parameter in dev_prep_valid_name() and add a
>conditional operator to dev_alloc_name(), replace -EEXIST with
>-ENFILE.
>
>Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Why not.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

