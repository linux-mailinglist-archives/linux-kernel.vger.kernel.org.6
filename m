Return-Path: <linux-kernel+bounces-280051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26094C514
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEA11F27E62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255ED153801;
	Thu,  8 Aug 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="3BYWlPcu"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C95146A9B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143972; cv=none; b=RU1olz7Tc7p3cWupNH07ZmN4vXZXLXzLPXRaZaSdvCSJ+N91q6ZG25fISmDvuyWn6tgsA//cCwiN1pspwOeF81jN/UMQMbxMqFNelFSKnf5dPYhc0UUEbpapIxTnnCN5QS4UTj/hm+zOZPNuFwMVKoZArVVtpnAZR28izJVeOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143972; c=relaxed/simple;
	bh=7A+R6yMU9d6rQjFJ5o1iuGrbrwZ+/nqdudiFO+Vr3EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uw47nIrXlFBEm6eR8jT0wuXYnOCg/ql/F5hd9Fl74DVZvfLHI2p4pLk2U2RLJRyxdrSnNdD853fWMd2AezB8+a+exyJVlqKAEAMlUsZF+uguOgKOjy+PTgx0zEUpcNecCyDeJob80GHTZoh6/KXXut7JfqnJCD/2Nyb28pcwh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=3BYWlPcu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d067d5bbso91930985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143970; x=1723748770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A+R6yMU9d6rQjFJ5o1iuGrbrwZ+/nqdudiFO+Vr3EM=;
        b=3BYWlPcuUiu4MJybLy3Fliluz2VjfYLv5zELQ+EQvTKAcJ+hCVX2Ar1EisJmO8HfON
         Mfk4JyWxnT80Q2a4f8HOXGyqztLFzvIU1uefNA+oTiiqK4Y0MnvPDWBIgxn/rELjLcAI
         txHUq1YQ1+4frKRK2kN8xraiEKIcuiY1x/yu7rD3ERrZoyWGWfPbGTBy7vyYIeG4bDRK
         76pY0MsMTYlYo9+CMcCYhLppE+vHBJ/NOgrygOQWrNhsUcI9lhLXA+gxCXXhjeg4GsMc
         639Es8sp/IEfWdVmUYwa0w8OYVPRhz1vwphvbZiyj8/0qBCaUfCerr0l2PYOXehaW/rd
         96bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143970; x=1723748770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A+R6yMU9d6rQjFJ5o1iuGrbrwZ+/nqdudiFO+Vr3EM=;
        b=WQmkkICT0DCXQC7YdxLUJMLf+rw5xxEz9WqeVCIBQX30MDaSuBWgk+S75BSHyDsB+c
         dCVkAxt+dhmpkopSOaa1fhcuHqYSt5KLRtEogUvn7ifEWywIeyl5lU3lV7tXSA2RzMxV
         oy6NpF943Rz1yyG+m4+Oz88QbcBwZ/ceI2Ye6kkaZMhmG/Z8lsXE2CiPLATt3ml+dz6F
         PIbCcN6fPP73mODAhtYlm7LBsWK48bAl/y+i47lp0YdTvswnIt0Wh4Aw912kN3ZVtnq6
         3jX9fwgb0HxoeGEEPKO+OD+6/ApjMhW3mdOxMLwaLicHrZevNs4kouIu46iDjWn9cxer
         c3cg==
X-Forwarded-Encrypted: i=1; AJvYcCXFG89WlnqWYJCKEDyqdvY4VhE1l5TRUoj8ys9k9d8Io4CtV4j5yZjuT+XjUhnSHmZjf4MM+AbN+gyJviSSKe5YrGM1GIrWr5qqFQtX
X-Gm-Message-State: AOJu0YyhRr2Hl1HqthRJtFeF4uPp8670OWEL3vc+e5gpQymLd8Mp1AYA
	7p8FIE1k/MXEw3qPB7dWYuN8uHUgkz8aioyB/nj+uPK6tTym8HE3a/vy9cUP6JNvgwOMslzDnlq
	638TPgmg326Ik+0J1Ux64aiwfTndgOjea3A7FJw==
X-Google-Smtp-Source: AGHT+IGCNR6tOOc7zjRc+Z6edE+0iR8kbni5q1QhFVJ5IjBamDJUsGTUSZ80r6e+xP9C/Z5Z3E87bJ+J0HUI7bU8HDE=
X-Received: by 2002:a05:620a:4445:b0:7a3:56dc:d414 with SMTP id
 af79cd13be357-7a381872973mr296729185a.49.1723143970021; Thu, 08 Aug 2024
 12:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-5-pasha.tatashin@soleen.com> <ZrUUnm/pEpPS9ltC@aschofie-mobl2>
In-Reply-To: <ZrUUnm/pEpPS9ltC@aschofie-mobl2>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 15:05:32 -0400
Message-ID: <CA+CK2bD6wMh2svqf3vhj=53=EUWYtQJmJXyTRkLBm49q7KJFtg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: don't account memmap per-node
To: Alison Schofield <alison.schofield@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, david@redhat.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:55=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Thu, Aug 08, 2024 at 03:42:37PM +0000, Pasha Tatashin wrote:
> > Currently, when memory is hot-plugged or hot-removed the accounting is
> > done based on the assumption that memmap is allocated from the same nod=
e
> > as the hot-plugged/hot-removed memory, which is not always the case.
> >
> > In addition, there are challenges with keeping the node id of the memor=
y
> > that is being remove to the time when memmap accounting is actually
> > performed: since this is done after remove_pfn_range_from_zone(), and
> > also after remove_memory_block_devices(). Meaning that we cannot use
> > pgdat nor walking though memblocks to get the nid.
> >
>
> How about directly include the failing cases and user visible impacts as
> reported in the Tags appended below.

Do you mean adding panic backtraces or repro steps to the commit log?

