Return-Path: <linux-kernel+bounces-278652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C594B325
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A266DB20AAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B8155337;
	Wed,  7 Aug 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juMPo6WK"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893D12BF02
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070198; cv=none; b=P3TKuYYuKI/RYWPu3UqnkGL9bYN0GtdxxDREeGiA0NuSVHTRJA5zZZZCrS/NQ+GHCCQSfvcO+DDpVOEbSBnKqQk7NCVwrwmwK3e2lp/BvzOtPMkY5eliz/3rntpEmT8W6EZjJwFJr5ePWJ9cz6uh/hPaJzPpbA+SXO3YyQUMp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070198; c=relaxed/simple;
	bh=a82BazRTsLV8O545SUtLHexI80RAcukz/terjjLKadM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quABa19DZnKExu250W/B6jN8KIv2gOYCK7EoGp7+mx+BiLCx8sfh70eCIBgzEhbvx4RUvIG2tfdB7iVgLhCR1VVbVCPfMB30zZ6MZEn1MdKj6nFEqtApjUFvj4JZPlYCgl4pEtvlCHcwRrutQOa/i4+klGWsaAVX8O9n0rYI78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=juMPo6WK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093c94435bso157083a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723070195; x=1723674995; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5xqVBE75uTakMohQNNM+Ob3mwTWILCE117tt64StnA=;
        b=juMPo6WK1oMZfx3SBHcJlSj3c0OAieioPg67K4fwY3TboNmdDxI6OxvWHaSwPXE0jH
         eK2kcYczUnXPkSp9r2nd3ZcPC0eO1UFirsKHaAQhfs4B3XsmiO2rgpN16/xRYst+zXch
         v1QZuNA2KHlX2wVjEfqlVlphsB12PFmbxgwSDRxJhxWO2YLxmhYaOUuRlWk7PcCjbk+y
         Fa1343O5HYV8WiUbUAj+4J+E3lqhYfnWQwuqjB8xYEROLCu+ASmt8BRrQ9DlieyXSFqw
         90DAPW35AVjyBWWyq9AGUFdftONiop8Zvy8vQgTvqIjRNXOYmRUtbEdFnGY13khRg5G+
         mnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723070195; x=1723674995;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5xqVBE75uTakMohQNNM+Ob3mwTWILCE117tt64StnA=;
        b=AWQ6KBKdAcE3Wm0c5DrQOLG9C+QZaKukV2kzQsfC3Y3lJAXSbLreCo/LzxajQGm1Nq
         Sbaps/sRoydTX8Wnvj54gfDGpqzsg+mqwX3UYVJqoTzmmNxsPkqs04MEmKEB2a6te5P8
         1a6Jk7q/3c3EjyRbWehoTi4Kl1kfnDjXiPoTj0MhQKZWhwVNh3I/LiC1xOOFPnHgqE48
         y09xjOF0eZFfXDeDJF8Ez1F5r09vG3zl+dizyX6fPT5QqBS/0uHxb5qJ3W5wLdVJTV87
         RqYuYo97GAbK5CPerVOha3I51SD6ZFxNBaud4xkrKw38sQh6tfy27pPKMcKcGPh8rXov
         O+4A==
X-Forwarded-Encrypted: i=1; AJvYcCVX311ALzpV+QEz4AYyZpMq0lrJws1EJND7Y1ilMcz58AgpALz4ZElpqysWlZlEOq9KfURwlau7wdVy2E6G08njKlQ2L9/6Xp5Rk47l
X-Gm-Message-State: AOJu0YxTBXHIuWEfClfKPlZSwsI2zqpCQT5+ShhVFFFI14e+bZqlJBVr
	DB+hVELFhXL6jFSS/Pv1dhqH6ZOgASkKCSAzfTo85jqDNN6q3IG2C9DpQgRcR7k=
X-Google-Smtp-Source: AGHT+IGTBDVQAm3GArH3otwegCgx4BHN1ZL2N8yxYA8F/kedHOZ4Afd+CPHaShh6RvNkbAtiESu5bQ==
X-Received: by 2002:a05:6358:70c1:b0:1aa:b860:f10e with SMTP id e5c5f4694b2df-1b15cf91432mr25702255d.15.1723070194758;
        Wed, 07 Aug 2024 15:36:34 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654be293sm7403332a12.91.2024.08.07.15.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:36:34 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Florian Weimer <fweimer@redhat.com>,
  Christian Brauner <brauner@kernel.org>,  Ross Burton
 <ross.burton@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-doc@vger.kernel.org,  kvmarm@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 37/40] kselftest/arm64: Add GCS signal tests
In-Reply-To: <20240801-arm64-gcs-v10-37-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:07:04 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-37-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:36:31 -0300
Message-ID: <87bk24dkpc.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> Do some testing of the signal handling for GCS, checking that a GCS
> frame has the expected information in it and that the expected signals
> are delivered with invalid operations.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/signal/.gitignore    |  1 +
>  .../selftests/arm64/signal/test_signals_utils.h    | 10 +++
>  .../arm64/signal/testcases/gcs_exception_fault.c   | 62 +++++++++++++++
>  .../selftests/arm64/signal/testcases/gcs_frame.c   | 88 ++++++++++++++++++++++
>  .../arm64/signal/testcases/gcs_write_fault.c       | 67 ++++++++++++++++
>  5 files changed, 228 insertions(+)

The gcs_exception_fault, gcs_frame and gcs_write_fault tests pass on my
FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

