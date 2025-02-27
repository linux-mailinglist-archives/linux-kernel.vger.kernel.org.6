Return-Path: <linux-kernel+bounces-535948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C94A479AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11033B3463
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5944228CBC;
	Thu, 27 Feb 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiB89m7q"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215021B192
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650368; cv=none; b=YB++Xg7fIgNZMPnN3Zb2lYchSLXSWbpQUmyozNrAWnnJXUqz5JpZw2pDoT+0KQLt//mBPkK3es44Ho1xWk1n5KIbD6KH4lKxsx495YY2lx4sTCRY5nWhlAitosUjurDmVabG/4lF5Si1pj0jTOBbqlxrB/GHBQx/SmmwSH8juN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650368; c=relaxed/simple;
	bh=FZg92gkXljfLWp5xIWy5OIT7hy0mXlnkpRrty4FskTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPJmmBiIW3+unDLGiCo2CFe89jVFsQLj+mIgLYweQMnSLkjlz4nHledvdLnIX8I73LcP6bIpGlQuY5oJjlgX3cUQ30TgoH0cD3a/w4g8cTQITZIwj2MVAHLLJUOrdsmw/RRFh8dMhmvHtPdKWdvz0OGFhJsjVPHQB/wZvtHGuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZiB89m7q; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbdf897503so329868266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740650365; x=1741255165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEPF+BF1tDABXHmu1u7MFMwie0IHNzPzsRHwCtOuq2A=;
        b=ZiB89m7qyKVzoFyNAMnbdmCwClCceSk6lKG4WQ/gO7Lv1veISu/nlplRDUULD06JLY
         dH8bCfPCitlQZbTupauADmDAzKWy5ayrXi4ozNYQGO6sFquzqqMeP1Bx9OHiyPaR98Ds
         WYcYkxN9np1rbAqgFW1bQKYskeMTlFGgwLdhJtZ7xqbCRb9GUzwlerZxLgJneB0RgrPd
         vfg+N4vkgiz5PKmUt0PUPgBjiC5znlaV8Aar5czhuBAl7DQmoj8MUvHeDeU1IwLg8KpF
         fre7sW+zDJowf5/0n6xdcgfK294PdQ2YxrJ1vrVxcOE06fiZtNIa+almAHJamnciQUcZ
         auVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650365; x=1741255165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEPF+BF1tDABXHmu1u7MFMwie0IHNzPzsRHwCtOuq2A=;
        b=wNAqMNPA8RLaFMsMpV0byEnmshsSBROxjFd5Pv5B8O086dr/2Dzm3fQKyUouCqlb42
         L9ZgzpgrndCt5X0DKEGW2jRZX/xl+YqEs+/y/WLo1rKznAdUiuGFEc418eoZlrf31ZgQ
         s+pL4sOXKS+2Xs6PiiQcsbFZ3lXBDWXRlzJK4UAuBYit7WL7L3TBSOk/p+cgssd01iyp
         pZkSUaCS/YbbPRinirZcrlzHJrM2yiBDwNuCRwjachQYM8HzrtDROcntYpaTsVKoqlj0
         IH2oH/+lePc45WctNBVye7WmXN/RRz4KFeZe/iG3lT94IZwRLzw/ZMTzlFHj+P8aGg6K
         j0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVUtxXSPxaYOXulQiyxu53wiaRb7i20s5g4tSzZ2sGSH04diYaGc5GOqvHqtxrg6bSsycftGvIU5wFyzJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtMQCgEWZhn+JueEzOCxt0kyaoI6VFixrZSRirL65zKHI5l5R
	iXpkRFerNBZyf8/AIt4whechG8mO+SObzFGFc+Xr/fOvuEHCceW0vLCuKozglI4=
X-Gm-Gg: ASbGncuqzn5u0oS8CnGFIFKYOMcnaJZFLp/XDNixR275OXeSksX+J3LYpUzwBbX+WKT
	rl23IvA4wwX/2/2OQ/fxQmSZnP4lsYl+QSwNsdX4w2aRqE8mO00VzhIfaCTB04kkK4hGWqtn+S+
	xgKcFuNbsa0sr+ui5xd3Zquu9bp2B9X2+fSeWAHFvf7sEc/XfmCvJL9m33ObWX6mPYRglh3ye22
	CW0iRcVdiQsb0oWMKNy9Dy05xbf8wI3awWCcCtzZG9dgonrE98WM9haAZUorKTR6KdQqxCEBtsz
	GDeNBX6HFODsHMSA+ZVfj7D9rh7g+8Y=
X-Google-Smtp-Source: AGHT+IG9mCmnscH54kVfFF28h+Qv0TbfaejQ9tOnUBiZc5WmqAgsuv6yRgR8ejlnTJsblysvqegACA==
X-Received: by 2002:a17:907:c48b:b0:ab6:ed8a:3c14 with SMTP id a640c23a62f3a-abf0625d622mr372435366b.27.1740650364736;
        Thu, 27 Feb 2025 01:59:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c7bc588sm94441766b.168.2025.02.27.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:59:24 -0800 (PST)
Date: Thu, 27 Feb 2025 12:59:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com,
	akpm@linux-foundation.org, error27@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] rapidio: fix an API misues when rio_add_net() fails
Message-ID: <910d7ee5-87e4-40fd-b1f9-c1d99e4df304@stanley.mountain>
References: <20250227073409.3696854-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227073409.3696854-1-haoxiang_li2024@163.com>

On Thu, Feb 27, 2025 at 03:34:09PM +0800, Haoxiang Li wrote:
> rio_add_net() calls device_register() and fails when device_register()
> fails. Thus, put_device() should be used rather than kfree().
> Add "mport->net = NULL;" to avoid a use after free issue.
> 
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add "mport->net = NULL;" to avoid a use after free issue. Thanks, Dan!

Thank you!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


