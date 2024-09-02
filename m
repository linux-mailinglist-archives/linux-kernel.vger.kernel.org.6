Return-Path: <linux-kernel+bounces-311005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46219683D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E75A1F21E08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22A61D2791;
	Mon,  2 Sep 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdyPVhpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB5187847
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270983; cv=none; b=ikiJz0zQ5f+vj/qvQWQ3TOAi75+EX5G2uhB2YiPNYrexV5TgqKEn2XZk0nX29XQKRZFh3sXeZZOfFMugHKE0lh9f9z9elaSinVhKR6Rj/lax90oydkxnR3q1kNQdUTXOilVLuT8xNnK6O4YQSpvd3bZqSWvOxnslDJMWjtXrWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270983; c=relaxed/simple;
	bh=K300WKnaTS4abPUqq0WlJ0Pe4/16zx5wnDedk/d6tsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1iR4mkLv8JsznrfLxYOiVYEH7PfkK8Bo5OBbmeARs2zulyGu+1aubNNdLEPM/YLG51lRFp0rrNuk2/OgPZYKVQ4ZZ3CNrjF3TN/UI0+Vhep5shazDMQJPhRdfd3RsSJGJHC1+kd/wS20YO6DODUIY6Cml9R36BfY2/eo8GfuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdyPVhpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2B0C4CEC9;
	Mon,  2 Sep 2024 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725270982;
	bh=K300WKnaTS4abPUqq0WlJ0Pe4/16zx5wnDedk/d6tsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdyPVhpFmv9UpRPOZQgtm+w2Vv7pzOC+9O0JR4S5A6ijfDM2m/JKNEPRd/1Lhp0HQ
	 hqOy96A62Oq7ETyk5Q2CzR+M7F2+O27auJ6n6lyc7PFaKOjmvE2mqV8lrbi0uUSWoO
	 7oihVzHOAQNKWjWE+4MWlGFQVvbjIXOZmatHFPomPKgj6fEHOQCcXX4HgdtkUYTSiw
	 NXQVzJEJINdrnxO0UeYTkmfr6XFh6+Di9ciAPikBxmCnVNVA4b5kaJ0WMX/O60RrZs
	 zqBF675RkCaaphG66Mux4M/eo7COj6rk2r24dNrzv1+hHYH3hOGbzravT44aYecTva
	 jz2IwkrSS/pSg==
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] drm/panel: ili9341: Remove duplicate code
Date: Mon,  2 Sep 2024 11:56:16 +0200
Message-ID: <172527097257.1571890.1200730115855091676.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813091258.1625646-1-andriy.shevchenko@linux.intel.com>
References: <20240813091258.1625646-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Aug 2024 12:12:58 +0300, Andy Shevchenko wrote:
> Remove duplicate code that is handled by tinyDRM,
> i.e. drivers/gpu/drm/tiny/ili9341.c.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

