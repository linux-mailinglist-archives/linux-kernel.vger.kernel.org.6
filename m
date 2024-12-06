Return-Path: <linux-kernel+bounces-435608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B597B9E7A13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07A816C8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF791DA619;
	Fri,  6 Dec 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv356JkZ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF41C5491
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517406; cv=none; b=lrpj+E6ZbsJiAxIG1SfQGKL888tUXVrYJAx0hMpy6qKExNrikAMRDvwoyOfydAzemVqmq23WZtC+OqdQauAAiw4dQrOvZBtoOxx/jJTDJnjf/ubfTlVpagsi+MABaB543QQY1873t/S7FT+u9E9QfOLRgN30eqJ++8umEtHFoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517406; c=relaxed/simple;
	bh=/id+wG1D9cmIBpBBvP8YZBNvko2ajxmLL0iDo/a53z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItQTeZL6C8xPgCNUxZm7EyND7kVPz+T+9S5oxiS/aTvrnH1Tk3Xo16yFpl8YhiOyByStGvU512hpU303+6pKgFR84YmQxjJs7EmasfnlcHD0rWUb6kuJD9z+529jIAz1Hj4K8ucDoUrJIwN9u44x4mVdvNqu178z5V6mwTgsRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv356JkZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so115147466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733517403; x=1734122203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/id+wG1D9cmIBpBBvP8YZBNvko2ajxmLL0iDo/a53z8=;
        b=Zv356JkZkoQKWK5HoMDP6MiR3odhGz8j9jkUya3fg5Skifg9VKu6ZcWojtRG7fv5Vu
         enRivsb9a+5XOhRAnm5+LF6e3UDbXUndYFS7HZfTFeuforZRNlqYWJ7medUsK+MyxC7N
         ipniMkyz8mu/7T5Cd9UN+UCwHJqzHrJxm5hOEhipChzZhO8EN3/mxsV8IHgrladq3b13
         sDmzEUhRrVmUqK57vax7hgyQplfvuReTLNQUncHbN8d03TaL7VVyZmcblry/kg6vW34y
         lLcMDlNH7rSu3H8X0Cz5qE3/rrycnzkTy2sGfZeQKSunGFuP4yUh8Bgls6yI09hpLtmq
         xIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517403; x=1734122203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/id+wG1D9cmIBpBBvP8YZBNvko2ajxmLL0iDo/a53z8=;
        b=QoRqJDB1p+2CpUT4e+oGQaR6tEiyEQxfH/j6cx3vzYQw1rDCqjYCNUM44yVYJtj7b6
         1jdz7aG8iXOQ2sf/1soHzERTexv5ehDh2DSwznkIMtSTLOzIeVRIarxQip3HXEwRN4qx
         tRnvCtyZmOxn6ab7ZCgQoC6+96MNxFZ4AKXZIZ8omcwJUttJqD+S/iGePP52HCkGsg1u
         aK49UaOE/KTQRgFh9Oo9RXG9gMCIA0yDgOgH2RDaysg/suhXCdpZsKX+XuFI8N8xDXOm
         FSgQ6dOjR/UmezSBzUPGkyhZcepkaUahvB7ImfhHOn4I8VdBJp8DKGnaALm9xqJfVhQk
         SryA==
X-Forwarded-Encrypted: i=1; AJvYcCWOId9CJMjAslDm56NcL6mpsNXZiF09trCjWEtFfIcU0vW+gaSK4U4qfX9xsL8WO3ZBuQtfsRDn3KRQHv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC+qcrRKkvo5RtfN0cmNy3kqVJ3KOgF5kAHRhX8gTED4FtJlH
	TNGZTRUlXuRMacgFTrJbNGyGUDgMRh1sCtEkrtsVLCc4S4Ds2noNGF/VMKNwNcCRR5uole+Rh3+
	FtM9XpI7jYK30LZ5wZtzmovfn0aY=
X-Gm-Gg: ASbGncurcAW8F1HGmtZNEUHuTmVi91PLyu3ckzPKIXkFsCnb34a4A4evoYg/ohyOg26
	nf1L6/v6zRUUpI9juHe0yCTJ7+qNStCBn
X-Google-Smtp-Source: AGHT+IET9rxrpQyDvem/Cv+5KU2pGD5o5DyC1HpeiVmEBQsKWBI1BwLsyavF6bTYJOwCJBonYIoyPpGumUvyFlE4Ies=
X-Received: by 2002:a17:906:30c1:b0:aa6:2d88:ca7e with SMTP id
 a640c23a62f3a-aa63a2c61femr439703766b.49.1733517403022; Fri, 06 Dec 2024
 12:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
 <20241122191304.4182642-2-bjohannesmeyer@gmail.com> <3d1642fb-79f9-4abe-8856-0ee67da9666c@arm.com>
In-Reply-To: <3d1642fb-79f9-4abe-8856-0ee67da9666c@arm.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Fri, 6 Dec 2024 13:36:28 -0700
Message-ID: <CAOZ5it1EGwZJYVw42mA=BGwS7LFTo=QMuOuq7trvU5C+u7EiZg@mail.gmail.com>
Subject: Re: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error handling
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Raphael Isemann <teemperor@gmail.com>, 
	Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your feedback and your patience. Apologies for the
delayed response --- I've had some personal matters arise in the past
couple weeks.

I had initially prepared responses addressing each of your points, but
after revisiting Robin's insightful observation below, it seems this
issue has already been resolved in the latest kernel. While I=E2=80=99m sti=
ll
happy to address any further questions or comments, it appears that
additional discussion may no longer be necessary.

On Mon, Nov 25, 2024 at 8:03=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
> Hmm, looking again, how exactly *does* this happen? To get here from
> swiotlb_unmap_single(), swiotlb_find_pool() has already determined that
> "tlb_addr" is within the range belonging to "mem", so if it is somehow
> possible for it to then convert into an out-of-bounds index, maybe that
> does actually imply some bug in SWIOTLB itself where "mem" is
> misconfigured...

Great observation. Upon reviewing the latest kernel, I realized I had
analyzed an older version of the code that lacked commit [0]. This
commit introduces swiotlb_find_pool() into swiotlb_tbl_unmap_single(),
effectively mitigating the issue. Specifically, if addr is corrupted,
swiotlb_find_pool() would return NULL, causing
swiotlb_tbl_unmap_single() to now return without invoking
__swiotlb_tbl_unmap_single(). Consequently, the failed BUG_ON in
swiotlb_release_slots() is avoided. My apologies for overlooking this
recent change and not verifying the code path in the latest kernel.

That said, converting the BUG_ON to a WARN_ON_ONCE might still be a
useful improvement, even if the immediate issue is resolved.

Sincerely,

Brian Johannesmeyer

[0] commit 7296f2301a057493e97b07739213c6e864f76891 ("swiotlb: reduce
swiotlb pool lookups")

