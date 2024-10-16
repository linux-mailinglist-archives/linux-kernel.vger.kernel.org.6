Return-Path: <linux-kernel+bounces-368693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 050A39A1371
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98074B21811
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47102170AF;
	Wed, 16 Oct 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELQ8f8MC"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA615C145
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109291; cv=none; b=a0bNDUCE7OE90xgdOazkkR4+H+aT8Jwruafl2Oxx+E/0lXHRXgeA6O9YMwsZEuXnPfvMUEBv5rdtSGk4OW0s7S1vcqIgwcjKFjzz2YL7+xSCakFTeuJefRwYPt/45z6yUn7hhAENemZmlv6VWE3EekOGocPTjTMzeFbieZAc38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109291; c=relaxed/simple;
	bh=GdkznF4IVV6bJMBN5T9UjLgi67lcbrBzwicDpDkQp9I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pss3N8hYpuFdPUYKckUVVgBCZ15/tonyb7JEdjq98EKl+QD9YolpZIc0w1yNgW7vBV30xtVhdfOq9GiMdWDgRxY/cSXx5aqTNvKqztjq+BXR+Et1OUaZw/NmDQJ2lgW1qehnymQiOrIWo7ts9n7tcut5hqHe0jJmE+0ZFj8jQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ELQ8f8MC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460969c49f2so66171cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729109289; x=1729714089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4x8ZP9Vbh+VTFMg/xiymQsuRxJWNJs+6ZIoiCkqRAm0=;
        b=ELQ8f8MCgEZdN7ebs/2UTku/Lil307fm23SFWqNud42h8l0pZk/3mGIwrFk+9/GqRd
         bfy/axuXZV9U6D5AoIN1Xlwjg09BHCNngHZJ0gBv8KMKqRr6Y4zeESc4edzVOhj5nhvO
         KdU3nQ1z3oU5MKJxoo/FVmnoC0ExtogNqK1F5SX2QIZu5z3/5Lj9l2X2mKMJ/pH/zxt3
         IJdTuNmGNOzL06kGcKcZuupNTx4ja0bESrXGoilTMi4TMme72n1pLMAiFnWrT48JvDVp
         3tbjIt1RHHb9XsIqHoEf2+7rmlRShIrM8OQs7nxiPlHtFn88OF5Zqnyg9+8cgBIRWFrE
         ZBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109289; x=1729714089;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4x8ZP9Vbh+VTFMg/xiymQsuRxJWNJs+6ZIoiCkqRAm0=;
        b=RGqixafb8+yQ3czUMMX9Dh/KbmE8068nIny8AhQJCgwxaaii0ZGPLDOp4eWUhFZDSe
         mvejRfLZQHl7Gld/GgmaZFI/qpLf+zNjsVlYTJy5JvotuB+rcLAqdiKspr2waCreWouF
         z8doDbSa5tSA1m0AbI0vKDKHfL7pdTgxP1GCTIUihg4YUaZQuV/m4phe8ENCK2WzACHM
         TLQTHH1JNO/TBh183gv0aSwajUlMQ/bQCpDkMUdC8XWs5Gi47g3SnR8HdETOa7zTXQzg
         FabL11tkUbWTkpSEcZeDOh7ydt5OTfnmnKrXY6Ps20TtWzAC79skp8BbJr0+rBCjD3rc
         OT0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/68Hchcfs7IeBt98xeSswBs5Q75AO5dfk91ifxq5pwmjHXTvGTeXuGbiOdRN/8K5iya3BmqZ0Hhdty84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9viWpx7rewmMGYx4g0y2xMGrW/41Si1BcAx/rNu89rBz1ij0
	u9E76TyGwdPCM9ld+TgTM11JCNtmT/+N5E2rNzv60YaaP3zfNC4pXLJ3nNBqJM7G8yauzOb4xOF
	DJajV80EEbWU80GlFom9BEQ2ouEL+zF2N+c/l
X-Google-Smtp-Source: AGHT+IF5hnOqY+1pTXpL3951R89pfy6xU8zLwGpCYH8n03Mf3vHjGku1bi4mgVj553z973h+Q6KOOQ98ZWYCxNR51ds=
X-Received: by 2002:a05:622a:4e98:b0:45f:6f3:5671 with SMTP id
 d75a77b69052e-4609c8e1896mr731531cf.20.1729109288691; Wed, 16 Oct 2024
 13:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Wed, 16 Oct 2024 13:07:58 -0700
Message-ID: <CAJHc60yoipTA7WywvPSM52X-NgCTgy2Dvxn8OrCT=vPJNNxNxw@mail.gmail.com>
Subject: [kvm-unit-tests] arm64: Build failures in fpu.c test with clang
To: subhasish.ghosh@arm.com, andrew.jones@linux.dev, joey.gouly@arm.com
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Compiling the kvm-unit-tests for arm64 with clang gives the following error:

arm/fpu.c:235:3: error: unknown register name 'q0' in asm
                fpu_reg_read(outdata);
                ^
arm/fpu.c:59:10: note: expanded from macro 'fpu_reg_read'
                     : "q0", "q1", "q2", "q3",          \
                       ^
arm/fpu.c:281:3: error: unknown register name 'q0' in asm
                fpu_reg_write(*indata);
                ^
arm/fpu.c:92:10: note: expanded from macro 'fpu_reg_write'
                     : "q0", "q1", "q2", "q3",          \
                       ^
2 errors generated.

It's likely that clang doesn't have "q" registers in its dictionary,
so I tried replacing it with "v" registers, only in the clobbered
list. However, I think this granted clang to optimize the code in a
way that causes data abort at in fpu_reg_read() at the first
instruction:

stp q0, q1, [%0], #32\n\t"

Although removing the optimization flag, -O2, generates correct code
and the test passes.

Any suggestions on how to deal with this in a better way?

Thank you.
Raghavendra

