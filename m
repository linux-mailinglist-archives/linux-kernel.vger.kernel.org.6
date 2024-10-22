Return-Path: <linux-kernel+bounces-375439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604889A95E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3633EB22D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE6143C63;
	Tue, 22 Oct 2024 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq2pT0t7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A880141987;
	Tue, 22 Oct 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562484; cv=none; b=bVuoHPRBVPK5MLql/QrziqdMjRsGunyqgWZ9MFA1CB1w80qjmkouMh68wxd72JJkI52uWuD69+i+152aTj5xUIi53oKAo4jyLYSkmyWcpKdL/4CT9hTu+syCD0wX9nLZR1kXM8uGaeE12AiulCrBh9Nz/8mBe1s7DDJyvp8E4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562484; c=relaxed/simple;
	bh=ZRiqAHnP27cfBP/NQQBM0XoZ8/zdK0SbvS6GfSDV+Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AA/de4nuZfckYF5hwoniCgSYIxVA5Br5Kh+f0+ilH1WXQ2Y7ANg7BUE/mHMdTHrZV7d8drhJhYH3PsfxJ5abZ1uAH27JT4YVmI1qTGz+VnI/E3kMDpAdgDtOpPcvpzjvly82u7CuyKN/fZYfgF4ek7X2en7Fqvu6DmXqMl5LKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq2pT0t7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20caea61132so40278925ad.2;
        Mon, 21 Oct 2024 19:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729562482; x=1730167282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPNabAA00UhSLiwzu+RL1RxmJwr1aDxxDCGsIyPJfSQ=;
        b=Oq2pT0t7Mudf2Sy3UDbw99FMxOxCaWjC7SIvDImtFlDwdfPLuVxWB/JB1p7fN4LVGS
         2cE0XX/eFMe4g+LVSAEa88r0yRAXN5nK8ji/RwMTPYByGIGvb8aYrU7i6tKdsKMDxSc7
         iC3T3Q4ovOEl6xxTaqDXtZvDmkLFk7j7If25T2Fh7zCQgEgZWIg0OTMyDyybLFhXzZcu
         iGG3Ts5EsHJ2Ty1g6POTJbsqFUkkpIvk+hMqfmTgjqlI8uj2tr1VcVyXhArS/7TgsML2
         jMDZXGELcBzD8L5ff4OGIqlvCezXZoGSeLIJT822uSFuA96CazbiUWZR+GUsL1A+Pk7Q
         jLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562482; x=1730167282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPNabAA00UhSLiwzu+RL1RxmJwr1aDxxDCGsIyPJfSQ=;
        b=wJutzgRe7Jz7W90Iv1L8RhpteLjkctTbx7PxIf7WKxPs5WXrbnabdtlJXef+AziIsx
         GWJrXWYJvNpFv7MtP6nAFpwN8HiADvfYqRA4fJv/b4LLTMB2Rz9/iMgqhLihRyr2Ra3G
         CLtpMk39CwtcO7IFFKPcqz5gzPBojuCddwjlnZ60NH1yHeyu0kW/IW4I7aIm0kcADerU
         oV3RsQWJ96UCdT4T/QriXBFTofKFaK+yNHN0u8Ap7DHWmEk5TQc40xopi1+vTrCjxDtB
         1pkcxv77XkB7M/1VmnUXgGX8hbR/EjD4KJIVn2e437uy+JMRq44felPi2rlvYVRke447
         7y0A==
X-Forwarded-Encrypted: i=1; AJvYcCU9RlrOuCIQYRr1FqcdacON39NmYv13aZIj89brslF8XfvO/ZhNIVQt5iWjbEZWF2cY5oOXoVWU2fL7YKnM@vger.kernel.org, AJvYcCXIsvwjfN0oPmB+BXZNhqvGhsQUXI+tJ295zKfuIjaxZFezH1HSIrvLZoADFzmBkmREUxSt2aOJ/65g@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8D05dvnx0Ns/iWE/owPsjSBnice6Q6Qg4mq354Ddygww2nKhI
	+Qa/f8QXqLyYbwAEBG2yHH2ZJHjPgIKj0YT2QBRImlJJm31ZWVsp
X-Google-Smtp-Source: AGHT+IGzuILj1RsrFZjoJ4dXI5tDh7XMcKK2Bx+k0YFTR77UD8om/JwzukAtT+4x7q3vK/f91G9AFw==
X-Received: by 2002:a17:903:2448:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-20e5a76137fmr161321345ad.18.1729562482111;
        Mon, 21 Oct 2024 19:01:22 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f355csm32435915ad.265.2024.10.21.19.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 19:01:21 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com,
	Chen Wang <unicornxw@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 0/1] Add power key for pioneer box
Date: Tue, 22 Oct 2024 10:01:01 +0800
Message-ID: <172956244972.305559.6733343990944223670.b4-ty@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1728350655.git.unicorn_wang@outlook.com>
References: <cover.1728350655.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Oct 2024 09:43:32 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add power key for pioneer box.
> 
> Thanks,
> Chen
> 
> [...]

Applied to for-next, thanks!

[1/1] riscv: sophgo: dts: add power key for pioneer box
      https://github.com/sophgo/linux/commit/128bded4bc5253b94c66acd63bef03f16148ae4f

Thanks,
Inochi


