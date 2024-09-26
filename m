Return-Path: <linux-kernel+bounces-340637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC3987622
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D30286514
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F0A14D70F;
	Thu, 26 Sep 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewUJumSc"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9514B959
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362777; cv=none; b=ARP8jq2bCcP1yGoMe1Q5yP2QDvu7CKWt8JAFsEEin8mc0RE8WpuoxuMxV25xXXA7FXV2HsDTEDC6bNASg6xqRKj7EKXIKI6kJFQe1LCbTlkiFtl95GpQoJB/RHNLrTVPAYad0w1DzaEO4W4A2QDdCPLSNto4UMzTqCSDNH70mvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362777; c=relaxed/simple;
	bh=Twk1wQnSBYqUrwPgppU6IblWdyNgBfrFOMFHTIuSYDk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S9aQoN8B0QFxtPMscUn7vFtwONUHWSRFoPBEmB+W5oqI7hlTcezjNPtG4Au/wBBiO2HKmraoYFC4Hjn4itCfLh6imgcdoQc2X9/QUVQzYDiwaiuJZmVIVmJjHmbhIF3HqyeNGcaSb+B0eDWMtaPDM3Nyyu6usNoqHnJhi1L2G4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewUJumSc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25e3d7f514so131136276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727362775; x=1727967575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmvRPgDoL8QHsBR9jVlHIhzOpjA+hNTzpNM4jcDB5LU=;
        b=ewUJumScUoSxOntswYgRQ0TE6WGYaddx4Hx7cy8uRwcNHNIi5OTbhPDWtRoM7x9uRF
         y3EUMQskIZ+UX9ibCm3CdPuTkjhEddkWULtkpI3uNzS8ZpR1w8UVd1fAl/r64jT39ncy
         ei9V5Vm4Ed1qOErR0LjQOGqaHil2In9Sof8d/bGgpvKpH278apIeJyEL2On4Kg/G9WZu
         AsBy+YzNY+EJzb8puWV0PofLyJPFwfH8vtQA/kH2P+M6oYKgLXPUq7Is1L/n+IJo+RFR
         hUA0e5GWoI/XmamDHqlOnkuUKDrpIYdYAJrG5uHLnIHYY0BBB4WNR8Jf02lx5AQJRX5p
         KXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362775; x=1727967575;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmvRPgDoL8QHsBR9jVlHIhzOpjA+hNTzpNM4jcDB5LU=;
        b=RuyqnyKxBzpMgpllYNIU/502kqqIyDOO4Q+BOSmEPfzk7ifjP9GNpkUqK7Zhqho1Im
         Vb18WJnZy4/z7pvZmMqoRqX4CoHY9ScYLN+owW9uy8r0dKyDCQAibJAQ6mtdwGPNvTBq
         IvyJP3KbhC+mWLa/VnzBNpuOO4QgD5mCyyf3SOy1lBYvK61dEeYtTmDB8cM7Tg5xEaO7
         so+4tBIoDD3AW8o7maqX6EnGHfntbgC1lyPBYjiyaPgoLflhesBXc2562keWsIwvtl2n
         d2FtTwgQgsc+HZ1T4WNMi1lYW0AsSM4xyDvfYSVNX4iuIIOGFojOSgfPNFd9EZ19+pL2
         5j+w==
X-Forwarded-Encrypted: i=1; AJvYcCXaNe3/hWd/d0Q9BvR92d1ShAG5yjJCZiVH4bK3Lufb6b+nwxB9dWq2bwTuw06OTRB+lHAw1hNx5Y5KfDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5HfHUz+xEjrALrjyrK0H6Oz79w2rJZq5GACHYKzDtt2Dhyd1
	xywxLnXKG0bt62JwP7P9jPhHqESwxmmZc3nrVZtgEPj9pZvcQHJw5puyhW3hG3nCTyEH8EWSbNE
	Ip59s1UpLt6hHnQ==
X-Google-Smtp-Source: AGHT+IENP7Kx7M4Vi4Vt/eiie+FqP0nzfwl2y+4Din8XNMrO/5bTMKuLlkVaBOTPlzBeY9KeSKk3Ah2pbeqQc98=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:74cc:0:b0:e25:cced:3e3f with SMTP id
 3f1490d57ef6-e25cced3f41mr34732276.4.1727362774767; Thu, 26 Sep 2024 07:59:34
 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:58:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK529WYC/x2MSwqAIBQAryJvnaAmoV0lWvh51ltkoRCBdPek5
 cDMNKhYCCvMrEHBmyqduYMcGITd5Q05xc6ghNLCqol7zQ+qIXY3IFfWiRSNHo2X0JurYKLn/y3 r+36p9wRwXwAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Twk1wQnSBYqUrwPgppU6IblWdyNgBfrFOMFHTIuSYDk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm9Xa2YUpz8YLZJ0XuLQKBhsgdcDwfS7+0EQz25
 oN/K01chRaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvV2tgAKCRAEWL7uWMY5
 RjP+D/0VUGUvQuh2G44M+zDxJ4o/WUijMkAgM38lt7KdI0LAw/6fwSoJlZWXOGk563fruQ44SIj
 kmBZ0MeUs44ENruJXaRPtK/KJIfQT9Le+o+hJ0tCmD9MbBSXZO2xXohqfvIgn6E+4hd+VYaC9JF
 YzwRRODpoQxeSipt2eBQe8bUmfe8xSg/lJ6QSFlz/c6EwMZUhE/ZL6GVtWZ3UzWgy+nFTi/9++r
 dib2+PkHcS9CS/KTJn4LhSGRO04d4aen0EknjcZxm1RoKXiW0UZfwAx4Z7xXfiVg1vqrWqmhYuw
 6YKNvTq4ldIM4+S8u5X3FnjXP1IqReRbCJUcUYOlNQQnfCoGDGG/DDRB/m8u0YzeFIlZ+QobFAJ
 A5fQqmiQzW3EPgtkOAewZpR3iA1vdSdDNR9g48Lih3Lia0ClaPRHrl170EpiZQ0jIqVUvAVM0yz
 exJdZXv2Ik3y8nJH/q/A/9aJmZlSnW8lR/moyHnEZ6zbIYWFEpdHDyYuOJwly5+nmNVqRjpqpXF
 3a6LG2lcE1uR0VoV23V/bWVZcTQ7gpH22Lu4p0jLRSHI3CSBjUNu2Sfb/IcHR/r5BczHQUC8Vyr
 3f2EALu0SBk5mVbbdC86cCdJjT9EuTG7dWxFVHpGkg3QhLJzEEm2smFu9BSjO4mnQM+W//j9TM/ 1SBYl6jLGALOThA==
X-Mailer: b4 0.13.0
Message-ID: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
Subject: [PATCH 0/3] Miscdevices in Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

A misc device is generally the best place to start with your first Rust
driver, so having abstractions for miscdevice in Rust will be important
for our ability to teach Rust to kernel developers.

I intend to add a sample driver using these abstractions, and I also
intend to use it in Rust Binder to handle the case where binderfs is
turned off.

I know that the patchset is still a bit rough. It could use some work on
the file position aspect. But I'm sending this out now to get feedback
on the overall approach.

This patchset depends on files [1] and vma [2].

Link: https://lore.kernel.org/all/20240915-alice-file-v10-0-88484f7a3dcf@google.com/ [1]
Link: https://lore.kernel.org/all/20240806-vma-v5-1-04018f05de2b@google.com/ [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (3):
      rust: types: add Opaque::try_ffi_init
      rust: file: add f_pos and set_f_pos
      rust: miscdevice: add abstraction for defining miscdevices

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/fs/file.rs          |  20 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       | 401 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/types.rs            |  16 ++
 5 files changed, 439 insertions(+)
---
base-commit: a6266fcab443f4b6ae31016bd6c3872f8200d5e1
change-id: 20240926-b4-miscdevice-29a0fd8438b1

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


