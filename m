Return-Path: <linux-kernel+bounces-524443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7ADA3E332
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C3819C00FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836CB213E81;
	Thu, 20 Feb 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G2+YX67I"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3121FF1AC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074391; cv=none; b=OX1gaqAU6jo4q4/1UbGiXVyTUsILjbdFDLkJdTAHEkZP0bPO+dUFIu3fzLdQW2xgBwU1TIB8JqQuK4gbrQ9LqXMhqq78QkmJm/odvZzghC1fuNDGFYubJffhgB4qvPFSeyPKmcGh1MAgzVhqbRuhS3dUKB7oXp4kI0oCpBbTRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074391; c=relaxed/simple;
	bh=tYZdg7sRmlVaf134nM3KeRlxvjXKLXuRmFN9yX0E2pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqtqF0higvRP/VIu8g+SxBp+5hnULufXvkGYcHOCYbAqvQh2KB1dC0InrI/zulVU5P9JElIsGedSkQJHZUJW3ge8Km1RL699Vct5Hz2oN1SCpOXJ/tQSsQ2OtVyUaU4yWBok8EAOkYnry0GPucMNCRWyQm40no0F4OpzSmXqBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G2+YX67I; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so259821666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740074388; x=1740679188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9T6ah5nvaQ91ZU/lmF1ivJr9nZ+XvlNxAP3jut4I4g=;
        b=G2+YX67I0cTUvXlWlu7cqILLGlnmvWgy7W1tXZTUna9lt5i4VWSKsgXyIVrWiYCdq5
         CSnvzeI0zjG3NEs/6GFWybihPunZ1xrQqTRaDqyHjSwSpUVtmfVlWQd9Un+gJc+Zprm6
         +E7ep91WeXmc+cf5dhcaLVnNqXoYLbhgwVz3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074388; x=1740679188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9T6ah5nvaQ91ZU/lmF1ivJr9nZ+XvlNxAP3jut4I4g=;
        b=SAzWqQugm0eLzAO7t6aMwVnIBoNAI934xRZ46iTrebvTYusdyZ2E7Nl/bJntarWgfs
         85hzmm2krBisQrygePguhh1jpub25qD2L6rlMGLWxBqHdec+slQMBvo3rVyUr9RoviQG
         GxPucxXS4mN8Dubny5x3ndsaX+y93eo9X8QsyDP35ilEPPn1xXlanuIivF+XvuLuAJSi
         f32Q2WdVPVGFSP7XLx7N9mrpx1zMi8h0MspqwcTMglb14He9/Pe65xK1SxhIntMxp1ds
         DtQBIrXM06ZtDb86Na91Wy/rJMxMYV3Hwh+EuTOldHuweZ8mzDtcLZJmuXi2I6wVpxmr
         jE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3LJVPIHt86jMCYrk6wKRPHf6iz3VpQNm4TEM/4MNgaizBBrwUEAf7IVJ9GeZsteeSvacW+t/Si8dqAYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0KD3Uu44ASQ+qoQNRsJvG6GtVgpQZbZd0VUNf2Gi00RZHabd
	Smvic13SKFxhPjiLT1a/9jzeRLUnH02wjGzzhXsKiyrAbK5NbcmnXw0EnBjGA93UeXPhJEH8GmF
	9erU=
X-Gm-Gg: ASbGncuf4LbeBINwPamyUg+z+lWcS9FFQHOv1EiT87Jo5+GK82TYPHsLDkLuIus3XC7
	cgHQ1/Y6YHlxht9bCcoYFIpsDtbnDfNGWixWKUVSNcMsvTOdeMHEwHrM8L0FcGUpWtpPsKe+pDV
	A48EwItb8LCgJHAWwUTY1Skok7pV/3ZRCic+DtSB3RtGsUD2jO12xvv4NDBBkVpPJ2hd8lB68Xi
	6YxhXtEYOqpnobjMkpQlPKl/M66xw79dJUTfDOZQHRt4Vnuk2LGE+v3hMrj4zpwVnhIwxPaNKk2
	pWjadb18ll6x3Jcrpd8vgLL01ST9b/tko8jD1ii49BU1fgN+ayvgq/GDoIAgTFRiOw==
X-Google-Smtp-Source: AGHT+IFPuIXFmI4N7kxXJmm9/C9woQlI/cehj6xEkqZAPXZAzFceHCDyfaWB/QQIOW7YzJhKTElaeg==
X-Received: by 2002:a17:906:4fc7:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-abc09d31cd2mr25958366b.35.1740074387707;
        Thu, 20 Feb 2025 09:59:47 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbe74100asm543882766b.95.2025.02.20.09.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:59:47 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so259815966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:59:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrCWEAcFdYXOGgkQRuwKOSvqZEIeTZ4XqF0JOnnZlbTIsbU0735EGOU3ZQknEBRKgCKBA+73Ozw9PmbNk=@vger.kernel.org
X-Received: by 2002:a17:907:7fac:b0:ab7:eeae:b23e with SMTP id
 a640c23a62f3a-abc09e53506mr27429066b.47.1740074386561; Thu, 20 Feb 2025
 09:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk> <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org>
In-Reply-To: <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Feb 2025 09:59:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj42Dks1vknzKKBbXUMCrs-iuLZHq=0z3P0AN9TrXNP+A@mail.gmail.com>
X-Gm-Features: AWEUYZlm3vCnMDaMdXY1w_rtbniMJDt-7-eCVXlsPvvSJMGzSgi_1TpINhz0niM
Message-ID: <CAHk-=wj42Dks1vknzKKBbXUMCrs-iuLZHq=0z3P0AN9TrXNP+A@mail.gmail.com>
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data consistency
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Ivan Kokshaysky <ink@unseen.parts>, 
	Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Magnus Lindholm <linmag7@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 09:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Crucially, when emulating non-aligned, you should not strive to make it atomic.  No other
> architecture promises atomic non-aligned stores, so why should you do that here?

I'm not disagreeing with the "it doesn't necessarily have to be
atomic", but I will point out that x86 does indeed promise atomic
non-aligned accesses.

It will actually lock both cachelines when straddling a cacheline.

It's slow, it's horrendous, and people are trying to get away from it
(google "split lock"), but it is actually architecturally supported.

                   Linus

