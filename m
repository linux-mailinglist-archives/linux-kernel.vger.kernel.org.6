Return-Path: <linux-kernel+bounces-513614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E05A34C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B553A7736
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A923A9BF;
	Thu, 13 Feb 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzNhcwV9"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F723A9AD;
	Thu, 13 Feb 2025 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469225; cv=none; b=dNnZYizKAzfxZGtZy5efz/yGtmRO45a7nl7FB/dxy7K8qUrufYten/iZJETwNGn3NhCIz3cEWpT016fqWnFXER7RdOAebz3Xqb6LWJYRgJC9JXm8SVQV6riLGtdeFYRrQS8qaGRULnDQCTZBx+iNiYJk3KSnOSP/P7J2GJM8jsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469225; c=relaxed/simple;
	bh=TLrc2YZvYdJFq15z9JF4BK5oBdyJE7ePw8hoZu47Iuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTVMm7xY642Mluq7P3sr44NjfP+RaWUrDthHG7az24bXZOinvb/sWsVGb/8YOpiu1kSRO1jk/WEhHECNJrBfzmGoc3AIRzX4U9e4PTtFBuQcEE4RL7pIhT1BOMjdwz0/l/brbjcqy56vAYpd+vo9Ikgf/a+7Rr/fgPqIGIcpcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzNhcwV9; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f3a97b3e26so689371b6e.2;
        Thu, 13 Feb 2025 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739469223; x=1740074023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLrc2YZvYdJFq15z9JF4BK5oBdyJE7ePw8hoZu47Iuk=;
        b=dzNhcwV9PXTczS5OCnvwd7XKEEGzhFuyUVdBNxEwxT6zHxixVPm4+GmOSQ69I+uH9Z
         +azIkKOBF4v7QKuoLsHU3D1ZYh18c0KgTBhHkRof/qy79TFFsEqwVcdLvHlpFOKiCgyQ
         rvw3Y6b1YTkoSfJRj21dBUP2fGDA9i9vV/7wkGdjjO30ghD7R+yJlOKcrZ8XFcLJ/krl
         iPUc5UlsxrJEeSfS21bma3nzhkgzXp6jdEHXYMECCqLguyjHEn0+/qQvgQJmAYfEckAZ
         49uyZU98trh11/uBjxjT2ZJ0yv2hXPwMnTfgyWQd4ra9gzHkRlfdl3eYMDT8Z3FavFVR
         bUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469223; x=1740074023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLrc2YZvYdJFq15z9JF4BK5oBdyJE7ePw8hoZu47Iuk=;
        b=mSOw59qv5xznDxFEAvbEhr2Smd31UDxnA5WTgJd0pcw616s9y0XZaCpIyS1yDJmvQi
         Aj/sufiV3Vluq+vTOgomXDgF2A5UZkQwcbzzXf/sX4SiCdIPUFhVhw7gRRUrlJmFOLcR
         FKJa8PHrLj9rwymKmrc1egHq4JHKkFz5XuuKPQ5PYNdwnEIv8WMTF5QRQBhwa1jj7Gh9
         VeTtNNZbG9XoajRtLywgbnfDgID5JstBWVZ2j6cE9kKHYkJEJpfgqVeMT62Y15ShL8Yf
         28w7f+kg3RoKEx1iANy9AuDhMX7OqHeMMcGiqYNLAN/8gPpfa8DvIWpq7pyLEYV7W/Q5
         2Tgw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Lv4NX64+qBhW9COl6kjMHgay6AOPrh6DCEeEbmeMVPEq6+DD9x+bR4exa0cOVNJbjl7pltsdA5uMk3w=@vger.kernel.org, AJvYcCXv3KMvot4d8IcapeHdSrP6nrS4Ho2q+aeByBY+EJX3s6m8oEfK0gnBkj97QcCgLt/oj936Eg7GVn4cyq3b0+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpu0Sq1nqv+bf8j248wU8OGIkIrDRtV+M3pjgU/W6Xq8anWuLV
	NRWYw2Sk1HutX3Qty3TOQOJV/IOqpgHAmb821itwum2p7WdLLo/x
X-Gm-Gg: ASbGncuc8POulR+0d9Egp/MyOMeAo79nVCDp64RoarHcTd7CtRDaE3CIRnN4+wn7G9w
	z7hXl7f+DAAC6dYaiNMMdH1mCBwLm5bsCcP3UoFcSFISsMUbnYpxwFRd6YKnxPMSU8wnQ8O8rWA
	Wqy2ZWABhS7XNcUVJ2JIdDOvghxCba4C6f43lB8/9aOHY7u9fBiPX7B9igmvFiSpsZmOVcxi+TT
	TjsJ2YOVle4xMQ7hboma3HbN6wo95i90my6oQh065PFWUg3a+Y+AE0BZeP73sVtrXXf8psEAn9U
	1K31yR432MTS9Aj9c3WOBwo1
X-Google-Smtp-Source: AGHT+IF9flIbzrqTAqMgPf85cz8bXxNkg0DkuKPNR8VC6vMAkHQ/vvjaw5qT4GdlZ7dgoy0YQ+1nlA==
X-Received: by 2002:a05:6808:198e:b0:3f3:c0ab:db3b with SMTP id 5614622812f47-3f3cd6193f8mr5795784b6e.21.1739469222756;
        Thu, 13 Feb 2025 09:53:42 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3da966976sm696423b6e.27.2025.02.13.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:53:41 -0800 (PST)
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
Subject: Re: [PATCH 0/3] author field in module! macro should be a array
Date: Thu, 13 Feb 2025 14:53:26 -0300
Message-Id: <20250213175326.200647-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72kQLizgq+uBEFz10MYPFcpXEA6zttXMz35cG6W93Z-Szw@mail.gmail.com>
References: <CANiq72kQLizgq+uBEFz10MYPFcpXEA6zttXMz35cG6W93Z-Szw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrotes:
> I think this was a re-send -- in general, please change the title
> (e.g. increase the version number or at least add "[ PATCH RESEND" or
> similar) if you need to do a re-send, because otherwise it is hard to
> follow which is which (e.g. in Lore).
This would can be a v2, because I already sended a patch for authors. But how
this patch a lot of changes in comparison to the previous patch I was thinnk
that is better send this patch how a new patch, but maybe was be a error.

> Also, for some reason, Lore has your #2 and #3 patch in another thread
> -- please try to see if you can fix that when you send the next
> version. Both `git send-email` and `b4` should do the right thing by
> default when sending a series.
Yeah, I maked a mistake when I send via `git send-email`... inattention


Thanks,
Guilherme

