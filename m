Return-Path: <linux-kernel+bounces-182806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74008C901C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 11:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF04281289
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BF17BBE;
	Sat, 18 May 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A94ODE2F"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDED1754B
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716023407; cv=none; b=AVfBegNO9hnuNLD12m0uV2gZUru6S+SK9kvqegBntUgj5XePTHRk34V5+NlCPEqsu6Gsq+tGvcNSbfgZch1u3zYB8V/HCXVUoQ/uU+EG5bdb7g1iLKptJWYDAsnhwdViQjtOi5IZboHrxjYbg1Qb2PSBEpvtytZXuBnHAEVUIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716023407; c=relaxed/simple;
	bh=BS0hGBTnONYffRCWVcBC/4T5eEmn6lIBz+Cc4Z0z2lw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TJ84MKF9skA+Q09GX3RlPF01HX14tt1iz6r5Q6jxK11GPWp7iF/3twv6S/+3GP6UzRU0cMBVkkGzYJlj7Gt7UA4vvGO0XMOzdZX8N4CxaYYfF8kpK3GhHYRbEdglZOQy8pO8WusmLpYzj8KJFjBOXCMl5y+NZve0PU5uo9mK1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A94ODE2F; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-574bf7ab218so6086667a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716023404; x=1716628204; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tftqzzSPEX4QSLboSaiUIFGje9Unrb+c3Yg/V8KRFkA=;
        b=A94ODE2F3XLumjTKz2eCRPYasP0ck13d8dWlQiriXcQs1523hB6f9TrCViDxuMRQv9
         y8bWwzOpY4+xMr69TwuPDBpFYAmRWikrGn7okDX4lBdPOeRIBwI8m5OT0vRxfs8G8Fm6
         Y4nQm5lAZdjmspLw2WuuEF8PmZW6TrlovlMIotts0KW3pxBb2xjaV8+rv+3LQZdlje9Q
         rKkXzm6zGb35Z8j4iyDkXwsTpu9rKqMavd5BRuwtSBnzm970Svtvec/0ilNwELv3era8
         D8acIkD5lWPQM/iSbYoXfiGZyIPcXT6FEmYcKLmdt+vrxAkZSjJ23sS+zCuA2eFvwenW
         2dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716023404; x=1716628204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tftqzzSPEX4QSLboSaiUIFGje9Unrb+c3Yg/V8KRFkA=;
        b=K9OJgwrUd66Hg1ezJBemfCrNqGH/U87ey9c5RkEk8KYRK6TL0sovRuVmd3qkpcuOse
         Ws8ln0HRFXyJONRXTWUxCG5JF8Q7m14mGz5oUGs4In9CdEFpQTyK2PEA9sS5KzmD0zg3
         jeBzg78zdds8ma2+RpcKyrSeAXLvqDsCxLIlWRaj+TEPyNLGmYpcgOA4ON748e4dCzDi
         DykjHzvS1hgfiafZKy7dKt5HOLPXz/24ud9lOVWZIeGXwFDLK87JRx7udqppX/42dHar
         amxyupQ3U5GdBAbT6Hp3G2DWiKfjCobh6MaKAS36ueYJy8TqDZ78fYTbMLYuU+xOsQXR
         N43w==
X-Gm-Message-State: AOJu0Yw6LO+I1BdFFqIQjd4qNfn4sPRX8jtVJBVZK4RUdr/pSQXOxFSi
	cFDSYwQw9jXipUlbcHoQf1UaqW2/gJ/RjBSzDlqiK0HV/zUmzyca
X-Google-Smtp-Source: AGHT+IH4ZpdvzcHnT2cGokneLZThjNR/YyP3FyAAYkYYgeMtpOqpJcVZ5AJnrRQONG0Lk1JcPDt3Sg==
X-Received: by 2002:a50:9e6d:0:b0:572:9f60:783d with SMTP id 4fb4d7f45d1cf-5734d6f3366mr14919914a12.36.1716023403547;
        Sat, 18 May 2024 02:10:03 -0700 (PDT)
Received: from gmail.com (1F2EF1AE.unconfigured.pool.telekom.hu. [31.46.241.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm4922597a12.82.2024.05.18.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 02:10:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 18 May 2024 11:10:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZkhwaJk7MwLXbtqF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-18

   # HEAD: 9dba9c67e52dbe0978c0e86c994891eba480adf0 x86/alternatives: Use the correct length when optimizing NOPs

Miscellaneous fixes:

 - Fix a NOP-patching bug that resulted in valid
   but suboptimal NOP sequences in certain cases.

 - Fix build warnings related to fall-through control flow

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/boot: Add a fallthrough annotation

Borislav Petkov (AMD) (1):
      x86/alternatives: Use the correct length when optimizing NOPs

Nathan Chancellor (1):
      x86/boot: Address clang -Wimplicit-fallthrough in vsprintf()


 arch/x86/boot/Makefile        | 1 +
 arch/x86/boot/printf.c        | 3 +++
 arch/x86/kernel/alternative.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

