Return-Path: <linux-kernel+bounces-182318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E48C899F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5B6B2152F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60112F598;
	Fri, 17 May 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jv0sWgVI"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751912F595
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961176; cv=none; b=Ek99zqFV/fVAHhMUE2AFjEarJocfYP7hyyH6zeMB9ukiGI1vzcwXC3xL+dTAyxTGXHePHAK4S8F5S38iOrWeKnt+4CyGbUPhR15kjka9kZ0ulNlGj1qZXdlgnndnvXelrzb6oMsxmvLhRFnkaLbZt7V6hMox3kQQYTdNWwp2Kes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961176; c=relaxed/simple;
	bh=+KKefjoffKvfiWlHtyzARSgF6pa3VRijHQBIea8/azU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af4va/TIZyLpp5PRWdhi5QVWFy7rz3SWkwQoh7Ig9wpSrtm7Wv2BX2jl0YTZyEYud16RjU/95s/A3GXM+lbhKIcOaly5I0jqULi3wz82VnsbzMNtXAyqA+1lh4/S5TanH7DW2cPf52bxzlgWFqzoRA2sghapOTXYfBfnJhWXUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jv0sWgVI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f45104ef0so1003780e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715961173; x=1716565973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5F6odILlMEMye+qyQ7yUkE31zWxXmW2HU+hKWzkF4IM=;
        b=Jv0sWgVIJ5ZAfdZmxnRL7r7w/3ryERjop4vZ6RNzYr691huDo/jWfWFy9fPv4GkbVw
         wpH16sYL8xOrsIzRgW+SvmYoxnkWP5XEo/IF9bzURL7vCyOBSni5XhSLQfN21IiyjRSn
         ZiDNQnc41QYk6TLB7/Wrw56Vc/jwerzpTNeWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715961173; x=1716565973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5F6odILlMEMye+qyQ7yUkE31zWxXmW2HU+hKWzkF4IM=;
        b=drkhoAVFCj/wKMjg462aEedHvYEMDJ6hP8yCzZciN00T6iyRhOam4G7LR3kc1rxrGn
         vS8maJPnRY8gkWNm70Q3MITOWc6M3pLErzExCB+UI15JPXVnSPNWj6TkpuMroLKIbAvz
         OZ7nFNunSyyp//BO+4EceTNBPUTtCTIRzaJ0jEeAdZBoQyiLnkx3meufTOWOxpnibRo4
         hrJ+cECj4CLivX66ZL+IXvPeUbkNjy+7ggu2xknQ15esWxkfO48dZbBU6kiZABXbV+25
         Swp6xlPM7Aj7E6WPkK9B7QHwqA3DlYGspq3SIq7HMgIK+uxna1n4GtoNbZlP6DT4gMDg
         6CKw==
X-Forwarded-Encrypted: i=1; AJvYcCXN7/hx9qygNqwgBcLdxTNq9rJWgkxd5vxdHGkT8bJJxBk9o5BnJiBR4wwLyr0JFVMKRhhbF4w3hKNlrYFMc6KPCqzaicm3pew6Ph4m
X-Gm-Message-State: AOJu0YwqWLrqYQpFR6By02Jf7j48TOzkrA5UY+aZs7/iBlbSGsdVhqi7
	ggco1f4MPV+6ah9VboGOfyANS4an03EXuKKeQ2zgaGaXeSEObk7IN9LEf+RPN05U6KLp84PLCH4
	XQM8=
X-Google-Smtp-Source: AGHT+IEw0OFPx4yWwTYVjSy+jxtnIFy6OXBenVH6RTxcm2FOYxkQCM3CKT4t8O4KvAmmkxhqUKZ7sA==
X-Received: by 2002:a05:6512:1314:b0:51f:601f:cbae with SMTP id 2adb3069b0e04-5220ff73602mr16902263e87.56.1715961172858;
        Fri, 17 May 2024 08:52:52 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5236cdc7e62sm1432170e87.295.2024.05.17.08.52.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:52:52 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5210684cee6so1050248e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:52:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgYOjws78AObn3NzcwCys6vbTWDNnHiTGynWP7hg14qpqGgcLr8oGV6UWBSe5SOOBsi2I7HZ8DxOZZxHOsvNLZnzvsnNaLP81atdnH
X-Received: by 2002:a05:6512:15a8:b0:51f:b781:7297 with SMTP id
 2adb3069b0e04-5220fa7180amr17902407e87.8.1715961171112; Fri, 17 May 2024
 08:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507142454.3344-1-konishi.ryusuke@gmail.com>
 <CAHk-=wgogPoSdCYw9jhc2Zm=BaE19nXYwFn_F9SwD2C-DyrmCw@mail.gmail.com> <4a5cf233-a4e6-48ce-b9ba-f1014f452892@acm.org>
In-Reply-To: <4a5cf233-a4e6-48ce-b9ba-f1014f452892@acm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 May 2024 08:52:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9cwmRUzqskD=qV2oCpyS8GBWWAv1sSrN8YOPR3fd70w@mail.gmail.com>
Message-ID: <CAHk-=wh9cwmRUzqskD=qV2oCpyS8GBWWAv1sSrN8YOPR3fd70w@mail.gmail.com>
Subject: Re: [PATCH -mm] nilfs2: Use __field_struct() for a bitwise field
To: Bart Van Assche <bvanassche@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Steven Rostedt <rostedt@goodmis.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 14:52, Bart Van Assche <bvanassche@acm.org> wrote:
>
> It seems like sparse verifies the types of all expressions in a
> _Generic() argument list instead of only the expression for which the
> type matches.

Yes.

>    Could this indicate a bug in sparse? On
> https://en.cppreference.com/w/c/language/generic I found the
> following (I'm not sure whether that website is a good reference):
>
> "The controlling-expression and the expressions of the selections that
> are not chosen are never evaluated."

Not really a bug, because "never evaluated" in the above context means
that they don't generate code. The expressions are still obviously
parsed for syntax and validity.

It definitely might be seen as a misfeature, though - the "degrades to
integer" warning is done before code reachability has been determined.
So it's done even for code that is never executed.

So you'd get it even if you had something like

        if (0) .. some bad bitwise expression ...

Sadly, that's fairly deeply ingrained in how sparse deals with the
bitwise types: they degrade to their regular base type as part of the
type evaluation, which happens fairly early on the syntax tree, long
before it has been converted to SSA form and reachability analysis.

It's *fixable* - instead of warning when evaluating the types of the
expression, sparse could leave in a "warning node" into the tree,
linearize it to a "warning instruction" in the SSA form, and only
actually output a warning if that instruction still exists after dead
code elimination etc.

But that kind of fix would be a pretty big change, we don't have that
kind of thing right now at all. So "fixable in theory" is probably not
"practical with the current lack of sparse development".

What would be much easier is probably to hack together a couple of
builtins for type checking: a "__builtin_signed_p()" should not be
hard.

                  Linus

