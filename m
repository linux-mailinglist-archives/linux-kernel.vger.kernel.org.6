Return-Path: <linux-kernel+bounces-516245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDEA36EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090D13A748E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFF1C8615;
	Sat, 15 Feb 2025 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcpJ7IWq"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6A186E54;
	Sat, 15 Feb 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739627564; cv=none; b=gT/hhvZpJ7RlOpj3Izgzj8nycg2bimCAw1ONx0kn0EdWWpcTSDJBvP54DH+3aWTDe8QqOegU5JDB/3T+VR9QalcgvfuvH7Iw72OTsU4AMbsiImdQ0ojOiw77M0QsGI82FIeL9ronuq3TEUKEcLG32reB9Ydz1O9q3ulA5nAP51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739627564; c=relaxed/simple;
	bh=YWhbF1mdP9nqZ2WCZQtej7ovlu0IyuZ++4Ue367cGEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ihmUFQ5NEoWK1J2CPW9Rw1E+iUH1s+SFj4ADHFlpiClJL7LJefc+83lurKYgM+MUL5T+YKsFdRnoMxAt9H7KEc5UrRhkEYj1W5g95mKrSqCtJ4cGKyX5IUx+6rMf5pBvI+fCqD3HMaahbGGKa45pnV5vQf6e/AGAmtrf8AVgfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcpJ7IWq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so52540305ad.0;
        Sat, 15 Feb 2025 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739627562; x=1740232362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaNUxH6SFpAA21j86E6kLFdfmS5koBBXhIiZdTkRCXo=;
        b=jcpJ7IWqYTNtVWHU2DfiDWFCW478wZR6DzWjUQ2RT3wgTzF6Cko6qlJO82+EGfnSCS
         uN38Hl06A4nS2PKvUA2OI+lmtzwlZtNHe6+PccaA4dz/O89Wu2qeDdcTb7E0E2LEsV/d
         YN7hTE3eb+bL9XkEkW78GAcfz0q+ll+HfpK9GDG2A+39IMoynWPgq8CSMgVhMUyK6tng
         f5af47vHh22szySw1ZlPHmygHidZaqlUhxQ/7FLlWzBzR5+aHE6s4Zh4i9knrvt6OYFM
         uZ8UUbtxIW9DJlGD1EroCkYHO/WCWul5HFhbgtmia58npmcOfkrgORuOd3zNAt6eHQDQ
         k7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739627562; x=1740232362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaNUxH6SFpAA21j86E6kLFdfmS5koBBXhIiZdTkRCXo=;
        b=SfnX2XQqIu778AfAMObHXpVOrGT/8+SMCK2gAbR8MmK+ibgZdO+LKZZgzL+1QYdrcy
         FdQ9Bb9AbtB14M36nP2bRpOYu54n89sfmgF8Ct3gSRmZzjHncwLLOY4KSeFJYmgRG1Yj
         sakbODjtXUq90hl5KOCmfHJcR97/OTSKVJ2Gx7k3MHtrXtE5Fpf26tEVfFonyRqQgaNw
         cVg2e2HbPriHbEjS+xifbzlklnnwlyhihgPEug9PA8Zai8ySRy8vhHJMqGKYc7otYrqn
         THGUUDle+/oyyydGeQbGJNjkriUHNoqHHtLL8E5DDHqItGOJA7gOsCg3/dK1jTFnoLDV
         6/4w==
X-Forwarded-Encrypted: i=1; AJvYcCV15TYiUYUuRvWSHzYZsmC3YAhiTuiNov0kpW57PZP4KfOHSaSf4MeyBm3UU+iEjLMmToKZxffi+2y1oLE=@vger.kernel.org, AJvYcCVPVxWUGB/lEc32d8x1UN0s5mglUBRMuWbgGdDhC0tJZLrBNkrPhAgmSnm2avHt+m9TZHLt8/A5MwcEk7PYOgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycWUECjxqgxNRAcCmQBCfKZXhBA5DgBrZH/WIZw2EY5TaM/ulr
	prDNOCfXFsKpOW0fruBr1H0dwZD0t6p0plk/wo3litm9ZszIvWiL
X-Gm-Gg: ASbGncv1y9YoMfxsHBqdvJciKYo73HPBS0xMWRRF6pWAZbbao60oPaml5ed8DeSLLnM
	Gxkc9uLRbE0zlOeH4FAZAsId0u2qQAPxxNA2CRDzOI2PoTXPVNEVD1MqKJ8H+zd3vXAC5ixw4pW
	LEjtM0vPGC6AKkHqw9BuG5R5wQke/xlenttUJdsXzCVCBqmcbbjW+VhE3eiSHnJT2Co1rSjC3IG
	b98qY9ULs2gxysRX0bbuAXuFw3/ctK889GVLnCC87UPsXNJU0UeUl3xuCARnIDB/OKnl+M9CC+5
	39LiripngB74f/7dHespNjCU
X-Google-Smtp-Source: AGHT+IFfaxeE+NyKacuzcbL4HKdiCGziXsxJ0qeAcMrBVH78k3SQu6rlAWweKDn8yQlNhWcBEVICjA==
X-Received: by 2002:a05:6a20:43a0:b0:1ee:69db:b0c5 with SMTP id adf61e73a8af0-1ee8cbd7f21mr6325214637.31.1739627562422;
        Sat, 15 Feb 2025 05:52:42 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732532ce7f1sm2970126b3a.73.2025.02.15.05.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:52:41 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: benno.lossin@proton.me
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
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
	miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V2 1/2] rust: module: change author to be a array
Date: Sat, 15 Feb 2025 10:52:29 -0300
Message-Id: <20250215135229.300420-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <93eaeb37-9913-49cb-be6d-367696a81baf@proton.me>
References: <93eaeb37-9913-49cb-be6d-367696a81baf@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Benno Lossin <benno.lossin@proton.me> wrote:
> This commit message looks a bit clunky to me, though I am not a native
> speaker. My suggestion would be:
> 
>     Change the type of the `author` field in the `module!` macro from string
>     to string array. This allows multiple authors for a single module as is
>     already possible in C.
>     Additionally, rename the field to `authors` to better reflect this
>     change.
> 
> Feel free to change/adapt anything.
Thanks for your suggestions, in the truth my english is not so good.

> As already mentioned above, I think it makes sense to also rename the
> field to `authors`.
When I maked this change, I thinked in change the field name from author to
authors, but I don't doing this because anothers fields that is a array in
module! macro (firmware and alias) are in singular too.

> You should also change the documentation in this file, there the field
> `author` is listed as "string literal of the author of the kernel
> module.", so it also needs to be updated.
Yes, you is right... I haven't seen this chunk of text 


Thanks,
Guilherme

