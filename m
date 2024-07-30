Return-Path: <linux-kernel+bounces-268271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8535394228A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303051F24C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873F18DF96;
	Tue, 30 Jul 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2H1+98X"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49931AA3C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377088; cv=none; b=H09WJ24p9c+zFHMl7slVCXO1CWL2wDIHrgO35rcH8UCkq3+4+d3IsECvVgHLBumJzTJZhWhXvwMpqcL4xMS8a/OMsY/PRx/jNZYTe8KoZNmpbYR6f/hzDbr+LWW2lIw1YqKkFfXc3pYKvIugJnRJV9HuQMA2qwpGn4TDDfSAcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377088; c=relaxed/simple;
	bh=JNUuu08aetr0kAyJKfiCeHBUw+nwdSQtOt/9BVqIqAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBgIXXtJHem23EFzqceebcKxHwMmtL5EOXxLW3WR2shOTCtNyyOJ3fyT1zCZR5xPeQv6cHIf4T9/NES6YZvbDhPEM6nvvabtHnAfb4h9yF7rwlegQd/juH+NCHLHtBojsFyXJJGlSCh61K9El9gX4a5w0S3EM6uymxe+eOzzuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2H1+98X; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b97097f7fdso31856106d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722377086; x=1722981886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNUuu08aetr0kAyJKfiCeHBUw+nwdSQtOt/9BVqIqAw=;
        b=Z2H1+98XWJ4opQ8LpmzoqIol7OlA/LZBa9t78FiGApyJhIyJpxqb6V5db51fhqgIuB
         L1Mq/MmNF8ZpH+ttpcpY6RtJGEhjQodSywXXfWbHxgT7zQnZplcYVBX0p+oMTr02o7Qz
         7taASF7i/PPn0ZJ+SZdhY6+R/DYZibU9vsDHdet0i+gDLQYVyB93Ubsrhx2eBevIDbwG
         1UpeqKHVhx7qXBeoYF1fkYLQ6aJB4FG3zB7k0OtbGm2L6F/4WJbOYmM+Gmdkxw71CLr9
         T8diJ26gfKHxHbgyLHDIGrOM0cCGXVxKzQCpSQ43a28zcVNlE0XRzphn7ApY2qBrjPSM
         0vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722377086; x=1722981886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNUuu08aetr0kAyJKfiCeHBUw+nwdSQtOt/9BVqIqAw=;
        b=JQqIDXyXeTZlihVst+ckkeU4dc9c/OkheTb1aYbPpQoWobhbXFnyDmddmu51Z/Lpyg
         0xYafbw94+UyXawNnYG14J9PGO0nn6Dn++BdIaPWP81wNZVfQzHfb0+855df9PUNyNsW
         hyd7SbIEK6L65ZrCLmxxFP8e1x1nKB+Ezzva83xiZy/Igf5MEsKa98WnCDTAKbTJQIcc
         KfYjxG1HH/7LMxF21OxF/BmbC4EoWhF9Hp40ggEf/sqC+gjdcsHDWlWC6HOSQ260biJq
         iVFOR/vIIR5wm8N8w3Mp6qHWenm9ALFto8dt5U61BYDIthi1pH42mfl2tlGzRbVlRobc
         JTwA==
X-Forwarded-Encrypted: i=1; AJvYcCXuKQcTb9ctcPrZrJrpfKAwUD+Ci73V+5ZIxKF7jcyxZVqsjoOTzKrnrFvxblwmj9RGTi/WqlwEoB6Y434uktb3yz/r95wfPCLuwm1p
X-Gm-Message-State: AOJu0Yy0yRg7Y6NPxpysuX/pbgr0G+A1Movzbzc1QB8A4Pxey+Pv2Epo
	oeG6kjI7VS//rQYIbMZlaiq2hFRprUDiu0Nq69acjCFvvyhyknHvACXsmtQruhTCOr4cZ2lOIb4
	oia7J0tVvj8FLgs0cMTvkdmjIv1Q=
X-Google-Smtp-Source: AGHT+IGti6ygUSDEPOvtPmC0MgdDJOv2wcoxn3kUfSFBqhd1GW2v1xZ73SkeVnsrMBGe5103du1tiR8KtkaqbPo5PtA=
X-Received: by 2002:a05:6214:4119:b0:6b4:b179:8eea with SMTP id
 6a1803df08f44-6bb5597d3bamr131210226d6.3.1722377085642; Tue, 30 Jul 2024
 15:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com> <20240725232813.2260665-2-nphamcs@gmail.com>
 <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com>
 <20240730033929.GB2866591@cmpxchg.org> <CAJD7tka1tPA=qGFJcf4n1MM20A4WoL0cA28jDcyoc0y+48+0bw@mail.gmail.com>
In-Reply-To: <CAJD7tka1tPA=qGFJcf4n1MM20A4WoL0cA28jDcyoc0y+48+0bw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jul 2024 15:04:34 -0700
Message-ID: <CAKEwX=OTSD37qznj9dquA=VKHxGBkdu2d=cYZRwTshsjwtGcBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, flintglass@gmail.com, 
	Chengming Zhou <chengming.zhou@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:46=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> I also think it's important to clarify that there are two mechanisms
> that control the writeback rate with this patch, the reference bit
> proportional slowdown (protecting against writeback of recently
> swapped out pages), and nr_swapins protection (feedback from swapins
> of recently written back pages).

Regarding this - perhaps I wasn't being clear, but I did include both
in the changelog. The latter is this paragraph:

"We will still maintain the count of swapins, which is consumed and
subtracted from the lru size in zswap_shrinker_count(), to further
penalize past overshrinking that led to disk swapins. The idea is that
had we considered this many more pages in the LRU active/protected, they
would not have been written back and we would not have had to swapped
them in."

I also replicate this comment in the nr_swapin explanation - see
struct zswap_lruvec_state.

Same goes with the second chance algorithm - I did briefly explain it
in shrink_memcg_cb(), as well as the changelog.

>
> Maybe we can move things around to make it more obvious how these
> mechanisms work hand in hand, or have a comment somewhere describing
> the writeback mechanism.

Hmm let me add some documentation for this near
zswap_shrinker_{scan|count}() definitions:

