Return-Path: <linux-kernel+bounces-421396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB419D8AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B5216995E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128C1B6CE3;
	Mon, 25 Nov 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFfOIJRq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B1D268
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553907; cv=none; b=I0wFY1uiZ7BN5f88Z4ue0MIWnkqH+vasCuzLRvE0kkUguzkQqPGeaHLnmAYiFe0F7XCO/6CX1ad0gcAVxZHO8e4zrH2gBTkNazgaQZjDWYMzgm3XjDHCgiJdmn7mmqI3LkVG6DvBjgmGeEL0IQ6NsfnUlDgy30gbOjTYUV6Vb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553907; c=relaxed/simple;
	bh=ZTPKLffCvQEZEK6o2yAQNX7IBGJkIc769lbWA7fTy2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGuggFRpUSJtbWpS+GwyVk74vSB0tKv8UUqW/NO92J/PasPnN1nS38Uh1SDjDIRzWHIxcMgDB1WWOuj7f+3jFBccSYf64ek2z2ilmTcSxb58QhN5MN7R62MTPxoA3RoOJWr2id+nNY1FsqEfUlH7eFskZNbqjhw8BcJbcN0ZR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFfOIJRq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732553904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSzBiL5u950eGM301lTYfnD6IlyYrIXFO0OgaXC9p8U=;
	b=gFfOIJRqgPHEB2HLYTS2wal1tbIMbbE90ykM2YBeKbPtd1nmlpwYAmcIbG0l0jRHv4Z9e5
	KST90qTJn3lqgLuqCaNeGwgDt3Upl1FoELGUfawfTf1qFjtYqazNRnL4hI3dF8EGDT3pg6
	ZpXs9AxuUjG5gF2K0ucZG3nfOPFS/O0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-YlxJWUOAO067TFhr1l3zzA-1; Mon, 25 Nov 2024 11:58:22 -0500
X-MC-Unique: YlxJWUOAO067TFhr1l3zzA-1
X-Mimecast-MFC-AGG-ID: YlxJWUOAO067TFhr1l3zzA
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84181aad98aso182542339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553902; x=1733158702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSzBiL5u950eGM301lTYfnD6IlyYrIXFO0OgaXC9p8U=;
        b=X4dov8FMd3uLoFbdHReYQVjQxOuEz8XLFQ9v+2Tj/C4rWrSaHylqGGaUBOgF2hXowO
         8BnU1EGr34LoadgnXHFKVMQS6IH18hlLkLczBVE39qfs/Eavs8vJqRM7G75mwe8jEos/
         2C6qXGzNLajgVRcmohrPZKnJw6rL1nBaS9SfR358iURl6YvY/+FTsHtx8+hs90Ak9/CE
         147mhpSHaNBlEnhHUqqJrdyC+aE8h66JliJl2JqPkzaSIgemAdUOJjWrn25RQzLk0JZ0
         tll9bOe1RDJWTaYGwdk9ZdmnpVqNo8KF99jpP9OrK4+JHM2Hodax5c+iCinFWorI7Xio
         4UIw==
X-Gm-Message-State: AOJu0YyfnKZttD0Hez6D4gF9stbSQM+Noy+RE9AsciPd5FrOG+Bn77Hi
	jFHWPBCKapYK86cTZCJkU8/LqKYHxEqijNTlys0aYGVHWtYzdvR4hJZ1NdjEq3XI+67f5ScIhXw
	+q/xTTVn1yKAAacSzYf2eEy8nPQJKhKn4/oSlaKhZ10UnNoVMxwoh5HRhsGAmPA==
X-Gm-Gg: ASbGncvuvfZQp1ogpIcQSmh4S1sPhcKbEai/iGTGjd8v4udHcYbXivUT5mbrZH1XGHE
	Wgt8hO14qpGKNsJ4a4EOOLazkGIfDN1WwJ2Diy30ad7BR5R20L8zc2OXsgDlF/MWcebMH6uJS8F
	olwr0TYR8IuGPWWYXgY6gVLda1uRLRov+hUFz3t0c4ZJQK9rwU8JhDo6pUXuSj8D6LFIh1V4bfZ
	Wbra/PIhNRAkSEZl6OdSl42rgjGE4UAY6Adtkrftg0Jw3QKxm7Div/Xn2+oc6lUZW5cL2on4Arv
	Tw8XWo6xWKw=
X-Received: by 2002:a05:6602:2c06:b0:83b:5221:2a87 with SMTP id ca18e2360f4ac-83ecdc32053mr1707083639f.3.1732553902233;
        Mon, 25 Nov 2024 08:58:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaG71TGELrKdnwNe8mQYHvvMOzWYYkH7rQnL1yylAURyOtN7iFiYwOhk+JkzObWCwvm/sN4A==
X-Received: by 2002:a05:6602:2c06:b0:83b:5221:2a87 with SMTP id ca18e2360f4ac-83ecdc32053mr1707081539f.3.1732553901943;
        Mon, 25 Nov 2024 08:58:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8419314d3c5sm67497839f.7.2024.11.25.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:58:21 -0800 (PST)
Date: Mon, 25 Nov 2024 11:58:19 -0500
From: Peter Xu <peterx@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Message-ID: <Z0Ssq15MQd3rimBr@x1n>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n>
 <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>

On Mon, Nov 25, 2024 at 07:15:10PM +0300, stsp wrote:
> 25.11.2024 18:59, Peter Xu пишет:
> > I agree it's slightly confusing but it's intended.  It's like that since
> > the start, so I think we should still keep the behavior.
> > 
> > The userapp needs to create one extra userfaultfd to detect supported
> > features in the kernel.  To use it after a probe request, you'll need to
> > close() the fd, redo the userfaultfd syscall to create another fd.
> Hi Peter, thanks for info.
> Unfortunately man page doesn't
> say that. In fact if it did, I won't be
> using the second userfaultfd just
> for that, anyway. :)

But AFAIU that's the only way to probe kernel userfaultfd features.. so if
we need a probe we need to have two fds.

> 
> Man page clearly talks about
> "the userfaultfd object" (one object)
> when mandating the "two-step handshake".
> I spent hours of head-scratching
> before went looking into the sources,
> and even then I was confident the man
> page is right: people should always assume
> documentation is correct, code is buggy.

Hmm yes.  I didn't pay much attention initially, but then after I read the
latest man-pages/, especially "UFFDIO_API(2const)" I found it looks indeed
wrong in the doc.

In this case we can't change the code because we need to keep it working
like before to not break ABI.  We may still update the doc.

IIUC the two-step was mentioned since this patch:

https://lore.kernel.org/lkml/20230919190206.388896-6-axelrasmussen@google.com/#t

So I also copied Axel and Mike, just to make sure I didn't miss something.

> 
> Would it be possible to re-document
> this part? As all test-cases in kernel
> do not use 2-steps - how about just
> removing that part from man page?
> Suggesting another fd would be strange. :)

I would actually suggest mention another fd is needed for probing features.
But you can wait for some comment from either Axel or Mike to double check
that should be either removed or proposed.

For man-pages contribution in case you're interested, see:

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUTING

Thanks,

-- 
Peter Xu


