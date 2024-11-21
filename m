Return-Path: <linux-kernel+bounces-416484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF09A9D45B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9881F2204E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00211E884;
	Thu, 21 Nov 2024 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZdCmPuu7"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A019A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155858; cv=none; b=J7a9aMnKWb3J/y5zK+ucMCXLtqCp6At1pkGeeIwHJOc4oosyLJMAGdWDDt877rtI1L2rq7SZUZEfdxf2AtL4CxTADXx9sdwLTpPLJBNorGbGlmJ/xb/rTvcaYVjZghmtT9mGNg3uv6SVBJ+dqPqYS0JoywD0GPJ0ILch3JhVZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155858; c=relaxed/simple;
	bh=FrwpwY0QgBp/05+IQ/BiAHTeuNYSmYA9/t7Sw5rNzlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRlBt8yO5P7t4kY1yy4oRBWsfgy3vQ4H3vJNY6vn3tuPCa04h1vLbiEEVhzWy51jCSwv8zeoL3eFZIPjSxQQ05a7xFXKEChACj1oSdffwI26/QaO1znn9/cp4/h7eQS1L5/jajSCUHinqiKLlWcdcOWHs0BFS9QeKnkyS61Iv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZdCmPuu7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9e71401844so58397266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732155854; x=1732760654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dBWX2KEmVRvSFN/PQiBqXR51abbrqVlIHCrrRa/Sib8=;
        b=ZdCmPuu7bRd9MK//NmfWrJ9p6pLLJVGl5ygMjQeresna6nZrwivGMssonT8z5/vjSz
         3qjIjx3t1UzBmJRLuerNoGsGjc78Q2PkJEsmqpO6oUXmZs9QO8WZBRnBXjn2vaNO0BKM
         trgpQc3g1+/o7XK0MlfLCU59oZA+OMpWPhVwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732155854; x=1732760654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBWX2KEmVRvSFN/PQiBqXR51abbrqVlIHCrrRa/Sib8=;
        b=vqyBXxE/HWhnD6vsYqigYMSAhqMtiEABZ2S+GQ0sswL4rgbrwALaDHiXsJYXHfmbwS
         M2lqeWnq4Yr9+VfYQaP3niRV62HDg4JGm+BJkJOdfg2iuho/I66CTgIhtyxl7fZ4L6kF
         DISIEeCFeFIrZxrm8bwR4TqyYgg0NN/z/gP1W3Vhl7Buln3Yn9YmFbTJawkmeafdmI4R
         Au8VjDtAyuiQBwzHfH64LtivpgrDSixKijUDZw7wBV3lPaLHpb8f+nlW9adSBkXr9OKR
         PBBxcexLnYB8W7OcuD6UbB/cgHtdQoVKfiKSLiF8nUNMjgVFBr5mHxn2BQzkz8vYCo/W
         vhMw==
X-Forwarded-Encrypted: i=1; AJvYcCVUTDnbHe+auw7NYrp5YjuyDvLR/r6/PyijpVriUdwbTxVNIWShTQyD7o87Vsp7H68pAJCf3voBholBHxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6GaIfwVZSsM0KuY2QmNGOqS/TnAkaud6lNKpBefhmupKWXzJ
	7eiinJC10Pe7vNsZ9XYAzN3ytpP74R4ru6kvZAq4/ObtQK7i+r7ibjAc2jfcbYMT0yKfJ6gO93L
	3cOg=
X-Google-Smtp-Source: AGHT+IG0H0NP4QsxEJXKAN0npSY2dDv2akKqcrIj9AYUiHHfgywc4GvL13iWtADi68DAfGJXo3MK9Q==
X-Received: by 2002:a17:906:6a18:b0:aa4:a814:3f69 with SMTP id a640c23a62f3a-aa4dd5304bemr526219366b.4.1732155854052;
        Wed, 20 Nov 2024 18:24:14 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41536d3sm24399666b.24.2024.11.20.18.24.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 18:24:12 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ef275b980so68807766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:24:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5ihljSVLruC1MqbiSTdmoGofIif13Q4bdRA6JnH1asBtthdJQbEwT5x7brJoW4NdYG6zhBpn1K91zqkI=@vger.kernel.org
X-Received: by 2002:a17:907:9407:b0:a9e:8522:ba01 with SMTP id
 a640c23a62f3a-aa4dd723feamr507045366b.39.1732155851655; Wed, 20 Nov 2024
 18:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87jzcxv227.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 18:23:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
Message-ID: <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 16:55, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> __set_task_comm cannot be called with bprm->file->f_dentry
> unconditionally.

No, no. Only for the "no path" case.

> The reason bprm->file->f_dentry.dentry was abandoned were concerns
> about breaking userspace.

There's no way it can break user space considering that right now
comm[] ends up being just garbage.

And I do *not* want to replace one garbage with a new one.

> >  - get rid of fdpath that you made pointless by not using it for 'comm[]'
>
> Again binfmt_script still uses it.

Ahh, yeah, we can't just get rid of it.

But we're *not* adding a new complete garbage "copy random stuff badly
from user space" thing.

             Linus

