Return-Path: <linux-kernel+bounces-549290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A6A55063
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344A01743C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2051212D82;
	Thu,  6 Mar 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUYyvWyO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F8183CB0;
	Thu,  6 Mar 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277917; cv=none; b=dUeiqz6+Um3A5b8YcweTLRhkcEwIJOn1eT+HZ9t29hNr3bEAk4GOwJLOp1Phhd83uQ3RrkVTXfFA5WbEs7/YR18m4v1RRJHbHyh7NyfQHPnD0w/ybNR2YcbwEDBCffd9iquEkGdh3zO4Qp91ooo4tt3Sk0+zfKLvVfCnBVlRBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277917; c=relaxed/simple;
	bh=Y6t1qNw3Kvb+Q5NmdPGHx2xhuIdWInYyhfAWQd9UIJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LuM0y6JmS1n8329K+SfZmidU0sCI/qhSaWXZ4RsKIlrlEkynFbFa5tajx0YaEXsv19HVz387UtPX72Juu9V7UvFmat4m8KCDUM358uaGd1iIaeKop9ACB1LwyjWck/z2b+1FPiB3fLfn7MWvs/UxOgBkexPL96qNOwft7N4iNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUYyvWyO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22349bb8605so16909835ad.0;
        Thu, 06 Mar 2025 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741277915; x=1741882715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GVRN00CXHgqx9rFb6IpoKCYiwShZJigsgi/z9IGnRY=;
        b=CUYyvWyOohC32iekI6CgJmUK0g4WjtDXzOC/nvihSFllcqt/AE9YukIS0ZVK+78n3U
         oTvb1fWMrGqN9if1xG0TeGaQ+7zzOH3vEK1erQsUHhX9ip0wBLQQtCwoEGJfqsLdVBXz
         JA0RrhZOBhm0acAYB1c20QfmotbPUrEP64zSlOwrIjPmpav7cm0GAURpoNWdhJh8jriD
         PnE5xn3oJm+LShH+DPfyh+cbxZ2Awmfpfy2MtXjP9F1A0vjH3yCsptvQHpcSMMY/hUPy
         /TgZR5nvvmp9ksGrCF2qUIOfhpOPvJYANp0LsH4yTCakZ7kG3sjtKadl3bygw9xHD7Pd
         hTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277915; x=1741882715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GVRN00CXHgqx9rFb6IpoKCYiwShZJigsgi/z9IGnRY=;
        b=lAwq9qoVkWNFkGhl0nuZijoCRwEOpWp6j2cYFEz2jcSL0GbqCIWCAIPuRAXC+EdRPX
         VFm+KQZ9mMtV3U+uH79pWAqiBEMW7BMdCUVPt24n5X1GU4sFuORTMsCtS8mFV1TjgOdx
         LIXqDqYtrmXDHGqyVQTqDlCgHzCc7h4ZXf5IfBTwzL+BhRf2gc/GcSuenpVc9WjGxUlV
         Ry1HxY+H4nwE03BcfqBpN9H/luohx/M4jD5T0sMX6V/oMLg1hc18nd0Dm8EzatQoGXP4
         bPABD0QvW7XQf7aKXIENOvlVj1GEKLbZ6zd+nwqZXRuW46dzJIFp2UEzSr4l5nI+xqMf
         hbHw==
X-Forwarded-Encrypted: i=1; AJvYcCV4mySRSsZSn+uj34QYyb9ZSrIDjsbX/R0uPfX3sJS2slPdMG3XiGZcKU/sjlNQmwSXJxX3UgddXeBhlOo=@vger.kernel.org, AJvYcCWvzowaBEU3ctlhLmHFqVvaWT86+mZaLcmSeEwWw6kII0jyvrKDAiPCYp0eMKB+U7a3ixTynIeX4TrIaHq9n5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Fv6855KWEMHsm+hvBfYaj4hE8eCUeWAQUw+t31lsonx1g+br
	iXGORanL//BcRzghOywY5sJ72Xu9CRaTJj+xz3dSGEXBdpiaZrcT
X-Gm-Gg: ASbGncu9x1uqMZffb3l/jAd97WLY1MMd1R3DpYSS6arYuKfDXB8jmZuwHARmC1lG6wR
	KdhAPdyt9FoH0ddCw2xf5ongZFYKOInC9TDK6wB8xyt1Dwvr4bBmpCIUFP/yYnt3VAn20PSaWB2
	WeB3IANbG55P6Cq8BmJjo6m2X9X6mnTtYJN+jSv2RvZmxkf9qsJmnAlAVv4gA6Bj83KFuPIv5TH
	98rR2Xq9AxukJEtJgrohejFSy4c/OcvqHSR07Q3rreyBPU8zuZ7sccDTUk22F3+6V5ra83QBzw8
	OvJ9M6OtRN7ZnVoT6POgbM5D0ys2PqfLt6qK++u32XL6s+6i0+Mf
X-Google-Smtp-Source: AGHT+IFyTdKrzScTqL4R6ZpR47GOeEpWked0yL7ByVbMCiLUi/3RphyYFtaItWT/4JzB8oQsR2300g==
X-Received: by 2002:a05:6a20:7486:b0:1ee:e701:1fab with SMTP id adf61e73a8af0-1f544c88126mr136313637.36.1741277914926;
        Thu, 06 Mar 2025 08:18:34 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281075ecfsm1435168a12.5.2025.03.06.08.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:18:34 -0800 (PST)
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
Date: Thu,  6 Mar 2025 13:18:23 -0300
Message-Id: <20250306161823.282516-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
References: <CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> Perhaps we want an entirely separate thing in `tools/` eventually, or
> even out of the kernel tree, so that it can be easily run as a bot
> etc. like in the past.
A out of kernel tree tool, is a good idea for me. But a separated tool in
`tools/`, don't seems a good ideia for me, because, we have things a lot for do
in addition on developing our code.
like: 
	- make LLVM=1 rusttest
	- ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch x86_64 --kconfig_add CONFIG_RUST=y
	- ./scripts/checkpatch.pl
	... and anothers things more.... 

I don't think that this things is uneccessary, but, if we might reduce the work
of developer, and set he for focus on your code, seem better for me.

This is only my opinion that can be absolutely wrong... 

Thanks,
Guilherme

