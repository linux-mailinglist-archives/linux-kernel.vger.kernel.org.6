Return-Path: <linux-kernel+bounces-269778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBE39436C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D131C2151A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429E14F125;
	Wed, 31 Jul 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFeHM6hQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B5DF53
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455831; cv=none; b=QGji6dWoF7qMESrlrzAGspdNsW6UydSGg7OJAXH3R4dyZV0B8s/M+Eqe9qUsJbDnSqWbkPcGe/0DdA1FaOTIdI1sHFLfuIFET0zVCOcc67PWcD9t/w7s7odw+QVrBu8WNuPomivRntDrSQKldyB/9YVb1w5/sVqgPWiwlxFZcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455831; c=relaxed/simple;
	bh=xqFUR2hlr0Rt/DfOJxtN0G0ZmV0JHjUDEpB0WWaRTpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAhcpXfgLuPAKylTyBTtmIK9Q0qiZPF/vKTEwyaCsL3XTAdzZP5cJXxh0nMbsIYFFKpcPfBqdY7PWQSBIYbDbY/v5rlbyNVpwQuU4eQjAVw+E0FzGHXRdBG+vYK4oGUP5h+fC6pQa9ZdCkdK/WznBRoGhbyD0Pqv73fp2nJnRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFeHM6hQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso22640a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722455829; x=1723060629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xqFUR2hlr0Rt/DfOJxtN0G0ZmV0JHjUDEpB0WWaRTpU=;
        b=vFeHM6hQczrfAeMQS3+qb0OBRPk1rRfixNSDpMzw5fCHI+3u5oOR+pJ4I1742g4lJi
         MkMu7fbW9og+nRbdBAhNIgzat/lADaQYUw/qkiXpM1N5gT33f6jJto+QCqyYj5i/qvZ4
         177z8GMTAQMj2uhP8ErcXDzxPgxnDaF0zAP9EcqoIQxs9NV3KUboQsv5YZzFiDQK1xuJ
         Wb7N/d9ArToxAZSCS1QN0kj+InpJHY4DNhFVN+ny7ruOPJfb/377zc9zVXQm+YGOOcIN
         6LRbQbl34zzSOg7kwKhB+1AToYmL+tKhc9IYmvW4PIIK4CFAYq7/HHucKPfG3pK4ZsfY
         tzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455829; x=1723060629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqFUR2hlr0Rt/DfOJxtN0G0ZmV0JHjUDEpB0WWaRTpU=;
        b=YPhuyG95YMLF9Xct6cYB2E2Hz1xVLCUaOnGajkOBU+R0we3SlNyOQPmpp78jzkGy9r
         ciXRyJ9QuEetlLO9yZLSUz/ziiQ1M/a9koitWSOnlBh6eGyQxQyKQfyaNQOHWL6Zf1m2
         GAySZTmqgqIcglpmmF1hsQp+uRGO7l8IJLlKXAAv8786nlVRR6mf6SY8SLKk505H722O
         dh4Ppo1eqQ11Fx9yt5FPBxMinxJnYBH08oi0Nm1ypiAiNzXLXIHVwad9EdoZYJjhx1N9
         2FUY41s2Rmsu0LsYkgOpF/+v81ANBHaDprIqbrP1l6tRUC9b/2Fb5cJrUhAeiDygOsuG
         GUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVposlekiw+5XBY7JnZmyCB9MbOj1LOFMSULW7NL+GAQ6+7WBrf+xqpKGORjlaNYvpBV3k5ZUG0WKzQF3/9JNkGf3c6KpQ40y2jPoFw
X-Gm-Message-State: AOJu0Yz5tOq8Dqj0BIme0yuP2Qs8ArteJlIp9nMTKegy9ij6d6UNUalJ
	OsECSRlor9hpQZ6bcOupWpL7Zp/8s/3FL05KfnKAiqlTG0Nk5itQNMbmXqF5pjHGF6yMYyo0VC7
	w6CDSk7pMlbrc4LBM+y6dQ9MtmWorDChEIQKq
X-Google-Smtp-Source: AGHT+IER+3B4Ti8SQlTJcNqSe6BmypSDKd6BurFI61graRZCCNQKJz0ONwaqFvJaP237gN8FbfwlFtAgMMKK02J9Hw4=
X-Received: by 2002:a05:6402:27cd:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5b5b4a6a671mr196924a12.3.1722455827367; Wed, 31 Jul 2024
 12:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731034112.6060-1-zehuixu@whu.edu.cn> <CANiq72n48BvaSNvghkEMn796u4K3_1owZqD9Gjmyk7h3R9GT+A@mail.gmail.com>
In-Reply-To: <CANiq72n48BvaSNvghkEMn796u4K3_1owZqD9Gjmyk7h3R9GT+A@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 31 Jul 2024 12:56:55 -0700
Message-ID: <CAGSQo01oq+nmPFCB3bRnjcXn9fvtu8tcvjsUh55tZnyJSz6ZDg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Zehui Xu <zehuixu@whu.edu.cn>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Does it change the ABI or could change `bindgen`'s output in a way we care?
>
This should not change the calling ABI in a way bindgen would care about;
Those flags only control how functions are defined, not how they're used.

