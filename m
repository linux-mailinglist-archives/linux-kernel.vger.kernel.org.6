Return-Path: <linux-kernel+bounces-177265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4598C3C27
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B11F21A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF0146A96;
	Mon, 13 May 2024 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoSll/2l"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1B52F9B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585714; cv=none; b=MS5R9cgY5LrIHhtvA/fhBNBsWYkU+sChOFr0IJJqliCIr6OuKgorVKB2FqoCpOpY8UzWZCCnyBJX0PwFn1UjwLz0RRRkpFMFppEi1D1rDeSCAxQlbRDJSSl4X3sza/VIVlCxOje5Lwp6Pvio/9ZwGWZD9IrHJwZVUqzA1g3UJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585714; c=relaxed/simple;
	bh=s8eVM+TDS1k56D3VmNLq31/MNPVBkY+NNnsrIQj5sfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZYgRRdS9EfBYeRaoY/ilaloLjmw02iH+nv9ukZujV7RVpRN9/pvPUdf944Y41ZaSaGAfMq2I8VuYDR5uhdvmyW5ZEtderADJ9US4VYdRv8jBkMwCkFQvpfTjr80fCi8ZXDp4x1gsqhgF4aLRmXCBIkrNh4xuyKJviaIGhI0kkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoSll/2l; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f45104ef0so4177721e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585711; x=1716190511; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac8lTq57pXwm0vrxrk5jAgEuyndIlwiqKJ59qUYGLwI=;
        b=MoSll/2lmFNaW9OXYwWOSzWJlDPotFc4hkCe4nRy3kOM019et0wwbRJkajy8FOAphX
         D0wrD+Q0SW9vIGQNNYKbPejus2kYAUmMjZlli4b3x4OzIWdlpZumj3FA++sDe6xeP3bD
         btsTy3qi+BDxxbnTymoTE6o363XbWG75PofAUS0K3fXQOwF+rzj9iUacUIyFW/jKSBCN
         hWEn/21Kjhe7AonwzmAUQR34aVqWMoIPc3gk3EL8ntpgf5wRjzKelcMlelOZESJ+kVYx
         muIK0+ZRzuAu7jf2Ir9fw4Gftlv7lyATFgQWK/TgJUH7DMTvA4+SY5rjOt8rFFZhLrYd
         OAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585711; x=1716190511;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ac8lTq57pXwm0vrxrk5jAgEuyndIlwiqKJ59qUYGLwI=;
        b=BSPPZeCvw2cJjAkfrsf68biAi9MrWJjdFCZeauvFasaThSoZkHrKzwNDU2GBXOmClo
         Cc9myiBbNJTBnKRpYkuNHomjtIW+E7XL+mN8mIb0BBt7UdjU4zW8RZZlVjdJjm70RPaw
         ob7aVLc+TIbrKZWu88ABnQIJI31hLoBFcNpoiEAcMI7ZkwvYEgSjaEBLkBT26g79joyi
         uLsLvMoIydNKehHCjuGmAFr4mN1C90vHptHTa7LoFgbRB5Ni66JZSdy3+n6epP5gel8M
         LPyNFdBw1Hbrq/cbquVN0MjIKzfw254xnTyjV5KlA7whQ6ALkR67GBgadx6AkFd0kGpQ
         h1GA==
X-Gm-Message-State: AOJu0Yx+Jd7QXGLuWPlnDr0mbsYTM0KJe9H8DHbL+7E7cj8mwYvWAoSK
	b1IkdxCX9nhSjR9S3cN7j9OAINYC3NVimMe2zpbAqAKOHuuh1a1qL4x3rBoQ
X-Google-Smtp-Source: AGHT+IEWRx6/HUIUQKjfBkAjNojPpnvP6RBczo2JgHs/0ldEIcOS7bI4HQM9AQgiCclezwx74sPpIA==
X-Received: by 2002:ac2:57c7:0:b0:516:d692:5e0b with SMTP id 2adb3069b0e04-5220fe7997fmr4001004e87.54.1715585710926;
        Mon, 13 May 2024 00:35:10 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7e25sm5771212a12.61.2024.05.13.00.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:35:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 09:35:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] x86/entry change for v6.10
Message-ID: <ZkHCrJYrQuGMh3PS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/entry Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-05-13

   # HEAD: b767fe5de0b4a5057b070d8cdefdcf6740733d6e x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S

Merge thunk_64.S and thunk_32.S into thunk.S.

 Thanks,

	Ingo

------------------>
Lai Jiangshan (1):
      x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S


 arch/x86/entry/Makefile                |  2 +-
 arch/x86/entry/{thunk_64.S => thunk.S} |  0
 arch/x86/entry/thunk_32.S              | 18 ------------------
 3 files changed, 1 insertion(+), 19 deletions(-)
 rename arch/x86/entry/{thunk_64.S => thunk.S} (100%)
 delete mode 100644 arch/x86/entry/thunk_32.S

