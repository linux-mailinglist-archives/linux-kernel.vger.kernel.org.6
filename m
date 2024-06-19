Return-Path: <linux-kernel+bounces-221707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1253490F77D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D651C21EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03015A863;
	Wed, 19 Jun 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L9KhGDI3"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161C15921D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828723; cv=none; b=YBebew4cfPyvduL0qPd/ki61DUCNCN1+DKjWVmfv1Vs2pJKLcDHF4pMvCXs9o0sBOwmKlBw0mj68RfDkMw9WnNE72TZ3PfDiE7OC+Js3NUy1sTvKnQNmlyShv/bBRADwO+AQP06SU+wSfHF5Nf0NQWIrfgnA5kNFsEROiJN+Oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828723; c=relaxed/simple;
	bh=rG9ENg+9n76Cn4HGc5+anyg5WiKL5Mt6eTESlfVDI8s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fAL/1o0FnWWLeGjuflDNQHfViALmKNAiVGc37zBJ6jqcDS6theUCYrvofQrd4NW/s+v+LY3wetViGW++21VFSclbca+MjC/fuQcD0hui7Xhot5jjrDH5IPxevaxDdt9rR9WPgOq8SlUWwJ7nIyNlSQHndtTuUGBO0jeuPPj9Sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L9KhGDI3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-364b2f92388so51097f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718828720; x=1719433520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NB9pQz873Cy2BI/A69NB2hPivapi5DfhwFSffll5JTM=;
        b=L9KhGDI38mqoFcTGrQY5wbFSoZAOSeh8XowF3j72YNdHweUlxwUrdN7QZr0lQKlVmp
         zPyAVF696AIh8kF/+6Kfv44XoNLhjlDgIUEZ78XnncBcCnvApRf3Rq0mg7/sLtsYTJN1
         m7die/k0hgyVoOlhUlv1vBGgftRwv+aPg6mjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718828720; x=1719433520;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NB9pQz873Cy2BI/A69NB2hPivapi5DfhwFSffll5JTM=;
        b=L4rbTeCwWSfzlHK89F+GFiHQF51oxml08kG02/S/R5wU5kQw7jOnqWhAKSvwLYxVXE
         w5ZbD9M/oIBSdBlb0FBo4vETND7ZXMJJn0w0Qjm1EmnWIotgoEI1wcRJm1GTM+aKYqKY
         DYr/5m1TMTsVTDCHwKMzHXLWBE9BNLVGPyf5NYxUzgq0sLXjY5sWiCH+5kU+LA9zNMQv
         B4KnRiPPaE+AGf1xeHEIacrziadiQhxNELGRBLS7HRrarNxuZ6SkD4nmhsCWK0hYHII2
         i9l4lBRpgcjHF6RTzsXSWInRvUIsgQlCV3hidsx8VFwQhJsoDVW08QijKO+ZSRHM/V17
         orNw==
X-Forwarded-Encrypted: i=1; AJvYcCXKGQ9Ti79jF2fa3WfmTX3LNIemdNvDpsDa4TbHqSGVAj/8R9WxElwk9RPXVElGkGuGv71zDzhgvJ92zcimZtF86D/tLr98wipldSpF
X-Gm-Message-State: AOJu0Yw0WNdBDrA75j+KWo+e55abx6VGujgFRJoSMuAFhH8IyaaRKxEn
	yBrWgYBJ41hlcBnQZroq6GhXeWZgRUnNaqs9lUFT/1PblL4LApQW5Ke09ImjZNw9ioGrOvYLPor
	Te8CB5Q==
X-Google-Smtp-Source: AGHT+IEtctB5USxaXj4+r6HPBqKw1u1gAeAB26OynmmeVl8Ie7IxIhh9hRmSoN4n9u3FVCyWN4WeXg==
X-Received: by 2002:a5d:63c7:0:b0:360:8f85:a5f1 with SMTP id ffacd0b85a97d-363170ecc19mr2740230f8f.5.1718828719843;
        Wed, 19 Jun 2024 13:25:19 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4182fsm704117966b.178.2024.06.19.13.25.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 13:25:19 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f176c5c10so15465666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:25:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2h8sxws+M2ovPcBeKFm2B2CmPqUf3p1NKbR3NXz+bk/WYIbVsahio9BluICeOX+vG8uNTI0LNRl0XbohEH+vsXzxNszzPcJXH6m9O
X-Received: by 2002:a17:906:d98:b0:a68:86b9:52e8 with SMTP id
 a640c23a62f3a-a6fab7d0449mr192966866b.68.1718828718630; Wed, 19 Jun 2024
 13:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 13:25:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
Message-ID: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
Subject: FYI: path walking optimizations pending for 6.11
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I already mentioned these to Al, so he has seen most of them, because
I wanted to make sure he was ok with the link_path_walk updates. But
since he was ok (with a few comments), I cleaned things up and
separated things into branches, and here's a heads-up for a wider
audience in case anybody cares.

This all started from me doing profiling on arm64, and just being
annoyed by the code generation and some - admittedly mostly pretty
darn minor - performance issues.

It started with the arm64 user access code, moved on to
__d_lookup_rcu(), and then extended into link_path_walk(), which
together end up being the most noticeable parts of path lookup.

The user access code is mostly for strncpy_from_user() - which is the
main way the vfs layer gets the pathnames. vfs people probably don't
really care - arm people cc'd, although they've seen most of this in
earlier iterations (the minor word-at-a-time tweak is new). Same goes
for x86 people for the minor changes on that side.

I've pushed out four branches based on 6.10-rc4, because I think it's
pretty ready. But I'll rebase them if people have commentary that
needs addressing, so don't treat them as some kind of stable base yet.
My plan is to merge them during the next merge window unless somebody
screams.

The branches are:

arm64-uaccess:
    arm64: access_ok() optimization
    arm64: start using 'asm goto' for put_user()
    arm64: start using 'asm goto' for get_user() when available

link_path_walk:
    vfs: link_path_walk: move more of the name hashing into hash_name()
    vfs: link_path_walk: improve may_lookup() code generation
    vfs: link_path_walk: do '.' and '..' detection while hashing
    vfs: link_path_walk: clarify and improve name hashing interface
    vfs: link_path_walk: simplify name hash flow

runtime-constants:
    arm64: add 'runtime constant' support
    runtime constants: add x86 architecture support
    runtime constants: add default dummy infrastructure
    vfs: dcache: move hashlen_hash() from callers into d_hash()

word-at-a-time:
    arm64: word-at-a-time: improve byte count calculations for LE
    x86-64: word-at-a-time: improve byte count calculations

The arm64-uaccess branch is just what it says, and makes a big
difference in strncpy_from_user(). The "access_ok()" change is
certainly debatable, but I think needs to be done for sanity. I think
it's one of those "let's do it, and if it causes problems we'll have
to fix things up" things.

The link_path_walk branch is the one that changes the vfs layer the
most, but it's really mostly just a series of "fix calling conventions
of 'hash_name()' to be better".

The runtime-constants thing most people have already seen, it just
makes d_hash() avoid all indirect memory accesses.

And word-at-a-time just fixes code generation for both arm64 and
x86-64 to use better sequences.

None of this should be a huge deal, but together they make the
profiles for __d_lookup_rcu(), link_path_walk() and
strncpy_from_user() look pretty much optimal.

And by "optimal" I mean "within the confines of what they do".

For example, making d_hash() avoid indirection just means that now
pretty much _all_ the cost of __d_lookup_rcu() is in the cache misses
on the hash table itself. Which was always the bulk of it. And on my
arm64 machine, it turns out that the best optimization for the load I
tested would be to make that hash table smaller to actually be a bit
denser in the cache, But that's such a load-dependent optimization
that I'm not doing this.

Tuning the hash table size or data structure cacheline layouts might
be worthwhile - and likely a bigger deal - but is _not_ what these
patches are about.

           Linus

