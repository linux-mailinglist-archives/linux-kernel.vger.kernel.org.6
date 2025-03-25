Return-Path: <linux-kernel+bounces-574760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E25A6E994
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E8C168D95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7671FAC3D;
	Tue, 25 Mar 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gFk9531s"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98F38385
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884052; cv=none; b=Ogc6/m+JiIH3ZLzH7WYInpxOn2Y/Jf5+BWjd5mD8voE7A2n2cgEK6ewiZldvmaaU0vGyV3lvUfT19ByZKdha9++TjIDeKa7QILtNqoR3EgxdbLLa17HuepjzyIo/yAEB4qa42mMzmMVqvLp6nKBZvPrpW4VFSUlj79wP6M2rMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884052; c=relaxed/simple;
	bh=lAsxP65TBItfq9A/ejJGYnmNAqPTg1H5uubV19ShelM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX9SS4GUZBn5WLFPbbXgh2nsSB4ewUvQ38iWRXhgVfDm23nxVsmBvcq37IMNur9pqekszzXDloK+NWLX4+uhlg21zfiGOTszPLA/TyY+gd33XH58kBUcyVy4INNl4PIgYJyAPmTIrEbLn3946wmR7OwDWto/VX2KRL7PrAmD6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gFk9531s; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so8739919a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742884048; x=1743488848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KFtkJYIcFO8DPBzUn9JDdz2WSh7YjbuBmns9V95xwQ4=;
        b=gFk9531st5O8Cg+NSXodlSV/+6biIx+IGKHPFqqlFQvs+O+KKc6+k385p53WwOPLMD
         wQlaZYsUfWT2dEr/BLaHVbUKoMX5AXn3Mdh+c5pMAIQns42JBbBvKgUsIfa1axwQLMwn
         xLz6ZDEWUUeV0eOGInKYlxtJ8Tehs6W7AUNKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742884048; x=1743488848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFtkJYIcFO8DPBzUn9JDdz2WSh7YjbuBmns9V95xwQ4=;
        b=uNHWCDphDZ3Euor2GsazCDEcV2jJpGdtNWg0ZxY3+PYEcY9D/7vR9uLrSopzYWjaM/
         JSIE/df81wHVd27xurgpd4MbnyX2WiQ52IunFMyxMR1KeN2V0IF9wR7D/T/K5oDInbYM
         0vmMrU/yrh65uFDF3EvVR3ngfPKf7qNAEkho5wJROQFecCf0vjU+Pg/XvHF53mBx/0bp
         TItVZzc3aMUfbrr+KA66hqCbUnvRNCiOaeWizViabDxPMXxtWqMlTssjMLTrEjkSnSjR
         uzDxsNqFwgkirfULBaVt5SB+31zhz8c8QIJbv90bmLFNExgbE4aSIWT1nsrP5uSdDN+z
         ZvHg==
X-Gm-Message-State: AOJu0YwQDlxpwW7GUp05HcIa1eaA60zpQljO6PG9f4BakIc+HPs/+/sj
	n85CxvqCdv1BN+Hz8pM5/kZasxMxLGke37TNHiz9TVI89ATSkF8BFuDGQUmE9K+JHvZGZZDxnTM
	rwFg=
X-Gm-Gg: ASbGncvGj7w54su+eh3kc/SWJYapjHQv2gtWLGG6uts+Nig6ntWORhjIGyPlwlWQrf1
	TBp60lnQHD+49A+uOAZQ8Erqhte2bjXtE7fThOvxnK7N2P+LXYd647+koZkYDM0fQMv0/aGk63I
	3ReaKgLeJYXtjr9bthoiCAPSa31hHYdiEomwQTKIfU5kQF6qJvXBY8szXWtw/Q5YJcF3ywUe7/F
	h0nxFHb9qmPye+bfOzUDc1kT/2m9F4P8mDzliZBIwjAgu+JfgN/VZck4+M2SKP3u8VdCoLp6J7k
	olwFl8PSKI66XUHLX00n5fDChX2X+f4vmX29uyKO3qKWgumJxKzCjN1fPd0U+MFAGrd8kh9SMpQ
	yziF7GuVMT9IVB8tkHyc=
X-Google-Smtp-Source: AGHT+IHhg1H4x42Ex0lIF+mW6SCRaNTGX45E+LIgHQFLyvhDr8bvy958DsKxE9B+0jt/RHSQJnXG/g==
X-Received: by 2002:a05:6402:e93:b0:5ed:13ba:6538 with SMTP id 4fb4d7f45d1cf-5ed13ba6593mr1460292a12.6.1742884048081;
        Mon, 24 Mar 2025 23:27:28 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c6f47sm7127395a12.52.2025.03.24.23.27.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 23:27:27 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso8373569a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:27:26 -0700 (PDT)
X-Received: by 2002:a17:906:c148:b0:ac3:eb29:2aec with SMTP id
 a640c23a62f3a-ac3f24d5c79mr1678726566b.38.1742884046562; Mon, 24 Mar 2025
 23:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z96jAWGvYzZOM6O4@gmail.com>
In-Reply-To: <Z96jAWGvYzZOM6O4@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Mar 2025 23:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whu2fb22rEy6+oKx1-+NCHuWucZepvD0H2MD38DrJVKtg@mail.gmail.com>
X-Gm-Features: AQ5f1Jor1dJDT-v6IamJPj8N6Y9O_XrLt-B08RQEjClG6tg0-8AT5BjsN4EuytY
Message-ID: <CAHk-=whu2fb22rEy6+oKx1-+NCHuWucZepvD0H2MD38DrJVKtg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build updates for v6.15
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Mar 2025 at 04:46, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Drop CRC-32 checksum and the build tool that generates it
>    (Ard Biesheuvel)

Hmm. I didn't notice this during the merge process, but not too long
afterwards it became obvious that this caused problems.

I've committed the fix separately: commit 2df0c02dab82 ("x86 boot
build: make git ignore stale 'tools' directory").

Please don't just mindlessly remove .gitignore entries for generated files.

Because even if *you* may have removed the file, the generated files
don't magically disappear from everybody else, and when the gitignore
entry is gone, you are now setting other developers up for mistakes.

                 Linus

