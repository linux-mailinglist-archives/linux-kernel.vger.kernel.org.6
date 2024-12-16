Return-Path: <linux-kernel+bounces-447968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9B9F395B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42C916A964
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C33207669;
	Mon, 16 Dec 2024 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQjagBjI"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F4BA49
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375261; cv=none; b=b5OvjyIe0rI/aa1OlfExvASPTd00bTaxz7+ElWUaUSxRwssyjllHnvwna1fqf7mqh45EicskcxKIS3fJ7hsj0SfqXHO4yh3dHtcr3uXH+FxumYWXfdPXfd1RFzutKQIC/sK83sp3SA8xdwkXKF78D3lNd3ocJ1OR+3NrqHQ5FKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375261; c=relaxed/simple;
	bh=+CN3MFvUIjIXgzPDpt7apU1DXFBh0hoCPHWJbqmsbkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+YUCQ1tJ4EqYOZ4Q0H0wBL/drA4aTehojL7mEFXjlDQTln4TG9wD01MTRQtkE2P9b1059Mw9JT95IYVfsjHn245dwb0twQLr8UqOag+4ssbkXO9P8+aNTBLioayjRJJ2euTbE49RnenUcYRMt1hfzHWlk09aoLwu4wRxtolbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQjagBjI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e1799d95so5282275b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734375259; x=1734980059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=690bYW6+JhWBO5SGjqvjGmOT9zUI0kV2wWETtbgOT54=;
        b=gQjagBjI/x3wlc6h/IK3uQbfOn5OB0vrhoewcDgl+umH8td8XE9TUQ0kb9EhrxMpq7
         +grI9IfzB4i1aLypPDKFHQfrQRVr3lESzufxo110LfMcotqo6EZH3ggPxhE98ubROfx8
         7UaJiSjNlUA4I95WHgg7iKAedb0CJnptEEFpwTRLffzT97FbzHHEGTYoOkz6vg//Ik4R
         ImpfitT7puLDKuQqHH++rZ9UFjubK3XduhHUBM2MlwVjZswvUshsffNoChX0la4LGn0w
         5/mTBzglfN44ebL4GfHIfP/sCsc38z5qJ+21lq9PvQsp4yTDj56kuHVtfCLU7n6ZszPj
         M3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375259; x=1734980059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=690bYW6+JhWBO5SGjqvjGmOT9zUI0kV2wWETtbgOT54=;
        b=iDWjf0Ce1XDd+GjB3zTmkX/uGmFJI9iTyyALy+nVdFLz8C23WQNryWNvYnvCjartfv
         NVpTurBfaCUq8cVuvL8ISDcTvMQ7fOTUmluKkPTq4vyKxjR1OMGsxqUJ79BqnutPDIIQ
         /LwchdeBiInZJ/mYlr6/6J2WisNjFXje0tibibEr/t2g0H7w9nA2vpf3jk8thUXVawuK
         gq0lMqPjH352rx5HCgdLmtl0jFetyYlXvmX3ndtJpo1OSYlcohEzniWP08gXgd8i/zvf
         AUj5rd22xMFVaQcgL0fgI3oSSf28zZFgU/4g/7BWU1RAURW2awRtVeVmzTD14om/r2IS
         3xog==
X-Forwarded-Encrypted: i=1; AJvYcCWX+aGMClALhNZiNmEhGTXVr27PsCvCeHVz5b3m5j2ka+s7P2hYGOjXk1nlD83So8mDO+gnTeq2cKQpFvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yc6/dfcpUKIYt2cRyE1berrQ7R62QasZ5cutfg1Ff1jLQ5ht
	stDZYU/XATIk9IK2cBOoZCd9bHVJJWOrTMC1OlJma9epYNqGUEHydd47takAZw==
X-Gm-Gg: ASbGncvvkNlAeeYXFMvfCyTZktmJAyzyTWEUzaQIxCd9VaQt2Vra5pFGrkxTfUsujhi
	u4aa3fBnqkX+VB45Yv3Ofh6nhhPQ+tzmgEaAEPeFmq2WeOhzYSwKnzcn5agql8vaDmWyq/CRCL0
	9lI72Q6W2QZERXeoKc1DnNxyJqSFAzcuqhkvpgRjvtelegWq/0+JgLi1Cq+h4JaXkQdMSOLefSF
	fqoHF6dIAssLrEHViIlgF3FSaFDB8MPQF1XqwmV57OimscXtKIXqn3JpGps6usvkBR4wDaSj3+h
	HrAiLSFWiINLL4tE3KjM+WpS
X-Google-Smtp-Source: AGHT+IFLkxN//qOcEYYuBjw4V9elaQ3W3HVovjotDyIMx9yQiA5AcZ4RTDQhTqISuW2kKbScrkRKeA==
X-Received: by 2002:a05:6a21:1796:b0:1e1:9fef:e960 with SMTP id adf61e73a8af0-1e1dfc0970cmr19290101637.6.1734375258877;
        Mon, 16 Dec 2024 10:54:18 -0800 (PST)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90832sm4476417a12.11.2024.12.16.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:54:18 -0800 (PST)
Date: Mon, 16 Dec 2024 10:54:15 -0800
From: William McVicker <willmcvicker@google.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
	kernel-team@android.com, daniel.lezcano@linaro.org,
	vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: gs101: add ACPM protocol node
Message-ID: <Z2B3V78k2ibIdLYh@google.com>
References: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
 <20241212-b4-acpm-v4-upstream-dts-v2-3-91b7a6f6d0b0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-b4-acpm-v4-upstream-dts-v2-3-91b7a6f6d0b0@linaro.org>

Hi Tudor,

On 12/12/2024, Tudor Ambarus wrote:
> Add the ACPM protocol node. ACPM protocol provides interface for all
> the client drivers making use of the features offered by the
> Active Power Management (APM) module.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index 04561e15b96c..8c3f07371912 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -277,6 +277,28 @@ apm_sram: sram@2039000 {
>  		ranges = <0x0 0x0 0x2039000 0x40000>;
>  	};
>  
> +	firmware {
> +		acpm_ipc: power-management {
> +			compatible = "google,gs101-acpm-ipc";
> +			mboxes = <&ap2apm_mailbox 0 0
> +				  &ap2apm_mailbox 0 1
> +				  &ap2apm_mailbox 0 2
> +				  &ap2apm_mailbox 0 3
> +				  &ap2apm_mailbox 0 4
> +				  &ap2apm_mailbox 0 5
> +				  &ap2apm_mailbox 0 6
> +				  &ap2apm_mailbox 0 7
> +				  &ap2apm_mailbox 0 8
> +				  &ap2apm_mailbox 0 9
> +				  &ap2apm_mailbox 0 10
> +				  &ap2apm_mailbox 0 11
> +				  &ap2apm_mailbox 0 12
> +				  &ap2apm_mailbox 0 13
> +				  &ap2apm_mailbox 0 14>;
> +			shmem = <&apm_sram>;
> +		};
> +	};

You mentioned in the previous patch that "GS101 has 14 mailbox controllers",
but here you have 15 mailboxes. I looked at the downstream driver and see the
number of mailboxes is defined by the ACPM framework (firmware) which is read
from SRAM initdata. Dumping that, I see there are 15 ACPM channels. Have you
looked into into extracting the data from the initdata SRAM address?

Thanks,
Will

