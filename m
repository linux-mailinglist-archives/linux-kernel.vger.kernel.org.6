Return-Path: <linux-kernel+bounces-576153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80734A70BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC7C3B53C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D41F03F1;
	Tue, 25 Mar 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vvp1gwrv"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929E18BC1D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935556; cv=none; b=FBupVR/8GBGakQh0ZhEwi1X5mMGcKAl5V53JjR7pdlIQZZ+CSrySQAE25WIGOGvsB0L0czWWO76mjQ77ra5ugJ8DQykeb80fMgFyzBmbPCX8kJBkhhxdgzgu4r0IKRJiRPPnkQqTn0yfpTNuzE2KyWuoo6obLpdz+MzOfiXgFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935556; c=relaxed/simple;
	bh=L4WAmOvAqqlmhgEuZU7Szyq4AKB+rJgG7LVopkTbvZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu+KLZuYVnYLhKfW5mHhbJ2+62w/IQ6VGXgZFNyY6wAxhtV1v9i6JyVJYAlISQ206hlphftu7jBe9oftaBmoNhyQHSHzXCLom6EFSUfnZTi7/Z6yh2mbOpsVQ5BNXJGluiTxPW6/cEXa7T+dhx8EeJhNA5qkHJtvSum4ReW99sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vvp1gwrv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264c9d0295so57625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742935554; x=1743540354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=og7voQ+Rn+DM07BPbCSM6gpW92L2IWvYVQjWMyJfnQg=;
        b=Vvp1gwrvJjwQYgbGF73Hk1IprCTGmTcdLhZ+QwPvxvRC0iC9fjxwC0B0PrO6xzkmU2
         TSN9wEH3/XuVfCPrcCk1H7WIEk5sMjIVx6M/kYJTDvCxkTHIOeouMTCoz+6MC9Vr4JuD
         f4vqAoxh2DDCea5zOT+uMIAn9X5xs/ca4LI/O93F3Bx64lXugmEUrq3Fph/e4Vzws0GR
         5aPhiRrNrR9tV4eepR+ukS6nEbjFI70fRE70RRo9iJ0QzCvcXvjD6gJSJfyGTR/dCm3R
         Fgck6QnusE79OlhfsMTEdcYDGoy7ZOWjkwxMR8FBaQk0CURZqOFSBS3kaw90+ssZFUyS
         sPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935554; x=1743540354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og7voQ+Rn+DM07BPbCSM6gpW92L2IWvYVQjWMyJfnQg=;
        b=qfzXlJKxxiDy28fQl56mDE1BJ2hUswX4gJAJG6lKRcMIPsNYKPWteeBvsC1RGez/bO
         MMJemCxsVsFRU0b3WUcvddAJ9IxlKh3PR57kB/Vp7Cv6mO62FKLvu1MlgOtQCXxh+Lfn
         7NYZ42uVcWEmgp5crVwZeiNECxHJTzraeNIMQ8k7Qm+0VbEcR9F3X5stbDHdGvHAgHhs
         AWRNf2Y5y3EFDD978P0Mv5HvpGrEmiyQyviidCzQAgmCvHYNxff6djgE673Qdf5eHgGm
         CCYv7EgOiCBnt+aAKwBbWnp5Sh9hgES4rsG+d/JXgEdUZpel9blIZexG/Z+Vn+p+Mppf
         C84Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQGtCt/QAqTb0crVBSOXG42Y7z9ZGHhERP4MIp/+jFdUMND4jgyWpF1/toJ4PNOw0GQz7ZW87lGKg4ibY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/+/M71pu1kqF2FHDJOnZercNRmHeqWV6o013lbyGX3Pmoap7
	jHXbDhf/x8Dd2AoG3zpSpZJjI/+KN5XHjpQMBicXM8cWBrDKF+cfO4E8465baQ==
X-Gm-Gg: ASbGnctRnTOl0xTNcRg8rbeifoSX3JhGUo+V1vbCd2kYs0fXE10TP6qZ0Y4Xy7jpGrP
	mgwCDYV+L2Hpw2SV7k+yRSP3uv4muraWUG/5h7ET665bM5aLxqoXgKZxCbC4ZwTANAiWWB8a3Vy
	apL3Aqcq/QpRUu1ihkqiX2+h3PPZ8b8DLsnC0ph5BmjTpiuO8gydoNWlqJueqllDS+kYsj+K/Fu
	Mq4HoKYZqgh1uT+gmsVmDHDIM6CnzUGWuCJTl9PH3+LGO3p6Mav7k9955LAoQOlFiHQhzAX+wz6
	1DTJRGQxxGgOogLG20tbdIra9CxWNEsTALqDUiEPrOmpmSE6kHlLzuBEHivrDnoLXkzGogOWj5n
	c5R/A
X-Google-Smtp-Source: AGHT+IGHjX9bK9q87iIXWhAvOMt0bWd6gEu8aYT/M14WqGyf8aibpiqxZfJLrxlowISVypTdfnWcjw==
X-Received: by 2002:a17:902:f70d:b0:216:201e:1b63 with SMTP id d9443c01a7336-227f3178a20mr45325ad.11.1742935553921;
        Tue, 25 Mar 2025 13:45:53 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a49bsm14876664a91.34.2025.03.25.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:45:53 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:45:48 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Tiffany Y. Yang" <ynaffit@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] binder: use buffer offsets in debug logs
Message-ID: <Z-MV_KoW2w9F0HZw@google.com>
References: <20250324180716.1012478-3-ynaffit@google.com>
 <Z-Go6qOLxT0ZfxyD@google.com>
 <dbx8v7ryym9o.fsf@ynaffit-start.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbx8v7ryym9o.fsf@ynaffit-start.c.googlers.com>

On Tue, Mar 25, 2025 at 12:41:39AM +0000, Tiffany Y. Yang wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> 
> > On Mon, Mar 24, 2025 at 06:07:18PM +0000, Tiffany Y. Yang wrote:
> >> Identify buffer addresses using vma offsets instead of full user
> >> addresses in debug logs.
> >> 
> >> Signed-off-by: Tiffany Y. Yang <ynaffit@google.com>
> >> ---
> >>  drivers/android/binder.c | 31 ++++++++++++++++---------------
> >>  1 file changed, 16 insertions(+), 15 deletions(-)
> >> 
> >> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> >> index d1aa6d24450a..994ae205aa07 100644
> >> --- a/drivers/android/binder.c
> >> +++ b/drivers/android/binder.c
> >> @@ -3261,20 +3261,20 @@ static void binder_transaction(struct binder_proc *proc,
> >>  
> >>  	if (reply)
> >>  		binder_debug(BINDER_DEBUG_TRANSACTION,
> >> -			     "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
> >> +			     "%d:%d BC_REPLY %d -> %d:%d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
> >>  			     proc->pid, thread->pid, t->debug_id,
> >>  			     target_proc->pid, target_thread->pid,
> >> -			     (u64)tr->data.ptr.buffer,
> >> -			     (u64)tr->data.ptr.offsets,
> >> +			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
> >> +			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
> >
> > These could be pointers to anywhere in user memory, not necessarily the
> > alloc->buffer. So there will be cases where this substraction doesn't
> > make sense. However, you are correct that we shouldn't log these addrs
> > so maybe just don't? wdyt?
> >
> 
> Ah, in that case I think it makes sense to remove them here. What
> do you think about printing the full buffer and offsets values in cases
> where we would print a binder_user_error or binder_transaction_error
> instead. Ideally, I would try to limit this to cases when the data or
> offsets ptr is invalid / copy would fail. Ostensibly this wouldn't
> reveal dangerous information about the user address space because the
> print statements would only happen when the data wasn't where it was
> supposed to be and it would help with debugging, but I'm not sure if
> this line of thought makes sense...

My 2 cents...

I'm sure there will be a _few_ exceptions in which having the pointers
from binder_transaction_data logged would aid debugging. However, this
won't be info that most users care about. In practice, logging an error
with "invalid buffer/offsets pointer" message is enough.

There are _other_ pointers that users do care about when debugging, such
as binder_ptr_cookie but not these. So I think is better if we don't log
them at all, as calculating an "offset" is not possible either.

--
Carlos Llamas

