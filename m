Return-Path: <linux-kernel+bounces-565124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5411A66161
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84757A6036
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC1204080;
	Mon, 17 Mar 2025 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL2WIC6D"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DE18DB1D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249927; cv=none; b=ntjTnmG221aUOAIM16fsJ4OcZcDqdrOLeS1RKuXgGYfkRKwwpphxlQ+6azobx9GG3FqY5mGllzYD4fmnTzpvBz14ebOngNCVhsMDmOzgYWmCR+R4xpx7xpooCBCjQAZQvhO76ISNfnu7dQEVEyZ3kC76dgTjR3pKuLvracKqFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249927; c=relaxed/simple;
	bh=kPPsPbTBXtYGabTP6xCmvbUEcy7svgsAUf+e5NPVcEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NvgTTJxfhtuHBhXULydMCTnensg+Gvx4YDDevcwY31mPDfl/EhmXCudhz1Buwiz/i6Hn0ztQmvrFKrAT0/Cs/uiMdR2dKUgVU4s1DaQj51xmV9Q4e3CB/OeqhM3Veu1Hs6Cy0l0/1BUwY3PrlIy7tR7YchfjPjzZ7KLntK6Hn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL2WIC6D; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so11082923a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742249924; x=1742854724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FYSD80M/Ft4BUyVeQVkAN+ZBQjwwoQreYh98Exogres=;
        b=CL2WIC6DHyjDLW7W4skem7QAh7TS/OROWKujUy6r6ZgpxqdPh0y4d2hybxuLZLhc3t
         YrL0Ft4F8Jysw2fPlIo+eZ8iWeWz7bysZxHJzbE+URLm5mRNOslvNGzcxvHqVa3HfirL
         ukNWwg3wR5J1bWcQm9SPBlp2s6d+TAKiPNhHaVsXNLFmOnrUYx076EGOqbKEMv5Niw1K
         /MB2FHRS60Pvd25lzA/WYeJL1ea9YsDG4hweGMzznB8NzHjXsCFDmKfLCTFAIoDbrJM0
         do2DGrzy581ip0VFI02HEevKjlwZWayc0eMUTNt/T4p1wHjUjzBPLwgKCEI46xfkoo5T
         ulgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249924; x=1742854724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYSD80M/Ft4BUyVeQVkAN+ZBQjwwoQreYh98Exogres=;
        b=BYHWyFMzbSLSZJSkW1qwlBlXMN8UrV7JN3+3MSfyiymuTBBNK6IkbSF5Ox+U3uo9W/
         muqSEoBryicAQRm1vrFIrLhCh/Su7/Y/Vw/o9onyo9+mqA8rKNkqTFur3jEJvyIessLp
         ZWJq9gX/PxVnY+EMckqsrJPBh+EERY8PFZdCPQ32Ha7lL4mayo52FvtH+y7FeyJmMRCf
         k6KISMZF8TINpbKYk6o/1Q5QCsU2hyrijbPLNnVYubxKHa86LyI5csJaQV/ULUZMQnUi
         Ie8/gndNc+7jBOORl263psWJmOKElmbSl9g7RxNUy2BzCY+E0zomMIwZcR7Gjy4fig+5
         VaIQ==
X-Gm-Message-State: AOJu0YzHEIAXKX6v56/CyiVG788amG1nSHvL1AfBAYqWIve1CyUq62ew
	wJzgjPDJjiWok8BvZc5cJms92O+aNoc5b/E+pkNzmMjJrvmzpjDcPXSQ/yZ/
X-Gm-Gg: ASbGnctGGbZEDGSiNXj8h9e94er7PuZrLu3i5Mq4RC/DlM8mL/egaZ5gbPGhAToFaFZ
	VLwBIRZg3VWSlxqZDiNyq78huAiUnZk+rUj40PO9Ex3Plo2CMiAh/WjbI9ywtDzDYYxAQE66ah+
	BSk6xlrlz4Opb6S4SUIkpeaoamz1TXyLrHTfnUMTwmQec5iDzCfSsFESGTDNvVr0nfgZ7Mi/v1F
	MqO8+/ufYoHPlPjQCi6A4iYlL/Vcy3ujZ8an88nMrKF8HqFiKe5gh9K1c2zbuNqnLGb7wqD0sW9
	n5G2Rh/xT4d4dqxucL+0K9fluTqCdZYlTHRoQ/KTbnitrjY9GiIcpaWFQ/2MhQUX+FW9IriupLB
	M
X-Google-Smtp-Source: AGHT+IE/VfwrDS+lGI9he1Oj+9qdrVBgXIIwEKb0ympfC3r3Hy+/twhMGl9635Eida4wQca32ejv/Q==
X-Received: by 2002:a17:907:d58b:b0:ac3:25ea:822 with SMTP id a640c23a62f3a-ac38f6dc09amr110078166b.4.1742249923770;
        Mon, 17 Mar 2025 15:18:43 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a481absm727454966b.155.2025.03.17.15.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:18:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and <asm/cpuid/api.h> and clean them up
Date: Mon, 17 Mar 2025 23:18:19 +0100
Message-ID: <20250317221824.3738853-1-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains Ahmed S. Darwish's splitting up of <asm/cpuid.h>
into <asm/cpuid/types.h> and <asm/cpuid/api.h>, followed by a couple
of cleanups that create a more maintainable base.

Thanks,

	Ingo

================>
Ahmed S. Darwish (1):
  x86/cpuid: Refactor <asm/cpuid.h>

Ingo Molnar (4):
  x86/cpuid: Clean up <asm/cpuid/types.h>
  x86/cpuid: Clean up <asm/cpuid/api.h>
  x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
  x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>

 arch/x86/include/asm/cpuid.h       | 217 +--------------------------------------------------------
 arch/x86/include/asm/cpuid/api.h   | 210 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h |  32 +++++++++
 3 files changed, 243 insertions(+), 216 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/api.h
 create mode 100644 arch/x86/include/asm/cpuid/types.h

-- 
2.45.2


