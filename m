Return-Path: <linux-kernel+bounces-206937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66054901009
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5273D1C21135
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADEA54277;
	Sat,  8 Jun 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWuoVi+A"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC24610C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717833139; cv=none; b=GZ5fuNWdFWIZiitgiCbU0GrdvrGz6EJgo6MCNVyL3JojAW0e1GfMBFVnLB/Udc+olAWTEBteBGeeIx71Cd2EIqfOaABobTVWPkOX3RTwqNgB4vRos2tVjOi2XEFOIANqASyIcY0uhbKmYXyxGt9Uj76CZ/q3MrS34m4Uu2u4HXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717833139; c=relaxed/simple;
	bh=xUruPsOvkv5qnjLO4zGfkhQrpEuCZ349fRkdtpWARhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kud9KvPR6pS8RRrDQOCZTvjTRBjWlgZKnc+fLyx/J+af1qFfzU4I51xnix29I0/2avLbyXNAhXS5oc/pADRAQbhJ/bcohlspTo1Tiwyss6bfDxsWdUKVyj6af7s/3oAvSf4qk2F+MZk6g5Z/OPBkEUdNKyPez6MekxZb6oQD9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWuoVi+A; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e724bc466fso35243661fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717833136; x=1718437936; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XCUIjEdPj9yYcl7NxFSdYm2hn3adtyr7c/0+/hBZR3M=;
        b=NWuoVi+Adc2c4h5EG6Z/gbyxRYrL9yxg9mTXSaBYYaMm/cBeqSB/1SmP2Nk3nrFFWT
         78lgIAhH+YZfZcVbnOpS9hvYcYaQ3gtGMeJMSCKfIHzd1fMpj2kFXFA+m13nnh3NaHYo
         rUYxfCkcbZuQaZIqdrjEsfosYk6KfBZH5ff8QngVFthbKognarRbLUnEk5/h+xm9Bgd7
         +/PAKKjKerlJW07jJtt4WsLen0QEqbDTCFpwGAn1s9ZtjQ7lALW4xDXfVN53zoDCxua1
         LP5qMCnd4/imFeLioaEbo/XU+Qeve2KV4LNUxn2OaO9lh0qcGn3uj5bl/X3a4Jr1gW+H
         f3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717833136; x=1718437936;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCUIjEdPj9yYcl7NxFSdYm2hn3adtyr7c/0+/hBZR3M=;
        b=l7gVd8DiNNv4f0G6jKG6yxT1XnUoNvgrn0iDoTBaqfoCHRjpruJgLZ7exdRSFE1X6Y
         bLbRu8CI7ielVqjMJ4TvdN7VeB/eDIUboGUhyYH+URlkdvIdT+8Ricl6BaDD4eB9uS4P
         ODjpjLVF2r0PAjYgNkSxWathsCpTNgcaKpPJn7f8rgoXUTFofzRf1h+KRiutjzgG17xj
         +4c7CYqz2btPw7AMWnRgL0dWKmqYf2SzWe+xtFdVIusxtHwexWed35OwTw9HrSSW3Ybg
         f/fvX0w6Ij+O3Zlakf0Tnvmyyco60PzAzGX8isdncItXURUheVqhfyq1VvdeGEd0xxez
         IVkw==
X-Gm-Message-State: AOJu0YzNCvFbccuht6M++j2qTaebFQyEv7rmLlr55zkkYqCWpVSrxcah
	calLirxH3zDu7aPofXgGcboMHvq2dUVi7JpSbRkesFYXkcIQaDqE
X-Google-Smtp-Source: AGHT+IGBt1m8qQ3ir7nXwAlrCMp0fF0Vt9IjGdB4YJ2l7rK7GM9qrjJZTftqpK47r205oVrhe73c1w==
X-Received: by 2002:a2e:3502:0:b0:2eb:d696:4b80 with SMTP id 38308e7fff4ca-2ebd6965d7bmr6260671fa.52.1717833135714;
        Sat, 08 Jun 2024 00:52:15 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2323f7sm3886993a12.85.2024.06.08.00.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:52:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 8 Jun 2024 09:52:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <ZmQNrYML8WUnkBYv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest irq/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-06-08

   # HEAD: b97e8a2f7130a4b30d1502003095833d16c028b3 irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()

Miscellaneous fixes:

 - Fix possible memory leak the riscv-intc irqchip driver load failures

 - Fix boot crash in the sifive-plic irqchip driver caused by recently
   changed boot initialization order

 - Fix race condition in the gic-v3-its irqchip driver

 Thanks,

	Ingo

------------------>
Hagar Hemdan (1):
      irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()

Samuel Holland (1):
      irqchip/sifive-plic: Chain to parent IRQ after handlers are ready

Sunil V L (1):
      irqchip/riscv-intc: Prevent memory leak when riscv_intc_init_common() fails


 drivers/irqchip/irq-gic-v3-its.c  | 44 +++++++++++----------------------------
 drivers/irqchip/irq-riscv-intc.c  |  9 ++++++--
 drivers/irqchip/irq-sifive-plic.c | 34 +++++++++++++++---------------
 3 files changed, 36 insertions(+), 51 deletions(-)

