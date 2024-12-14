Return-Path: <linux-kernel+bounces-445837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00839F1C15
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577A9188EADB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1C182BC;
	Sat, 14 Dec 2024 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TOAfIOYs"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782751401B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143148; cv=none; b=mmJMphL/UR0lFIziucGoKm2WkaYnfHKqUmZH3nb3PMbiTwmv9WxmJgHpRw6miehmYBYCTw4hfWp+0lU8xb8tPH/pHB2VEK2IfFKyBNVeXtUiYGjSVgRTTbH7Wc8gLDwdFra+fvHINeZqsEVZjzajoNVKqiLykxh+yGExkJYWjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143148; c=relaxed/simple;
	bh=iq6dDBbndLiY2DDddQXufq1/8xq38ddxvn4I/8Ms6j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl2EG3m0pHOLFfYfAjM8pHM/moZkYe/gY0/3+RcXsXSeuw5Ir79qV7CX4uU9iSWn8+6WagF4q1I55nqvzYPdoLP0d7RW7smedwNaz69PudCn6WZEUqczeFp639JgQffODtobsoUAbwjehucDwL8no3f/jHRS7KvSjGHvUPt8+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TOAfIOYs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467896541e1so60511cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734143145; x=1734747945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iq6dDBbndLiY2DDddQXufq1/8xq38ddxvn4I/8Ms6j4=;
        b=TOAfIOYsGw09snwAdKsaL5dpulvRx5JP4DLhNeR3ZP4b/iSTmcS54EfV/GxkD5OQsK
         atmrKU8y86YWDwP3dIzcykV0tx8QhggnwCpKju3bb/tbDcRZ1N/3P0eZ04zeBoDl4vKD
         JgYCf3a75hyXrFZFCiL8VICVTeLPubtpKsW3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143145; x=1734747945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq6dDBbndLiY2DDddQXufq1/8xq38ddxvn4I/8Ms6j4=;
        b=fS5FHVrRrZ1P8E0p6YAtbInr8tUtMo40zq6gOyb0fec4A/S2wrDeVkpn4DDjM3y+ow
         1Q5MfZCONcA8QyQDYO2Wh+50dDtpgDvpIQcgLnE9BBQAlk9pop3DML8tA6IgwVS+WS16
         XsNmbxBtCeamN8IR6WUVJz3EJlhKunaHNV1tyweohjgYovJbLGB8FQLHXmaBjX4Px+EC
         +gShYpAOgM/7gKZ1CZPj7+GBjx9QU75uAx9OnU5nRMzyigsjBaKcKOswGGSqWN9OmK/I
         2gDr2/7UWct76yY38ytm9mP6hk88ZO3vDiSUqvR4pnklLpAEkwlFbirQWkvscL7Ar9EO
         ViuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXTPN1Gxaqxta/UgK1a4Pe/0ZNLCZu16WvWxb1QFBsmA7Mma/AV6GtaObAjmy8AXSNSb05toAsh3FTtRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwarEdBbw/F1tRSL2gS0csJplh22nD2+A2mosDDFf0j2oZjUn
	R4YRRebs0oh+vWvj4zLM0TfavNddz6rURhCNt4ZN66iGziNWdIXUihTI7LUtOgN1ED7WdkmReo6
	GPr499KjqK4QFc+spkavknIyT8yhOx1lqxI8+
X-Gm-Gg: ASbGncswQk4WSGefzgrvdqRNsyTkbXc8OD0ufyb790yTmzZq71oHbHYpbJE2bGfOYMl
	EYmqrXIf1fmIku6GS43pgNNQs9tcCppR343w=
X-Google-Smtp-Source: AGHT+IEOn70h5dn6BYdJXbg/aSWnK5Ci6RKTe7m32gd+98te1xMx5Rg0/FeuU5bBDSrYLKEpYMEBBJdcHNY+XpSFfJI=
X-Received: by 2002:a05:622a:89:b0:467:7f81:ade0 with SMTP id
 d75a77b69052e-467b30b4e71mr1334511cf.24.1734143145148; Fri, 13 Dec 2024
 18:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org> <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
In-Reply-To: <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
From: Julius Werner <jwerner@chromium.org>
Date: Fri, 13 Dec 2024 18:25:34 -0800
Message-ID: <CAODwPW_c+Ycu_zhiDOKN-fH2FEWf2pxr+FcugpqEjLX-nVjQrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, Julius Werner <jwerner@chromium.org>, 
	linux-arm-kernel@lists.infradead.org, Roxana Bradescu <roxabee@google.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, bjorn.andersson@oss.qualcomm.com, 
	stable@vger.kernel.org, James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I feel like this patch is maybe taking a bit of a wrong angle at
achieving what you're trying to do. The code seems to be structured in
a way that it has separate functions to test for each of the possible
mitigation options one at a time, and pushing the default case into
spectre_bhb_loop_affected() feels like a bit of a layering violation.
I think it would work the way you wrote it, but it depends heavily on
the order functions are called in is_spectre_bhb_affected(), which
seems counter-intuitive with the way the functions seem to be designed
as independent checks.

What do you think about an approach like this instead:

- Refactor max_bhb_k in spectre_bhb_loop_affected() to be a global
instead, which starts out as zero, is updated by
spectre_bhb_loop_affected(), and is directly read by
spectre_bhb_patch_loop_iter() (could probably remove the `scope`
argument from spectre_bhb_loop_affected() then).

- Add a function is_spectre_bhb_safe() that just checks if the MIDR is
in the new list you're adding

- Add an `if (is_spectre_bhb_safe()) return false;` to the top of
is_spectre_bhb_affected

- Change the `return false` into `return true` at the end of
is_spectre_bhb_affected (in fact, you can probably take out some of
the other calls that result in returning true as well then)

- In spectre_bhb_enable_mitigations(), at the end of the long if-else
chain, put a last else block that prints your WARN_ONCE(), sets the
max_bhb_k global to 32, and then does the same stuff that the `if
(spectre_bhb_loop_affected())` block would have installed (maybe
factoring that out into a helper function called from both cases).

I think that should implement the same "assume unsafe by default
unless explicitly listed as safe, check for all other mitigations
first, then default to k=32 loop if none found" approach, but makes it
a bit more obvious in the code.

