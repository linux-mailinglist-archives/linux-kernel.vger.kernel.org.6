Return-Path: <linux-kernel+bounces-566453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867ECA67832
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A67C881F51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE220F08E;
	Tue, 18 Mar 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P63Ka1Zv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367F191F92
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312683; cv=none; b=kuWenJVAlZfmwAJKpH+/a4xiVkLTWQk/w0cCb6MajAmDrxJTkfjOjnyfHwE6nEALKXHWtHkuq7sxzLWpTMeIm8UaHfBKofZ3ic4OwDoNc8sg2BCxgm12zzoiEO/d5K17jK0uKvTjSTf/BK2AWaLuJvb9F+7bOG+NXa+hHVz/V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312683; c=relaxed/simple;
	bh=0Ly72ZYq7RIo8KXKjul9y58c5p/oa2pQnjcQhtbDLZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcAZRpKARePMC6h2rkRPhjLInIj8pUMcK4kqF57SaP6T4UcbN0LTjZYw8ijCAi+LAbTgmigHLVr3sIeFaWcK3tX9s/XUWrDRqgrpqvw3dLzbF0K0mre9CgqyxiVRhdTMCS0zbqCW2qAZWXKaOaQbRp8QL850/BBo25RZ33sIwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P63Ka1Zv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240aad70f2so241095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742312681; x=1742917481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ly72ZYq7RIo8KXKjul9y58c5p/oa2pQnjcQhtbDLZU=;
        b=P63Ka1ZvL3jn1K/Xb1CwGuil4qQe8uYtny/8i/bQc4VuCv76w/K4I9+qzZiHqh+9rz
         oTMkBcztHJKlRuzJy+yVUts41vg05uzJXy+dxVCw86FzaG8RmEEZcv1Ph7t02RdAaQam
         S8xVvQrMkQePQdWGOT/IqG3sKxq3aka4p9INxaY6Zp1lYbUrGaGg4dqGzYbJuEh/QTGu
         Y3Fl/jVjs2V1FcgZaPZ9TECAwBp8NdIS6Tx49HDDhKg2HLH+yrTDbtqxwpTUYObvcEwS
         flI5tuvVFdcWtD10Yl6CtjQ2eJyxP1Q+M9tKmOmbkpuWBSWmTv0t/nGvTvKHJnuF+DO9
         wmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312681; x=1742917481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ly72ZYq7RIo8KXKjul9y58c5p/oa2pQnjcQhtbDLZU=;
        b=pVl0OYkNi7L9dN0hQgbXhKueKpS2PR2l/5GWRI1bk3MemkZ5e2R3ucpt4Vpv+qwAak
         scCkHxwNsfBAQIjiypyQrmVmfghxT1/AN8PRsIO0BMeRQQi1kTi5cJfa7amGqwjBfqS+
         7LopB+MSH41sJ0FNqdPOjqf7pp7ngr2+Yh51E66BySsIZGEfnQv/y1eQCfUYM3U9mwwb
         QjZBmRtcf2VdyiPIQkJrSgfDVU3cZDi4YqJR1Kr2aWSabnwKAudwiLiBvQ9BXLBQuae1
         TpmibQjTVRJyT+wUhFhZtbgJ3VePilUVFoRQFzufMwHbZpJAAvT4eweFQnSEwNPQN6d8
         tYOA==
X-Forwarded-Encrypted: i=1; AJvYcCUwK6b57Pbft6801NUts+ZW+ECDHTYKtghmG7lF8oXRxeGjmQyZ3Haa0FhbxtFv3TC4HqFdrsdLTGDjyr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMHGDBCzybB7eG0FV/K6ALLbJhqpkzRORUhHKHdZ28oB+gChL
	mj/C4lkFkjTb/Sa4Qg8WmqEfmgjBokh72waamqxXwd9SUO+Ms9vsvunwkcJtCSHYvES1oRP/U88
	gO43p5rlEEaAB/SlAPVxqS6H5CoLSXCYRIWWm
X-Gm-Gg: ASbGncsleZRvLjNIOnGA8ywrtyfjn1pT8lzz1nSL+otZCwrHAJyDS6IKYL6HYy+PhWf
	pyJp2qgeiPnetCv2739lcJ2p9WNzhribOZbTt0PpAmi+0CfWKS8iBtd1+OUDN7VxaTiDBlos5NR
	PBc3aUTo/ig0SEcZjolgmY1cWjVvxasvfoBJMAcOXDsOaK7g/jU6KNgHQ=
X-Google-Smtp-Source: AGHT+IGh+2xZ8Ms2gVdUDlDHetxkQkzf082zJP7mKnLMc3K5OnEeuJwvj28gipqOgwHRgL1ljn+HQg5UkkyHg9KmHxU=
X-Received: by 2002:a17:902:f605:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-22631018e82mr2453915ad.10.1742312680721; Tue, 18 Mar 2025
 08:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUPz9R60Lay=k-0k5Q8C9AdStAMycOgsKqA5MJ_o7Ag3Q@mail.gmail.com>
 <20250318021703.78297-1-yangfeng59949@163.com>
In-Reply-To: <20250318021703.78297-1-yangfeng59949@163.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Mar 2025 08:44:29 -0700
X-Gm-Features: AQ5f1JpJbsNyitrKe8-u7csMc8VsRaKxiXcnfy9KlhRdj6oGLdKKOKioQE3_iLo
Message-ID: <CAP-5=fWuavNZv-x-t=f5-suLZHAyU-1y6PFj7WYNf6O_-RW1Ng@mail.gmail.com>
Subject: Re: [PATCH] perf kwork: Remove unreachable judgments
To: Feng Yang <yangfeng59949@163.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:17=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> On Mon, 17 Mar 2025 08:44:45 -0700 Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Mar 13, 2025 at 8:10 PM Feng Yang <yangfeng59949@163.com> wrote=
:
> > >
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > >
> > > When s2[i] =3D '\0', if s1[i] !=3D '\0', it will be judged by ret,
> > > and if s1[i] =3D '\0', it will be judegd by !s1[i].
> > > So in reality, s2 [i] will never make a judgment
> >
> > Sgtm. Out of curiosity, was this tripping a compiler warning? If so,
> > could you provide the details?
> >
> > Thanks,
> > Ian
>
> There was no warning during compilation,
> I just accidentally discovered it while testing and analyzing this code.

Thanks!
Reviewed-by: Ian Rogers <irogers@google.com>

Ian

