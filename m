Return-Path: <linux-kernel+bounces-315940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DE96C8E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023D01F28793
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D5D530;
	Wed,  4 Sep 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G8TI0Z9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D1C2F2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482793; cv=none; b=r+TsRoOsUQpaV4TulN1cYcwzvb/R3jkUoNaGF1V+eNjJRys7FNgWDZL3hBpmvcwUHhiUiYXNymc9YYsq+90xVOexbY3pyQP7EY1nUQids3imdPitaYuBXcIniTaPfUDTRcIOVPCOE6Ly39uUwF+/bY4q9YE4napELlXKH9opLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482793; c=relaxed/simple;
	bh=jLJ6mKIo3HkW7nk29ShAZtA3mgb0x2uwBj+JNND4bB8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K4/wy8d5OOJvUNgeEX8WQbQQZRvE+qka2ojOxJS6Q/N7rljNny/V7rUi3o919l6rqwaaZqb16wSX73BLTscPvtag5bpjtZsRuIuMM7093h8QXKcOOqIRBHCCT5qOuQjb8ZbNPKDIX5f0QxVCID9/Uw2teixZ0XXkZVOcIwdZTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G8TI0Z9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB1AC4CEC5;
	Wed,  4 Sep 2024 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725482793;
	bh=jLJ6mKIo3HkW7nk29ShAZtA3mgb0x2uwBj+JNND4bB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G8TI0Z9iyV7aD8ODKdg3+t6z2OhUN531PgCCXIxmXHyFN22XizUeEOuQtutODlpwF
	 n5KzFrIeQ6Af/U89Fel5aEfbp4Kt2JTphVVrAp50l0GgY22ME7WFYrWl+PYD6FsH3+
	 te9O/fK6+6n1mZEnoVoN81t2rh/6VwqNC8SB8c7g=
Date: Wed, 4 Sep 2024 13:46:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <ioworker0@gmail.com>, Gavin Shan <gshan@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
Message-Id: <20240904134631.4dd7a0bde6439aad3a275002@linux-foundation.org>
In-Reply-To: <f7ced14c-8bc5-405f-bee7-94f63980f525@arm.com>
References: <20240808111849.651867-1-ryan.roberts@arm.com>
	<20240808111849.651867-3-ryan.roberts@arm.com>
	<747d1319-f746-4379-bf88-a0f6c3f558b4@linux.alibaba.com>
	<f7ced14c-8bc5-405f-bee7-94f63980f525@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Sep 2024 11:47:29 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> >> +static struct attribute *any_ctrl_attrs[] =3D {
> >> +=A0=A0=A0 NULL,
> >> +};
> >> +
> >> +static const struct attribute_group any_ctrl_attr_grp =3D {
> >> +=A0=A0=A0 .attrs =3D any_ctrl_attrs,
> >> =A0 };
> >=20
> > I wonder why adding a NULL group?

Was this review comment addressed?

>
> ...
>
> >> +=A0=A0=A0 &shmem_alloc_attr.attr,
> >> +=A0=A0=A0 &shmem_fallback_attr.attr,
> >> +=A0=A0=A0 &shmem_fallback_charge_attr.attr,
> >> +#endif
> >> +=A0=A0=A0 NULL,
> >> +};
> >> +
> >> +static struct attribute_group file_stats_attr_grp =3D {
> >> +=A0=A0=A0 .name =3D "stats",
> >> +=A0=A0=A0 .attrs =3D file_stats_attrs,
> >> +};
> >> +
> >> +static struct attribute *any_stats_attrs[] =3D {
> >> +#ifdef CONFIG_SHMEM
> >> +=A0=A0=A0 &swpout_attr.attr,
> >> +=A0=A0=A0 &swpout_fallback_attr.attr,
> >> +#endif
> >=20
> > Sorry I did not point it out in early version. I think file pages and s=
hmem can
> > also be split, while 'split_deferred' is only for anonymous page. So I =
think the
> > any_stats_attrs should be:
> > static struct attribute *any_stats_attrs[] =3D {
> > #ifdef CONFIG_SHMEM
> > =A0=A0=A0=A0&swpout_attr.attr,
> > =A0=A0=A0=A0&swpout_fallback_attr.attr,
> > #endif
> > =A0=A0=A0=A0&split_attr.attr,
> > =A0=A0=A0=A0&split_failed_attr.attr,
> > =A0=A0=A0=A0NULL,
> > };
>=20
> Could you please squash the following into this patch, which is already in
> mm-unstable? I'm hoping this sufficient and I don't need to send a whole =
new
> revision since there are changes on top of this in mm-unstable, which mak=
es
> things tricky.

I did that.  Please send along a Signoff and a changelog?



