Return-Path: <linux-kernel+bounces-392260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72CD9B91A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2091C22151
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD44119F42C;
	Fri,  1 Nov 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlZ9wyTy"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3C155A5D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466869; cv=none; b=BI9BzJsi32gWfmtKhVX4XQP9vRkkmddkK65N37yhGS1M1IyfnKpPi7D4rilQ6rAm4Ik1zDpRhetkPt516RkKViawgdUpMcsS3LuXHk1vRVR8fz1QsGlbHonB1jk18swCxUI+a+Zuio5RlV+F8cV3dmnb+iVNY0dA8LyJ3oe0D4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466869; c=relaxed/simple;
	bh=6aAmFsJss1QRu8uaL79qqcvFWlGka3N/28+aWyODFkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfkrVgfFkGAMvuLfL6KD8NhJ5DtTnnBKSZtYeMmfo3YAlLDtCyzM2MS2kLmGMuxlI+tFCxMA5SROMa9FtpAoe56epS0YBu/8F9361blqGAlCsyNPFIzbsRJii1ooUKA9K0Mlrmbz+UsW5ZxYpQw6Re159xo6SP17ARxnPJlu2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlZ9wyTy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so293445ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730466866; x=1731071666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWlXIahODzpoNdr0NLzeKSp3oyNmpJuqBRxB/KAVeiw=;
        b=mlZ9wyTyoHQPVwpDfsBP3O56lnVDYrr3wKodSOtNYp2fs4X21iRRssET5xOsUcYybV
         jman7LeX4aGQqdgZZjuF3qEZBXqBRu+76J5w6GZcZyn3NldjfTgwIi90Vgn978AgiBfd
         vYB0jYR5arbGmRRKk2PJJ+6ILWr5UugPjRwrx1DsTbuwjd4ZrgpjRMiusEqPot4Esi4N
         qizfMsUeq8kdzQB6gwW3aVSTnZ3njHfnq560JsDTKvNruRmfI+8cxr03THKNKdoCjF32
         VYufzQwIT1dB3Oh6sDAinR6mKX3JytM5DPrVd7GBLz3C8ZXuDS1PXTa/wAkLlwFEYT/W
         5Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466866; x=1731071666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWlXIahODzpoNdr0NLzeKSp3oyNmpJuqBRxB/KAVeiw=;
        b=UrfQGu+QZBlA44aPTzUG2ZoPkh4VqhiTxLz+JUI5o4ztGPhzFBZtF30WhEoiY3JE35
         BeL6q1ERDkJCiQyg0vrkD6jporYIk+GciI/K/93PeQ/f3UMpHqGiupPg/ozfwVQosh9X
         iA9i97IELEwH5mULEsZpG1Es45X23IoT88h0pZE6yxsncAz//BAbcqutRa4pmPv/6zM0
         +ZX+dnwP0ubWUOaf5H8sAA+M1hw9Jng+401OHVyPas1WdkiSkiMqT7Ld0+c2ptx3jaq+
         yq59l3CGaKpNOM8x2xJQJw2bd9s3JVJoywUzMiVDVdOWSTDZ3DbxdP4vsiNKoLQ0d5Pw
         eeBw==
X-Forwarded-Encrypted: i=1; AJvYcCUbgJZdQ1L8dwcgeQYrfuHdqCYPF3HJ4hRQS0Sphl3uCSBz7zBm+P3+L1/U3zVgfJhudP88r9/UiDLicQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIj0FBaloAG7JXAbkvCUCWpPNOa9niDyuAd7VeE0J9+N3C3P+h
	Qpf003Q8rOL83EPBswipzivUXa1KUytFB5a242no7NGdxKKTDeIdSqm374XQtwJQypd+RH4ud98
	w9QXGA5cTrCIi0FmRYgq07iijk0gsjZdr/Ox7
X-Gm-Gg: ASbGnct8mgtUJnwY66yIxRMAiWzO+ODQhIXFD59yhvG+b0l56Li1MqBVAm1Vr1o/6d/
	Ul/FD0AAy8//V9/eJeH6ShXQ+vUFSRgI=
X-Google-Smtp-Source: AGHT+IG9zSpv682re0C/0/lu+w1kkJ6uERs+tlXRbzXuyVLvZia/fQo8HxQNYuQYLETlY2WFrk/vuONmvkFszIhPjCI=
X-Received: by 2002:a05:6e02:3f0f:b0:39d:2555:aa2e with SMTP id
 e9e14a558f8ab-3a6a94371dfmr7307805ab.13.1730466866197; Fri, 01 Nov 2024
 06:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com> <20241031194101.301f1f72@kernel.org>
In-Reply-To: <20241031194101.301f1f72@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 06:14:14 -0700
Message-ID: <CAHS8izO-UhDfctAsjpdipRV=WyCvUAu9VnAes0mBe2wSvV3_9g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/7] devmem TCP fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 29 Oct 2024 20:55:20 +0000 Mina Almasry wrote:
> > A few unrelated devmem TCP fixes bundled in a series for some
> > convenience (if that's ok).
>
> These two should go to net I presume? It's missing input validation.
>
> Either way you gotta repost either as two properly separate series,
> or combine them as one, cause right now they are neither and patchwork
> doesn't recognize they are related.
>

Yeah my apologies. I made a mistake posting the series and posted the
cover letter twice. Looks like that confused patchwork very much.

I'll also repost targeting net since these are fixes to existing code.

But what is the 'missing input validation'? Do you mean the input
validation for the SO_DEVMEM_DONTNEED API? That should be handled in
the patch  "net: fix SO_DEVMEM_DONTNEED looping too long" in this
series, unless I missed something.

--
Thanks,
Mina

