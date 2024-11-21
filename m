Return-Path: <linux-kernel+bounces-416741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C484C9D497A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B230285FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA01CD1E3;
	Thu, 21 Nov 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aETrMKhs"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918F1CD1E8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179842; cv=none; b=FPrg/me4YuKInzIUjt1DYXVjHlCuKh8ZF4EcyJPbNSDmEsLLARlnGE22CUUFSPjMNkdeoOw7CI8oyT2TkM/7TXsQ0FiD0oRZZIpw69fPMCm9v2zmWNLKKw7HMEUcmKqTMjShue8m8Qg816GW7v2m0F669Gj0aZuHWCB+EGhnUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179842; c=relaxed/simple;
	bh=zbMpCiW7h8V+zZcvggBvpxC5fiQUbw0YA5J9ZIlWRHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7ehz2SW16XOZqPOXcVb0coo1T1mqWLTbo8kRapT2VSZ+18pQhf/lc9BhdUJYcceZDjoHarsr6hil/HPPg9kE8uTSZLTKhIBiN+WJiFJkYDIABz6IrjO5rKGqqLWz7921yfm6ANgM1fYMHEQUYC5OUOgbGbnriFOSNlv4TGd7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aETrMKhs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e467c3996so563186b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732179840; x=1732784640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMuXjuB4be9K05S/thLA6uCT79d6OYIHblQiKfTfcSU=;
        b=aETrMKhsBwS7vP8DQaenhRaq3ce0Qki/m2ajZNEccA1hNHOcZ5R3QuT0WgRu9jeZ/4
         93g6Vb0uaPHq+9JfcIoOEXob3HWehVQaNCfrAIiK44YXnOKQ9pnkC2lJBvWB+VoeXWw3
         CVRt96coI/KcsyK1yeUVYCGdvH65J4B+Jj09dzPrJWeWJpeJ508rV1qXlc8nfYFoNN9V
         82JfjEmkMScJ4taCQ9novXd/m5p14WpeUDlSnjErPrxTLDbtX0kofflt+LPPdquaMw3V
         Z7wVwdUyKIWrbJ1FaVN03fnXfFV3PvXjjDlDjRLgUctzWRy9FjLLOFh+4+fTAOFrAhsC
         UhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179840; x=1732784640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMuXjuB4be9K05S/thLA6uCT79d6OYIHblQiKfTfcSU=;
        b=eysAEjdqWiJpZkhYrkUCt0Ifs2mQb5/vVQyHhuEVRkDDdvW6QuAf9D1TPFO2iCpKa2
         UuR7Q5FSoz+gUISXn5kf9PiFyS+MVHmH8HBFY80Q53YMZJHHnn64rNp36Vb8W+IGuuwz
         Bt11WgiDH8gfrqB8ic1aHuuLKGgKpNQD/FYoqrYHtxtG1e6JL3pDGqK/4xTuxDRrlEsp
         jeLnbc4r98ZEY+ib6bKZ/Ehvl0G1JJ5rrR2HxAqQxOHDyjyGNT97jKzvpV5FeLpsckdU
         3++Kn2oFiYhMZqfEkWSYs7ItSrOSMb7MufghlfA2VCNYasBmCXVxPuVGgkCn8Z/Xp68O
         p6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXJRZ/6mfYI/TcggOvqaH9TjEXg6ttM9K04BRNgj0Hh21CFVfEdX4s+ZhtXYhoqyUnL45UqB2wRptY+DXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypeFUCDE+vXxlNV4JQWG6L3PMkxpzfZ7ipxobO1g4Yk7uAA6vM
	wWo0R2yA0BKPKHI7uo0kwZoJTRj6l/ZBos9MSXnQVFmGBqR1RB7u/mv6E+IsZt4=
X-Gm-Gg: ASbGncsjNKa9Ln8MKSfaMpY0toWDAErHCBZ9Lr5HobP1eQZj3vrqP/PaVjmueA0Pi4K
	UCXLvYcHvwWOQmHsJpciYi7WSfQvl6kSAXpRF45Y0DVo3hGO1MsYuZKiqzn05Wyc4ut4AuiSb2z
	qNmiz8grsuonl9Kha5OS9Bw3BsWBRXeaKOygcAg7jPfif/XZfojpA9LJp/0OQSlXPjlb5AJVDu3
	j1bRQIZOn3n02qHAOq+pwCoS3KbRwJnnM8xTRW4nJqyZXh1e+Rj
X-Google-Smtp-Source: AGHT+IEaWTvKWTc7WuQDWMX0j/0BgxaMEKJnSxfGmPi1Zv0gPPgpz4Tj5YUsAhXM7ACYurVWy1q0RA==
X-Received: by 2002:a17:90b:4f8d:b0:2ea:6d3b:1985 with SMTP id 98e67ed59e1d1-2eaca70aa97mr7709392a91.15.1732179840425;
        Thu, 21 Nov 2024 01:04:00 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0314f30sm2722817a91.22.2024.11.21.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:03:59 -0800 (PST)
Date: Thu, 21 Nov 2024 14:33:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: robh@kernel.org, arnd@linaro.org, linux-kernel@vger.kernel.org,
	Radu Rendec <rrendec@redhat.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Maxime Ripard <mripard@kernel.org>, javier@dowhile0.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
Message-ID: <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>

On 21-11-24, 09:52, Javier Martinez Canillas wrote:
> Will autload the driver for any platform that has a Device Tree node with a
> compatible = "operating-points-v2" (assuming that this node will be a phandle
> for the "operating-points-v2" property.
> 
> For example, in the case of the following DT snippet:
> 
> cpus {
>         cpu@0 {
>                 operating-points-v2     = <&cpu0_opp_table>;
>         };
> };
> 
> cpu0_opp_table: opp_table {
>         compatible = "operating-points-v2";
> ...
> };
> 
> It will autoload if OF finds the opp_table node, but it register the cpufreq-dt
> device only if there's a cpu@0 with a "operating-points-v2" property.
> 
> Yes, there may be false positives because the autload semantics don't exactly
> match the criteria for the driver to "match" but I believe is better to load it
> and not use for those cases, than needing the driver and not autoloading it.
> 
> > I am not sure what's the best way forward to fix this.
> >
> 
> I couldn't find another way to solve it, if you have a better idea please let
> me know. But IMO we should either workaround like this or revert the commit 
> that changed the driver's Kconfig symbol to be tristate.

Yeah, this needs to be fixed and this patch is one of the ways. Lets see if Arnd
or Rob have something to add, else can apply this patch.

-- 
viresh

