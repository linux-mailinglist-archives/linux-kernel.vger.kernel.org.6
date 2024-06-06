Return-Path: <linux-kernel+bounces-204881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B48FF4A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B5FB23D81
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D3199E81;
	Thu,  6 Jun 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eR+tIULi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04191199399
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698492; cv=none; b=nsdAu18k0YCv4aZiP6YrULv6uh0ZnopZeUKKqoRAFUwEf1WKMg5XT69f91FWOmGMUqM9tlR4A39A2xPKQTtVY25MFv5B0YtF4ZiO1B/tINGK1C255lmLBvq19xjZp0jdyLko/yPhzb2xGUyTYRWpK3yBzU3e/c6oU6sHoxsKiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698492; c=relaxed/simple;
	bh=hXBCWGDl6iQUiGgI3mnJqEYYxAygCL92+j7yppmzxuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTLwNkeH9PFtbCogUqS7RjIvAmdfk2oJ5RwrAaFDCtRLjOg+vXcmjYp4KtX0dXTXqbaaNwbRpQibnt4iSJlr4YAYDLlzi6OpX0UyNKP/yyLqIgGh3oNvwg4fTpzL2j/aNdG/9rvKhWVglAZBNhoFq65kjKXuwQfbUSlya6NNmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eR+tIULi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35e573c0334so1438898f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717698487; x=1718303287; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9pp+YQLbn+mewrs9te441F0Mjx0zH5J0mECKySXrOe4=;
        b=eR+tIULi2oHBRMmc8VtesRQm+o3A9ShyBCKqnLXSpoP/8rMnvJgTAwMsd0AsrCUDtD
         5PD2+BHa9zAGOmkQDP5wwkFAYGG4B9Vy5m6qumnLeAy8rhG2IN7uCKxwcuRugrFw+t3o
         3P4pl/9W+K5YpMO8MlR4fy5D3JQhvzBjjuI3CwW5LS3mMXo+//xhyfcUSCpJZ9W7ddqx
         lWiju48rjE0G9e2Mtg9TQZ+4YtLL8tFOXQGSoUyD0x0iXa9KZcsabtM7u4Pe0IVa3ONZ
         BP83RGu9sfmODdAmxARniqd5LJp8LQmxY463EvZajTOiWm0W1ODcd9wWyOJLJTRPzIyF
         Dr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698487; x=1718303287;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pp+YQLbn+mewrs9te441F0Mjx0zH5J0mECKySXrOe4=;
        b=XY8SMP3W375Nj0Zk9lwJjF00T2+xi4wlCdYy4fI7G9y8i2/HNVExdsXYeELDuMH6CS
         AW0r9j41D1mm6qTEh7xvRKFkewtxKa1Sf40CMeY/jlAp3kZHQ4zvebZQDKNmUSd71DYO
         uKvzFTgqpLudl6muvubWhLyrGc4pBUY0tJeO1Oqu2DVTvMypgZ+4SGM9yLNDS6hRFZAk
         lPnSThlW8S47PtMbada1dz/+M08ggrfdo9Po3Ojp021+6pDM9wLL35lxEH5n//pFHRzR
         1+F4DX0jpRvAPKocUg+fh6Q2EGj9syK7soJknyfteHS/bXz9bAXcT+fFuMSPU9V9V8nD
         fz1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+8iWWlGdtTcJjEy+LKr8vLxY72MgjUDLYjkdoZxnFrXUCZkJER1T7wDnyEcTY9cRthXcOuiGIA626zyhNwli/6yJoscerdDxbaylR
X-Gm-Message-State: AOJu0Yzs6HOkbgmYwp0VD9ieTdr64gt5S7qMFcFk/oTeFAXNMzuaiG/g
	SULg3bKBYzN3shuHWSTxZvG209RXUmc6tQ3tdRxJbjmeUbh3zEyMbkCu8ZWn17Y=
X-Google-Smtp-Source: AGHT+IGPYw+ErGrFYTd1ZWI76ONo/bVUSy0lOdhvbOoId04ZnFhN69Ko8hQMDbBfXHaA0IyeYu8obA==
X-Received: by 2002:adf:f10f:0:b0:357:8a96:4eef with SMTP id ffacd0b85a97d-35ef0ddab9amr3182950f8f.31.1717698487366;
        Thu, 06 Jun 2024 11:28:07 -0700 (PDT)
Received: from ?IPv6:2804:5078:851:4000:58f2:fc97:371f:2? ([2804:5078:851:4000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806bd7ddsm3880114a91.40.2024.06.06.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:28:06 -0700 (PDT)
Message-ID: <0c3d947f230e2c7b737cffc2b6a326962edd890c.camel@suse.com>
Subject: Re: [PATCH] selftests/livepatch: define max test-syscall processes
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Ryan Sullivan <rysulliv@redhat.com>, live-patching@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
  joe.lawrence@redhat.com, shuah@kernel.org
Date: Thu, 06 Jun 2024 15:27:53 -0300
In-Reply-To: <20240606135348.4708-1-rysulliv@redhat.com>
References: <alpine.LSU.2.21.2405311304250.8344@pobox.suse.cz>
	 <20240606135348.4708-1-rysulliv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 09:53 -0400, Ryan Sullivan wrote:
> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.
>=20
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>

Hi Ryan,

is this the same patch that you sent on ? I couldn't spot any changes,
and you also didn't tagged a different version for this patch.

> ---
> =C2=A0tools/testing/selftests/livepatch/test-syscall.sh | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/livepatch/test-syscall.sh
> b/tools/testing/selftests/livepatch/test-syscall.sh
> index b76a881d4013..289eb7d4c4b3 100755
> --- a/tools/testing/selftests/livepatch/test-syscall.sh
> +++ b/tools/testing/selftests/livepatch/test-syscall.sh
> @@ -15,7 +15,10 @@ setup_config
> =C2=A0
> =C2=A0start_test "patch getpid syscall while being heavily hammered"
> =C2=A0
> -for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do
> +NPROC=3D$(getconf _NPROCESSORS_ONLN)
> +MAXPROC=3D128
> +
> +for i in $(seq 1 $(($NPROC < $MAXPROC ? $NPROC : $MAXPROC))); do
> =C2=A0	./test_klp-call_getpid &
> =C2=A0	pids[$i]=3D"$!"
> =C2=A0done


