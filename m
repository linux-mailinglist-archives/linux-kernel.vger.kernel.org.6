Return-Path: <linux-kernel+bounces-553257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E326A5866B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28300188623F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FD1EF364;
	Sun,  9 Mar 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4gtr/9v"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F1F4F1;
	Sun,  9 Mar 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542440; cv=none; b=FM/wFHEBJmrkPRWXb+WLFxvWXTEUErWhq0yFxiIf3g3iIu/auvpCAS9He52GIBloulNN/mb+s9oYEMO++qel+VkOl07gLXqY37Es0RRbsb7BbZse2p7sKONK7GDbXUSTVPnIcD0LhVr0E0YFjEvdci6DHZMzr0TaeZKjKx4J3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542440; c=relaxed/simple;
	bh=HfqB+ra69dPFuR3ZyPW+9h+o/dVuinOJtECSahu2qbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwLtMLnRnXmXrI28KYp4OYBIXtSKwSjOK0n/JmJI8+AM/4Tyr0RIpti4nEKC7fdGUnl/whqEOktivagoesCvfOLl2bWcJv30bYxRb+0+i0NOTDEGOh8oo00A6u/hTJVMz+US2YF5xqYvREmG7U9GnQh6pVSVpSJyBL+c/O6k4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4gtr/9v; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225477548e1so15582865ad.0;
        Sun, 09 Mar 2025 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741542437; x=1742147237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW0Ijt8WDfro2KH1U/Yil1BXF8JyA3zRUqtElft2AgE=;
        b=U4gtr/9v5kgj3cdMEhvRn6bDnaEXP9lrwBRQB56kuJeoSY4BX4Wj/BQYtE+5PDm9Gv
         5q4b5brOoe+sJNtQXp68AOcYj8P1mRTJHgO1ZaLfpBRDcjmMfTQyL4z6lb90TiG/179w
         x++secvU+5aQhhSY/hsFlncVA91v/IImZ4WGXShpYO8d7qNJX9Iz4CKVVkCBmCtb8Y7g
         1ZIq/uXjpnhF7Cg91Qie/y5daWvrpMup1iFwodN3ja7rO09RHwBMeXj9V0tvlMC2k9em
         qlFRNPWM0kl+7rajVMFO5DoiWp3hrYX10ZSyOqLGoeCn9M495bSnNsgQVJvDugwAPT/q
         JbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741542437; x=1742147237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW0Ijt8WDfro2KH1U/Yil1BXF8JyA3zRUqtElft2AgE=;
        b=jC9UedmHiq3d9S1i3j8kjsdiCCWRuj9Vrc39fKvbu8rUodybA5E1XGmlOTPy+R9Bgz
         lEBV0kZ5H6A/XrfsFD0BqAOz2Cua8cNGDH4wPC+HgRj0YXaI0qXzHlZ8txWg0KKKUEGB
         mibVINChwiKfresgoD4Lu7FCPaed7Ha+nXEvb3pBXpMstlHSNymzmRsFZmFnj+EINQ2L
         OVSrG9uKBXKsQBdr1XYcIWpH8VcqD114orvJdV6WaDieYLKDouyCY18jYJXiFhIma+Dm
         ETSxeL4kHv1B02/Ygk/R2bkJB+daXOh+zIAUncqO/WJToAKfO828QTaSFrCCse8M+Fbu
         svug==
X-Forwarded-Encrypted: i=1; AJvYcCU/nzZ9fuq/EAwhzsuz8bs7QNrNYUXqCgFniVlYPPnIIDQFXpawumchKypoirow5btpowcoSxO5Wswapz6mIOo=@vger.kernel.org, AJvYcCW3wn4pPLXNxm/yUee1Nn13bMfoJz0M/IMoul0TdplW7DnfzcgLMcdk+4OPQ4j5+s1BGjJ10Ka10GjkK5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/suzOLoPjrsMiwIJLKckbfx3YH2wtmpibO9Greb88vUHhjmz
	ly7JIaviYSM/4pMz5crOJVRLmfKi6UBz9QkUvxUI6Ze5WR6xnoEp
X-Gm-Gg: ASbGncvdhNxEjaT+CbGW9E7quIQ26ikSghD9nAkWLvHyARaIXNh0X1IET/sTnV9Dd+j
	Pn3TmJsgRHH/Jh+TtekPMYpmJYfw9g0uCWiIBe52rNVBy9tPN1H9wJ1AClgQImFEcFTc5qXEyiF
	wBQKl24MrpeznjGgyFDtnwDrkPVnWgUOLxRg3W+JCloZmuyN+gWjcXaijdBCu62HjHu8yxPFWKB
	hazVOyaftjY2W2gWUnh0hwOrKjxb2abCosm7ebaW4OUaMAMXsnIcVsUNC0gbtVKLv23nW/cy6fh
	jMblXeElKFkV45QrgmOF18/Q68aGfSB0bAyUTjEngR70RDhAjw6a
X-Google-Smtp-Source: AGHT+IHxEAcPqGX8pdSGz4HO3VaYjHB80YV0+hGS1utKqObvUBBpG8rAuDg49C1i9Tu/LjKgKu460A==
X-Received: by 2002:a05:6a00:2d90:b0:736:a694:1a0c with SMTP id d2e1a72fcca58-736aab1677bmr17551539b3a.21.1741542436821;
        Sun, 09 Mar 2025 10:47:16 -0700 (PDT)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bd615191sm3210335b3a.128.2025.03.09.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:47:16 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: daniel@sedlak.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	charmitro@posteo.net,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V7 2/2] checkpatch: check format of Vec<String> in modules
Date: Sun,  9 Mar 2025 14:47:02 -0300
Message-Id: <20250309174702.844914-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d2fe8cfc-df97-4947-bcbc-7d43b5c24ecc@sedlak.dev>
References: <d2fe8cfc-df97-4947-bcbc-7d43b5c24ecc@sedlak.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Daniel Sedlak <daniel@sedlak.dev> wrote:
> ThanksSmall grammar nit. "Prefer to declare…"
Okay, I will fix this and send a v9

> Small grammar nit. Shouldn't this be rather: "Prefer to align 
> parameters" or "Prefer aligned parameters"?
"Prefere aligned parameters" seems better to me

Thanks,
Guilherme

