Return-Path: <linux-kernel+bounces-249339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292092EA42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E7E1F22BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEEE16133C;
	Thu, 11 Jul 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nhe0sg3r"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8AA14BFA2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706817; cv=none; b=usnChkf0npTSp5INqTvJqn31z5N992RfA+s6Ig1FWCs3y+OfE2TJ4ZA15+eJpqDFDp78gLLZH0CWceEjS5o91RVY7PyOcTdXqykKHOEDHwBhoueqrmkjBwoGDjpQRsbnDvAIPpJZm0k2SksmaImlNLdMQm8sQ+y5GbQ3NamzZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706817; c=relaxed/simple;
	bh=/LJntVGckN7+Mm5JjaItmJFTbNIfdKRitOyh9FjN9jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ1f+IFcccxv7nv8HRSCXfLzIFN0p3/A0GVU8fk+st/9Iw4ygih9KM08QdPi+uFTf08M9I8+8uVsQbEKAWugTlUJECSUGahEZoVHC2LlFq37/bwo0nK2pjjW/qhNosjLxku3sqaI8cekP9MzdGg4pf95qkK0s4gr9nC7EhyReMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nhe0sg3r; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64b29539d87so8497297b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720706815; x=1721311615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIPNti1s2/HNmMC/IZjSDG03fTpEhLPjzEULCFaJzl8=;
        b=Nhe0sg3r/l3FHItlCMjROPPUsneIdDc6em4U5k7ZIEOCx0msnePDvV/fRqcCkgv81V
         ZH1WRBN5Yqmz6Op/RLZwjC46s9JfIGgbrUkulQL2EpZ8DEMPL2Oe858VV4vcfHhCCryx
         +8U8UJ7D5MhMcY3cuO49vswggdZKYqplQzX7+5+chfldDOtPeBKwSDNC7IsdejJ7JujR
         8H5Fzbl/1d9xLHm76UUfB78hnmh55UNE/0ZjaADqTFfau4rCvgtXItS0NgRB6NYFcbPl
         HUPqkdMS039iNj0eXLEP41eRth+FkNQDIPHTRJQySfB+6aJiR3Y5SCCRbRtbvAqEDAWq
         0hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706815; x=1721311615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIPNti1s2/HNmMC/IZjSDG03fTpEhLPjzEULCFaJzl8=;
        b=f6Ku/rkbWdWz025q9UPdkzJlGJLXRRJto9/+YxLgXa9kG4zgAkGssnE3ZWOoSfFyKV
         LVjGAlaQKfZd3U77Rwi7aI98VAPhyol8qbJ10b+2gQSBiHCFmuHG/0TxxDL5tdMm1r7i
         J/Hd36Kbyv9/dmpBTKvP9/Hb9C9MH9kmVfyglaEmkXQsyatA3zWUVYKmuEuErnbuWApz
         dghA15PhYg0xaADw7w7enK0Fx/2wVjSW+Gt4x1zfsfrpVTz9ITv9qcFtLY3akc82ZBJv
         v9uFQUv8VwnZIlEJNxUTtOW6/V2onuhrQedp8b1CwSdRMghRpZfErfaJBVHTe7KRbvc/
         ob2g==
X-Forwarded-Encrypted: i=1; AJvYcCULUywDIPov3c3BeTyNSetxV+qEnDZ2LlMVdaUL7AHEVhdg+kqvKDJVToFy+S6TYM2uPXKJd1XDODwB/obxkpNF4WRowV9R1VHsxKDj
X-Gm-Message-State: AOJu0YzRgk0h7Uy1Q/B002rSL82FpoCgKBVANaMqrJri/VQuGbv6EDLI
	kFzCtAqpNYLvZnA7Y4vP7q/M5qVM/udlKYVUibaSbEuEQw8GBtMhihOvU8Fen3ppQklnYhseomI
	yy3VajiBdMwDBslWntsoUy44AWMEos0gk4g+A
X-Google-Smtp-Source: AGHT+IFuspm27tfeFqYCo1mM1up+6/KBdHFCOyNzTDo6zxPKaW5nKhYAVDWMkqQ6+wQZpi4uFLUZhsZMyCfRvdjmzo8=
X-Received: by 2002:a05:690c:3385:b0:62f:2553:d3b3 with SMTP id
 00721157ae682-658ef3414eemr119351847b3.29.1720706814862; Thu, 11 Jul 2024
 07:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net> <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
 <eb168f2f-948b-4a3b-9237-92902f0c7438@I-love.SAKURA.ne.jp>
In-Reply-To: <eb168f2f-948b-4a3b-9237-92902f0c7438@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 10:06:43 -0400
Message-ID: <CAHC9VhQUqJkWxhe5KukPOVQMnOhcOH5E+BJ4_b3Qn6edsL5YJQ@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:32=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/06/28 3:28, Paul Moore wrote:
> > It's also worth mentioning that while we always allocate i_security in
> > security_inode_alloc() right now, I can see a world where we allocate
> > the i_security field based on need using the lsm_blob_size info (maybe
> > that works today?  not sure how kmem_cache handled 0 length blobs?).
> > The result is that there might be a legitimate case where i_security
> > is NULL, yet we still want to call into the LSM using the
> > inode_free_security() implementation hook.
>
> As a LKM-based LSM user, I don't like dependency on the lsm_blob_size inf=
o.
>
> Since LKM-based LSM users cannot use lsm_blob_size due to __ro_after_init=
,
> LKM-based LSM users depend on individual LSM hooks being called even if
> i_security is NULL. How do we provide hooks for AV/EDR which cannot be
> built into vmlinux (due to distributor's support policy) ? They cannot be
> benefited from infrastructure-managed security blobs.

As stated many times in the past, the LSM framework as well as the
Linux kernel in general, does not provide the same level of
consideration to out-of-tree code that it does to upstream, mainline
code.  My policy on this remains the same as last time we talked:
while I have no goal to make things difficult for out-of-tree code, I
will not sacrifice the continued development and maintenance of
existing upstream code in favor of out-of-tree code.

--=20
paul-moore.com

