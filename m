Return-Path: <linux-kernel+bounces-435456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014839E77F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3CA285F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F8204590;
	Fri,  6 Dec 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXcmj+uw"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7A1FFC67;
	Fri,  6 Dec 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509031; cv=none; b=fBxnhp43cBi3/q4RKDtI1r9cy+paHQRVL1QtYprQNdtgcWtmV1tkNBjIasWMFejMwA5Kyi2mSjO79PICGZko6+CcJat96lpaZj39CzHcqiIk+Xwla701igLhkG+puc14vo3pZ6bxrejCmi2kx5YZjFQLcSEy/QaBgA8bm0Ehf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509031; c=relaxed/simple;
	bh=F9RJBsAgeYHEnkBkzcTxH6KpY9seHzyzKH6LHKSwmpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtJgbNYzPjqAKMlL24nQZYQa2iC3e6eq9iIbC04Vfou142lmn0zrVCjPm+gt6j7v6/zevFuMUUupJTLbGS+4nHDJZCJR18wrET+VTd7rGWF5zW3Ct/Yb43z3W5/eXWrso/fhFxq+wjHTSJts5UFH9H/aj+4TvM4XzGGbY1+p2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXcmj+uw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3004028c714so138481fa.2;
        Fri, 06 Dec 2024 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509027; x=1734113827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlej7UHUsoeR+yZIvzIoLbF8ISp1uA7IpBE5oPajwGQ=;
        b=lXcmj+uwVtuXnzxE7eJMg1X9bNs+RC5RMgt0QOr8E1v30IY8MW0WIYgI1RFBaMSkND
         JRqcXKfCEcDFOMuXhjJ36ev8vmBaqvQGWrWgqJ1r81QD4ua3Vg4zeQJM2H9jeB/cXaCs
         nkWva3V3no1Bc+yAmErYpNdvMp5+sMp72HQS5Tuc3c/HmAKZq2oyemlaESmbSCArVOLo
         hV3MjffNpA08p1yie64snDmVZ/6FDhGVtS/D9qnaNb4OGCJT2SvuaBFYRmkjLjbBFwdm
         2FddmtjJ367bk8C5KZhxAjsCJToLmxyyuGkRnGFvmQTbMkcIishEjQgvuquQM0Ro83h3
         wLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509027; x=1734113827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlej7UHUsoeR+yZIvzIoLbF8ISp1uA7IpBE5oPajwGQ=;
        b=pG9kd9JxkTekT4QW+/sySSrZtBx9PEn4yISKTcxEIk3T2SGYJGZhjl2Lz6p2E4PFdz
         q0ug0abULzCMO1h7bqh7DosA4uljPiOWSNMRBZXWsuydSiz70mVncysyhWeUq/VgTv55
         hwvWtQkG0mnSsG4U6HpIyP/H2Cg655AJnPHqsniUc9YzpERABdLmMhJ9U3DrruRZedP/
         +VoRKdcq4Pq/rf1DwjFo3AvQj0ikmjVn17UAKegfY6YykWmWTfjVxC6rptYVsTmKPmZg
         uNc3f3pBHgT4zOQS85N+JgSpV3LuAL4M/GPWBJBCvHZtDUT9+AvY8VPkATildJrNE0bP
         AVfg==
X-Forwarded-Encrypted: i=1; AJvYcCVOdOWK5wfb6a0CdNlUwEZMlZbQoTwKCs1PLsmvsMshKfa7X2OsCmUMfTjCx8z/WHACDq2qPnppIN5xXBF3@vger.kernel.org, AJvYcCVynQ9lAmVfx4/DKf8WkoccmeWqkLTKFaN4ORKhA0zOcGltMxVA+yHhCO/JKcxniQEzpf6Bh1fg2Iw=@vger.kernel.org, AJvYcCWfRn57C0nrUJIQPS9susaQMQT9s6DH8CTs5afVnCwtP+z0FejrNPCtWA5szKg2RYc8qdJc9y2du5VMwCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0pxKQGlWzaoBMehxzN4sKqqzZU9t7hLE39d+oSK0A+ThEK/I
	kf+DridJSkm/E6mIcfmt98qbvKztPsoatW5Z+CGuz5LMVlLRLtXUlxA41bV7FEhRl1awJejKj+p
	0ThlBcpmxtWuGaI3b/x+W88q2o0A=
X-Gm-Gg: ASbGncshasYVUlADhSsRSy1YY/ei+VN8C//JdNkSug5GJB84Sbm5gYYGRC0kGMI5Kmp
	y9iwfRmux014/7wloqiKJRY9/GHhyHg9y
X-Google-Smtp-Source: AGHT+IFHdBprXTF/2XrgM8L9yFe2mpFgxWqG2GYDHruD27KoBjCURXLHgF7Yxsf+IoNcubV0lKMSH6eSrfm9m0Ynnvo=
X-Received: by 2002:a2e:bcd0:0:b0:2ff:a928:a23e with SMTP id
 38308e7fff4ca-3002fc68b7cmr15919451fa.25.1733509027170; Fri, 06 Dec 2024
 10:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107200835.3033-1-yesanishhere@gmail.com> <87cyj622oc.fsf@trenco.lwn.net>
 <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org> <874j4i205j.fsf@trenco.lwn.net>
 <70a27fe2-cc85-4f35-b24a-8e3425e447d0@infradead.org> <87v7wyznow.fsf@trenco.lwn.net>
 <109984d7-98f7-4b2a-8fee-1f7b30230a44@infradead.org> <87wmh8p5ag.fsf@trenco.lwn.net>
In-Reply-To: <87wmh8p5ag.fsf@trenco.lwn.net>
From: anish kumar <yesanishhere@gmail.com>
Date: Fri, 6 Dec 2024 10:16:55 -0800
Message-ID: <CABCoZhAmsXN2e1RoAudUzYDNa6dU-orUPojp0S4jixqUtEt4ew@mail.gmail.com>
Subject: Re: [RFC PATCH] ALSA: Add debugging guide for audio issues
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:26=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Randy Dunlap <rdunlap@infradead.org> writes:
>
> > On 11/7/24 2:25 PM, Jonathan Corbet wrote:
>
> >> If we really want to separate the mechanics of kernel development from
> >> the associated process information - not always an easy separation, IM=
O
> >> - we could make a top-level "development" directory, put a lot of the
> >> other relevant stuff there, and include the debugging stuff.  It seems
> >> really weird to put debugging by itself, though; it's only part of the
> >> picture.
> >
> > I could go with that.
> >
> >>
> >> Why is Documentation/process so bad?
> >
> > Documentation/process/ is meta-documentation about kernel social "stand=
ards"
> > among other things. It is "soft" documentation, whereas debugging (IMHO=
) is
> > "hard" documentation.
> >
> > But hey, it's all your baby. Do whatever pleases you. :)
>
> Hopefully not all mine...:)
>
> My suggestion is to put it under process for now just to not block
> forward progress on this work.  We can surely relocate it if we want to
> make a proper development-processes top-level directory in the future.
>
> Thanks,
>
> jon

Hi Jonathan,

I wanted to check with you regarding the timing for sending the patch.
Should I go ahead and submit an updated version after relocating it
under the process/debugging section?

