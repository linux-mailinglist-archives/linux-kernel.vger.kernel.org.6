Return-Path: <linux-kernel+bounces-183150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36278C9549
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE551F21B59
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D794495E5;
	Sun, 19 May 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FaVz0gNA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059C4501B
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716137351; cv=none; b=HlKJy8RLb4owVfIhvK3KBm6iSToUgPwYu9d6PYKim8ZkscHOq2Poxi6a3i42zYBeUyHu5qtZxpPNHGECNTUfLjxvN+zOgJY2py5chAJCQfbflBJ7n21NAEr7aYEeqpfRTKxXfaQyWDrjSe5VurHYqtA/A0mmetYnP2Il8VJ7NK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716137351; c=relaxed/simple;
	bh=Fhiqd8BsQupsJpiNgkIjNU/SvByQ1V6nfzY3RL0SiXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYxjSY36PXhAFmo7IJnMIHHKn66aG87h11NFL+1iMKQJR7ey/TfxiiJZJ4UP2Q9gHdrenlTfVtqy3KED4e/STp92VqbZ3SKkBPIjWsGx+WkFrM0pDM1Pn7u5CH8AGp2mCkux/lgk7RH76DaGySf1l6UeCzt+Qsw9P06VeQ2nQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FaVz0gNA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f57713684so4517941e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716137347; x=1716742147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9lPiIVfBe4u7k3tCVL2yrGrYYG9ynn3v8OVvk6ILus=;
        b=FaVz0gNAaGH8bZwJ6DQQvA43Q4gpnmsWItlmasb0t5McIcnseYHg/Si4E7CoE5HpmJ
         VeLDftAS+LCaa9puZoHZwkQIS8ymA7ezNnaR5ZcYLkiZKJQAFMdutwDcw71wSjbt570e
         /lWJ12JnSUXcQbP0qRj+F/y+JeeevK35OP5wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716137347; x=1716742147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9lPiIVfBe4u7k3tCVL2yrGrYYG9ynn3v8OVvk6ILus=;
        b=Ik/g7xNkFupQM+G+8RTju5L5u5CIK6wPX9yqQ1c1/ERAKVhvO9zMPrvoisQIoSshIF
         N7fBHuIaa9X1JzvZBvS4cCZvxO+/h/R9c2oaUdAgmgHe+ndjheZyeGScxS3uZCZonv42
         t8foR2pZal6XomdgpyvuDmB7XI/Y9N00flLcW0y95+9UXbKbhYQScnQeQU/VEae2sgUO
         Dy7Xnx3Iub5pSiLEJaEpfUEjtVTXQ54kbXfYeKV4JffVijm40yTRveF1w7qap/lZD0Ei
         /V3iuprtYgHRFsaYZi2fkXpo7wlWnjcNQkDl0d0osI3ds0TeHxPMA5krVYoL6Lo7sRZA
         BGQw==
X-Forwarded-Encrypted: i=1; AJvYcCU4QU/eLh30ycNElOy5BZXAQDzt3H4OIG8Q7JlxxJbQQAY4mrv4ySmORXOTN1WfNfimsBkX2RB8+DM3qY75A2ALuGpnq1hTTfW/quMQ
X-Gm-Message-State: AOJu0Yyt+QGXBY2izUw/UN+1gQvX6Y9Ke8g4JYFW8ErbPS6HLA6nInn5
	5D91z9p/0k+I/nWoXG/YKYOaS/HU1i8bSNFwpE3k6IhUVgTrDpPl/uYnZtM+e8aP27WEmkUchIc
	e1fhS5g==
X-Google-Smtp-Source: AGHT+IESbwoMLkGM8AxacHrSZSiA554nSpyrtYWxJJRyBGh9sp3/6gCAdnIis8XrV06WsCV2D/n68Q==
X-Received: by 2002:a05:6512:b07:b0:51f:51a6:eea8 with SMTP id 2adb3069b0e04-5220fa71dc5mr21422160e87.7.1716137347397;
        Sun, 19 May 2024 09:49:07 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a691870absm905156766b.124.2024.05.19.09.49.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 09:49:06 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a0e4b773so625215966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 09:49:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe+sYSwVKw8mfURsNGkQ8V5uJINNxy39WjaDxFdjcvQOp3pidZIWZ9MekyNtjb9kvmjwf9r+mQ+Olhg/lNN/l7OqGyBZlQpvO5RKbt
X-Received: by 2002:a17:906:22c7:b0:a59:be21:3577 with SMTP id
 a640c23a62f3a-a5a2d5cd472mr1751615266b.43.1716137346046; Sun, 19 May 2024
 09:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org> <CAHk-=whEAquncw0wb59-XVAHmVh4CWSfwuWh4bTJjJzvx0=PzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whEAquncw0wb59-XVAHmVh4CWSfwuWh4bTJjJzvx0=PzQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 19 May 2024 09:48:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSiUg7dggHaBLULuF6_GB6NORLDByog0p=Qo+0ewmZSA@mail.gmail.com>
Message-ID: <CAHk-=whSiUg7dggHaBLULuF6_GB6NORLDByog0p=Qo+0ewmZSA@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.10-rc1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 May 2024 at 08:32, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> I'm going to take this pull and fix up the cases I find, but I'm not
> happy with this kind of trivial C preprocessor misuse.

I did some other maco handling cleanup too and tried to regularize
some of this all, and it seems to work for me. But somebody should
double-check, and it's possible these patterns should all be
regularized further with a few helper macros for the whole "add
__GFP_ZERO to argument list" or similar.

            Linus

