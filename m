Return-Path: <linux-kernel+bounces-206936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B266901008
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372AAB236B9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF34F20C;
	Sat,  8 Jun 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqwxI62p"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8C610C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717832825; cv=none; b=ojFzTHgXqm8jC1l7xjpRSCW7BWFHKvQw7OdMnZx+ov+PBq/gHZF9sShGLPf0YJPzoBKS6UcvsV5PP5HtIY4vY9Q5YiJXMPSHqyKhtQjirGMNskgqx5yplv8ot3HwWBZVnkdJiC5McCmZMAm6wShudpB5mwRrQGILhX18GLigMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717832825; c=relaxed/simple;
	bh=gVDrztmJdahSzu8wPuo0l+SbQvznzoielTJwCFk2C8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fc4a4cIXbVSWTrjeCbTwCUA3GWOlDT7TueYNT/5VLaQz8Jrq6MG0XIPoT0Dek8tdsMzc7yFKvqAWL0gp89mgl/1qePgux6VTPv5WaAT+QBNu/mRVXclIRXDpfop+oh/30dh3SdsrambLppoVv3CYFm/IcWqagm4CSq/YXw46fQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqwxI62p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so3277285a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717832822; x=1718437622; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vj0YCvAtmcOxb4pfXz7wbHsH3A3TClO1n/6FxRDBYIs=;
        b=BqwxI62pjkYAmf06P+PZlbZ9LpL7DBN/kHeRAq0PmuBp/Bb6eF1dfrTfmlFldYcpjC
         fv2MqaC0UuVv9pnIpNJopfog6Sst6uKj/a5rz++IZPbBeV/zqv3qhWX+iDLUaepsheUf
         SKJYRPcmWUHTtfdVrDe1/BzZmiMhduCqhgQnItHWUoj8kKsuulFhNE43ovjzNliQquJs
         lU6y3TmoCZlJtPe9+LRkrR7CICGetxcJPIsMo2LseMg18u3BBKzpow/MoAXb3sZoYsB1
         ZTlLhlFJCdVmRPHDH76hvKu/MQg28Rr5EiNeLdiuDk2jaMzHXP6wtnuN10aBiyFTto9M
         DoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717832822; x=1718437622;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vj0YCvAtmcOxb4pfXz7wbHsH3A3TClO1n/6FxRDBYIs=;
        b=RwtDAPExt7uKxFlQKe09wucdUeWtaPd612LcQQeSjpq2sRsPD+wADev7GqlWoo/YK2
         0Q1uNcNGlfEzBtbwe06GPA+dL6UPo1Ll8Qo85Bv4RanIGp8Gkm5MhONFTIZZXm/imRiN
         Cb4cgRBGAimXHEDaVVoi92INncE0IBF+u2JG+cEj+szTt4nyhpDL/qM+Mp+P4DOKOb9z
         rIZp3NPpgm1ob821BvWoX91yjJN50bG/k3jRE9kaGu5EQCLcwLHJhmWrNWn21aYOyT9C
         V5YVkcDQfkz1/aBEv//ckJ7QetoWH/CoGJHtKtF8KplQE8D/ioQt51tF/QSc0nOJFIG1
         3Jzg==
X-Gm-Message-State: AOJu0YwtRNy2ZNKMtxObtZOiBFOi+QNMNlxgO/HhyYcQrN0bPLBAfowK
	GqrXLJYJs0DdYUBkXaxyPgCycxz7BBXWHUT8PtnKd1ScPJb3Kr2T
X-Google-Smtp-Source: AGHT+IH8uyHEby49kKpXl2BfkhsKe1dgLeuoVKoDxXdp3K4tdLZP5Xah7GoSI47xePbzCyHtBD6NzQ==
X-Received: by 2002:a17:906:2894:b0:a6f:cae:b145 with SMTP id a640c23a62f3a-a6f0caeb6bdmr29122866b.5.1717832821693;
        Sat, 08 Jun 2024 00:47:01 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c86d342c0sm308508366b.179.2024.06.08.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:47:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 8 Jun 2024 09:46:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZmQMczclwLdB9sEP@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-08

   # HEAD: c625dabbf1c4a8e77e4734014f2fde7aa9071a1f x86/amd_nb: Check for invalid SMN reads

Miscellaneous fixes:

 - Fix kexec() crash if call depth tracking is enabled

 - Fix SMN reads on inaccessible registers on certain AMD systems

 Thanks,

	Ingo

------------------>
David Kaplan (1):
      x86/kexec: Fix bug with call depth tracking

Yazen Ghannam (1):
      x86/amd_nb: Check for invalid SMN reads


 arch/x86/kernel/amd_nb.c           |  9 ++++++++-
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

