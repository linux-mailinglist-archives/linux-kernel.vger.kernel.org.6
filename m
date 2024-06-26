Return-Path: <linux-kernel+bounces-231527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EC919985
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F7F1C2123D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92219306C;
	Wed, 26 Jun 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rztHhcsy"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19119068E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435568; cv=none; b=iUJPst17eY5O6pL0PPoO3GQZDmIGrxtWJknU6KxIesgvdU2WTUASwIA54EhjqpkTAv8BuCaq8kg4MWCxpRBY9ampivhN8UszJyEl2X+HalHjpnyU6u2FRV5aMbyJH4mtPo75Sm/YBdnSvIbKEvuW6Bh4fE6RrDb2+QOJAmGuvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435568; c=relaxed/simple;
	bh=96OyJIYZ6kFoOzCuSrM2f3jAde8CM7fVKLs+CUWcIds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgFB9e+lAwIMRB0BGa+lUGi11DvLbrg3c27VhlL+iqOzKh+XpbC2OlqZ6UO74i28ZpA5Q4nBLHAsV28rNyG+SzYVHwuGgOBUT/xgAWSFqx1Pxg7FHt6S+pQzcJZ9wVwqemLr8xZW/K3WllVDWGSxaMtAM+srehh6XEB8pLZwB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rztHhcsy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ce655ff5bso3560950e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719435564; x=1720040364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96OyJIYZ6kFoOzCuSrM2f3jAde8CM7fVKLs+CUWcIds=;
        b=rztHhcsy7kUte8qqkML8duOeT30Dlagbumywmt16zv1Eq1EVSsgBQruMKWMNLiINqP
         3e/9Zfb+oc2PyqTR1gnHHdbQhjDQqJ4O09gP2vmxktuQpEV+8omUmV6p0KSzgAT0Be1o
         6mzh681TD4UJkm2Aqwr6a8y5ByiSHc855b3gVCGDLBiBKkGnO4aPImyXo5B19g4vDQk/
         d8lWz3RtgXyZZXnqh6P3GVROqhBgFAOKyfvq/f0Gcun2/5sbQvNgTvXh3MvgOzDgxISi
         rX3NKEjyrdi2/4SH05ViekjQCR2+pNu2KN4A/wbZvn68DSKgnRXEOLgBvcgH/iWDqz2L
         djLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719435564; x=1720040364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96OyJIYZ6kFoOzCuSrM2f3jAde8CM7fVKLs+CUWcIds=;
        b=AaYbEXoOtlEBaR1bzZpOOV+Npysq4foY9kmyX/OS8i39ZbsAt+UIRV23j3WzRLcOzp
         ocxKZiJ25YMmKjbVW/hDLq94HX7bQomqfpfOVPXJgd4nEKTQvThuxHrXwHDBpQQ4HLc9
         gpdnSnp1BOqXuflezIqCkmsvaBFQ76tCO3dNcobRyFUH8jK5/ES1lbtoVO2atiQVMaWU
         P7UqHkfm1bwkR1xy7JKJ7+FijoNPtQiR1V3Bz8/PRDZunStEpTgxWH/iIMqpS3w7SacD
         iCVFHHWa9hcLT6Y3TQtGpltxYuiw3jf1V2r3ptwd0PMid6JmokUVBkmx5iNNG7T3QZFB
         zbsw==
X-Forwarded-Encrypted: i=1; AJvYcCXo6r2GBF0n5KTfEaacbF+/pnDXR2rt3zEd0vbygQbYAQlMBbPHNktFIEMooV3BJxREGoGi3C4zJZIS24eWs1Jzg5vSVNmZ7j2MNwqn
X-Gm-Message-State: AOJu0Yyv87xV14gWcCiikOqRVcMnkpR8U+InxUNiSQjh39wnxJj8sC53
	ab2L+Eb2HHu5ZTs9qegWrDiPYiNckQY5RdaepDBFgmMTM7D2SndVkNqUSU8I8k5gQL0JoRCEi3z
	jrJDGW+RI8Kb70ClB32/hv6EKZ53MzqFGeQA/EA==
X-Google-Smtp-Source: AGHT+IGrTd4cIzRSRIXqqDuLILkPD1S/dVkHkeQdYhChs0LMTJ+8Aq5s53BLlJ7clCzY9u+1vmR2P5wcJjkV73+JlcI=
X-Received: by 2002:a05:6512:205:b0:52c:cc38:5e1f with SMTP id
 2adb3069b0e04-52ce0641433mr8913241e87.47.1719435563137; Wed, 26 Jun 2024
 13:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406260432.6WGV2jCk-lkp@intel.com> <20240626172154.GA50752@fedora-macbook-air-m2>
In-Reply-To: <20240626172154.GA50752@fedora-macbook-air-m2>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 22:59:11 +0200
Message-ID: <CACRpkdaXd1sosdWzWOpbtin1h2NFS88Dc3ZfXhyix+t1uC1L8A@mail.gmail.com>
Subject: Re: arch/arm/mm/proc.c:82:6: error: conflicting types for 'cpu_arm920_reset'
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:21=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:

> Hmmm, it seems like the prototypes of the reset functions in
> arch/arm/mm/proc.c are incorrect? This builds for me with the original
> configuration and allmodconfig + CONFIG_CFI_CLANG=3Dy.

Incidentally I fixed it earlier today!
https://lore.kernel.org/linux-arm-kernel/20240626-arm-proto-regression-v1-1=
-089c23ea13dd@linaro.org/

I added you on Reported-by for now.

> +void cpu_arm7tdmi_reset(unsigned long addr, bool hvc) __attribute__((nor=
eturn));

The attribute is not needed on the prototype AFAICT?

Yours,
Linus Walleij

