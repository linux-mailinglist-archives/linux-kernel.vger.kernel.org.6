Return-Path: <linux-kernel+bounces-209547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98D903784
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3B1C22F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D617625F;
	Tue, 11 Jun 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMpdwsnn"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078517622E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097054; cv=none; b=LtMatviI7eJCjbQd8JmHiwoNhqoa0Cc4orGF+GtrMV03sICOvWnIgVo00TRxDc6Gkmwny9VwJsEebqzidInUnRrkbejovARL1/OJ8lPSjKm/oBAFO/+LuYbmMQau65QP7q3OL+0StSYnk6HfcntvygpUTggPw3m3sgLSSpw2liE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097054; c=relaxed/simple;
	bh=71WRNLupKDV/d72CgVNQIoqiZLm/+4VOI9x5CzO+QYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0n0pZcLC+1ar+/OjYhi3g7iX0z41d23tJNRr2SQ9NcUe8QlT4oUHbD8skcdqFKuTSF+PmiUs7PHh4nD6dJOTfjx2TBXwx1bUmuhR5scodv97k9eQ3KPcto6jTmv8buR8prLJRRHWHDqZLKrnn/S3rYws7gSA9S/lbqE/XpohmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMpdwsnn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f7028196f2so16701925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718097052; x=1718701852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrXliMWOrqknI7uqoiUvdZlF8/ofaRo4zJPs4buL2/I=;
        b=HMpdwsnnmbZGheaWKxHSCi9G1WXBbnlwYLH/JJIyDga1ghxZMuIwW6VdDoTEf1IHpC
         Q0ve1Zpkc+hAgc5HijXUMELCRCUyiVPWHKHTGRoxrpIK2Xx9NLvDEON4khGLQugFXizp
         YUQYRyD4+HTPB9IH5zQlbfKylnTVGKAvRuNXujtWtd2Wyl8gVzBTl3Y/+Y99eIoZCn8x
         bLkL3ZKh8piiGgGtA6MRLw254yvsBz27reFG4IRWLEzAJWxYFBv67c3nEedbNeU1lIt7
         OYp3DlUY8fSqy1tGpFsRQ5hXs3EtDEXYihAgERSmmU+gdFSk1KswYS8dYW6fS9Usmy7P
         W2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097052; x=1718701852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrXliMWOrqknI7uqoiUvdZlF8/ofaRo4zJPs4buL2/I=;
        b=QITpswxMRA+xZbKXU1dUjU8jFwa39YPWk8AuHJucJBuIOyrXwRyR1AlK6MEOOzWTmp
         u2yjFGk8wNotDS3aM1w852U3QZUuHUKU4HFP2bPc2Q4UEMk6EmkAEuFgKsJyXfPrVSUk
         mVYVxRf0C20CFvGpXTWnW7lKD5oI5EeyNorBvYEoBluqkX07MuHW6OaP1YIuOlnqeBnG
         Ei1o2yqv6EvzRj9cS8DR1pwIzAUXEHvHjj78PM0534awgJBjN2HitrXVjyTZX5S2YkUc
         GSSGjJPhn6vJ4gp5TjBc0ycCteGylG7EG4moqY+Vq0/Fb/ukAcGm/QA/noaQ5KTaeLO4
         m0jg==
X-Forwarded-Encrypted: i=1; AJvYcCWUGGCtUZRhFHFveQ42GiLUVAx5X6+SMTADn/m3RK3anidHMTAd6JvItdc3VKCqUv9eNu01dwzfp3FBk+mxbUaDmXxtwOPfXleGcW7f
X-Gm-Message-State: AOJu0Yzs/gwz2gwNP01CbhFG1jftheq/6du+SXHqCRxF3iKUpWLAee0F
	Pb2KcDscooT0/NcQpsKfmQCfxZakphlgOUIdEA7Dg6qGts6eYdtPXgXvsSj0qtw=
X-Google-Smtp-Source: AGHT+IFuWtHsxsNkowJj6t+MiMcPN73fgLC497E9oO/gME1qLmBFPmn8qc4KrhwiAWg79db28w0yGQ==
X-Received: by 2002:a17:902:e881:b0:1f7:171e:5264 with SMTP id d9443c01a7336-1f7171e5534mr47675485ad.4.1718097051862;
        Tue, 11 Jun 2024 02:10:51 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7fdd53sm97158645ad.293.2024.06.11.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:10:51 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:40:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Riwen Lu <luriwen@hotmail.com>, beata.michalska@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, hotran@apm.com,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when
 set target
Message-ID: <20240611091049.lrypvvluntf37uff@vireshk-i7>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240606090737.z3qenphikjs5ijj4@vireshk-i7>
 <ZmgQ06jtJBPh5wat@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmgQ06jtJBPh5wat@arm.com>

On 11-06-24, 09:54, Ionela Voinescu wrote:
> It's alright with me.

Great.

> Some "nits":
>  - the "desired_perf" local variable could be removed in this case.

Riwen, please fix this and resend.

>  - [note] while this change helps, we'd still need policy->cur to always
>    have the latest request value (see details at [1]) for this check to
>    be made obsolete by the comparison between target_freq and policy->cur,
>    as mentioned in the commit message. But this is/can be a separate
>    matter.
> 
>    [1] https://lore.kernel.org/lkml/ZmB1qKucR5fXk100@arm.com/

Yeah, lets discuss that in the other thread only.

-- 
viresh

