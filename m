Return-Path: <linux-kernel+bounces-447121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5DF9F2DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049B7166E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D6201110;
	Mon, 16 Dec 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipKaYN8k"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE01C54BE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343274; cv=none; b=JDBV6n9/HKO/cf52dWnW+EEypVISApPCkrk8yOktZw3+NkgJpLTMAO8aGasv/d4dvtxKtT2BQQXqsDQ3IOC0iE3Y1rf6xGaOYrN2csv4Cy0cLPdvaYY/gzBN1lp7V71fJaE9VsnzM5khbUIu9jUEVByz6Qu6FRC3uvTqTI3SBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343274; c=relaxed/simple;
	bh=8o5jTEa5ebzOtzZM3gpGo3F5kdkUdqu2jYjbHg/1rL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw50B0EIocfJidC1gqZs6fzKlINnzsmp6rcMAC4rMCMm4VtQqqSFwxj8fNOiT+CPYZb0l63ywxraKg6D+58d3dKFHdaocVTWmOQkX+XF9Ek41cJcb9KcFdi5A0kglCovjOKxrEKOs9DSWyowSaGvcMtRldwtRx79Rw+Dnwcpqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipKaYN8k; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4679b5c66d0so384321cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734343271; x=1734948071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwq5ggD/nJ1Jxh/jaamtYJrA0D6FiVs9BLcdVRZw1ww=;
        b=ipKaYN8kPyBHJFXpafErK0vga4oOXRuEHtVw4v8hbMgNCfDrKaBzLHw3wC0qdtTz+n
         IUzkKL1ikjNaFdKxj8xap0mWN4EF7CD5gQro5H+W4RFGsxR0Zu0n7geOPKQCtGvLNWs3
         goBZ0Gxo29JrEwo6TbXUvMOyWubyFAWznyGE4n5M71aSnsc6qTO15AXdJB471PrtFX/m
         q77/2drJNAHyK7HiUwOTJfC5r6yR8wUpM66lJCHbzccjtWH0Mmeik+5RYzk/ehMVELrf
         4flxHdg4BScGW9sC5rxubbvfB+Tys/cdAdKDMlMHHneyRXj7mk/jtsgKu58mHBid7JtE
         gGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734343271; x=1734948071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fwq5ggD/nJ1Jxh/jaamtYJrA0D6FiVs9BLcdVRZw1ww=;
        b=bO1QUtJ5gFaqwpqt8DAcCau0QLsOE4I/BW+ig1edL6v9ECgEKnTd60fJNmi6kAksAn
         xPyK25vISwUKjw5n/s0M5XS10stPzI08UVLX+ybz6p1oxJLfEe5/9j7CqCMTHH6uYFWS
         HQzf9gO+XwmVuEf4roD0ljkMNehYzqsh1f5NS2YXCmO2X9Dzk3iAGtcx0Ju+vqt/2utD
         sOsBbJTeP2G5NeELt51Wizw63GQtbWFv365DivkSJ48h6p3OqpPxok2xwEIYauqrMhIn
         V1udn9aNzPPNIRtQyMhr28VLgdvGh5xbsppKwyXwDXA7Bv0O5Nhlo2k6gOli/R9XHLLw
         CjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdsQxWiUrLqFYJX7iGRWyW+opVKBatB52xGauqcONJDjWRoj/FiataSCouzwYphqaDomDUsggO78x7C4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5a1QHiFFRu76ME7r1Qbf8IUiZAX/jZt3YTWfq8LUTAs+xBdsy
	ouk6kWryzBSEXVEvnGLPULU5XV1YIEgFQWtzwGAffyf6UDa4603YyeTh6rQ65zq4X5ugzraIFzn
	P0vrTr42egDnamAFfmObREG7ajEwCrL7nTOCP70B6LJmuWKI34LpL5GM=
X-Gm-Gg: ASbGncspd3fX0wpEUMYG2cQbGdZo2qD3IJXaWfuFTWHI8qc/emep9r1cfJWmrY1DqQk
	yvAxNLoL3HLXMnGYZJAGcJNiroS7p6aI8jDAVNejg61KZ2AcXr5r3PRzTa8gN+ykabJFx
X-Google-Smtp-Source: AGHT+IF5D+bUUP/otSIqXEjmjhLQdoX5kqC6bDKYp+Tf1iVR1unOxp0lNb68N/rNej8OuotRJ1wjQNALfXpxk6UU8sM=
X-Received: by 2002:ac8:5d4c:0:b0:463:6fc7:e7cb with SMTP id
 d75a77b69052e-467b4a283a4mr5464631cf.11.1734343271175; Mon, 16 Dec 2024
 02:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-objtool-strict-v1-0-fd388f9d971f@google.com>
 <20241213-objtool-strict-v1-2-fd388f9d971f@google.com> <20241214005223.f2fansikbwovm3oo@jpoimboe>
In-Reply-To: <20241214005223.f2fansikbwovm3oo@jpoimboe>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 16 Dec 2024 11:00:58 +0100
X-Gm-Features: AbW1kvYh0Qp40TndjYKL3Uwl01lOD3gETa_kj_WPV9X2f7Vg1GPRlPG5NP24GBw
Message-ID: <CA+i-1C20dBQGYU0gAJ7BGfo7ShSYSuZgB0Gr_Y-ei9gqXq83zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: Add option to fail build on vmlinux objtool issues
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 01:52, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Note that *any* objtool warning has a good change of being a major bug
> in the kernel or compiler which could result in crashing the kernel or
> breaking the livepatch consistency model.  So the option shouldn't be
> restricted to noinstr builds only.  In which case it should be called
> CONFIG_OBJTOOL_WERROR, analagous to CONFIG_WERROR.

Sure, sounds good too.

Just to make sure I'm on the same page - are you saying I should add
the flag to $(objtool-args-y) instead of $(vmlinux-objtool-args-y)?

