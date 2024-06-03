Return-Path: <linux-kernel+bounces-199753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28948FA55A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CFB281A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890B13C832;
	Mon,  3 Jun 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gfxucmz3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADAA84FB7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452382; cv=none; b=T56cQ+iD+aXIJqVSOynkf1bVDmuDppy0sLBfZyGVeZUU5Zdk4e/8ZFF/LQ9JwNijR6dxl0SBOJeyO/P/5XUdut69OoEciOpe4gPUcLdQUsHtKRvB2StI4e3lPjXgeBfL5Pz5Jvpee96Al3YCicylhBisqfoTjmz4ICQAC3xgZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452382; c=relaxed/simple;
	bh=w/5x4WMYBQSub464dP7QnggplP3WH1UzvXVybHVdiTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wrglxtdy3e2ybTX8Vz0xRJhKgh+dqLZ3k5WuPdh+vXgcS3FNl0Uat0tkU/Lv+cqnSYZe4FMxJDwqpCkYQGExf0xCqHDIcybTsHAkky11JG1aeG5gTZ1KdsQ7SmcCDkI24PGi/Il11i4nZl8zikWFhLR5O3EsjWymf2MGRd83m+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gfxucmz3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b82d57963so4983786e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717452378; x=1718057178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=88HkfhteX1tORBOVLSUiwb3Ab8uk/Fd1+xWCSdTOy34=;
        b=Gfxucmz3bBgRpC4u5GZRpS7RxOJhVF5u44HUdJnBEeqEO8oPsoVYcxFwjaolWJF6/M
         WX5DFr5ZTg+rRso6FQAtlu6V10l2h4KTNPzHjCQTFgFemAj80KGN7XS4jBAjhY91+K74
         kVZxmHYD6fSPfvfrPVl/OOaH3KQAPgCgrcUto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717452378; x=1718057178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88HkfhteX1tORBOVLSUiwb3Ab8uk/Fd1+xWCSdTOy34=;
        b=XrcyKlKZylpbUQg+l/gKgiWlKmFsBQwJDUg9IBH9HM+yLaeyBzrLjYIzgglycvmINr
         l/g5NmmS/S+11brkXV/5I5vK/S3F8AfVfeerkwNVXnDWf66JfUmR+4Gcoo4eO4r+M0Gv
         bJkyn5RqOpvBjwQJp1epHdNNbtWceSd/XsYNdPFCSXW6lRw5Kn8rXCcyx6xmx6iZjdva
         srqfqEN/JOM90/U83TcGmhPjZkfcQ1rqh2gPlFI8LXvHRtueFwyewnBjtK+asctZIeMt
         PwkemmNPP2XMjXn1D/O+MLlbINDgyAN/Zvgma1+3+310dY7V3nB05p/G7lqwdSv7/d6b
         JRhA==
X-Gm-Message-State: AOJu0YwndSOqb7UVqOSq/2ik04vrGEdkRX4Gq1FRQ4h9lXDkZgQu9lW/
	tog0b/k0q7LodeXy33+DR7t80SH55rDfY/5JmGVk9WiNgU3bZijlyWZy0H7m8oSz0sKEtfIKS4d
	vbH4=
X-Google-Smtp-Source: AGHT+IFLFV8Yy/LZ31RiNRdHqWlD/BpzJt05boQGKFBf343sn0xnipfzPctl6lHvXIrpHA/N6W257Q==
X-Received: by 2002:ac2:5ecc:0:b0:52b:85bd:8de8 with SMTP id 2adb3069b0e04-52b89596691mr5865547e87.21.1717452377949;
        Mon, 03 Jun 2024 15:06:17 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9dce515esm260008e87.48.2024.06.03.15.06.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:06:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b83225088so4580716e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:06:17 -0700 (PDT)
X-Received: by 2002:ac2:4e04:0:b0:52b:9e2b:9e1 with SMTP id
 2adb3069b0e04-52b9e2b0a7fmr2203863e87.23.1717452376905; Mon, 03 Jun 2024
 15:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603211538.289765-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240603211538.289765-1-andriy.shevchenko@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:06:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5F99-GZPETsasJd0JB0JGcdmmPeHRxCtT4_i83h8avg@mail.gmail.com>
Message-ID: <CAHk-=wg5F99-GZPETsasJd0JB0JGcdmmPeHRxCtT4_i83h8avg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] treewide: Align match_string() with sysfs_match_string()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 14:16, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Make two APIs look similar. Hence convert match_string() to be
> a 2-argument macro. In order to avoid unneeded churn, convert
> all users as well. There is no functional change intended.

No.

First off, please don't cc hundreds of people. It's just annoying.
That's what mailing lists are for. And no, that doesn't mean "add
every mailing list". If you can't find a specific one, use lkml.

Secondly, we're not going to encourage people to use some double
underscore version of a function just because they don't have an
explicitly sized array. The existing users of "match_string()" are
fine, and changing them to use a new - and *bad* - name for the same
thing is crazy.

IOW, if we have two names for these things, where one is for a "fixed
array with a fixed size", then it's the *new* use that needs to have a
new name that actually describes that. Not the old use that gets
renamed to use a worse name.

Thirdly, for something like this, "no functional change intended" is
not sufficient. It needs to show that it really is the same, because
I'm not willing to take some patch that touches 50+ files for some
syntactic cleanup with the _intention_ of not changing anything.

In other words, what would fix all these issues - apart from the crazy
cc list - is to use a coccinelle to make a provably identical
transformation, ie thave

   #define match_string_array(a,b) match_string(a ARRAY_SIZE(a), b)

and have the coccinelle scrtipt that does the obvious identity
transformation from

    match_string(xyzzy, ARRAY_SIZE(xyzzy), name);

into

    match_string_array(xyzzy, name);

and not make other places uglier and worse.

And then you can separately take the ones that you have to *think*
about and that aren't locally obvious, and fix them individually, ie

-       ret = match_string(vmpressure_str_levels, VMPRESSURE_NUM_LEVELS, token);
+       ret = match_string_array(vmpressure_str_levels, token);

but where it's important to somehow verify that yes,
VMPRESSURE_NUM_LEVELS is indeed ARRAY_SIZE(vmpressure_str_levels).

Because your patch also has

-               idx = match_string(hash_algo_name, HASH_ALGO__LAST, token);
+               idx = __match_string(hash_algo_name, HASH_ALGO__LAST, token);

and I have *NO* idea why you did that completely garbage
transformation. Because we have

   const char *const hash_algo_name[HASH_ALGO__LAST] = {

so as far as I can see, that one should have used the "automatic array
size" model too.

And these kinds of examples are *exactly* why I refuse to apply this
patch. The patch not only makes several places uglier, it *also* is
incomprehensible in which ones it converts and why.

So a big NAK on this, and it very much needs to be done differently.

             Linus

