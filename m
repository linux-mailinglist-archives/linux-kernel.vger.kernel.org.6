Return-Path: <linux-kernel+bounces-428242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607269E0BBF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25330282942
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38DE1DE3BB;
	Mon,  2 Dec 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CASHVKk0"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF794381C4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166671; cv=none; b=qHjybHdZkkQXPZHHHKQZ+Bw5xu0A26k2E2pQ2foE74AUn82Lk0i8+5e68NIwnLEDuxhQ158M9gCMjmJQHc7e8DHEroJoDOfbvyzc2mydirTg0U/ixYMdR/Ec90oEezK3ZD+SVQYLWCBMW6poMpL2S/OSA1jAra23s2oiMd9yns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166671; c=relaxed/simple;
	bh=+dDY/13lhh92HunAuLrfZgMjJQbbaOhGf388ITcDrbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNrQTcEjlZE/VjBKC1zZP85lWb4Zg+U0H5e+ITow4a4/+b+k/BVAxoZ7w38FWmwy26OIDG9y7YjhYTpNSCsX/qFbAPlh+bHdtbQH1YNMAAYeh11peu3j7VDLFXzUmSrIfkuffmWttjRk+zA+EZabuZJfDE/51qIS2Q2OWpNMDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CASHVKk0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b66b64a381so318903585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733166668; x=1733771468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tZHNcncTzXBZ9VMwNXbeOxENgdTLEygyN7vzsxyigU=;
        b=CASHVKk0pbKsP6FTAXyW5hhY5K5eePhBGMHYkcbEsP7wAxDDqanYiucTtsWcR3AuBt
         neQZ1fFokmISDWcoVL8156Q6srB0MID8ITW89ufr0mse+SEhKQiiv7ZemUiovBcDqV4f
         0Oc5GOhyYeItxDRLuPmvbbDPbycrJ/DHkhGMzqlCAARlt19BwG6DGUlbfiLHgiQCKtkf
         wS4qFZSPE/FZ9oe3Nq4tsbm/ZGw+YTj1mi5fI1WPRXJeMqNGeU7t9eolugfP+Q4KQ5xW
         LkfrW9M0HTnpKbZ0i0VwUYTPfRshwhTwU735mMsOf5OT0ZLqIYqTUTw01BIMoc7ZM41r
         X1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733166668; x=1733771468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tZHNcncTzXBZ9VMwNXbeOxENgdTLEygyN7vzsxyigU=;
        b=H7FhFWOglMKyPbaMQGXOuzdqR4H2ejD2bP4x8eUyJCQRhcmLyGOqu9tGq9mPj56/Eb
         6fZcfAYnhW1hwWq8W2hdyIKqd+iJNDGv1of7WXJeSE8aTUniU+tU6fd+YPxBaPXpUasS
         s7x4OI/4kGm9s5AmzyfzZbNv9BxAGjJiyYpstf+4UwXINGbBqde9TTK84HMa9xX4uBDj
         mE4Cp2wmr+uID8cwoSEaJSn9bipK6TRwvhhz1i4WWyHhn68DyuPv8QEP1GWPZfv24oSU
         ML2oXiGvi8vHabxpnOo8+ktSLw91aZwJl57QCaCkZIhXv5JRD4i10Vp2xDBJoZgmfhBH
         y0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXQt5TDDsHbvQrnCskVUXs6jPojJG+Ek6yMkkYZqi2PE0Pbuf4/UpXbiJ40znC7PalJpnG3jcw8pRpmkwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5M62qB32wjOT/3LDepnNqHmvLHtCEZMDTe5e53apa0zB/wqAB
	MbnlHn6tZO0hsuY2/PpJO1QVtxIimQboK0MzGWN/Gf7LeYCgnbGJK82U21cdQ40cBXvU/MkXtjD
	BOguicOCyUDWu7P5at+k9079V8H1kR8jx4deV
X-Gm-Gg: ASbGnct9GdksokcNboyCV/g6s4WPzVHLgX2dcvVk9Cj6rnfUl8PXuBu2ZnI8hb96vgU
	MuH1bePd7G+UhVPkNAW9faqYCqhDr
X-Google-Smtp-Source: AGHT+IHOQnSlFzFAeAKUYgKdEL1GA+HhzSuU7YRO9Wz/mhvv9hGBoppdTHpYn35KpsBM1Hn+yp79IJKjwUYS4gmLbpo=
X-Received: by 2002:a05:6214:2682:b0:6d8:9002:bdd4 with SMTP id
 6a1803df08f44-6d89002c59amr247159806d6.28.1733166668142; Mon, 02 Dec 2024
 11:11:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-2-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-2-ryncsn@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 11:10:31 -0800
Message-ID: <CAJD7tkYemGu0iqt+ZW9t5zr21PbHkFBRnc=EixiwoNbq0xq5Ew@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
> which is already checked by the caller here. Skip it by calling
> __mem_cgroup_uncharge_swap() directly.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..d3d1eb506eee 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4615,7 +4615,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t en=
try, unsigned int nr_pages)
>                  * let's not wait for it.  The page already received a
>                  * memory+swap charge, drop the swap entry duplicate.
>                  */
> -               mem_cgroup_uncharge_swap(entry, nr_pages);
> +               __mem_cgroup_uncharge_swap(entry, nr_pages);

Would it be better to instead remove the mem_cgroup_disabled() check
here and have a single check in this path?

Anyway, FWIW:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>         }
>  }
>
> --
> 2.47.0
>

