Return-Path: <linux-kernel+bounces-299822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EC95DA69
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3CB22FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0E8BEE;
	Sat, 24 Aug 2024 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1EpOyes"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651B4A0F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724463300; cv=none; b=AlxREYCnZmBCqOTFwIujxDOd0ZFvEguiq0bHVhrJ/zi2TbO+xxDp8QOByepnA63HzPH60qv26/kVmrw37jCc/tY9I2XKDNmBCiPGLiIH323kBselgaDQcC5lL9xpH8iuXhgQjpmzhKSZD5q9MUmdQoTpUfk4wkrkwTtFf9xMB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724463300; c=relaxed/simple;
	bh=Hw7jnvfa3Q1O1QIXd8Gkh/Elt396GJ7HVFb4Dj8GDzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYrSKzS/Qv1XiwLGXMI+/JKZiqjtKRMn+Vn+Oh5Nj/zwmjTXNrNqIku1b5cuPbbizHICX4sQYgV7oP4Q6f/V9F+xKAYpsMhLslttszWao1Do9UCIrZjKYrsmGEgrZS4zSCwEz4AL20Gv51y9HVqOmEWM7VFfKRIgWYcF8UO+tZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1EpOyes; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5334b61b6c2so1093e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724463297; x=1725068097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcP2XHdhpQoR+8wXNb3t5tqZe5jimGDfuP+Dc4X+WBM=;
        b=O1EpOyesM03o9AE9QAeBU7QwQc4h97F/sic2vVxy1RPd60NLdcbPWA0EPs5fy+S7Vl
         9bqgk7EbKZhZrDQM2lrdtuoaGzWSWDwjx4oUlVAOKxE2vHGaSo8hq6n4ULlAGj7oJtw0
         c/7H76IzXIZaPa7faAPINQAEJY4VgGvnytOnITOTGMhlySSfJSyhyHvsoyxzCHw8Wix5
         X5M0tOrin2QE3L19ORPpwghV+47boKrTF/cPAziN6YkmA0KiiL7oCvRtsAgoL4yEfncB
         /Xb7dQbxFjBOaR/XnoS9L6eiJP27qvy+EuUEzE1Wl+SX+6M+VS/ds66y/3DsPGec47mA
         ufxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724463297; x=1725068097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcP2XHdhpQoR+8wXNb3t5tqZe5jimGDfuP+Dc4X+WBM=;
        b=tFzl1ZiTc3GBVON+pcvWeBeX5sl1ITRKCntl4K6iNGXDBQr7GouGKZYriNJZ8SZZ14
         2h0yaehtpVNmYtdMzIHfPN7FSsNGuLJkMHO4xMxNpL7hBr3xrrV8Pm4vPmqZDQOIIihu
         DrStsPMXJoZxYi6EXFYBT1sGOPG5mVZLPqT9FrHyF5F7LfzIas75nRHL6uSqQ4mFRh9K
         TRqf43ZQBcostVFwUXxviRTr+llkGwdaNSXk+i2UAneWNh5U1Bw+jUJmP6AcS17MQHif
         UqTxWSbuN/FE/xD5fHHmNsdD86x9IL2GUl1bBfFlN2kA7C7MlgFpnybd4SDgYHyYTEFm
         rYcA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ugXNbbme2gjJ7eI+jBIx2oGjYXxoOB7/aqDZVphY1apQfsRWJAFC3sM17q27LWF+4uBT0YFTjbhldIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPiQgZsCztjbNwFcUxirhmr/54p/zj5r+m7iq6eZv4DJntXhD
	N27epJZLpSmn7dzXimPSd6ZBATnJ+sjG3VlHWzSA4dBxoEGnGuluv/XlZrLoLMlIQBC+WukVUHQ
	2JorvIA379DHeO6y3HA4ugv7rQZp5g6UuYVQz
X-Google-Smtp-Source: AGHT+IHURFxnbYbSnrLHwqXFAW8a7r4AgAH2k8U6BVLvMWbntozxXieb/Lp3SJFLl8PP7sKnwg98qPonU/lz/wgjMlI=
X-Received: by 2002:a05:6512:238a:b0:530:baaa:ee10 with SMTP id
 2adb3069b0e04-53440bcd289mr34644e87.3.1724463296675; Fri, 23 Aug 2024
 18:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-firmware-traversal-v2-1-880082882709@google.com> <Zskp364_oYM4T8BQ@pollux>
In-Reply-To: <Zskp364_oYM4T8BQ@pollux>
From: Jann Horn <jannh@google.com>
Date: Sat, 24 Aug 2024 03:34:20 +0200
Message-ID: <CAG48ez3A=NZ9GqkQv9U6871ciNc+Yy=AvPfm3UgeXfMyh=0+oQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
To: Danilo Krummrich <dakr@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 2:31=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
> On Fri, Aug 23, 2024 at 08:38:55PM +0200, Jann Horn wrote:
> > Fix it by rejecting any firmware names containing ".." path components.
[...]
> > +/*
> > + * Reject firmware file names with ".." path components.
> > + * There are drivers that construct firmware file names from device-su=
pplied
> > + * strings, and we don't want some device to be able to tell us "I wou=
ld like to
> > + * be sent my firmware from ../../../etc/shadow, please".
> > + *
> > + * Search for ".." surrounded by either '/' or start/end of string.
> > + *
> > + * This intentionally only looks at the firmware name, not at the firm=
ware base
> > + * directory or at symlink contents.
> > + */
> > +static bool name_contains_dotdot(const char *name)
> > +{
> > +     size_t name_len =3D strlen(name);
> > +     size_t i;
> > +
> > +     if (name_len < 2)
> > +             return false;
> > +     for (i =3D 0; i < name_len - 1; i++) {
> > +             /* do we see a ".." sequence? */
> > +             if (name[i] !=3D '.' || name[i+1] !=3D '.')
> > +                     continue;
> > +
> > +             /* is it a path component? */
> > +             if ((i =3D=3D 0 || name[i-1] =3D=3D '/') &&
> > +                 (i =3D=3D name_len - 2 || name[i+2] =3D=3D '/'))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
>
> Why do you open code it, instead of using strstr() and strncmp() like you=
 did
> in v1? I think your approach from v1 read way better.

The code in v1 was kinda sloppy - it was probably good enough for this
check, but not good enough to put in a function called
name_contains_dotdot() that is documented to exactly search for any
".." components.

Basically, the precise regex we have to search for is something like
/(^|/)\.\.($|/)/

To implement that by searching for substrings like in v1, we'd have to
search for each possible combination of the capture groups in the
regex, which gives the following four (pow(2,2)) patterns:

<start>..<end>
<start>../
/..<end>
/../

So written like in v1, that'd look something like:

if (strcmp(name, "..") =3D=3D 0 || strncmp(name, "../", 3) =3D=3D 0 ||
strstr(name, "/../") !=3D NULL || (name_len >=3D 3 &&
strcmp(name+name_len-3, "/..") =3D=3D 0)))
  return true;

Compared to that, I prefer the code I wrote in v2, since it is less
repetitive. But if you want, I can change it to the expression I wrote
just now.

