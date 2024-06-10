Return-Path: <linux-kernel+bounces-208188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB7902216
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BD51C21E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9681729;
	Mon, 10 Jun 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2j35B2c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8680C1C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024026; cv=none; b=IhKFaxJ5/YOiBhiLYU3sztqzpe1w2sQxEqRe3EmDahsi8qJak4+5hOSDVWbLkLIhwKDVmAFivSRilCS0NRSqvbrcolhbW29eq0slqwflWUOxv8jzTjHI9Xc0JeCHajRCKOXc2Oxs8SjM5XKclWPMZwKHn6k4QBsf2qJ1x1lwhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024026; c=relaxed/simple;
	bh=fiE6O7g5B0mqvOxiDGcraG8ZdbHLcDWJ8WOI/cTR7h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s86e46hGNXfqP51gAYmWcJEgqu692wMG9QCcK3u3Sv+AjzPD5RefELezyLHIoi/O0bGMALOaAaFu+sI+9gu/4Ll96KoA7nrHfCZ8fR8tnjXH9BWDVzt5UrF2O4QcC3ah6GsIbfq9ZPvDRGZZqL4atnS4LIS2Iz3fQh8fq/0XQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2j35B2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718024023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzBsxMH3vmY2btBaXMxYVJZfosKLoYMTI9Rfski6Xyo=;
	b=U2j35B2cqmcKhcFfYA9980f/ClxpLgaJzme3e1ULQ94FT2Q74oBDn3r5IdLyRB4b423M2f
	LfUHLcHRyZHwnc4l6UDZqnBxktEl22FkxyIfzHHNNTJKSTEM7wR9KCll0T0iyJt/U4xW6s
	YRbj4Pte1Hlp1yNxo5KeI1cMahRBydI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-zxypzGH2Myqn0FasgyP8Pg-1; Mon, 10 Jun 2024 08:53:42 -0400
X-MC-Unique: zxypzGH2Myqn0FasgyP8Pg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6658175f9d4so4013606a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718024020; x=1718628820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzBsxMH3vmY2btBaXMxYVJZfosKLoYMTI9Rfski6Xyo=;
        b=r2fa2sx2QGrGy3jNKfBpUtO1yh7yRdC/0SAH8ftT1aIfJ61jjF5JEBhO32lFYt4Odw
         thlw8pINRnxHWzo+0jS7DwkTFdUoZ/2fJ/S2Wp0XMj2pqXrw5GNUweakfsPqD0TjYQua
         WSKOoZfvy4bi0LG0qOYHnAx+zU2ftJYPphKx7m8ba+eKYnHMe7QWE0NWamtX88pVPIOE
         9otzeJ8+dBaMRDuYtEInWjVT70ypMpMz9mlSQ1UHKV0mu3aFwYeMA1SKBlM7diUMWUAW
         9LJ2YkdiWUJVnMCbUieNUuNUSogM/EfcRKVdt+BPXJtoDB2dDECfag0jh38FGskgblTJ
         e/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFah4yQMD1GZYE9VzRQtnKfKW5atVXUD2LeQ4v0aQPyTsNkY0HeM0I3HMQyzy8nfJTxxyy5pJmINO0ylshF0rcvqSwRp3TDkLo8jWI
X-Gm-Message-State: AOJu0YzYLsX75rzkDuCzbHQnPvHbuROnDN/6cfjDgYKJa3vglMS+f19e
	TEJ6xY99HYRdALxDpuxDEY1ggoos3E90aK71/GfMQmZNXD8bxXaq7Ap5ve07ALje2wiPTlNXh5d
	qyiU6s7j4neAygcoUenVjs0x4g/UFZ//j2hDpY3hg/bwm8bL+uzqjpdd/kEY7GOJOBvqtgIRNjh
	/jy6mS/OFO8qD+1sSH8VPFzrL2jj7WVnSSb/n5LEuVLgho
X-Received: by 2002:a17:903:24e:b0:1f4:698b:7a0b with SMTP id d9443c01a7336-1f6d02bebdfmr123282965ad.8.1718024020635;
        Mon, 10 Jun 2024 05:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe11afcKYP+MpOmGt2jmNnuEKLbqhWPhN+LU/MpXpmTJFkfDh6wbalNYSe8t/iINN3b9pOwNbP8rcuaYBuN2I=
X-Received: by 2002:a17:903:24e:b0:1f4:698b:7a0b with SMTP id
 d9443c01a7336-1f6d02bebdfmr123282825ad.8.1718024020314; Mon, 10 Jun 2024
 05:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529142455.1c68e65a@canb.auug.org.au> <CAHc6FU7MrnksU9vDvdAvc_tv5knukGpnxXEpqidvdfWqDf1p5Q@mail.gmail.com>
 <20240531100032.4a112093@canb.auug.org.au>
In-Reply-To: <20240531100032.4a112093@canb.auug.org.au>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 10 Jun 2024 14:53:28 +0200
Message-ID: <CAHc6FU66Tsg1WZcUwK641rJ-KytbBSkegzrXWFgsEuuhe+PDhQ@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the gfs2 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Steven Whitehouse <swhiteho@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:00=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
> Hi Andreas,
>
> On Wed, 29 May 2024 15:40:13 +0200 Andreas Gruenbacher <agruenba@redhat.c=
om> wrote:
> >
> > Could you please remove Bob Peterson <rpeterso@redhat.com> from the
> > recipients of these notifications as that address no longer exists?
>
> Done.  Who should actually be the contacts for this tree, I currently
> have only Steven Whitehouse listed.

Could you please add me, as I'm the maintainer. Steven almost isn't
active in the development of gfs2 at all anymore, but still very much
on the management side, so it probably makes sense to keep him in the
list as well.

Thanks,
Andreas


