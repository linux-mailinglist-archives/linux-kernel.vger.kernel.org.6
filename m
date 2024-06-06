Return-Path: <linux-kernel+bounces-203865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8858FE16C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7331F21BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9D3A1A8;
	Thu,  6 Jun 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/uMM51P"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728A13D2A2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663630; cv=none; b=Q8FCZzgXK2J4uUCYV8t9rRaq1PzsV/0BHumhVzaJsCf5nhL8aXjw4kN8YVw3QmphO2kjfhGxe2gkY+p2Eo3h82/Eh9ngpZPmG2FegBiNWRfvz3hkJyKceDq53aeVpeIF3h2XAojrghuRc3nnJvlG30NJLektV2QkceP1sSUKHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663630; c=relaxed/simple;
	bh=4+GXNpkwbXsJLpc8xVY8yTgjoStTH+O0MZyp2Hvlv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsi6mz0DvtGbk1y8KaTNV/C/lNe0Iue3ciReylyq1160cAZG1h7Mgzi0PHXtSxjlFkaeeff2JA4Rj4GrG7hn13L/eHjJDaRdR7y19rMPPrRatSiZAjpJuRROYnkI6drcNAwRO+hubhQQzesf2BtadbDWYVLm75BE7+TDJeSKRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/uMM51P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42155dfc484so4492415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663627; x=1718268427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJUXsnL6UHPai4KnVVu3p1CmYH/GeKyQlGOaxUYe5to=;
        b=B/uMM51PkDNQ0zpmHtw7024tbK2aP/E5kiwYScdRhlMbwWbWheqPEc2TUjk+rvoLQH
         7Wz/5TqTD3YoSKI8RzAGWJkVE50VTyedxoTCYV+qo8I/WfrmEVMbyFx35BRCORvBu9E4
         QNf/T1jrgqDUDgDMtZv2HBNav960xfC569d0LrOQjQRgY+gdyTFgYJdAOO2w+eJ9WwyT
         /W5WR5Q5vPGL78vUjXWjciauSvx753/VBf3EWLkTrDtx4jN7PBisyF9g6lPCo/zvBMi7
         BMlC4YTHvYIsd2tQzwiOlYPJnAdr3fQBapOQ6aVrdjnD05dKlq9xzSooGFdBSwEql3HK
         3fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663627; x=1718268427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJUXsnL6UHPai4KnVVu3p1CmYH/GeKyQlGOaxUYe5to=;
        b=X9VuNDzZHLR73yh3z4OT2C6hKH7ftnNsa4jxPH2uYU/OCCraMqILW84f/SwRjPrrCL
         RduZt/eEeYGwZM2cFnouj9YVOZIF6JJocmFj3+A+tf8DoBfGT3k/dtNusNhJLsulLBM+
         l+k7qrMac83Qsuej3Jqnke9mpoCv7qz9beHimW27bMksgjl+dLNS4/lTBYtqeXHLow6A
         zP+oxrDjaI+uZu2WsZaHF5ruzK8va1ZP5C7Pmg076wbWlt3ETPPru+w/pMYKRHzxhr48
         YL85hP8sBCebm/dFwrN6I3mkLXz6yDsR+a/Mx0OJjQikrmdhGA5s8np/bYNgIYY8tNYS
         Zufg==
X-Forwarded-Encrypted: i=1; AJvYcCWV6DQTpuHrEGTku25dM8jpnO9d4zEISuVahMVsjF1toJK3S/X6mCgdExmzS5nx4FWTSKN6vSrMdjAovje6C12QhROVhkErTdewwmtp
X-Gm-Message-State: AOJu0YyMtE8Yi94ZO3r5mt6mg4MfmX56bsrsM80wKOZZ+wOqy/r3WiGP
	xngVr51UfWCSwFydVo+Vyye2mUHw3N8oGzYtjoZDEB/v+T9ktTaX
X-Google-Smtp-Source: AGHT+IElIQ9OBGezmSbJprwlkilhN0h+8TtT0oi+ftGQUKPXqPpT553nJAmjNKTGPefDOoi4XtzBLg==
X-Received: by 2002:a05:600c:3d8c:b0:41b:f979:e19b with SMTP id 5b1f17b1804b1-42156354bf2mr40497715e9.39.1717663626526;
        Thu, 06 Jun 2024 01:47:06 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29a85sm975119f8f.10.2024.06.06.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:47:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Jun 2024 10:47:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 5/3] x86/fpu: Make sure x86_task_fpu() doesn't get called for
 PF_KTHREAD tasks during exit
Message-ID: <ZmF3iNHjBdllXOJf@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
 <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
 <20240605162610.GF25006@redhat.com>
 <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
 <ZmFziN0i10sILaIo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmFziN0i10sILaIo@gmail.com>

fpu__drop() calls x86_task_fpu() unconditionally, while the FPU context
area will not be present if it's the init task, and should not be in
use when it's some other type of kthread.

Return early for PF_KTHREAD tasks. The debug warning in x86_task_fpu()
will catch any kthreads attempting to use the FPU save area.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/fpu/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3223eb3dd09d..db608afa686f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -681,7 +681,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
  */
 void fpu__drop(struct task_struct *tsk)
 {
-	struct fpu *fpu = x86_task_fpu(tsk);
+	struct fpu *fpu;
+
+	/* PF_KTHREAD tasks do not use the FPU context area: */
+	if (tsk->flags & PF_KTHREAD)
+		return;
+
+	fpu = x86_task_fpu(tsk);
 
 	preempt_disable();
 

