Return-Path: <linux-kernel+bounces-198325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14188D76C2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D600B1C20978
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47E47A79;
	Sun,  2 Jun 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8ziF+pP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293A20B35
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342266; cv=none; b=abQGeOL6jQRClWmxOr3c1A/hSiL2Xqs6cLWMOR/FYYszo31iA+Fd1+eU4T5jH0REJ76vV8pn81ZFZVvH/tIDPc3R2K7p6HlToMDz4woEIP66EgL0ZMMr7OQbvjMvKk3RKDuKa74vlK9X3tdd3OVygfIYb1XwwsaZHBnuS4p2upY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342266; c=relaxed/simple;
	bh=iMrrITcYzd+RoOFIyCQD1UIiv8ZkY4HWWRv34mlMqzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh1PGD79NZS4FvLfXR3To0Qd16V5acP77C7b8RGOuuYZMMZ4JpRULbLwXiKx42IQWkHI6zu190GCl2+sy7sQuGvFtxbrcoJ/7DOjGiT8YiGC5UY5Ua23oFkT9CHR+8dLecX15CvgvQosp/5LUFlAv6dI3muODcf5ArFmiuy2n5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8ziF+pP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso3349967a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717342263; x=1717947063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aPeMRTLQP1kufJff6402SOGzLmZ5nQceAsLZPxwEQro=;
        b=X8ziF+pPIExQ79pCbYg9zVB+UEi+bYC2D2ZEaTmq1RDxORkp6hLNWKgx+KICNiCMHL
         Ox/DCekd9WvNZxJi15242Jecg1mA/uDKCPhN+A4nqKN6d/5genCRnOG20yoRV3IhWOA+
         nhOkPkKKXaxPhpDcscyFHq7ltoCTyvZv4gy9DQCa9ChGyZpF8uYOHgNmlr2YsBs2CjBL
         X2I6pRFt27+8900E2/CoyydT/xQc02X9WzisOsRM6SrucH74eUJI31LyyNl3pf2cFCrR
         lFSY9shfV19IxqFQI4p/+u1O4tkK+VcsyFTiprmf/gOD5DKEnDdkqk8BxfukbUmtz2JE
         wMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342263; x=1717947063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPeMRTLQP1kufJff6402SOGzLmZ5nQceAsLZPxwEQro=;
        b=gTPiN0IOuPWz/tLdRI2SdM70KrX39OKttCcAfZO25P9Fi2o0pUX1qDkg/5LNgqd5Po
         kwm2AYMsYzzzBNFDH3HL5UdsTVr+uNEHdF6PyBqRQoeF9b21x55NUWF4LQGyU3+Lrmoz
         jDOcmqjBhuH87Ks/8/0huC7bFViHFmNIPWNVvyWF+7aWcdetX+dtyNNWP/1cyVj3IErt
         sZIjcjVNexlDjdDyFEWulDEMu2BOxGsxw55WHht07B/5xiOwTxIXP89OtJRLty8NfKMf
         LS7rJO2ossqqA22XjCctNg0SKpm54N2BVz1BNzpkeEP/mEtCl13JCZb9NUf3OONKMbQI
         pKjw==
X-Forwarded-Encrypted: i=1; AJvYcCUZjPv4tvbLB3sco7xWKheg2ZcKr8BlD8tnt0QAP3szOWkmHKTQNcjxZ3NKDLIxZ17joY3JcT0k7CC10aSFFbzLnGuoTONYRub3QdLi
X-Gm-Message-State: AOJu0YwpvxZriXnTHiPlkxfKXG8+pt+ZP3RBKVi6defTWRx+O/WakMBM
	pQcHkmJkAbiLG79G3T9hvcRxZhd3+7ZUMu6ED82sxkNUhpGVa7td
X-Google-Smtp-Source: AGHT+IFnLY3CKJpeC281AVWzyFnvgsXkGBUU1G9iQxirdGcSeUBakZvGz4kcjbXwTw4aKyWcu75cIA==
X-Received: by 2002:a17:906:cf8f:b0:a66:5064:cc73 with SMTP id a640c23a62f3a-a6821f4e311mr456012466b.55.1717342262285;
        Sun, 02 Jun 2024 08:31:02 -0700 (PDT)
Received: from f (cst-prg-8-232.cust.vodafone.cz. [46.135.8.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a690057d2dcsm64341966b.4.2024.06.02.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 08:31:01 -0700 (PDT)
Date: Sun, 2 Jun 2024 17:30:51 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: =?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>, 
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org, 
	danny@kdrag0n.dev, jgg@nvidia.com, mic@digikod.net, linux-kernel@vger.kernel.org, 
	joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
Message-ID: <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
References: <20230601075333.14021-1-ihuguet@redhat.com>
 <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net>
 <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>

On Tue, Dec 12, 2023 at 02:50:59AM +0900, Masahiro Yamada wrote:
> On Mon, Oct 23, 2023 at 3:26 PM Íñigo Huguet <ihuguet@redhat.com> wrote:
> >
> > On Mon, Oct 23, 2023 at 8:19 AM Vincent MAILHOL
> > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > > On Mon. 23 Oct. 2023 at 11:28, Jonathan Corbet <corbet@lwn.net> wrote:
> > > > Vincent MAILHOL <mailhol.vincent@wanadoo.fr> writes:
> > > >
> > > > > On Thu. 1 June 2023 at 16:53, Íñigo Huguet <ihuguet@redhat.com> wrote:
> > > > >> EditorConfig is a specification to define the most basic code formatting
> > > > >> stuff, and it's supported by many editors and IDEs, either directly or
> > > > >> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > > > >>
> > > > >> It allows to define formatting style related to indentation, charset,
> > > > >> end of lines and trailing whitespaces. It also allows to apply different
> > > > >> formats for different files based on wildcards, so for example it is
> > > > >> possible to apply different configs to *.{c,h}, *.py and *.rs.
> > > > >>
> > > > >> In linux project, defining a .editorconfig might help to those people
> > > > >> that work on different projects with different indentation styles, so
> > > > >> they cannot define a global style. Now they will directly see the
> > > > >> correct indentation on every fresh clone of the project.
> > > > >>
> > > > >> See https://editorconfig.org
> > > > >>
> > > > >> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > > > >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > > > >> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> > > > >> ---
> > > > >
> > > > > Is there any news for this patch? I would really love this to become mainstream.
> > > >
> > > > I have concerns about this patch that I have expressed in the past.
> > > >
> > > > I'm not going to apply it... since it's a global change that affects all
> > > > kernel developers, I don't think I *should* apply it.  I would recommend
> > > > sending it directly to Linus; if you can get an ack from him, I'll apply
> > > > it then.
> > >
> > > Hi Jonathan,
> > >
> > > Thanks for the comment, message taken.
> > >
> > > Hi Íñigo,
> > >
> > > The last version of the patch being from you, would you like to bring
> > > the topic to Linus yourself or shall I do it instead?
> >
> > I'm not doing kernel development lately, so please go ahead pushing
> > this if you want.
> >
> > Anyway, note that, as discussed in the thread, it is incorrect to say
> > that it will affect all kernel developers: most IDEs and editors only
> > have "opt-in" support for editorconfig, and the few that are not
> > "opt-in", are either "opt-out" or has a workaround (Kate).
> 
> 
> 
> 
> Applied to linux-kbuild. Thanks.
> 
> We invested a significant amount of time in research and discussion,
> and I do not want to lose our efforts.
> 
> If it turns out to be problematic, it is easy to revert it.
> (although I do not think so, given the wide adoption in many projects.)
> 

So after recently switching to neovim I found that .editorconfig results
in messing up my diffs.

I'm screwing around in the vfs layer which has numerous pre-existing
whitespace issues. neovim proceeds to *silently* whackall of the stray
spaces and whatnot, which you only find out about after you git diff/git
show

You can try yourself by editing fs/dcache.c or fs/bad_inode.c.

It stems from this line:
trim_trailing_whitespace = true

The problem is dodged by setting it to false or adding this to
~/.config/nvim/init.lua:
vim.g.editorconfig = false

Is there a non-giant-hammer method to disable the thing? Maybe some lua
magic to special-case that this is the kernel tree?

Also note editing the shipped config shows as a diff to master, so doing
it is not that great either.

If someone could block new whitespace issues from appearing *and* sorted
out all existing ones, I would have no comments. Definitely not going to
try even myself though.

A naive/shite grep claims 840 .c files with issues:
find . -name '*.c' -print0 | xargs -0 grep -l ' $' | wc -l

As is I think the config mostly gets in the way and most people have a
setup which does not use it (for example my vim does not). Alternatively
maye it is neovim which is overzalous here and other editors don't treat
the entire file. If there is a way to convince the thing to only tend to
whitespace issues in edited lines that would be great.

I think the best way forward for the time being is to move .editorconfig
somewhere (scripts/ even though it is not one?) and leave it there as a
template for interested parties. Then people who insist on using the
config can cp and modify (or not) as needed.

I don't have a strong opinion as long as it buggers off the whitespace I
did not even touch or a solution is given which whacks this aspect, but
only for the Linux repo.

