Return-Path: <linux-kernel+bounces-200919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6180A8FB68A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517EDB247CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1C13D2B6;
	Tue,  4 Jun 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT5aDXwb"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C313D273
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513532; cv=none; b=MIQ8wAgi71aWgC2RHA3swLqhhhjnvYpeEt1JMxAiP5SZ9HKh7v+c0A2Wp9ApEiGziesVKD6DWyJ0WHvu20FokBpI2GLk7dMWYdiHnj+ZIgauWkX/WfsWOjUwHo+5TJf2MWIu4yeHT1fVuKfB0ChYQf7hM+6spen/AWmqMJMpD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513532; c=relaxed/simple;
	bh=94VDYsHzzBLioUYgp5PTC7zmAaWzB9RDh5pArOzfqZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcIGBeE3OzXrrpdexCECqBvq9IxigPYF/gl1lKTYZRFMTCwh2UIyRG+URDpag5okf92XYqzlWD2hIkPaBdL1QrDfxvoh+qiRROjqx+MlKCAewW6wijFBFZRAjZsv467h/qO59OhbwkBjN0ZeSJ4CkY0PJ/22m8NXqWxfZcpOUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oT5aDXwb; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6afbbc87967so13586876d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717513529; x=1718118329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94VDYsHzzBLioUYgp5PTC7zmAaWzB9RDh5pArOzfqZg=;
        b=oT5aDXwb226Z6dVsXoYbKmHKXQgfnChKKd0XCWWQ/3bAZmpD635cjTyoopweSsOdBo
         m5kk6qfJZEE7PWGG0mAZ6qqw4DjMsuMjuB2N5nTCLLAKYl/9S7BinM0m7aOhTD5JhR8g
         HTvNhZ3eI3xfu5tcnPsETUd0ufUhqm7CwrLs7k4rQbNU1Kqu6q11z21MPRV42YW88u5o
         yuYaFuF59bbto2pEW3aE8CMMIfv5jkIjIULF1gUWUcakSMUWGJxSqQ0g4osqpz59BZpn
         Aa5tgz9Bc9WEGMMn+um0f57CoTe2uz5sCnVVhf2LMmsdE+EacMy7d1PBwbwiLr+67YCn
         3U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513529; x=1718118329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94VDYsHzzBLioUYgp5PTC7zmAaWzB9RDh5pArOzfqZg=;
        b=wbvi/iYzKnEGTeuYfz83T7tUg3i93YKUVbtHzoBdm8/+oygzq6QRqsT8PyUOpO1r9u
         Egz9O7whpDZZwfgq/t2uiIpZzHAq9aObjXRGpgOPpx8GWhwcL4oUv8f5IOtsxpdXnX4b
         qPKKQAy1IV296dlt7YNX9ch7M/xpvNwOqf0XN5K8gPr7vm+IrTR0iHhmlPMCakT6UkoT
         Z9CLLMzYc6Dkgar/rn6vIG8XP4HS2dIWCWQlYrdNBOQGH340pMEctrIdN2uVTjboYAn4
         CanOnNvjYmzSDJ796voBLGanZJyaXMN9Q+/mAiyqE6HFuorPRyw9iOaE4G9I1Y5cRgCh
         gEKA==
X-Forwarded-Encrypted: i=1; AJvYcCV6d/fiheij4jpMYpkhixP7oub5Lnq310NN6fEia5wP7U5QWDsvDRUutL9UZiakDeVcOpuxVKfTgkLQwC9DXPo43BZQM0lsM1K3dXzF
X-Gm-Message-State: AOJu0YzsVE2n4nLxMZ2DqFQ635+qaXTuvMZbEb+NfZwNZFRQ+iixOeND
	9b1DAnDLauornaaLc6GNtumlhebnDEJq2IDrdS9fQ/wBPtiEEEL9ftHETwmtVRpY8z28E+l3rY1
	/FXxtERmkHO1vmVqjGdeRtAeo7qYacP930ZdE
X-Google-Smtp-Source: AGHT+IEBPKAlTho4CJOxYPwToOjLi3MGkFqiqRbt+SKyCfAhGYPuYLlY7I5nyZfftddOLf9CkxG6MIav6O6REeodHsk=
X-Received: by 2002:a05:6214:3b89:b0:6af:5056:da89 with SMTP id
 6a1803df08f44-6af5056dd5cmr81784966d6.11.1717513529108; Tue, 04 Jun 2024
 08:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <1ada3be307bbd076c4ea63530cf445e7fbd0e4e7.1717507310.git.dvyukov@google.com>
In-Reply-To: <1ada3be307bbd076c4ea63530cf445e7fbd0e4e7.1717507310.git.dvyukov@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 4 Jun 2024 17:04:51 +0200
Message-ID: <CAG_fn=UHSA9upL02GdtbeG0qUCwU=bAvfkmkOZDnwS3nzFZnJw@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/entry: Remove unwanted instrumentation in common_interrupt()
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
> common_interrupt() and friends call kvm_set_cpu_l1tf_flush_l1d(),
> which is not marked as noinstr nor __always_inline.
> So compiler outlines it and adds instrumentation to it.
> Since the call is inside of instrumentation_begin/end(),
> objtool does not warn about it.
>
> The manifestation is that KCOV produces spurious coverage
> in kvm_set_cpu_l1tf_flush_l1d() in random places because
> the call happens when preempt count is not yet updated
> to say that we are in an interrupt.
>
> Mark kvm_set_cpu_l1tf_flush_l1d() as __always_inline and move
> out of instrumentation_begin/end() section.
> It only calls __this_cpu_write() which is already safe to call
> in noinstr contexts.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

