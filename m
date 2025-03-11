Return-Path: <linux-kernel+bounces-556622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B73A5CC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49CB179B36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB8262819;
	Tue, 11 Mar 2025 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJpN4V6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7D25F985
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715063; cv=none; b=IONrnOyoshaknwVFcTeBq9kvsgODbdvfIfviubVZEM4T0YMDzJ5jdlw6YkVbfOqgO+540BDfLBkJRCaGdegxn3pgaOMkFq1C8Vfo1xRfLS1f7CQwbvOaOPY3UBm56wNwF1Cqs9PFFZ8Uf77wn9NBwxO8QEOFXRW6c4EJGqa3rQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715063; c=relaxed/simple;
	bh=+RJ+NBsm3TbqIXpQPM4swQ/BZV1uLPkQ1daPvSX1nZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn7FWpAD3GlkmHuKkbpD9qnB4+AoEzLP5oCKSnkMt90GOGKtrew/BiQLBVc9mwI9AQYG3V1sY+dxTrR91whCSxwU6jV8bZhfZg3yo++P1aCyNzvEr46JG7kCTnYkF6xuAw9L+Fi1rcfc3jw0aoYcFcgsqxfREV6S6fQmFebVO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJpN4V6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F8FC4CEED
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715062;
	bh=+RJ+NBsm3TbqIXpQPM4swQ/BZV1uLPkQ1daPvSX1nZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CJpN4V6wxwwbCdo7twXA0eNiA9INx9Tp6AsF6JWmwEiBEol0HVptyWl2mWTGiCshq
	 W042fmkj3MHuc5t1U6QuVZq9BfhYYKgZWM3rT6vIEMyCBfIpg3PzB7N95dVOBFxJzT
	 qqCfpK5XOdirrOtw+aoPIptNvy0oqVf4WAWlrtw8mo1901lshE2lhemA69qu2x1iah
	 X2eoRHLJyooI8dPrxFSkjCUPlGHpQfjdSg/mVRbcat3cb07OPNHkztza4B+oPNRSXk
	 9E7GUbBfLa1Dqm9trGhv7ebQHnJJiV17NjbBhK6qfsC/KIhkcHcrig7DHltMT5Gu/Z
	 UbOniAWZrFAgQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543d8badc30so6493437e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:44:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfq2ib4XQfqZnBVMp7fUA68hNv0BYnmRldibwsbBsmUD0Yjn8sZoorSuj9jPOskGo1UUCAkk9gN1JBevo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8KHxrN/cKQRdzV0OS+3SK7QqU1QePUBM+iF+ymT4wIRzWP7b
	v4KHUTbOlQHkHxgEjwF5cqd630U+BXY3xXAeJVVmaWJlbnxZSJSb2olFftzu5CWyh6Z5aMcARqS
	oPA4ejEDEmdzTcqW2KDgOp5YNHfE=
X-Google-Smtp-Source: AGHT+IGj9iEYvwybjJI4X6CybofJgfd/7jLny/LGS8n7P+dbVWv7pH2mWoVTrrn6ESSgQkMz9XzE85jRUQNPigqJU5c=
X-Received: by 2002:a05:6512:39c7:b0:545:54b:6a05 with SMTP id
 2adb3069b0e04-549910b7c1bmr8267843e87.45.1741715060824; Tue, 11 Mar 2025
 10:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307164801.885261-2-ardb+git@google.com> <87bju7o65f.fsf@redhat.com>
 <3AD32490-F072-4C10-A732-E5BF1E303C43@zytor.com> <CAMj1kXHZsk68kVA=dFbCb3yCrLJmHvn7HZ-qqSjjuQkdUf9_2Q@mail.gmail.com>
 <988E1140-BF0F-49CF-AA0B-D05741148836@zytor.com>
In-Reply-To: <988E1140-BF0F-49CF-AA0B-D05741148836@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Mar 2025 18:44:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGmyssEYer_Su1N+s9svNd3yNm7W4bf9DYHsJszxHoyUg@mail.gmail.com>
X-Gm-Features: AQ5f1JpnsbH1diVjazWrzLt3VkzP3NCSVgNAO7vlhP17HIhvu2E08R8bczybX-c
Message-ID: <CAMj1kXGmyssEYer_Su1N+s9svNd3yNm7W4bf9DYHsJszxHoyUg@mail.gmail.com>
Subject: Re: [RFC PATCH resend] x86/boot: Drop CRC-32 checksum and the build
 tool that generates it
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Gerd Hoffmann <kraxel@redhat.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 18:29, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On March 11, 2025 10:25:15 AM PDT, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 11 Mar 2025 at 18:14, H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> >Ard Biesheuvel <ardb+git@google.com> writes:
> >> >
> >...
> >> >> it seems quite unlikely that this checksum is being used, so let's just
> >> >> drop it, along with the tool that generates it.
> >> >>
> >> >> Instead, use simple file concatenation and truncation to combine the two
> >> >> pieces into bzImage, and replace the checks on the size of the setup
> >> >> block with a couple of ASSERT()s in the linker script.
> >> >>
> >...
> >>
> >> Please leave the bytes in question as explicit zeroes if possible.
> >
> >Keeping the
> >
> >. = ALIGN(. + 4, 0x200);
> >
> >in arch/x86/boot/compressed/vmlinux.lds.S should be sufficient to
> >guarantee that the last 4 bytes of the file are zero, so it is quite
> >trivial to implement. However, I'm not quite sure what purpose that
> >would serve: could you elaborate?
>
> It means if someone *does* care it will be easier for them to adjust.

I.e., someone can always stick a CRC-32 into the last 4 bytes if they
wanted to? Yeah that makes sense.

