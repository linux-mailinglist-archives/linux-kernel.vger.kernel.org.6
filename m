Return-Path: <linux-kernel+bounces-446232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E99F2185
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C6A1661F1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C101B6CE3;
	Sat, 14 Dec 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rWx5GosI"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908B2940D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734217880; cv=none; b=kJvdfo5Z9NeMEKLRaXJYrr3sjroGbrQFM1s3Qcot2qZTuPN18s+TXTC811lU+tYI9JDnPxmc3ZsuxKyD7ve9DMaXbig+sLTErJ4it7z7X0/mdChRLgH0RFbiYuvGfEQCjLHulcuwbLGVUl16/eG5g1LC4F11NfrxwaoJZCY7UkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734217880; c=relaxed/simple;
	bh=zLiMbF99KU2BQR/Z5xhF0Q1dI7hESZUBjckhE+4hosk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ym3o803Zs47BL7nGchlMNPryg6/tsHwQ9Hi6f9m6vXry9uMRR8LH2QBHqp5QA+4eiIVNbU/HLUu8v2KgOsTzb032u08FQtqp+jg10kx5IxKLi7rK8GJakTNJtS+yBuVlLAHJpgHggn9NLu46kLYrM6Vh3wvV7TNcU+LjDpDE9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rWx5GosI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P/dcvQTM5YLir1CGChPDq5O3U4OygiIvAkfxT6zYGWE=; b=rWx5GosIifj3o81oaRH7i/IVUj
	OiZVASVPZd75sZTE1/xHrV9mF+dh5vCHP9tREHi/ZUmc9SjNBBfT+I/tcyYFQyVqwVjZnQc3wYJKE
	jW/CJBkFJHJJkvlhMpW18nGLUmIoeN3GYJ550w6tpfeQ/4UeeGogJz/u97T45cz7f6JTYYGT31PvQ
	qDF+C1fdBIQoWf06XVzuz8+W1eLyMkal/2U0wewFxyczhJWr2fLjom8b4FoatPoQiWBvbpUpk6Od2
	9En2e55rpk6E7nAu2b723DiW1jeZmEnFSnFzEasAmKsMWzSHV9tGl/m8gK0lFeRAzLjLJeW64tz4u
	vffYUgdQ==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tMbHy-0000hg-CX; Sun, 15 Dec 2024 00:11:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	sebastian.reichel@collabora.com,
	kever.yang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2] drm/rockchip: Fix Copyright description
Date: Sun, 15 Dec 2024 00:11:06 +0100
Message-ID: <173421785405.212079.15956339456077528024.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241214071333.3325308-1-andyshrk@163.com>
References: <20241214071333.3325308-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 14 Dec 2024 15:13:33 +0800, Andy Yan wrote:
> The company name has update to Rockchip Electronics Co., Ltd.
> since 2021.
> And change Co.Ltd to Co., Ltd. to fix mail server warning:
> DBL_SPAM(6.50)[co.ltd:url];
> 
> 

Applied, thanks!

[1/1] drm/rockchip: Fix Copyright description
      commit: 041c664da0691a72aca67f72ab6a13789631358e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

