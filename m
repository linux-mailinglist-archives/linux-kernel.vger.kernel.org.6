Return-Path: <linux-kernel+bounces-188087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8158CDCFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3958A281AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00AA128830;
	Thu, 23 May 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U57Sh1V8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D81128812
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504484; cv=none; b=GqzVlt3k+MPStQsx0BUEWE9cn9lNYw3iaSdUx3qPfY4F4M4e6lbXjE0fkf+nRar8veMkPzuX4Us+e24ZAAC+sb1efBeIh/kOTLoJ5JOMNiaMcQcfs5q/FaolHin4S+5CgWmvbyECdOLGYa/BA3TFD38DMcoR+tvFAvYv8VAK3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504484; c=relaxed/simple;
	bh=gz0PkwjZapZ313UpBb/0ZCcYeCPvCTVsQ+dYKgCkRYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdYQoyY6GlJOEsU8QV+7kpdnsoWkLc4aOgT+uB1amZiw51HfBI8miMwOwsmk7oFNA2ay75XVHnBGeeNpdyBizpeXs0GJ4sm0EZO/eSPEyJBGuOzsrAvKwukJK7Qmbwa8RZW1k/4ulsZeP5B17uwGgrmFgLfiEuTttn+XlOp9jTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U57Sh1V8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f3434c36baso8787205ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716504483; x=1717109283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA4oat8jyy3CDEKkZfrcdIUDv0o+HLO5NbY98ff+pUo=;
        b=U57Sh1V8YyODu9+AZPf+p+WnEA3anP4y64iyy/fes3u3L+Wcj81oCO8RFSj+/5Ae5F
         qxgbajzWSaQ7GstdM6AJ5MEbkOO2YKYeo8HvJN+JnPwyPROuYHy2bN2vPY5V4/Xuf4Zd
         BXTdKE690HlAerrTp56EUkJ0l5dUyrNgfDMxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716504483; x=1717109283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA4oat8jyy3CDEKkZfrcdIUDv0o+HLO5NbY98ff+pUo=;
        b=DMC7yLpsDn1VdMrXDmCays/TlFJxLYJtY6w0zhSSabdrg3imvXew76MELyeqEiJba2
         pB2hdAwTJydHlPEowst5/HZzQ6kS8HJGJUK94rZwZ3PRv0DW3ks9VMoPPgVfR0UxYtZl
         BDxQS+wjdZpS6Jj7TLjfUvusFJ3BNheAk51n/K6/cNHgCIFwGPCQHMERH7AQmsF+Wccc
         atnfDKW9exdbRioVXRpK9bxZEtE4stbVRyqHxAHj6O6SJ3iWm4dXDwgtVIFMIOA8VhIh
         HUbVubNcJjZnD4BP2O9dVErQCcRGrJjwUdcaP/fpPvHOint2WpUvOi0E4wyi1kQKxmQI
         1/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCeNX7u5RjWFLZRHGKWIM1BZ9fFte2ScKqyuvnGgw4HBCT9pXyZ5nJ6I6vHEHO466qt7kJoLMRUnJKvA/blDN/ckh9eP8wsujTTeJN
X-Gm-Message-State: AOJu0YxDMa0d6f1nRHBEnlpK8gOyfKmM6B78QUSQi1vVDZm2HO5lRsKd
	iVeEDj26y143+/FFbpLtfh5A/CE+AUQ618V8PLYdorSw31zGn8hECU7dpXvAlQ==
X-Google-Smtp-Source: AGHT+IGJGZpQ4rf9EhpaVQHn1iwjcML//bMqKC3QEgcf7g6/WJcRFjAa7WIIEUgfb/nq9jE8JKVYSQ==
X-Received: by 2002:a17:902:cecd:b0:1f3:35e8:d309 with SMTP id d9443c01a7336-1f4486d9f35mr8074405ad.20.1716504482757;
        Thu, 23 May 2024 15:48:02 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9aa1f1sm942125ad.241.2024.05.23.15.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 15:48:02 -0700 (PDT)
Date: Thu, 23 May 2024 15:48:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: syzbot <syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com>,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __fortify_report
Message-ID: <202405231540.84B3DBE841@keescook>
References: <00000000000019f4c00619192c05@google.com>
 <20240523130456.GH65648@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523130456.GH65648@mit.edu>

On Thu, May 23, 2024 at 09:04:56AM -0400, Theodore Ts'o wrote:
> On Wed, May 22, 2024 at 11:29:25PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > dashboard link: https://syzkaller.appspot.com/bug?extid=50835f73143cc2905b9e
> 
> > ...
> > strnlen: detected buffer overflow: 17 byte read of buffer size 16
> > [<8080fe10>] (__fortify_report) from [<818e9a40>] (__fortify_panic+0x10/0x14 lib/string_helpers.c:1036)
> > [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (strnlen include/linux/fortify-string.h:221 [inline])
> > [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (sized_strscpy include/linux/fortify-string.h:295 [inline])
> > [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (ext4_ioctl_getlabel fs/ext4/ioctl.c:1154 [inline])
> 
> > [<818e9a30>] (__fortify_panic) from [<8062a3b0>] (ext4_fileattr_get+0x0/0x78 fs/ext4/ioctl.c:1609)
> > [<8062829c>] (__ext4_ioctl) from [<8062aaac>] (ext4_ioctl+0x10/0x14 fs/ext4/ioctl.c:1626)
> >  r10:836e6c00 r9:00000005 r8:845e7900 r7:00000000 r6:845e7900 r5:00000000
> 
> This is caused by commit 744a56389f73 ("ext4: replace deprecated
> strncpy with alternatives") and it's unclear whether this is being
> caused by a buggy implementation of strscpy_pad(), or a buggy fortify,
> but a simple way to fix is to go back to the good-old strncpy(), which
> is perfectly safe, and perfectly secure.
> 
> (And this is a great example of "security initiatives" being an
> exercise in pain alocation tradeoffs between overworked maintainers
> and security teams...  regardless of whether the bug is in fortify,
> syzkaller, or an effort to completely convert away from strncpy()
> because it makes security analysis easier.)

It looks like this is another case of a non-terminated string being made
terminated by strncpy into a string with 1 extra byte at the end:

        char label[EXT4_LABEL_MAX + 1];
	...
-       memset(label, 0, sizeof(label));
        lock_buffer(sbi->s_sbh);
-       strncpy(label, sbi->s_es->s_volume_name, EXT4_LABEL_MAX);
+       strscpy_pad(label, sbi->s_es->s_volume_name);
        unlock_buffer(sbi->s_sbh);

This should be using memtostr_pad() as:

	memtostr_pad(label, sbi->s_es->s_volume_name);

I'll send a patch. It looks like __nonstring markings from commit
072ebb3bffe6 ("ext4: add nonstring annotations to ext4.h") were
incomplete.

-Kees

-- 
Kees Cook

