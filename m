Return-Path: <linux-kernel+bounces-447909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0A9F386D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB09816DB55
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7893C206F3D;
	Mon, 16 Dec 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OFDOnPoY"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F11E4B2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372068; cv=none; b=JgukdK2061D6Z7Yc0x11vZUjPHXXAO/rj5b8w1WKZLPODuRG3MWk8iYHl50g5946ydrHf5MtHXneu5bRMN0XetXw9IiOpW9+UDOr0wMxfvCKS9tCyPRdrIIxZDt2R1kpwEOVf+2gmflJ++h293l2jyRmaa907tFU1Rr4yxPik5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372068; c=relaxed/simple;
	bh=Mp9EWrYi2fcu88ncy02LCgZahxz30dOsdYoNAk1qCKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ynf3S+6ssnQzKq7h4ZoSDK1Uy0DcK7MMxWvXjIGpF22JCSzJl4fLc9yxgpZFUOTdsNqhTcYpP1D2q824QK1Ny/d6Yzzb/LQgr5O3QJdKqklVkS9MR16CEOkXRNygPsN6s/NZlQNb9qRcMuvQWysotjCJJGwr+PVWt/JCgwk+XLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OFDOnPoY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so7717513a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734372065; x=1734976865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMgm+KOp06CzvsJCwSPAGMvVT7HVNw5DzmJS95QuCJk=;
        b=OFDOnPoYksXylCn0uvBuIakc8UToyjCGzFqyON85qrfX/8cBiqZkK0byIGslOxPE6j
         NA2DFnwCxF3WGmOxsoZAx1wV67LZZEjwacGYAKm3NNRkW1RuyhbdH2kyIb8HB+cMaS4R
         4SiStrIne2NkpbaXSln4d+tr/eaohoNLqK0tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372065; x=1734976865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMgm+KOp06CzvsJCwSPAGMvVT7HVNw5DzmJS95QuCJk=;
        b=QJKpDc+0rLAQoiJ6RQC6dtoneJLAp/ADMI2Of9RLFVqWniKE9LamoO6acxkZtXnOCs
         +4R4mjB+iuhFcQyKauZihF6vhp8/V3t63FcUtiy0t6BT4L5+exr1laXwAzF5196mCUx2
         TJYs6l03HXQ/O/W4uJzw/XnrMdrsevZDKYcaSrkZAGXmDPCDEbkPVTE8w3OUUxg56MFR
         prtkG83nq/FZs3hhPkB52l9F8qybppJ4yIJXLRux/Hf2Qk4e0s4cK1dU+Ad2BMQ/ge7B
         ONdYGKscWF7V28YISrkUvzg7Sc6qfsfVI7O6B48KjiB6ahGcwP6eB0q7dp7BgzOQcvK7
         Wxtg==
X-Gm-Message-State: AOJu0YxRPyMeynysgkvh9HPneW5keYKD6rK1j9dPfmXFg0BU1cuSSE/K
	BYKAOC/RNVU5OuV1xhdqt7GGUeLI/becxQ42/NTZ5j9q40sz3AStBoXr59fj3TJTtjUAhOgYkh5
	6R6k=
X-Gm-Gg: ASbGncsTPzlWe0ZTtCVC7RSAEVc3JeT7/6inqC0ra6shC35tsAmkzB47zC6CsKoK5ZV
	XXJ82UKG3yYBhKy5cWJTR8ebWjnSNvf2I/2eWmqYnOj+0wFfphRpvOfPzAiu1zxB/5186Z/4Xcw
	wr+dz7ohx6H1OB3J19JjRTpWF7D0K4iwQlfg0bkQF2vggRfkL6BAb63457eJlC33G4qE7OH54vb
	tPqEVPxlQSXFX4GH3N5FeILjXT9V6ELa6k/U5VHcgaqIIi0SbijMxDeNquT3BYGCgNPR1iZWVup
	wYXDtOVi6T4ePG9Iw96vgjILC5AY+Qk=
X-Google-Smtp-Source: AGHT+IHwZxulv+Gt1EQP+gnmTwbsQAUHjzd0u12L7EF3jkzguKQkFSiLXdYukQdTyKU4K2QGZUAXNQ==
X-Received: by 2002:a05:6402:13ce:b0:5d0:9081:792f with SMTP id 4fb4d7f45d1cf-5d7d408e574mr469715a12.16.1734372065088;
        Mon, 16 Dec 2024 10:01:05 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab523esm3580162a12.11.2024.12.16.10.01.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 10:01:04 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6997f33e4so684383066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:01:04 -0800 (PST)
X-Received: by 2002:a17:906:3d2a:b0:aa6:82e3:2103 with SMTP id
 a640c23a62f3a-aabdb3c0e62mr48858166b.32.1734372063960; Mon, 16 Dec 2024
 10:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <20241214221212.38cc22c3@gandalf.local.home>
 <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
 <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
 <20241214233855.46ad80e0@gandalf.local.home> <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
 <20241215050517.050e9d83@gandalf.local.home> <CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
 <20241215202404.06f7be8f@batman.local.home> <20241216083324.5b2677f4@gandalf.local.home>
In-Reply-To: <20241216083324.5b2677f4@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Dec 2024 10:00:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_tTykEE7s-_EAq8WLPF+qh-yWuSV6AOxrR8ms8GL8RQ@mail.gmail.com>
Message-ID: <CAHk-=wi_tTykEE7s-_EAq8WLPF+qh-yWuSV6AOxrR8ms8GL8RQ@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 05:32, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> One issue with just doing it manually, is that it would need to be
> maintained, as one or two "%p" are added per release cycle.

See my other thing. I think people add those things entirely
mindlessly without any thinking.

If you add garbage, you get garbage. I do *not* think "people add one
or two of this every release' is an argument for it being valid at
all.

               Linus

