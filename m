Return-Path: <linux-kernel+bounces-433185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFAF9E54DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2B428451B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C8217711;
	Thu,  5 Dec 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="COnSVc/I"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43A217703
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400143; cv=none; b=tqwxl6y6itn2rJyhBN3jPffBTl/BiuA0tK6k+awY14gdWAQCiG0C4W1SMsdrp+VDwWKam9tZEA5b8RZ49tDqbKutkAcB4cagQWcbyR/yJRxQfn1YG6ob87Ui3Ro5HUz7tyGUgHHhQOh+/+i5P/zOaYpHINX/n5h8w8MI+3Dg0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400143; c=relaxed/simple;
	bh=XyfEByJLaXEI2J7PmhW3DYY/suyZlc64UiioSv8hnSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIHpB5BrsI0uNjYBZjT2QxTJ3l7YjuG9tPzxCxNrLvVCwsm3YBgmOGp8cslADzNyJ4FK+innoYDYYqH8Y7Qy+UXZhPVsASXANadKAS2jOqQ0Ccfk45K94/WuSE7HR2a1TfANxTJq6uT+/MctcTzu4tY5y6Dcgz98fXcETKCr0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=COnSVc/I; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa62f5cbcffso36824366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733400140; x=1734004940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyfEByJLaXEI2J7PmhW3DYY/suyZlc64UiioSv8hnSE=;
        b=COnSVc/Imj0aebKx+Q/QZcP/abJAbERCNVw0vdInpdnuFupObDgXwxboolpmU/MVMe
         6Cp8cqQTsnGBa52W9NXCI8FmAOdwkrQ2pu28/1LOUgleQvWeMUu+3gJ4BpwDO4fW/V19
         lWmOPzlyZ4s1X2jj1md2eSmoc8jMfs9f3Zdp0OxqWyXc9sNQJPQbZDtfqAXTtEA7aT3+
         Q64kY495kiT8cXwNbZzBPrHqJPLKC7cBI8tdn0HgJzNAPizLmtlgvwGxoJ7RnFZQHEqc
         5ZhHdkRO6guQn4fSfyAKtJjogX2HcVUZgfBua2YSDmVelkXjdK3Qvz+s/953R0cenqfR
         1GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400140; x=1734004940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyfEByJLaXEI2J7PmhW3DYY/suyZlc64UiioSv8hnSE=;
        b=TBnRhg6mZgR9xCtrN1NEGX1NzGNLFfeJtblM468fx+OP+0FuAEAnO+yModW52lxy+N
         NtarWN9Rq4KYjgKWz+a4dRdzXJa7PFd8EjLNYjbwDvHrBquq0c4EsdhU9e3ZxWolEg3Y
         pfKF6/2oj1vN7DZBsgMo4T7yjrSyi4ExeFkI5cqB61vxDNEVWsoSodMZ3csGhImcmi7T
         VjPlBdouRXhByt50YhLKSGjlnVO+0G9L9dz2C/nLAZKzQNsZmjY0SV0etq0q8fZQ8mZG
         21cm6TMh/AAUrkhmWosmMFSnKxCUyDvPwpFjoQTUvZEIulTBqNZ4gnOCDFZd6iSoigCa
         Gomw==
X-Forwarded-Encrypted: i=1; AJvYcCVgApO1YdOCCERj7iA9WTybmkjyIEHRHtIT2xkrMYpBRbNdYx1YJuID+BaDu43vMnSyGOgeplej0OfvgkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqaK7F2hMlWgU6cirLb9TP+mhTWwv5vgL4++RbXQamCU699Ex
	k7C+fQQWmSGKrMWYu7yQDvcnqZkqRypYlUCBJ1N3PWpoR/0FMTP6UVOiznPf81xpi7Rcq5Zxr7D
	OEzE17dhIsMsVj3fVa86GgkgyR4Axo5dGQkq+Vg==
X-Gm-Gg: ASbGncsJ1OrLhGQ4NtlIckjV1rT8j+F8k6GsDwlkI4CDfcx4mEYyuvGlbN1V9pHbH8y
	1ag4BugvbXjldEHeQ0fv4T523zTFcHVkJI/5ASzl/ibhxIFd/R6XXBQK91Xym
X-Google-Smtp-Source: AGHT+IFP/wTYLryFFk8fTdYJy5qaJwWOgpmG9awKpo+rmgz0NzwBMJtXwwZap8har7hG0jmGiguupw0DwGkLQ1i6mfw=
X-Received: by 2002:a17:907:7e86:b0:aa5:4e27:4bbe with SMTP id
 a640c23a62f3a-aa621a3da23mr246213366b.27.1733400139827; Thu, 05 Dec 2024
 04:02:19 -0800 (PST)
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
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com> <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
In-Reply-To: <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 13:02:08 +0100
Message-ID: <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 12:31=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> This is a bad patch, I don't appreciate partial fixes that introduce
> unnecessary complications to the code, and it conflicts with the
> complete fix in the other thread.

Alex, and I don't appreciate the unnecessary complications you
introduce to the Ceph contribution process!

The mistake you made in your first review ("will end badly") is not a
big deal; happens to everybody - but you still don't admit the mistake
and you ghosted me for a week. But then saying you don't appreciate
the work of somebody who found a bug and posted a simple fix is not
good communication. You can say you prefer a different patch and
explain the technical reasons; but saying you don't appreciate it is
quite condescending.

Now back to the technical facts:

- What exactly about my patch is "bad"?
- Do you believe my patch is not strictly an improvement?
- Why do you believe my fix is only "partial"?
- What unnecessary complications are introduced by my two-line patch
in your opinion?
- What "other thread"? I can't find anything on LKML and ceph-devel.

Max

