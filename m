Return-Path: <linux-kernel+bounces-364491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3F99D546
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4A5B20E35
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EC41BFE03;
	Mon, 14 Oct 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lp6seAB4"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D13CF73
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925747; cv=none; b=Gom+7p+0kGKfEqYQCFybo3weyI32DuaWwOcSBRNIyv3xkVsZ08b9qcPRqkj7ltA08KwDVBTHSX922fNDjw1IAQww4YwPqCWnHgDgYwcxhydGotnTqrdgG4snA00uv7uhyP5CGqirHUW14traDmXzupxDocEMWlS34nIlGbMJteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925747; c=relaxed/simple;
	bh=aBNqE7I/9Lk1oKa4t0Edva0cW4vetJa6Y9o2A+wTuqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB3eUOF3OP1uKreLx6PHe8du7SWqft2k+tVQpQoKDGtHplj3Kq/I8xfNOS8+YQatGZETv9B5EJBgGdV3JU7TBQK0jHlwb/sy4kBCNsHd+bt49Zma4lA6ZPqpzaUXJOm5S3YDoIFGBxQcg3IjWMXwz69cxlkDyCdPcOjEh5dDUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lp6seAB4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso242271366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728925744; x=1729530544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBNqE7I/9Lk1oKa4t0Edva0cW4vetJa6Y9o2A+wTuqc=;
        b=Lp6seAB44aVqIR4UgSi4CSx2lzgdS0dwKnSNJuH/mfKm5gMuXL5WmYPvXAaeEiPwjI
         WyCQ87oRXZQs3aew0N92m89pEzdrQPNl0pWSWPX3V24xnz3Rc/F/FQuC4RawomAO91Ko
         3vrdi+illhI/CYZay15PWZfK2HKY6+l2WnRtZrePH5ChIaoPV4szczll/Q+UUJPdvbY0
         sM6CeCE1vVpa6oKupfDBhgMEhPsKanQbWNZBWEu3njGDJKyTi7Av6u00BYWb2ChbdqoR
         WRHnGaJrDQqy9m7VGJtQy2izVsNTQqPJp6S5xFWbEQgbybY17kqeAP4drpb0T2jkwkBg
         BU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925744; x=1729530544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBNqE7I/9Lk1oKa4t0Edva0cW4vetJa6Y9o2A+wTuqc=;
        b=OtRwISMix2sXC5Sz/DEnCSRZ6fQDeiUdV4IGbc3vMuw0mvgo0cDMU8+VCrnFei1puy
         78/0WU4kEFheF1Y72v4HSTyleHdd7Kgly+jn6X47uAkboRQGo4IhHWD+5VPJEz/U+5cm
         R6HCIVILLtI/NdCuY24EWypI1hudSPan69n4xgue2oN0JkRmozQJ/P1nwXh3oK8ucYmt
         ybWQoT/6/eAxrjEX83LRKOGyNBgSlAPupTc66+oRYNPIX0nGFlT6Urxm4dFM7+4yhFdC
         wKyB3TUWfn4Cj1oujV1r9gz3AGlh5SeVNs58WJqM7GekDQW8rYe7RhtpbmiO2O5y4jC/
         0o4Q==
X-Gm-Message-State: AOJu0YyG/zGhF4J2x2z9h9VxtYjY9vzehzK8hYzxdWR8xu3MHNelsqXp
	nzOrsRhNKlspurJHxOFUpRZEHx6pXvgwNwBFHytPbyy1RnVd46IEEtrO5P/TXTrg2TBI4zIR9jj
	rGP19PBou9/kIwP0pUCK8X14zLiPPzO/o7Rv174ZYFumb615+
X-Google-Smtp-Source: AGHT+IHUGq4gjrB+s5CKTcEQ8EdA8Y4qcdyGwZR8I4gvH3OCH+L/lyWfnuwyTdsthwJXIriev0msOWNPUnE6hW17I1c=
X-Received: by 2002:a17:907:3cb:b0:a9a:13f8:60b9 with SMTP id
 a640c23a62f3a-a9a13f862d6mr144648766b.36.1728925744040; Mon, 14 Oct 2024
 10:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410121433.jYN4ypTb-lkp@intel.com> <20241012165523.2856425-1-jstultz@google.com>
 <20241014105323.GA16066@noisy.programming.kicks-ass.net>
In-Reply-To: <20241014105323.GA16066@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 14 Oct 2024 10:08:53 -0700
Message-ID: <CANDhNCpzgEFpfHOzmUZU5aG-Sj4up2YckG5iWjHMbfN=bY30yw@mail.gmail.com>
Subject: Re: [PATCH] locking: Fix warning from missing argument documentation
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Metin Kaya <metin.kaya@arm.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sat, Oct 12, 2024 at 09:54:37AM -0700, John Stultz wrote:
> > The kernel test robot complained the commit 8d8fcb8c6a67
> > ("locking/mutex: Remove wakeups from under mutex::wait_lock"),
> > currently only in Peter's git tree, didn't update the kernel doc
> > for the new wake_q argument added.
>
> I have folded this and a fix for the i386-randconfig build problem, and
> pushed out again.

Thanks so much!
-john

