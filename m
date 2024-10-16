Return-Path: <linux-kernel+bounces-367113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64B99FEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F045286D80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EFD163A97;
	Wed, 16 Oct 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KdVlktDk"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AB15C13E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045446; cv=none; b=RxsPSRG11Wt608aldIQgIKhkdAIfZzJJoAzxJ3qEtRbevsgqTkMl3zAv8c9dbPWnB8KJXXRpMtOPIa8E0pKTz20Qbr2uIfrPdEE58HkP/BDjzuV0lswxXgU5JN7cjjvYMJMfRfMCgP3CrjRgEsl9Muk0tRH6MZuy65IyDK4AFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045446; c=relaxed/simple;
	bh=vkFin8YAkk9Wiv1FM6Rwn193R82QUFJ0lMHnYMg5PW8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spHWb87CN0kwTEPFnKLgxpCpm1JNmWMo79aByuIIuPoGkFqajKFuuoHHJgZRhLVbGMTQxY2faoKf4M7ed8FHgUjkJohP23YPP/h4uIrJKmXsqPMCoLwXNvybbTCGESJMSiTFHwFnSvFPLCTU+FPzpQn87WNRvtuKGlVKMV0lGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=KdVlktDk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4603d3e4552so67003401cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1729045444; x=1729650244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rSM5JzEpw8IEvYl8Wi1gclJRID81zECxLDVfM6LHr2o=;
        b=KdVlktDkDJHkWr7HFDsQQHLqYLaHgT1E396S+UnUXghwn7T1HNdjC1PSsHNIcfm3za
         74ThQGHppDbKkl5FmUp03FrB2qv6SCgFExp07/GT0uF2fSnUmr3s5goWsd7YETMzEM0X
         A57kjMF+uUYKjlQOh1Yrvv1j6HhDNJ0cI5PF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729045444; x=1729650244;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSM5JzEpw8IEvYl8Wi1gclJRID81zECxLDVfM6LHr2o=;
        b=hcF3F8FeeBV+bG/o7grV4Md5GyNZqa8QoJo/nEbhz88YSnNUUrpVLn68h8kV0zgEB0
         U5U+z+dqWjtQJckWP3sQL4/OgjR5SvRQFhjhHSbh0LsZxt6lmfC7CqZ/o/ThZhFc+dUR
         U48zaJ8Iu8h4GyjvpIokooMq5DFx07vjB3Swbbj/Pb/9JHf0fKiBaU9RGn+6Zanamn5R
         moAeufT9qeUpzS77iuW9mDCUzMi8xnrfrKcL2cCoao6A8x7mIoLgI6eoZyRdRuSosXJn
         QXmAKTuxoXPkH7d4LksGT21opC7O+vgvTvsAn8qJdceZd4pzaeEUuMoV4ocP60+ytGHy
         Z73A==
X-Forwarded-Encrypted: i=1; AJvYcCX1F50SDC68DH0oPP6pJ8OfY0ClXHSsYYG2v6h7GIecf9aR0zvTJRWMHZTDu2dKAA1vsplGeovDeOvrUTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvhPwwDNH8h1pFgiSuUXVTZJHoj50DKiQ5pkQmXpa9pYyXj9r
	nwebWl/Yt6neaeV6/WjzTFiAo9Wj+sHVMX+twNRf2sgdCNAeyb9lmtwN8mSZMTYAXSAD7fBnn8X
	p
X-Google-Smtp-Source: AGHT+IFWCC/S9dXsp+A051MHox+o20A3NL3tpfTZfFxD6YcOo1vnCybm1oZluCcvQ9PpRfE9CJMD1A==
X-Received: by 2002:ac8:5806:0:b0:458:2523:c060 with SMTP id d75a77b69052e-4605844500amr232582351cf.29.1729045444189;
        Tue, 15 Oct 2024 19:24:04 -0700 (PDT)
Received: from localhost ([91.196.69.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a3fa3sm12755241cf.5.2024.10.15.19.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:24:03 -0700 (PDT)
Message-ID: <670f23c3.050a0220.1fe46c.5dd2@mx.google.com>
X-Google-Original-Message-ID: <20241016022358.GA117803@JoelBox.>
Date: Tue, 15 Oct 2024 22:23:58 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: paulmck@kernel.org, netdev@vger.kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, matttbe@kernel.org
Subject: Re: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes
 effect
References: <20241016011144.3058445-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016011144.3058445-1-kuba@kernel.org>

On Tue, Oct 15, 2024 at 06:11:44PM -0700, Jakub Kicinski wrote:
> Commit 0aaa8977acbf ("configs: introduce debug.config for CI-like setup")
> added CONFIG_PROVE_RCU_LIST=y to the common CI config,
> but RCU_EXPERT is not set, and it's a dependency for
> CONFIG_PROVE_RCU_LIST=y. Make sure CIs take advantage
> of CONFIG_PROVE_RCU_LIST=y, recent fixes in networking
> indicate that it does catch bugs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
> I'd be slightly tempted to still send it to Linux for v6.12.
> 
> CC: paulmck@kernel.org
> CC: frederic@kernel.org
> CC: neeraj.upadhyay@kernel.org
> CC: joel@joelfernandes.org
> CC: rcu@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: kees@kernel.org
> CC: matttbe@kernel.org
> ---
>  kernel/configs/debug.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 509ee703de15..20552f163930 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -103,6 +103,7 @@ CONFIG_BUG_ON_DATA_CORRUPTION=y
>  #
>  # RCU Debugging
>  #
> +CONFIG_RCU_EXPERT=y
>  CONFIG_PROVE_RCU=y
>  CONFIG_PROVE_RCU_LIST=y
>  #
> -- 
> 2.46.2
> 

