Return-Path: <linux-kernel+bounces-370142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAD49A285D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E661F2293A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65C1DF26E;
	Thu, 17 Oct 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PR3eE2t6"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00C13B5B6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181846; cv=none; b=UjKcqxkwwiYF2UE27towia5Jx5w9gJthw4eucqX6Ocsgby32nidQ/tXozANvonNqmDnQ3yAS5jhGjfuPintPxKp4ys8WsjJfdL4VTI19KAbZxmdnYX7rwbZCncU1Y9xIAVikvcmch23VEIdd8JMRcTgVAVgR+SgmHzvpGk2fkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181846; c=relaxed/simple;
	bh=REpSbRLHRT+bYqXXqi34yOmCcGBN1SLrOxSF29WYjxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouce/Ee5su/sHlPxqAJFJJv9A3e+BMGxuN5I3yCYGhpiJBgJPtsq4/8lmHL1B8YaeAcwmetw0eykvIU9N79AFI9TtCpovQCYN5IzZ6PMcM0YYSv8iE7Zlt4leubA9E4i7DUidvt55QOrqNCBuQ56HJnn87FrvCBCihbVghvdiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PR3eE2t6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718062c1989so40512a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729181840; x=1729786640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JW21AChuGIHXm/a0oYaXopY0qylbrYU6FFGsXgb1P4=;
        b=PR3eE2t6IXV2MrJvQxNrF9rNWeIy3xX7vW8k05PbO806DDKzepz0koC7YzOCeDz/B6
         BeW7gBOPtrnLty5clWaWTW0hAtDNCiSJ/8N4uEMiMlHcpy1IISpk4XUO7KI9Vb3vk4oG
         QduM9PYdrInH3SHvj3oJwKOzKn5Of1ACw+QHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181840; x=1729786640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JW21AChuGIHXm/a0oYaXopY0qylbrYU6FFGsXgb1P4=;
        b=HbdUveSa/zN86sCByc7BDRoJIPtcnLWXmm9+pxOFlrFIgQ4b2+cKM40MY/6Oyxax7P
         RQELnKW1+3o0VooqoCuRHmULZ8DKHZd+sXx2ZYQ4d1MPrkOFxpnccj9s2LpI4CpMhsBX
         RTGTbiV5MgTaW/kYcfH+NaFV6gsJ5xsRX5a24L2dJbKxAlt3CtbsPb1zMPn6pRsOk7oZ
         WwU5zN3wytRYkzpwdx7essp3p1LkbD4n/JI9ebqkHaZ9sa6wq7uFBuUk8MnvGKGaRHeg
         RjUuyzvyzn19NeXK34+CrTp3hQ/gJ24QYvvswabbwgrVNnQ9j3LCawd0jTsW/aEY3iPp
         vu6w==
X-Forwarded-Encrypted: i=1; AJvYcCU+Wsi53dMZPpAxSYCmHgo5GZuLNESptT0KrD+XX2LDE63PRLD4jlGS7lAfXWxlBu6w9mdVVaThFgZghFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ggvAW5NswCvggVENnmFy6oM7oxusVYiHxPlmYsiXTShFUyYI
	C/ixiw/WIvLXMqlZ6c6BgOoFb3M9HUAx9T+WUtaB6XLS2uCA7pVMQOjPGIjpVhNtv2OyxOdF7Nw
	3lDL/zJIV1AkWp6fxcLYtTSBfxwnlC4oxIefo
X-Google-Smtp-Source: AGHT+IHkJFKWi2HwImyhXcWCHDzPIt0NtMmH7KPRIsgXi23zIJJa5MFWOze9uSBgvefBr1YXz4/XAw/TpbeM1TFd/00=
X-Received: by 2002:a05:6870:5591:b0:285:82b3:6313 with SMTP id
 586e51a60fabf-288f78c3509mr1471296fac.6.1729181840481; Thu, 17 Oct 2024
 09:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017022627.3112811-1-jeffxu@chromium.org> <2024101722-diligent-baritone-b211@gregkh>
In-Reply-To: <2024101722-diligent-baritone-b211@gregkh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 09:17:08 -0700
Message-ID: <CABi2SkXhHxW9kO2QeM81XCAvqFbQPfra9ApGDi9nuxPuJP5jYw@mail.gmail.com>
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, deraadt@openbsd.org, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Oct 17, 2024 at 02:26:27AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > It appears there is a regression on the latest mm,
> > when munmap sealed memory, it can cause unexpected VMA split.
> > E.g. repro use this test.
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - Your patch does not have a Signed-off-by: line.  Please read the
>   kernel file, Documentation/process/submitting-patches.rst and resend
>   it after adding that line.  Note, the line needs to be in the body of
>   the email, before the patch, not at the bottom of the patch or in the
>   email signature.
>
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what a proper
>   Subject: line should look like.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
Sorry, the title is wrong, it shouldn't start with PATCH, I was trying
to send a test case to help debug this issue.


> thanks,
>
> greg k-h's patch email bot

