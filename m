Return-Path: <linux-kernel+bounces-255800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFF934560
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ACF282ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4464F1C36;
	Thu, 18 Jul 2024 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQsMh8mQ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8E15BB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262589; cv=none; b=GVIFvFhImZm0GMmCRz9ezF43xHZGI26ITtts+MCD6qsnBd4E5CwgBUJ8UEAPOAp1DF/gN8hBO2N5jQHjNjZNPBUBajfN7UrRX1UG3EVozc2PudrtxY7FL4J43DnXzMPPMPoefVjxHKonupmOhhuC6GMqgC9IzDTuPCNe/sr/5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262589; c=relaxed/simple;
	bh=+or5w0IYanrdx24gFMXNosUMpik3z9BRFce4JaMq8rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTN4IVJc5lDePSMF0/DIY50mj3BSWmTBfijNMWc3iW4JewTtchkfNAA45Lumnu99riF5nrZ7AF3fFzkfRnQ1RxBc2IEJRShl9WrWxPz8EpG+Xpu7SVFiX+SPi8ZaCQc0KcgEpjrqu701OGFKEhfWefIT9CcBDYH2jxg7EVeJuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TQsMh8mQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so252455a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721262582; x=1721867382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+nmDzrtIiDuahGrPRV5lcTl5qIWD6fXdud3+UrhXSw=;
        b=TQsMh8mQaMSysfn4GLdGbVmtlVhL1Dx4oO6OYt4qpMvR+6irMscTQ6k8PGE/TeNr2U
         AITjQ5X5o4D8sDj0vZj+0wF5RQwRJB7z9dgQiADecU0NfXEeRuRJaSdHjH9s0PxXENd1
         qnRM3+i9Gn0NB+T2erLBzqbkIu1AUpg0DM+Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262582; x=1721867382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+nmDzrtIiDuahGrPRV5lcTl5qIWD6fXdud3+UrhXSw=;
        b=QCk6fEW1SKn5gSAUaaoCKNC5xYnRvvW1ArAvSPA+ym0GoFfeJWdmyRy8weoNoCafYj
         v7+DoMD129Fg1ogclQwlxG0CzBqJC6EZlqVlSr5vTgTikuoK7q8CizSHlHA/14qkrgu6
         TVwrDQhP5nKzTXWEmKbP+p1HDpDFqtUO+aLANdYGltldzUlbqcHSw+KG/Xc65qCsY8M8
         OHePlLTwjr/75Uq9MA7TV9LxcK65fEgtkfj901anUAB5xGjXqQt2FJoKOQKgOmI7u6SE
         UcLXodHYetWwwe+XIJBF+8hEBZJJIsdlatHvCPub5+OJpmuKrpUh/qumAIxr5+RBgatl
         cmNA==
X-Forwarded-Encrypted: i=1; AJvYcCXQgTIIY5lwnaR/8b2oE+h0oqW7fnCwyGVY+Y+5Ig4rvnKn2ZDZVb5+NFJOSBHjBYJWHMSM3mJreo4xhQHpNTAQoFQHvzEzQI3SbAKw
X-Gm-Message-State: AOJu0Yz2Y7kHOl14XGhwNKMJzXYOl+gzH4bvO9KA9+4RHmcQwAXCggRo
	MvlDpEImF4FAVKT+vQ4nmEsuS2BTSybNutV9cbA69bVsk4WuYE9Ys+Cge1stw3GZUL3/vmrot/O
	J4Tds/g==
X-Google-Smtp-Source: AGHT+IHOMmeRnuNMpQoXMfwbv+dRkLrnOnSm0vYlL88D+BN3qkN/mYl5q6qJp/OMdH+hzIps4A5usg==
X-Received: by 2002:a50:d713:0:b0:5a1:a469:4d9b with SMTP id 4fb4d7f45d1cf-5a1a4694f75mr200358a12.13.1721262581998;
        Wed, 17 Jul 2024 17:29:41 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59e2905ff3esm4702489a12.51.2024.07.17.17.29.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 17:29:41 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so258521a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:29:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPS2j5XVwSRSpwlEkv6GSN1j1mzMSJaX1Re2/mUcyRwn4uMECagsgEPBZL8gnXmiYuWOUG+LX3KrmkTwpFUqDhhcguFRak0zqi1fp/
X-Received: by 2002:a17:906:4c5a:b0:a77:e48d:bae with SMTP id
 a640c23a62f3a-a7a01192c99mr210611466b.28.1721262581203; Wed, 17 Jul 2024
 17:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
In-Reply-To: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 17:29:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYL+35WqSHA8z3gV-7=gpdFPjjq-qDzMvykfJ-RRa3Zg@mail.gmail.com>
Message-ID: <CAHk-=wiYL+35WqSHA8z3gV-7=gpdFPjjq-qDzMvykfJ-RRa3Zg@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.11
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 06:34, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> Please let me know in case you'd like me to fix those and prepare a merged
> branch for you.

No, that note about the issues and pointers to the resolution was
perfect. Thanks,

             Linus

