Return-Path: <linux-kernel+bounces-389933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6A9B732E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EAFB2369D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FB13A884;
	Thu, 31 Oct 2024 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpKDXv+P"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E571BD9DC;
	Thu, 31 Oct 2024 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346897; cv=none; b=DSRJuibNEfYBWbnHPOVeVski1MnDUsrQEJsxrmfzeSgzVuSaqe5ZwQ5FQuWvQGM7yGGl4QWdWnMZBqqeeDd+zI4rorLiH15YA8e8EF55EUkVPgPbKjaGlycTbz6mUTw0paP93tdeSiy+08DAKsO71gQPrG3UUj3pE/nXyZeaNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346897; c=relaxed/simple;
	bh=96Iv6THCGP0JrhryaiJYFkXsq35hdKyqbJhSHwJ51QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9P/t1BfM1jrBAgID188OXUqTs2LYUjmr1JU8uDO7XtpiwAn1wwDC8YxmbYh6x6eHdUGyKUhA+d1QILSPk8HmPQA2YlNe31Vhvavf0OjvHijpTzvwa1CEryGiUm7LlHrE6z3YkfzBgzUU28/l94d8AyEnZHSgSvuX25/2aghOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpKDXv+P; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso6570701fa.2;
        Wed, 30 Oct 2024 20:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730346894; x=1730951694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD+YSmHeMO76TRixPhraqIR6tq9sHj0TxN2haMlVSMA=;
        b=CpKDXv+P/lbJgWcxRJboepVApdAmpsQWCg1lUnJdTwroX+IqothI27Vgq96Hv9QBGo
         HS34YTTUYYoyehO+K/ao/bCNtDHELS2Q1a8qfK38S/IOLlJA9Plq5Cq7ExCxRmk5Qgex
         T3fVU3WRXRVx1sci2q5i3jc+HotpUehP398VHqGbiK5mSLEGRC02SrSqtQbkIwQHVsbJ
         ePXTOQZd+h+NBeOXWgRJ8A40HzLyIgAcH0TkC0JHV2A42Car6mhoPLFJU4GRmG/hSB0F
         Mby0tBuaOXKh4JxXQ7S8u4D0r3+Q7NHmHOzXHTk+x6q3XK5xbDqkG1j8Ai3TyGO+Lg+b
         J0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730346894; x=1730951694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KD+YSmHeMO76TRixPhraqIR6tq9sHj0TxN2haMlVSMA=;
        b=Z5puFzqtSpofjobvPz0F5k74gw5PTiCRNe6+F/pRDiTrJtUrQoi9Cwi7zj3AwNDPTc
         D5HsyyYcZtP+yr4cwlUoWoUm9cWYGq6HLYbmguoPkQ+3WAEQbhU5aqNUvGr+JMwtxEtG
         836efXkZeCdDyUp97UrBZGYCgzz1FAT2RPFFhD9+TcIm1D6bqc8Ofn7EQ8ryu04kIlxo
         bykXfQNSDpknxKiAVaWcOKp46RNe9qsT84wxRlvrBs5b8IBqeSkDLAQaz6P+SlUoHdaO
         3sKX2JeEolg8IeLoGu9r72QxTwDRxRUkkKcyNaCYjjOXz9HeSLzukbAOBOXPFpjrXv03
         3wvg==
X-Forwarded-Encrypted: i=1; AJvYcCU0/hIUVH5pUtbOhddQ7zE2hnC3I6EWYNi1jE39Sg4oR+IyhOlPjMNrLEqU4LvO0HRDumVe9XBYRQxI+FU=@vger.kernel.org, AJvYcCWo36Ev8BX4dVy4BKYshrxZ/YxR7gbkJ2hYX7hjgnXhfvfBvrobw8fIrDB6SB9bKXTAAuVuC/Y/b7g=@vger.kernel.org, AJvYcCXKMQOKGSl/BWH6Osl0mLmyXqqW20YTu7ZmAsCG80v5n9EVHCJbiOsD/ee9Sm36aHgq4ARijEcqzytBesa3@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGbYnFm/ANBYPz67AeRtWrMirCNe+LXN6yeFfNlpXKoS6616a
	wMYzLg9LAw62KQ2tAMb10VXVfhFuBCG0OE0H7SBjuTIC6UsXYUkXZD/xaJ8T4hrwCaiDn375FlZ
	XH1iaNyP1V1KKLeO5HfX+IqiGl4M=
X-Google-Smtp-Source: AGHT+IH1Qml0b81A/MqCwi0uUiAO5U4CKapC3bT+sUH9kMTSDUXGnNB3R5Ad+0AKCWifyCOhlyVORYWD/Q9HSfiN3ps=
X-Received: by 2002:a05:651c:1990:b0:2fb:8c9a:fe3f with SMTP id
 38308e7fff4ca-2fcd08bc0ebmr119476751fa.22.1730346893276; Wed, 30 Oct 2024
 20:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029235623.46990-1-yesanishhere@gmail.com>
 <fceef9c9-f928-47fe-a6e7-cdb28af62f71@sirena.org.uk> <CABCoZhAgnkDReqdMTgEjKYX4b9y0XqocEheQR1DhsBCtp7zpHg@mail.gmail.com>
 <874j4ts08p.fsf@trenco.lwn.net>
In-Reply-To: <874j4ts08p.fsf@trenco.lwn.net>
From: anish kumar <yesanishhere@gmail.com>
Date: Wed, 30 Oct 2024 20:54:41 -0700
Message-ID: <CABCoZhA4AwbKCse3S-hBgJgUQ08Dy2sTAFYmP=TiZxnwtkewHg@mail.gmail.com>
Subject: Re: [PATCH V2] ASoC: doc: update clocking
To: Jonathan Corbet <corbet@lwn.net>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:18=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> anish kumar <yesanishhere@gmail.com> writes:
>
> >> This feels like it is (or should be) duplicating the kerneldoc generat=
ed
> >> documentation - I'm not sure that we can cross reference the two
> >> sensibly through?
> >
> > Jonathan, wondering if you know a way to link the clock functions defin=
ed
> > in https://github.com/torvalds/linux/blob/master/sound/soc/soc-dai.c he=
re?
>
> I'm not quite sure what your question is.  Kerneldoc comments can be
> brought into the documentation, of course - that's a big part of what
> the build system does.  You can link to that documentation just by
> saying function() - nothing more required.  What else are you looking
> for?

Was missing this, thanks Jonathan.

.. kernel-doc:: sound/soc/soc-dai.c
   :identifiers:

Will send V2.
>
> Thanks,
>
> jon

