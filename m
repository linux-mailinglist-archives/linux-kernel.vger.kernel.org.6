Return-Path: <linux-kernel+bounces-520729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA7A3AE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ABB3B45D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906EA1B4F14;
	Wed, 19 Feb 2025 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N5d6Wgvv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2F46B8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926524; cv=none; b=tRHPvnPBVbEKSMpxM6AdgOcFec6RRv9FwbBCJBNB8PiwGzAwuEr7e3wUBYUBdTRnNhVwbBVxAI+0T2gRNbAQojjr/FCzZNKrD30J4/au6FdWhuyrL/3SoiGdL8iX4EUSuwQNxxHmOQE0KNQAixVjashIFfYWi3Uik1u/4X1YgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926524; c=relaxed/simple;
	bh=0HD9f6Q0+um9Uu9vpR4Q8s30w3Xw/Vd5V2C8wzjWp/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fahlXYjQngFFomANCA7+M5LorPcM6SXqzc9UOJzN0ZHVDsnbVlT8Krhtzu1Uot6BwKTwUFZ0yoxHbbmVc8onFOEvwAqzGzAEuB2hWH0ouyde8LxNAYScH1rEO0GEoa49zaBw2TGQmSSioWBLmGSOGTWWC2Y0dEIwjukkP6S6NQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N5d6Wgvv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4CC343F29B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739926519;
	bh=NLWmLVqr39FXw4/AXsNpGlD7g8VdYK2vZxqlgBh3Mq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=N5d6WgvvtZDo8ZeXzDv5Do4QRSIEVotZC7qpGDZV05/56tQZItDPLKBmQW4R7tjaZ
	 CSq550HClqf3+EzXixM9RbtQ415uu1N72768GKXBDihk7uEjrOR8Zn7/r1o8vzx0ny
	 vmd+XcucueC33PJ9FHNqye1oFttYE2JtII62UGh8OprpCsAJBxlJtteRuhAa7CsBXA
	 gBhwOyD2fOiqD4j1smOxA/qdUhNlsB49RvdMmC5Yo9edWsfsjugeruKTRwy5LV6JZS
	 1UyRXieaVtEDWfIp+TKqgO9rbECAC3meNkGqNfvjv2wkDpGeaSMg7UBvIhlkQ8OXQ7
	 CG8cyz8ujnUOw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5dedd23cdecso5528094a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739926519; x=1740531319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLWmLVqr39FXw4/AXsNpGlD7g8VdYK2vZxqlgBh3Mq8=;
        b=sN/KivzzignoJPDe1OopEOW8ls20vyEcDf+5rhw6FO8d4hDm4BqhbZjbNLqaVlbUIq
         UxQsKedkPQ3YAp67HBPtFvh4WhqyTzrOfiVL5Ww7c9h8RdGLrNKkX+xys+IXNOYyHUO0
         gLv7AccjeaJsZ8Bjv8Q/z3TdCZ1nczbsVINoMmwCtXSklLE2YEumjfvG3047PTdp63VL
         jKgIx/mgHqM8uYVfzPgdtl4sZ3+nhz8vzhE2ijLVYnKqSGSFB+Bnn9cfB0EEf5twjV/r
         sab7m7W512pHsZp2L99RS2rIjFp/sAX8asRIQys9AXD6cggTUPdC5t26hjmGH7ZOcG/E
         9RcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp6TAyTMt1W3lYT3ruzVcZ8JgbrGlRdOtlg8OkVbOob5xlyu9R0Q5muJUdUMPB3gjU9ZpPPn2G9JKx1Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2IfH831zrF6BMWeJqvbWYtNUosRsHDwT9dRLuajUDufWZ3GP3
	LQsnXL97jT03IVdULJr+lBZHqZAEIYdwzD6iaf+itRecGiewBMyY00ZYbnJlxaLevRRIgRwGwKE
	ZKXITA+29T2KQmVr/LK7Rh6sgKd6Ea5axSNz71qOxD3Lg/FTTUZO7vaJmdhxQLXBcw58KafV9Zx
	2fxx9j5Wn24ENE+eaWFfxDEmm5/dv8Y5N7LsZJ/4E4AxJga3BYKD1w
X-Gm-Gg: ASbGnctFAWeArEqc9042mjVhbDN1FnNZ2nroBui2da/BMM7ZDEUKU8ZoljTB1iSaP9k
	Y78i7soj4YSxKpI0QPC7vwY3R/xF/WuKcJ5k/eFapX7xOjSeJm0u82ZtFUHGP
X-Received: by 2002:a05:6402:5246:b0:5de:39fd:b2ff with SMTP id 4fb4d7f45d1cf-5e035f49943mr17649878a12.0.1739926518680;
        Tue, 18 Feb 2025 16:55:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT2uJA8DApXDK/hkpgpT6514+F1RAcaCyRGE946iObnvNukFLaBB3sPmzN2RQj66iTo73OWKv3q72y5RXj+GA=
X-Received: by 2002:a05:6402:5246:b0:5de:39fd:b2ff with SMTP id
 4fb4d7f45d1cf-5e035f49943mr17649870a12.0.1739926518350; Tue, 18 Feb 2025
 16:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
 <20250218222209.1382449-5-alex.williamson@redhat.com> <Z7UNsiRfdOWfZWuq@x1.local>
In-Reply-To: <Z7UNsiRfdOWfZWuq@x1.local>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 18 Feb 2025 18:55:06 -0600
X-Gm-Features: AWEUYZlI5D_is7dzf1BazOzKeFxBNWJyWcCvq6K9QTXLgIopUjBtOh6ETRN7vx0
Message-ID: <CAHTA-ubd8eTAt41n41jTR-O6PH+aVMvufghtYCja5xv3DwC+nA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] vfio/type1: Use consistent types for page counts
To: Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, clg@redhat.com, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No change in behavior observed from v1 on my config (DGX H100). Thanks!

Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>

On Tue, Feb 18, 2025 at 4:46=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 18, 2025 at 03:22:04PM -0700, Alex Williamson wrote:
> > Page count should more consistently be an unsigned long when passed as
> > an argument while functions returning a number of pages should use a
> > signed long to allow for -errno.
> >
> > vaddr_get_pfns() can therefore be upgraded to return long, though in
> > practice it's currently limited by the batch capacity.  In fact, the
> > batch indexes are noted to never hold negative values, so while it
> > doesn't make sense to bloat the structure with unsigned longs in this
> > case, it does make sense to specify these as unsigned.
> >
> > No change in behavior expected.
> >
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> --
> Peter Xu
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

