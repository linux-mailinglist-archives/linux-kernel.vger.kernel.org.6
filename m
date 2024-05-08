Return-Path: <linux-kernel+bounces-173608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC08C02D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7491F24040
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7D12AAE0;
	Wed,  8 May 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hrzHrMhf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A54CE19
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188506; cv=none; b=lw/fE5t5Q4fWJFqbSYHxGnxsG6+rAlwb+YNVu/ymfV2jPoCxjzVD4DrvT8Kqu730QT1/8ya/EEE5TzcpnAzYisv9StPAYHrjJYXAM/WMzYSTbfEpqmnCX4MtYX1Cwe21kyRNbCJOnhKbyLaWMJYXBNtcb3nacaXXxtjfOP7p6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188506; c=relaxed/simple;
	bh=V0bpsJ67PmT0LSDQg/VjFC4vr5TTFXyb2cnSJu3RiIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csDuQS2PrG3LIHQPP/vXmBe28z6H/ZCrP79iyX/cuVuCcQg4TC2goOyumvjb3f10PRL9aaIXMMCcvnfZd1UrIrCfVWC1z6t0Yn5nordk8McZRSczm1W3CA/qFRozlr2IUnYjQG0swVQlRZAooSrWAQZxPOx3Aj+YQpFXDXyD2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hrzHrMhf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a0e4b773so1122140666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715188503; x=1715793303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U/4yjhmm7i2TdW/kF2dab+x944KGHXX8XGDp8OQOwgM=;
        b=hrzHrMhfk4Af2mAW+gDJ2igv5VnkcjuyqI+Jet76L6ChMrg/Ik+JcYIv1M12ARI9x1
         HN8smMhRK4jjUuF8I4/645auzfr/S9I+zfXwsKneOHxNY58sW25nwrpbxW3a4VXdunTR
         o02wel/zSPnp8SyPfJnoRuFlkkazpUCbR3FM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188503; x=1715793303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/4yjhmm7i2TdW/kF2dab+x944KGHXX8XGDp8OQOwgM=;
        b=uMjlNaUR/s/bZyw3uXPSwczSkbteGe6aTuROsNe51wJ3cj+fFbdn4d79qcwK0HMPXf
         pRkJQFW2iJLJ/2JRJ2GUSrwDfKifuX0hOcK+ZY12pJ76rQfg6pq6mCkq1VtwLv9TzHv4
         0jr8EasrJtHYKMy4IaSq5MCQr8EReAiZ1dOkuFE1HaEElZDNpsj2bzLVooSoQ+Bt8WqH
         THLHTvJQ6qPjHttYRjN6jXq8WSyTKiCP+dovQpIKDS/HexuuHAyH9EnBsnZh7CUM9P42
         /cqrUG8gHlvvqTE8RBatn3jKkDG1wA1FiwixE+Fkcy6P7GC1KNwRPn7MpXO5Hdftwt1Y
         r3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWHOLjn3pSA5Ye9Dk7zP1r83dYc+A2iPYRrF8HpNMNyeiPbRIGGCoiJLAQAebn/aXQxQ/4zP7tKudUJxOh4Qt6pYB7zECwNKJ+F1HRr
X-Gm-Message-State: AOJu0Yz4oASS0GsUip30yB0uXKgOflXrFLIruPjEvOctJyBTbV07xSVT
	u1TKc86JZwpNS6LHKdXCm8836igHQG8w89jBYAczFxavU4eMXC1VqOIazotzVM+7GGqzyz7b9kG
	qKT2c1A==
X-Google-Smtp-Source: AGHT+IHPDl2civRpneAqByGeMvlJRRdlziF4hmbWXqN64+FcFTUBGIfx6DZd9DYDLAk++PAC/9vBJw==
X-Received: by 2002:a17:906:6994:b0:a59:9b75:b90 with SMTP id a640c23a62f3a-a59fb948fb3mr193949866b.2.1715188503290;
        Wed, 08 May 2024 10:15:03 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id mb15-20020a170906eb0f00b00a59cc6d06f2sm4099159ejb.218.2024.05.08.10.15.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:15:03 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59cc765c29so885956366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:15:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+je2oGIJytkdRo3bacF2A0SQTYJdR7Y/e72Kn25IA/olN1biEZOI2noVF+L4g0voud8+HoB6xqJXp+YFInobOsaZGRLi8pB5Lmdfe
X-Received: by 2002:a17:906:a996:b0:a59:ca9c:4de9 with SMTP id
 a640c23a62f3a-a59fb9f5184mr235459866b.76.1715188500986; Wed, 08 May 2024
 10:15:00 -0700 (PDT)
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
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
 <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
 <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com> <CAHk-=wixO-fmQYgbGic-BQVUd9RQhwGsF4bGk8ufWDKnRS1v_A@mail.gmail.com>
In-Reply-To: <CAHk-=wixO-fmQYgbGic-BQVUd9RQhwGsF4bGk8ufWDKnRS1v_A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 10:14:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmC+coFdA_k6_JODD8_bvad=H4pn4yGREqOTm+eMB+rg@mail.gmail.com>
Message-ID: <CAHk-=wjmC+coFdA_k6_JODD8_bvad=H4pn4yGREqOTm+eMB+rg@mail.gmail.com>
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

On Wed, 8 May 2024 at 09:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So since we already have two versions of F_DUPFD (the other being
> F_DUPFD_CLOEXEC) I decided that the best thing to do is to just extend
> on that existing naming pattern, and called it F_DUPFD_QUERY instead.
>
> I'm not married to the name, so if somebody hates it, feel free to
> argue otherwise.

Side note: with this patch, doing

   ret = fcntl(fd1, F_DUPFD_QUERY, fd2);

will result in:

 -1 (EBADF): 'fd1' is not a valid file descriptor
 -1 (EINVAL): old kernel that doesn't support F_DUPFD_QUERY
 0: fd2 does not refer to the same file as fd1
 1: fd2 is the same 'struct file' as fd1

and it might be worth noting a couple of things here:

 (a) fd2 being an invalid file descriptor does not cause EBADF, it
just causes "does not match".

 (b) we *could* use more bits for more equality

IOW, it would possibly make sense to extend the 0/1 result to be

- bit #0: same file pointer
- bit #1: same path
- bit #2: same dentry
- bit #3: same inode

which are all different levels of "sameness".

Does anybody care? Do we want to extend on this "sameness"? I'm not
convinced, but it might be a good idea to document this as a possibly
future extension, ie *if* what you care about is "same file pointer",
maybe you should make sure to only look at bit #0.

               Linus

