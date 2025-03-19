Return-Path: <linux-kernel+bounces-568055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D196A68D84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEB1424D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47703256C6D;
	Wed, 19 Mar 2025 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9KhXjCm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55424255241;
	Wed, 19 Mar 2025 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390090; cv=none; b=dta5l75an6SM9TYq/Nys/nHeL3H4uIqavZSlnSqmwUXVqmUYOX6IxrQPpL/shEbEoYJxxMJK5ErUhjQiGW5V20+TrfYPAkhVzs1StCDcqptco/X9QsfZczHMk3k/VxnviZpCn7IixsPCOMOdoRimjK+kHV9muMOUcEzVgrPlt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390090; c=relaxed/simple;
	bh=DgEWhrcArRQWivXgdYNOyO9PJj4wouT5Ax1fLqaVzCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfOqLFETD/9DyqklqUI8WKPDfVWFKwRTiiGgZdUjqQWzQgmt8rpSiD5aL6gB25AYatL5h93MweAThTgDOhfVreiWKDeTSNUMjQlGaoNlswV6L+jGgvBZcJL4k25ZyWyE0LpB4+cwoaFTbNZuzMtqGN+PvjBBIyY8aaJu4tyXSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9KhXjCm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1245616a91.2;
        Wed, 19 Mar 2025 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390089; x=1742994889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYUSaTGRo0JCGf5h9eN0Z1fo+PmRHUL8UvdHhghPcsw=;
        b=b9KhXjCm3YThkx8spmc2S0H7JWx7UqyINjz7NYe+pp1TFKdUIEZ8RJDfoqk24YSq4A
         ZMRDmDy3kzCwL2RaNNii7MSA1LaoZpnAgaQxWu3lQ8dZ6vQElwH4kVB3V55JwAMO8cMC
         FHQIFTF6ohsXKYgAeoqjgBuz4yuRV3zJQQiWF2XjOXl4hvSIqsvaLl+TnEFVq7jKEDky
         qYKW3G7179Ir8XlIoxAa254X7u3R7WmPKIOWyk41P7fEmTCnInhwVeqbJduzt2/Eslat
         rdftIsvB+47Zin7L8TaQS/f+NROEFBmhYbw221vsw/YtIudO8Ttf73jvyAH7wjgflW4k
         kwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390089; x=1742994889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYUSaTGRo0JCGf5h9eN0Z1fo+PmRHUL8UvdHhghPcsw=;
        b=uxzz+OPpXmw8Sw54FAx8MboF63ZT6Y8qL8E4oIXsxGqnxI+W1ArLyao8WDEo22UNQz
         iArYfSUp/7AFTREXRHG1tM6YOGapnwOgljBtQow6zkDkf6zQ971rswzihh7eCfiN0MSc
         vbJdH6WpMelB/DAiWljiwE8xX/DwLOGC9goUkCuHd/6TvAgbyvbJhlLEF7N7ktY1ZDbj
         T0THWXdXKi08CvD29sylfeVYk/iR0Srqgbw3its//mm3Xk4T2Oe4jJN7QAHbFOejmBTr
         59xae7gILT9LttWhCXy+SduWhXnvrzsxqgmMqQnYQ9C/jQ3bpKqYyMuODsSWAR2E+TIY
         6F/g==
X-Forwarded-Encrypted: i=1; AJvYcCV77MWzPIiMdMYnokEcSgpesgDKZCQE2TpplNWCETY/qe7CO5UQpo2nDbe1GgYzY0a3vesGY1qRh0SxstgEuo8=@vger.kernel.org, AJvYcCWHLqaU51BLGLSBmSugQoGjcCK6qhDz4fXIKpbgEES1DluOYScGbb1Ya5CGFLF1fJipl+Gcp48q2TCZRIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSuGj6FsCUh6vuTmHdQMLVVIM2zgk9YaJEN2KPxZHD7g3zFSl
	X4+nYwXb/LnhYue4aPfu+ilNn09hN0dxem00XFwkKZPYZhJPR6KXwoGkztdV1w0XAbv7r0uGDM0
	uT2L001gUACeuzY+5n3zEfoySvTk=
X-Gm-Gg: ASbGncsKiNhBNDAUCdaspU6fafw1zeY4celBnKh+vPu1RQtoPhNHmo+SLR/DmXXnYVh
	r+X3mbzlDedsI9y+j6Seo1CeezX8yXKfSPfYa2NfJgegrKiCDtr446rWl6duwGXWPcdel7crE81
	i5AvljdtaBmzBIVSCNCOqDxYQaQw==
X-Google-Smtp-Source: AGHT+IE0TIH8vCl1YM7w/VhczEWsJNbDY0aCz8IJ6GE+PbNyz3qY6jSGdchCTHakOWOdd1I3I2SlJFUZUMkOMwfcVdU=
X-Received: by 2002:a17:90b:33c4:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-301bfcadafemr1235002a91.7.1742390088657; Wed, 19 Mar 2025
 06:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308110339.2997091-1-benno.lossin@proton.me>
 <MV3Dd6cjj9PCMrZhszmwYsMgAsXCTrIAa3Fr6rSkDd33d_Db4Myl-3TTnbpfp6pQXoG-3q3mXam8wY614QYYcQ==@protonmail.internalid>
 <20250308110339.2997091-5-benno.lossin@proton.me> <87iko6lgj1.fsf@kernel.org>
In-Reply-To: <87iko6lgj1.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Mar 2025 14:14:35 +0100
X-Gm-Features: AQ5f1JrJHxO20FkTCPN7D7O4m7sghzJNUnIkPWPEZmNSA5cUl8R4WMizU1IFURU
Message-ID: <CANiq72nSDWYOv0+X51ND2gTon=jzPHsA5okBeFrE6BkdoY6cGg@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] rust: pin-init: move proc-macro documentation
 into pin-init crate
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 12:35=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

I already applied this on Sunday:

    https://lore.kernel.org/rust-for-linux/CANiq72kg2-5PC4T_ieFTN9dqeMnZ0H5=
TqqPhW+GxB7fPV0COVQ@mail.gmail.com/

and we went through fixing the conflicts in -next, so unless I have to
rebase for something else, I don't think I will take these tags,
sorry.

But thanks a lot for providing them!

Cheers,
Miguel

