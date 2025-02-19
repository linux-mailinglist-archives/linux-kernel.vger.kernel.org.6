Return-Path: <linux-kernel+bounces-520790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A9A3AF42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F178188B0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA27081D;
	Wed, 19 Feb 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg5/jUfE"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE02AD0C;
	Wed, 19 Feb 2025 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930558; cv=none; b=LFyWim/pI3ffPP60Q+2A8G7QuOQzZ18+c5hWF9IrNclAlbXugDXorC9fOh96VN80+2P7Tx3cS0Ay0JiA1mVrA8rTdCgkhujGNaO3nAJk/Jk7Wcuevg3fCeOgb+feM24/izBNaTnOPvqDQkk9q2OidyIwOmJpmQ4LT4YElecqaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930558; c=relaxed/simple;
	bh=tSVYR1llQvTI5Kv99pwKgISlYZrlOljaKobqaa3fY8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA9R7kUdDeoGUiHLTlrRcB5CGnFKPZA7qnHhr5jQQ5UEG4fT7MpDssn3Np2tseLKsKxQXwX46kPrTbKzak1E2hMKkQ7Z2YUiC2BMFLlnjRqtAta4s0U1rkycn247rZPGmpBM1t1VnrWe/BjjfoGAohBoBu2EiHRfXGR4nRA9w4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg5/jUfE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd43aa1558so56487246d6.0;
        Tue, 18 Feb 2025 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739930555; x=1740535355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=980SAjG821KkBNdaRx+A15s8OgNFk4ezjXKzzUAttK8=;
        b=Eg5/jUfE+NE5zZo+10y4yc/As8NxAr9hvl+ao/gmFFSeRdbTIfC1OtOjfBzVtQJBk0
         A3tQuQNM82Lu1UMfrBvXxuKiENZwy3Uu7gZzHaDhmLI5HBrnvxS4yk31zIay7jM9QNYR
         Q05wu8sFvcvhKXwslhpf9UXNKKmOtU+DHQVyBdQDVJhzmgxlTV5rSxZ6lcLLnokyeRZU
         QHRrJ4czSqFpFGx8mI9lCx/DmP366HE57+ZdsDGkbudmuBCs81KHQ+vMnDhsL3SLYTbL
         5Z4PGirQf0/4hky5EUSqGovHkl8uNtGGmWkLYevuEEFHsvWBGEwj1XgmyAquwaYveLE5
         SoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739930555; x=1740535355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=980SAjG821KkBNdaRx+A15s8OgNFk4ezjXKzzUAttK8=;
        b=pNnxGjlbsAO7ma8TGslyfEvaJVRpBdy5ZwgsRkXXU6LEwlo9Bxow1CXhL67RK4cQy7
         mC2XEoaEAWTofJ3gNpDAV7WyLFWVrhQ0J14RGdlVVj2+jR9WV0lKHsL0va910vIBb29f
         sBB1BnTelGL2DT1WUJZpnkLmnPuKhlHzeP3tzVCSeILFDIW7F2aYEOnzM0lZC2mUvpGC
         eTyjINDk+QEj6GcUTvMObDLge2FGaLCd/iu1eyVOO0F8uiCAwU/czsdcUXDvxmvj7b94
         sWeHrVEGW9NTgV+B1027/tbajBrYd0Q0GfO5QGRkvtZqWjA3IQMSBM39m9IND4sYtV91
         qnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBPUpx6Wo/Jvg5VXRiKsJEdP3pRkpGx+RN+wnvFZl55+ZmmnHrb92mf08zrbegESIsh4cXikXRygI4@vger.kernel.org, AJvYcCWrVTyQHrKIUBDqtbm8SYzpuKvZbr1WlqCXu1vl+H6UVyNMZuPDGVuWLIe/LT+FeeUYA5xpUl8Yu54hmIJ4@vger.kernel.org
X-Gm-Message-State: AOJu0YwcomCzy//sq5s8Yk3QaB0N7YYlY82WTKdfeNJjrCLuxPDgXRDe
	WG3i5k0hGZQ2v97v5qjw0IGp9Yy/2sI3QY3Cj6PyWuu9TxtVdA+v
X-Gm-Gg: ASbGncuIOBI2wELyP32kCqMjCsP2aOGEKTSgPwAjo4JgXnC/coISfe30GTynm2cGvsT
	Z7Mj9ZPLHl6BXL5LhtpcD8LqPNGnEKR0SDXTfns0KcbNZGIT5LBja8/c7CkfajD9My7hEbG+B7O
	kgrj9HX/eAIPEa7go/GOPpiwYd/adZBzKXFcR5UIfo/TcEEmE31YEygeCQkFI0ef5ZpVPprUv82
	8RynTCQYu0jQ9qKqD7rMi7OMm1pgAvJQ2P+mr//6NniDddQvypwTSlllfZ1bfDxEn0=
X-Google-Smtp-Source: AGHT+IFao5uYt/opWCP18gBhrPbDbhzTsVioAhM4PEXmi9PCMUnZww8XRVKOU3gkOFPTX9L4VDhHrw==
X-Received: by 2002:ad4:5f0a:0:b0:6d3:fa03:23f1 with SMTP id 6a1803df08f44-6e66ccc1141mr227209846d6.13.1739930555333;
        Tue, 18 Feb 2025 18:02:35 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e67ac30bafsm32452896d6.111.2025.02.18.18.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:02:34 -0800 (PST)
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
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com,
	sophgo@lists.linux.dev,
	Chen Wang <unicornxw@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 0/2] Add pwm-fan for Milk-V Pioneer
Date: Wed, 19 Feb 2025 10:02:19 +0800
Message-ID: <173993053303.993263.3269292978255036963.b4-ty@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739351437.git.unicorn_wang@outlook.com>
References: <cover.1739351437.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 17:41:44 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Milk-V Pioneer uses fan as cooling-device, and speed of the fan is
> controlled by the first channel of pwm controller of SG2042.
> 
> This patchset depends on another patchset for the SG2042 pwm controller,
> the driver part is now on pwm/for-next [pwm-for-next] and the dts part is
> now on sophgo/for-next [sophgo-for-next]. If you want to have a test,
> you need to apply the corresponding patchset.
> 
> [...]

Applied to for-next, thanks!

[1/2] riscv: sophgo: dts: add pwm-fan for Milk-V Pioneer
      https://github.com/sophgo/linux/commit/62cdf0a06dd5a650e4ca95b6f3a13daa48cf517a
[2/2] riscv: sophgo: dts: add cooling maps for Milk-V Pioneer
      https://github.com/sophgo/linux/commit/f047a9285f9f3fd5c0d5ae53af350b8b619e470a

Thanks,
Inochi


