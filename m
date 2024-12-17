Return-Path: <linux-kernel+bounces-450011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92B9F595E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBEE1896EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76CE1FAC33;
	Tue, 17 Dec 2024 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dt3B9Gv7"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F91FA8E5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472805; cv=none; b=iIgCstyl10IWaVPDfMV91zL2/2CWN5Xsu21fJ3WBQmKuA2VFG+92FkVQf+avsBAOECwM5E4A6QXW5+zxvZDhvhmGCqGxWiUQsU9Jxpbh6nFwAWw/rl+TzArTxG3CmErge6UxXFtQbSUTsJh+w1oRLCkfVd5vklD2L6ebDSxTflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472805; c=relaxed/simple;
	bh=RX/zhaiq0L9l8ly9a3z2OFOaSe+5bBHH/nUVnvYlvXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU7CWL1YMmrlgtvGTBGl2b4gJQbu87C1aoK3ipmnp2ogbNXBTAMD5nzEzfpHWlEMAHsfeqJGxtZvfLyAAnkviaylfua5mQ+UZZgbZx2pjgmny6yZzm9uN28YL/NPO/vZdQquL0eaLO8sVT5DxWxwz3lG01bPffhaFvZ5LqNow50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dt3B9Gv7; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso4031690276.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734472802; x=1735077602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftdzShgtX/tEAx6aAhp++i3l0eubtYOM8tBAmWgBMfE=;
        b=Dt3B9Gv7TgfxnTpwvvWDpvMtVKgCNSQXIdGn2cDp+WAZiKRU1+Sl/btlbAFtGJkDUO
         7ftqo0GX7GV56dIB5CAnJpTKDklKfL+QMPnD9LTGlnSegpXwB/SCiJTFFrGEfBUV40Z7
         DdaTSkT0YtYdhuzZrNmdGfw5C+JSoxdJNeaXdP/Et2vZENVZBahV+7cllhWFoupSHCPn
         aibJhEsPsPcWRs4yMiS060XWLD25cfNreE9Y4eU46v9cCgKS1inNqsjwXYkSIrMrCUt7
         TFOzRLfz5qVudqD4DUme7zAI96PPs1eTO5ZFOn/mwyaUzitABONMhcZyvqkOt4A4SEvP
         afBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734472802; x=1735077602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftdzShgtX/tEAx6aAhp++i3l0eubtYOM8tBAmWgBMfE=;
        b=wD8YWUDkLzhA69uTbuG7kvGn7Tk8FdEXc2znursDDswo68n+slc5UM5CMLxn5jucHi
         2iEeybvqkOAJPsd5CAsD53SNhqBa3KupScNIOhzXtXmobwAZW6SDUCuFRVVa7gee5z4R
         2XgI6JURqA7FkDQmNWNH3H9EI5rHVFAyLHLX7qZSClcOBsqBdrCyLLv49wpk7jUEQTxA
         stq2AKIuZ5r9lbpsFyNd+vaEcuhzQoPcgzLKSVIc8s2aQ0YR+uAqZdM8HaaSM53KBl6I
         qIiMrOtYUJA4kUroXaZISmO1MVbsJKmnUX6GKRjRQ6DJ4NFwvhqSjlQyjwBJqJht/Mft
         DMdw==
X-Forwarded-Encrypted: i=1; AJvYcCWKJaDTdso27H0wUNa/KfaakrK1A7jVcWUdVBkjHsJuaFbmsI3+M+TDe8HJI1Ql6NV3C23GT765aboKrdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvqo6+HmGDA42s0WJqDyrviXmeA+XbUDxQAfa7cK8H/i8N6oB
	2ljCziifhK6nyYlzvBbjCrgu+e8Jcq/yMUe+jzMnKJa/izG/sYPwLki5lX05wwnAkr0BsVgLNAu
	sAhf+Neq/nnRyyHKSlym8cyL2Zmd1sfKN17El
X-Gm-Gg: ASbGncvc35cMw1rjN9o8/GXUpivycIyXqznNPx4uPTdxzo7SUeYIqYfx8rnlE/aQkr0
	r03r5o7cI3L29rhV8iFIp+3NaaiQjW5z52MnP
X-Google-Smtp-Source: AGHT+IEU7ZqkpQLdLUs+NmpFyHzcV/krv50XAmUj5bf5ADbtRq+UVr88p+tUmkW66IRG+xuXXznG0o19SeGqPqHFkkQ=
X-Received: by 2002:a05:6902:2204:b0:e2e:440e:d29f with SMTP id
 3f1490d57ef6-e5362122e49mr679348276.20.1734472802619; Tue, 17 Dec 2024
 14:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217202525.1802109-1-song@kernel.org> <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
In-Reply-To: <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 16:59:51 -0500
Message-ID: <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	serge@hallyn.com, kernel-team@meta.com, brauner@kernel.org, jack@suse.cz, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:29=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 12/17/2024 12:25 PM, Song Liu wrote:
> > While reading and testing LSM code, I found IMA/EVM consume per inode
> > storage even when they are not in use. Add options to diable them in
> > kernel command line. The logic and syntax is mostly borrowed from an
> > old serious [1].
>
> Why not omit ima and evm from the lsm=3D parameter?

Exactly.  Here is a link to the kernel documentation if anyone is
interested (search for "lsm"):

https://docs.kernel.org/admin-guide/kernel-parameters.html

It is worth mentioning that this works for all the LSMs.

> > [1] https://lore.kernel.org/lkml/cover.1398259638.git.d.kasatkin@samsun=
g.com/
> >
> > Song Liu (2):
> >   ima: Add kernel parameter to disable IMA
> >   evm: Add kernel parameter to disable EVM
> >
> >  security/integrity/evm/evm.h       |  6 ++++++
> >  security/integrity/evm/evm_main.c  | 22 ++++++++++++++--------
> >  security/integrity/evm/evm_secfs.c |  3 ++-
> >  security/integrity/ima/ima_main.c  | 13 +++++++++++++
> >  4 files changed, 35 insertions(+), 9 deletions(-)
> >
> > --
> > 2.43.5

--=20
paul-moore.com

