Return-Path: <linux-kernel+bounces-577393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31568A71C71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F84189CB60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EDF1F8BBF;
	Wed, 26 Mar 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JayTS8rV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEACF1547E7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007888; cv=none; b=Jz4I4urHqOiSu8MqoBocnmWpcUQctUYPDP26trFTmG1sRS47HjdaYBrD2DIEqq7q8cqVWuTkC2Zx5Hqa5jr6nlaRzcwoSqLXYsscoxZXB/zxWUecbm3Sh7wl/kD7dnzawtNM1vszMjrPimVFDGeN32c22ZmQfyLL+GJPLGp9iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007888; c=relaxed/simple;
	bh=7v10mmac03rPThDGMIRHGVGhg7qTMh0XmgNoq1q0kBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRGh38gApoYNd1aA30GAuXTIQDkN0Y+yx2A5o9BDfPohWGLMqnqMAYTeCHugQ5L5Isz/IYEzv8kJC4Y6smfRk4EL8sd4vbTHM6PRvhRrDSo1OIVF/4MFWa9hmkGnPvPfMZ9RS/C71Wre/ttsePRqOHfQ+UPxto+T1AQZGDWP/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JayTS8rV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so5322566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743007885; x=1743612685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YlX138X0XD6VY0/PSMsdwRSoZx6II/giCuqBLoh1aW4=;
        b=JayTS8rVfWXBrkrj4bHxV7/fqcMmvpzztCRNbYw+RwV8ZFiVwgJFAD6yyorkYjehWS
         xQUnklM7s5jrYfNCKuWF1BTsrez8Cel1hR8Hf4WejulPF9qm1JUxEVIWNCNiOoNAHVSy
         9tsU+YLr2FEfvZ9aa4wlaq2gXOvB5rCVzRy7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007885; x=1743612685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlX138X0XD6VY0/PSMsdwRSoZx6II/giCuqBLoh1aW4=;
        b=Ee/chCeQIKIhVYdfoGd5uspmVDe7YmNyhIKynYARZaAx0XF3911IisYI22sjJ3zxcb
         SKkpamoKlUZFJU3WYrcp7mQC7QaSztw597EZeg63ncX2X7QkpynGz2+Mt+hM94GZgywZ
         TfJtHA/yektU7KRkdJePEbBx6w/B9Z6AQgVjfNzpJrwIJ986vvMKLxbK9XRuMDRV6igE
         WFp58UZOSbfQlYfBbUN2LKe7yMttBTVUD9A1LSdDyZBGO6KpzJqIQokRrvL0si4xfH3i
         R/SC0JhV/XiN45djFCDFDu7u+uDqGbGXwyzXyyO4jUULLwE61uQavo7Os+riwi0zY4qR
         soWg==
X-Forwarded-Encrypted: i=1; AJvYcCVZsOcwQLkGYX7VR1zY7A4pWPN1GJuaex4DgPSFIBT8FaOkxATK7koXgE0y5vq0UZAkJB8d51N9CoO8WV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBF1doIDpe27dvI2hBbYHQRU6QHiisMyxLBqKlon3zsR0KOLGr
	6p2phxj7ELhG6rbpouqd7+EQ+6v7tcK+xTFzibCQy4Cvwt6Eqw7iVoddOS02BixspQnnTk7XPhK
	joh+xNA==
X-Gm-Gg: ASbGnctBYryhvrpQe3jOYfFxcUqoLlEGJ0X27OQPagDA+fSRmjcGawAy+5wGZNduOFb
	ir+GomjzmvZZdcUOCi+zKpnEcgatT/u2VFO8RtMn5zz0oFsoUFX3tvlR/sYe2IB5cv5dPiAf9NK
	3cVkPZZyyN79V46B/6+UOXYv2VvA76fEDZl70NJlQ9UrXynEqEFsmOE4kMqQF9nJS+UbgfSWZ2S
	eZaUULPukQsNMgg9EMrQBWoqzOoIGtmU9+B2SmR+Yy3d4/SuDXo7brmkUrqsmfaGdqufsWuL3FI
	G47Ko5m1N9CQZRGfl3NnjgmQ3bb2J0CoL42jxZ8AW7eHIcFEagD6t/s+W/rhw6WvnJxLcChd6zA
	VYHbcWtm2wywaStZuofI=
X-Google-Smtp-Source: AGHT+IHVEeOinYQR7P1s4tx0AMEZ/gwAqkSDU4WFbzPjMO6EEBnjWMRsRC53tlrcEjYRhLcgYhx8iw==
X-Received: by 2002:a17:907:7d8a:b0:ac6:f6e2:7703 with SMTP id a640c23a62f3a-ac6fae44e64mr11854866b.8.1743007884783;
        Wed, 26 Mar 2025 09:51:24 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4798dsm1052184666b.161.2025.03.26.09.51.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:51:24 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so9887a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:51:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8klcRRZPQTvQDRRKlV5QyMeJYyoOTKA8o+k6T7fZOvf2OGXEHl3luzCtSByzYA/iAyZSSQHLAiF7J7k8=@vger.kernel.org
X-Received: by 2002:a17:906:6a2a:b0:ac3:f35c:755a with SMTP id
 a640c23a62f3a-ac6faea0d57mr13698466b.15.1743007883744; Wed, 26 Mar 2025
 09:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
 <CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>
 <Z-NHugcLdLqkEHFR@arm.com> <CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
 <20250326124025.1966bf8a@gandalf.local.home>
In-Reply-To: <20250326124025.1966bf8a@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 09:51:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwmmU+hv1SyMoyr8yAGP2JiAAP+g5BZaMajzAukzrM9w@mail.gmail.com>
X-Gm-Features: AQ5f1JrHB7Lot0cInBUrRaxXLA6wQWz74bylkRNtBdz9wX2p3sbslySwH8F-I1o
Message-ID: <CAHk-=whwmmU+hv1SyMoyr8yAGP2JiAAP+g5BZaMajzAukzrM9w@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
To: Steven Rostedt <rostedt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Konstantin Ryabitsev <mricon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 09:39, Steven Rostedt <rostedt@kernel.org> wrote:
>
> Now I wonder if you see any of my emails that I have been sending?

Your emails are fine. You're using a kernel.org address, and you're
going through smtp.kernel.org, so they have a perfectly proper DKIM
signature:

   Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF624C4CEE2;
Wed, 26 Mar 2025 16:39:38 +0000 (UTC)
   DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
s=k20201202; t=1743007179; [...]

> I have my own email server which is on a dynamic IP which most ISPs will
> simply drop because of that, so I route my email through kernel.org.
>
> I just sent myself a few test emails and there's no DKIM signature, unless
> I manually edit the From to use my kernel.org email (which I have never
> used before).

If you don't see a DKIM signature, it's probably because when you send
emails to yourself, they never actually go outside your own little
smtp setup, and never go through kernel.org at all.

               Linus

