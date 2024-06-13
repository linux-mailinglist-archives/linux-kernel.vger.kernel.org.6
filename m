Return-Path: <linux-kernel+bounces-213588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBCD907746
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FEA28E50C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365A158D65;
	Thu, 13 Jun 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DekLwn8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847E15886E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293224; cv=none; b=NQCrivA/Zz/oYyH0Sd+zP0AWUzJH1YULy9KWj8P6DAz/ictw0OOvo0h4+eaX0AfdoGfl3MxrZAFKQBKNYrD2fwFcbZyCWsYniFtIB9/1CPzTdLwd3eHQIbxnCn7OdF2pfxnhtfmpiH89rlIV7PvL51YxcYKX3atUWPVqSUFfP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293224; c=relaxed/simple;
	bh=bA3t750aLVe9+kIvYa78qWA/d7Nucom/3lQQGHdYrOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=po23SH8e4+RFZyVquwGtDbC3FAuPsFmxLoQpEWEtvjlGDpReugOEfYrcEJdh/jgw/2eqiQ3lEcE1ZCrSe3gNZDzoEUdCrmfVki8/Nb7p4KSDzG+GqmFp2p3eZfd4MlXGpIFj5hpVcWeu8tJevtTsLgDVbN1Wkl1yJjq+TEMc0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DekLwn8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A279C4AF4D;
	Thu, 13 Jun 2024 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293223;
	bh=bA3t750aLVe9+kIvYa78qWA/d7Nucom/3lQQGHdYrOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DekLwn8JNT4JQ5q8mjiYg5MEqhVrqr8EX0gHPo/9Foy15v21VeCsBRf6g44VmHFaZ
	 FuUS4dk9vhT0HG8Kqbmuu61WjrB+oiAaD1rMaY+OjNobK4smH1K8IDKgF0/8yfqMVA
	 yPF0kAOJJ0i+gOXOGLoFJZFO5Qry+z8OMNS1adDhiOC1I98jJh25UtNwSAm9UK+5ij
	 pXjX0z5NdJa14su4CU9Jf6Wn+MZUaLStoiwrijiS2XMdT6Morcm+yoGShbUN8BnL3L
	 sCtZjDrnSzS5wFwQ195mGSQAe6UnSMlaP3e4tjKQmoNxb4sq3k7m9sxK0hUSc9ZAm8
	 tJEKXP74llFAg==
From: Maxime Ripard <mripard@kernel.org>
To: linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org, 
 sui.jingfeng@linux.dev, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, sam@ravnborg.org, 
 Jayesh Choudhary <j-choudhary@ti.com>
Cc: jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 daniel@ffwll.ch, a-bhatia1@ti.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20240613083805.439337-1-j-choudhary@ti.com>
References: <20240613083805.439337-1-j-choudhary@ti.com>
Subject: Re: [PATCH v5 0/3] SII902X HDMI Bridge fixups
Message-Id: <171829322089.1494794.15521482935825350505.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 17:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 13 Jun 2024 14:08:02 +0530, Jayesh Choudhary wrote:
> - Move the mode_valid hook to drm_bridge_funcs structure to take care
>   of the case when the encoder attaches the bridge chain with the
>   DRM_BRIDGE_ATTACH_NO_CONNECTOR flag in which case, the connector is
>   not initialized in the bridge's attach call and mode_valid is not
>   called.
> 
> - Also add this check to the atomic_check call as suggested by Maxime in
>   v1 patch.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


