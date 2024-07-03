Return-Path: <linux-kernel+bounces-239876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F3926654
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249F9B22591
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0718307B;
	Wed,  3 Jul 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DKs7qNri"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177E17E907
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025273; cv=none; b=VCT7Bts8bU2TSjxm1I43VX6XVgRztuSSkrTOuqsJTOaluRtCQ/NtiZOA82boyHhuXsITpGWV418qm6SPARibBcYbVbNduQRWHo6F3jTwvDrnViNigvAOViuytpNm0kHTBDSDy7ul4l269LgE9DBphNxZ3Hl3uyvEugZndB5OpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025273; c=relaxed/simple;
	bh=lJ+oJjGSmPm7QGJbwvHUTgTAnkoXpzeERWyvbJICW+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYHUQ8syJCnD/fTqAoJKma97QXOk/YPwHwblQOC1atDEJcj24u+Da6dmg6iIm+xCqS9KZlqr9uO3g/VSJvuEQsqbMIVHh/6bW8TZhgtS9YGV2E9k6ASNVGbfC3g/CR368/6630Df7n2sSvWf0Yv5nzP339tsEy1JG1C+kypEA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DKs7qNri; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b3fee65d8so3123267a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720025270; x=1720630070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DTEVlOEUHDwAOvpYSd+1fj7nxZG6XoxqWf/WJzx45vU=;
        b=DKs7qNriwfjI/ITcS4HeWN83dVsOehD/tzOF8i8rwT9frEfUlvu0fvsPMIkhk+ChOM
         20S1IfZz/urnsQ2LUaLry//cbU6PBt8pivQmcLlW6P85J6seBaddL4t6ghWDfKWSe1IO
         SJ4k/2p0a2TmuOwmoc2knrObxhhXBEZG2qGcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720025270; x=1720630070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTEVlOEUHDwAOvpYSd+1fj7nxZG6XoxqWf/WJzx45vU=;
        b=Fr5M/X56EL87d3vF3dNXsBiZt3orLVo4P5k+QpURKVDQPVOB9L8JEp3WzVnLB3i4Az
         rQrbhBK9RlHJO44A9qd8RM8ZiWF56qg9Hn9qzWsSVI8fqhFdKsM2HbSGouLY/u6Vhvij
         wmcqeDsDPGxcBE7PQ4sUPuclDIb5Ws74uObND6eApSsVfeIROGzV0qKU0tbQ0KwlwBqE
         PgDISolxBXkaQ38ShaUQGcS7TtWcqU4RIfrtivpNSkXR6gdBsAcIwcGmQTACXMh2dIWe
         OrFaPmSpUOiEqteZLBRVLyGCFzDpmx3OKI8UlSvnUNpOCc0cQAQkTqV40xijbxzdYqEg
         41uw==
X-Forwarded-Encrypted: i=1; AJvYcCXIh1OSc0WK1xbd7ATCztOBfVaTb7VbgAQ5DcKjYGLoCIWHTN20RUdcOJD3+75QScg1WkPtWivtPvZ6mCbT/uSToDkG9ZxpT7C5cj/h
X-Gm-Message-State: AOJu0YzeQdTQvHBfuDreKtVed+fOU0bxsDYwBwHiLNpl8qd5JWLsxQGg
	EsRey2QfT1tG+rZD4xRCjT1aErrft4JjbVHG0h0YkPahmfLYlwipfvdTV+qAREGluPsIBIzi/qc
	yPVVqzA==
X-Google-Smtp-Source: AGHT+IH+j42VoCuxRCadnRC02Et8hPfcDEDrVMJceDp8Nrwtt2g8YirzzncutMo6vUNLT5AmKxBJYA==
X-Received: by 2002:a05:6402:5cd:b0:583:a39e:f469 with SMTP id 4fb4d7f45d1cf-5879f1c2589mr8072732a12.17.1720025270072;
        Wed, 03 Jul 2024 09:47:50 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c835c4sm7234720a12.11.2024.07.03.09.47.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 09:47:49 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso4104854a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:47:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuppvF3mXaYRDyVfjr6y44eQkWzxn67/qsRsSXJNTjcAP/xFOA4ZOhf0urTA6m6bKwhp8/oVoacUNhObYyvTuLDXvSVhMCRcwg2sCX
X-Received: by 2002:a17:906:794d:b0:a72:7603:49ef with SMTP id
 a640c23a62f3a-a7514451ce8mr941408566b.35.1720025268507; Wed, 03 Jul 2024
 09:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
 <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
 <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
 <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
 <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com>
 <3g3arsrwnyvv562v2rsfv2ms4ht4mk45vwdkvssxkrjhfjtpdz@umyx5tl2du7o>
 <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com>
 <6knlkefvujkry65gx6636u6e7rivqrn5kqjovs4ctjg7xtzrmo@2zd4wjx6zcym>
 <CAHk-=whagTfq=EgwpuywUUu0ti7PPQuE_ftVjZOVrjnLwtS0Ng@mail.gmail.com> <du5vnvwygzbtal6qogmxckawwwxgbppuq5qi5aeqcs5unrlpz3@3k5degdvflzq>
In-Reply-To: <du5vnvwygzbtal6qogmxckawwwxgbppuq5qi5aeqcs5unrlpz3@3k5degdvflzq>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 09:47:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJRoSW=RN=r=YGpG1nBa44=wkDLZ92SZnuuzA_6inJrA@mail.gmail.com>
Message-ID: <CAHk-=wgJRoSW=RN=r=YGpG1nBa44=wkDLZ92SZnuuzA_6inJrA@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 06:53, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Now I'm confused mate. Based on the convo so far I would expect you
> would consider the xfs thing a no-go for the machinery.
>
> You were rightfully pointing out the relationship dentry<->inode is not
> stable and care is needed to grab the pointer, and even then the pointer
> may be wrong by the time one finishes the work.
>
> I presume you are also worried about callbacks not taking proper steps
> when looking at the inode itself -- after all they can be racing with
> teardown and have to handle it gracefully by returning an error.

No. I'm *assuming* the callbacks don't take proper steps.

IOW,. the reason I think the callback model is the right model is
exactly because I do not believe any user will reasonably understand
and get all the RCU pathwalking rules right.

So my mental picture of the callback model is that it is entirely
speculative. It will *speculatively* fill in the stat data. And it
obviously will *not* fill it in in user space - because you can't do
user space accesses while in an RCU-locked region.

So the stat callback would purely fill in a speculative kernel buffer.

And then the path walking would confirm the sequence numbers *after*
calling the callback, and override the return to ECHILD and finish the
path walk non-speculatively if the sequence numbers don't match.

> Inode changing identities adds potential trouble which does not need to
> be there.

I agree that the XFS stuff may be questionable, but I still don't see
the problem wrt any stat callback. The sequence number tests would be
EXACTLY THE SAME ones that we currently use for regular file open etc.
If they are wrong for one case, they'd be wrong for another one.

I think you are coming into this from a backgroudn that would do the
stat buffer _without_ doing proper validation afterwards.

> Suppose the inode got reused and is now representing a device, i_rdev is
> some funky value.

Tell me how the inode gets re-used with the sequence numbers still
matching, and then tell me why regular path lookup doesn't have this
issue.

> There is also potential trouble with security modules as they
> unfortunately have a hook for getattr.

Oh, absolutel;y. The stat security callbacks would need fixing.
Exactly the same way we had to fix 'permission()' for RCU lookup with
the whole MAY_NOT_BLOCK thing, where they just say "I can't do that",
and we'd have to fall back on the non-RCU case.

And yes, filesystems might disable RCU stat - the same way filesystems
can currently react to revalidate etc under RCU with -ECHILD.

This is all *EXACTLY* why I think that "callback with error cases"
makes sense. Because the callback may well say exactly "do the old
thing" because it can't handle the RCU case, and it will depend on
things that are outside the control of path walking or stat itself.

                 Linus

