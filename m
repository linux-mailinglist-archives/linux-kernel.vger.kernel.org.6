Return-Path: <linux-kernel+bounces-180521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D78C6FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDA31F220AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7E6A47;
	Thu, 16 May 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="tCQwwYOG"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F0620
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715820048; cv=none; b=BDZRQOX3rm+PqK2+D+oWEqtFyHHCaMScUXujqldbsS5XPF91ZPKRRTkg6kqrWH6yKok9eVaqprp/W3x+iHaHK7vklLfx5SdTXT6IkT8Ux/J6ZxcvIET6vZuwiMu1b002MpOWuBVuaCSsun+HFO9OpGhjzKc6LG/35L+IihzIi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715820048; c=relaxed/simple;
	bh=9abLEE+9ZCkj45X/8sGs10BG0//YdgH1IRIHDBUOCpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMmk6niJiaVr9Y3S3BjfRDvVEdaNSuAbVClABW1ou2dpXR/z3JGla7YaH9zFCXHikR7Rtu5ymJ3i3nKVu5s4fycnhlofMQyqK/KdyRIZ8LjpZtA5PJYxKf+LkWuhGYmi/hF98DdqPUTNbOStPbWzePNbHzsJI9dZ98XJNc8pdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=tCQwwYOG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=WLRrFtSftIZp/DIoV6uP1EDdzLDN/HEm8dpl8avsW7w=; b=tCQwwYOGDtu1rcX1
	EgWov9eVBuKiTRuCZbT5GWgcCMNlk+tX8+pl2yAfdXTkl5dDum28eWjXFnJXGSdKyE8Tnb8k6qtbA
	HmXJqBTaDsIGpNKOqXrVS8WCgTqCi/owCZb3Cyy7BrBZh9xtsNBEBzMxOI2TSZ29015geBvriXKNZ
	dMj3OYaHBpZwDRwlUFBNzA1qHSWME88zOrZKY2j0GHbOHF9/XFuDEsuiVO+cMxkxzmTpVDEv/Dfaa
	Q/aMRCUt0S4zXfcOLsxT8g0xlQhfwKnbBqs8mVoZCrgDx2mDnWMGY3AX2BLIaoQb4xE+ayuwTULT1
	lHogLdhskfL8Xh+ubw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7PAm-0019Js-0a;
	Thu, 16 May 2024 00:40:40 +0000
Date: Thu, 16 May 2024 00:40:40 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, nathan@kernel.org,
	luc.vanoostenryck@gmail.com
Subject: Re: thoughts wanted on dead code hunting?
Message-ID: <ZkVWCOZDb7iewLxL@gallifrey>
References: <Zjy82Ja6G2iIHl75@gallifrey>
 <202405141706.1D5D26C@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <202405141706.1D5D26C@keescook>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:17:07 up 7 days, 11:31,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kees Cook (keescook@chromium.org) wrote:
> On Thu, May 09, 2024 at 12:08:56PM +0000, Dr. David Alan Gilbert wrote:
> >   That's found me ~200 candidates; where I guess 150ish are probably
> > real; but my hacky script is, well trivial and hacky, so they each
> > need eyeballing, then a git lookup to see why they're unused, and a
> > compile just to make there's not some subtle macro somewhere.
> 
> Nice finds! People are usually big fans of code removal patches. :)

Thanks; removing the LIST_HEADs actually saves bytes in the binary;
just removing the structs themselves still cleans up the source and
occasionally it's noticing something else left along with it.

> >  ** Questions:
> >   a) Can anyone think of a better tool than my script (see bottom)?
> >    The simplicity is a blessing & a curse - it doesn't know about
> >    #ifdef's so I don't need to try lots of configs, but at the same
> >    time, it can't tell if the struct actually gets used in a macro
> >    and I have to eyeball for a struct which is assigned to as
> >    a variable at declaration time.
> 
> I'm not sure I've seen anything better.
> 
> I tend to use stuff like Coccinelle (spatch) for finding specific struct
> usage, but it can sometimes be slow when trying to process headers
> recursively. e.g.:
> 
> // Options: --recursive-includes
> @find@
> struct to_be_removed INSTANCE;
> struct to_be_removed *POINTER;
> 
> (
> *       INSTANCE
> |
> *       POINTER
> )
> 
> 
> (I bet this could be improved, but it should be a usable example.)

Hmm, now if I could use coccinelle it would be more tolerant of coding
style and slight variations than my script.
However, trying that tiny example, I get:
  File "play.cocci", line 10, column 1, charpos = 141
    around = '',
    whole content = )

so it seems to be objecting to something at the end of the file?
I ran that with:

make coccicheck COCCI=play.cocci M=arch/x86
with Fedora 40's coccinelle-1.1.1-30.20230624git0afff7f.fc40.x86_64

> So this might very a given struct isn't used.
> 
> >   b) The dead structs are all over; so they've mostly been individual
> >   patches rather than a big patch series - how do people feel about
> >   another 150ish similar patches ?
> 
> Generally the smaller patches are preferred. For this kind of thing,
> though, I'd probably collect them by individual header files, rather
> than one-patch-per-struct.

Yeh; although note so far I've only been looking for unused structs
that are defined in a .c file rather than ones in headers.
Those are relatively easy to find, because I'm only looking in one .c
at a time (although that does hit corner cases like:

  header:
       struct foo;
       struct baa {
          struct foo *p;
       };

  .c file:
       struct foo {
         stuff
       };

       func(struct baa *b) {
          b->p  something
       }

  so foo is defined in the C file but the symbol 'foo' is never
used again in it.

> If you have one giant patch, this tool can help break it up into
> per-subsystem patches (it isn't perfect, but does its best):
> https://github.com/kees/kernel-tools/blob/trunk/split-on-maintainer

Thanks.

> >   * There's a few cases where people have added 'static' to a variable
> >    to cleanup compiler warnings, but actually they just needed to
> >    delete the variable.
> 
> Hah. Yeah, these are nice to find and remove.
> 
> >   * A harder problem is unused structure members; some I've spotted
> >    by accident, some follow from what else I delete; e.g. if you
> >    delete a LIST_HEAD, there's a good chance there's a struct somewhere
> >    with the list entry in it that's no longer used.
> 
> This is especially tricky because a giant amount of structs in the
> kernel actually describe over-the-wire or on-hardware structures that
> maybe the kernel doesn't care about all the members, but they're still
> needed to keep the layout correct.

Oh yeh; and also I'm not deleting unused struct's if they look like they're
describing some firmware or hardware struct, even if the kernel doesn't currently
use it.

Dave

> -Kees
> 
> -- 
> Kees Cook
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

