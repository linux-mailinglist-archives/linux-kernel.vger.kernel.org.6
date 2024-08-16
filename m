Return-Path: <linux-kernel+bounces-290041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9A954EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FFD1F22DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77416817;
	Fri, 16 Aug 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpWw8I0E"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE37136E30
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825660; cv=none; b=M1mpI16qBIdTnuTP0cHdfmkbpnKhXyJ7iZ9y1n5oNi3P84LqqMNb1akrflXSU9blh2DGLK8SGpPg1AuJvWb1USUxlTr2/f0kn1covqKdtO6fhSBaxMRFfITYi9UKHddMbPNY3UFG4CeCaPG0xgyNAqd1zYPpE9EUVy1DtT1U7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825660; c=relaxed/simple;
	bh=9+ilsaccI6ixtMBw1fHh/3BZ/A+5/QbvLWcuyZ8wu5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHZOR1JmHcI2rxz7mq69tTT/y4cSameex+Wj6JudsCBfKW3vdwEYHmJQVOlO+siH6OhuqHhrNod4iL0fT7nDHlPW8+2ug8DbTqpJpEQstagBdjJQ3nhqveBsAUgJG6gi7J2Lnc4r44gSZYQ6e/AMW2t4o4ymnP9F0IrEFcrn6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpWw8I0E; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-699ac6dbf24so21086187b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723825658; x=1724430458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7WwxLAS0ZUy5wWtJOP42rw5b2Ueq8dEn+7WiJY79gY=;
        b=WpWw8I0EaxGbXSkks2sj8hEi1emWjyKLSNT5yEdWgqO4VNFR+2wpcDcDWTyFqlNWXY
         TwrcBWvfV2rl+Ggzn2+ux1Xgoz4qnbxYOjYY9RzYmXfORrXhQegMTSoLkBOxCSU1Ny97
         d14i33Q4SL2xjTh/3gAYsazZg9tenMzSHuuk7kTaIfJA/IIOKgoCFVizfAkjaLXxjHKh
         TTGT6x9fD8Hm/B2PH+bGJoX7UTGP9ZWd4HhIZnunih9NVttSqdJ4AaWIFN+Z5/Rt3ANI
         LwS3C+WevtvIcpkL2TrI+BRc22HiQLwZs+hCf9I4tVmdiBufrOD6b1NBa/Pl6WGBCg0p
         3zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723825658; x=1724430458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7WwxLAS0ZUy5wWtJOP42rw5b2Ueq8dEn+7WiJY79gY=;
        b=nqLfsL2IQnksdcJscXIxgjrhxzlp7DDc1NxB1iUwVZl+BbIlXJVPJy7382y4qUnEnw
         8Shc9V+AKJA+IBcLd+0AElvLCoDNWJ3QCJnEhK9EnW1BnSueTNdU1584lQLZnlxcXJ1d
         RM2kvbKSptuClNJwDOgeby+7a4KqeCjAG5WPJdi9WXPDBwgpsC1s9yYYuzyHFsQijDpK
         Iy+zeCtAV/3W+yDiOiG44627AYNHnLkaNUdiJ6v127rOXCop/yBNUrcBRJ0UwYeHEJss
         nor0OFH+qPunBU4uqvUvPu9fKcN1chJfdVEOQRdsWUh0MmYS7KeQkQzh31ZG5N3+RLqU
         GSqg==
X-Forwarded-Encrypted: i=1; AJvYcCUyN+00Chb5FopYbHhditu1zRcYB5giGY1fsFpTBrJaj5D1VPsELXlR78GBPrzDg6jTFP+AsY7IqDdqN6yMR7Pf1+FsiBuwpdmeeScx
X-Gm-Message-State: AOJu0Yw4aVfCJCCBjvKzqB+v90rl7mfdPKGoeCn0lc0qwGOmn74DnJ9q
	VaTBhV5AkhcAQ4WN+jYOlv1av3c3yKiYi5v3JfwfiNWWUuwMFGeiImRKF19dvl/C4z/Rlz+ZWRK
	FrxBCKs7idMcMNUM8EzuZ/veiPvYejM7/Cfbq
X-Google-Smtp-Source: AGHT+IFS42kfS4NEIV9e6Cd6qxnCl6eGj9iWg4DjB95brRzDynPcHRqhZmevD3bVnTKtacXx9wDPy2RuXbvwtewuVaM=
X-Received: by 2002:a05:690c:3085:b0:647:e079:da73 with SMTP id
 00721157ae682-6b1b7a6cbadmr33163627b3.10.1723825658162; Fri, 16 Aug 2024
 09:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813204716.842811-1-kinseyho@google.com> <20240813204716.842811-5-kinseyho@google.com>
 <zh4ccaje54qbi6a62rvlhclysyaymw76bona4qtd53k4ogjuv7@tppv2q4zgyjk>
In-Reply-To: <zh4ccaje54qbi6a62rvlhclysyaymw76bona4qtd53k4ogjuv7@tppv2q4zgyjk>
From: Kinsey Ho <kinseyho@google.com>
Date: Fri, 16 Aug 2024 12:27:27 -0400
Message-ID: <CAF6N3nXmQ=+j5VNf16KL6Ma8RaO0o-Nv=C7reJKQOzdpHzWOsg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 4/5] mm: restart if multiple traversals raced
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

> I may be missing (literal) context but I'd suggest not moving the memcg
> assignment and leverage
>         if (memcg !=3D NULL)
>                 css_put(memcg->css)
> so that the is-root comparison needn't be repeated.

I might also be misunderstanding you with respect to the is-root
comparison =E2=80=93 the reason the memcg assignment is moved is because it=
 is
possible that on the restart added in this patch, css could be NULL.
In that case, memcg won't be assigned and could be left with a
previous, invalid value. By moving the assignment out, it ensures that
memcg is a valid value.

Best,
Kinsey

