Return-Path: <linux-kernel+bounces-549353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3146A551A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CB51886828
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C2D233158;
	Thu,  6 Mar 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDhT2atB"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5192233705
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279356; cv=none; b=VbLWoJAtv6uzgMabl3Zg07PgY/AGP3Q8k9/iLyjKUmNPJKGgJGwK7ovToQF40ZH+wOf9e32n43kSmOGhCQ+cKXaHjdbV+wDTAhZbrJT5NKzBfii23gVNsc8QiF4tyulNbjqNec3iyiShcYkAov600T5vTCObAqUAI3gG3C3eFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279356; c=relaxed/simple;
	bh=Htl3h7KeaL/zOb/ApH4x3HZDGgYnWqggjXrIEIkaUSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onbpfn7D/kvYY4hwyrK1f7HjesoC4vUtwCUVOpapnrVqHLusRn2U7OEUNwDdP/FYyIsFs6q61L68nk0G5oKGAI+gEFka5uxIUAJmtw/J6815XXyAGvkoV/MAHP9rFctKTeZqsoPPZw7D3h7Tzh66cqm8hUDOdnvAOZsK0QdZjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GDhT2atB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54964f8ce4bso885789e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741279353; x=1741884153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1TEoG6Bs4dGXKhJ2AGcoAN5xoNJpv8hc7dD8huvzUY=;
        b=GDhT2atBG6Kv6jMSO94VxaAkl+XgQv2yXVSXAG41suLUS38zYtzdddMW3IZ95Dyxub
         FvUQAx/kx6MM3LL6pLenc8Yp3JmMLz/PsrbQeMz5utB+rPjvNU/lKzIjMvS+V9RL8kE0
         dCH/s56xypbPu4Xe97YXfCfnHpiRWDnQwf5FmrK2cO53+0x0ad9l2m62TyXPSrBpirh/
         ktYg74bJTrqQVBr73pMswKJBYy/yQ+OVAGNQihSQc5+BgsrDNxnB/FdcsD6ALqGhvs+r
         RRP5aQVVwzX+5sRZXyf16ueLtcEs/t8kTHY+bp+Frv6UgnRwHWjCWtP7gi7zHCXd9cbD
         LQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741279353; x=1741884153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1TEoG6Bs4dGXKhJ2AGcoAN5xoNJpv8hc7dD8huvzUY=;
        b=jS+HszxKmUyIzvNvIxsE8t24rQhMlc8Ua6/vElZhGSQbjUVMPeUDlwrwH76l+p++2K
         lmfCHFNNVcN30ht62glkiEoQrIYw4gXY7WAnubfru2AH0Eb/WoF/aNfoJyoVkq6bEggB
         /aD0m4j9KyVJyTsexq+6SLdCBo/dCDvoLuj9lf+6gSsuPETsLQgWCQRKogCTkKBX6+V+
         KUT8JAZxqlgreqzFuwAcN2vKVvnd3A0jzlf3BoZWHoysH9qVjQGswR1xsaKfLccnGUqK
         MiGw7CTNEALbVpUWLoPnlM/EVi8WtfVfwIiwcoQIu9iltvHCTBHmNzUicZe7iJ9qxZDb
         axEA==
X-Forwarded-Encrypted: i=1; AJvYcCUqBArlaQHPwMSwrihlrE8F65N40VUQiPtzQMFjDaXtIGr3PqI+XCjbRk/b7NCJ7MqzxCKCF+3vcJ5UyJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+ZUA2V76Lg52vjZ2MME+NhPWuE498USf/l3cC9DZ7r5sKurX
	zUGmmzdwDQxLuqGXiL0KX5MjzOicppj5P4LQYNpZ6DmgZt+0DtsZsOMoXNZ95xg=
X-Gm-Gg: ASbGnctS7yzfYWygIphSzEZzWRDYircaSmnUbaxQFsaGMS3apR2NQAbBqDZVcEG7vEb
	sx47NyJqUuAmZq9WfPjhR8RI5zvdDfOUWzYHWmlf/GxTOxeNXxR1C4c9J/t1vcEFO3ceCsAytAH
	tgs2plcI60fh7TQho4fTEyl7COYOZrhGGmJa6eEUuzSCZf/NYiTuVpep49oLde7VSqZKNcX77HN
	/UjckJrhjkgSpdwX/2lUvGDtMqfEUOOTt2kVIeq1joEHIKXqvOWNPz5xvHicPlWrfEent8mxFu8
	YK/Z6826oCQBOvCByAIJOJTFRM/WyCx5NRxKP19S9LSecoQGJKqAy5dzld8PqQgAzosIEUPD7YU
	psXrYCVjeF5LkZkE8A6nH589r
X-Google-Smtp-Source: AGHT+IE1wW9mQTVmacyoQdeIAvRVB50L7n4ewIxrLBTw9juMr8FpFISjO6I/fHqGbHPO6+88qFtLCw==
X-Received: by 2002:a05:6512:33d1:b0:545:2efc:7458 with SMTP id 2adb3069b0e04-5497d377827mr2510465e87.39.1741279352687;
        Thu, 06 Mar 2025 08:42:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc204sm225871e87.176.2025.03.06.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:42:31 -0800 (PST)
Date: Thu, 6 Mar 2025 18:42:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC v2 0/7] drm/display: dp: add new DPCD access functions
Message-ID: <fdhegbtikit7n6ftql4cx4giikgt2vkue4jrasxfgkpxlgdbo3@vlcv63kz4j4r>
References: <20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org>
 <87a59ywda3.fsf@intel.com>
 <877c52wbrh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c52wbrh.fsf@intel.com>

On Thu, Mar 06, 2025 at 03:04:50PM +0200, Jani Nikula wrote:
> On Thu, 06 Mar 2025, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Sat, 01 Mar 2025, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >> Existing DPCD access functions return an error code or the number of
> >> bytes being read / write in case of partial access. However a lot of
> >> drivers either (incorrectly) ignore partial access or mishandle error
> >> codes. In other cases this results in a boilerplate code which compares
> >> returned value with the size.
> >>
> >> As suggested by Jani implement new set of DPCD access helpers, which
> >> ignore partial access, always return 0 or an error code. Reimplement
> >> existing helpers using the new functions to ensure backwards
> >> compatibility.
> >
> > I think that description is for earlier versions of the series, it's the
> > other way round now.
> >
> > Regardless, glanced through the series quickly, I like it, this is
> >
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> PS. If you need to send another round, please Cc: intel-gfx and intel-xe
> to run this through CI for both i915 and xe drivers. Thanks!

It might be a good idea to do that anyway. I'll send next iteration,
fixing the cover letter and adding both MLs. I hope we can tolerate a
bit of spam for the sake of getting the series a proper CI test.


-- 
With best wishes
Dmitry

