Return-Path: <linux-kernel+bounces-241141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5492777C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C901F23E94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9D71AE840;
	Thu,  4 Jul 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSDdFON0"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D681411F9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101065; cv=none; b=kKRVLrDcfNv3cwUyAkccVYmmI5vzI2f1q+yzuVMiHqzxI8CwZL0YtTZfLPs27kW1SzYu5X7yshAUBqGL5+uxGdjLpWOHp4Jv3Y0kZAB5V64UncjsJ9zjCBl2yYMbqMMGylOY41MhkWadTJK7i9LDiO0MU85j6zqh+ClK7dDOskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101065; c=relaxed/simple;
	bh=Mk2zjU0OD/BqtSdx1Y/wNXDDAcjEI73Cmr4nJ0Iw0TU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SlWPpD1zcRFpB/+EkWUz/ru7eKDgEQyk0FsFPZ9XmUDGOBCDjR0EnKMDZd1fib2yMJrH9VPe5Ipo44q1TbuPgcZAM455J/UAZyM96R4UX99hRJYLzsWtpGodRwk/3tETEKvzDTX6ZogkeCqGPMjMlmqZO27fT+SvVFRNSHHYiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSDdFON0; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a725eed1cecso63327566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720101062; x=1720705862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk2zjU0OD/BqtSdx1Y/wNXDDAcjEI73Cmr4nJ0Iw0TU=;
        b=DSDdFON0Hjt/NiO3u6wC7+FmZL0+1EhRt/bN9TGCv/AiYzDNDgQJeCmRJKI9QEmmRK
         4f3LhWPqTuglCp3HmVu9p+3qxkFddHmVypKeYsqTBT7+90jiyJofsZMu7bQnzuZUmBfj
         Mc8T+urOWRv25/DX4XXIJn72TRpuJryJIc2SqIUN+qo4SJy6xm5pDhgQPHenNn66iiuh
         D7uasbX60uSLuz/2TVbuTX126OOCymRZBMCV6F5mD+ZXwZu9ydqOoLaE3hcZtKPD/TUJ
         C96Aw/cDggEFR2PyN5fl84WFj5ZIHwwLFCMpJI+LN/3hoZdEesQGK/NiFlvWJhCubSBx
         CpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101062; x=1720705862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk2zjU0OD/BqtSdx1Y/wNXDDAcjEI73Cmr4nJ0Iw0TU=;
        b=lvXTkHqLPqnwnmyo3pKoF/ORVoVGste8L3oR7ss9RWbBrXCzuQQacIrpACPkiNCwz8
         7zlmtUseu//DUjokiWvbMOsm11qFmHV1+jxzqXWryoaU3WQMwjcpjPQmS8AE8ksN1mtf
         NZjUqOLscYLb90YMAHW08DHuqS3sxy+I+SIB1OTCjnngW1OLpNhfswTMzImVwTlIU+b0
         wATooZXh4bO640zWCf0wqITQv45m6bJIAfbAaRTfCgqWptPeKANL5+49Q7272jgCBBD2
         /2WY5NkR5E89h0MLwQZgC8MVGwFfSgC4Ca4TbzQR6lk7AGctTCreMaNziQ9fZNWz+rjd
         lEzg==
X-Forwarded-Encrypted: i=1; AJvYcCWS5jSpipkmT5WqtJZg2mNzFdZ5e6+fj7ufWSFCL5//HzCFRBLbcUuFn3rC1Ww8fLXGxZWxJp9uyvaAUs6wOfRgkYxLtMXrx5lGesU5
X-Gm-Message-State: AOJu0YyI707t9Dgp4rbQ0xI52e+fd3qGWbrXVovyOhVPMhFI/mSZwT7g
	WbXCQj5aBfOx00ei6iYXs9ORMB4n9TRG9YlvDnesVv3l3kwlWVwKJSMtJlwTLE5UyB86i5n332A
	gJw0Jlg==
X-Google-Smtp-Source: AGHT+IFrFc15nopfz9rvRJbJq682fsp+q2IZ5nbvfQreeYJuORUbZwDxqyh1wfijUhGGgU291E1rUbV7ygFF
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ef38:74e6:67b5:dcc0])
 (user=dvyukov job=sendgmr) by 2002:a17:906:99c8:b0:a72:8fe5:9c60 with SMTP id
 a640c23a62f3a-a77ba727e6emr125366b.14.1720101061941; Thu, 04 Jul 2024
 06:51:01 -0700 (PDT)
Date: Thu,  4 Jul 2024 15:50:57 +0200
In-Reply-To: <2023082746-antelope-drop-down-5562@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2023082746-antelope-drop-down-5562@gregkh>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704135057.1174408-1-dvyukov@google.com>
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
From: Dmitry Vyukov <dvyukov@google.com>
To: gregkh@linuxfoundation.org
Cc: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com, 
	Linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	luisbg@kernel.org, salah.triki@gmail.com, 
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi,

What's the kernel policy for such cases?
Should this be merged via some fallback fs/mm tree,
or taken directly by Linus?
The filesystem is still enabled in all major distros.
Or should we delete the filesystem from the kernel?


