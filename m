Return-Path: <linux-kernel+bounces-445997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E123D9F1E52
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0DF1886A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496718E76F;
	Sat, 14 Dec 2024 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeZufbtC"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6E186287
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734176381; cv=none; b=iCegbDnr/ibspAfScfUtYsJQxwrfj4j4UkfXvC3MeLWe1SCbdtE3DX8Hm0bMWv8bEo5j2h+b0KJI4S+5P1iHSHuNypxw/+MtKQAc5rlXarTCtGvo85/JAlvPWhGLEoiy97GWFx0H04+lJOGxQ0IlaLAQ2rryeCCik4sdJSAfiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734176381; c=relaxed/simple;
	bh=Hi0KPvOMo5zpxOsXgD8nXO1azY36Pqum6h29Oow5cDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph3SiOVhKIkznvNtFCkng3M2yuXoRmsAB3e6u8Q8CHI+Wie9GqgWIusbTF+tV7y2OJcQ7Uv6KYfN3lFTANt9UcRGPl3SLiJ6DfR5MwdOl3rtyZCc/keIBX94DU8zPXLG7XodnR6G7P4dxDnwrJHOvop2nJA4AVxf+aswLkw/CXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jeZufbtC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30167f4c1deso22456501fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 03:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734176377; x=1734781177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeCcjkbPl6Xl/41j85MrwKw61kLFoQEu17cYntkW6cA=;
        b=jeZufbtCrbo/2Sig2gMXZYop9UvtDEK/b2c5mthZIjMgeFD7vhPJlP5NME3ddxqgzd
         038ZUiIX2CnsVpJs+knAPeXK9olFF8iyEp0FqDAx1nEj9wa5+sXEPnm8Nr6knO+lNPAd
         FWc5oiRxtpw5+8YU0y2FcgY1Kl9eBs66/AXL3R/RtRyHxaVyj8xDd3yyJQFgN6T5w2LA
         BlI/tnyJXXcAS7fjLWMSqYR7jXlI0a2ax+zTRI6IFPgHe18gEkFi0V+3sU+U/6dYlM4/
         miK2vlloKr9FV97+zNBhaTdTepzuoLlj5fLow8hHjfcwFftoG0MBbyxjvv7Mwr3GIzWR
         MpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734176377; x=1734781177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeCcjkbPl6Xl/41j85MrwKw61kLFoQEu17cYntkW6cA=;
        b=Xu1x0QiNMd/MYNZDsCJ2AuttYh+TLljPtpM2g4MmfgDnBM3M/Pm8dZ4Q+IhEP8fZ7p
         OjRczBx/bTk0MQjZ1heAI3wZ2RapyxviOI/0D3SWK1yfIfBDTNBxDANcHNPGnkqENmvw
         7Ne/klRoPbDggsGBxaXQXgox2QkrrjerKgbhT4NlIvCbU2a7AEdxMwGdHPbI9EfYMCFj
         cdWHX9rr9o1q82f4lppKuPqt+ys0tsiwlgc1NxZfbfJE9AtWhZA25qNi/YyKDL1K9XbF
         nB3Rm74pFM701teWae0PYk9+3uRiqC9XYCxZ8BKbtGVhU4MDKGQYQ7EJPVW5ndUhXmkO
         5ZWw==
X-Forwarded-Encrypted: i=1; AJvYcCUKu+mOWnzcNxq1u2kNr3jl9gXRBeCCw4eefmhN4nz2UORlMICP4YGOtHQ4+hVK2+6uI6Io3dSBTioLk+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQyMXgfKL7UPkFyxJzsTz1x3yzhVMOvINe6QwKgD/zOlycSiV
	ZouXuys9VQyN9fUQJwVipSadWcKWbKWF6OclgbnEG+Fu+9fVwHlJJx2ys4RmDkg=
X-Gm-Gg: ASbGnctevWFG5Wuswc1oSggd4b3ICNdQPnovl+wntDEaOBlDT/GJ6DuGTGlbEjP9QIO
	kWMgdUxfmkGwKM7z8ps8uo4MD1qusgKk24L5DzeOpLMVDjxaEPKHCdfSQ0zmylVQOMbB8vruXAc
	YKM2ty+iqn2pRlyim23GqqR5txOjPxDzUIj+yULSqx3wGKxS9SJbIy0vxrwa2os2n5fSb4rHu2B
	LaUIpa+fMk8ntpTVKIpMySTnylugOkGo0P+FG6WF9MkIneexwCM57gjr2aUO+UV/UQQImbiR36i
	tsx4Aucuj0zNnG3kaZKDDO1GSg3nA3Awrt+V
X-Google-Smtp-Source: AGHT+IGqTQ1pNqm/Ngay9AHMNf4hrhRAE2mYmS+Ahol55tRGPvjWEaqYkQ3xCrtSle4klGeWah9+hg==
X-Received: by 2002:a05:6512:401b:b0:540:1f7d:8bc0 with SMTP id 2adb3069b0e04-54099b6d6afmr1869994e87.49.1734176377364;
        Sat, 14 Dec 2024 03:39:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c20acdsm192457e87.261.2024.12.14.03.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 03:39:36 -0800 (PST)
Date: Sat, 14 Dec 2024 13:39:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: errata: Add QCOM_KRYO_5XX_GOLD to the
 spectre_bhb_k24_list
Message-ID: <2qx75syaojhnsqt256li6sinafml4gohohvld6uw3zhejrayuj@biiep5dvko7t>
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.5.I41e227ed809ea607114027209b57d02dc0e98384@changeid>
 <l5rqbbxn6hktlcxooolkvi5n3arkht6zzhrvdjf6kis322nsup@5hsrak4cgteq>
 <CAD=FV=WQf+ig21u316WvQh0DoKsdKAmZgqPn5LB-myDXsJtXig@mail.gmail.com>
 <CAODwPW919K+XdxjUe3aPgxsv0CEWwx0P_Hxvf=VniLhk8eagkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW919K+XdxjUe3aPgxsv0CEWwx0P_Hxvf=VniLhk8eagkQ@mail.gmail.com>

On Fri, Dec 13, 2024 at 05:28:55PM -0800, Julius Werner wrote:
> > Interesting. So the Gold/Prime are actually IDing themselves as
> > straight Cortex A77. The Silver is IDing itself the same as
> > KRYO_4XX_SILVER. ...so in that sense there's nothing to do here for
> > those cores.
> 
> Should we add some comments to cputype.h to record which other
> products are matched under the same ID?

I'd say, yes.

-- 
With best wishes
Dmitry

