Return-Path: <linux-kernel+bounces-401668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D239C1DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD1B1F21479
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41FC1EABB7;
	Fri,  8 Nov 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D81ghuGK"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CE1E0B66;
	Fri,  8 Nov 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071699; cv=none; b=gYrcZLxRgaduU4ZjI43OTk841ZliCwuQSAPO8NjTU7CIfJv29OvyJmHl8w7uBnlqkniA/xKHLqI0yZ/MmPGHREkNq7C65l/q6MQF1QTp6qsC2kNZbs1pbkWyhn/iDfWpqPyuHnvJ39RRxDyj6CZhGBmsXtE+jWjuzI3QRLcuhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071699; c=relaxed/simple;
	bh=VKApLKh/OaSQZYBytMS+E9U1FHsGxs8ulMjSr6yqCIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTsPHJ4Usjb53kx4kjfTi7nfuFzW6Uwt2rxTTLiYw6qOEcNbZho+YWf4COKxW91eiPY/EqhOHip/awfdvOm6eePdPCdAPBPJ97Mo6nHzxX0+xLMpjnuy1lWZpm0a/UW/dvHTsRH09VsPLPpt2JJ2WROEMIF+iQiinWgDzLYQw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D81ghuGK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b533c6865so2441795ad.2;
        Fri, 08 Nov 2024 05:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731071697; x=1731676497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAWN2eLvDuVONO+s/YMY0zUkUAcW6PaRYznFYn+lT8Q=;
        b=D81ghuGK5W+22QlG3AjdDWr3sOq0xuI4Xdry0NKeCEWwkMcW5sos095pFcrovTwH8s
         vw10sL0fhCs1eqfYFFyb83/gIPgQYy9CYj/Ib+gyO/1JIUs+zCFaTvJkrNMzRCp6hmvw
         6Dl3gJROE+wGg/h7WCS4ns49L4MEuUYnK6nYCMdYbU/ibiuHzDbDRh8/skkRBUb8EyVf
         fmY6IleaAJ5IDEUXIkGq/tjn4zBrvXdPRBffnO/HJ//GRCIW+SQ6YfAXR8cn7FfjUZ6V
         3qMvh3mPIa2EQOBfu4nCcM5Gk9ZkKF7Bqo+AhqHxqhfIQZpKk8OIwRwYun84U32SlI1O
         XvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731071697; x=1731676497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAWN2eLvDuVONO+s/YMY0zUkUAcW6PaRYznFYn+lT8Q=;
        b=M5vZehTokS9WE1frNQJQo79GJfqKvSnMciqjxX7BTmqD93Z4RASqC2Npe1gXEgRJW/
         NzAknR2dPsupXU/1EX8t7mytef3nzfsWwI9IQg49y9gKHU/HnUSuVCENzTGR1ddsDw0/
         I0dTeImLVDW7Gx0zFuw8ugKCqBgSmzXM3++xvblO2AIwqyg0Ii0wUltsZR2HEXnQSGBw
         2ZL0LeVs00AOH+SH2SgjnFMuHTlh5aRijwYgKKNOHhfk65PUIkLecOeCB19EgXgwlXyL
         NWa0rfS3oXN5RrjSMvz+Qco4TuCaFNVlLVSTwq5OmjiandQ8NGVGhFDRl88F1c+hqL50
         hs5w==
X-Forwarded-Encrypted: i=1; AJvYcCVAN14cnXIKAMkJyin4ydi+rXcUt8z8vGPqMrbKPSFL5npx0wZP6Aeqaw4Cld8YTH+zjiNJM1mQ0tDhn+k/6Vs=@vger.kernel.org, AJvYcCWLB1K7ieeSqTMzpnwN9eGmMtMCVDjVyYpsszcNUZts30cnb5WKoGqpcaMWcp9ucl2a3zbKdSgw57UVlAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybuIwwIAuXHNYY6kd3FISKPw4l8E3Bm0CgdOv/qETUrI9nrEQ7
	YI5xUp3opqYlv0gWnvCQ4CnGNkdFvYktc1x+UjC/D4cv6zMkjaZRJypyDHqNCl9Dgm+9Aq5deRC
	bdb5lzd1S6df+zpuzOaE+XnJbl1M=
X-Google-Smtp-Source: AGHT+IFJxUkjLtbQGde9f9KFHbMGAR+3lLFTiEtIWayWy9HhjL0qA/VQ62o9GNJFdwwWFYrLmwbbRlBGbSJoX7/B4F4=
X-Received: by 2002:a17:90b:3ec4:b0:2e2:c423:8e16 with SMTP id
 98e67ed59e1d1-2e9b14c7c8amr1747280a91.1.1731071697409; Fri, 08 Nov 2024
 05:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-2-de650678648d@gmail.com> <CAH5fLghWusxAnU7avBueJmsdbvpoabb3=ckA7JvaZX6iha960A@mail.gmail.com>
In-Reply-To: <CAH5fLghWusxAnU7avBueJmsdbvpoabb3=ckA7JvaZX6iha960A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Nov 2024 14:14:44 +0100
Message-ID: <CANiq72=RpF8xLVqBzmKbec+fDcDFss_aiSB1nGzjvj=ApExcUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rust: types: avoid `as` casts
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:35=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The compiler auto-converts from *mut to *const, so only cast_mut() is
> necessary. I think this will still compile if you get rid of all of
> the cast_const() calls.

Yeah, if there was a mode/lint that forced us to avoid the coercion,
then I guess this could eventually make sense as a more explicit (and
symmetric) style around raw pointers  -- I opened:

    https://github.com/rust-lang/rust-clippy/issues/13667

to see what others think.

Cheers,
Miguel

