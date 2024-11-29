Return-Path: <linux-kernel+bounces-425230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F69DBF19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0BA281B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1E155725;
	Fri, 29 Nov 2024 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YcJZyXU2"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25E22EE4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855474; cv=none; b=J8nVYV7MaDohQpYbycO7wbfGkGipV0yH+RS+mefdoeTvI/BYKVNJYiMPZTKPsRFy7OljLwOvVHu6/GdXrw20jH443laFLbaxs5e971ulS5GDZvnA7o5Ybgyeis0USkhHiv7f/EfZEBdWmXpqHmQzojsK/xIk1+z/OArJ4RwT/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855474; c=relaxed/simple;
	bh=ZnjNLzuTqDqRjAG/pFmZMcN8sWHjm1XwqVKDzI3E9So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLQuuL32JEcrFFd4C+mxNhWOIDpgbyqusujnG/u8FopSAfre0tnP9+IIC0AFPyWg4GCNAzGYWQCVwC9tEKdS4Pxuh3hTCvN49+Trun5bDmNLM5oK+9IuUoHFJ+l/dzQEKK4GYWzUV8D8Ps6xziZCf1VXkwQYDx2CPkUfUwBYAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YcJZyXU2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cffb4ff85eso1676125a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732855471; x=1733460271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEsv50wWPwi2w4Uw+MIOu9zN+8+kyUlL/Z0oSIDrlYA=;
        b=YcJZyXU2AFuSMeBbg4MEquMkKQKLEOTlKq/fJeCk72cLw2tZJ8LjXpT7xYKYJyRNJJ
         YkE7tWwStRlq3GYMbAyfa2TtA1QMd5OaoiRojCetXRHspLQCv8E/4IW5RqChKeP3jdp4
         mSokzgx362ckUMUa+w+7DELEDgqEptbd/8m1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732855471; x=1733460271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEsv50wWPwi2w4Uw+MIOu9zN+8+kyUlL/Z0oSIDrlYA=;
        b=ws8Et8vxbSXUtvV9IfrUwj1nUH2W9Krx2yyEfPGp9vlcktAOIgkt8xXtDdQ1v5WQ4v
         nyVWnwBtZiBHnG2J0iEPorpS/e6icOaLQTSTqdxvD30mXMpTwttiRPmduv37UxG28DgQ
         nAjjIysqyafYmKHH3D3fTNbbtmVZ2sbdp8PNCwENhLt3OOMtsNQxZwHJrHZqlNiwg0xq
         2cuJXySTr3UL3eyKaBfTlbuTxo5ClbUmrAjZpBAbPle5YoemCTkxblkwHbkzMZ1HDBzy
         +r5PnShLrp6f6hSVfVyX++U7Lj1yj6jctntiI81AJcsTVOh3gTevI3cfVvx4jZAK44Nl
         Q03Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV2w9LXYIeGFVNnCqwkotjM8kgwRVqP8vCA0CdEOgfhNZMyrlxxgPX/CcrVyUVBhfWdcnK1LDeMdxwwyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5fgyHowz+HXbwlJJtuqRRnRclyqG4V/X9k6D0Qnv6AGoCygm
	0Nesh/+BVALnvJpZoJRwIUGBVqNHg01XyobdIKUeOCFM/6yeHaPLDfEePC+ALxcZe5TkSJiPfzM
	rwuJBEQ==
X-Gm-Gg: ASbGncvhBf706LPxu0ikyR56rvWRM8gzy96DdGtFjlzECHAIHKMmPX5pwKOrLpxpTzQ
	lkySJipHnZhGS8FlOCfMiia+A0Hb7Bpsz7ifyLG4hJQSTQpK3p0O4XZZQQ5ZviyLnwBIiiRA48Y
	qIEke5U8qZXT7KybUK6QLx7ykbssfxQwId56rw26xitufiRUX27Ii50dOz52awTkPweQ9tVasB4
	87RAnuIvGadetertTCtoRPKfpW/3OyJaMt/SG3kNY7nC+ytE2beufYjOnSvws0KH9ZZcGwCS9vq
	CRpheeq55sEbX/qEdy4Nt2kj
X-Google-Smtp-Source: AGHT+IFsAoRGRFw6gmV98d9cbo8Ug6soTxNWe/h4n+R4jv4A8RuHD1rHQLKsOUiS594zEQsV+XkEOw==
X-Received: by 2002:a05:6402:3217:b0:5d0:b7c5:c409 with SMTP id 4fb4d7f45d1cf-5d0b7c5c748mr674354a12.14.1732855471021;
        Thu, 28 Nov 2024 20:44:31 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0979cbcaasm1418756a12.0.2024.11.28.20.44.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 20:44:29 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa53a971480so190794766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:44:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUv/AYtZp9FwGzkYvdFVtixjX554vREISKXOh3zZMoxA2DYm01GcVuFaSq+O9sdEHLKRbFN/CnY9U/T+CY=@vger.kernel.org
X-Received: by 2002:a17:906:3198:b0:aa5:274b:60e4 with SMTP id
 a640c23a62f3a-aa580f582efmr818673066b.29.1732855468302; Thu, 28 Nov 2024
 20:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org> <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook> <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV> <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org> <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
 <20241129033419.GI3387508@ZenIV>
In-Reply-To: <20241129033419.GI3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Nov 2024 20:44:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
Message-ID: <CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 19:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Just one thing - IMO we want to use the relative pathname when it's
> not empty.  Even in execveat()

Oh, absolutely agreed.

Good catch, because yes, I messed that part up in my suggested patch at

   https://lore.kernel.org/all/CAHk-=wjF_09Z6vu7f8UAbQVDDoHnd-j391YpUxmBPLD=SKbKtQ@mail.gmail.com/

which did this dentry name thing for anything that used a base fd, but
yes, as you say, it should only do it when there is no name at all.

So instead of basing it (incorrectly) on that existing

        if (fd == AT_FDCWD || filename->name[0] == '/') {

test, the logic should probably look something like

        if (!filename->name[0]) {
                rcu_read_lock();
                strscpy(bprm->comm,
smp_load_acquire(&file->f_path.dentry->d_name.name));
                rcu_read_unlock();
        } else
                strscpy(bprm->comm, kbasename(filename->name));

and it probably wouldn't be a bad idea to separate this out to be a
helper function that just does this one thing.

           Linus

