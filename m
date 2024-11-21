Return-Path: <linux-kernel+bounces-417292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574159D5218
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF4A1F228D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D819DF62;
	Thu, 21 Nov 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MCg5O+gQ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FF1482E2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211244; cv=none; b=ThvT8UtZioE/+xruXJ3t2izP7cfZ310DTXQ5R4aGDbfoQ4inpnmrSzkgCSjXbmWo12Ebw+lxTWhVYqPfmHXYc82m1+Z+y0aZsmVZr7K/FbdZTjaeOVa02mr6oRvNOBCTOljPteYBDfiHBC6Hf5Uafdf0XHNT3QY2ylpoIkhNlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211244; c=relaxed/simple;
	bh=B8qy8Q/n5MDwBgCK9TorilYKi+CojlmuzgfSg2SeO+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5y1xFfp8VtEYgX5gNe058xU9T4fRGj8OfDNG/LdqjnFy9pRz+ySYcTD0kyzz/nERvoIu3q4WUxZvnhVYCQc9GGWP5a9VNZc7mXepZjYkPoCpX3zt8SU7UnUHtUB5n41P3XG9lPUTw4q6+EqULecp/lvu/LjB2pLQYVrQRDfDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MCg5O+gQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfaa02c716so1583906a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732211241; x=1732816041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XA/iJyNnc5nTicmbbrtzlzZcZnraDIPDaCwbOdD4hKk=;
        b=MCg5O+gQ1y+gowGXUag4CUYWF1qc1a8+CIKmE2TBEGn4MvRozsWUHyw77CmfShADjU
         FfhGEWUzAHbBBbl/sfyyvQ29xbuGG96rRVUSrCTkJ/Uinwk5cOZOQE3yXvonLsZd+Y9u
         H/7caoV5xVnZ/o5z8ghFk04ULXqfTdPLWnsi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732211241; x=1732816041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XA/iJyNnc5nTicmbbrtzlzZcZnraDIPDaCwbOdD4hKk=;
        b=MXhA/jeBUf9OeOKqKGkfwwlQVjBYuu09Enan8evNoxpbbVrOIsf7uOEi3oZAr7Dujc
         pHMitp/2lnamMnt/KtyVCoaIt5cneN00Dwx3dQ/cl1RrTRyziAIygDC54q/aF7UbhrsU
         35H0eKSgwXqtwrjKb7gicbr5fLJpF7aho0C3/K5qHi6hL5Ehcg+oLzzdyhO23CLGD7p0
         JT3Qa6iLIgHS3Bdb9YC1Uh/tH9VqLZIFd68D0jG0xmxTQaIQA48dxHxHDuYPrDNEwwuL
         Z9TdGe7DsEUi/GPQR3bwD2sWQNwje8zdKmiE8BPvAL8TBMYQb2P28yGjT0Zo7f3rYPLW
         fteA==
X-Forwarded-Encrypted: i=1; AJvYcCWU7/6XkLjmXd86UlJANzuKHNCEtPTJBGrAYGYinJ1JFdQToP7Gxf3n3HTEFS42PN2m4ydvv4cTscoLGAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfbm47rDbuhFj3xRxspZxvJwBGdS5J6yhCpwuxQr3n9wNuiC+7
	6muUgehszTPi9XwwVuZ5xXV4p0UeA6FiPUfZTwWBeeux3C7zUznsC6tZWrp6eFKBUkXGhdL6gMb
	BgO8=
X-Gm-Gg: ASbGncuSANiOSjim4oBNjAdV03e1bB+iiFLq+5YrAocH7C8Cu+XwW8N2sn6WcztVEyH
	nxKpEUQsYp/JrYgH7tkQQhURuo0NDLZpTF8XidDsPz/ROJ78uXgzzbHAjz7+p5Dx42sepJGMfsJ
	nNVXGPeiywcH5owwO+3TYWlYA+P/IlqE4AyUIBx+VqjPFLn7JuBRjDZua/GGjPOpQMMKs/sJEPq
	622hX8EjRAbMNVmPVIMlml0cEvPPGwGxcue0E5P936HXQWZ1X8AJSTeQdCSJ4lnHQ0V8MhnqWVA
	ImJQLtn1loletdumCjGCDb/6
X-Google-Smtp-Source: AGHT+IFEcKQwCF/QLk9m+VXT3JMO1livpJa+zzJtrxgqlvnmum5w8i+Td0X/86nvZ+UPnKyZEl/8xQ==
X-Received: by 2002:a17:906:3101:b0:a9e:b287:2813 with SMTP id a640c23a62f3a-aa509906366mr6043366b.5.1732211240763;
        Thu, 21 Nov 2024 09:47:20 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d33e9sm104125466b.94.2024.11.21.09.47.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 09:47:20 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a68480164so182628966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:47:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC8zHqP6otFNQHjQpCji9+iEJVDgkNJSJxXsClSUyX5VeI2XWfAGAIB1j8pszDMAAESXqZo8TrLGrrKW0=@vger.kernel.org
X-Received: by 2002:a17:906:3188:b0:a99:ffef:aec5 with SMTP id
 a640c23a62f3a-aa5099393a2mr4495266b.23.1732211239821; Thu, 21 Nov 2024
 09:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl> <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 09:47:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzKjzbZQ9a-ZvRFwj6X_wsQvNjiizyCzTryEQnZc_47A@mail.gmail.com>
Message-ID: <CAHk-=whzKjzbZQ9a-ZvRFwj6X_wsQvNjiizyCzTryEQnZc_47A@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 09:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See? There is no single solution, but at least the dentry name is a
> *reliable* thing, not a random garbage thing passed in by user space.

Note that the reason I want 'comm[]' to be something actually
*reliable* is that that is what the kernel actually uses for various
error messages etc.

User space tools like 'ps' already do the "dig around in user space to
look for argv[]" thing, and tools like "ps" do *not* actually use
comm[] at all from normal user space programs.

For example, why do you think "ps 3545" says

   3545 ?        Ssl    0:00 /usr/libexec/gnome-shell-calendar-server

but when I do "cat /proc/3545/stat" I see

    3545 (gnome-shell-cal) S 3129 ...

in the output?

That's exactly because comm[] has that "gnome-shell-cal" (limited to
16 characters with the NUL due to TASK_COMM_LEN), but 'ps' will go
digging into user space argv[0] by looking at /proc/*/cmdline which
gets you much more than just the name of the executable.

And I do *not* want anybody to think that "comm[]" should act IN ANY
WAY identically to /proc/*/cmdline. It never has, and it never will.
Exactly because the two are completely different things, for different
uses.

And yes, people have historically actively messed with the argv[0]
thing, and actively tried to hide what the actual executable was.

I am not AT ALL interested in letting people play those kinds of games
with "comm[]".

There's a very real reason I rejected that original execve() change.
It was stupid and wrong.

                  Linus

