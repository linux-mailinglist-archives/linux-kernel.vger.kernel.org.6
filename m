Return-Path: <linux-kernel+bounces-172033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3683B8BEC45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BA1C231B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F916DEC0;
	Tue,  7 May 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UQ4COlZi"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1916D9C8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108853; cv=none; b=bxyR/YtxHBEu194ttuTrRAteB2creJknGtbVZRNhyuUSxtXtZ32yePIXi9JLWQZb29mai32AT/X/cQLbRFXMWoekWSjn1FblU8JaviZ+qz8Vz99U/9aPGQdqU68/pep0jzWlLUio2CkB9uPhcO3t8rcWENTG3dZ6s9s8bh15in4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108853; c=relaxed/simple;
	bh=pui840tsR5Yet33PCWgvY2wZoLY0nvaSbhvNkKxiwJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0sSao7P2CG0t9PjOBvXBHO+jdMj4C/i+lCpXX6Rk5644UqkxZaDvPBH2UfXOL17EuqIT0bPMrzRO6TByozXYE9iSr/+n5HFQI4Oa3AZc8S8cwAK0P4cDo8/0PBH3+oedcoK3sDgb40AFR9fn0htIZUE5OPYmYAp3l+A9XYALCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UQ4COlZi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a5f81af4so918586766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715108849; x=1715713649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JwU1IWNzhlSP5EH9iyMHaFmRpSbbE8IFJCVgZMlAkcM=;
        b=UQ4COlZi1wjGRec1vXSHfd/ePwofzv5i+nayllj0aKOQVMkogpronwS7fiNKGmJYdc
         REVt1UaVKAKyPpoa8plwTreCFTeU3qc2gfW4ylySKcUh3P80ZgAPmXXBjy+U3z68P0a7
         6wtqLOMLsQfLwo6VHZ4W8c4W0n2CIrr86nD1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108849; x=1715713649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwU1IWNzhlSP5EH9iyMHaFmRpSbbE8IFJCVgZMlAkcM=;
        b=jBGBh5z5x+1Bws3nC1rwDm/jhaH6g+xGJN118Tv68W0gpuzxORj+J1TdS6OEbFSrmE
         5E5lUwfZ6PFmIKE8bvFaWOyL8EJ+w5qMcc7ijcD9Yh5+JEsGI8GmonRmMzUjYk7maPnf
         oc9nhbf03uLtPgSv6f5zkG3FUApvU98p68jTqmZsniDZdSd1jv7j0MhluIMLhznc+jOF
         PWiHcKmOFwf4PQIReIkCZdGGauRokA1NryR8U2AY5IxOrYcR4axcJZHYt40mA9/pcRMO
         rlQDuft0o5gvPWCHFVKaXH2lq/1qMYvbTmoXT1jb73TZrPvupKbkbtZcOqZgTiRQzw1z
         iQag==
X-Forwarded-Encrypted: i=1; AJvYcCVvjI+qdVSqrYtrNkwqLJhUzHoNV2kxOPYWH8T9qsHflYTCUtaftDeCFn4f8Oei46QtBiPeVfKmrdqZ+XcIQkhlX8MCHVNQapPRIQdE
X-Gm-Message-State: AOJu0YzRDiaXstY49ERmVmCqrAhPjSEqRUXHwA2lQ9s1WGdYGp7hp70e
	EEtQAks/Fxg70JHeHIv9rdLSTEmPrDwXQP/bZaMx0g6OQBIqJ6uFFriCj5qIhPbJ3A0LyuZRe7k
	9y636cw==
X-Google-Smtp-Source: AGHT+IFNXFm+GFjbDBdDFbFSW94KSS9dvmrTomdqJ7ToLhDZTIKKho/hh1kXCohu2aSedXgL7RtbnQ==
X-Received: by 2002:a50:cdd9:0:b0:572:6aaf:e0d3 with SMTP id 4fb4d7f45d1cf-5731d9b78d4mr398358a12.7.1715108849149;
        Tue, 07 May 2024 12:07:29 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id bd14-20020a056402206e00b00572bd30320esm6655077edb.82.2024.05.07.12.07.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 12:07:28 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a5f81af4so918579466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 12:07:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCEWfHzas8dbyGI5R8IAa2P269fYt3s55xxKrn5e2eLnAar9r1xfHFxFrjvK2UAl1aCo6rIv91Q2dP6f7yJpRcOcOUTEhwhR1Jnse4
X-Received: by 2002:a17:906:1957:b0:a59:a977:a157 with SMTP id
 a640c23a62f3a-a59fb9f209dmr23097766b.73.1715108847432; Tue, 07 May 2024
 12:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com> <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com> <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
In-Reply-To: <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 May 2024 12:07:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
Message-ID: <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better about
 file lifetimes
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Simon Ser <contact@emersion.fr>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, 
	axboe@kernel.dk, christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 11:04, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, May 07, 2024 at 09:46:31AM -0700, Linus Torvalds wrote:
>
> > I'd be perfectly ok with adding a generic "FISAME" VFS level ioctl
> > too, if this is possibly a more common thing. and not just DRM wants
> > it.
> >
> > Would something like that work for you?
>
> Yes.
>
> Adding Simon and Pekka as two of the usual suspects for this kind of
> stuff. Also example code (the int return value is just so that callers know
> when kcmp isn't available, they all only care about equality):
>
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/util/os_file.c#L239

That example thing shows that we shouldn't make it a FISAME ioctl - we
should make it a fcntl() instead, and it would just be a companion to
F_DUPFD.

Doesn't that strike everybody as a *much* cleaner interface? I think
F_ISDUP would work very naturally indeed with F_DUPFD.

Yes? No?

                       Linus

