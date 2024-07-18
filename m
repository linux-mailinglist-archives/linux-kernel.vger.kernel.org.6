Return-Path: <linux-kernel+bounces-256803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B6E93708D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706A1B22342
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53178146584;
	Thu, 18 Jul 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HdHrzVwA"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544D135A79
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340388; cv=none; b=Fhux/CsEep7WI6F6xhtT8XfzyYfVBTqECOExLRcPyUuSGq81rmUZj1nwpH425LXora1GIZIbpBboXZmDPVcCiMAcJCtksSMKphfRB6OQAZL7tMxXnygELMXukxIkNmWXwkiDqtndbt/OCgpqRJ3cm466KLc0fJPb8soe7ja1ivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340388; c=relaxed/simple;
	bh=acccNmbkTNt4D6rXrxsctZAkrYQrsQo0yHnBb7YJ3+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzWEd8iAXEFb8VVzoNNcmuXDWglgBSjdgPnAeUmN0kYNLy6Xnpy0c9N6V84y4OqAKCyE/tINedMit+dOE3rZIT9P595Q0ufKLywDTTAJ9i2YsgEgGYZpUVQ0KNBLwZuXKS7LU/3b8DrA0o+i0/qo05SKn24GMID/C49VuO8kcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HdHrzVwA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34722so78668a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721340385; x=1721945185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WnQ/kRx27gXXnNgCG0Fp9DDc+PIy4XrGs0yssbc7gKs=;
        b=HdHrzVwAy17E6TwqlxmVqSsYhNZh9yw7O+lgvxFxD4E1JZ/tIU5s0eWbbJqCcB1Zln
         9kEbvUu8FnHepPNrILjqneljkEAAMq0pooT99SoQnTNebl10kfJTunbsdcg8SLVzezLC
         XLlA8KNi03qoVRif/APjW9LRmKq1X5SVkG7/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721340385; x=1721945185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnQ/kRx27gXXnNgCG0Fp9DDc+PIy4XrGs0yssbc7gKs=;
        b=I/TI8a9+FaP8IkU+Dx32Moug1q/HIvDuYnKKrxnFh/dqm3Mkka5vp/DgSib//cEwHH
         bUl4v0AxdZpYF3jhojw4x5HXbdHj7ZolB2K3y7UYL3OaOB1ZDcjg8ozOYZIh2CJUlGie
         gS3VoqKz0F6e/BqGg2p5ySv9Ahj8xWziEkvTMl+Gbu2JznwYKvXA4BQ/jH67Z/CDPTO7
         Gy46FO85zK52jdUDHaX5PCtQUQkbjnIKbXzB2YMKXl1Ug4LidCxKKUSbx0+bZvn2RRyg
         3oaggZ2nFmfjqFFEDAzhEgQ+qxz59BnifTSbR1McgpPbhgl23SivAnYls+h0EtvpPWhP
         ph0g==
X-Forwarded-Encrypted: i=1; AJvYcCX5fkpxZL6XpO1WegFAKbmF2aAPHsEGlxr1CqNtSWYOgSQTJNBPz4LD4mbc1UbMxXvpfSDqpgjAzHs8K4FBiTPHrs5EFcodm8nAFf9u
X-Gm-Message-State: AOJu0YwFxrEECMxukNzHLUzlZBRg84qOXZ4JrTYK0oy6p5+uE+KzGNXn
	nh1HRxlQqF00YCWvwtwMi+f7L0eY/jpecUNol/y1kjWN48V3YZW1TXirnOmE5ZMvneg0XCHqP79
	qE0YetA==
X-Google-Smtp-Source: AGHT+IGHvolDR1d6uPVCfpognN28BwrJy2p+lIn9buioCxjg2WFosPUgI6cFInSj+3VeAK11EUqegg==
X-Received: by 2002:a50:cd53:0:b0:58a:f14f:4d6d with SMTP id 4fb4d7f45d1cf-5a2ccd8688emr516511a12.19.1721340384978;
        Thu, 18 Jul 2024 15:06:24 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d75acsm8654a12.11.2024.07.18.15.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 15:06:24 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34722so78642a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:06:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdTHaxKU8/ZFRcCwB/aa45SYvsZl7AbEPDh7gLCqs808cihndS5wI3Dc/VH0E9dnB4MCEesmWsHxnsqYbTQy6NBPFcM2rBr6EZmdIH
X-Received: by 2002:a50:d481:0:b0:594:4d7e:1b6b with SMTP id
 4fb4d7f45d1cf-5a2caf4eebamr568069a12.5.1721340384115; Thu, 18 Jul 2024
 15:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com> <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
In-Reply-To: <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 15:06:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com>
Message-ID: <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.11
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 14:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> But my master branch (previously the same as for-next) will now be
> for-next merged with the latest tag from your tree, and I may do
> similarly for bcachefs-for-upstream if it's needed.

No. No back-merges. We actually have documentation about this, so I
won't repeat the hundreds of emails I've sent out:

  Documentation/maintainer/rebasing-and-merging.rst

But the gist of it (well, one of them) is that you should keep your
branch *YOUR* branch, not think that you should merge in other peoples
work into it (or rebase it on top of random work by other developers).

There are valid reasons to rebase, but they are balanced against some
VERY valid reasons not to do it, so if you have to rebase, make sure
those reasons really outweigh the reasons not to.

And don't do it just before a pull request - and if there is some
catastrophic event that caused a recent rebase, let me know in the
pull request.

> As a bonus, this means the testing automation will now be automatically
> testing my branch + your latest

No. That's what linux-next is about - it does integration testing.

Your development branch IS NOT FOR TESTING OTHER RANDOM THINGS.

You are actively making things worse if you do: you should worry about
YOUR code, not about all the random other things going on.

Now, if you want to do _additional_ testing along the lines of "what
happens with my branch and Linus' latest" then that is ok - but that
should be something you see as completely separate from testing your
own work.

IOW, you can certainly wear "multiple hats" - your bcachefs developer
hat that worries about your bcachefs branch, and if you want to *also*
do some integration testing, go right ahead and have another
"integration testing branch" that you then test separately.

But I don't want your integration path. When I get a bcachefs pull, I
want the *bcachefs* side to be solid and tested. Not something else.

So by all means keep multiple branches for different reasons. If you
think you have users that need to test some integration branch (which
honestly sounds like a horrible idea, but you do you), make them a
branch too if you really want to. But again, that has NOTHING to do
with bcachefs development, and you should not mix that up with what
you send me.

                  Linus

