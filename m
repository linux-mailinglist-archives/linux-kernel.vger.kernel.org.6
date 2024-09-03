Return-Path: <linux-kernel+bounces-312550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26393969812
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C2D1F21FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEB1C7689;
	Tue,  3 Sep 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6kNvhZX"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F01C766B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353966; cv=none; b=Z+qs6kvHJsfZu1/7XlVZa6BA8H4o9JH6qXvpMNcKCVc4134Fnbzx8UAfAdipvaYfQ4w9jUOX4cTdKxwkgW6hdtQvy047lIh7XzSSK+LUUChwq894j0tUFmBEk/i21shsjsWSEanY20K/pPOKvzGUKTpEwnUsH7G8Z63TyLv3As0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353966; c=relaxed/simple;
	bh=udGQV/GmfFfAjfO2sEZziU//Qi8dyLILtEc/1cuEovQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIcfSzEsFM1Td3t/NniXfrsooZgdE/Jx+/4V26KZAHicAt7UpQrQ0DZ/vP89WO9RAb4FSYOT09n6V4xeGFHWwub+R65QwMsMt2sVtEX5d72pk206dFnePdZfb8DpVgurTv7ruHmooyMa/9IDbvT8oa3OSgMiP+WAIN59lNpIfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x6kNvhZX; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3df0e0e5577so2609251b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725353963; x=1725958763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymoJtuBQv5UzRRerIW81ssFX4/DtJS7COa0FqHOhZgU=;
        b=x6kNvhZXb0rnHQbr5qzEZGQr7jq0691qqA6UvLjpWDd+x/uP3uDeubVkQk1iLhWvo0
         T9ON5GH1pZSXjTViYAGrxzBNc9YBftB47paLkSnhkdg/DlK2KA2LtAA46wNtcJt1M2/P
         dKPUTVdGQ9pJ+BtTM/ZwLcnQNK5hgSm9TH7d75OvWXSVrzSVnNNq9c0V6nO3IjowHxFd
         S0GXvohW9+1h3m+HbxXYDk6Mh6c9WYQi/tAGcFmn9Y7ZwRCd04LycBtfI2K3HjrxclfM
         VxCsgSYMM2puyazWYnounV4ehRdVsxsVn3zWP9J4YkxV0dJ1oPqxpCPZcKDlsHxiQ/gl
         qM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353963; x=1725958763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymoJtuBQv5UzRRerIW81ssFX4/DtJS7COa0FqHOhZgU=;
        b=M19LQw1roqiir/KDylhq7vJDuxZUIKtvawE+f6ivKPu59zJyENbj7uK2yQl48G85Z0
         yUi1H19Eu5Ft4zju8qx5vSjs4KECX+XPCQmP3/bYjhsZ7rAphiJP/VIT35Wh7L/XZOB1
         bdUA75ggCv1MZ+ywtKdkamUCFfEcnFX9GnEtniKWz9l5f45rTm4hJLmXSoS8BiMGunUk
         YlS+T77sg5tCfi66r8fycv4Xv+YhnaNpBE+2/I3WO85wPV1b/4ZwgDHF/pSHhE0i6nHq
         5QZjOugqAtYmZ+VQM4JDH+nn2EwsPgjzp9WBIDXYEpG6C9uH506Qlaf2nO6dHN23AjKf
         uRPw==
X-Forwarded-Encrypted: i=1; AJvYcCVSySEW09B9PRdiYSlEsBAvi6fj5ZPqmAaoC4uRxFoiXJ73XLjkmPf69uhupVDYdu/OpA7Q6wcy2to/JNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJAzRHydT1jHn314o8hktpAW9MQcbIcnp6xfVJPceMRoaAoAv
	kjBZVp6fUh1bJwO+N7L7R0Qkz9HahEFOEGdNlNlfEQ4c2Weu0B7lUB5x7JcgjiU=
X-Google-Smtp-Source: AGHT+IFuS2L60v1NP7nVOUMwHsCSPHEXJ6vWOJHGecvF7IyXMJ+9BQCfiVc8MW107Tnk61AoYNyV7g==
X-Received: by 2002:a05:6808:152b:b0:3e0:916:f7bf with SMTP id 5614622812f47-3e00cbd01bamr1305179b6e.47.1725353963674;
        Tue, 03 Sep 2024 01:59:23 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e7759bdsm8759318a12.22.2024.09.03.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:59:23 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:29:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
Message-ID: <20240903085920.rk4bx5qqdbmj3aom@vireshk-i7>
References: <20240826133842.5519-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826133842.5519-1-abelova@astralinux.ru>

On 26-08-24, 16:38, Anastasia Belova wrote:
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
> v2: remove mixing code and declarations
>  drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

