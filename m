Return-Path: <linux-kernel+bounces-549277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D19A55038
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D103AA077
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F984211479;
	Thu,  6 Mar 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ5xiwMU"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB6145A0B;
	Thu,  6 Mar 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277338; cv=none; b=XqUHWkp/aYN8SXpZhG4sQ+h0enWgRDQe7j29hp2P+EBzz0XJjjEwcMqTz9LJvSa87j8eFSQvyzNls/yUtsUHYGfwuVPWCue7gvOOmGNXHOMGkDat2hlOlJbm0BNysVBhKXX4fTWgodYFa/GPrvrlC4oU8lylmye7/D79TKfJYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277338; c=relaxed/simple;
	bh=6inTVkTcpGwvmg6llHOj2dPDvxgSjLoa3hpVklIUPbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQi4NfuQ/UkUcJnIw6SYAWKxbr9UbzrFybyIss49Szb7b+I4PcNiZwWpPjiC6ABmW7sqnXGfZsauzfL9NV0Tm/O7fNxgC0nFNcS/7BJUr6Aa6mvH0PF56mzviQ3Oj0yaykw3O69P0t26fsepI12GQfMUebt29ko+tz5vUYcdvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ5xiwMU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22401f4d35aso15849875ad.2;
        Thu, 06 Mar 2025 08:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741277336; x=1741882136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E15Ou/Ag38gHJBr4kh5fGeP0yT1X2+13TRGZu8RxeNc=;
        b=cJ5xiwMUCxVmCU28Og1z/xo4RFgpXiQ1bj1ZqGg0SgydpKExnQJ1sNprFgTlpCn4sz
         QgHERhR/q/CI2bvB8EARO1FOqYP8+Jh5mzJphNxDrbXZLeztUQhDP/KRfEI1z/flOcoL
         dusYgNY9qrcBzb7Ni8uYrCbt3B6tkmu5ROXyexGFmS8/bpvbZpFh5ZEKXJrsYMkyf5k+
         wsBb6Ioo+Yrv39Vq1OnyJiOK61QtnbRoFlIW2wlTGesdoyMFXPiU1Js5X+SFQg7591Yv
         TAklU+EPnP9otaAzvDaZayblbKNLf5cVMunN79u+8RR92QmbkjpVncaKAmPz6zojVtoR
         Xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277336; x=1741882136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E15Ou/Ag38gHJBr4kh5fGeP0yT1X2+13TRGZu8RxeNc=;
        b=WFyIYEPedSy6btGJ6dD7k4xU66WWLh2dHk50pvc/QxyFB1J0d8sY7W1RItLUimjpPT
         82YghiKFmKbYvDYmq8+Gr4Zuofqh+vhlsAFplVfAQLeep0oRe7rM4ZZ/jx/KWHWTwzo7
         VgG58A4moKZ4cX8p5xLL9rEN72JOuG+TBdOvWBAcjBifu5lbiQpG0kTWY+Eh4nBxYo0c
         3f8HhRyD3TMazIBFmx47bGQ0IfQDxoDetHx7J6ZHKB6PNRsOF3tOr5nGFvGwtD+akxCb
         cN1aOdFtvyZI8zDyL85eDm9R8RoXyGWY2p4FeovZVSYoHib2FWRli8jpt0HSaWfR+q8v
         8/PA==
X-Forwarded-Encrypted: i=1; AJvYcCWGwqFHBSLkECc0LBmv2Tqyw0IFLR9dMXBdN7SRzcLZ9gHy/V81BQCtBOomDSzGUO357dkWLYXSSXO+D1Y=@vger.kernel.org, AJvYcCXIJm0yw38vapZAKRggUVzjTsY8jThWXEpftCr69kgEHEPWrsiTeeVK1jlkL+4HTpyWaT3TL/mu7YgSrenYHMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENTjTL5/m5wFKFkpIx8qvta/MT/8jUAdWDesGFi0Z4iquiuT2
	GhZPRtnXx4a9KaT38Uyv+kgV7gXXmBnOEFJU/wQWANFugrGUtxQy
X-Gm-Gg: ASbGnctX5mjR/424eI4MLt97kc35W4CRdjgPNBTO3ZgxySUAHx/UX34USc9/dYWI6EY
	0RbpwARybgRXf8wXNurHKpCCURHkz5JCcSojP4LFaITkJ7OKM2O8tMEVRIQ74j0A8aJvpsBInw4
	AxuKOEOYZm/v5XBC2L+S6cmOlEsezmfbrYcLrD9uYgenFqRHrttPBEYeVnB8a9dmZbqerzqjEoN
	bw+W8KQAt4x0SFn1+Alr9QR4vl0xuRsAYXmeAW/Xhdq1frRKVY6tLKWbpxvM2gt5LzAubxGW8h+
	a/b27AmORV5jHoaYoxuX1bCW4nbfb5mq8UvL3cJRu/v2HklW8XmI
X-Google-Smtp-Source: AGHT+IGWtCYPtPKvA9ytZNWDmsaikYLXtYMxsOG12S/GFmGoPi/hKI+9bFGk5HyAWTh506wT+dZJiA==
X-Received: by 2002:a17:903:244d:b0:223:5ada:88ff with SMTP id d9443c01a7336-223f1c982dbmr145065475ad.24.1741277335621;
        Thu, 06 Mar 2025 08:08:55 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd5f8sm14203695ad.52.2025.03.06.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:08:55 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
Date: Thu,  6 Mar 2025 13:08:44 -0300
Message-Id: <20250306160844.269308-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72n=gFWrv9yFmzntaeR+RH5=qeD_uOs6NiW4dHkdaopKKw@mail.gmail.com>
References: <CANiq72n=gFWrv9yFmzntaeR+RH5=qeD_uOs6NiW4dHkdaopKKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> In any case, without changing the configuration, i.e. the current
> status, what happens in the different cases? e.g. 1 item, 2 items, 10
> items...?
In current config, the formatting seems don't have a effect for arrays. 
i.e. this array: authors: [ "author_1", "author_2", "author_3", "author_4","author_5","author_6","author_7" ]
don't is fixed by rustfmt for no format.

Thanks,
Guilherme

