Return-Path: <linux-kernel+bounces-200945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B28FB6FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6476B1C2259F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ED4143C6B;
	Tue,  4 Jun 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXfdEtBl"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F03C13B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514823; cv=none; b=CC/LCH7M27FlYQX68geVlyezFX8hrtspu4c0pcAvYwsmNA2v+eM0ViiLZB/ihjCRe4V4JvG3y52SWSnMihNrf3lO6k6Fvd3CUeas3uwItvTmvsMOWOQpRZY4mGCZfSbfbCsyOkFgAQDaVnmI9+nB+s+zlUTg0K371+Kidhfvdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514823; c=relaxed/simple;
	bh=+/m73fd6wwvwn2BK3nQ1qKzu15Ei0WssG1SvvVxJuPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAP6r2ehWuQvZzOGjKy/h3wPOcWzs5yFqOWAZFH3PO+GxFsZVC4t2cRxiS/1DHE3dDRm+k+VE45tHx2GNZNuMhzYponm7HV3BPbAf2yRZhGHXUYlIpgtosm5Rp4/NXqzmy4Qsin4+P7ek3OXpZdWVRjSlZ2UZJvi80iYDd1oyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LXfdEtBl; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9c36db8eeso3233763b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717514820; x=1718119620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/m73fd6wwvwn2BK3nQ1qKzu15Ei0WssG1SvvVxJuPg=;
        b=LXfdEtBlgURb+1yRL9+LlkQ3xq56uuyPVaXMRL1Iphgd68iNevs9KI84sO6c3twK7G
         UIwvMt28n1MB27aAOmQbeGJuS3iyDvfM8DedBEVRK5WiCKddIh2CyrL5oEfFdFwpDSzT
         5lGdcDyjXq21fbquqBJ6OzG/CW4Km+ivbdap8x/xyx58q05PekDUqbTcN2fvqcXq53B/
         9TxEltIMHvQxNg7tLXRp+y/F+o9ISsAO9jNORWUkTo9o23IOKQLRWutNluQKbQGRqbQy
         RwgphiC36cDxkfSejcTryfMjrvSkG8e/776suKSVpYk/A6umlxRZY8m9YhHLxX6SYMqW
         of8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717514820; x=1718119620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/m73fd6wwvwn2BK3nQ1qKzu15Ei0WssG1SvvVxJuPg=;
        b=gBmM0fI0BVS6E3XSymB7jepOw3UtQcruKBLjhZtxoNanbf8zQgqCat1sYHb8pJCUDh
         2LobFZH0wLAdlNYqK2OhyghAtDEYM+ac70RZk3pn5o8E+8zIpOFASipauRcuSh+qD+Oq
         luZuA27EgJte+bb7omphObx97y4G7uuYgNUMp7AsPAkcKtsKU9sobRhSFvfaSkn2yrlj
         Ab3tA193Tf26cnN0+eYZYLdtjY2MzTSbcgo+bA/7pOhUOLzYWajC9EXf+IStk73PO/GN
         YJtOUwM7/083yIZuM4wEwkigetwhDQRafdRRYeoE0f0psR0L299N2D0Zp+RfVkHMFsIm
         hJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt7R6JnF9gnV/ETms/J95/+fXe8jIXyvl2rGSryzvckgf4E8+Dm2Jjyzn5LvMXqwjF/RNwnQUv61n0nUpUGV3dxKUzUXgEd2VMAUs0
X-Gm-Message-State: AOJu0YxggIEfIqcczFXUIod33RrUQR4/5QQU8OXAhTAo1spCwQSItEdP
	brvdAkp8mod+TkXnl3MvNS18swH1IiFuV7DDWeughT70nGZwoazKu8mrEM5DHrimybiG90IC0sG
	r5NBMgs0kyUJ48U/GfEWd7ZekNRFgIjYT2re7
X-Google-Smtp-Source: AGHT+IFLDOMwo3T4HpXcVkRPTZIGv3buuS9vCd/Gl/M6Lf/7+v6OGiKrv6Eg9jXvGDshthb7OOBtYx2eHBZ5k4fU044=
X-Received: by 2002:a05:6808:8eb:b0:3c9:7aef:403 with SMTP id
 5614622812f47-3d1e349e4b2mr11834942b6e.26.1717514819911; Tue, 04 Jun 2024
 08:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
In-Reply-To: <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 4 Jun 2024 17:26:18 +0200
Message-ID: <CAG_fn=XNZ-OyjboNctGSL-zZiag4NVFNs+uaPm95Y9Rrc+TOaQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] kcov: add interrupt handling self test
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:45=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> w=
rote:
>
> Add a boot self test that can catch sprious coverage from interrupts.
> The coverage callback filters out interrupt code, but only after the
> handler updates preempt count. Some code periodically leaks out
> of that section and leads to spurious coverage.
> Add a best-effort (but simple) test that is likely to catch such bugs.
> If the test is enabled on CI systems that use KCOV, they should catch
> any issues fast.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
Reviewed-by: Alexander Potapenko <glider@google.com>

