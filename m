Return-Path: <linux-kernel+bounces-550754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC32A563AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C89118966C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC6206F30;
	Fri,  7 Mar 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn5LpmQ9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7A1E1E15;
	Fri,  7 Mar 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339346; cv=none; b=RSgEjVy0wnJBRbxTt0m5LPGEf6ZPEyeWIaZ91ouQISGmJhgBtaoAGOkOvMpqN36OygTs40YCMK6hzlA7m0VCMD/9VqbKeH7NLN7NksPsx/+WF1oh0cAQhFORiGu1VTSUCgSqBS278kfeaRWwXsfAg/1NCf8wr6cv4Vz23RsF88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339346; c=relaxed/simple;
	bh=87Kb5biitOhpG5gMp3bpw5yvhnZmWoZlHADSUNLC8LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9IeMOC43sVtc7KeO3sE9tqsFNSCJHNAcJR/WeDngPC2SvCoS//0TLIQXA4yi5XiYaY/VXe7LaNgYOzaXIf8Cu7F8EDebbQKHKJmOOkU6F9bPASPYFpQ5cTsVXQWSj4i+F5jITa6M5s25cGw2yeDQn6lFAo/qd35b73Hw5cdPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn5LpmQ9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so422797a91.0;
        Fri, 07 Mar 2025 01:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741339344; x=1741944144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87Kb5biitOhpG5gMp3bpw5yvhnZmWoZlHADSUNLC8LI=;
        b=Hn5LpmQ9rN/G1c5jJ0qhokCQyRUVk+PMbSxGj3+JREOqk/KMeryWWi+5QfG7mlMDAt
         2wPVAMYqbaefKyr41MCZ2i/jql9WLTXyb0rJsg8vGjS6G53I+ZpHLOBakeq/oMOuxxgy
         8Fhf3BST3SIbDjzNETaDvcUJUL9lrClGUnXAs/ymdSKHGsuSUc0a/TkTwb67uefOLc9R
         F9fM0U7RZkyfLQSSdt0yESIrUwWYu8lifR08Jv7VjzVxpXAEBWE6RJhU4oOLk+dj9a8t
         hymbKZ9O+Wy+gI39f1oxXtvlpfy21DsTirvZxX2WggqpSnKEFKy9PgoL/kup34brHydN
         /17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339344; x=1741944144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87Kb5biitOhpG5gMp3bpw5yvhnZmWoZlHADSUNLC8LI=;
        b=eW1y40riy5acZjhNf6qJZ026ffTZMENW4pe9FUW9vckxrZY3ybxTAHsWAlyghyYx6R
         DRF7DrE7apowffCKf8CM+dQc63ZlbO2o7jZ4ngnQ4PWCShjXYUYlOqFUk9Kaujm7wKXW
         KFa4cGM0m3x/+WhvcmdEI9AvmWgNw8LtB17orAkqL18v9LjTC9KSHGaMo5JizYKoEn9N
         n44eIB5H2hLdVfPdmvPus3tS9oahViP19xm0sX7wuUU9ERTTCcZ426pITQjJIAUM4n2p
         AruUK+YBkiAiNltOFTuFOWNzfOtHgEkkfZifa7oeRk8p8ZtOejrrj2TE7SO7SIT8eB2v
         5rag==
X-Forwarded-Encrypted: i=1; AJvYcCWXJclzvzbVcucv417HxgrwDU6Z1cqvVlxihzDSjECPYYbfzqS0PC/2SDPdRkDu2QB4zQYCHZRTWpI9TRTQ0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgk9B3ZmAszKl+FjIOVdremiPYlOqQbx2aoK0T+0G2vKSKVkU
	AODCPcDgkyIvvLKuhgsdohDfzdyydUdoSPHpvRyZBHe5yaTSsgz0m1lukzyl+J5MKoo2B8OBDjT
	4p7fjwarWGaGDuzE2qk56bATWpCs=
X-Gm-Gg: ASbGncsapFfYt1lISWzYyi2twpypQDQ5fJh4q/4uUhMMYVDmgbmt3c5A//1275KtC2q
	9xrJjPpFnltmb166GZnSIT0sMNWeYQtPneCSpOEln0JUtCpaOpF+lTtAJAQgbTG1YazsYtrgiAb
	M9hD8Ow1h+Wc9gmIPV2pjiDzxG3w==
X-Google-Smtp-Source: AGHT+IEpu2mBxhDYQudLKRpi7LZHnjwyWrq0RYW0y3YoPrRfNM5pKE+950u744oRgriD/7+EMqn1URCkBNxcQ7BdgbY=
X-Received: by 2002:a17:90b:1d02:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2ff7cd5b688mr1632156a91.0.1741339344187; Fri, 07 Mar 2025
 01:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306211716.51120-1-jarkko@kernel.org>
In-Reply-To: <20250306211716.51120-1-jarkko@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 10:22:10 +0100
X-Gm-Features: AQ5f1JrwqZzYVuixzkbOtIQU9YA20cODrXv2HTiEUfXbth4mGH6OWpn6XFaX5z0
Message-ID: <CANiq72kfo1zSsLc5TWr3wS3t2e5OK_hnECGMpAv-7ezyBsnPig@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: linux-tpmdd-nixos
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Fiona Behrens <me@kloenk.dev>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:17=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> This is my new testing tree for my kernel tree. It will over time replace
> my previous BuildRoot based testing tree (but not just yet).

Thanks for Cc'ing! I assume this is related to your subsystem and that
it will go through there.

Cc'ing Fiona as well since she was interested in Nix and Tamir who
does macOS; so they may be interested.

Cheers,
Miguel

