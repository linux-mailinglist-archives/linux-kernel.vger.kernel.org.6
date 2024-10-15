Return-Path: <linux-kernel+bounces-364956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCB99DBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D86287CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A77158A30;
	Tue, 15 Oct 2024 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="wn3nw3yM"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B518A6BA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955926; cv=none; b=OJXdOqOZVZAymHH1PAbdiVA3WuS2D+l3Yo3byI8R+yu6AdrzYM848/M3uKFibUhRqj5MA0loeReb5tny7h9iP7YRAysfIe6tRDNLc9IVARffqqScczviwQxXgwqFzFo+FBpg9wkVITY/+3kPZlkE16IjRk6bLG5lSrzhd0tSvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955926; c=relaxed/simple;
	bh=evtDFhlbO2SfYWbBEcGg1cg6KW2I8YqCcXT82SPzxcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi8Z9GOl7YKzwxJx1XcdEUjdbA3UymQ2zb0uaN2EoBJ/5Af1LSu+GVxKzBVhk18LHC6fs9Ga473jHC5P8wnSqs9+kGDscSaUXOxs6f8U2YiB2zeShBdpVE9qUBmhtI304bdb1cOQi47290O9e13Ycki+034z6wKviwqqQ3eNLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=wn3nw3yM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b110709ebeso352026185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728955923; x=1729560723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcrqeSJOTDI/cz8AM43HkiRMvxwegUULZjWirUjS4dU=;
        b=wn3nw3yMrQmYf0jnMy6rs/mkB8H0VREMt0z5LzZ+/KHjUsYNGiQnOgYFVQKIE0IuoD
         h4Sjv5LzVPCdepviNnrkAYdrvWDGS4kJBAa8BId5GtCh1Wb0+zv0877kPbDcDQMVYbN6
         z0o6f72yjNbmxoSS8v2W5wMQrqME0FMaACHIoazFbZxDdPK0ElTeRU3ctO84xOPYmWWx
         I0wuw/rKWBTIalv4f8i7XgcqfIEac1fvXRKCvks6TKHScPl7xd2VJ3JjVhCqEUEH3DHo
         xKY6JBNbnSkJiJnL5TV1GPWp6Ebmy2ZkzAhDTfWH4UREbKapNyT6CG7Lg94wQoVL/Vm/
         6jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728955923; x=1729560723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcrqeSJOTDI/cz8AM43HkiRMvxwegUULZjWirUjS4dU=;
        b=Urrvv4NyGy0ofs4w68TgK5pohsa53B/kKqrhJB51xJaj5C9vYCWJ/9fLgQDfdVgIsH
         pMTUFSZw3x+xgtfkWLSlN8855Ll7BQtalxfHs4SRNavVxXvGAivN907FsCsE7macO5z4
         M32PAASgDuvdIAUTkEs04wWyNEvGjRRSZ96uaDstvhCckhwN68NKUxSF9fHZqg6d994A
         /wP9Z1UeCJhl+QZrMKOunnZx+3VYqOzoHhMK/ZGxLhY3m62kH0JPiAY5jLYdHRCejKWI
         FY5Rp0b4GCrtWiyqZZNnPDvdEC56k7R3ykLJcVsihB9g8bBBUi45T9SRA7IPu13VDk/4
         IKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtKzwrrUTuT6xKOFzORtuJNVDi8aNOARsEmEr6BB5NVc7gNdV/EdZJkp/il4Z9lxOq3tSg/5k0CYGSBhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkeGhKRSk5cQDLNykVhhklgYZ0hOHcRuKn84ScdMajBWjLDFp
	wdxDWf6c5YiJlD7grHDZJ3QFnlIkptZKtaYnj0eKd35WNBeOcVBq1iqdDvRFzN/1f3VS/hSrq7w
	=
X-Google-Smtp-Source: AGHT+IFb3JuxX0Me0Jk5ytKkH2I02jiUABZ/eXCHy7K9rI0ylzmgsAhY46mtxElZewvi2+A35r4cAw==
X-Received: by 2002:a05:620a:468a:b0:7ae:d2d0:f86 with SMTP id af79cd13be357-7b11a396bfcmr1842929485a.38.1728955923241;
        Mon, 14 Oct 2024 18:32:03 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::7dde])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b378b1csm1254641cf.75.2024.10.14.18.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:32:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:31:59 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzkaller-bugs@googlegroups.com
Cc: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <377d1fd2-054a-4ce2-a188-3db86675e5d9@rowland.harvard.edu>
References: <1336ee1b-cf5d-4081-b4f1-512e2b29dace@rowland.harvard.edu>
 <670dbb0e.050a0220.3798c8.0134.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670dbb0e.050a0220.3798c8.0134.GAE@google.com>

Syzkaller people:

What's going on here?  This was working earlier today...

Alan Stern

PS: Why doesn't syzkaller use a 12-digit SHA-1 code in the commit: line 
near the bottom below?  This has been the standard in the kernel 
community for years.

On Mon, Oct 14, 2024 at 05:45:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> kernel clean failed: failed to run ["make" "-j" "0" "ARCH=x86_64" "distclean"]: exit status 2
> make: the '-j' option requires a positive integer argument
> Usage: make [options] [target] ...
> Options:
>   -b, -m                      Ignored for compatibility.
>   -B, --always-make           Unconditionally make all targets.
>   -C DIRECTORY, --directory=DIRECTORY
>                               Change to DIRECTORY before doing anything.
>   -d                          Print lots of debugging information.
>   --debug[=FLAGS]             Print various types of debugging information.
>   -e, --environment-overrides
>                               Environment variables override makefiles.
>   -E STRING, --eval=STRING    Evaluate STRING as a makefile statement.
>   -f FILE, --file=FILE, --makefile=FILE
>                               Read FILE as a makefile.
>   -h, --help                  Print this message and exit.
>   -i, --ignore-errors         Ignore errors from recipes.
>   -I DIRECTORY, --include-dir=DIRECTORY
>                               Search DIRECTORY for included makefiles.
>   -j [N], --jobs[=N]          Allow N jobs at once; infinite jobs with no arg.
>   -k, --keep-going            Keep going when some targets can't be made.
>   -l [N], --load-average[=N], --max-load[=N]
>                               Don't start multiple jobs unless load is below N.
>   -L, --check-symlink-times   Use the latest mtime between symlinks and target.
>   -n, --just-print, --dry-run, --recon
>                               Don't actually run any recipe; just print them.
>   -o FILE, --old-file=FILE, --assume-old=FILE
>                               Consider FILE to be very old and don't remake it.
>   -O[TYPE], --output-sync[=TYPE]
>                               Synchronize output of parallel jobs by TYPE.
>   -p, --print-data-base       Print make's internal database.
>   -q, --question              Run no recipe; exit status says if up to date.
>   -r, --no-builtin-rules      Disable the built-in implicit rules.
>   -R, --no-builtin-variables  Disable the built-in variable settings.
>   -s, --silent, --quiet       Don't echo recipes.
>   --no-silent                 Echo recipes (disable --silent mode).
>   -S, --no-keep-going, --stop
>                               Turns off -k.
>   -t, --touch                 Touch targets instead of remaking them.
>   --trace                     Print tracing information.
>   -v, --version               Print the version number of make and exit.
>   -w, --print-directory       Print the current directory.
>   --no-print-directory        Turn off -w, even if it was turned on implicitly.
>   -W FILE, --what-if=FILE, --new-file=FILE, --assume-new=FILE
>                               Consider FILE to be infinitely new.
>   --warn-undefined-variables  Warn when an undefined variable is referenced.
> 
> This program built for x86_64-pc-linux-gnu
> Report bugs to <bug-make@gnu.org>
> 
> 
> 
> Tested on:
> 
> commit:         8e929cb5 Linux 6.12-rc3
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git v6.12-rc3
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
> compiler:       
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=162e785f980000
> 

