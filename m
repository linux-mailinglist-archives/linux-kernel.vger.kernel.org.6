Return-Path: <linux-kernel+bounces-430743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F179E34E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B688281225
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A8194AD1;
	Wed,  4 Dec 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcA61YJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25A18F2CF;
	Wed,  4 Dec 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299342; cv=none; b=tl6tV1QkXrS2UfJczPY1EMS3G1Y+x+oJ3rIyZssdbtDYVJbdefPKBQxzN1PnbYNXdnVN780dtA7dSGaUFafT/0MzmrxafSW/5fizcGIVZpmkkyfC43uU9J4+FZomfYaYlUzAd5YnsSk9kw57yPxgBpGl4bauqPW4ZO+NkvvZoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299342; c=relaxed/simple;
	bh=M+VgsjFFjkbJsHcaeIjSbhxuSnKP2h02k6+chfrtbN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvJuwFVZobmCjAzgj3FgJLnuMUwT3m6lTy5GgBr13uLJb8ItaQMBWvIGQ7N9xcNrx2NF7iXjjI/9gyJjepi1PM6nyrX0Nep3GyZNzCQ6tZZg6FEK41+G9y6LzY+P0zP5IESOwKKT0DHo99uJxAzARWVi6YKV7C4nGQFqEEVJp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcA61YJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ECCC4CED1;
	Wed,  4 Dec 2024 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733299341;
	bh=M+VgsjFFjkbJsHcaeIjSbhxuSnKP2h02k6+chfrtbN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcA61YJpyB9VroU9zHwG0pkluA4QSt5ZwmkLnHzEKhCQ5Ag9dbBcMc+diJuK9YLkU
	 AsPWwSjkEJhsNdyYik8FOERb7zUir1QDbWKR7gxgXWjbIetYvdwPJo8bO7t2d+0jew
	 T7zwhTXLH+39wYN2izalXeOW5XsiWOYgsiXHcTsfiwmfJXRTxhGbXJdz86dr+E80z5
	 UYR/s8TWLFGHqB0g9gAEyGHfqjKRbWNLDJfofhN20yD85P1N5TQyvhrdGZ16x90VAX
	 3RF08NVEkU1wrN8csXTVAULzHUfMeNU3Iay5qnElPYqNloS29cOawR+A4hQDyIpCak
	 IdqF4Wsk6G1Yg==
Date: Wed, 4 Dec 2024 09:02:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Mahadevan <quic_mahap@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: msm: dp-controller: document
 clock parents better
Message-ID: <hqe2pipkcnxftoq5mvdk36xmkj3ybr3oto6eghimq75rqlncsm@v45smglhedy7>
References: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>
 <20241202-dp_mst_bindings-v1-2-9a9a43b0624a@quicinc.com>
 <bfa857c2-cd74-4fe2-a88c-3b35a58710b0@kernel.org>
 <gpqrugcsyhz32bvip5mgjtcservhral2o5b6c5nz4ocwbjw5uo@eypv4x6jyrdr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <gpqrugcsyhz32bvip5mgjtcservhral2o5b6c5nz4ocwbjw5uo@eypv4x6jyrdr>

On Tue, Dec 03, 2024 at 03:41:48PM +0200, Dmitry Baryshkov wrote:
> On Tue, Dec 03, 2024 at 09:01:31AM +0100, Krzysztof Kozlowski wrote:
> > On 03/12/2024 04:31, Abhinav Kumar wrote:
> > > Document the assigned-clock-parents better for the DP controller node
> > > to indicate its functionality better.
> > 
> > 
> > You change the clocks entirely, not "document". I would say that's an
> > ABI break if it really is a Linux requirement. You could avoid any
> > problems by just dropping the property from binding.
> 
> But if you take a look at the existing usage, the proposed change
> matches the behaviour. So, I'd say, it's really a change that makes
> documentation follow the actual hardware.

First, this should be in the commit msg, instead of "document better to
indicate functionality better".

Second, what is the point of documenting it in the first place if you
can change it and changing has no impact? So maybe just drop?

Best regards,
Krzysztof


