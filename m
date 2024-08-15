Return-Path: <linux-kernel+bounces-287814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AC952CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE6286946
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1719F471;
	Thu, 15 Aug 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="14QS5XXz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153031AC8AD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718464; cv=none; b=pzPa/FedSZOshT9Wfap/yQjzcPlIQ1VWA4TfX/fmTIVuNI71rn4XnIY+hAfRK84djZETmJdyU64kLemhFZspJc4vSIlpJfAWe27jNd29zBAGHuh0PBsnbbgA2b2X4Fn5PBt8uJT8CgeyKxRJCHMjl2E+ZkLSeyn7xDC1f0KRPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718464; c=relaxed/simple;
	bh=0A3BeWpT25SIP9LGQuhq01i2QuRx5hRzSDRG7Z5bs/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWaHf6/4shr0lwmzoZp9D5KxglHv5cAhfY97jr95vJbE0/fmwsX8Yj31ZeYhU+DOshv1TADfLjGuy0XV/gKGH5jZCEpQwlQAW2rg51xvZ/2jRWf2iAT1/ujIofHxgf0K51sSqVhfcFWi0GV5rZ+xbbNS5STZSPN6jbeoBi8dkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=14QS5XXz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vhK51bOti9km8q+PAjJsqfOkQmP4br8Lmu/o8WHP+Ik=; b=14QS5XXz34UzotjhZznoyjzdEA
	zzVIpq0gV+HQvvrrJl+RHNosEAzZHvmkjOgS2pkFcoh9l2JVbzIBfUGh3umXdsH1RtuErY1TeJC4v
	YsO0h5O+HWa/+RggLJ7CWM5dxiwUT4fBBEHqFSgxiVqJpFFc/1gBg5vZu0bUG0jGD55kPyaEg0CL5
	rP5GftLnRDfH+inrGQca57zjD6Um+JRCef3VzAuIuD9lMWbfqeTGf2SxHeinQmE7kvFPeQg25SHiz
	S/G6I/Ws6i0DRDYqkcMvU+lfN5PnBAJd2vYptnxuMyoX2tEbEdMnbxGDaVMrho8yOikQNBOb1TKec
	cBH0FPwQ==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seXuX-0000oc-0A; Thu, 15 Aug 2024 12:40:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: inno-hdmi: Fix infoframe upload
Date: Thu, 15 Aug 2024 12:40:51 +0200
Message-Id: <172371844381.722173.15806804441564466230.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805110855.274140-2-knaerzche@gmail.com>
References: <20240805110855.274140-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 5 Aug 2024 13:08:56 +0200, Alex Bee wrote:
> HDMI analyser shows that the AVI infoframe is no being longer send.
> 
> The switch to the HDMI connector api should have used the frame content
> which is now given in the buffer parameter, but instead still uses the
> (now) empty and superfluous packed_frame variable.
> 
> Fix it.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: inno-hdmi: Fix infoframe upload
      commit: fd45cc614b8acca5bb435ba37fe9b3f9a17fab84

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

