Return-Path: <linux-kernel+bounces-403032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C74589C2FD3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9E1F218A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DBA1A00E2;
	Sat,  9 Nov 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wfgs76ln"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385A143725
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192742; cv=none; b=a0dVowjQ4BvALbBKGfngILmkTNb0/BF48nFeH4a/0NTj04/h/RhThe8XmEg4tvWKnrDy/061wePm9iHfDUSzuUNiD3NuOKTN24X3wZffiPJ4SmxYbNwLmUeSwNxy58WyfebfB8qRYxE2DLn28ZnZZV+E7sLwGVpu7zOfdwxrrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192742; c=relaxed/simple;
	bh=iloaAT4dSEQwW+ZQsL+VJVbl4AFJisJJ7l/vOa1dfpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8L2hRk5tM9xKx6kBGHYYqfZq+ZKUuWVqFQdkEG12WvnDjhd015wdDXY3EzAnu7c5Hjtwm2/0YvGzQ7+bdMu455aURqcU9MO+Noj1gU4Rq7LXK1+xPr++NbyOt1WI0oLYIu6nN91RxxG7ZBJMSxdOKQerfaCTIwU+m/CmhJL7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wfgs76ln; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=agd7DTsP3iDbnG7sWOzlCcsKSDrrKy3fQmFvesVPIFQ=; b=wfgs76lnTeZLn8bIGTGvj/GPhh
	rmaQ8JI3KX7xwRsd4sVZAtL8Hwg1O4h452xGUxoxaH5ocANU/BPzExe0jClK0Ap2ko4rROZ0afaKl
	j/00aJDatlW+2lL7WMVt5MjQvVuiAULwndxotzYbl+pXMm1AqrzXSlkUYzwACxJQPmwIF3n2qnxjy
	VWBaqB1MudAW0Ae3FgKor2rat8hGrqyWHUopbGGcizY9uZVAvoy2rZBXrbTlKlX54OUks/UC2RU/3
	2M7xK2L6WUKtURV15G6TRJPOumH1eH+j6L/WAdgQ3Hfo7ISiaRvKVilcajYTuyJZUSOEnxYnGoPN6
	V0dJ483A==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9uJN-0000NE-MY; Sat, 09 Nov 2024 23:52:09 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	hjc@rock-chips.com,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop2: Don't spam logs in atomic update
Date: Sat,  9 Nov 2024 23:51:56 +0100
Message-ID: <173119266840.1201296.2477223024161993614.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028074140.382199-1-andyshrk@163.com>
References: <20241028074140.382199-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 15:41:34 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Demote the error message to drm_dbg_kms to only print the message
> if the respective debug messages are enabled.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: vop2: Don't spam logs in atomic update
      commit: 712ec5de382d009396ced509e75b392d28871aa4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

