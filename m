Return-Path: <linux-kernel+bounces-527789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE16A40F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73B416AB9E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445A20AF82;
	Sun, 23 Feb 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP1pT+OB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FD1FDA7A;
	Sun, 23 Feb 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325165; cv=none; b=KI1gkdgw+gbqr6vnRjn4ianzU/NnPcByjsg2DRN61raEVkp8Wx5vSnWEPmtlkq5atUZs18prLtLfzdpXxUKupFo1SSBYbMr8Wa4QKDlujAC0eiW/xNe2QcxHWCP9l7EFy0KrzNfBYqIFvpn02a6r8XbMaBNHPtlh5I+Vb5G6U+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325165; c=relaxed/simple;
	bh=3qU4GtJTsGQwbFsusLCPsAZ3tv5n7AUPfNKXFNRGBgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9p5BMzQsXsdGeogW7TsL+yVZPaVbTVsSKG/P0koxVO3Hij0Hv9mFw7QCMPcjZSF/2Yam1rS3ggITjcPTmJrFhpqZC/q4VJ5Xybc6+Y1uPtZR//WTk3pBFbQW4eCwG88k0Lwiajfc2v+KT0efUgRyOLLgXvtSsGb5lQskAjzsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP1pT+OB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221050f3f00so79806095ad.2;
        Sun, 23 Feb 2025 07:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740325163; x=1740929963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c5MN4s2WfRcbWBk7ANZ07wregEvdSHL/lHz2WKEa6g=;
        b=NP1pT+OBFuiSjFyx4sW8W561RknQysE+SX4pQnlqoAhHdmNB9OGLu+rdjvAadCfhF5
         jTN4DMFcW0ZIEpTL13G4WQ5Y+kSN2+WOccFOMvs4I25VoEzPOKE/+xoDFKpOuiFw94Q9
         ANzVSdaA6gs4ls+y6LC4TISrZzajNbntBWLv34TOX8TnQNFEDO/wROAXOP1NJMfSe9AQ
         R7DwljMTb57tFFhY+EQWWCxBkasmznNozLOUiY9h757SuL43bvm5GIoZedbeF5MUVGOw
         RwjC2nns+tRxyqKW8CaiyzrUj4tonVVg9GFoQaGEb3yh5skeEA9QkPaS+kWfdSeANzwt
         dKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740325163; x=1740929963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c5MN4s2WfRcbWBk7ANZ07wregEvdSHL/lHz2WKEa6g=;
        b=SWAFVszOv+jsmokqZX6I8Uo6oj2HyJzpKuYos6j8h0RyHOHV6S+hZu21ai1sMVASfs
         d0P/+oe8EB0ITMO5DoegzMPdSA2zVW1InITcxIWb1iGtyeHu4cI+YuLv1G6elFTZfq0V
         uPH4poTfKWOZzGyiMcC+FXspadvyA3ihl567FxN4o6mdc4jiPRS22KkO5PCht+c3U1yX
         wtJdhDzfxlJEf+PZsQLesgeoai/GUj9tyOv3iI/SGTu9gDhVe9nNYayP7becasbdwJLv
         L/FiuEEup1wkeZyAH86m1zIzq1R2hW1r598iLG7ywa/7pEJpW4nyx9MsbiNkuPS0pgNV
         CSPg==
X-Forwarded-Encrypted: i=1; AJvYcCUi7oxlf2tNfUNCkvj7fiHEkiWQFns0PfKg56/C/A2Y9i6c2747UmYogNhii3R2Nv8e0hBW/j1+7ZI47Kk=@vger.kernel.org, AJvYcCV7m7uPP1ebyJ1YnIYixntaGrNhqlIh8uDCHkN1LKkv9gcX+75alupesZgIdBv8ub7KxLCmlsQ0rrXrjP+xKX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmgyUbakSdjfViL4m6UOaRTQhD4pF0+2UhjOYMQhM5tBdBJq7
	N4kLcP6Wu+FMXdkPliWX7nF8/zoCFBJihEzFWfS5ypJpVZdqWKWC
X-Gm-Gg: ASbGncseBgRQio/cQWEz9EyUY7F+uHr2oQc+z9u5A5pICTGhPbdZrA/rOnM1BApbDor
	4OkECK11JopWXgDglqnYu+xQy0J7uVInLRkhNuUO0Xm9AABzBWN4WMez8f55YaUGVHdohXYqZI3
	n0dSGVSG9yXCVvMd99/9cqkLzZG8shqlW5r6px7x1ju3WER2gQeZ+Xt8GWfywJzbhxbOuGDxbYR
	jBgWt0R6lWG5UAkZt7lOZ80s1pRV3q4dc8fbVhBVrCuVnyT8QhC3hNHKJzF0M2M7uXBGYvfaQn3
	WGrQP+fMQxzA1XR2EnC8Hftkwex2jCNwng==
X-Google-Smtp-Source: AGHT+IGRwX1ZKSDq2cEEEEKtOYGsDnq5Gxg85Qb+/LLJNGyy9n9RrWySUHGtnQjbIbggkTPbM6ICHw==
X-Received: by 2002:a17:902:cec1:b0:21f:55e:ed71 with SMTP id d9443c01a7336-2219ff31895mr191972235ad.5.1740325163182;
        Sun, 23 Feb 2025 07:39:23 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2217a2fefbcsm69818235ad.116.2025.02.23.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 07:39:22 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: joe@perches.com
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
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V4 2/2] checkpatch: throw error for malformed arrays
Date: Sun, 23 Feb 2025 12:39:13 -0300
Message-Id: <20250223153913.10846-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ccc3d3e756e82af53b4f75c4ab9cc99e555da1a.camel@perches.com>
References: <3ccc3d3e756e82af53b4f75c4ab9cc99e555da1a.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joe Perches <joe@perches.com> wrote:
> Poor email subject.
Okay, I will improve this

> Convert all the messages.  Use consistent style.
Yes, my bad. This was is disatention.

Sending a v5...

Thanks,
Guilherme

