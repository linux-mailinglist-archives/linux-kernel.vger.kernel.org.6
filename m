Return-Path: <linux-kernel+bounces-431443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFF9E3D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912B3280C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008020B807;
	Wed,  4 Dec 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnRzHpt+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063A20D4F8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324026; cv=none; b=IXLfHPUnq2J4ckaqRxoF5+j8qekbwYr0Mw3STJA5mcjrMfnez0t+050NtbjVVCR/j6QDLeNvP2p11xKmzUdfcpNdH1/nnixET5VUOu5MoPJdui4DQhvARhIcOFL1nwjD20jJGZHO4/cjeR/vqSyvbutqYA5+wMIN8c7pEX7W+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324026; c=relaxed/simple;
	bh=K7kBGbl/wdP2nCgoFHgNguRbgX9tLrTyha54rTPE+sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es+VWnj5AzbGznMPwpFC9A6EC55yXiSnSyLnsjEjpiVxW/1Cg/ZtT9Ng8BY2PltoWC0EDrRWIJU4kDV+TdiC2fOOZ4cq6DQS26WaL6yurzmRXW5xXPF/00TQ4pmSUj52U1TpnEhoagtzLuLbZcue5ZOJ4gMWCZh968VH6CxLwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnRzHpt+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733324023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7kBGbl/wdP2nCgoFHgNguRbgX9tLrTyha54rTPE+sk=;
	b=OnRzHpt+zxCDZ5DbnZTm7ENPbbG4//j3Ntz2pB7zhwNOgqmqxbIv5eUx/wtFqbzzhHwjcd
	q97UXp3PLg1VCTMfctUmAfWG12+DdS6rOUksubz5lOPc9P022XVURs6N5GFnHiYyBwVuJX
	IMu+f3e3h5OUHp9wPSKoAGFww9oEK1E=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-qPmOvZZUPny-7NQJhepnyg-1; Wed, 04 Dec 2024 09:53:42 -0500
X-MC-Unique: qPmOvZZUPny-7NQJhepnyg-1
X-Mimecast-MFC-AGG-ID: qPmOvZZUPny-7NQJhepnyg
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-71d63a6ce62so4880973a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324021; x=1733928821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7kBGbl/wdP2nCgoFHgNguRbgX9tLrTyha54rTPE+sk=;
        b=I7LViqY3wLuyuLW5ftBCN4RXPiM2hvQh2Af3zbQyYahXdplMm94squoZNOz/6GsfNz
         IYWFzy9fnk5ldgxjiy3IQUC6colR6v62Q33LzMFB+Wts28Vhr6mF83EmZbc0meqeOqBo
         CiJGb6lrW5JQxyQpGQDmOUeVH8s15VBSspLlD2B8hkwRFR6nGOFuQHVWdFdlZAMYcr9p
         sRG+1j1kBRzTIyfl0Ik2VGbz5RW1MercOrZRacvHiV8mqKNuF7h/OTL1KPerkWXjeD+3
         ZzgdZYm+/Y7j9yr+9rH8tA0Fdm1fx2tQLJqxOqHdCSnUzrV8uz9pRuUBOAs7h+unrRF0
         lVSg==
X-Forwarded-Encrypted: i=1; AJvYcCUQd2K4nt+i/zmiXVaxVD5hx27pd0lfOhli20qua1xHskMi41WShWyntuDEPLe8CTDftgPE2VcDqfGdNXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3rx0VuUuOy6LWDaCNKTHuwvqJXLWqQsOPX2mIjXH4LztAT40
	ZC4NqLuS/bv/YS3Hde9Y2LkbfUjsFVzgOBss+tgKpnUYY7dpVApV16HdspQCAcqlDz0+SEnbOc2
	ZZHXzvYmXJBic+6NMxHhXqbtkEEcMuG64xMyfApafQTZXvz6QFgqxvIHA8n7Pc5/53bkv8/JMqs
	aUFxli3PhLGm7lsdse0DrBT/wvapbS4cKDPA67
X-Gm-Gg: ASbGncvUWiOt0kJwnFl358EFr7ayzAuwff/N0EsUYbL+yGYB20NCuwbUztC67lUsgtQ
	gDo0Sv4FWIGggMUVgdmHBHXOqueTfTJc=
X-Received: by 2002:a05:6830:388b:b0:71d:576f:29e4 with SMTP id 46e09a7af769-71dad4adba6mr6442243a34.0.1733324020840;
        Wed, 04 Dec 2024 06:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFS0oFHuIGv/zbXpCZrw4VpD3aJ8iYW3+nmQO54xHnhiT/5bN8TcEUROIJsrOy9LsBSbug6MeMRE0DrorOzYI=
X-Received: by 2002:a05:6830:388b:b0:71d:576f:29e4 with SMTP id
 46e09a7af769-71dad4adba6mr6442234a34.0.1733324020668; Wed, 04 Dec 2024
 06:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733216767.git.jstancek@redhat.com> <20b2bdfe94fed5b9694e22c79c79858502f5e014.1733216767.git.jstancek@redhat.com>
 <Z083YZoAQEn9zrjM@mini-arch>
In-Reply-To: <Z083YZoAQEn9zrjM@mini-arch>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 4 Dec 2024 15:53:25 +0100
Message-ID: <CAASaF6wX1GnXd3=Ue-yuCgGWNgKLy1+ChkydvYJ0dODBtcJL4A@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools: ynl: move python code to separate sub-directory
To: Stanislav Fomichev <stfomichev@gmail.com>, donald.hunter@gmail.com
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:52=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 12/03, Jan Stancek wrote:
> > Move python code to a separate directory so it can be
> > packaged as a python module.
>
> There is a bunch of selftests that depend on this location:

Sorry about that, I haven't realized other places it's already used at.

> Perhaps we could have a symlink to cli.py from the original location
> for compatibility with existing in-place usage. Same for ethtool.py
> and other user-facing scripts.

I can add those, but I'd still update docs references with new path.

Thanks,
Jan


