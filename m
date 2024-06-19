Return-Path: <linux-kernel+bounces-221786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC690F88A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409411C21A84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114715A87E;
	Wed, 19 Jun 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBmiaPd4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AB77F2D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832826; cv=none; b=dgyYE1ra2rMmORxEMxv95M4VaW9GAwzsoZNkh1Qck3AvVT2FyZpcqMrt3f0t/4kW5d8UtlIGLSZeUSsrtp6B71buaNLx7rp0x7nHVSkI6XN7n8Aa0o/zvCL+Ku9EYIVyyAAROhjsqWDPesscm+tzPL2l00elvLAWoUSeRmlOS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832826; c=relaxed/simple;
	bh=FVDoRdh8K7mSFOE/o69xs6jRlJZ4GjAMAILSSsowHPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOZZhhoSkyZQ6qD53ZvQ4e4n3YsAnStyuz808Q91qPBGXxO9AUBjrtpVcXBxaGAWY6VruPn70XfFSR9Gnjd4vaIjWxHAcq6Q1yNMRk6hywwiOE7f6ZesRvyxKbcKp9ADdU1D1DMNdVio39n2uUZ97fu1dkT5sEO13HdgKWyI9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBmiaPd4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718832823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVDoRdh8K7mSFOE/o69xs6jRlJZ4GjAMAILSSsowHPM=;
	b=EBmiaPd466pR1vp6OE3xM6zicotxNOxiTAQYp1N2lCBeKJpBfyuFnNqwMrPHTAed66rgZY
	DO6nKmAnbafLlg4dFQPQCg/PPHVfZH412SbNLadUU45RUOhGhZbGx0w7q4Rm3hxYQiV6un
	4og/YWjsbP74g/6WgIVTuU5Axt7stuQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-mmGsHayJODG_NFRE0VPycQ-1; Wed, 19 Jun 2024 17:33:42 -0400
X-MC-Unique: mmGsHayJODG_NFRE0VPycQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ea892f8441so1064601fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718832820; x=1719437620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVDoRdh8K7mSFOE/o69xs6jRlJZ4GjAMAILSSsowHPM=;
        b=G4qT9DG7yoOOGa/DR3ghvPEPt8Tj2lcoRc1lHoQcKWUUUCxrUawhBwg5OqzGNFA5Wj
         ToU0kRNpnVcf4xjoRj5OOS5tq+gPWZj8LaufQDvSKMZ6nW5lIe25pM7pvc+/3oiqv+UF
         5juFfAts7xdespcXJyFjboVVCC3+k6kJ5zRFzx+SkeJczsDRLeTiqOOnnV12Go66+96J
         br7+1QVUNyEM6GBTu6NUqlHMq+yC5od5s2F2GHs6F5Q8CvDOFCTr5QUafXWXQbjXsmu6
         hsm8KPSoOrQe/fu52CdpGd9OheBB7ofWBS6Pev/Rx06yfsVP4liVBBSdmjl4BK6d9eug
         Dx8A==
X-Forwarded-Encrypted: i=1; AJvYcCXhK6KGwQDfVLbvd/tNTaoIjsExP7FcAB1BYfNYr/DjiK/IWj/efs4eie/heM5aiIfDtfQZcygsussgzfhFRZVbYr1hW9+GfgJ9RVKD
X-Gm-Message-State: AOJu0YzVub85UqoKecJDoBR3j5yyFvmxplKCiOO8GPU1kJI0Yef6nEvT
	A79swgr6cwNmK5mCup1YH3js5imD5LLEK4Mo4HvVd8+H242FPfEPy1CoaDOUJnLWBM1iGdXriHo
	WeEH20fYcBc17saf0qaRQ0NyG82VHxm+78x5AxTYe1eR0rEIbxq+POJRwfIk4gHuu5LJ1DjqQTf
	jGMC8rud5Abn8gOhDlm2z3FMb9rHN5SAD4iXnMx8cepU0KlRI=
X-Received: by 2002:a2e:9257:0:b0:2ec:27d0:b28b with SMTP id 38308e7fff4ca-2ec3ce9f6d0mr24030061fa.5.1718832820189;
        Wed, 19 Jun 2024 14:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsKXGk3yVltT7CT3arRWzPzx62uXtdeT/GyDTGGV35BOQ5Yu4GYQKTenCMS2OPm8GZP1fJnc5D02SNBCQ102s=
X-Received: by 2002:a2e:9257:0:b0:2ec:27d0:b28b with SMTP id
 38308e7fff4ca-2ec3ce9f6d0mr24029961fa.5.1718832819902; Wed, 19 Jun 2024
 14:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619050358.411888-1-lihongfu@kylinos.cn> <78ded683-9bf8-4f2d-9dd4-877aa86e0e0b@web.de>
In-Reply-To: <78ded683-9bf8-4f2d-9dd4-877aa86e0e0b@web.de>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 19 Jun 2024 17:33:28 -0400
Message-ID: <CAK-6q+jPMPoue9w+=_ZtEjE7AohRrbPHN93Fa=CbXtrTOyhicQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: use KMEM_CACHE() in dlm_memory_init()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Hongfu Li <lihongfu@kylinos.cn>, gfs2@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 4:54=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Using KMEM_CACHE() macro makes the code more concise and easy to read.
>
> Can the three passed name strings matter still for the identification
> of the created caches from this function implementation?
> https://elixir.bootlin.com/linux/v6.10-rc4/source/fs/dlm/memory.c#L27
> https://elixir.bootlin.com/linux/v6.10-rc4/source/mm/slab_common.c#L362

probably only for "dlm_cb" that turns into "dlm_callback". The only
place for me would be /proc/slabinfo, but I usually do `cat
/proc/slabinfo | grep dlm` to get an overview. If you are very strict
and "/proc/slabinfo" is not just "debugging" only and allowed to be
screen scraped (which I don't believe) it might can indeed break some
userspace applications.

- Alex


