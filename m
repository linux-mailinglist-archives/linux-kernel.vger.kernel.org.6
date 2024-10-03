Return-Path: <linux-kernel+bounces-348966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F087C98EE8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D5CB2101F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B381155330;
	Thu,  3 Oct 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L0dtKJ87"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2116155C96
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956371; cv=none; b=SfZHRzCHcfkgXegsIW++x//mpMLJZS4stKDno+hKBfEo4Va3lDYHg7Tcg44I030jnSrxWdKKAe6dllxyRpalVdO7/AE5x0sN8A55cjv6OyH/j+qxQcFhDwsFdCuII4mOD1wlgVtU0dKuvO9n5yngqfTjW6SfrGlPfI/dKD7NZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956371; c=relaxed/simple;
	bh=Wh4l8Az/KY0v3OC2ST9tddQSlzIJcdcfoB/J2zdsd/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNp3EG8vRw0s2hDM/V+30f68zuLRn9jWSrqY6cZah0yyLw/TXghkIrhv0KekbHO1w1qejsSzQHtBvPHHA7HjsWbm6Qq1BI3FjLj12SQ9HqVPvwgeeruEcEEcxHOFkCDxNmpSE5hdX8JdIBeSGRHU0dFQ6MLl3PQTmf+eRCu2DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L0dtKJ87; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fabd2c4ac0so10566941fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727956367; x=1728561167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYTaZLVmqP9UamQF3fmKmfm8bWtPNDsWL4oo2X00/mQ=;
        b=L0dtKJ87nTj7QO7ADcPA+TxIjAbwKqYJH8GJDv8uALkv4sLleB1bokhNkMLwNJj0R2
         fKeiN8S9osxNyhZBDGxA2R5b/8B8u84L0T7jZa7uMS/Imx/a/aXIYByf7h9LUUNZ8myp
         YH45QYQULRMY85Qh5N3BCXrMvu76mqekfAtaenFL2IkA/5K3Z2RYv0zi88afguB+/1Zz
         U0deD6Lb/QNx8KFGXXK5qLajMKpnlmqwr3NPptEhm8tBbDSph7z/s4y19iZRZeGh3fEM
         AXVghgpticUz9SLzq7hB+cxI0ajrFr4a2IYS1wqlg3MMu4tN5drI+EPx9HaqipJ/pzt6
         3R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956367; x=1728561167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYTaZLVmqP9UamQF3fmKmfm8bWtPNDsWL4oo2X00/mQ=;
        b=kPIyjobBdD8bMLrXven+k+vtzgE8NQa6aJHGFoYYW05+Lt6X8G0wOix2uqOefG9XqV
         u8ZfhDd+hDA0EG/mU6NIq7H86TgDb2d73edIrK2t6dxgr9ojw1XIzo9zo69jsfT1nlQu
         gPt5qjUTKKuvQRjWDGBlAm++G1F/xhkXhqtRZ+Lv2QgOP9Lt7c+VD9TxLupmLe32xi9z
         EkcuxmXtcsBnet/NCL+FtlAilT86stMXVTzkF48/lEE8z+Cgfyvu8akIEAHULQcLj2fc
         flKiaM5ZP2j2w+pONJcjIRVijrUDpD+iAkRA0Tbix7G8ovg+EOSKTIy0SLPv9ur2SoSy
         4vbg==
X-Forwarded-Encrypted: i=1; AJvYcCVsiQa5nN5MBvP3OD8zX8UPgT4QTgs0KOEuce0yi9wXa5Fq2JsHa1qBJpsi3bQyZK+E7ZGTGSP77JijVO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHEqsNS7553Ky7G6kRNX4Xnhppbowq+kb1g7lTiURv+NQY23a/
	q50umEi4hk10RfpgJkat9GjM17HmHnXeX8F5bSIARCjjC5KmpbQZt3U7CHQtquU=
X-Google-Smtp-Source: AGHT+IG5IqUbGaDisFw6QQQyG0evOtTglSBsPHu+Q9HaTETo1tnz4mJPRAbeqPW6ydeytkKAIETMxg==
X-Received: by 2002:a2e:4c0a:0:b0:2f1:a30c:cd15 with SMTP id 38308e7fff4ca-2fae10aedf7mr29528001fa.36.1727956366851;
        Thu, 03 Oct 2024 04:52:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3de7b6sm626248a12.27.2024.10.03.04.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:52:46 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:52:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/1] livepatch: Add "stack_order" sysfs attribute
Message-ID: <Zv6FjZL1VgiRkyaP@pathway.suse.cz>
References: <20240929144335.40637-1-zhangwarden@gmail.com>
 <20240929144335.40637-2-zhangwarden@gmail.com>
 <20240930232600.ku2zkttvvkxngdmc@treble>
 <14D5E109-9389-47E7-A3D6-557B85452495@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14D5E109-9389-47E7-A3D6-557B85452495@gmail.com>

On Thu 2024-10-03 14:26:19, zhang warden wrote:
> 
> Hi, Josh!
> > On Oct 1, 2024, at 07:26, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >> 
> >> diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
> >> index a5df9b4910dc..2a60b49aa9a5 100644
> >> --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> >> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> >> @@ -47,6 +47,14 @@ Description:
> >> disabled when the feature is used. See
> >> Documentation/livepatch/livepatch.rst for more information.
> >> 
> >> +What:           /sys/kernel/livepatch/<patch>/stack_order
> >> +Date:           Sep 2024
> >> +KernelVersion:  6.12.0
> > 
> > These will probably need to be updated (can probably be done by Petr when
> > applying).
> > 
> True, kernel version may need Petr to decide.

It would be for 6.13 if the changes are accepted in time before the
next merge window.

Also please rebase the patch on top of current Linus' master or
v6.11. There are conflicts with the commit adb68ed26a3e922
("livepatch: Add "replace" sysfs attribute").


> >> +Contact:        live-patching@vger.kernel.org
> >> +Description:
> >> + This attribute holds the stack order of a livepatch module applied
> >> + to the running system.
> > 
> > It's probably a good idea to clarify what "stack order" means.  Also,
> > try to keep the text under 80 columns for consistency.
> > 
> > How about:
> > 
> > This attribute indicates the order the patch was applied
> > compared to other patches.  For example, a stack_order value of
> > '2' indicates the patch was applied after the patch with stack
> > order '1' and before any other currently applied patches.
> > 
> 
> Or how about:
> 
> This attribute indicates the order of the livepatch module 
> applied to the system. The stack_order value N means 
> that this module is the Nth applied to the system. If there
> are serval patches changing the same function, the function
> version of the biggest stack_order is enabling in the system.

The 2nd sentence looks superfluous. The 3rd sentence explains
the important effect.

Well, the part "is enabling in the system" is a bit cryptic.
I would write something like:

This attribute specifies the sequence in which live patch modules
are applied to the system. If multiple live patches modify the same
function, the implementation with the highest stack order is used,
unless a transition is currently in progress.

Best Regards,
Petr

