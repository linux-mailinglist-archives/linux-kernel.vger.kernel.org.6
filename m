Return-Path: <linux-kernel+bounces-423685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D69E9DAB53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5284E281F16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B8200135;
	Wed, 27 Nov 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JtbJ26WM"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E920013C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723389; cv=none; b=kKSfxUbiUNqxw5bLiJ3SCQhsYYgGxSuoDccGlJ1eAywdoEZs+klDYZHmXtSeoers2/dvt8XSH+T7f/qam9aP2ufsipuP8ll0eSn1thwoAruXRVagJDvq5I5rY5/EbdLphI28Rk/kl7DJRBlcdI1bh+LbyfR161CRntwb2XoxAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723389; c=relaxed/simple;
	bh=kvkQBgKgqvbTXYYmqM6UI6L/FLm2zpO7UdH3CTjBjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFKxXKtJkfLF6OHpoPT/wKh4xKSp7JZ3cvG9Pn8D1jON/2D2UuTTYUh58CTG/M5iMj8i5uLUPWGr3Ei3Wkl4IG1X56TdGqQ7TmMAMVSlcb0xC0JYXXPs1S2KauY8If7P/ebHiWoDeanWzxjqGwiwGYFelcVHDmaMRtUquT/+hJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JtbJ26WM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa51d32fa69so743517866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732723385; x=1733328185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdWnBnwaeKDvwcEaAV+LyuOscfq71IzH2DRHDLZ0UH8=;
        b=JtbJ26WMUVHDaq1JDXdj1tJFzr9m/lecNcygwksM1wf/ZW/e6zrv+sex/T+4oZ1EUb
         Bdd3lavGf97/kLXrHx9eoVblj0kOvYHGkJRiVzfEhcsncEdfniMO4G0NtGqOXDxtpy01
         ucJd3z+g6qeDAkXlyYWBT/jQ2ZfdX4z2oC/Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723385; x=1733328185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdWnBnwaeKDvwcEaAV+LyuOscfq71IzH2DRHDLZ0UH8=;
        b=jpZjC46dZZeZfi/UL3JfM0irJtqtEfL6k4Ra7mLvE0ebOfX26pOGIsiKXn/WNBCuHn
         B9RpEKZKUSB1XDuQxZ7vP3sPaU51Cv9h/KD85vkKw8/0gUAlnlb+748OseTKlcX48fU1
         4ApxzFgYjxpCWO2TIBl9LB6gdp4u2hKSXyZ8/gn4AJRkuXWOgdlb5lUb3zNZg4WUvOoL
         WyD/dVat0xj4r2MzwrTXZi/gpr+tZ5UsmjkSz/zwbEpZQL6l2vt81zuFK83MVbko9B4F
         mCjlQn4W0eqMiDe91KcsNRMy3BWLPQzjb5KSJnlgPFCqutiP0YtnfFwvgliB/LYBVdsX
         DgcA==
X-Forwarded-Encrypted: i=1; AJvYcCV54P5KNXgXWNvK67HcKg6m5ZYL+r7wL6LatShQ4RIXbgKSpPLJUoIATyk/r+Z2NFZ1hZJ2dv91QK3YEew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzAi4/9+tbJvflticCXx9zwN+Ya9MtbQcnkYCZcueyZ18Jf/w+
	7OgKiUsKapvqbkawnbE1v6Hy923eFqR6faLOQhLNDNepqKblicWYpS1AWr7yipvHj16urek6nEv
	tyZyyVg==
X-Gm-Gg: ASbGncvdVh4YrajepM+G34NbG7JfLZ4IBHi+EunGvyC/OaTdK7Gd3zaszUpFRpJUvsK
	mTEBAZ0gi/ojWztgLEJW8zxVFsQXf8pAbmcgZoG0An1/shRzuU18I2gsasbxgq0OZffxm40puFS
	NKQUCYo7k31qF4jZA0DfjsSyvznboo5nFX2jw2dWMRn6OYQovFEDjIl7xzfJSDdT2xDim+3u0i1
	3lpG++kc7d2uieW+rnWSJQNV4STcMwX2tNyzeg+VqwnJsGusoEyAodheyZMfqNvaQySKPqbHoUc
	sdYX7wVBRqifJD71y3RuYgA+
X-Google-Smtp-Source: AGHT+IG9Gh/BLW818TZDCY3qnVMMck2S7C1HmVcfPkqaYBp2SJV0rNAl7tTOKFREnqcV0xxYyI+Rew==
X-Received: by 2002:a17:907:350d:b0:aa5:451c:ce1f with SMTP id a640c23a62f3a-aa5810634c0mr270021666b.59.1732723380377;
        Wed, 27 Nov 2024 08:03:00 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fe94sm717103566b.96.2024.11.27.08.02.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:02:59 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfabc686c8so8039402a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:02:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqqAEKmTMPQHQ39wrSfQ9QjjKcY3ja+CzyuGRBtOk/mEGqtQGbAzKB64u+8ixwoA3eZwzlvQVlN3hfpT8=@vger.kernel.org
X-Received: by 2002:a17:906:3d22:b0:aa5:50b6:a600 with SMTP id
 a640c23a62f3a-aa581028af3mr237466666b.44.1732723379380; Wed, 27 Nov 2024
 08:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125071653.1350621-1-namhyung@kernel.org> <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
 <Z0ZhDHXxHKoE2Nrl@google.com> <Z0ZvAB0vcL-D-a6f@x1> <Z0aRFFW9xMh3mqKB@google.com>
In-Reply-To: <Z0aRFFW9xMh3mqKB@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 08:02:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=widREwanfzcQ3YUvqQ42xLmQHjK_asCFN2jTBM2OHY-Ow@mail.gmail.com>
Message-ID: <CAHk-=widREwanfzcQ3YUvqQ42xLmQHjK_asCFN2jTBM2OHY-Ow@mail.gmail.com>
Subject: Re: [GIT PULL] perf-tools changes for v6.13
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 19:25, Namhyung Kim <namhyung@kernel.org> wrote:
>
> I think it's a bug in perf record since v6.12.  I found the build-id
> event in the header area is broken.  Can you verify if this works?

Ahh. And the reason I thought it was new to this release was simply
because I was traveling during the 6.12 merge window and didn't do the
tools build that I usually do, so I hadn't realized it was actually
pre-existing.

Your patch indeed seems to fix it for me. Not hugely urgent (I just
installed the fixed perf binaries and clearly nobody else has even hit
the issue), so I'll leave this alone until the next perf tools fixes
pull and we'll get it fixed then.

             Linus

