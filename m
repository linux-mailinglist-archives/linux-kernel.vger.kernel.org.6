Return-Path: <linux-kernel+bounces-304225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D9961C20
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16ED1F247F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64841A8F;
	Wed, 28 Aug 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEQx3nrv"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6008F49
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812318; cv=none; b=f6eQTJh9RgyEOaP5wa2cSLPZ58NGpPE1QOp/6TyNjEg7OVoK+kD3m3t7lhgbRVzXQ7cr4zp/ZPlEN4ug5hST0KxebPEwISz8c/bqX9EfZFTEqbrtsB99vYGPjnrGNgyAN4zjL2ailBsjnmOxyFOOuRbHQLnTfDhPWcLq0if9Y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812318; c=relaxed/simple;
	bh=5i0vwY1TQmn6Ut7owwX77TQkqXd3Ihep6vwJkWqtLac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvmOYE3EWFvuxsCRCv5x2QGdJPdUCCTovUnoKkCEsFeOebbzNlAo8CiWYyMW2SlxatiN4Z+kNfZnuNytq2hFljoAw5iX8St9sFd6H7/Ig2gNsmZjgOLpJ/PfTXNt0ou/aqkW1f7XBGIvwYSP2jj0g318I5LW+z+795Hv72Wl0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEQx3nrv; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2610c095ea1so901356fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724812315; x=1725417115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1GnzLFrUG1kn/nmXLxF4DvuCqygZXWm2X5g1VCxpbo=;
        b=BEQx3nrvxP+4U7722rPK+4NhcKbSpgwjahhYmnkB2z6cBMFJfwkkl5xYNRQRhl8pTF
         G8AiN0ez7IdxjZJVyfMZWaaFIlORve863ijrCTsRY2jz8sUlhriEGpSl8nuJtLrjzqL5
         f5/+rqfx0TekknJOlCDQ1bSpgJtEH1Lsw+ARbvdFRZGYuKsl2+fBUV2v/pAntCgxWJwj
         w7F99b3OAJhg/4iuOWwoUR8kNIreSPbM2p8pkAdGip7ATokNOG2veRLkmjwA1Xo/Nz2j
         kJDy+6Kez7MQsfQ2zxWe2svIJdifbELxVVPwsGQKLSb1DblaA7NT9rmKZ3RC4hlYCB7b
         aHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724812315; x=1725417115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1GnzLFrUG1kn/nmXLxF4DvuCqygZXWm2X5g1VCxpbo=;
        b=g9/+yqBJMFhfqG4ta+3gcKT5LjL/m6cgVEjt6l8l7LxvW7Ek+1nnNKwjLqjFalz35m
         VYoxzUvZ1r13IETuOogAsj9PR7A6wC7/5+Jci5p8iRHgmn4HA6IJKMIlHuDhJAESiG7J
         ERINZllXK6ow9OQjS+KA8+hpBWCBXDR+NLEkpU8TO4boAks0B/v1yLttmpyOj0/gYZVM
         5zJtNUcz30QzznQzhJbuCI9gujdAuABypnGs/EEfbMrCjVJ1zYKsbdyYoyOLqn7phvC4
         jWWBLmhpNz6pQ5eaTHFqAX+HBsexhBU1SJkLg7JaXZDmGMHz4xGa+Amn+861TIwPW0mi
         13lg==
X-Gm-Message-State: AOJu0YyhmJtM7UHddpRTmB8d1eacEyBm1XIFrRWckstLHIxEI8LORmin
	2VZ21wK6Ys/Bs6cANaZUSAZjNHBLq7J1IOk974KjGAEyMzlKK/Tci/Lw72Yl4Hw=
X-Google-Smtp-Source: AGHT+IHjlwirEOdOCQOdTSpzmaZOMKmTQUa8JaZXOIJC/SddiPnM/OUZ0hyY4uPE+SoanZSlN37Rfg==
X-Received: by 2002:a05:6870:700e:b0:258:476d:a781 with SMTP id 586e51a60fabf-273e6468d3dmr9172472fac.3.1724812314980;
        Tue, 27 Aug 2024 19:31:54 -0700 (PDT)
Received: from localhost.localdomain ([49.0.197.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm9144713b3a.218.2024.08.27.19.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 19:31:54 -0700 (PDT)
From: sunyiqi <sunyiqixm@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	sunyiqixm@gmail.com
Subject: Re: Re: [PATCH] cpu: add CAP_SYSLOG check for reading crash_notes address
Date: Wed, 28 Aug 2024 10:31:35 +0800
Message-Id: <20240828023135.944867-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024082701-trailing-poster-6126@gregkh>
References: <2024082701-trailing-poster-6126@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 11:15:25 +0200, Greg KH wrote:
> On Tue, Aug 27, 2024 at 04:11:33PM +0800, sunyiqi wrote:
> > CPU crash_notes value can be obtained through /sys/devices/system/cpu/\
> > cpu[NUM]/crash_notes for leaking the phys address(introduced in kernel
> > 5.10-rc1, but some distributions may migrate this feature to 4.x
> >   kernel).
> > The relevant function is crash_notes_show() in file drivers/base/cpu.c.
> >
> > Though crash_notes file permission is 400 and owner is root:root,
> > but in container, the root user can also read crash_notes which leads to
> > information leak as most of kernel pointer value can not by read for
> > root user in container without CAP_SYSLOG capability.
> 
> "most", but not all?

Kernel usually use printk for output kernel pointer through /proc and
/sys, when investigating the /proc and /sys directory, the kernel
pointer I found is all printed using printk guarded by CAP_SYSLOG
except crash_notes.

And kernel also has a script to check kernel pointer value leak in
/proc and /sys (will be mentioned later again).

> > In current linux kernel implementation, kernel pointer value or address
> > printked by %pK is not directly exposed to root user in container. For
> > kernel interface which includes those values, like /sys/kallsyms,
> > /proc/net/packet, etc., address values are guarded by kernel function
> > restricted_pointer(). Without CAP_SYSLOG capability, value 0 or NULL
> > will be returned for reading those interfaces in container using root
> > user.
> 
> I understand the request here, but why is giving the "real" kernel
> pointer value somehow bad here?  What can userspace in a container do
> with it?
> 
> And why not give root permissions access to it container or not?

Linux Kernel exploits often need kernel address to achieve LPE or 
container escape just like lots of exploits in repo of kCTF held by
Google.

When kernel has a memory-based vulnerability, kernel address
is needed for exploit. Attackers in container can leverage this 
crash_notes to get kernel physcial address to use. Similar info
leak issue is still popular in exploit for distributions which
has not fixed those issue:
- CVE-2022-4543 kernel: KASLR Prefetch Bypass Breaks KPTI
- CVE-2023-0597 kernel: x86/mm: Randomize per-cpu entry area
- CVE-2024-26816 kernel: x86, relocs: Ignore relocations in .notes section

> > In restricted_pointer() and container, address values only returned by
> > kernel when root user has CAP_SYSLOG capability which is not the default
> > capabilities for Docker container. CAP_SYSLOG prevents root user in
> > container to get kernel pointer from lots of interfaces based on printk,
> > but not for cpu crash_notes.
> >
> > Add CAP_SYSLOG permission check in crash_notes_show() for viewing kernel
> > address.
> 
> Is this really the only place where this type of check needs to be
> added?

Early this year, when fixing CVE-2024-26816(kernel ELF note leak kernel
.text address). LWN article say that kernel has a leaking_addresses.pl
script to scan pointer value that expose to userspace in /sys, /proc,
but this tool can only identify the pointer value in human-readable string
type. In CVE-2024-26816 case, it outputs value in binary form, so the
script missed it. Cook <keescook-AT-chromium.org> fixed the script in
18 Feb 2024.

After that, pointer leaking in human-readable and non-hunman-readable
through /proc and /sys seems to be solved.

Why this leak is missed by leaking_addresses.pl script?
The output of crash_note actually is offset to PAGE_OFFSET which is
0xffff880000000000 in x86_64, it's difficult for scanner to distinguish
whether it is an address or normal data.

> > Fixes: aa838896d87a ("drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions")
> > Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
> 
> No cc: stable?

I used get_maintainer.pl script in kernel repo which is a way for finding
maintainers for specific file maintainers in kernel submitting patches
docs, only linux-kernel mailing list is listed in script result.

Also in submitting patches docs, "a severe bug in a released kernel"
should be directed toward the stable maintainers. This crash_notes issue,
needs high privilege and happens in container scenario, also cannot
be used for LPE or DoS directly. So I think it's not "a severe bug".

I'm very willing to abide by the rules of the kernel community.
This time get_maintainer.pl confused me a little if the result of
get_maintainer.pl script is believeable.

> > ---
> >  drivers/base/cpu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index fdaa24bb641a..a2f27bb0ffe6 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -156,6 +156,9 @@ static ssize_t crash_notes_show(struct device *dev,
> >        unsigned long long addr;
> >        int cpunum;
> > 
> > +     if (!has_capability_noaudit(current, CAP_SYSLOG))
> > +             return sysfs_emit(buf, "%llx\n", 0ull);
> 
> Why not return an error?  Why is 0 ok?
> 
> thanks,
> 
> greg k-h

This patch refers to restricted_pointer CAP_SYSLOG solution, output 0
for unauthorized user. Also, I think in this show function, return 0
value maintains consistency of the result for reading crash_notes. 

Thanks,
Yiqi Sun

