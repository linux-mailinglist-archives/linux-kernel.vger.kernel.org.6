Return-Path: <linux-kernel+bounces-266711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06E9405AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8364B283D53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B214659D;
	Tue, 30 Jul 2024 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu66/o76"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A12114
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309335; cv=none; b=RFjNxgAz7Zt6vwUp3yfkrNn0gGZVvwl39/lrv2Qgd0ftwlsm3GCgYagvRYxJHhWS5/ZKxpzPHsK9Ka0hoIrzQgr7/gFsYQTW/ticBUCzSbX5r7E9JWdO/3eYg1aT6zoPly2V2GySLx7mXEO+mwei8lygVYSMfHPH6pv8wv9mfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309335; c=relaxed/simple;
	bh=1CKkz3zxFpHgFERnc0F1vpBPw+j05grDqYO4v5We1FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+khmx5/rjZ9N7or1EnstHwetJ4eY+yXVpf4N15ZH4LPv4pu6EWZqfgf37Ee57XHtMB0Q5wyE7EFUpY+lNb1B/8viuxEOhiQZE4t0sRPAGTCPa8+MF3T8nOKWDCW89o0zPEP5HaRO6meknJeFAdZrWYE43xtSwvF+LqAyC06xCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu66/o76; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7aed340daso25028016d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722309333; x=1722914133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nto1jrvILAsl/5NefBeJdv0jQDCPstv39lORcSktRro=;
        b=Hu66/o76b1+2PfFvELquXOjiN4O6HRzDZCLVOumOpHCJHH2AxF90vYYypK0ciPLcUb
         dOSpxIKlmFfs8+EeEjsMW8qXZ55Z5pOs1nd+z1OdLdZ5wfQO5SWejkZTF3qMuGct7XcG
         Xxt8yfh7Rwm7lljwLKuJRV8OEku9nS6tisQrWKWpyL+4DYIlCGx50fO7bevxKGhbRINJ
         kW/oI/S8N/KSEYntQ3WDgb09ZZjkJNli+nklWplZme3Fj2jf32Zn/2tjrssVgdVBYPF0
         X/gyrqbu9LrfQQDG+FH1TZiwIaoh92I45RYaQtQ448GqrR8iNIDttN9VPeiK0jpKsjhc
         +7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722309333; x=1722914133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nto1jrvILAsl/5NefBeJdv0jQDCPstv39lORcSktRro=;
        b=No6iwpi+zVCce02XXkbrQJuVO8MF2vEZlKyvkLIJ8ilUxMroeFENYP50zY+Y5gcOHm
         6SoxT+ojKI4vY7dS3iAxq9o0duxMRfXLYaLiumqguYTlvNf/ymqxKtFxFyiBuO3MrirX
         PTE61w0kvSZdmr+nsovYbGpotQdcvNx6jOu5+iAWz5qAbuf7P36LnFO2nlhPNRlhR1N8
         p4wmmcUKfUOij4rVXILBIhjOcTCSUcX9gKjxWDL2+X5m260S1ibsmPxx5JdzQWhxpFdl
         A5RW6E7SPTgnkq1iUGPmpPo8Mme6T4bnFWxNULd0QB1WOgA6Smru+5FMfpIaz2Fw5Zw3
         lkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVerA5w+CNxBoGlJvP0ckjYSJOyIPqufWnQN0BDZ4XZK1ZQX5gg0doEwWX17guqAZppWf+I3+GZ2RAB7YtQicFT5yi+0g5p0Kaqw2sY
X-Gm-Message-State: AOJu0YzPyTHs1IcEiGQxVuTBUQccpra1cJ5PTo7epldCmLXETvdLXAto
	TfbG1wt30rkRtdspiOoCZd8af3wRtN5PRocmTxd4F0vVih1WHfULlZt5nfarAEAxu/UIvlBB44Q
	qiR6VCqDdnxdJ9lf7YNE4+3s7E+k=
X-Google-Smtp-Source: AGHT+IGJLl+etrv2QedB/ZTbVHfGz4EgTrx1v64zlfElJwuxkhWZ2VVNbHeEaLNR4QUlqczzPW/niHtUEf5CYsIyEIc=
X-Received: by 2002:a05:6214:27ed:b0:6b9:9192:7948 with SMTP id
 6a1803df08f44-6bb557b5215mr114472856d6.0.1722309333076; Mon, 29 Jul 2024
 20:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-2-21cnbao@gmail.com>
 <ZqhZ2sFhZ3-lyqz-@casper.infradead.org>
In-Reply-To: <ZqhZ2sFhZ3-lyqz-@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Jul 2024 11:15:21 +0800
Message-ID: <CAGsJ_4xK2oiVFdGyquwieO-jfHBokVtMvJ3T0jCcOE7PJpoAug@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:11=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Jul 26, 2024 at 09:46:15PM +1200, Barry Song wrote:
> > +static inline int swapcache_prepare(swp_entry_t entry)
> > +{
> > +     return swapcache_prepare_nr(entry, 1);
> > +}
>
> Same comment as 2/4 -- there are only two callers of swapcache_prepre().
> Just make that take the 'nr' argument and change both callers to pass 1.

make sense to me. As Baolin also needs this patch for shmem, I'm going
to separate this one from this series and send a new version with the
suggested change so that Andrew can pull it earlier.

Thanks
Barry

