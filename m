Return-Path: <linux-kernel+bounces-436330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5AF9E8482
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F641653A6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A70A1420DD;
	Sun,  8 Dec 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeSrbMub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189245BEC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733653033; cv=none; b=VRLxujq6Hn5BVCFKZMkWGz3GE04YYWoVLpZaeS0G6zTLUzIvSzhcIVkINASoqI9tN0kDknYTRWfBs7iUpwH9UUIUu8zBFb5zeVhsrajlJQXh8ApNdNdq/NC7ymm/96Qkyi9OoQlmZIp9Y8Uq3NPRTSXtaFEfX7GNXbyaCOkNqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733653033; c=relaxed/simple;
	bh=iSk7qBPcuDjKWe/dJvRrHB51dAqOTbdPSdfEakWI4CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/QoJ9TFp+sZzwERV0v5YWWt/do9OqnQXxbhlXuou+85cIHHZySPlnPnCTPhs25RZQR0UOyQbXpa8r07Dqi3YcBBdy7wbLTBC79czil95Stcf3pkrNLvi3ByAWzBxH2XcRsYXpLhW3PQ9k9i1zAGkeK7tEsF/u9aZnG3eQGT088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeSrbMub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733653030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSk7qBPcuDjKWe/dJvRrHB51dAqOTbdPSdfEakWI4CM=;
	b=XeSrbMub/eoZ61p1cjzJ8n3TvLn0I6PWqHpBvEB3TOGAqP0H8AHJxcU7QXPlSa2iZlUn6W
	Q84gH3cUaL918yy2kFTa2rTzR2mFezCbHNHQIYNgDT4ODzyc/7lbU8KkaiX7VuTWrrIQ1v
	Gyv53lo+veR5PzUPb1USks/KIRlsXpc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ynXjJHcjP9KLQcgwoRZFEw-1; Sun, 08 Dec 2024 05:17:09 -0500
X-MC-Unique: ynXjJHcjP9KLQcgwoRZFEw-1
X-Mimecast-MFC-AGG-ID: ynXjJHcjP9KLQcgwoRZFEw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa630babad3so271534266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 02:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733653028; x=1734257828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSk7qBPcuDjKWe/dJvRrHB51dAqOTbdPSdfEakWI4CM=;
        b=AJFaIS3oDfsdN7Eq9zGFm2OKLXobY6jq1o4Zi/tye7p69BW5sVO+9bp4KDCtEAmAQB
         5hGtTjYCoHkWV+eOcBSrxgbGYv8+MERaFvmh2UtF26Gt/IdT3UDBHNGL/RjvJUaUOxjH
         v1NTvDJplvD0ol2gNABPDJ4/xIXrB4bEr9xr+E7alv2ugHJn+kkr5ryM69CMrGq9Wh3h
         OPqkATUBaM75E0gApRAEsSGPp/ZwVxG8SFWhSTbXfLo7Z4gBQ5Z941j379h/CGvR4sPO
         GJtbt4sF+AuDBX2uJQ4xoyLGIEs6iTevWr9rqV6yaVLbkcZL7N5FkM4T7JF52y0TvqN5
         E2KA==
X-Forwarded-Encrypted: i=1; AJvYcCWGWuLD0D8lr7asrELpK1WDwB9JYnFmqBJ6knVfo4ZpyVObmmWC662a3vOT0uLNYy/v/5VxT1PUV20qMQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTKlI3QEfsU+KGujEreTt/+xc2uz8A5n7Q0PMVvhQxS6IrEGh
	E+lEoSpkYZZnwiTyp7uDn87PWbxz5CGPVkDrJPj8GyPLcMa4axKEVhjjkGSJSC/cAx75N3mnNEH
	zVYOuCE5orlrnURWY7wPhSh/5xW6oorK6oUyhhXBZI1upPBU0zhVHmYRS3ZQGfOPesDeAegAZ1t
	7l49/lEVEENkVN1AzjHdKIHwE9VzSJ9VQgKSul
X-Gm-Gg: ASbGnctc2fvA+xE+9GDsjuRlrosfuvaiYJD17pzqm6fSr4ps/tJdNGGaiCE4WQluTHS
	AiQWkYDTj8GZVj36IxFzR2uH/6M7a7Jk6HyTaAGok4J9kxO4=
X-Received: by 2002:a17:906:18b1:b0:aa4:9ab1:1985 with SMTP id a640c23a62f3a-aa63a2c6626mr776044066b.51.1733653027973;
        Sun, 08 Dec 2024 02:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFamKd09koQ2FZaKjQGaKQqbUfNzFN6quC7hLeEwoA1mVdlNypn6b1pc9Ybo1wSkeUjYV+Mp+R+DMrikNj2bp4=
X-Received: by 2002:a17:906:18b1:b0:aa4:9ab1:1985 with SMTP id
 a640c23a62f3a-aa63a2c6626mr776041466b.51.1733653027380; Sun, 08 Dec 2024
 02:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
 <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
 <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com>
 <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com>
 <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com> <CAKPOu+-d=hYUYt-Xd8VpudfvMNHCSmzhSeMrGnk+YQL6WBh95w@mail.gmail.com>
In-Reply-To: <CAKPOu+-d=hYUYt-Xd8VpudfvMNHCSmzhSeMrGnk+YQL6WBh95w@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sun, 8 Dec 2024 12:16:56 +0200
Message-ID: <CAO8a2ShQHCRWBGWs4rk69Gvm-NoKHyZPKJmmsazKeY3UZHeEdw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Illya, this patch is tested and it has my review by.

On Thu, Dec 5, 2024 at 10:24=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Dec 4, 2024 at 1:51=E2=80=AFPM Alex Markuze <amarkuze@redhat.com>=
 wrote:
> > It's already in a testing branch; what branch are you working on?
>
> I found this on branch "wip-shirnk-crash":
> https://github.com/ceph/ceph-client/commit/6cdec9f931e38980eb007d9704c5a2=
4535fb5ec5
> - did you mean this branch?
>
> This is my patch; but you removed the commit message, removed the
> explanation I wrote from the code comment, left the (useless and
> confusing) log message in, and then claimed authorship for my work.
>


