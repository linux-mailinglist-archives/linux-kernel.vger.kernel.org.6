Return-Path: <linux-kernel+bounces-570431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2FA6B043
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68333483B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43719221F03;
	Thu, 20 Mar 2025 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBDLMaDu"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86C1F7074;
	Thu, 20 Mar 2025 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508317; cv=none; b=GdmjgOQ/PnOfd+lFoNGWtpJbC6vXzb2LJIoxCAeilLHNpqYnWFsrUGQZ9OoD3NORIF5fBe2iVrIc9nQnuceaV9J2k3DAqitcZ21q07SiuG0GUXov4yw2Zr4nt5x5s+AFyz3HkDaRZS61RV5IKUIEn2UKnl8t79yIXNNbZQWkdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508317; c=relaxed/simple;
	bh=p1RASg2XHKczACQM/FXb7ShSCTSi7hvrsyoDrMPtTCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV8Tiip8lYoi63tCeQ+D82E7c5UmewXlJ6VkwJoqrZBVHY7Zd7yMNZwaUdx118odEbFelbba+8InQjGOIYsX3jrM00WbzIdYnvGoMGzjOdVOg1j/UEJRI/Lgai/4wEoyAQhes925gEYbyRLTj7LItVJpNK6mpmS/gw/PZJsXKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBDLMaDu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30beedb99c9so13226611fa.3;
        Thu, 20 Mar 2025 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742508314; x=1743113114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1RASg2XHKczACQM/FXb7ShSCTSi7hvrsyoDrMPtTCc=;
        b=cBDLMaDuBufYo8lB9rDE2y+aAR4fo2rbUyvbtqIuPv9LA6wxvgdsD+R2tTuqW5Bg5c
         o/9P0SY9u4yPlpcfXzCe0RJNSCV6OD/PZkH2iYqRDpeekJTjHlooy2O+uEp8lE3/afdW
         G7KKuV519YqGcf8RWm7og7+gSh81jSbzOE0H2OlyFaXmaBJlr1d2Zw1HLU3V50xx1Nt/
         bCVpoVa+gXyBYb7ipZoQTfvUBB3hiPNbkOcgbDonSPsG3Ng/chHYzVeDv21/4wi3wYFS
         5lVNNQCbh3gS2giBkfAQg674wAtyLeHZ4ZNB97saIHCwabAk4dft1GGPZ1Ua0QX0wLOn
         Shqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508314; x=1743113114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1RASg2XHKczACQM/FXb7ShSCTSi7hvrsyoDrMPtTCc=;
        b=TSRVzYKmMI/ouzXoIWRDUfvjvbLxpSFJUr2exTNqmSuYPvviTiwfjNFmIqwJybeOOR
         jcCMDVURgg3U1+NhUnowGN+vYx6Boqy590G9dEbSJR4eDRYFh/S+m+KbR+suQfwlvjI0
         iebMiUOdZQ45XLP6Qh+tyBAZvrxgjkYf6TGD1hY+ZdpHbtZAsITnzxWnV7U50Q3YkwX0
         dDnj4LgC6QT4zJJ/eNAFn4DUqDGVXN178DTYmZfQ7bgx9FUF2IAsPOWy2ySkoKB22r2b
         zGiH6J3zhS+ft93dMiSL0lcrMRLT/TuYs2Ii5Y4kR3E5fuMMjCfGX1nUMmsLNw9McVFX
         DRYA==
X-Forwarded-Encrypted: i=1; AJvYcCXj+T8C57WKoDQLnoEP0+XQV9KNw3s5MuXlk0+YsYpHu7vNjiELknGvq0eD4lzRZ9K+cTBqKpEEWFeV4R86jSk=@vger.kernel.org, AJvYcCXktsl12AVhSAEHcxurAonLmp3B0trQ0OBEItx1YZXRc0VA0eN4ZCQPg2kvW800i/SY2wOJ/LtW+d+7CSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbWgkt9RxhuDDcss+mGooatcUVc51h7JeYsuwRBGhOgFZZ9r5
	2+BvAdbi0efxDP4QXEAYJqh6qr3aNFqQ7wT2bwKjNQUPxwwM2wngHw0Zux9tSMZRn5CgKN0psLm
	96u2/M/AQRJerZPXjLpZW/YDOVFs=
X-Gm-Gg: ASbGncsafpn7O4u6AflFEh3X+b7MVbGOwA4MNR98JduF5WWOBotv2dfyVpdplW/2/ox
	HAym7UOZbefbAxVxhWx3Ntupe9aYbBkoMfsRXgAjROScG1mgRa4+GhF0h3cPNTVHT+kyf+uFRX3
	joy7NzsII9mgDmOQAuRNsZR/VZfYUjpr+ixJ1eM+BGpA==
X-Google-Smtp-Source: AGHT+IFbDrbgapsx0x5jQolKztjF8xOTEPBIpHmIn1P9NZeF4PPEYJKKlawUnSbtvBVcJl1s1tGB8s2tnca3JePpHWw=
X-Received: by 2002:a05:651c:4cb:b0:307:deea:f576 with SMTP id
 38308e7fff4ca-30d7e2d98e9mr3683461fa.34.1742508313804; Thu, 20 Mar 2025
 15:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com> <20250320-vec-methods-v1-1-7dff5cf25fe8@google.com>
In-Reply-To: <20250320-vec-methods-v1-1-7dff5cf25fe8@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 20 Mar 2025 18:04:37 -0400
X-Gm-Features: AQ5f1JrCJGPMLCdNoFj9SS9bSNS_H9ODe9oTnHfTk7nN88NcmsnMvbYT3n-xXXw
Message-ID: <CAJ-ks9mVTCH954G_HvT6MoxpguEm5NWXtjmNmFBZKENZ0UzZpQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: alloc: add Vec::clear
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:06=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Our custom Vec type is missing the stdlib method `clear`, thus add it.
> It will be used in the miscdevice sample.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

