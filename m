Return-Path: <linux-kernel+bounces-328167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E6977FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C332817AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0353A1D9343;
	Fri, 13 Sep 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eypy7Mmh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C31C2BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230498; cv=none; b=eJAMaHkNDjU6E/5w7bshCzg2Y1Ft2x5VgRz75YJeT4FNiTxdO0Ixm1TSPgS9LBfvPG8wxuRgbPvvs2Sq/dFOQclvMsV4ntqZuzCHw0jC1ad/z56N+5DgrfXcOwQ68BUlJUgic49Zc4i1jBCY14j9rE/vgGrshhPQlx8hxygNlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230498; c=relaxed/simple;
	bh=0iJqFXz26XdgCQSvH/h8w9WHh3L/KON+49FMx3a5V0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/ORk0PY8L5GMmZfA4w3njObcbn1tsxF/d0xAlY1DdrhiLxCFqd9O9H/iPLuIBqutY97B+ABil1cGeHifUREOgiQNhI7INWDYYsjtpXwSrGUINFQOkDOA9pfOotZvsi7r5qSwPP8z+3tFuRYwlFUjjmWNi63WTsh3kO1Bdjnkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eypy7Mmh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726230496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iJqFXz26XdgCQSvH/h8w9WHh3L/KON+49FMx3a5V0A=;
	b=eypy7Mmh+A/DLsZg7d0NyZiyQdV+sqrnuxtztHg6OBNWIxAvH7B5lOI0T8KOA78HurYP2e
	NOALvAlPJhGUoV0w3tzHCMve/577ncKWLX3qVkm/ywH8Z4gLZSG+MFq/4WHQm5O63bNGa7
	wA63LAJGSNyhJnVb9U5hn6x3+Gza6is=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-KgaRvxp6MoGg7oLbCI_z1A-1; Fri, 13 Sep 2024 08:28:14 -0400
X-MC-Unique: KgaRvxp6MoGg7oLbCI_z1A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d882c11ce4so2070004a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230494; x=1726835294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iJqFXz26XdgCQSvH/h8w9WHh3L/KON+49FMx3a5V0A=;
        b=rtakNDkaIX/nv78dJlKCseFa3vjwim1geCRvzRo/qQFHDc4jEzEBHuXg9xyGSfL2sT
         ZdZY/ZRw9Qks4sZH9wpyAEDrXo+EBmYViRUDowHC15qnTK4VKL8LtY2MSl85U9mNOMPF
         IM8HH5ZrDQ/jKPUsoI0xWf0SedhmKr6WZyMd/yYkd4Pk46TV96sqKPl/SDttokfEfcQ0
         QCJnXd2jkhSgYfMHRjMSbzri+GNC2lXQe0E9y/nPi89tNNYFelMxC6dlG1JCZM+P33/+
         frhl8fh2VvJ4iG7z1KWDdlIBqjNtM/ST7S6zYFU+9NRf06kqIw46ZOwsxx5M/aYm18vA
         8Eew==
X-Forwarded-Encrypted: i=1; AJvYcCWf3eMWC52V0v0LIg3+XMJKL/lFj1ec1M/4+DsTUzPNmItUS6ol4x4KevHs3Uj0GX2dnV2/OjNs9PwKoKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvOuV+L1g0Wann/hNp44VwsCEA3xgu/M7VwgigPQuim7I1hSX
	yyAqpZvH66RwtIHfwcXvbaxxAqL6e9Lk3I5vDgLyJua1pff0B/KCmspksM8/TTckYgBgzbUc2L4
	GeyAsaGBshYfTUvwRyRqwCdaWybliir5BNzG4GUTuzb5cgd44FfK18l0lMRedytygxFFCXqxQOg
	kvf5sZPHknt1ulCvC8hlEkOJAK+fwi0lYN4CzRFUE9I+Lh
X-Received: by 2002:a17:90a:ac09:b0:2d8:898c:3e9b with SMTP id 98e67ed59e1d1-2dba0067f9amr6608900a91.25.1726230493773;
        Fri, 13 Sep 2024 05:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoTGktECP8iZMnogTt7kyrdxvDWlfqIbjHUry2VvX13OCACikqY9Yv9ppzeu9lYjEd+EdPSuCBCK9aAudcW8I=
X-Received: by 2002:a17:90a:ac09:b0:2d8:898c:3e9b with SMTP id
 98e67ed59e1d1-2dba0067f9amr6608882a91.25.1726230493458; Fri, 13 Sep 2024
 05:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913115021.58405-1-lukas.bulwahn@redhat.com> <d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com>
In-Reply-To: <d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com>
From: Lukas Bulwahn <lbulwahn@redhat.com>
Date: Fri, 13 Sep 2024 14:28:01 +0200
Message-ID: <CAOc5a3NEJkHfmWymRsXa1AGLK1K6XOtT5yEsuaaqr9EarOArQg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move BK3 machine support to CREDITS
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lukasz Majewski <lukma@denx.de>, Nikita Shubin <nikita.shubin@maquefel.me>, 
	Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 2:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Sep 13, 2024, at 11:50, Lukas Bulwahn wrote:
> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> >
> > Commit 3e0bae7f35c9 ("ARM: ep93xx: delete all boardfiles") removes
> > ts72xx.c, but misses to adjust the ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
> > section, which is referring to this file. Hence,
> > ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about a br=
oken
> > reference.
> >
> > As the corresponding file of this section is gone, remove the whole sec=
tion
> > and note this previous contribution in the CREDITS instead.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > ---
> > Arnd, please pick this quick administration fix on top of the commit
> > above. Thanks.
>
> The machine should still work as before, I think we should
> instead adapt the path to point to
>
> F: arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
> F: arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
>

Okay, I will do that and send a v2.

Lukas


