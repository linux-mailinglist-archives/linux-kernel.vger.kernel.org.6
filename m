Return-Path: <linux-kernel+bounces-244533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B657492A59C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C261C20E21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6059B1448F4;
	Mon,  8 Jul 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldcwsrk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3014430B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452412; cv=none; b=q/TmF1WgX0AcGpOptLjLbAK7KrsLMQpz+x3weZJRekn0j5jfd1xmQOHHip7bd9gxeUSK/F/uMntIGkcswOMFoGeTmuLST+ie3qJOka+7ruYrkBK2EU7E2djbCLhDMr3B3jFp4PaqpDnk2VqyQtmKHu3gl7rdXZ7bXcr75Ts3Ovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452412; c=relaxed/simple;
	bh=NMWDAP0++I3uHm5Cy7E6r49iQ039YTZsrIxu+yxCFX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch7yI3TYDejPP0Y5wVj56wqgpPDWas0LFmKDYD/Rz8LoHzKghrQI7Iwzwx//p3j1EUtveHLspy7yEXMUXk/FFji7TkWtsTfn+zaZU/92ehc5kMxjWGMAnNN4xXDfxW1lpkh0yb24/J0sm3X1YZpqzl4f8isMDmfT4/QF+xI1I38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldcwsrk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502B6C4AF1B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452412;
	bh=NMWDAP0++I3uHm5Cy7E6r49iQ039YTZsrIxu+yxCFX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ldcwsrk4MDaQNVqZ9nebVFJllaVFj8oSl+0PuVezfJ4OuLzLHNhdimn/rI4KPr6W7
	 qpGtcAmhKzSjBAaaGksv+b69LM2D2o/g3HqjBGkgGaB1GvknHuHCvjFqP/+a95+ZXc
	 II5+HTFc7x4/KLAx//3gAPdk6jdSB+UvqzG2VSZbjIRNGYv5exexSBF0wfxDsEF/OQ
	 xWqV9YeAQSpyEkikc8H1aPKBhFurq6F2DfgGGKX6tulaQQBuA02BYr8ZNgz2dZbPld
	 eMxhAHx5tsSijbB3UeQBy/fupbq4lltGQzJOgwXSiWWOGd1KnAOMC3vYSZfg8+0/yr
	 ODkqUuEnP2PNg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso5337863a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5vwO2KBNCDZxdNg8Eme/lE6EnhJKfvDlxpfnHf/InXp5aEvFZNFFvz+5AZhb1xrLyUflnK3DJvPfVK47BFb/3sqsS+9kG6aInvQMD
X-Gm-Message-State: AOJu0YzaC2ffwkut8NOmJOBG70yGKaRKhiMCTEmx7ehvI0WrxeFfUxW/
	fM8jrjAtQk+GAN/y38dIipZwS6L+HHBhyZ2gYyWJvG8zaJHxvLjEP2mFp5u3uYphtAh75//XmMK
	ybw1ivRk+pWw70rZCQ8gihg8PKLFBcRYw4Uiu
X-Google-Smtp-Source: AGHT+IFr239xq3D9Un1IJnTn6DbctDzeicjb6FE+pRqZzZZcuPGczW3Y9ITNwlSJjszfqyRW7amOVcQRU0EyhR6i648=
X-Received: by 2002:a05:6402:278c:b0:587:86d8:8b54 with SMTP id
 4fb4d7f45d1cf-58e5a6ee9f5mr9581463a12.4.1720452410568; Mon, 08 Jul 2024
 08:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705145009.32340-1-puranjay@kernel.org> <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
In-Reply-To: <mb61pjzhwvshc.fsf@kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 8 Jul 2024 17:26:39 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
Message-ID: <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>, 
	Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:00=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Daniel Borkmann <daniel@iogearbox.net> writes:
>
> > On 7/5/24 4:50 PM, Puranjay Mohan wrote:
> >> fexit_sleep test runs successfully now on the CI so remove it from the
> >> deny list.
> >
> > Do you happen to know which commit fixed it? If yes, might be nice to h=
ave it
> > documented in the commit message.
>
> Actually, I never saw this test failing on my local setup and yesterday
> I tried running it on the CI where it passed as well. So, I assumed that
> this would be fixed by some commit. I am not sure which exact commit
> might have fixed this.
>
> Manu, Martin
>
> When this was added to the deny list was this failing every time and did
> you have some reproducer for this. If there is a reproducer, I can try
> fixing it but when ran normally this test never fails for me.
>

I think this never worked until
https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium.org/
was merged, FTrace direct calls was blocking tracing programs on ARM,
since then it has always worked.

- KP

> Thanks,
> Puranjay

