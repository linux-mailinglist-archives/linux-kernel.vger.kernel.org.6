Return-Path: <linux-kernel+bounces-387696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7249B54CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B78A285034
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B2B209699;
	Tue, 29 Oct 2024 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8bEqOWA"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C913202F8D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236510; cv=none; b=YVWReFAaJlGzKJreI5Cje4zPdeZLIqAE/dvjiUjCNWDbM4YEAVSgeKVI5l1y7EchktWBb89M+d8DYelIAWeF9VNOhwt9XScrOw3V7eAXY+j59CSI2xlAVOP8uUM/iuIJe9WHCOS3E1l9nYeQVKvXfrVmaJS1DMjceAUfa/PgLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236510; c=relaxed/simple;
	bh=4TrdDCKfEgvhGXb+ZYfKmMKnSvr3m029ovWzv+E8mVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZHYah9c2uBX16uXw34031sT5SKAWTu7LrEHKWRlpYGH3+6UaZjamfDUHWrUGzE1cDTFqN0ZEXsatpIE4e1+7liR+YMia0ZvE0e27F16aSfB5/yotIsCfIqLxSG6hd4mpWFgcYJdB2CTq503xKxaYcChtsktX9sBplRiDi6gWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8bEqOWA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so4625110b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730236507; x=1730841307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TrdDCKfEgvhGXb+ZYfKmMKnSvr3m029ovWzv+E8mVQ=;
        b=H8bEqOWAXmChLg3WwYJ4hlOmngO03vjKXj0c0cheHCu6kswCHlSjD0oHkidUbpSm6d
         n4ovV7wvLEDY1yT9HySZbtX8Dm+FfYWfRpigkpr+yA4KiQYqE3U/1oEcxqG8Ghczxfmt
         eNcqHhSuIcd1Tkh9K8KhwyshPbKQc3vpPcHAnSw1UnbPJ+w2fPRmOjKp7+AAwR2fUr/w
         h5kGd4YugLjvgJBNa0ACSy66OMCFmcyRub+EPKpu1pBffCitopncBaLTyZwXUOpGbSmo
         Oc+19fO9bjEZqra5vRXPxpprwUrKHlFTiWk4Jvnq5YzSqwwlSp5/EfS3y+2Heoo6EHe6
         MdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236507; x=1730841307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TrdDCKfEgvhGXb+ZYfKmMKnSvr3m029ovWzv+E8mVQ=;
        b=G+GSxxezKv1vXzygH7uMdu6id6kGIt3fUKorIrVs6w3hdsAhkX9GEj+U2wewjJ1Wv9
         zvpv0pLobVLVjFzcSBlkiQHKqXiwb2j9SKC5+YlBMloOcCErp507uP9SIJfZbhRZ/RqR
         Ypph7/Kxwpn56rMxHK/tfmea1jU5Dpef7ZQkuv358Y92l6yZiedKU2OMhGec+Dk2isgL
         A4t/ezjFOlRgthSIJnSZF1yDpMHi6Dtmdon3u4mA0bUaZLvX6DlYU1zq6pjeyXWzeu0Y
         +4FZUC6fSK+vBzbl3fhCqs5p/2zbGg5sbUR62E+mG4BPkklw4k4DpjdY2+YDj8SuAURt
         N1xw==
X-Forwarded-Encrypted: i=1; AJvYcCWIYTSMdnioGv2+N1aEibyGFTny/Me9NDKKG/AK7Wxwt8tE6oZnWsxQncknU9w5KiEm4U8RWqAaSExOgUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+j8oDQFsYCSZADt8Z28bKyIBxvC4p3wczf1Pztr36DFLqb+J
	b1PtlA3PBlaVZ3DqIFWsTEX3GrEUi7OX5pOdkSSqa8ufF8G1YhYU+HP9DAPkl14GimhbA6s4GGn
	lkYc9Fy5naN2ferbeY6jjOk4hSMw=
X-Google-Smtp-Source: AGHT+IF5cH9weBxuQe5arr47haG1olMVF1DqvxpNpN7s8TRJz9srFGTnnSvSHeWnbD9SYp+2vDpw4WE2/z41mvFU4vU=
X-Received: by 2002:a05:6a00:2d95:b0:720:2eda:dfd1 with SMTP id
 d2e1a72fcca58-720ab492841mr1189049b3a.18.1730236506666; Tue, 29 Oct 2024
 14:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205231.1944747-1-surenb@google.com> <CAEf4BzZvFFXByMS-eyFZzt7055MHexT2h0FfKfSN83x_jYTZEg@mail.gmail.com>
 <20241028204822.6638f330fad809381eafb49c@linux-foundation.org>
In-Reply-To: <20241028204822.6638f330fad809381eafb49c@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 14:14:54 -0700
Message-ID: <CAEf4BzZODA7AkC6Y7d_fhGnR3MH8MV-0QZC6aKi0FfwJwv++PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: convert mm_lock_seq to a proper seqcount
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, peterz@infradead.org, andrii@kernel.org, 
	jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:48=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun, 27 Oct 2024 17:57:34 -0700 Andrii Nakryiko <andrii.nakryiko@gmail=
.com> wrote:
>
> > I got a notification that this patch set was applied to mm-unstable by
> > Andrew. But I was wondering if Andrew and Peter would agree to move
> > the patches into tip's perf/core branch, given this is a dependency of
> > my pending uprobe series ([0]) and, as far as I'm aware, there is no
> > urgent need for this API in mm tree(s).
>
> OK by me.

Great, thank you! Then I'll hope Peter will just apply all 4 patches
into his tree.

