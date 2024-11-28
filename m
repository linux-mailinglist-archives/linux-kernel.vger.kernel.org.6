Return-Path: <linux-kernel+bounces-425034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9359DBCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB36B21700
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83931C1F14;
	Thu, 28 Nov 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W/+Qo14Q"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A57A13A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823758; cv=none; b=otCSTDhqoKSX2ywg1xo6aCvj1jn98uWwGDSQewwMkku1qjJv8Mmql34/jlPxmysveXOqLymjtw5SMN/VmhCceBNybq0hmE5nlP9DOXtVpGX04Ami8Vc2E5YIDqPT4pUwtot0S7G13rS5hmxl5b6/jLo0LLMzTJt8TnpLQzAWaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823758; c=relaxed/simple;
	bh=B9P2ENiavm6q3s6Tk0/34QRTigY5JKurnCEpeKNL1x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kg4CwJ1FwKysvhOCdHJmBuqVx7lklS/lAumqJRgac6LxwoBDySaUUf5FpTqcBQlgFrqv5Sp9Wejapcim70SqHKPRl/V0RiD49wujXts2f5Q33j5/Q0qyhCO+upa1uW7aKmJ3QCFAHPBw7XVWFUSeeG3aWrJJzFGKjwBIcvwUzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W/+Qo14Q; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso12543411fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732823754; x=1733428554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PYmYBYyArByRymcLIWmoSw8pIwozTi0i6w5/CUprJP4=;
        b=W/+Qo14QTWqk3gWGeTaCyn6TIyJHubqSG1lvxBt/4bCSeJwutP94HmiB4U9PVXIOk9
         D+A10nLuUo+yqdFAzNs6687ipcM86HzTOuVYfSr4rSH29wOcwr4K/190mKp/O5LPNAHF
         qrQYSWA+GfmT6I7iqdziowVuo3xOumtyXtZGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732823754; x=1733428554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYmYBYyArByRymcLIWmoSw8pIwozTi0i6w5/CUprJP4=;
        b=w+cO8CxgLtduRCfUgImuA8D4l7ka95wVXBDMAMqfjDEnNVZyW1Ngsz4vi2hbMZQBEv
         ov/H4617W4vt7bh2LeMNq93gqi8K7om36C0AG/qpyZ24II2ykull9TJ8lL2xkvGX8Qpt
         M7Dgh+3YPTk58qYHV+IsKn++5kt01WAEJKij9/vsICJi5YhyF8txqqKDEb5s7dOU8Mr9
         CLSa0Y5q0ChA6BxHwmhEkFAYxw7j4Sr+um7CrMPs1SYkWIg7f8nzJ0hm7K060bMLbiMC
         lTJGZgRAbtZFoAf6iXZIcs402wtuPsyS2VUYTfI0bbuqBbP6PURRIS+fPDfH3Y3GPXDF
         joXg==
X-Forwarded-Encrypted: i=1; AJvYcCXuU4UcEnZE6STENP6jWSiXRPMtyf7K0KL2cIgtNOS0IZ8FVKggnEl0hx0YSYijB5Qlbo7KYSqPn7+XiDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8iTzztwBCaEErgk8wXI1XkKF1ea8KSWoezuSN993ukDY8C8Y
	Gk0PjnVfVLafNoepXlg4HiqvcuWQla04n7pR5WDl/7p0daAct/WqYSfiISkIsUk04n8msZ/MhTl
	1WVMygw==
X-Gm-Gg: ASbGncsMppd3/jwh6cCHZGibSayTRQG451zGvz20N4+QraG1bhTd5f8Vu+CZpB0urgC
	IBAOFEXYJElqHaYPLVyBjfqYADdY7AhqOdYvFksSybRoKUl7lQ2+1XyR4kUi6Cv2EmSbbyBxa+7
	sAiTadyGZLs6nR7gWGw8DsxBlOMTgPfEcL4l8Qe7tKu3INVHC6JX7zJifWOhhELy56BoKvqc4RA
	DcNUeOkxh77y2UvUumdNzLxrKmKWSInnQ+Ih1FsJF4lyeK2AVVJPys0iI1n4E0O1Op51okgTET4
	L4tpxeuOnpSgMIfpIqWuEBLK
X-Google-Smtp-Source: AGHT+IHG3xUbMJcDGkpvjj2PGHLq/B4xfgTWqwwux2ckJHSb5N1akoySJZvGEWIBdHlWS1d7ELubZw==
X-Received: by 2002:a05:6512:b8f:b0:53d:d443:1ab0 with SMTP id 2adb3069b0e04-53df010902fmr5534155e87.43.1732823753862;
        Thu, 28 Nov 2024 11:55:53 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64974c0sm266378e87.222.2024.11.28.11.55.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 11:55:52 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso1150122e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:55:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7mG3I5bK95jxS0l4w1BrDYxKzY8he3flPp5EWgyLRrOtok20oG74fezyCkMy+o1n5l4Mce/A3d8j/QUA=@vger.kernel.org
X-Received: by 2002:a05:6512:3b25:b0:53d:d3f1:2f4a with SMTP id
 2adb3069b0e04-53df00c74d2mr5053239e87.1.1732823751174; Thu, 28 Nov 2024
 11:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127131941.3444fbd9@gandalf.local.home>
In-Reply-To: <20241127131941.3444fbd9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Nov 2024 11:55:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
Message-ID: <CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: More updates for 6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 10:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> [
>   NOTE: The rust tracepoint code added hooks to the same macros that were
>   modified in this pull request. The merge has non-trivial conflicts. I
>   fixed it up in my "for-next" branch in the same repository. That branch
>   was a merge of this branch into the commit where you pulled the rust
>   tracepoint code.

I checked my resolution against yours, and I don't think your
resolution is right.

You didn't check 'cond' on regular rust tracepoints, and you didn't do
any locking on either kind.

I've pushed out my resolution, and hopefully rust people can actually
test it. I might just be full of it.

That said, I also think that the "__rust_do_trace_##name" inline
helper should just be renamed to "__trace_##name", and then the
regular trace_##name() helper could use that inside the
static_branch_unlikely() check. Because that seems to be the only real
thing the "rust" version wants - avoiding the static branch
infrastructure in favor of whatever rust infrastructure.

But hey, I do basic sanity build testing of the rust code, I don't
actually _know_ it. Again, I might be missing something.

            Linus

