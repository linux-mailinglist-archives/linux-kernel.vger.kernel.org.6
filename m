Return-Path: <linux-kernel+bounces-390261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762AD9B77A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C1F281B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC43198A2C;
	Thu, 31 Oct 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqf6xRJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F85194C9E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367305; cv=none; b=JzgB4U1EQ039n3e1G+nhW7tmtXotaC1WZ/E2WJX/kN4P1xoo/FahJFqOV6ObnbyilnvvrcjjbIZw1jiZJyR7JAmeShDRJOChCuv/BY3kygSKQVVvPn+cSVsEN2BA+Vq813y1raImzv1FjGkMghCUV0napB+8rsNkSORmwqHPb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367305; c=relaxed/simple;
	bh=i1JF5hv7vtBX8g03vZ3RISaGgraP8hZPC83GrDkms6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9EKQ61Cfwzbd/MPPbP3QXLITY9V1weIraz7o7e0SXa9rOJsa+qKKUy1iQj2UxxE4OxqpQx9pscTFWo2X3HbsBD9FRT5bM+BKIqZFkh8uJxCZ9dZXfaX7kl7oLTh3razBtPIe9OrcHpDC9MQ3rMm8VguDqKJUq68GOkILs8rVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqf6xRJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACB5C4CEC3;
	Thu, 31 Oct 2024 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730367304;
	bh=i1JF5hv7vtBX8g03vZ3RISaGgraP8hZPC83GrDkms6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqf6xRJhhUbnRaSrc5A9DYzADXahx2euct7LThTvHxAIluNdd1u+5QJry1DQXtDeU
	 tV+Xq/goTF94FxDGbNcJd0YcH5753belkEEaTfsFY7NhcIYD4LDF8q2uqYVN7mmSaK
	 za7eyFTcnnoZ1odY9kAq79ZQBk/x7QiYM3SLMjgQr8cUVboFDrf/VUBXtip/Ptfz4b
	 quary7EIDeq1uOXlmvzR5thBrP/xLyKTPkTxkeXsnHk7ylNeyU7JROSZKZaDZDWtMD
	 pOnEPdydAgz5d5BN+rcw4sxEc4OlcBXnUgtnmupDON/72sc0QYcg+Kit2a2GFov/wX
	 ght8LE16U0Z3A==
From: Maxime Ripard <mripard@kernel.org>
To: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.baryshkov@linaro.org,
	dave.stevenson@raspberrypi.com,
	quic_jjohnson@quicinc.com,
	mcanal@igalia.com,
	skhan@linuxfoundation.org,
	davidgow@google.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 0/3] drm/tests: Fix some memory leaks
Date: Thu, 31 Oct 2024 10:34:48 +0100
Message-ID: <173036727981.2456570.2384235382375387545.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030023504.530425-1-ruanjinjie@huawei.com>
References: <20241030023504.530425-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 30 Oct 2024 10:35:01 +0800, Jinjie Ruan wrote:
> Fix some memory leaks in drm tests.
> 
> Changes in v4:
> - Return NULL early if drm_display_mode_from_cea_vic() return NULL
>   for drm_kunit_display_mode_from_cea_vic() helper as Maxime suggested.
> - Split out the separate ttm test patch.
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime

