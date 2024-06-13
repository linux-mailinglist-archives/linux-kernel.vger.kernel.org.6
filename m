Return-Path: <linux-kernel+bounces-213622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F79077DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC94A1C2414E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84712FB39;
	Thu, 13 Jun 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sal+bMI+"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C38A23;
	Thu, 13 Jun 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294899; cv=none; b=hAhgjomdjjvsryakO5LpIz7iVaFhYF1KTzd2XJwaSQsze0hJulvf36zIi9wUGEoPO9Q8lR246M+7OLfRABNMphGBsT/copMxGif0nm4hxigzsTO0d8zJT2PoAWkkqSuX2grXbsDx3N8TPaId9hWtUd3Qr5gHaozGp5b60L9xrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294899; c=relaxed/simple;
	bh=Gb0Fl6tht05rZTeCNYRhz/ufV7pO3QDjCFBjJjIDfXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGoVt7hQ0c3HTPeF9YvE0sMN6V0RKGBgogzB2pV/n3v0AYekYaeoa+Kwq8S+CyIIHhV8Rg1EouCU/2zDycl3cfFhIwv2jL/Fq49y+uWVCRrQA1pB3wV97FbK4RW0UgGYpA1jpyjTiO8a6HLo/YyUOFyaHl9HM42pBuJenIHQrEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sal+bMI+; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bacd59e562so594600eaf.2;
        Thu, 13 Jun 2024 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718294897; x=1718899697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqHB7d/fQOBxu70Lq3/veRtB4jM3A8VBQDLaIwljpU0=;
        b=Sal+bMI+oqcbj22cFbgJ27e76P7IOh/ZsfF78ZHBhaTqz9FO8abhu9ywfeJVWqNMSd
         YGeKCNNZBaQHasyuyEMQH58WRa94wURmaBcQsbn0jIlC0WkxnWAZQWAy33NA8n8dcEph
         /m4Nd8swPTEb7HhbuYGNIxslHWYtUaMdt5uewKUhrJid+Dq0wyijlavH+vbb4JT0+uZy
         HAfmeC5KmSXkFrBi228eNWAfqhHJjd4pqIeIBsSFAI3NK/Pmpdt4KKIrqhc11X7CTKXH
         SkBNBzLLpB4Ur3Ol6I06g1kcyHlCG2J167IfP9Blwc+IvAIkDonc2V4Pivgqk4xt+jD5
         wj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718294897; x=1718899697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqHB7d/fQOBxu70Lq3/veRtB4jM3A8VBQDLaIwljpU0=;
        b=qmWrougaimEOK4HT6X8pD9yRse9PuvQkQ1fawOVrHGdCnMSECLfjDiM5/TsTvi85zS
         biKxUJlOwL9l4ZU8Lcoptpqr++jp8o4f5+osiWuPFUH8n2e8mNHaaID5Kpmchk65GfnO
         wfSgcCv9jIwqWxuP9LZ5bh7QFUIUgXEgGOvwJ34IFLDn8HOdTSErsGdK1Esbz58ftiaM
         mrMLMfV2CIeBuEYA4FlsV57jhaTKBgBVeqtPnfqeudDB4FT/jggOGBwJ9qGsV4WZhGbJ
         X3HKXxh5LgdMW19rBJVq29jLVIw/dHkqS8ACNGAwUZj7BKpca8ZOSiIad7xoAZfWLQqi
         j38A==
X-Forwarded-Encrypted: i=1; AJvYcCXLo4NeU9sEHJCu9QeB5CC88XSZBmNuD1fmbtEPK8O0Cj9waFYb7Cg/g4ytM/UGILjcb1gDq763YR3DBibrf70gZjF6aMmSeOkX6ywUzoU2TO5FvVJ79FRIN9/3JeZkhzhSrQj75H3j
X-Gm-Message-State: AOJu0YwfSOcYCdO8est08n0qByW3Qu2gFyDN+rUJZaNNkB9rXG240Dvp
	WVRt6a25pPWQeNlgh7BNTzJxw8ZU1poIwUsTUWUDCbjtaJwOjw7TraiLGNVETldKdI3ZMi9/ndx
	DC9P/0m3A66N+3rqeACI5fuk65cLbpRe2
X-Google-Smtp-Source: AGHT+IGncy3iZuOU+YBrf6fE4opBg2nOmjMMNj1/60e1lgzQa7ypMxuR2TNW/Ek0QXpCbT3mDrtdp+Ov/ybyBvgzDGY=
X-Received: by 2002:a05:6358:60ca:b0:183:d2fa:ff5c with SMTP id
 e5c5f4694b2df-19fa9e3ed22mr29344055d.12.1718294896891; Thu, 13 Jun 2024
 09:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
In-Reply-To: <20240608155316.451600-2-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 13 Jun 2024 09:08:05 -0700
Message-ID: <CAKEwX=MiMMCrQCq2j1DDOR_U6==6pwbqqCnsaoigQ4aEqhgaaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 8:53=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that `shrink_worker()` would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offlining memcg and continues shrinking with the next memcg.
>
> This patch also modified handing of the lock for offlined memcg cleaner
> to adapt the change in the iteration, and avoid negligibly rare skipping
> of a memcg from shrink iteration.
>

Honestly, I think this version is even more complicated than v0 :)

Hmmm how about this:

do {
    spin_lock(&zswap_pools_lock);
    do {
        /* no offline caller has been called to memcg yet */
        if (memcg =3D=3D zswap_next_shrink) {
            zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_shrink, =
NULL);

        memcg =3D zswap_next_shrink;
        if (!memcg && ++failure > MAX_FAILURE) {
            spin_unlock(&zswap_pools_lock);
            return;
        }

    } while (!zswap_next_shrink || !mem_cgroup_tryget_online(zswap_next_shr=
ink))
    spin_unlock(&zswap_pools_lock);

    /* proceed with reclaim */
} while (...)

This should achieve all the goals right?

1. No restarting from the top, unless we have traversed the entire hierarch=
y.

2. No skipping over zswap_next_shrink updated by the memcg offline cleaner.

3. No leaving offlined zswap_next_shrink hanging (and blocking memcg
killing indefinitely).

4. No long running loop unnecessarily. If you want to be extra safe,
we can put a max number of retries on the offline memcg case too (and
restart from the top).

5. At the end of the inner loop, you are guaranteed to hold at least
one reference to memcg (and perhaps 2, if zswap_next_shrink is not
updated by the cleaner).

5. At the end of the inner loop, the selected memcg is known to not
have its cleaner started yet (since it is online with zswap_pools_lock
held). Our selection will undo the cleaner and hold the memcg hostage
forever.

Is there anything that I'm missing? We are not dropping the lock for
the entirety of the inner loop, but honestly I'm fine with this trade
off, for the sake of simplicity :)

If you want it to be even more readable, feel free to refactor the
inner loop into a helper function (but it's probably redundant since
it's only used once).

