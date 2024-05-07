Return-Path: <linux-kernel+bounces-171041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CED8BDF0C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4CB25D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDCC14EC60;
	Tue,  7 May 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V0dSg1IF"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0014EC49
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075712; cv=none; b=QfF2mubz93NKfLzWfdsdtSoJs4+1vXuTlZQfL6pKFAxO2oryjsOc0z0NbeVgWsqKmkHV6dyzZ550DW83tJnSspFvd0IlXWGZeQYFYS5t6Tosm3l69T+jdU4Ui5qnD9OR0wUqvvaqcn5z/CF/SLr/KfNY/imAMjKgXGYmVxcGnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075712; c=relaxed/simple;
	bh=ySzqAdBy3XIuOsN+4M43h3v/XUU1e6byy3HPdS66zkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2dLFCF8QWU23f85m1PbqAWuIvmqqpRUKDxbB80mhzPqZiKw8/su8sTMqqXnsCSoJy84RJHUHtvegfHL4eHfN58InC8yihFbsThr6ukN0Tmx0gfyNuuFKnQpbzt/NsVKrAtxlQB+fnXigswrw4y49Nb5Iae3GlJrsQhWUrmB0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V0dSg1IF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34da35cd01cso2676654f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715075708; x=1715680508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhfsqJjab/igtBSwSRfO0D4527C8EIUuYcZOQelhvBc=;
        b=V0dSg1IFxe1jQLFl2gadot4iA8yd3gwclG6/dmeZr0pa7k1QonT/afNaxbtj/T6yE3
         F9C/uwty+h5F7YrQuOHKzclX+XKDHf8omtL8PFGzXyVUWwhOzUfO9aW9xeozf0P4U4pU
         QyYkYngC0x6FOwWLtImJJWejto4AHVIKin5dfB8EE1kLAPWYFkHs4JC/YYoh7aEQ4CAf
         AB9X+5AY1g2h1xqGSdN3QZ8pexdubdNPFxqYhmTtB4PQkmWuFEQ0e4nzSlJEpoq1U6ZV
         m/qDyaKEh+MA7/Hg9ce2QuqVWt7CT1ujyoAkRWh/xJ5FghGTXcaNRr86e65vA3D8bl/B
         wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715075708; x=1715680508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhfsqJjab/igtBSwSRfO0D4527C8EIUuYcZOQelhvBc=;
        b=O+5276yYliV4uch5IeiUi9FZM5s8p/VOCCylx/5wIXHqvY2HqqIh+NLn95H3l6pcO/
         SzO5pLbhO9SHAZl+mxnSLeYPY+Cfye5Jo6pe84QRSn92RU4j3uhl8yjc51EYWBLiy9Ui
         6Yz0ZjRTtZl5owV3xugxzI7Xo49FOgjTHxHxkzrnHveQw/MXmLv3JKR8V+VGp3NFc+eI
         WTwgNhK09U+ZL8XAphifkC2cdEDdSmR7zV3bYyMu1UHBBPjoIRI3a2p0LNnc7bRdllb1
         UvtDNmOhyqmhlg//DtExz6mtaY2dLQ9OgCjxWwBxEUHoURKdBGbpINZvNdlYaXMCPv+n
         PwZg==
X-Forwarded-Encrypted: i=1; AJvYcCXJpcxPXmpxUnSE/h7+sLZ1cpu11Wk8DyY2DcUTbZNZbtmOH+9WLiqGi46cb+bsi/xpZh+veXQSDyUKXi3yOO6bTvLoW0IerEomHAJo
X-Gm-Message-State: AOJu0YzsCG2UwxZpm1hix53dmGX/ceKRinifZIA7NU5Cvck248P1ZZXw
	fVcWh/bJO5zQ/cDpadD9kvFDleTvnWTZJ1eOhLjvAanhAJgXWqOc7jDcmGjRXHs=
X-Google-Smtp-Source: AGHT+IEnX+GiP1H1R7a/PVZu6gZKW9nIWDfc/aLhP5NK80VEMsnFZNqObUfhm9M51FbyUiTT3ER0zA==
X-Received: by 2002:a5d:4903:0:b0:34a:beb3:f6dc with SMTP id x3-20020a5d4903000000b0034abeb3f6dcmr12404727wrq.2.1715075708291;
        Tue, 07 May 2024 02:55:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b0041c5151dc1csm22844866wms.29.2024.05.07.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:55:08 -0700 (PDT)
Date: Tue, 7 May 2024 11:55:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
Message-ID: <Zjn6ejJ9ecsuGsK2@pathway.suse.cz>
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>

On Mon 2024-04-29 23:06:54, Justin Stitt wrote:
> Cleanup some deprecated uses of strncpy() and strcpy() [1].
> 
> There doesn't seem to be any bugs with the current code but the
> readability of this code could benefit from a quick makeover while
> removing some deprecated stuff as a benefit.
> 
> The most interesting replacement made in this patch involves
> concatenating "ttyS" with a digit-led user-supplied string. Instead of
> doing two distinct string copies with carefully managed offsets and
> lengths, let's use the more robust and self-explanatory scnprintf().
> scnprintf will 1) respect the bounds of @buf, 2) null-terminate @buf, 3)
> do the concatenation. This allows us to drop the manual NUL-byte assignment.
> 
> Also, since isdigit() is used about a dozen lines after the open-coded
> version we'll replace it for uniformity's sake.
> 
> All the strcpy() --> strscpy() replacements are trivial as the source
> strings are literals and much smaller than the destination size. No
> behavioral change here.
> 
> Use the new 2-argument version of strscpy() introduced in Commit
> e6584c3964f2f ("string: Allow 2-argument strscpy()"). However, to make
> this work fully (since the size must be known at compile time), also
> update the extern-qualified declaration to have the proper size
> information.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

JFYI, the patch has been comitted into printk/linux.git, branch for-6.10.

I have removed the obsoleted brackets and added some empty lines
to break the blob of code a bit, see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.10&id=e0550222e03bae3fd629641e246ef7f47803d795

Best Regards,
Petr


