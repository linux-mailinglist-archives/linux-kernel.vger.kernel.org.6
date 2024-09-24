Return-Path: <linux-kernel+bounces-337431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F46984A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640D428410F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82411AC427;
	Tue, 24 Sep 2024 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VrPQLwkT"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BC1ABEBD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197056; cv=none; b=XQMFXfCpSwOqP6wEwI9tFX/IVGTeAmjozxDerWD36AAFO3B0iD/rhby//E6KacJFSARQs2yuYz4c6xNyHw/6iLfndq4SBoWxauo/PRHzr234P4ftrMVyFaRIJih/TITIduCeYqW6fl0TeVxolzXvtQjrjngss3r8S+GDhkUkh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197056; c=relaxed/simple;
	bh=bItl/gYVHfFmT4Id2cNUR3ZjWbNemA/mNpGur3LI3no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efvaPecOmZxha/2IpjFlwA8Haggpaq+PiDZzvUtEDhLbuT3EjKla734a6ZPiMBfdx0ff7WkUczF3MlJyTMk/GV4mTgIVgklpetoa1OYg6eHjpaWmmmcjIxhGgNvJrJHtM/eEpIbo2W4+dVS59upzL6S2YoXpdi4dhJP5tJur6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VrPQLwkT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso9117093e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727197052; x=1727801852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+8VVnFC0UMbLhE2FStB9WxzHe1cGOTS795re4qbfvA=;
        b=VrPQLwkTLJWDf5A1ZeJRkLu4IRiV1J0qtTctLtyDS78jB10NEP/IFyn6QYqpSGUnb5
         jwkAsQxXDTUXM4WivzgtYVQmFKVI/Q7SQywvkUlsPjWi/yiBa94+UyGfbst703WVfMoz
         G4WhqNuIlUnB/010eQSHbW8QJDnCqz2esGdFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727197052; x=1727801852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+8VVnFC0UMbLhE2FStB9WxzHe1cGOTS795re4qbfvA=;
        b=CWz5U/xfsrfqQnXcLUzTCNV5FeE4PAXRVFt9cv2thUYoDeJS3krRQi/nLFr7Es/vFT
         eG8DVUywv728f+qEiS0NxaOFv9GQmDu6GsskHhUKXNlRSMqlFDO0eqWfWdDfGvLdTETi
         ywgTkvCZKc4w9lAs8S/tYGYguKqUIXHsPUZdePYg2SklDDgbYqClKPmpTUdwtGGpmHXY
         0LgZJMsCbBE6dQVICoWPwY9KtU8zfzomhSlsnqOkC2CqsHjdbB6isXeJ/xykzS2yKqIf
         SJ+CQ7qdsm8fkrpWXbG46fbioHeQRmBxlBrgIWHeu66ikxkXk6dHsEgCtAn3ZmfTguVn
         c3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUDDe7fMdmIH5j7WvrJJVKFyw5YYxq3TwB+OufAMNoiiIK1Iak4TqwNpSL4EfJVGAQzffRD8M8jShe9jqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CcdE3jQ3gFjpywGsABpSBtcSeQGT4Lty6N02ZLTN1+X1rJFE
	SCM9aunuX+rqiZnWtuRSNDtpIWjE3UFjTwQLkm0siX+IBpOzSHVFSpZ12Z+y8V32dOgcBnAKPyW
	5F+zkJA==
X-Google-Smtp-Source: AGHT+IFS4LimzIZTv8vegFMvU/RvI0HJwR+d29L6S1e/h54V7nJgfXNI/Jq0rQQ9JyhZO6/D0lGsfw==
X-Received: by 2002:a05:6512:2309:b0:536:5625:511f with SMTP id 2adb3069b0e04-536ac32f109mr11366343e87.45.1727197052164;
        Tue, 24 Sep 2024 09:57:32 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85f0ffbsm280476e87.115.2024.09.24.09.57.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 09:57:30 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so32036521fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:57:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvIVkTucDG/RFO8j9fiY2acd4SP52PInKgPHwfKH9omnv1b5sGkV02El3945NZzouBwYF69JlWaWyrJQ8=@vger.kernel.org
X-Received: by 2002:a2e:d01:0:b0:2f7:712d:d08 with SMTP id 38308e7fff4ca-2f916002bf9mr453131fa.23.1727197050351;
 Tue, 24 Sep 2024 09:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area> <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com> <ZvI4N55fzO7kg0W/@dread.disaster.area>
In-Reply-To: <ZvI4N55fzO7kg0W/@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 09:57:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
Message-ID: <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 20:55, Dave Chinner <david@fromorbit.com> wrote:
>
> That's effectively what the patch did - it added a spinlock per hash
> list.

Yeah, no, I like your patches, they all seem to be doing sane things
and improve the code.

The part I don't like is how the basic model that your patches improve
seems quite a bit broken.

For example, that whole superblock list lock contention just makes me
go "Christ, that's stupid". Not because your patches to fix it with
Waiman's fancy list would be wrong or bad, but because the whole pain
is self-inflicted garbage.

And it's all historically very very understandable. It wasn't broken
when it was written.

That singly linked list is 100% sane in the historical context of "we
really don't want anything fancy for this". The whole list of inodes
for a superblock is basically unimportant, and it's main use (only
use?) is for the final "check that we don't have busy inodes at umount
time, remove any pending stuff".

So using a stupid linked list was absolutely the right thing to do,
but now that just the *locking* for that list is a pain, it turns out
that we probably shouldn't use a list at all. Not because the list was
wrong, but because a flat list is such a pain for locking, since
there's no hierarchy to spread the locking out over.

(We used to have that kind of "flat lock" for the dcache too, but
"dcache_lock" went away many moons ago, and good riddance - but the
only reason it could go away is that the dcache has a hierarchy, so
that you can always lock just the local dentry (or the parent dentry)
if you are just careful).

> [ filesystems doing their own optimized thing ]
>
> IOWs, it's not clear to me that this is a caching model we really
> want to persue in general because of a) the code duplication and b)
> the issues such an inode life-cycle model has interacting with the
> VFS life-cycle expectations...

No, I'm sure you are right, and I'm just frustrated with this code
that probably _should_ look a lot more like the dcache code, but
doesn't.

I get the very strong feeling that we should have a per-superblock
hash table that we could also traverse the entries of. That way the
superblock inode list would get some structure (the hash buckets) that
would allow the locking to be distributed (and we'd only need one lock
and just share it between the "hash inode" and "add it to the
superblock list").

But that would require something much more involved than "improve the
current code".

               Linus

