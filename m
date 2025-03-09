Return-Path: <linux-kernel+bounces-553411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD7A588E6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 23:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3FF3A995D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2F1A5B99;
	Sun,  9 Mar 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCQ0Kjdn"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24B76025
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741560417; cv=none; b=gtmkPwkLxvKQMRhpYyn2aLasY8c5Sjdgl5znU/mO+s2BZMlUs7MP82u2UyhQij5Nny0mv9OFCmnycJmPUdajC43dgq/o54CrL635jv7fYcznSZGGX7uZ5K3iLur8XwcC4IfTLV8YKSgpkQICPopCXGlwt6Ed1S0O2mclqHg3z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741560417; c=relaxed/simple;
	bh=fCgMgbSnFNNCxMS78Pyf+lIxwc9SUxwFWtpHnHTuhRE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oC3VfdBXtBswTTDZotvolzoA4MmllekurV7qUGgXLP5mdzVGkuoRllrCTShNgN9kD7U1k4d1i6qjrO4liWaNMpAE7RnFGWzS79sb+6RXHiBUyHtmzv1o38adRJz524f5bRKmZ1HVXC/Xdy0ed699WAAIoBFuJzWLORllvOcmwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCQ0Kjdn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so3198931a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741560415; x=1742165215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCgMgbSnFNNCxMS78Pyf+lIxwc9SUxwFWtpHnHTuhRE=;
        b=lCQ0Kjdn4XHxjiRkcsnZ6wB4RTQaAsjwa1FCN3lKxRQYTFAxpbTw3PV5RdLIH6YItG
         r0O8pP3UBrba88+tnpg9PcB7ktEIrg4ntrCx6JTazX1tBIRgJtu5tBHwckjqkwwMDhxg
         4FoLmHMAzGgmjpvUuzsRloub78sKhUJNs5bzeWngA6xrKFHnXtWpArRw8VhQ/88H1/ZJ
         AoRGYP7Ej+z5eSICBMtlUbyr/Sjc7Cf4wCfc6dlB4ekwNAZbFf37s7AP6LEbH9VMfjol
         +qXI2wJtYVNgPIZFIHLo1eN/KVs3zPl7eKiSzNFotYqyIweAkdSTUhSPyLt85PmYDuAB
         m0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741560415; x=1742165215;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCgMgbSnFNNCxMS78Pyf+lIxwc9SUxwFWtpHnHTuhRE=;
        b=dyhgZemZmI7+DJsg1yffX/Jz3n8O0vEoBjibTfUhxDxMi/SmS6JetzNdJTGNTP82uv
         wOAVIb1/39AdrdDEwkCMbJoRwOQMg39j17KIgOlwKTJBWlUsrkhTJrt9YT67rrrkeeBs
         fVlPhcWkb/j6QAyAaarrU137mmejR7M+Ilpgn7tB/YszlbkVadSkribPbu/1+6lxmXS+
         fa12K53bMqHSVE+OHQpvZx0rVOO0AQgvGPzRwFI9Zy4BN1w9ZlkEThRidSiseaKY9XWe
         zLttIBYc7rhRqF8+j7rxflRjly6C6KNs83PfN4bOGffYGpByXsVmH28DPFhBhReW60br
         JD3w==
X-Gm-Message-State: AOJu0YyJju39VSq1CYS7IdYR1dUaUK6ORqSW1V7yHJwYCKX/8pldZ1Yv
	I8OkOUjajQJEPN0YCph9Wse38LmTUzpQRMumV/gMEHhpnpWwarPnJ1RMO6z/Wx7hHS94YGzLetm
	/FK6AdtWkRtHievcRvTzs9OpEjsFH8fZUegg=
X-Gm-Gg: ASbGnctpKxT8VoXym3Me+HssnFr2T2L9KD8WR6mgIHeA6Nc2QqyrTJCBeMli7TVJDeM
	GAhOP137WwRWIPJzuzY64EVTsXyAb/gDJ0Bf1VkTWJUn9BFb/z+SSWyNxu2wJCejfI2ssaft+ZC
	wFviinGH/ifUKScjwYkKoTfRfZVe5vfPY7Hcu/SCKZwL5tTKvBpHfNaMK2Uuds
X-Google-Smtp-Source: AGHT+IHoXQaTMnrmYBPWkz8kZoiO8pNibAISA0hFKIU82FcGblSUyzqsJJVSMquWYZEoVcw6QqrNcH2w6biVW/o3r94=
X-Received: by 2002:a17:90b:3810:b0:2fa:3b6b:3370 with SMTP id
 98e67ed59e1d1-2ffbc1f57cemr11494205a91.16.1741560415421; Sun, 09 Mar 2025
 15:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Avraham Hollander <anhollander516@gmail.com>
Date: Sun, 9 Mar 2025 18:46:43 -0400
X-Gm-Features: AQ5f1JoAtyeDbh1_tNiqhPV04-y0JA62vtmNtKO8b6jDiTAnnz4vtjkoCe5FZ3I
Message-ID: <CAP1mzZS7=Vpc0wXeD259S02WP2KTHd3CcnwJrKqzxBJTVZ-b_A@mail.gmail.com>
Subject: microcode: You should not be seeing this. Please send the following
 couple of lines to x86-<at>-kernel.org
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After upgrading to Linux 6.13.6 (built myself with a tarball from kernel.org)
with the microcode loading patches for the AMD vulnerability, I am getting
the following at the beginning of dmesg output:

microcode: You should not be seeing this. Please send the following couple
of lines to x86-<at>-kernel.org
microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011

Looking at arch/x86/kernel/cpu/microcode, it's triggering the default
condition in the switch statement in need_sha_check(), but I'm not sure
exactly what's being compared to what with cur_rev.

I am running a Ryzen 5 5600G, family 19h, for which patch 0xa500011 is the
latest microcode. My BIOS already applies this version before Linux boots,
so no runtime microcode update is actually needed, but it seems it's trying
anyways?

I have not had an opportunity to update my BIOS+PSP because ASUS has not
released a firmware update for my board (PRIME B550M-A AC) yet. Could that
be related?

