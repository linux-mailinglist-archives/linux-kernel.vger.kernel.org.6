Return-Path: <linux-kernel+bounces-349799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2747798FBAC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79CEB22F43
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207F17557;
	Fri,  4 Oct 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="Fl2UTdds"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC313FF5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002514; cv=none; b=o140LhtlwK7VlYjbJh9Kc2Go1/fyUwxI9ERrnKxJkIGqp95KpJRq4c/yneAg77yHl4s22AYuuYgDfaxWoMOpWQR9YmpoyYLVPP2Cf2xC6B9nqN+saweOMhM7OuUwFLpUsdBlvG547Th2ZWNNrM0dV0UPsF3H970JnyeQb9+S/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002514; c=relaxed/simple;
	bh=Rf1JGLDV33/N9zcn/MiCeLTA4xgFUztmkDmo/mGl1/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fuoY4uy5OojAaEjOBDoaYaQe76BNkplfBWOET79+MCZCNjsDDI8qmtW9+gKIZrOm1KmQw176LrFFCiV653f9SrJHj0PX3Dy+4PMkWpvSLtWzCzavVaHLBknFbT2Dqr1tyigJ/2yVXpft9/aW6BkvSKffSuxzz5lHb52zVCtYw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=Fl2UTdds; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-8324124a172so72851239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1728002511; x=1728607311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf1JGLDV33/N9zcn/MiCeLTA4xgFUztmkDmo/mGl1/o=;
        b=Fl2UTdds8YGC4o2mLCVmHYBUYqIqd4NTFJBaIhnhJSnV3I8D5daF/KRid1FHwT4g1H
         1EeF3LaQQtr3XFqcjPe3vKOrbm6xd8bBTmcgbdwdrk17nI8Tv9kOxpzDAyZYv5xLta7t
         yy4RYzWzsaixinZavY9yFkQbQmhiR1rvJt8c1whmvVBMiQMW8TxFIPTILN0UXHPJKExx
         rQuU9UfMzWvPDar4AsvuckuvECydIYFP6qf2pNRpgGs/8NCSFjxTh2UrHcR2MGoimK7A
         HYXYXpGUVOpEswhVBLAEdKab4PQ55QKQ8603w9O8TfqQSn7s+UZXrGBn09Hiy/A6/CqP
         H4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728002511; x=1728607311;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf1JGLDV33/N9zcn/MiCeLTA4xgFUztmkDmo/mGl1/o=;
        b=a9KnRWKiANLS9saTx1mCXdXXO8h6bVAT0H5W0ZFSLQQuCJ6EcHkxCZ+iw0UsIq3VGY
         WWbVLhbwaJYQGU+ahBtrsSxuhP7gU9UZuFozXRyDBk9IS4BQVIQ8n84OAcF3AH+Zw2f9
         hoDrDsIrWMRFUAAoNfxl78BBDMUFBxuGndkwuvTqiW8AcB+p0K26O0wn1+T6KzlLw85i
         Jiyh+GHwtFry6L5Pb0Rwq6NrXmkqxC2oQafzBmlsJfRKZ/JPBJv9RWPd6HR50v7H4oD7
         27Imgl5U43rFHfdSeLACkgComaXzQ8DfrT4w4I0DmUaWrN6EU1g22GKvqn5jCWjAApuc
         SauQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgEdheIeMqgL8ojNOu2o8u/0v2ChqIMH/eKWp3DAdcQPEbrNq+T+ykhh6utar6AJtCIXIbLEuXC82yPVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITKcVxHXXoF7k1BIw7spdHp8Yv2E8a2yEc+I64doUYTE5VGf6
	WVCJ9QhQq9gqND1mH9JYssgFcR5UjaA7qywkq6si1daqVV12/WBGm5OSq+/PdSck1kWf6/zafRR
	U5YDNDA==
X-Google-Smtp-Source: AGHT+IFtap+fr4+Z5TUcr7xFFQhU1tzpy4WJkx2mxYrVAI+LzI3svatQ+b1K0HHkEp7R38y1YEXiyA==
X-Received: by 2002:a05:6e02:1707:b0:39f:5abe:ec25 with SMTP id e9e14a558f8ab-3a375bb2a69mr9653985ab.19.1728002510778;
        Thu, 03 Oct 2024 17:41:50 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:1159:d3bc:2a5:5911:c84d:e724])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37196c0bfsm4510255ab.36.2024.10.03.17.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 17:41:50 -0700 (PDT)
Date: Thu, 3 Oct 2024 19:41:47 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: adrelanos@kicksecure.com
Subject: Investigating practicality of process memory encryption techniques
 using frozen cache and TRESOR/RamCrypt
Message-ID: <20241003194147.2566a393@kf-ir16>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I am currently helping with software development for the Kicksecure and
Whonix projects, which are heavily focused on privacy and security. One
of the goals we'd like to achieve is making it possible to securely run
virtual machines on x86_64-architecture cloud servers in a manner
resistant to cold-boot attacks, without relying on technology such as
Intel SGX and TDX or AMD SEV that requires trusting CPU-vendor-provided
code, keys, etc.

The two main technologies we're looking into for this purpose are
TRESOR[1] and RamCrypt[2]. TRESOR is a full disk encryption mechanism
that stores all disk encryption keys in CPU registers, such that the
key is never[3] stored in RAM. If used on the hardware of a VM host,
this would prevent a cold-boot attack from finding the disk encryption
key. RamCrypt is a full memory encryption mechanism that uses the same
technique as TRESOR to hide an encryption key inside the CPU, using it
to transparently encrypt and decrypt the memory of running applications
using memory paging techniques. Both of them have working
proof-of-concept implementations described in the linked papers. Our
hope is to eventually get fully functional, production-ready TRESOR and
RamCrypt implementations created and upstreamed into the Linux kernel.
For the avoidance of doubt, I am not the author of or a contributor to
either TRESOR or RamCrypt. We are aware that neither of these solutions
will offer guest protection from a malicious host, right now the
primary goal is avoidance of cold-boot attacks.

One issue we have with RamCrypt is that it leaves part of a protected
process's memory unencrypted in RAM as necessary. By default, up to
four 4k pages of RAM are unencrypted at a time, with new pages being
decrypted and older ones being encrypted transparently as needed. This
has the serious disadvantage of making a cold-boot attack potentially
successful, even if it is statistically unlikely to work. The chances
of a successful attack against RamCrypt are non-negligible - the
RamCrypt paper shows that a RamCrypt-protected nginx instance left a
critical encryption key exposed in RAM 3% of the time in their test
scenarios. This is worrying to us, and we're wondering if there is a
way to prevent this from being a problem.

Our current hope is to use a cache-as-RAM technique (similar to what is
described in the Frozen Cache[4] project) to potentially overcome this
limitation. The idea, roughly speaking, is to ensure that protected
process memory is only ever present in decrypted form in one of the CPU
caches, and is prohibited from ever touching system RAM. When a page of
memory is accessed that is encrypted, a previously decrypted page will
be encrypted, written to system RAM, then an encrypted page will be
decrypted into cache and used. Cache should be approximately as hard to
access in a cold-boot attack as registers, thus this would allow a
protected process to be immune to cold-boot attacks by never storing
any sensitive data decrypted in RAM. It appears that no-fill cache mode
could potentially be used for this purpose, though doing so without
entirely destroying system performance seems like it would be tricky
and probably require dedicating one or more CPU cores to running
"protected" software with this modified caching mode.

The high-level end goal is to allow KVM-accelerated QEMU processes to
be run encrypted via RamCrypt, with no unencrypted VM memory touching
system RAM, and with the physical machine running TRESOR to protect the
filesystem on which the VM virtual disks are stored. To begin with,
though, it would be useful to know whether it's even possible with
Linux's architecture to combine RamCrypt and no-fill cache mode to
transparently encrypt a process's memory without exposing it decrypted
in RAM. Some advice on how to go about implementing something along
these lines would also be welcome, so that we can implement it in a way
that is most likely to be accepted into the upstream kernel.

Thanks for taking the time to read this, and have a great day!

[1] https://faui1-files.cs.fau.de/filepool/projects/tresor/tresor.pdf
[2] https://faui1-files.cs.fau.de/filepool/projects/ramcrypt/ramcrypt.pdf
[3] Well, almost never - the key is briefly stored in RAM when read
from whatever device provides it, but it is immediately expunged from
RAM thereafter.
[4] https://frozencache.blogspot.com/

