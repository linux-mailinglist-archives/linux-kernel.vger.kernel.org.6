Return-Path: <linux-kernel+bounces-428524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F65F9E0FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2793B22899
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD841FC8;
	Tue,  3 Dec 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCZHpaQZ"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94C5684
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185465; cv=none; b=B2tQSctpo2LO5PbZI2d9rSFfX2yc0tq/c4q+DdY517NcOPPCQiGg3lbt/e6rh+037u7gZQzONKft8B2Ac6PeXU7CJOXQ0/8+um4ebMNLjAnox+YNTK3ogdNpwyYMNusirbbTMpJln0IySK8tvT+3ikM0TQbWsClOGgD1hXEdzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185465; c=relaxed/simple;
	bh=+W7KDL+OEt/F8m0iAhk3AP52eX+WQu4nCWXJFGtXNX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7BNAN81SlNLp6012vGLjQr0LvedXvpJLQXHmUGlMmkLChETYPLVufO1J4A3XItrIpRnKwWTNgzKGPV6nPbIK2e7iCNehbRAEw1bTAQbQ02AxA0kLXL1jU0zWxUqNHCazgNaD50BFwPozHtmntbDe0MJx3k76eYGdtAEbpWhpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCZHpaQZ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f1ecd0d9ecso2250629eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733185463; x=1733790263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=769c20wy0Vv+GBDNra53cIKjEqA3OwLkS64TJk5Hd40=;
        b=mCZHpaQZ/Lr6ZjfjgApQIuGAoAD+IuiUX3fzC7UqJn655D1yIHmEMM7xlXUY24+/dR
         bN926N6+IhlfePJ0fUmlOA/gQrfg6BFzLwApSJkFoOYqqFgeeUomq1hn9sMKwfYVgJm5
         GpLGmZc0cnx6mbVbnnHqGzul8SZzYri2MGoIexUWvBxNvRTAcTFUhstvAC+GccgRIWHL
         NSZjSPbXDmLRwHwofU1EzW28jwxcmWBerupM1tndiQ/j1IRxrFZ+dp3Y5meMx6gKpJnd
         jHovQk16FPIjnV7hb0bqd4X/PS62LURK6g+vbt37YLnaVG1VEcnvLRhrmfseR067vU2H
         Lojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185463; x=1733790263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=769c20wy0Vv+GBDNra53cIKjEqA3OwLkS64TJk5Hd40=;
        b=lI8CWNBhXSTkWRQ7le2ui6Vidld8YnAE8QaPqNd4XOXVXdFxmRHmCVaekOnwzN5P/F
         s+/9DaJ6bWXMmYBatDPSfN1cWV4TgI8uak4+ewle7QoeULo1ABnRIzE/qsPEHAyq1Zhw
         SLajEYhufnO2Ked0tpACwefk38Aoy/JANxp6u2uBOUodKOn5Gx89qWIby7+ezda3afPP
         HCEoic+Wtl6isBEwvb9k45UxzEiNNxWPcl7NjQu05LISvkpa3RirzHaLDT105d3ooVpJ
         Uq0MmhkD4Tj1pca3d/zPKzQpHOIrM4+S6pv4iOTvIxtM5W8EE7y91q0zgNhx9D+MtUdN
         mliQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRNv+zL+lKxMh2tQkSZYWKJo6vank7phKgv4YDf7j3jyE2c5osTFNrVyAbsyP192n0jgdl1xhZnq21LKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lAzqqF4I4byidJtWWI2wqG9iRVReXV9XDtMLb7qMnHZ7Ax5T
	RAnMhUqB9WLvliqAPY2WXGMPxNRJxzT5tnmude0COd7A5dDcVY+IArwLLj1yp1vAqBO891n6sr1
	gGR5f7tAw1ygKldlLKGRi7GVIh/U=
X-Gm-Gg: ASbGncuT9XbR9scvEREnqWtcqHlObWleITF1kSGU0rBqft6jP6jmsN1uTLLmBrKwulO
	l129TCGxG3j+LKueZZb0YT+PzLwki1Q6RVjWCLBa8tIW9KkvsyTXaTwgeQ7LoYGglLQ==
X-Google-Smtp-Source: AGHT+IEFO7KqdcLAxyn/uQOZcHSTfFKHJ188mKQ98vsbqhUJI1Nakeqcl4diWmzwM+nQJadnACQQqvfmmPle1QCzT8k=
X-Received: by 2002:a05:6359:230b:b0:1c3:94:8ffa with SMTP id
 e5c5f4694b2df-1caeabc2133mr97690755d.22.1733185462641; Mon, 02 Dec 2024
 16:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-2-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-2-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 3 Dec 2024 13:24:11 +1300
Message-ID: <CAGsJ_4wg0MozOt5cp3unbg4pH5eb9EPVt_kdM8u9LoF=9iTohA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
> which is already checked by the caller here. Skip it by calling
> __mem_cgroup_uncharge_swap() directly.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Barry Song <baohua@kernel.org>

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
>         }
>  }
>
> --
> 2.47.0
>

