Return-Path: <linux-kernel+bounces-225523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8CA9131C1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521E7B22A16
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D98C1D;
	Sat, 22 Jun 2024 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0r23zWoj"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD779C0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719026494; cv=none; b=PtMWV/5tqhqYzZm0u3ml3PadgWvNK5DbpoC+kDeuYY9yxqnB7VmPS1+Pr20ekJ7/xjfR5X+eDNwzDagTv3SN7+rZ5XLNVPqZnZs/zF7jPaVSuNQjoNEPq/uTF08gk7teaOZveWNc+zgQDH/eMb2FqxNss+pKmp0wgrklq74tTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719026494; c=relaxed/simple;
	bh=Gpax3jT70tR7C/KsHMa7f8V5eajMmNfCtrTW6XYsBfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f/TMi9qreQ07Qk6oss+8ESw3QvQ+s/IOPO3CsJsIHscHZn9d67XDy9NYVjtlfPU/uvtKOB8fo8SOySL4eVq2ZRA3rJK5IoN2jfEnjsrsmu1NNoLZur8IR8PUiP9xZSxNhYcXviaO75FFCoKeOdw6mFGm6q7g5shCAPEHw8ajdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0r23zWoj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70663dee272so476160b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719026492; x=1719631292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1hZVwTyk3RKy3plKr/tqmfa2Bop0Xh/vK1vqULE1RA=;
        b=0r23zWojI4vfTc8OiEssTaq+EfFPBr9Z54SrR5dCpoYZka/N/xiVW7nulj8GaR46fR
         HXf3RAq6WRDXwA6tK9kXuJFXW12hWl49vW4Gq8nw89UDZA5Mqv9jR7FWnEvH+l6Vhu3y
         b7snQTVinjIZZUVumsuGlTF1SG5pzkoXCQz4q08zhdheYC+uv1U7YHykg+KoDYQcENsi
         l8hUxygZ+e9CdxGNstepigD2Ua0exMfFBUVyouKCWP57RqBC5OsVue66OLYx7zxgDdmb
         fXqfS8M+keaCbwD6h+ShSWyJKA0HSlBocPzWFxOKyoq2wnZZ4nQfdF9+vU8PTL7WRJdz
         CXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719026492; x=1719631292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1hZVwTyk3RKy3plKr/tqmfa2Bop0Xh/vK1vqULE1RA=;
        b=lZdYQzw3myiVG9lycHLI6oNi14oPaRoyAZLjldYU2lFIlR+/NRJNSppSKCB23CZpm+
         CAKgcn3eU+41yy/SESoAzTsq8hEetx6tpYHCyk7O3F74cL5btveZ2lV8SK8dfvFZyeG/
         cswf1jryz4WGMUyfWbdpB1jLkoRZYcYD3Kqs1vmdTpn1C5/8AX88xXVzrPqkR/hXMupr
         PvHrP1VOiXMWm4rD4TSfWzK5T0MhdtyPWmj8WjeZPJwF51BykAal1Aj9j1xDFXChpeh5
         4PacjktgZWuw4OZjpHc3FCzXjBbetOZPA9GMYXyhREU0afuJCkUxrE6Oqmrkaszhv0Lu
         9epA==
X-Forwarded-Encrypted: i=1; AJvYcCX0fS9QaId1VIEfdUR7q7W9TMvPe1pox9ijcniSeuD8LTAPqi+onrYqKzinW2a/n1T16PPJvVx4is4wpfVDZLC/5AsAe3Oo0A60QaHf
X-Gm-Message-State: AOJu0YwlSIstVXSqxf+Kxkr/7TeWkQQ5KgB9Y/6RuBD1Lb7PdauI6zu/
	QfdYzG/CSPThEqSbkw4nBM/JRZrRR8x3YwrPoAxl0jiM6UbNLFXHQeFUSSuV9Xem2Wp6xlHhv8Z
	sAVtq9Er439hP2PPWqxPUXw==
X-Google-Smtp-Source: AGHT+IFc532B87Htj7wUkk3FJ2X81U4kzmnKjAL0U1Lc0/IbQdUIwtbAk87DxmoksMCChtAph2/+gc86zl/tHC0ZLQ==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a00:13a7:b0:706:6b52:4387 with
 SMTP id d2e1a72fcca58-7066b52470emr424b3a.0.1719026491865; Fri, 21 Jun 2024
 20:21:31 -0700 (PDT)
Date: Fri, 21 Jun 2024 20:16:01 -0700
In-Reply-To: <20240618221347.106627-1-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240618221347.106627-1-yutingtseng@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240622031600.3762859-3-yutingtseng@google.com>
Subject: [PATCH v2] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"


Yu-Ting Tseng (1):
  binder: frozen notification

 drivers/android/binder.c            | 294 +++++++++++++++++++++++++++-
 drivers/android/binder_internal.h   |  19 +-
 include/uapi/linux/android/binder.h |  35 ++++
 3 files changed, 344 insertions(+), 4 deletions(-)

> nit: typo in "state"
Fixed

> It might be cleaner to factor out this copy_form_user() part
Done

> avoid WARNs
Done

> Shouldn't this return -ENOMEM or something
Done

> This "BC_REQUEST_FREEZE_NOTIFICATION" can be in the string directly.
Done

> > +     struct binder_ref_freeze *freeze = NULL;
> This doesn't need to be initialized.
Done

> This "BC_CLEAR_FREEZE_NOTIFICATION" can be in the string directly.
Done

> "freeze" has not been assigned here, right?
Fixed

> The preferred style for comments...
Fixed

> reversed christmas tree for variables
Done

> Why is entry on a new line
Done

> shorten the name of these functions
Done

> Do we need two different work types
Merged the two

> This should come after the variable declarations
Done

> write a short explanation of what this means to userspace instead
Done

> Use scripts/get_maintainer.pl
Done

> the corrisponding changes to userspace
Please see https://android-review.googlesource.com/c/platform/frameworks/native/+/3070045

> Multiple put_user() calls seems slow
Changed to copy_to_user


base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
-- 
2.45.2.741.gdbec12cfda-goog


