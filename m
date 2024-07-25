Return-Path: <linux-kernel+bounces-262366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B175193C5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EA12821F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20A19D886;
	Thu, 25 Jul 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lj+Dk2V7"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A919D062
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919611; cv=none; b=rVjXoUZS2GFX7EODZXmw77ZreD0vVoB23W8g/1Vw32OSi3/64Abp3od5E+EL173KwTvSVjZiAr1rOYETI+HgJ+uNNuUTp0g5YZjJldZoZKT1Jlef2ds/RphZeaTNAl/YPPD/mV+PEuV/mabKHi4wx8cyX04BgL5UlPnxlVado9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919611; c=relaxed/simple;
	bh=4+7G3tspcvIA18RcZDSVjgfkOmhgNLYcPE/E3LoZGzk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tvf2UJ/JK4lye3ZWOa5Y+03bXIjB7puHXY99ImtQjR7rVnU69CeZOYAD1PqCOsFOW00EPfj7Z/dXvHGTVPHLVg5Y+7ye7fgC8q0qwUzbVW6A5qoIq7xvH4tRXrl/uVkfsS35tqqTeNZ/XVLxCMCdda23hEb2V1KajgJsR+22uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lj+Dk2V7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367963ea053so744110f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721919608; x=1722524408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9Z4931Osuxi1qIHEscDRPOvBVDoh/CRmYBymvn/ZBA=;
        b=Lj+Dk2V74Wwihkgel25WTeByaZzcBfd7/exXLFPDy9RVw5K7bodOelPktM4CjKcFzI
         yg95I24FvlOGNENZXhuWijGB7AgvWRFeJmYmrb8Wmpye1EbHwLtZaMKyfPP98QdJDmBi
         sDZv5GrJQj8ekYD3AjE1J6Q/HE3e5tZHKi+CTaHtCCGHTRE6nvRGIzgdQL38mCcto8z6
         147F8pwhEcpjg4KBfFm6S2sk5Omq+awn6ZC5xSiey8U3dfyXvf/SJVJdHR3MrWIh/Mei
         XOv64lTI1uHWULn/BUKtBRLqyyK0R2eACuiEn/RpSrQnuTvKiqfGQfRn2Jh5wuIpE53k
         OqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721919608; x=1722524408;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9Z4931Osuxi1qIHEscDRPOvBVDoh/CRmYBymvn/ZBA=;
        b=BjIZzJRmrb5uGLUq6UZ8RmJc0TnadwF2JTm+xWh6z5fdg92RFdq8YdZlv0ksw1wVde
         Z7JqSYQlTZOxzY8pzgHGRZBTWh1HqZPHSCES3k6+Uf/lrG62KPw56QW5jEWvPDkb59vI
         I3LByy9l0UVB1XmzNtB4Nwc3xJy/P8osjEiAGm/bF0Wh0H4U+NbRlhqB8ixC9MAca94F
         iDpA3W2USoeN05OBDuPUkqGhN5+8iiwZRuWA8tWnG8gIWxyvH3MO56sUCvuuM799qOLk
         bw1xzdRzDNooYy8bB7mGvKmnGWYIg79W/tWyI1lSm5zjOun1lBkejfoxideouCKKyyf2
         QOcg==
X-Forwarded-Encrypted: i=1; AJvYcCUsNFa+b5Rv/XVvbR5khi2CXRVD4yUgXsc3+V0UDJPh9ELPDoV4VeJ4SwiuvsbEIrqsR8mucoCYRKxxiQIYkvwoOFDNX/wJ2QA+W+ac
X-Gm-Message-State: AOJu0YyoXtJN2w1GGWVmUMFdjCRR21DyY3Ebgj+b04IjMkDPfdYgEVQG
	9p4maliW+IRakqvu3CheLqkZHVO6Ps392JgQuEDsqBVxGT3XlkGgdqm1Erukgn/9CF7HEDLvNEA
	X
X-Google-Smtp-Source: AGHT+IHRCPqWVQXC2M7YIeZJcXzY2G3V2diN5IaoIFfqBHPCQ6aIbCtS+NN5DGnwuwi/xs+tmtNdgQ==
X-Received: by 2002:a05:6000:b87:b0:368:7943:8b1f with SMTP id ffacd0b85a97d-36b3643c8cemr1971438f8f.43.1721919608012;
        Thu, 25 Jul 2024 08:00:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36858148sm2507984f8f.72.2024.07.25.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:00:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, mwalle@kernel.org, dianders@chromium.org, 
 linus.walleij@linaro.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: (subset) [PATCH v1 0/4] Break some CMDS into helper functions
Message-Id: <172191960720.1560006.12723976790415124452.b4-ty@linaro.org>
Date: Thu, 25 Jul 2024 17:00:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0

Hi,

On Wed, 10 Jul 2024 16:47:11 +0800, Cong Yang wrote:
> This series main purpose is to break some common CMDS into helper
> functions (select page and reload CMDS), refer to the discussion
> between Linus and Doug [1]. It is expected that there will be no
> impact on the functionality, but I don’t have an actual board to
> verify it.
> 
> [1] https://lore.kernel.org/dri-devel/CAD=FV=VssfZBxwh6i4e_mHhT8vZ_CnXCrUhoeTUeo5xN-FmASg@mail.gmail.com/
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] drm/panel: boe-tv101wum-nl6: Break some CMDS into helper functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/93183c9959d456530ae502865586522acf21adf7
[2/4] drm/panel: nt35521: Break some CMDS into helper functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3c8d2d5da3e29f73fec6e04a424e789422f697db
[3/4] drm/panel: nt36672e: Break some CMDS into helper functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d969b31afa439f71f810076a5612596dae38fd86

-- 
Neil


