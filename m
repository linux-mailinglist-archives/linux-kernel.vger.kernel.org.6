Return-Path: <linux-kernel+bounces-241456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D36927B98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BCE2861AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770E81B11EA;
	Thu,  4 Jul 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GCmFU+vj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8A1B1503
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112897; cv=none; b=QCB8/lhmMMWLcX48Trmuztrkgd5VxqvWYicKA/WpDLd+XMcR9/uJ7h0vwt3ewej1uzYarkSeLIiFwGTsFdFDjLQMW8RlaqMLAiZK/KdePwXHpf4MRSsNCHBdyvOa9X2sQMFR85HJPjQYGerXD6hyLlfhkUQlpkUuht0SpknUbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112897; c=relaxed/simple;
	bh=QguQgLZBBttmrru34w9QMLWo5wJFt+WRZM0wpZpr6UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/z//t3S/Wyn2oTNhA8fg88xmCtb0YoxmR4/+qkaxuetSodIx93azTBEyKjtymCs87Vt5rFZOXNt7a1TKpZiOhDrEYvk2c+/LrcarMRjlI+aWg6RcCBcWf2iNXt6rF0vI/vEETF66jH0Z4PbLhSDxXur2fTpe8JRKgkE7Pf9lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GCmFU+vj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so11647251fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720112894; x=1720717694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=GCmFU+vjTvyzSneyN7I8hdFl4DW1ZAvLTsY4E/mnHvsWKC9RbjOPc5mf2KDqk0e44l
         F5SnDbjCIsGvjVucQsslqESmxvSsucLsNvaemwINZYRdok/Zw/bzYx63z4YYkpUhrx6T
         5slX9AP6k7xzM+ynG0lDcAba+960v4ZrJrybQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112894; x=1720717694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=VDmnHARkVpH+ThJKmMtRuJQ7AgEi7v5t6MSsy4gdGCMmExe0szQEKyzxOQBLDBq3xT
         Wx9m+GIR9Yrqb9fIG3Bx1ZH7TCYp4xeolOO4KqCCZ5iYVybuUbBq6hAjpHHJxNwMfRtg
         JGPjk2VJgI9ZyylARw91EFtwW/buzWyY9Va81IPaNHOsU6HO//jO8Vb7TO47VL7cSMRd
         HVmq6AYlxEjvX0gLOyVe0rx+WRdmMOC3TDBTgB3wfQL5AXY0bdVrkx0h2jCvIhRQz1JZ
         o5qAS1NT8AKIs9L2y89MkB7jS7ouwu8HAAOxO7i3KJy4esPHjSvD6t2U+Si/scwYIMep
         FWLA==
X-Forwarded-Encrypted: i=1; AJvYcCXyEiuwbC2daoVk2i4Zq7lHlGOrdrNlfeDYDD6wOYMGd9/a5+JfBGqBWqHQsV+ghr/IZExQhcpwn1Di+GthuX/cGoug/vbfav0G9UkT
X-Gm-Message-State: AOJu0YzlqSGEeKOy2nxtkkH5Y8GsS28e84i6pbGiFPTTaFFDqVJf/Z4Z
	TlVppTHTzC6x8HclXgCNGQbIysRc95e7JV8ecPJdy1YLhrhsLufUze+C7ZrItNPJKmkf7h76IxD
	lKm0XSQ==
X-Google-Smtp-Source: AGHT+IH0QyxmFu0ourIHusbsJCi8D1tpEbBiGWf0NuT5ShUpVrwHVlUf3+BhOf4JWQNlKyEzEUGdtg==
X-Received: by 2002:a2e:9c8a:0:b0:2ee:80b2:1ea9 with SMTP id 38308e7fff4ca-2ee8ee21297mr17809481fa.49.1720112892386;
        Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee89936f2bsm4428601fa.10.2024.07.04.10.08.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cd80e55efso1456693e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHYdaCwAEDbZjzQk0p0vV9QugfYJj9buLS+RW7hURs9Ot7Bul9JDUUHOjiawXfmc/ZfCjBJvyQ6VdaYVVksrd6PfC6spCnLDoPiAcy
X-Received: by 2002:a05:6512:204:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52ea0632781mr2063767e87.36.1720112891664; Thu, 04 Jul 2024
 10:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703182453.1580888-1-jarkko@kernel.org> <20240703182453.1580888-3-jarkko@kernel.org>
 <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
In-Reply-To: <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
	Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 13:11, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))

Augh. Please don't do this.

That "__and()" thing may work, but it's entirely accidental that it does.

It's designed for config options _only_, and the fact that it then
happens to work for "first argument is config option, second argument
is C conditional".

The comment says that it's implementing "&&" using preprocessor
expansion only, but it's a *really* limited form of it. The arguments
are *not* arbitrary.

So no. Don't do this.

Just create a helper inline like

    static inline struct tpm2_auth *chip_auth(struct tpm_chip *chip)
    {
    #ifdef CONFIG_TCG_TPM2_HMAC
        return chip->auth;
    #else
        return NULL;
    #endif
    }

and if we really want to have some kind of automatic way of doing
this, we will *NOT* be using __and(), we'd do something like

        /* Return zero or 'value' depending on whether OPTION is
enabled or not */
        #define IF_ENABLED(option, value) __and(IS_ENABLED(option), value)

that actually would be documented and meaningful.

Not this internal random __and() implementation that is purely a
kconfig.h helper macro and SHOULD NOT be used anywhere else.

             Linus

