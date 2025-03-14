Return-Path: <linux-kernel+bounces-562127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6FA61CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2798E4618B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688C204099;
	Fri, 14 Mar 2025 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EVBX6hrf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B9D192B65
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984520; cv=none; b=m7oDA7CFzpplPHpYg2xAPliwqvZ9KTGR6ZSUycSqV24T5q6nRoUF0tpclePcMaMVFsLDwKGgdPIBDHicEg3R4R91RIJaWrL7gZHM9oYBJ5yoqzfwHxiUzk0qh1fCYs9waG2Ib8MV0izVCybI87+lBH7wiQm3/nESmTu9+YjTtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984520; c=relaxed/simple;
	bh=t1kwPiFdaJhWQrItVLCbmUZHjlnWMGvqSeCt4BWyuig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI3miWF2yPKuU+Q90wW3VYIHWwD95PoQcWsaoCe9SH+TUGsncNnMECao20UdPcyX0cJ7qLjLuOPLhsnd+kd/MX80pAnj+/6pP0rkxSAOUK0CbhtkpdKF5e7A04ZA4cw2Ix93+dXYZiB0Ylk/gsjCa5vrAW9Z5KVjaGVSAZAmU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EVBX6hrf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac25313ea37so502260966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741984516; x=1742589316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pogjioNrCPU8tB4PVX2EwY4WFCYTF+eohhDC6CPnHkI=;
        b=EVBX6hrfbTUu+TM1lE3so6A+0S3KYrsMlmpaNELUljGY5F8NdCz3R1XksnLZD+iEg2
         kE/xJurZES8bAnb38XqfnV3UL93gukbsylZPOxVK7HVZYrHXQDSd3NyBBhom5CPkin4h
         6oZ7drYPzXwU1uQZN+/5oXE5tpcv/atZslans=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741984516; x=1742589316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pogjioNrCPU8tB4PVX2EwY4WFCYTF+eohhDC6CPnHkI=;
        b=XyxYEdACodIMXSdFK7yN2/NoN7xLTpWSjnDHBUcqtUVVXYEvcl28+uz721hmNCToV7
         QEsdnnfPsudznCO34DF2e4iSwDtlF1SR2mLJ7fY7OvnxLprGA0Vp3jT/sIB/DycW3crJ
         QuaCnBbMobhSwBLUVorDfUZXglYFVxecZHw+JJ7F1jGokk/tsuw2xbsfHCpj53HiRVAu
         b5XbGjmVBVagd+z3ykhzVwYAn+LhjOwPOCPul/4qUZPd0aHZ7muG+Hgf24v5QWyzuMmr
         x6Hbp5qxEu5hlYnLQpNAMg5wX17FSRXsQrsqUQBkqh3AbNlv7cREXEuJAM8OwpoJmB45
         5tyg==
X-Forwarded-Encrypted: i=1; AJvYcCV8/F0STQzCGPw28Sr0KT/7E42xo7yuiyN2sXaxgJCoXzgm5o8Ejefn8GH9Bs31Qurbc9EapcGxBHXVLDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZl+SmZWIsRyoLBJmU9Vttl1bNMpHVYsgQwLRdbbzIwJd09FF9
	tTWCgBW8tkJzaIof2Udz2T0cRsPoaX1nOEeKslXgbi/yynOg0g3ZeqJQp9JbJx0MKS2rrdWREe7
	HjfQ=
X-Gm-Gg: ASbGncv2qnxggjbxrv8+T2s4Y+8sPsFbkaJLRhxWa/0pxAQjGMTgGDVSX1+b49WKN8w
	xpNY1XwOLEvKv/8kzBoObu3GAHsjVzgYK5tTxyGPmpDNPARU1zRgJv8uf24umFt1C8QRuTtTmWh
	J32JO0s0QXizJkiPjVZ9IeyshGVg/43YfRaq4k367ZSlWjA20/NIrp/tawoAbSaukyB7dgXptem
	G+t/qJ7OV+pHbQfr75wBph9GC8Kl7IWDCDFGZ+5JnqRnPLOW303L7d1mb6U0+cY4KIQ2syhkzxp
	Om84mggUBF68zTKn9lD7Hqpbc5WRZiyEc8PD/GzWxeB6dbzsKVYzCkJriPggdKXwPr3L81YwDud
	Z+fTwWKe+JN0QY81chcI=
X-Google-Smtp-Source: AGHT+IHUDShmDfVACkngcvraJ4ZRK4mp1NiwLMEpqoqDqylEXjsUNGPSHpamW5GRcWFPAoVo1+WSaA==
X-Received: by 2002:a17:907:9485:b0:abf:7a80:1a7b with SMTP id a640c23a62f3a-ac33010b24cmr448539466b.11.1741984516225;
        Fri, 14 Mar 2025 13:35:16 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0df9sm273572966b.99.2025.03.14.13.35.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 13:35:15 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so468805866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:35:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ3Tje6CiRiNAC5DnAtXjkoUvixDi2/KXkSnSROVVnDCfm9r8MjnXVKv32EHvL2P3gVdFh/wUI4GNL5OE=@vger.kernel.org
X-Received: by 2002:a17:907:9713:b0:abf:4c82:22b1 with SMTP id
 a640c23a62f3a-ac330284c14mr404711766b.32.1741984514750; Fri, 14 Mar 2025
 13:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314160458.GA9438@willie-the-truck>
In-Reply-To: <20250314160458.GA9438@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Mar 2025 10:34:57 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgiX0q0WCL+SFwVCYtG7JR3=2Rshse-5J3AO2Y4AgT7Jw@mail.gmail.com>
X-Gm-Features: AQ5f1JryKZLnw2-ForjqZas2k5iB8R4KsSVk5Q8oMuZFtCfIHNVaIuQqepQJz1U
Message-ID: <CAHk-=wgiX0q0WCL+SFwVCYtG7JR3=2Rshse-5J3AO2Y4AgT7Jw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc7
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 06:05, Will Deacon <will@kernel.org> wrote:
>
> Summary in the tag, but the main one is a horrible macro fix for our
> TLB flushing code which resulted in over-invalidation on the MMU
> notifier path.

From a quick look, that macro is still quite broken. Maybe not in ways
that matter, but still...

In particular, the 'stride' argument is used multiple times, and
without parentheses.

The 'lpa' argument is also used multiple times, and the input to that
is typically something like kvm_lpa2_is_enabled(), so I think it
potentially generates lots of pointless duplicate code with that
BUG_ON() in system_supports_lpa2() -> cpus_have_final_cap().

Maybe the compiler figures it out. But that macro is bad, bad, bad.
When it looks like a function, it should act like a function, and not
evaluate its arguments multiple times.

The most immediate bug may have been fixed, but not the actual real
horror of that thing.

             Linus

