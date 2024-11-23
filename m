Return-Path: <linux-kernel+bounces-419188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D49D6A82
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A36C281DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881A381AA;
	Sat, 23 Nov 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S104uy/M"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22035195
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382355; cv=none; b=EDSNBtdE3j74mvtvK2EbIbv7+G1IK9EKr/XqCcF6WTRubKqxo+H76SHXG6+rhwiThoi/d64QaPeJPNJVmdJCQWA9xzX+S5SZw5lGV40hKe3qWpWi8jFPyWpXw4DTk6kZuBPnLdyD7MNwtLoyfiThfzlw1dtEijsAcZS/j/PCjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382355; c=relaxed/simple;
	bh=QNIZtU4UrRNcRlunJNgMSCglLrYx5rpbKWGGR17NwJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMaexwX/cJ7d9Ahd8Z80F7kMCR3YuOX+pQ+5zn4+ItiL2egPk3n7LXpReOOZrBSQ/9aixlNLzQHGTpe/EB2F5OG23QvrnuY2Hp7fOpWMHi3KjurHE5BfqQlT8vaFuM4cueT8Ih3q4/+TIxydok4U2cUyMU1MDYKSIrcyVHcWXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S104uy/M; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a850270e2so516708866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732382351; x=1732987151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5ChkXbScmteXOdHtNzIaXrYK9u5mdbWBULNnkBZeec=;
        b=S104uy/Mmq8ePJYaZ/iehPGsIQiH7DO5g7nZXzIqaTLvWthUwAeeYjwBXxZrOLp8qN
         PELXalv34hVIbzFhTiVuXHR++UdJcZalj2OGQuvlLHK+SJKCnC2uDHkIkp63bnAKayWl
         N5qMPHa3gejLeODnNIJuurFLxIm+exhuroOfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382351; x=1732987151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5ChkXbScmteXOdHtNzIaXrYK9u5mdbWBULNnkBZeec=;
        b=LHUyvzQVGLC7SVBkmFDaQZLg/h5Gfpg6zSaUpEojpzB6xoJeNp6zKUipgjniFdXEwu
         jOJGHCneAZAF65UBjVFwJFyRglult30BFrxD0da6Q9QJwZgDn+8HJpwCjFN62IQGf4VL
         e/KEiCe5ST1VoXTc28C0j6EyLcEumbEhs8rL6eIZd01gKYdyHABmnzgETFvWKo4PKB1Z
         82IR5bxXuUqRJtXnzlRAND8+/6rRPBIdVLR+fzHudMgcodmfV9Q6ZLxpnXqw6SWuo4u0
         HrEbmv0xpLstahHCFWifvf5sEth8gXYgluQwu7qimXPGgdd6sN5IcrDcJTk72DLtpPXa
         mJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXV9PtEOlLDRxrqJaH/6Oo2D7BQ9KWp/jcYCJyrirAvRfmZKSyotkUr7eWvyVF9s2VVP5nRe05QXbzrTts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+O58TmsMIY4ChxotLynF85TsdDU6wiOHkBkY7qY6CTJOpEFkL
	GzAyqgSJ+NLAViUwGyFPmKU6u6LOtY/M6WwU16EgyX3KjscTTBipT8PN2ARjVbvkw9/D2x8jJE8
	45MGcnA==
X-Gm-Gg: ASbGncuNqnt8vgZ/qp++1QvKD3H4PU98ezLcJl0Nnrbon/dk8ES14HQSWtwBlITUCPb
	wy0XsRYeJeL57KG+qLPd22tmWKoL9LoW600sgEfkqvGLThV85unL1T2JdV4bbaExnleWAZR4hrA
	NC1AwKiQpt190LNy9VynW0XY31YqEdZ7GD2bxVTp60VEiPXHu/Qlkh+Pfzm/5a5TxPiG6aIEPXD
	/qZxBPnc4HDZTl2UrzW+2o2ms1rKBuhFBxJ9jnifS7pjHdhw+u4aQ49xlhZnW5+8Uw4oQES+Tuo
	SheCYTUYM9IIN/NBF2rAYcPR
X-Google-Smtp-Source: AGHT+IHznlsEwdB7icssG716XtZk+NkWk+ePotkjcKywpiAXLiKlyYSFY6LyU3e+cxotEqB+rLhM5A==
X-Received: by 2002:a17:906:cc9:b0:a9a:82e2:e8ce with SMTP id a640c23a62f3a-aa509b90dffmr612105466b.40.1732382351216;
        Sat, 23 Nov 2024 09:19:11 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fa76sm249673166b.94.2024.11.23.09.19.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:19:10 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so3557344a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:19:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDdcWFdY4US/llfO+Ijw63+F85RfrC4G5k9zG5zBxyrm5YS1SN4+nK6wAayuU5GwVRGvzI7FYl1JoTUrs=@vger.kernel.org
X-Received: by 2002:a17:906:2191:b0:aa5:cad:eb08 with SMTP id
 a640c23a62f3a-aa50cadec25mr539778766b.39.1732382350257; Sat, 23 Nov 2024
 09:19:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
 <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com> <20241123061407.GR3387508@ZenIV>
In-Reply-To: <20241123061407.GR3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 09:18:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWYnr+V1-RbgvxkuD6uSQUJWGuounVMXThyH8jJ49c2w@mail.gmail.com>
Message-ID: <CAHk-=wiWYnr+V1-RbgvxkuD6uSQUJWGuounVMXThyH8jJ49c2w@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 22:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Nov 22, 2024 at 10:09:04PM -0800, Linus Torvalds wrote:
>
> >  (a) add a new "dup_cred()" helper
> >
> >     /* Get the cred without clearing the 'non_rcu' flag */
> >     const struct cred *dup_cred(const struct cred *cred)
> >     { get_new_cred((struct cred *)cred); return cred; }
>
> Umm...  Something like hold_cred() might be better - dup usually
> implies copying an object...

Ack. "dup" is clearly a horrible name, and I'm ashamed and properly chastised.

               Linus

