Return-Path: <linux-kernel+bounces-292852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CB957543
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4221F22951
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF651DF66A;
	Mon, 19 Aug 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FYN5rL7B"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC81DD3B7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097958; cv=none; b=nvuQeAka1U+t67wm0nRmY9Uxi9WS7vD3mmyjo6CmI4udL+7Ij1jZGL2oSldVqop/8P/9qE+iFEFNx0CUBMmxK+BOGcq8wbmnuhVRD44E0ULPNp9MRVuYux9Nq5b7uKHuT2W9i0JZIkiHUXwjDrAZF7dXuUoPJf2uD21rovnByuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097958; c=relaxed/simple;
	bh=+3oftQfhjhUYyg57I9ety2tn11QKkQqfdsVnyjwcBF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lnIPQ8bnSiC8Ojrs8jg5XgE3knPMQqFV6PqQioowS884digNN1AsYCGbVoQ7joxF5lUbON7rc3WjJC8ITjyaAxYglzRL5PgnIS311iB4hj51CzsVDkbmAzkuPz/AivwdqyKB18xdF82UF9y0Sh+kxetPhglaotGRk/jVkZ8mvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FYN5rL7B; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so3614339a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724097955; x=1724702755; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMxfpfJClEZ+ltWCCNkrYDChDycnDKMNk4ece3IVdJ4=;
        b=FYN5rL7BUVI5sPKjDbpNz/j1GS0INuEG1nI/ZopaTaCAWbnqbBjSRQcpet88exNRTK
         bBsgWfnj/+E1EB1mLHban0qzTxua+ABmzAcT3HhUVbvHZY1Nkruu2metIHPJnngQTQ9e
         Lye5kotn1dEETGjSIq1LN73NPU5DvBnstf3YyiZBWwE25u3yS3l+6Z/WN5Fx94vrXfM0
         Pzq7d3bMdkP1nqO0kMWPZ3GJd7eT+VZ0eINSoD1XpXohvCXa0tT6RtFAbg1mztwtQ2HU
         MLZ5fhRIUjnl2Fwgx/vDsEONzyXtU0uIP57/2tbat3SzZ7V+3nE4QPQ2dBTrN9YpQz40
         ctIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097955; x=1724702755;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMxfpfJClEZ+ltWCCNkrYDChDycnDKMNk4ece3IVdJ4=;
        b=OTVqCAzCiyBghTeJRj9IwU0u7+32IL6sJ6+ifgUmtwnf5JWD31hK7XdEaRpVVWF3b8
         q7ti6FXYlSksR3dCXv75aWntvBPOtAW9RVxAeFy71JJ+hlVjBO2fVaWn1jf3zc28uHBu
         x40+JN8uJLS8IRpFTiaMrV/5NvhEGAYMb4mXTduRFHcXryEEdgmF1OTYflgTXaJIaSXq
         RQJRQCuY02aBdFG9sMF/woVKUetkpE3SVWzkzoQ56y9XCsebrJECszwraBj2xiBjoVsl
         bhZv0umyZWe6Nw3HpIrPhh9tWQZmzOXJT9y9/50/Zi17hl6kGYd4PL/4+bTrZIMXfnxJ
         0CAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/9wespDNKIsrP30qyKkJ0BLI6WGrHPrqMwrtfHc6uEOKSE1KIpy1iQTAhqaLyASVkwzQ3L8L5hUUnlMmrEfwRCer3qTRib5rCzUqd
X-Gm-Message-State: AOJu0Yz5uaMWjN0t2TRn7HPWPvX1zqrZliv3tGh8vmD3BNUKjEeyAhvq
	pQr8A0kbjUL99tXp7E0nup4i5XxLcoHodGgg8lFSnzvl75JQAXDoFI8OPWnC7fk=
X-Google-Smtp-Source: AGHT+IHCD9ocXtZ6zDwa187R+PBvaqVuEvrwwPP2cleAnSgS3RYPhbyQRLrtSVrpR/ZkfoXjfl9kJA==
X-Received: by 2002:a05:6402:35d0:b0:5bf:79f:3b55 with SMTP id 4fb4d7f45d1cf-5bf079f3e28mr1220968a12.23.1724097954635;
        Mon, 19 Aug 2024 13:05:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48fdsm5851490a12.28.2024.08.19.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 13:05:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co> (Michal Luczaj's
	message of "Wed, 14 Aug 2024 18:14:56 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	<87y159yi5m.fsf@cloudflare.com>
	<249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
	<87ttfxy28s.fsf@cloudflare.com>
	<42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 19 Aug 2024 22:05:52 +0200
Message-ID: <877cccqnvj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
> On 8/6/24 19:45, Jakub Sitnicki wrote:
>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>> Great, thanks for the review. With this completed, I guess we can unwind
>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>> wanted to take care of yourself or can I give it a try?
>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>> 
>> I haven't stated any work on. You're welcome to tackle that.
>> 
>> All I have is a toy test that I've used to generate the redirect matrix.
>> Perhaps it can serve as inspiration:
>> 
>> https://github.com/jsitnicki/sockmap-redir-matrix
>
> All right, please let me know if this is more or less what you meant and
> I'll post the whole series for a review (+patch to purge sockmap_listen of
> redir tests, fix misnomers). [...]

Gave it a look as promised. It makes sense to me as well to put these
tests in a new module. There will be some overlap with sockmap_listen,
which has diverged from its inital scope, but we can dedup that later.

One thought that I had is that it could make sense to test the not
supported redirect combos (and expect an error). Sometimes folks make
changes and enable some parts of the API by accient.

Just a suggestion. This will be a nice improvement to the test coverage
even without the negative tests.

> Note that the patches are based on [2], which has not reached bpf-next
> (patchwork says: "Needs ACK").

I think it might be fair to resend the series to attract the maintainers
attention at this point.

Thanks,
Jakub

