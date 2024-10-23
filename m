Return-Path: <linux-kernel+bounces-378645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD459AD39B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A581F22D21
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B01D12E6;
	Wed, 23 Oct 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ArnVz3PI"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A161CF5E6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706842; cv=none; b=bfR8ORM1hgQes2Ppj1IzN91Xe3jSMt+d+nLSxYbd47p0uZL1tkZQ2rihvjd5d9YpCRer9eG/BZiJh6kubJYNsdlYjLtsaODuQ1Ef08Bum/005NoLdvJCLOpyPTFZOu5rg0UzsDyRdGGatgqjZjvRXfhnCXRkBephM3vKaIUi94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706842; c=relaxed/simple;
	bh=yj+9Mu5hdOk0PtgoeqGGPhrFchv8MxFwKehOOUmXTao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP1Psm2HD+e3oAP10g6mbYNVGOHVIEnApvELql5U69tyE5iqoZ797Q1CyGLBsmftqsraVxkhN9sBlNeYCJIN8Qh9eB02m25fG0o+fOmy4rUCcdZP3wpg/BvPUX/UxUW5xlD4I3fnwqDr5rCslFUYc5IGH4buwAztOyZA83oOmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ArnVz3PI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso142832a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729706838; x=1730311638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tN6K2TMFy+8W8ZGYWdpnPeKr5nzAwF7VuobwTRTKhDs=;
        b=ArnVz3PIY6zMPm34hwDeY+LJ9z3qqqGaYJAIBg21mHzznblkf12ncxKLEz4FwALaKe
         e6IDtme0Rf00qpDIQ6dRpqEeF4cr7bfWVrjsuGzaSi/fldZkoAsOgPcHgSF6zPShiNfs
         5YghKcfn58rwrpgNxleiCAgz/cI/FI27MoGN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706838; x=1730311638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN6K2TMFy+8W8ZGYWdpnPeKr5nzAwF7VuobwTRTKhDs=;
        b=bt4APxn22nY1PPnEPHCkrE8YDhW9a5SyzwdMRCC3ctyJgnudYjFRh/ISv/KzlBZVJi
         893pqPDynTSid6+tooK/6gB6CrY9dE9vNJHdwaEGT0/mXFt1Q73VY2YF+cN1rocaHoYj
         M6lXoAMZ1KtPwu3v1nFOv4aqoLvOgCS/RRWfmVHrfCSXit2S3qYv6qbJfAz8HMbg3V8V
         8Mur2MYONOrMiOG9hCp+y3OYx37G/9/d5q7fgfRyyNbnybLi3w9jc/HQ6XWpwJ8sG6dd
         7jP2HTVyeeRkZ3C/q+sdPuvBOI0GclG+kJLeZ2Zpy6BCVoLmnyNYS7x832T0jAG3m5zk
         Hfmg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/uyeSZI2kOFOPSpb5jC5ZZOfy4gA/EQKWlOT5bY1XBGxwTSDh3zfOevxfBvwmwA+IVwYNDyQElmjTeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0KnUly2kmfa/wANfqhjz9i8QAl2RvzX98wi8g5L9jXZ49enk
	qvLXp22bhiMuBTCO7yfEOBuIbvlja1BX3bLluwrrggN4eQmVxszAWLUihQXks0LmqnuVESDgYtv
	2wxAt+A==
X-Google-Smtp-Source: AGHT+IEqoe2iZl+Jlxq8BF/9H669swNb4FC+cpwq0AU3XHm0OzUdYbSbS9j9vu7DUk1Wq4bVJsQglg==
X-Received: by 2002:a05:6402:268f:b0:5cb:6ca1:9de3 with SMTP id 4fb4d7f45d1cf-5cb794a9da5mr7768759a12.18.1729706837864;
        Wed, 23 Oct 2024 11:07:17 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c726besm4707012a12.93.2024.10.23.11.07.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 11:07:17 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9acafdb745so26098166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:07:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgT8I31LNfNkFZbYx4O1+yMk4QP0WSZ8TzM3y8mcBKS/sxIbghtMVQpszyTudx3PWBTvOC2nF2lixI4co=@vger.kernel.org
X-Received: by 2002:a17:907:6ea9:b0:a99:ff33:9ba5 with SMTP id
 a640c23a62f3a-a9aaa6218f7mr835695866b.24.1729706836809; Wed, 23 Oct 2024
 11:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org> <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
In-Reply-To: <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 11:06:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>
Message-ID: <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: paulmck@kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 10:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > Yes, without Linus caring we're not going to get our process worked out.
> > Not sure how a tree that probably won't have much better latency than
> > linux-next is going to fix that, though.
>
> If I recall correctly, one thing Linus asked us to do earlier this year
> (ARM Summit) is to CC him on -next failures.

Yes. I definitely care about failures in linux-next, but I often don't
_know_ about them unless I'm told.

The linux-next automation sends notifications to the owners of the
trees, but not to me.

And that is as it should be - I don't want to be spammed by everything
that is found in linux-next.

So failures should normally be fixed by the owners of the trees when
they get detected, and those trees should not even make it as pull
requests until the problem has been resolved.

After all, that's kind of the point of linux-next - finding problems
*before* they become pull requests.

But that does mean that if some failure has been detected in
linux-next, and the maintainer has *not* corrected it, I don't even
know about it. And most maintainers are very good about this, and
point to things like the resolution reports (which are not actual
problems, just heads-up).

So automation that says "this tree does not actually work" would very
much be appreciated. I'd prefer them to be the same kind of "before
the pull request has even been sent" situation, of course, but if
problems _remain_ in linux-next, and pr-bot sees the pull request, I'd
actually like automation that says "Oh, this tree has these issues:
..."

IOW, I very much do care. linux-next has improved our build test
coverage and is a big deal. The more "problem coverage" it has, even
outside of just build issues, the better.

And yes, I know some people do functional testing on linux-next
already. The message at the maintainer summit was a bit mixed with
some people saying linux-next tends to work even for that, others
saying it's often too broken to be useful.

              Linus

