Return-Path: <linux-kernel+bounces-557846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86661A5DE86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184B53AFF55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7A2033A;
	Wed, 12 Mar 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee766vGk"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212D1CF96;
	Wed, 12 Mar 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788058; cv=none; b=tdy7qcnwrceQFca3e6EjW/EtwwhhA6tiF+CRu+yFz12A4R9s/frsi9b8WnlApiopnNwIp0qLTE5N/koIiszlio4KmqqvIGtqy+FBLFp6CjnbqJw9xwY44Jw2LfW0ChVsxERbuO+4so994pQivnPwFGSjQPJueqRXObkzY4NSZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788058; c=relaxed/simple;
	bh=TqGNnVj5fRtokbS934fV9uF/qjLEnU0awzPTFe5sz90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3+b1E8tXS5JKK/Gv378Lin3Y09s/rSu1TXP8kP7kOmZ6Oq6Zp7AtXW22kxrKRH5pLpMGCkaNPgfPGYiTthie9HMGigNCTHBVupK494mIwlK3q4lpTN+Sw2aaxA8C3ueg7YFFuuLgYoAI0mFtQv7vLXsq4DqL+SrM7/321Qi4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee766vGk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so7039014a12.1;
        Wed, 12 Mar 2025 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741788055; x=1742392855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqGNnVj5fRtokbS934fV9uF/qjLEnU0awzPTFe5sz90=;
        b=ee766vGkESa6k1GhMOwg+HDOab+qqksFuSKocZfTYu5GuigvjM6fQ0eKiX6OspiX6E
         nUSzXB9vqIwAzBpSglFcguZGbgFq5x0j2YHjMytl58N0ttQZKujFtQNxXj1rHlDtdf+F
         gbxrJVw5icJXiw9S/VGfiXxZkVEM1+3Ol5zMCqgWHqI/gynorr7oFvCHr7GMwH9HyLn9
         i/R3r4QJf5EGTBh50UknK/arDbNM3CQNEyUwMWGpINUoXQmAGV57+0iNIWd4qRjSaJpe
         FXmd6AI49WTgtB2fhRhEawEHiAPqwI8+NSaKLhVi4ia+FHEKozDPQI7SKBkp3pa+Vest
         OmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788055; x=1742392855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqGNnVj5fRtokbS934fV9uF/qjLEnU0awzPTFe5sz90=;
        b=XpUXsbd0VnuvFKJRsIcFcoTENjJtgvAmZrIre7hn1jfFH0GDOaVDjfR6Q6P+wdI9of
         OFnt1bWOrDQERC+cx5XF0mAMz3yk1A/MfzS2X5mvsZmhO3Y0w5u0hpZ29IhHK+NwIjPM
         6RCPpS1xdln1YyPTu5AlS+cgvfh4lLrrP1GpT+NjEvScO2qJNooZ033GLMzAPLppW8Hs
         aKZGHf0JCH9bWSIkBm1Yz0E0ve6+PvWahhLQvvphAE+15Z1Rdwo/VllytlH2AgCbeYR/
         Eionfx3qE/V0dsmbc2owKWNVSb2tjgXTE1EvKW6p2B1upkXoP+piZV3NXFtWZOeYzst8
         nTSA==
X-Forwarded-Encrypted: i=1; AJvYcCUANfdIv6PXDUlBR7sQ20u6plMP7q3+I4GU7ZQQETMVa/x7lG7aOLC32AxbEFJfRRjj2U+7yhwyPo9KplcIweUj53EpxQ==@vger.kernel.org, AJvYcCVeZsoWTqIalo30myK/vr5aUI1TlbKPYvO2nuwgLPgcRE12UH5LPPrYMVPh5W3sdBZzJloFO2R1452V3Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmS9fzyTT0v01Daghz1UE58uCRljV0S7MN6WLXzjkgS55KGbX
	ha/3XAm2U+RendDzt0BZnSaHi8XakSUuNmfFjlLnN8seH9JOoJSluq/CnMC70a9LBAqasT+kSYL
	V6P6vez1Y3JUfCujwMRWohwoimDw=
X-Gm-Gg: ASbGncsATxkxFYZIJgI8OAgTZKscactqV+Kpa845XrgAX7ODr1AYLEx5QtTeL+nRoQ5
	e+/kY80gAW2K7Zc2dLmGMggGZ3pTjoC60cIimRlR9AU1C+404stDVhe5HIU3k9AWT6BtYifjhBC
	G+6WFI8ZfORoJWT7LkJ6U2jzO3JNnt
X-Google-Smtp-Source: AGHT+IG1AXDjSx2HGa/b06k46wFNf5GJFDHKErUC43zuG5iIxiAg14/HqXr0u2c+9iUVVl51LfDiQyYz9YECKkIgStk=
X-Received: by 2002:a17:907:7255:b0:abf:5eeb:6af0 with SMTP id
 a640c23a62f3a-ac252a9e2f0mr2608927566b.18.1741788054668; Wed, 12 Mar 2025
 07:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312022955.1418234-1-yong.liang.choong@linux.intel.com>
 <CAHp75VekTbp++4yw4yDhtB96K+C0w1uHiVih5x-jO+TWRLiPmw@mail.gmail.com> <dbac683e-ab8d-440f-8013-f0ff2287a5ff@linux.intel.com>
In-Reply-To: <dbac683e-ab8d-440f-8013-f0ff2287a5ff@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 12 Mar 2025 16:00:17 +0200
X-Gm-Features: AQ5f1JqlZ60zffwzjxbsqdDAzlCHwmGLEbcwGxJGKmCkcOCkKyA6NXwwrnDgr7U
Message-ID: <CAHp75VeLhHh_xhxUb5fsk71ck_m9SGUeXjH8taq+JYjEpHdk2Q@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_ipc: add option to build
 without ACPI
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	David E Box <david.e.box@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:23=E2=80=AFPM Choong Yong Liang
<yong.liang.choong@linux.intel.com> wrote:
> On 12/3/2025 3:54 pm, Andy Shevchenko wrote:
> > On Wed, Mar 12, 2025 at 4:30=E2=80=AFAM Choong Yong Liang
> > <yong.liang.choong@linux.intel.com> wrote:

...

> Thank you for your detailed feedback and suggestions. I'll make the
> necessary adjustments to the patch based on your comments above.
>
> >> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> >> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> >
> > This is wrong as either it's a wrong tag (SoB --> Suggested-by?), or
> > missing Co-developed-by, or wrong order (but in that case David should
> > have sent the patch).
> >
> I believe the sequence is still correct, as the solution was provided by
> David, and he should be the main author. I'm just the submitter, so my
> sign-off should be placed last.

You are the submitter *and* the author in this case. As I said, that
SoB chain is wrong in its current form.

--=20
With Best Regards,
Andy Shevchenko

