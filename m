Return-Path: <linux-kernel+bounces-317572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C289596E088
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A61C1F26563
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E01A08A4;
	Thu,  5 Sep 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdEcEXAA"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB31A0722
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555403; cv=none; b=FIOm2ILd58V2eGLx8QOVoMzoHyRjXUNpiURqOYDM2Mz2wROt68FNXGqM18C0POloRSQuwy8jF/L78O2fWuhrZMG2odv7yvSQN1lSEkZ/gHkgnqwDC8xSxWJhgHbOKkCxYRbsJyD5h8j9wmy6PMmpUNWHZ8uZ+/qXhZwuRCTKpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555403; c=relaxed/simple;
	bh=uHqjy36mJjB7Y8neUhjFWgQCh0SpDtSG4PiN3ASD/xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRs6PJrUi7FTuGm2SE4BH69jXLkdTmO6Qfpx68PVhlnayroYS9KdiwvL7dRRFMnvHec6Ny3CViB8UPrgwcUrl8qTnXZIT8b2aSptFXMAcibDk3JMtLaF94138SNZ9sXgl0ojkxbv33XgzPBhetfvKnQPBf9zRFfbfvxDbqAj6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GdEcEXAA; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1a8e305da0so1154940276.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725555401; x=1726160201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uHqjy36mJjB7Y8neUhjFWgQCh0SpDtSG4PiN3ASD/xI=;
        b=GdEcEXAAOyBCOCqUKERNIvQKW0wtu/qnou6xttaUgYSIHMaHuKkZvjEAVOm04KQf14
         hOXvGIwWkHcsLr4230mCgGRqM0G+h8lflFJbGijmeXzKBPb82g66VtSOytaizr9x4E3D
         38Pcr/xvoFlkF8KzrbxLEzppt0HHTioKRnaDs5Ge5boV+zegi8NRf+vgQfvKuuDzP0kv
         Dk4+YawDz+x8buPJ3Vc2ZkPsEH//4gpGJU5U/OZ+lc3OrKJDIKyrPcNSsiBCMPRrV4Qp
         ROfI4MAqa/CuX5jbKgLMKUo5Qw3Wzwy+JyXuB1rDm8/zvo5cfgSv5IKWq1qodMBo4efM
         Dmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555401; x=1726160201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHqjy36mJjB7Y8neUhjFWgQCh0SpDtSG4PiN3ASD/xI=;
        b=uCFci055Odsp8FRwNGpMVbk9bM49LenQWvIi/ABMhG6SxoAFpZeEuFwkjQ18Q0C9j2
         wuETXhNHCYRSzr8m6IQcIX6/Z4aOtMDT0kU/J2WPHXW1m72NSyDMf5Q0dAjQzRFU8eQ4
         bm59oBmUHZsBhjJG6hkB7QjqoeuGEkPUJv0EpwQ/Ox+VSV47JrwHCPaHvGwfhajZ7/Sx
         +4InFonw9tjnv+QFbfCeurg6PtWoteOROda0zXWtVt4JawqmhUhjeYo53z6Q+EAFc0ui
         m+8psz8r2nGPAxZ8MXxY9y08Zq8nuHpDVizxU7Bxg/wHDs8RcgoUqY/abrluMy30hQua
         N1VA==
X-Forwarded-Encrypted: i=1; AJvYcCWa94VEoskt+xt5D3ctkRfxIDJyPAJ2xNQUwL/tv7Zt5LDpn4oHRWDqcesCT3cfBa1kPfuqVUcBJ5LfBok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bOOSkLI9r+6s2a5lgJUyy8C56YVtaC0bDtZvwoEdNw/55WII
	DhsgQ2lcpjvYfE2Kp8NETQqpt67MO2jKyQNVQVFGs3Y4Oq8441El7HMvG0cWY1NoQIPNMC+ycUn
	vWfWo5iQcbEN+F6D0nqUbiMyg001+L9QxN/tHzpYaoO7+rNWO
X-Google-Smtp-Source: AGHT+IHPSPP0a6x2pBeZdQ7cFMRpN5ue1U3qASJhoc2najQme0uesewUZpAlVDhvGq+pLja9rBnS0H5rCqWhKwKBoO4=
X-Received: by 2002:a05:6902:708:b0:e1a:5870:6380 with SMTP id
 3f1490d57ef6-e1a79fd8be7mr26837229276.17.1725555401330; Thu, 05 Sep 2024
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905164344.186880-1-ulf.hansson@linaro.org> <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk>
In-Reply-To: <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 18:56:04 +0200
Message-ID: <CAPDyKFrgzuuDBMWjBDVFAzwTP30JeD+zP2mVo+E=P0MZwUepHA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, Paolo Valente <paolo.valente@unimore.it>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 18:49, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/5/24 10:43 AM, Ulf Hansson wrote:
> > To not give up entirely on maintenance of BFQ, add myself and Linus Walleij
> > as maintainers for BFQ. Although, as both of us has limited bandwidth for
> > this, let's reflect that by changing the state to Odd Fixes. If there are
> > anybody else that would be interested to help with maintenance of BFQ,
> > please let us know.
>
> We don't add maintainers that haven't actually worked on the code. As it
> so happens, we already have a good candidate for this, who knows the
> block layer code and does many fixes there, Yu Kuai. And they recently
> sent in real fixes too. So that's likely the way the needle will swing.

I would certainly appreciate it if Yu Kuai could step in and help,
that's why I cced him too.

Although, me and Linus were thinking that helping with "Odd Fixes" is
better than nothing. Ohh, well, let's see what Yu Kuai thinks, then.

Kind regards
Uffe

