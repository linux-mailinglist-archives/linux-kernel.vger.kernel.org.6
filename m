Return-Path: <linux-kernel+bounces-527388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74673A40A96
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E1E7AC9D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157B1B2186;
	Sat, 22 Feb 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhigRMYK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE9130AC8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244806; cv=none; b=cMyKoyeLyAjbIamy2yZua3FvrvD76Qmgig5Z9Sc2Pyklv0jnQiUshN/zEOHwEdskhkgApLmaMBspNpS0ngzqnX0eHto+9YAcnqyVRXkrNh1IVcNlGRCNszw3RataHzSc/n5jP0ULGOzsf0yry8aEqgAg1H3PAM4WYsMKM/KdN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244806; c=relaxed/simple;
	bh=aA8xlusdxINetCnqLAKfRVb0p1j5MRYEmGHFMK/LDNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN8f6oPoAbKT/+V01LaMeFFN2czmAIGMwnioHsn7vY0fr8HJ7iXDZlzkPf/n4MfQlwNrYXQ56WP/KK+uCEKAkWuGA6U/hYNVdJOvPLuqlNdVzI43T5Ebmu/KC5rhuwnlDILmg6BdyZDGKEyMn+B7eqgefoef9tSVuvw5OcQAT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhigRMYK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso3656559e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740244802; x=1740849602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3PyMY7ETLfzGJmNaB6aZaX0aC+cfjCRc3HqGVEYblQ=;
        b=MhigRMYKziPxme8XXkYtYR8dtkFjmsiyTMHxhjo7yl0vRGrs3zR4TDI/9MrfNgLzqM
         7eApOUKOQrZ1UJuBQd3JkLAOZdBPilwRm4KbzuUA3mkvcR6Bu99J/WaXGa9vei0b7WfA
         ZwIM6W5CapM5l6ZC9JrY7Ma/DKpwhYRpMAS/yCuiJRSQZ7RfLfPew+Sz/9/gsAsEsxxK
         lh3SYTZpU74ubi8g8uP/N4sZd97Bq6/lcyyLSnCjYe5FyhG2x6CykFtLMOsVFnMXmBoh
         YcYLMkXN/BLZq7V5Nxla6EM4P4FPEo6k5a1ZNFIp+2rfP31/KiBrpO4DAYKHujdM6qFO
         8auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740244802; x=1740849602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3PyMY7ETLfzGJmNaB6aZaX0aC+cfjCRc3HqGVEYblQ=;
        b=XTq7eK7I3R+BkFaNn8VcYAbfOM99eqGU4Q7zBgMyGcBIg/Hbg2ayjO4xg+hOqiDVQq
         kvy08kxH5lrYfZKDTyzWH2cgrXTUAc/oqJErvz4Ek+f/D3rIOD07gQF7gQMX3oyMqPyt
         tL2DemMoZ/AoYtx6CVUma7kJgfPkmtQsLXXdf+QkiPq4zGvr5sS7LgJ9rLFg+uMPgoIs
         60Dhpl8zQbDPsRZHdUHMpNDoSRyF1HBLnSxWfc3StHDsfKCKZG6zJdgxp9DUIpk09P17
         ytSRMUQBREz3WUF3KTcMCAmoFAtEupmpWOQbfa3Mr0XWX/5ry+HZPCOAZ6jQ4KwWeF4d
         mu6g==
X-Forwarded-Encrypted: i=1; AJvYcCWdr7xp5Zp/DMEkzedU/tU6wwhmnWkVxY/QqkcyeeZu5MbHuBmOLNqHjvmTK7uQiESvkIWiGQdz1RSeaxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBpqjxpy5tbx8lMhOBafyMDihsA2mJCq/lKQmdiRbM1xK2UCk
	oLyq02f6ArXlRhEkfFAqHgsFgOo0qqdor9X/LAiaa8mM+Zc0Y00FSJ5HktYFs8j4WK+zuffQdeO
	j7WJtFUoHeavlMsOSRdjfGuAGcuZp+/eBCVU=
X-Gm-Gg: ASbGnctbVM5UBzV3SjwzTR1FMLaVpbABvKH7elLB1DsS6/mXYOr87lnib+iQcQWurhR
	177t3S8tAsU62xowyXVAFDLf14kApi0FG0vFWEq5JJ3A/MS/ApCMBcPepD6mS80f9bcUUvJ9zQz
	pgxyjEWEo=
X-Google-Smtp-Source: AGHT+IE/FZvw3/VM+wGOh7qRebtqxFj4oAyJsrL3WYhsS8fTAnUQTp+Yx2DAqLG8PV6TEfOWvnL9TwBOsKuQhmWcV0c=
X-Received: by 2002:a05:6512:2310:b0:545:16a5:10f5 with SMTP id
 2adb3069b0e04-548391452b5mr2550836e87.30.1740244801904; Sat, 22 Feb 2025
 09:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222160850.505274-1-shikemeng@huaweicloud.com> <20250222160850.505274-2-shikemeng@huaweicloud.com>
In-Reply-To: <20250222160850.505274-2-shikemeng@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 23 Feb 2025 01:19:45 +0800
X-Gm-Features: AWEUYZk1ynD35897TpB1IPblW6vptdQImUZiwCcYnnAFD6T3Jhk7QLCtyqLTdNM
Message-ID: <CAMgjq7Axk-rh+3hMpSisxKRU6W1tApgVA1H5zswC7z0q-t0-eg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: swap: avoid losting cluster in swap_reclaim_full_clusters()
To: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 3:12=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> If no swap cache is reclaimed, cluster taken off from full_clusters list
> will not be put in any list and may not be reused. Do relocate_cluster
> for such cluster to fix the issue.
>
> Fixes: 3b644773eefda ("mm, swap: reduce contention on device lock")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/swapfile.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 34baefb000b5..e5f58ab86329 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -861,6 +861,10 @@ static void swap_reclaim_full_clusters(struct swap_i=
nfo_struct *si, bool force)
>                         offset++;
>                 }
>
> +               /* in case no swap cache is reclaimed */
> +               if (ci->flags =3D=3D CLUSTER_FLAG_NONE)
> +                       relocate_cluster(si, ci);
> +
>                 unlock_cluster(ci);
>                 if (to_scan <=3D 0)
>                         break;
> --
> 2.30.0

Thanks. A little nick pick, "losting" is not a word, I think you mean "leak=
ing".

And BTW maybe it's better to describe the result of this leak in a bit
more details, "cluster leaking from lists" and "will not be reused"
looked a bit scary at a glance to me. But realizing it's full
clusters, they will be moved back to a list if any slots on them are
freed, so the worst result is inefficiently reclaiming of HAS_CACHE
slots, we didn't really lose these clusters.

We do need to fix it though. So other than the commit summary and
message nitpick:

Reviewed-by: Kairui Song <kasong@tencent.com>

