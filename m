Return-Path: <linux-kernel+bounces-512518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F2A33A67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F349C3A6A36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBAC20C48D;
	Thu, 13 Feb 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biJit9VP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE3206F0F;
	Thu, 13 Feb 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436999; cv=none; b=FjCmAUTwLOGCTpJcGsRPy79oWFDeGHK7BAMsC3SQzKZQmlAjM/ClRh8ONBWgEmLeYHIzXeqvv6Fzc7IrR5Q00QVpPpRFziM4EUxy7XDG3bDydADyZihM6yUOFRlvNaq56NkoRJaxTOeBs5/rwawjiN6tEMj4fQrfwdcCw4Duz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436999; c=relaxed/simple;
	bh=hih5Xq5n29taXspoRbFPy3YyVqsgUHNuM39mgdxlVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDfXWzeORZKsJkKyl+oQ1icqCYt/6GrkfpNVL3jCaWC2kPs+7sqg2ysJmnxpGAB62Ts7sxSwhlcHbZeboDl2OLshxRgid+SXlvpYhuWSyiz/PZNtQontcKprJYFyzqeatuP2mlYd5fczcC/Jg3dXZrVlWQLdxqS/G0nR9Xh3ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biJit9VP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F87CC4CED1;
	Thu, 13 Feb 2025 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739436998;
	bh=hih5Xq5n29taXspoRbFPy3YyVqsgUHNuM39mgdxlVLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biJit9VPtK/lzJuwXn0fR+gnxx4p8ETeD7fcXHEVBOnPrKRYkMVFIsSMILWuvFMSS
	 +5ZbhHyZQJ8bVvZzjYVPXQHcuhElifdzPG1Y5tHmw7lr63HNORzduL4MvAyfT/9GgO
	 RwPHj48xrfNPa32X99b69FNP3aV6c9EF/pvWKdA7znQ7j3V1eNjma61UOL2NHYcRJY
	 J9G9eBjKxumdTxZ0lopeo6xqpYcwnNkUPs0w9EUcvIKzpuJcemA7rUQC63f2Xz3WFY
	 UWCQcarJufGbF4anGr3bGnIno3J+d32ZB+sNOa0wAUmk+FHGBoQk4K+G61+zH2TLqV
	 NsXcQEXMdzb3A==
From: Maxime Ripard <mripard@kernel.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/tests: Fix a test in drm_test_check_valid_clones()
Date: Thu, 13 Feb 2025 09:56:32 +0100
Message-ID: <173943698484.1868200.4955901862780721349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <c50f11c7-932c-47dc-b40f-4ada8b9b6679@stanley.mountain>
References: <c50f11c7-932c-47dc-b40f-4ada8b9b6679@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 18:24:09 +0300, Dan Carpenter wrote:
> The drm_atomic_get_crtc_state() function returns error pointers and not
> NULL.  Update the check to check for error pointers as well as NULL.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

