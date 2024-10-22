Return-Path: <linux-kernel+bounces-375366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D059A950E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4022857C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C841E871;
	Tue, 22 Oct 2024 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqJW6JLB"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984917993;
	Tue, 22 Oct 2024 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557808; cv=none; b=txWSW3S0bpeuGO8vpB19ypr7rwygraGyToccjWdx0/ZfEkc7QhA5NRvsHO/6Wv8+D8rR0d+IB9a4AhR3c0mCamp5ycxEM/dKyp6WwSbeJoZYyi3DptmyC3waHW89UWUoIPNipGsAFOPivaPm+VyYqCZgGu+SuWv9gYzFC5SKfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557808; c=relaxed/simple;
	bh=bTlNqxfrs2cU2x3eIsIrMVd2Hvfp3KF090R05gwDV10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl52hGqpFXS+Umm8H8UaEzdkgm04kFG9immkP8NOwuzQlp1uQ1fdbh4pYNRffQyzLYaBa5Y3WaW8ROY7nsLoadJSqfp8a+a8sKpyZVU7Y+ChzFiqljMyZ3+OvKpdIuLlPp7fog3uP6V93j8pQG6Dx14ECnaroYrAdM6lSiWxyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqJW6JLB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso3539146a12.0;
        Mon, 21 Oct 2024 17:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729557806; x=1730162606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjUFXuysliNb6jOc1fF186zy4oPHVFc3jmgowhIzG7U=;
        b=jqJW6JLB6/XMKPBXWNoQhKpRo3L15lvkIXsqQzvDxHiJGVi9z4MRyn90ZxQ13JqR66
         jPd6VliNHcs6Dko/QpqQniU0ygQXnIeph+kDEAfaKnDvD4IRII5G6LpZYqTWnEwno/mK
         LjqqLBMpxCut3Sdgp/o2aMaIvwn0b7skFzqNiJnANElPDpOPQptRGYKMWkehCvDnLBhR
         358/Xe1J836XhhkbdWTpBLII0K/dT1q/4ECXT0tn26V2qIPkBcFkyF5JJkI65/c8AJAc
         LIHV8UmN5c+g0CWWWEzHjNY1uwdrI97xWJeBxthHK5m3lrVc5bYSUOmt2rqVtOYWCIr7
         OJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729557806; x=1730162606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjUFXuysliNb6jOc1fF186zy4oPHVFc3jmgowhIzG7U=;
        b=itw7L0ueQwcumvlhs8PWQ3tuekmxM8+lpFxSlvydYxbkKome/2QnzvBJmAR6glj+IH
         VXD8g+BwIc5JkQM8FLMAAfIDW6EtzLnAWGTUfRLqEH0C9n0o7cA+pUQB/EJA8T2fGLa9
         5zHA9Q1bYhIaBxEXUivOmxGArr4DFmcJYGuqESRFKll0+N6WQj9y0Gw8tbm03s1Z0MZz
         Pj0dC3CAl3iJXPOLfbtiKtyJp4oTLJZd8/nnWRVq6i5FsXLDJT3AZfWEyoBNnlRAi1aZ
         zAHkA3JIGT4PH2CHNP/aFwMr19Mo3A4sEVYOoL4Sz2MXUCZB5hHP26etmmGQWKsknsAE
         OVEA==
X-Forwarded-Encrypted: i=1; AJvYcCWMad+vL0T9ICOURymB85HaZujxnNSWhex8xPDwi7ac5vsP0bkI312C0aRAtEdFaYWUS4As6NbaWgVC@vger.kernel.org, AJvYcCXFG7A5STEh7rYdN/nHjIRPlBZ7N6dxp/N+wTnkXSsNh8RiUIpcxU77rbvP7+uzW96Jka5JbvIziPpqG/gI@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0YmHQUVyG1KPqGDs8IfAW6F/wxx7N3EbOBRFL5SO7IIKenKZ
	BalAa5ky6VywSvPtcDUQo6kxDWJMS0r4GoG3ORBf3N23T2gvj/Ud
X-Google-Smtp-Source: AGHT+IEq9b7KSsszMUpYsfGE1VXvTcTwMm/M8YEebR28lh04TKoLDBUZwYW1inEXr+gQf50tCmONog==
X-Received: by 2002:a05:6a21:2b02:b0:1d9:6d08:4b43 with SMTP id adf61e73a8af0-1d96d084bb3mr1244594637.22.1729557806408;
        Mon, 21 Oct 2024 17:43:26 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad517450sm4582085a91.51.2024.10.21.17.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:43:26 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	Conor Dooley <conor@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Add board support for Sipeed LicheeRV Nano
Date: Tue, 22 Oct 2024 08:43:04 +0800
Message-ID: <172955777485.235966.17744261419572259209.b4-ty@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
References: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 17:07:05 +0200, Thomas Bonnefille wrote:
> The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
> minimal device tree files for this board to make it boot to a basic
> shell.
> 
> 

Applied to for-next, thanks!

[1/2] riscv: dts: sophgo: Add initial SG2002 SoC device tree
      https://github.com/sophgo/linux/commit/93b61555f5095a44fe00df27399270867fbf278a
[2/2] riscv: dts: sophgo: Add LicheeRV Nano board device tree
      https://github.com/sophgo/linux/commit/d32552307b6c526aa75a9f9a0ea29a4a7f1746b9

Thanks,
Inochi


