Return-Path: <linux-kernel+bounces-253166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F29931DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738531C2196A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94C14386D;
	Mon, 15 Jul 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW+WpzKs"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56413D24C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086827; cv=none; b=pAagQGtwdoIpqSRVsQzbEUkkvT4LeP6Tag5I5huVg2zL8Ci8fEQngHXCLyLSZx7LW7cT3u/MvA5BKrmoWO4JScjH41UGd0G1BX4/ueAfZTcqAKlYFzAUQIz/QaLy2/brsVuIz2vc+TvTy/B2oqIs+X9a7164mzgRn/MX38eMzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086827; c=relaxed/simple;
	bh=usA5n6k0gXuWVP/H/41bPTBbmW3zA+YjMaWkJ3nuXFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ha5z+i/W1hkXB8m6U2iCZc2w425YqkAMpbZa4LAyx9OtS4t4qqZmDnSHErz1OHr4rzd9RIpRwilfENocBGVVtCjMN4WFrDyddgMUmIUoiC1/kHyMWWdrsh5Aqxv0nAPhC+66S+5grIeTj8JvktWBFu/+CNNC1BX8HKBHh94jfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW+WpzKs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eede876fccso34851121fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721086824; x=1721691624; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YRqiB3UNmNV8WA2WAD9TerTgLlRDB8kabRCeweHkYNA=;
        b=GW+WpzKsM6JUQaxFqR1Lr7dUJodyI/W42pKEORY9d0ERTYd5bZ0wYV75wsOwN5uBER
         M+nFVzhGYBt7XC+aTSLaS5cKLnPT2Q/J6WqECRrb0qqphvYkxh06lgfWW515Sc6IHVx3
         l6kZcKG0KRv+nE8vBYHo3T0ckSBn7UjOazjkZLzvwBRZg1YRP5T8HcEJ9Q/VnEjM4yyR
         aWxjn9JW5ZIk+cQLqsABdkjVifQSiQbbT6MJAwZd3TUO4mljafyRx8kWGGQs3rlu7CjS
         /xbjVNl9Wp0tJGTAmkj7GORsuqSq9PTdpShqiiSHNRkRbM1n9C76NeW2RGD+3hfDI/ct
         S/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721086824; x=1721691624;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRqiB3UNmNV8WA2WAD9TerTgLlRDB8kabRCeweHkYNA=;
        b=KIhZIrtyF8ek3+Kt04WpU7zgc3UnKFk3qWpmMTh3aqH9Q4yKkTCCOuDvEs+3nxtIaG
         /XvSCGYQjqLVRM0/4SKQJOF7dXFg1qIZEjr5H26VNgEj6qHc/opsn8yHkfGOdDBfJjUm
         6wemfqVWBRqV+9Ta91Bu0oP7JvxyHxjxPtRaucbQ6rxYbeueaPvk6jQZK4iEXmCymYpN
         WrdGloku3HkTfvfsJxn3g5a+knTqw5sMsKZRNMlagSOxzUWNhh/ul8r0KRPX24GXNbIl
         smUkjbFjulSzbpMmC/HnAVrEuLHPmG/+qp/ChdWdGaOiLa5xTkYvZe7qhUuLjkv+IZ2C
         hAuA==
X-Gm-Message-State: AOJu0YwzTzt0X+9bhPsrVf994efEQ9sUDTWZ8onqONpkvt3R6sEfYdad
	qEK/Km6RZGu/0QFH2M8cTW1/1kz3TrXbEeYjwvMQoL6kpsMIiuZi
X-Google-Smtp-Source: AGHT+IGBt4caPAcj42KqS/M8obQbmK+asdtjOdnzn3t4EvBE7Rdv1G9obJHcgi4pfnFOUgcSp5/Org==
X-Received: by 2002:a2e:be8f:0:b0:2eb:e365:f191 with SMTP id 38308e7fff4ca-2eef4173f49mr4335591fa.15.1721086823629;
        Mon, 15 Jul 2024 16:40:23 -0700 (PDT)
Received: from gmail.com (195-38-112-86.pool.digikabel.hu. [195.38.112.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276b14sm138372885e9.23.2024.07.15.16.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:40:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 16 Jul 2024 01:40:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v6.11
Message-ID: <ZpWzZC-UyVjMYjlY@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest objtool/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-07-16

   # HEAD: 8e366d83edce3065ff3372bedc281c5e217c0550 objtool/x86: objtool can confuse memory and stack access

Objtool changes for v6.11:

 - Fix bug that caused objtool to confuse certain memory ops
   added by KASAN instrumentation as stack accesses

 - Various faddr2line optimizations

 - Improve error messages

 Thanks,

	Ingo

------------------>
Alexandre Chartre (1):
      objtool/x86: objtool can confuse memory and stack access

Brian Johannesmeyer (7):
      scripts/faddr2line: Reduce number of readelf calls to three
      scripts/faddr2line: Combine three readelf calls into one
      scripts/faddr2line: Check vmlinux only once
      scripts/faddr2line: Pass --addresses argument to addr2line
      scripts/faddr2line: Invoke addr2line as a single long-running process
      scripts/faddr2line: Remove call to addr2line from find_dir_prefix()
      scripts/faddr2line: Check only two symbols when calculating symbol size

Siddh Raman Pant (1):
      objtool: Use "action" in error message to be consistent with help


 scripts/faddr2line              | 110 ++++++++++++++++++++++++++++++----------
 tools/objtool/arch/x86/decode.c |   8 ++-
 tools/objtool/builtin-check.c   |   4 +-
 3 files changed, 93 insertions(+), 29 deletions(-)

