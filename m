Return-Path: <linux-kernel+bounces-449646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DBF9F5292
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1253616F3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498311F8AD5;
	Tue, 17 Dec 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVC3S9hW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538E1F8AD2;
	Tue, 17 Dec 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455841; cv=none; b=hJ61HxWmLM/nLvPL6pF1oeETmm8B221SHvYGfX//vQsMk5hGwqRnxG4MrOdWRPLLRWwjOpvklYAS+xTQmu5XZI2uNPJiOXg8mwcOac6gKEdEdicyPjOvDzbVZ8ht3RiJJSY70m1+uyDFMJlvcOZ3CRm7yCj775L+0ul2rh8NtG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455841; c=relaxed/simple;
	bh=ShnuhRKLJAWLhwiEBbRAgFZs8muCXQgYKwgJacDbW1U=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=VJYIE/YUHR+YxJWYRsGULGo/+qiwOcWQ8Lr4fZGh+bHjTQg+LULdkPE79pITo94Jh3gLzn0PQtUMS2XHZeFGMfzrdHIgR+lsrsZDDsPLGsfHsDr2XPwwh7V/uUGHb7Q61UoY5CDOSuWmTU9H3Tc9rlieFOdvvY5pfKOedQ6+5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVC3S9hW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AF7C4CED3;
	Tue, 17 Dec 2024 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734455841;
	bh=ShnuhRKLJAWLhwiEBbRAgFZs8muCXQgYKwgJacDbW1U=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=lVC3S9hWfTvwAJ7d5e1gXPSB+G7bSyUsWKjUmzD+P+jnAV8CiRrA9aqlNLXxJ9YTR
	 abcid6dszSTROTDpH+GG2zjaFv6TqdvJ+8bFlafJUyl1Vxb8OAobFMI2cFmdhz+WE2
	 Amtt6bfq81pCrXOmnhmyaLTnbceCbk45Ma+fWW4Stx/QP/sk7FELWER4mLuAXg/yKR
	 Yk80H6xCP2ncKqY8C3FILEz8qxyaLNFT/3pqPjlxmClf+LVwgTDJ0H+WIOwfQvjmTb
	 HQPDPe85Kq7pgKtvFb9twyOMAWprRek+FUYC+SnBXL2AiaIZ0g7UuLGSCsKgl1HHS2
	 5jtFg4bwLIpWw==
Message-ID: <012deb5055f884e3c5374e1ead48fdd2@kernel.org>
Date: Tue, 17 Dec 2024 17:17:18 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Jessica Zhang" <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v4 02/25] drm/tests: Add test for
 drm_crtc_in_clone_mode()
In-Reply-To: <20241216-concurrent-wb-v4-2-fe220297a7f0@quicinc.com>
References: <20241216-concurrent-wb-v4-2-fe220297a7f0@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_abhinavk@quicinc.com, quic_ebharadw@quicinc.com, DavidAirlie <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>, JessicaZhang <quic_jesszhan@quicinc.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marijn Suijten" <marijn.suijten@somainline.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Rob Clark" <robdclark@chromium.org>, "Rob
 Clark" <robdclark@gmail.com>, "Sean Paul" <sean@poorly.run>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 16 Dec 2024 16:43:13 -0800, Jessica Zhang wrote:
> Add kunit test to validate drm_crtc_in_clone_mode() helper
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

