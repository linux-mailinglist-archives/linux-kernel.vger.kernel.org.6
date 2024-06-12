Return-Path: <linux-kernel+bounces-210974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB969904B87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F185F1C2145D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE1168C15;
	Wed, 12 Jun 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6a9aNld"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD91649BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173589; cv=none; b=MULBDc58U6N7I/XTDY+Hrlymfiu7b8VRtdand9B20RRTp02K8K+bwsfV+oN05KaSLdGjwoqcsz8u6dSdlXSVe+z6W/92HNIFIL4NSxs3H8teH7bW8a6Amp4K4SeAVMRdBdqy8dmVuDKTipDMGBpttnRe8eM6gLM/jo87Te1Hm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173589; c=relaxed/simple;
	bh=OjV2vgagW1+36R48ACdlpUls/Ff5SMqKkUp9o2DpjS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy3eD8RZPGPX6igqsUuOiywsj91X9vQ+3bIlD69nhan2OoXVyeJC06OLmiO7Az6lPvel1l5AR1lfdvgHnHwjwVjEur4G9QC6Qb2deFGxIhfuVeCxIX1DkKhyDp9m0pjM3vzBd9rEvU7PVNrxDtDJU89CBFm3cz8SMY4fWcXmmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z6a9aNld; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70417a6c328so4001594b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718173587; x=1718778387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0qDpNTuN255HruljLxZ81sNK88XdDWwGWSt+LRgqrk=;
        b=Z6a9aNld1t2HgEmd1UnMeg1fWCv8oBp+tHv2ilPRrRzXEJYygV0maRiC/TuZRJJmsK
         +C5WjAaU2gW6//5K3Sd1QNSEjGQZVtUKwjCBy+cuBXH301EUjBkLjghIg3ZKW04C+jnj
         OT3zcayDwptwZC0nsP2bS3Fa568Uh4LPoy7q24KTBF4qm+gsdoxzhW83wmnMPrXcAYO1
         1FX5LUwv3+KfdHsagVpPuy9u/lPIDuRvIt2Qx0a94W1d9J/XqpSEMBEsz2J7zZQY001F
         1os7McqTEY73SPT9ewUA0EKk1rgMUA9rl0JW4QtoDDbUVpoNCRZ0XCGplpYH5eIJjcOb
         Ujgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718173587; x=1718778387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0qDpNTuN255HruljLxZ81sNK88XdDWwGWSt+LRgqrk=;
        b=tAPFYtFvKNGDYRhWAobsmu8OGXH2CeJkWdHVARKfLxbszsf3hcqBp7QpI28RC7DFJ8
         pBaoCIUnjvkq1PnsyDx4lKKrv0ghu3k6kGAcS1tFErKWB9xb+S48J4rC4Bl5xRYlwcL0
         KQbK7pqFUXwYT2mhMjz7fA4+cjbaTozPEhgnsZ91XmvcMSdUNHmgR4ag2Amf6ILQaUrR
         /cwItqULwA52R8Fx0KE4WJlsFwp75o2EVFKw3KwDU3FhY194eqwq5XOv8rwxr8nz+pIC
         dgsUMaErLokSa1CAZMVxD/bX/9qMcH4QibowN0aVKzP9SqvUOY2zKiX2d8v5jy6mzhZX
         eyxg==
X-Forwarded-Encrypted: i=1; AJvYcCX7BjNNM3SFptdzj4O5kAYOiG8nSXT4jyjMlJ0RHcJ6b0VBkQI5fNQ8F+tzB+gXr+vdLi3liYAN0JVwWsHkQaL+XYKCw/eZ+rSWRi9L
X-Gm-Message-State: AOJu0YyPfvVOu7zk8yfSoWMcQP9jxN2mi/1tGfhIDWcM5DShhc0imv08
	GAODBrelOymykAN1pM7u9dopn1hNSrBRHmF7R1mdKooBlBIXqCLIkajLAwOs1UE=
X-Google-Smtp-Source: AGHT+IGzELfA2i9/pLOE2Y9YPsNDC54W5IrlhSFxE52jcKF0MeUTrJiiVe2uK90sPFxYjCQcX+MoNQ==
X-Received: by 2002:a05:6a21:32aa:b0:1af:fbab:cf92 with SMTP id adf61e73a8af0-1b8ab6a8be5mr1146101637.54.1718173586835;
        Tue, 11 Jun 2024 23:26:26 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f712408089sm53434545ad.117.2024.06.11.23.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:26:26 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:56:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>, beata.michalska@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, hotran@apm.com,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when
 set target
Message-ID: <20240612062624.i4kcm2nhneed6yjk@vireshk-i7>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240606090737.z3qenphikjs5ijj4@vireshk-i7>
 <ZmgQ06jtJBPh5wat@arm.com>
 <20240611091049.lrypvvluntf37uff@vireshk-i7>
 <OS3P286MB249073C57E2B5A36F45A02E0B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240612062404.yjfduze4bvgyts6a@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612062404.yjfduze4bvgyts6a@vireshk-i7>

On 12-06-24, 11:54, Viresh Kumar wrote:
> On 12-06-24, 10:52, Riwen Lu wrote:
> > I think it's no need to remove the "desired_perf" local variable here, the
> > code is seems more readable.
> 
> There is no need of a temporary variable and I don't think it increases
> readability at all. Moreover, same needs to be done in
> cppc_cpufreq_fast_switch() too.

Also please don't send the new patch in-reply-to the earlier one. Send
a fresh thread.

Thanks.

-- 
viresh

