Return-Path: <linux-kernel+bounces-433303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1889E5634
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFD8167AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222D218AA8;
	Thu,  5 Dec 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="J67fzyO2"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3E17BA0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404115; cv=none; b=VbixezJ5dvyMjAOt+ddiXQfNsXsjoCwqHKGI9g2afmRLdrbqjfMDeidC3C1DY5OX1n1VmYrnzpw/nui+9/On9+rN9iqsZ1LeLVGN2OT8bdNxGTJwMIJjcuNRkhKDXesQ2crk+Dd47ZlDro+qco2ZQudcWuLoYh4dSPWLUx584yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404115; c=relaxed/simple;
	bh=IO0mF8LdCGrgJfdas7Lv4J34R38TAYeyhCtnEGgvQB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koWKDIzYbR+c7/5ETXgm1hhWB7GOJnIEuHSwK6rS/VFM5arA7NwBF8EYunmwALvU8Tw6YbHwkvmYYir8ZuFw4IQ4us8z9pw79yh70J7hCca794QRb26sujwifm5eAmTtaiBN7dWtvwCom+MsvYiZPiTisu7srrvPXZ/4srPWISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=J67fzyO2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0bf77af4dso882423a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733404111; x=1734008911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO0mF8LdCGrgJfdas7Lv4J34R38TAYeyhCtnEGgvQB4=;
        b=J67fzyO2pzl+bw34BrVFOXnUH5sW2qKsviO2bEw08qx/AT21n53ZvZsQIZ3eRSjTS7
         k0bsTf1ex7HY+ASEQ2MKvvjoyiF/FiXKrFGpw5dDMWDFj0IuH3eKtjZZWP9XdPxV7nse
         Dts5mHfMji/IQoaIlrME7J/cUeWtG0ohGkkzhPvhg3AeY2vcYDZ5OJbeoqe71US4LeFf
         IHUrq27dGIo+4uu7rFScKZJtS9bHL/6HiP5cJ+5FSHOqTwdF1TV5wBezI/WFXmCep4Dc
         rNoFPTtOl6XKe4Rwt7H5GW/xnmaHHuaT1y7F0h7huec1OxEpL47sNkaQniTtVRjSS5v1
         e5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733404111; x=1734008911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO0mF8LdCGrgJfdas7Lv4J34R38TAYeyhCtnEGgvQB4=;
        b=Obliq6rP+XDfaMb8E5jy7f2UQEFb9WykOywgvZhGvrvVihkWhDCuCjO/eqwibur5cG
         byHvEsB1/AOxq75gpmmeerMymoyxV19zOcxzQqmdI8zcasgwUAFPfFk9ZuwTcpKfc4QQ
         CDILgaW/SkCCTRGWERhnyMufDL/MHFrlKuil/BIVcKkdKEcN0XbQ7bkC9Th7c0lMhAX7
         1Rwmsu56kr6G+w9V3JIyOteIStarwp0rpQnxlqqwixIAr0rVC/0DhdPm/mvo7T/ss6VB
         wYYnDOYnI/iopge4GNuxeD2m6Cldl6SmiEDHQBcshPVwkYXuCiBJX8XJ+X/JgIbtM6fu
         u5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXti/8/G0Hb+g9r/DrsEeXsQoCrW16TdliIJC/RZ/vF8sijXhvWpJw5Rk7VDEDBppd6xvDDcQs20ZTWzKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1BOzyvL1ziTlTGb0LZD2wHWjdAgjkTeucXx0aPoNMco9Qlpj
	gMfFZlpkOm+V8VIdMlTT1tS1N1yeRb0wOTFMLQg/0ZVVEyj68Et8ZT8VgATp7rjyj4PZA11V19p
	ERBOYNjg8fqxWkwTtdKHIJZ3lo6tNGBtmbpIJiQ==
X-Gm-Gg: ASbGncv0qn2NlRGD8RY99M9rf/rMZ6uWofUOvNsWZSKx4CAuxLCRr4bjqYnYSL9wI4K
	kv5LeYz0jmkNoUZtvcmdd/uhKsOIrQwAFniAViIQFIm5zLSAx3whb5ihWoSPP
X-Google-Smtp-Source: AGHT+IE1i1dEiJ2JW6fMhsX8wvc4Wu6L3IBg3/PLCFzr4x6EdP9ApTo3j+43t9I+0jdn4XnELEH0WmNmNZQ3Bazp8Wk=
X-Received: by 2002:a05:6402:26ce:b0:5d2:7270:6124 with SMTP id
 4fb4d7f45d1cf-5d272706652mr1423533a12.23.1733404111185; Thu, 05 Dec 2024
 05:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
 <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
 <CAKPOu+9K314xvSn0TbY-L0oJ3CviVo=K2-=yxGPTUNEcBh3mbQ@mail.gmail.com> <CAO8a2Sgjw4AuhEDT8_0w--gFOqTLT2ajTLwozwC+b5_Hm=478w@mail.gmail.com>
In-Reply-To: <CAO8a2Sgjw4AuhEDT8_0w--gFOqTLT2ajTLwozwC+b5_Hm=478w@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 14:08:20 +0100
Message-ID: <CAKPOu+-UaSsfdmJhTMEiudCWkDf8KU7pQz0rt1eNfeqS2ERvZw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:57=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
>
> I will explain the process for ceph client patches. It's important to
> note: The process itself and part of the automation is still evolving
> and so many things have to be done manually.

None of this answers any of my questions on your negative review comments.

> I will break it up into three separate patches, as it addresses three
> different issues.

... one of which will be my patch.

