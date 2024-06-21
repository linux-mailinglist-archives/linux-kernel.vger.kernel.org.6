Return-Path: <linux-kernel+bounces-224724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCC3912611
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923151C25849
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F0154C17;
	Fri, 21 Jun 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iaa+78pd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03244153BF0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974488; cv=none; b=TDw/JSMQAKZMbQJsZq4lsLtvqzrHM+nyT97J7rUGHQJeCAAhvEB/9UEUiHR6Wj8t5mX87em6yEYUYoX0PW6gMQwT0ucWMNBESGhU5FSnnGSfG+ht4AnAPM/n1yf7DSoIg8YPcluCGbijRZqunXcQuqM/SfzpKVRPNsxrd+BdqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974488; c=relaxed/simple;
	bh=XhaE0UonXFTQqvoORdhHbvrZwdu2mt9xm+V8VnQj45s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqgc4XKzjHhERQewZOTdMjW86uHWO9wXEuSCWdT3/2MwMSexBwN1/tngnw8CnyQtrvLC5l9fwTICc7sc9ybT3odgXoE+lm1rhxrBzhnynxtQjgce584oEbYauwxwXPI8Eqa5IqE4ETT8vbvrk3VxKg/NBMhYAoECaS6foVcEdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iaa+78pd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso238220266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718974485; x=1719579285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pdAHYvPgJox9jkhPwVxoz1/7COjSpOxiTtk8uybQTs=;
        b=iaa+78pdNa4dXyhDM6AM64vu5R1vMdhnOqLHu89B34q3zzrXZFwgu8OISnpMCiRrfQ
         TJAzE52mDok1RobCy0nCDjRRorGpRyff9WiE3UwwX5LhQwdX0c90qUnJlh7WTCpEJZJP
         ua3O3JvfIqpVcoEafkInfWI/mU6dwPBTMriU+Tw6JVLKONBLtG+QBWvPVxH1RxjsTERt
         dZLgraDNmuPrWBZl9VSaqS2N9bpCersTsfDyf5GY2ySACdSolfV5s+jMjhtYoBI2QXJJ
         wPz6v42Ss4uEtqRtKm+YAvXdzt4XN4ybnVJcMHCeVIG81NYgdejMZgRCvoD4kMplKQkX
         t0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974485; x=1719579285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pdAHYvPgJox9jkhPwVxoz1/7COjSpOxiTtk8uybQTs=;
        b=eRcdk7tKCV7KNRUBMH1dp//WOAeouk06AdtHbRpP/SeRmlEJM73UfdanVi6KCauMxN
         EGfG5X67tAVUzntb5Tq3sC+eLIv0yFACHkrhFwR76ZBxOvGPzlbrFotQ2R+qPV06pf9D
         ZfXShTRMR+z6pOGN9DTG7Lni6zTWHdMC2SWKY3R6/blTxGdAQbO8wZxddLt73V9G1IHR
         mNbKR8rDB+3t5IOgNKbOoF69djOEvQ8f1M2QNIa0rY6ZaOdHYHiKa1TYGkjEuj394vQm
         dBZiA57CqHcqECXu2vEZG2j7LxU8J+8Zx2lmvD7Ws4sTijc/yI8X2gCprLHFuMARPOPS
         eYGA==
X-Forwarded-Encrypted: i=1; AJvYcCULNy0vsDWt8OYa3H/A7yXLK5Ey9WJKtaOdKala/YQO5+xeL8FrBi00NK2FM69kkVYCeqJ+y8R8r61xrZT7DZCD6ZeX4sHvMKJM4W6+
X-Gm-Message-State: AOJu0Yx+sECdkRb30twxPLUiAqBJFSyIRONJvuLs2ivNTe8nNmf6E9+e
	gd0QmvDliPRkTigmSDIahQ04cUjNG/9XgM5OhZ+KpCVRDbcvGH/kpIxalsZ4u+A=
X-Google-Smtp-Source: AGHT+IGFcCABfPYqsys42451Qj6cmv21K8Gwfng8gQ+7KFppyVnCcWUkFYP647Twsv0fwN+Pc6fn2g==
X-Received: by 2002:a17:907:a19d:b0:a6e:fe97:b33a with SMTP id a640c23a62f3a-a6fab62f6b5mr470525766b.29.1718974484985;
        Fri, 21 Jun 2024 05:54:44 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b4c7sm81900066b.86.2024.06.21.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:54:44 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:54:43 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v2 0/3] riscv: Per-thread envcfg CSR support
Message-ID: <20240621-368af6395900f29559358915@orel>
References: <20240613171447.3176616-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613171447.3176616-1-samuel.holland@sifive.com>

On Thu, Jun 13, 2024 at 10:14:38AM GMT, Samuel Holland wrote:
> This series (or equivalent) is a prerequisite for both user-mode pointer
> masking and CFI support, as those are per-thread features are controlled
> by fields in the envcfg CSR. These patches are based on v1 of the
> pointer masking series[1], with significant input from both Deepak and
> Andrew. By sending this as a separate series, hopefully we can converge
> on a single implementation of this functionality.
> 
> [1]: https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/
> 
> Changes in v2:
>  - Rebase on riscv/linux.git for-next
> 
> Samuel Holland (3):
>   riscv: Enable cbo.zero only when all harts support Zicboz
>   riscv: Add support for per-thread envcfg CSR values
>   riscv: Call riscv_user_isa_enable() only on the boot hart
>

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

