Return-Path: <linux-kernel+bounces-343222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B2989851
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1F91C21057
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB3B137932;
	Sun, 29 Sep 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZKxytHU"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1E33997
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727649310; cv=none; b=FswExb3XIJJqIc6pGEaEy+m8JJ9wND88yoHTfmkkMME7qGEIqGZBVh1hdtJcLnl/6oGYfXpNieAz8Sh5pkQaznANNjDuqbPKPjTSX9wA/bPPLDW7eLMSzaDQmckNKFD25ef2ByfoqRhERLCts+s4/maZO2Ni7E3rqA3dz7mId+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727649310; c=relaxed/simple;
	bh=5TQHoVOlm/0DKqaIaI4Oa1Y3FC6UTT64+m7AHZeFOdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUYy2OqzJeR0ujeHNgk4ZRJipMWUGD6TmFd3FJXvk2620l+S9clhjp7B56GgjdRLTzJJ4NqZJP103y4XSWhT7llqhvhHO652Oc5ct2DhIAEDMmkuvLm0xhmCF8S63/wfzIUlUenKgYo+/JzSw7zVebqZ2hg8+4AUxQEgE375QkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZKxytHU; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb22e9c6dbso20743606d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727649308; x=1728254108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TQHoVOlm/0DKqaIaI4Oa1Y3FC6UTT64+m7AHZeFOdg=;
        b=VZKxytHUK/edelsxSL8yT75q+39Yxdl/wYWXcrkBn1LSoMgfzG8lipxwMeoScjF9J+
         BuZPMkSNU9fLV2JLUF9PI3cmdMsX4/hz5f9nM4KVCojwlXEo/DesmMtr41Tg55DGZ5sX
         +s0eqZLZVKHHoKaq3ndEVeRXirRaP1+XnuWDqpWEAylLPlIw06MQVL2oJOveOuWiB1oP
         zPYKqiuvY7l6gp9LtVgmhPhs0tEBPvo/JXiv4OqWTdfiamSO3vWrymTP3cp+T2bhAMlA
         Bt6nSfKQW1li7IfA3c/cxnFHknZ2yYeE74edEeyiz3kuUgMwnpeJTdobpWC398ucaV9O
         HoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727649308; x=1728254108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TQHoVOlm/0DKqaIaI4Oa1Y3FC6UTT64+m7AHZeFOdg=;
        b=OtJwBfcgJVNunv0sWyTiMDxmEN5Oen6p7EY4RcRrm3Zu7caXVPsTMOez1VhMRDNYCK
         5ieCmysImi+cihA234+Cfpbm/pkMYY1ZuQcVHB6SuK3w6KZx/+DGvXUD6/e1QHC+D+oL
         SsJ2iwan9GQNgoVFd3xdUBpQdqS1S0gHoIVNmg4MELXpVpx+c4uEcK1lff7ZE+GLQXle
         gP3+dlHX5oooo3d6lraXzfu4RuKz9TcgCmgQSIlAKz9IgRcdapmfghddJ6OHwFHPWXlE
         xy1bQZWOr+4tGYZg0m7BneIxDwzPv0SqERnP2/Yl9K67u2gOGc/M1Yy55VyhtUkbbYXj
         hnyQ==
X-Gm-Message-State: AOJu0Yz+xBPI+nFIdFlsl1s1kMB4KRLJKW+dpSTfWVE2qwXdL3ag4xjg
	JDugQEDpUbVZPWMrYezgyw6okrGLmgJ4KFmeEAO9kok97A0YTW8lU1M6P4cgAOekZspfloxuZOU
	aexdEguN9Jxw8BXpGiTCMkw2LyBs=
X-Google-Smtp-Source: AGHT+IFGuWetQ+y44T2KbgdFkGPyCCCRseb0awxfcoy+PJ7xstfrtGJRRizCNly9mCjCii9e4gSJ12INwKF4KKWy960=
X-Received: by 2002:a05:6214:4990:b0:6cb:5459:9b6b with SMTP id
 6a1803df08f44-6cb5459b005mr93474576d6.17.1727649308177; Sun, 29 Sep 2024
 15:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-9-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-9-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 29 Sep 2024 15:34:57 -0700
Message-ID: <CAKEwX=P0tfz01r7kQgmoZVeChHjk9QPb=9yTgeQk34ndptocMA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] mm: Document the newly added sysfs large folios
 zswpout stats.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Added documentation for the newly added sysfs per-order hugepage
> "zswpout" stats.
>
> Clarified that only non-zswap swapouts will be accounted in the existing
> "swpout" stats.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

I think you can squash this to the last commit (i.e adding the new
stats and the documentation for that stats at the same time). But no
strong opinions :)

