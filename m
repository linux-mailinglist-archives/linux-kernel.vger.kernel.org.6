Return-Path: <linux-kernel+bounces-391014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5289B8132
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F34728319F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665F1C9B78;
	Thu, 31 Oct 2024 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0K2f7D0"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E91BD515;
	Thu, 31 Oct 2024 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395802; cv=none; b=die3Fvmr25mwlFfxON8RlHXVV1zhKS65c3Wt6Sp6tnSebinBANucuDVgeUv1fjvtIm0azCV3hm8NA6eqw3MkAhJHGT3WMQb8odyRx9rJ+92tF77w23SefqafsRjReC6n01HTLL76cm80PCE8svXZQAwO7uLttbjhy9ag3NCQRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395802; c=relaxed/simple;
	bh=5ltS1vf+OjUJfP7ZUx7VzetsO8Xd1gc8J/CT1UmsflI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSZDZGEXwBiPQFP8eAzb2pWOLgrAMqUt60R2N3WztjwHvVHg02lrYka+uM4Z1ZC+7bL0h5s6ZJ4QWQ7r6jYpUcHRXY1rIBybVhiEBGwmpuqtEPDXA6Qq7LCxSCLZ6wmnbq/iqQcxn2S+dsPYpScrOrswfErkPUu1oXQJfYTHGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0K2f7D0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5111747cso12635541fa.2;
        Thu, 31 Oct 2024 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395798; x=1731000598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ltS1vf+OjUJfP7ZUx7VzetsO8Xd1gc8J/CT1UmsflI=;
        b=j0K2f7D0CWkZofk7b0EfwPwr24fOQNDVsohOPsUj+4pbEVMNWAxGa7/8aOl2SYmYdS
         NAQeg/4wWqUliZFYeIGdKtugQitCYoe6IKffet+PgJQwRJrquC7QtGhPb8OsM0dEq/cV
         J8M2ngvoMkwGGTJgjqeJs94bX0JlZK+q0v+WINA2/mF8qsP4l/s28ylT7m+61fGzwADW
         RSH5koeFVAeDubM1BV6/TycBy3uOSgWJHZ47PNa8jSM8SeCaOvFGuFWxmdIcXknEiFDe
         yOGslUHqrTtdTIT/6kcXYIa/M81k6XX1i05pjaT9vQ8QLH9iz3swImwCl4/m8eztQFBI
         Ka1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395798; x=1731000598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ltS1vf+OjUJfP7ZUx7VzetsO8Xd1gc8J/CT1UmsflI=;
        b=TNgmveVjRNo2DV/LbFPucSxh5fhoc0f3Cu81/Bs11krQHQ3vuoVxXsMHSQ+GLPmy6m
         zjJ8BEklbLmaqdYkvQneIT6iYF5AtAzOAnXicPpUEy5Qmi1N80s62OuHx61TJ93qIzaF
         EyGcvnleRSRfwH6Anj/1hWkvFNmiUyNXDuWnKrR6tE34tghyurVrqxaUeOh47cX+N1UK
         J09iazsAKS8oBfUOdVtEDp1S2ayAZ2jhk66mqFROc/GqqVdcs2IIfdf8um9ax3aljdt6
         1KNauAzgUHJk1HbFESexPifrnM8np/OY+EZ1dmJNo2KU2uDr+PCJV/kmt5A2G8jHmmeO
         PgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/lhfpYZFJ6yxOZ86FKoCAQbN7lNJlOLlfxRy9XvVbtLLA6Fv4OatfZgT0PpJyCSwoQYUT2xML9nDC2/j8@vger.kernel.org, AJvYcCVvMDqU0VOFTVFHLdE3UziDF7M3+49Q/8240NCyH1p2XvWd+vaERD3ib0PgmJP0n4yjbjEmS63cfAM=@vger.kernel.org, AJvYcCX7I7Y5B/8h6gvWrRf9tYlLO0e5pHuRQkwYhNusLpL6jFEvRH++HpHrGQfzGjL4611kXPPEz82iuXAfMgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+V0aP8XpV1o5mEavpiBl/SpEn+FIjjARJy9ZjREPVNtmGLK/J
	4btWeUrsvC2LlAkewM5QCZ4h6vdv3Dz4Ies0TlpkfLVyNSR3+j66c9cvuBAnlsOVkqcpJKT/N03
	tR77ogzTCIxnuJ0PWvAB6NI6Nako=
X-Google-Smtp-Source: AGHT+IHJn41Lx9ChohtgWUwNaub+WSRGO7UMJ9chEBli1Xl4uGqqQy+8QlulpqcWxmMZCN4Y7PudCv3pZA7TYS/Hsrg=
X-Received: by 2002:a05:651c:210a:b0:2fb:266b:e3b2 with SMTP id
 38308e7fff4ca-2fdecc3051dmr23642021fa.36.1730395798131; Thu, 31 Oct 2024
 10:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028194121.41993-1-yesanishhere@gmail.com> <ZyNmbQ88HbvkaSe8@opensource.cirrus.com>
In-Reply-To: <ZyNmbQ88HbvkaSe8@opensource.cirrus.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 31 Oct 2024 10:29:46 -0700
Message-ID: <CABCoZhDkBWs-siGPAD2rHBnw=tqyoXmiPVMF_Kyy3EO7t35RXQ@mail.gmail.com>
Subject: Re: [PATCH V3] Docs/sound: Update codec-to-codec documentation
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: perex@perex.cz, tiwai@suse.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 4:13=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Mon, Oct 28, 2024 at 12:41:21PM -0700, anish kumar wrote:
> > Updated documentation to provide more details
> > for codec-to-codec connection.
> >
> > Signed-off-by: anish kumar <yesanishhere@gmail.com>
> > ---
> > v3: took care of comments from Charles Keepax and
> > as advised modified some details.
>
> This still has all the DPCM bits in it.

sigh, the wrong patch was sent. Will resend.
>
> Thanks,
> Charles

