Return-Path: <linux-kernel+bounces-366190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A40599F1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0078F1F21B42
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569A1E6339;
	Tue, 15 Oct 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYtPI9Eg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4971CBA18;
	Tue, 15 Oct 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007521; cv=none; b=PcnYI20v2QlcywcZi96XdNtwnZ6hAq7os3hnPq3+qj/T0aVBtnlp30m6S51/PeG4LAB8U0/AWPfDFEU2QZvnVhf2JGVZO1pV2akgdddFb8akRXktqq6tQhDfjBHgez1rHdWddsiO4ZXRrRkGWhZr3qNHFVicpGAFjfmvLff8ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007521; c=relaxed/simple;
	bh=nS7IU49Ufuj1+KhRrg1Rn1SWIkOpLB9C5aDsxWhgVEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDJA6Bt5BJWRs++brrVImQDAvCzqxU5XewRGHeSuIEmYo/pVT49lo8ceqeYCyxbr+VLqdel2apov8VX9vy9uoM4hYwfXvq4M57w8iob1tTDrdgIxYp6S1vsYODwA2kHPxTJC65912vDWjVOfXeEQjscBW4Zmv78fHlG0h24sDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYtPI9Eg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so2188482b3a.0;
        Tue, 15 Oct 2024 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729007519; x=1729612319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjM9kwiZh5mmOHhBqP/Zm8P/ZASjmloafCH5HmKG1OU=;
        b=PYtPI9EgFIkgUumQpeveeu4Cm6b+Z36cnjbEdgYOw1Jla+jMC0YjTKmjw8+KwlHhEP
         TQ/FgjF4JnLS0O3NazsfSer4/ql78zm7y+A5BfHpyPGyscFvpvAKczPmC0sxpN1O0kEK
         KxlySuLq7yFTN2lekhV6163k3OQBMC631dhLWUB2trwlzXTsVx301B/EbSd1WdiMhHUT
         4kwoel+eMkzBkFn7NeASWB2AszpBgkqWGPBrjpzOTN5a6NqVuGXtGd8TBlQdlb12ydl1
         XGYqYnCEhf8EHmqXJzoopjojhZhjsPCitX+mjAPFvzCi9LvTlWlZmhthvaUt7i1zcJND
         /wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007519; x=1729612319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjM9kwiZh5mmOHhBqP/Zm8P/ZASjmloafCH5HmKG1OU=;
        b=Wn9ck2yIZfpa/etxFc8qvedjxY7sx6xNN/mupQvx5QveeoLc+JPtNs6FS893rraIta
         Oue8RWrb/vPiElETd+rJrtbsaDTaVXzFiFAAW8X2i3bkhtS0NH8TmbU6qZWn86m2xdt0
         jYKxS+6hFgYZfOYyhrvg1K6D+oWS1RYIzCUWXFA/kSE2oeWqgTp6Qelvn1ENhIRBHWl2
         wnjruJhxWg2ihz1LpTRSrdOlrqCDI/tidMEef9H+5/47mXGMcTJZWV6//AhJ11a/Yl25
         Iwku6tFEvCP/LIkJLKWQjedfRFVBWswP6KU49lcVbAHYQ6xCT5KFlgk1F+tnRGsR8P1U
         5bQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW53CJj7GwXamI4REhKEHQUYjfyuHHBmdT96zL26PHUbxU1I6rX8CLZCMtAF6TG+JpMnhcyiWFm+EDVdy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZytRZrzFyT6K8XmeroAxFvx+jwKCsZd1kwAeDk9DiHruloOoK
	Jzf6RscPCjVmR/Vb9AgZ9I0mWNCi4US/YO//Jk7fmD9Es2BYftcj7AA8GGnZgY0=
X-Google-Smtp-Source: AGHT+IGemyAIvmMW5ZL39CUqgVl2Ig0uZ2rxoUDJxcdhzf6LJh9gOcXc62OiKX12ZIW0wzWmffLfHg==
X-Received: by 2002:a05:6a00:22c4:b0:71e:4422:a1b with SMTP id d2e1a72fcca58-71e44220dd6mr20037218b3a.14.1729007518820;
        Tue, 15 Oct 2024 08:51:58 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2561sm1461753b3a.97.2024.10.15.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:51:57 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Hridesh MG <hridesh699@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Patrick Miller <paddymills@proton.me>,
	Alex Mantel <alexmantel93@mailbox.org>,
	Matt Gilbride <mattgilbride@google.com>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v6 0/4]  Clean up rustdocs and add new checkpatch checks
Date: Tue, 15 Oct 2024 21:21:35 +0530
Message-ID: <cover.1728818976.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the rustdocs as suggested by two issues[1][2]. The first issue
is to convert all rustdoc headers to plural in order to maintain
consistency and avoid situations where further additions to the doc
could render the grammar incorrect. The second issue aims to remove
consecutive empty rustdoc lines.

Also add two new checks (patches 2 and 4) to checkpatch to detect any
future occurrences of the above two issues and optionally fix them using
--fix.

This patchset is a merger of two different patchsets [3] and [4] with a
few improvements made on top of them which are listed on their
individual changelogs.

[1]: https://github.com/Rust-for-Linux/linux/issues/1110
[2]: https://github.com/Rust-for-Linux/linux/issues/1109

[3]: https://lore.kernel.org/rust-for-linux/20241002022749.390836-1-paddymills@proton.me/
[4]: https://lore.kernel.org/rust-for-linux/dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com/

Hridesh MG (2):
  rust: kernel: clean up empty `///` lines
  checkpatch: warn on empty rust doc comments

Patrick Miller (2):
  rust: make section names plural
  checkpatch: warn on known non-plural rust doc headers

 rust/kernel/block/mq/request.rs |  1 -
 rust/kernel/init.rs             |  2 +-
 rust/kernel/list/arc.rs         |  2 +-
 rust/kernel/rbtree.rs           |  1 -
 rust/kernel/sync/arc.rs         |  2 +-
 rust/macros/lib.rs              |  2 +-
 scripts/checkpatch.pl           | 22 ++++++++++++++++++++++
 7 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.46.1


