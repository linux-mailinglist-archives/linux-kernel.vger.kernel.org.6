Return-Path: <linux-kernel+bounces-206652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3253900C59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873E91F235ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41739145B1A;
	Fri,  7 Jun 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UckJRMl4"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A21CFB6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787727; cv=none; b=dWuSvL4Jadlv8/eOBbwlwrUKA7cJWn9OXvt+dy8/aQ6m8xguR/EmzogvzwS+O0jvrJf3vDK5Bdzsa3b7lRYxoNVyVbbQcIum4NIqvJaKk1rgiDOjxJSWMAQpTEVvHdyAH+lwMDPWHDuMqRFUzQ4JrbSr/eZkMA5uYIjKAOunojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787727; c=relaxed/simple;
	bh=8J+L70WS9pQVno8l6jjMVOPIu8b2mz0nvOS2cR+vTOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5pawue0DUwuOr3JpAuWcvlnB6cpMLF8eFyB4TMsYxqHllpEdWLEUW8D+zRjH9zskLR5xPx5pi6kXhAluC4DujK458YZBYI5a0mzzIFDU2q6y66DlszpT7tb4AZSlIaJjIhgZIvRzN1jZuygGKjRgSNg6OoWhWjhoja/oOYrGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UckJRMl4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso221696e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717787723; x=1718392523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U201HRecfdZEzANWudyljVSKPR1fHN57t8e+wgR4NiM=;
        b=UckJRMl497TiAaESh5KATMj7jW++fKKe3ces6CHXRd4NNc4/hqMkUomz3RjywOnuMn
         1rZzzvILqYRxHnUenJf6CfRUpEP1ozzSkUN/6AoJt4wSbu1O8t1m/ghAStbRbzQcqRrs
         cccVkS2g9boFUBvWfjQ2crncsQgTr2wfqv6lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717787723; x=1718392523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U201HRecfdZEzANWudyljVSKPR1fHN57t8e+wgR4NiM=;
        b=Zb8YK2k2tD48MKlHUF0M+wWiJPG0UkvVlQ69Sw666IoPPmAtwvbDNoqdvbal0Pf85m
         hoNL90HGoyOQu0Up3CU3dzVeokLqMMKzQ1/STYnnQSKDpAiHSOgP5Y3vTXLkVicpYLaH
         Tx9sSLQ7eXMbAWgEDzt63HLwFCqVXTNvBrN4HZ/x+cTcrCys3jOThvo8oNEp8Q6K3Bvx
         gKxJeHI6DHW2McJG5WO/T6/0qAaFApC52jgU6y5ATQ83HTqByxVK9ZFqRwek/b4QidHo
         5J1kdWX264wsEc9kl09UHnb7puA7zZuRqGPJLL/3AP4M0UPaf6bJSV01EdTXn6tDdrQJ
         EtjA==
X-Forwarded-Encrypted: i=1; AJvYcCXG6Zl79pZIp1etgPLyuNT2Z5z/V7Ycxa6Yugk7RcYueer7pmjv94fYImCKx1vcVwDxxMH+a8LL1CXDWbwgC/SBRJ55/giC3If7byPv
X-Gm-Message-State: AOJu0YwLtBNWiSTk25r+l2v07/X26Vxaf6fqZ2FYpQS3lrT9yNCQo3Un
	aclUjZRXbrkOyFj1ytUS9bSuFV6lVO6N7GMG3RckmJtQW/vOvfrYUWHqhBsDNO3N25+He1mL9TX
	2oy0=
X-Google-Smtp-Source: AGHT+IE1ycd8r9X+wusTZeqlo0TVnA+s0GohgSnvPclCFcGU0gXDkdv9wOpj0Zg4HkMrdPEzO0kNRA==
X-Received: by 2002:a2e:8086:0:b0:2ea:ad2c:45bb with SMTP id 38308e7fff4ca-2eadce9ac4cmr27230461fa.46.1717787723146;
        Fri, 07 Jun 2024 12:15:23 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae12ce21sm3195630a12.49.2024.06.07.12.15.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 12:15:22 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68c8b90c85so312388666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 12:15:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsFaiHiVgEuEohyyTffk82Y6Q5A6AQ2jFrQZoYMT7IzbtOP/jW3rzM5j+Ev8VVM0emN39dZhpqH6rrgb1XCE6NRzpe4DXfJF6CxFI+
X-Received: by 2002:a17:906:c18a:b0:a67:7649:3c3c with SMTP id
 a640c23a62f3a-a6cdaa04d47mr278592666b.56.1717787722057; Fri, 07 Jun 2024
 12:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
 <28c74739-e775-4813-b2f1-b588e14b3674@rasmusvillemoes.dk>
In-Reply-To: <28c74739-e775-4813-b2f1-b588e14b3674@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Jun 2024 12:15:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf-8ko=w7SyGWRLZ5bL_iwgw8mky8cxvYzF3xHDHoCMQ@mail.gmail.com>
Message-ID: <CAHk-=wjf-8ko=w7SyGWRLZ5bL_iwgw8mky8cxvYzF3xHDHoCMQ@mail.gmail.com>
Subject: Re: objtool query: section start/end symbols?
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Jun 2024 at 02:52, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> FWIW, I did a POC some years ago but either never managed to send it, or
> never got a response. It did boot in virtme and I managed to get gdb to
> do disassembly to show that the dentry hash lookup did become a 'shift
> immediate'.
>
> https://github.com/Villemoes/linux/tree/rai

Looks conceptually very similar to what I do, except I literally
_only_ rewrite the constant itself in the instruction stream.

You end up using these replacement sequences, which certainly works,
but limits your instruction scheduling a bit (ie the minimal size ends
up being a full branch to the thunk.

I started out wanting to literally replace a single 8-bit constant in
a shift-instruction that might be smaller than the jump.

That said, you then made your approach work just fine by just
combining the shift with the address load, so it's not a single small
instruction that gets replaced any more.

And honestly, I think your approach may be better than mine.

The "replace constant in one instruction" approach works fine in my
tests, and gcc in particular seems to actually take advantage of the
instruction scheduling freedom (clang less so).

But your thunking approach would probably be much easier on
architectures like arm64 where the "load a constant" thing can be a
lot less convenient than one single contiguous value in memory.

Would you be willing to resurrect your thing for a modern kernel? I'll
certainly try it out next to mine?

                    Linus

