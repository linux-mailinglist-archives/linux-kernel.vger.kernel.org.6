Return-Path: <linux-kernel+bounces-233573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A197291B9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF3D1C22DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7451487C5;
	Fri, 28 Jun 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+QV+aaI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF239145354
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562939; cv=none; b=J9gaUejaVrjhFJLikumYDRDqseRDhRR66ZzxMHOapNNPJig1I36rb4aOI9rEtqPUAGXbDXZ2QPStNSFhlY/9wM5+RZDwyBWfGdNLNiaIMY3qMITXp9HxwDU+KTnMmAcn1MA97gBb6L5X9tdhv9S2+T3mmWtFndMRpjmKsx8Y+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562939; c=relaxed/simple;
	bh=crLTz1c1AmA1Zrl/Lc0Dxy5Jh4oZQcyygTWZdMs5yNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/ykBbGyLNHBU6lH+62BQE8nRlmLyGC0FhgcxYWFWy4hpU21vAhXKQL9bLyL6vE0x98DoSSGHJO3YQ69Noq0C/s5qe8qniaUVMmza/ZhHQTo6BVy9MhINCVyB1gwYRaSio0MtH64nXv2Xgoy5tZN7XAbOXifJyZV9XEH7d9P6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+QV+aaI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso2570235e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719562935; x=1720167735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iLumAAOtFBvsHpsP3dUUUzzug2afUihyt6mM/795q4=;
        b=D+QV+aaIpWr5woI7xX1LAed06kHkeXGfC3BVLNSB4WLxZhFIonnmztHTzb0bgprtXB
         WfrFSTKUp2wHGRB7PdL0IwWIAdd4ereMuIk/IINfpTZDFJhYH7wPXPBRH7Al1BNDHqU3
         axW+oWQBu/ydRRm22crCVS+IE7fWvZzgzENECJn4iZmL07DuYqK6LQMXUM8ndiDvekmH
         4d+Ax9pNR46hs3vg3AbqqxHNaKHTo5LERGssiGwttotop+df+BOr2DKtoOwiFrrEO2vi
         QE3vE465TNCnEb9YUvn+zHIF7FT1LnSn3NG5zRvvRCgissNFOZ22LF4KnPCDVq2NodCx
         JxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562935; x=1720167735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iLumAAOtFBvsHpsP3dUUUzzug2afUihyt6mM/795q4=;
        b=Ys4RljrvW1fzJ4nVhUOYngqtLGUwbAetIIk+VEgn+gp8m0lHebU9p7KqRNIF/ZDKws
         n5JGBYtPv0Fz6IeqU3CDmDgrxQ6gM2EGnJa/afgfHM1RdmsTz3LIu7gpwXcpUQAiT3Iw
         k041JUaFx+r7ItvHXQoAfXHk9/GHqdj2lDGIeCc92bCIEcn3dwREzY4fkBX4tCt19Fkh
         MZsA6e2fAGLH1m6khc7+iPP3G0Kd994sbdfIIRpATcEAJSJoOpLzcMWA0m9yEM2AnhC1
         QvxPVjJ0fK6P9gT44b50hlA46U+SjDhiaDirkn4zlPW136pSf3NvljkykfFATGQbc8W/
         5oqw==
X-Forwarded-Encrypted: i=1; AJvYcCW3IC97JdGRaSezJ9V1CSqYuVyAMwmn8RpPj04nM45ZhGsRpRp5xAd9mO5VSTFgtAere+QqbOWMr/wOskEagqUFHzEdZWd7bLD4yXp+
X-Gm-Message-State: AOJu0YzQdwyxWVz1FSntq88bjbsHHBPyy/lwxbsAfJp17CseqG2Q4/Lr
	3v9Hm+GZGy8Ji1SC7++BlUMpLUi14xphvtke8nctLltRvLykRz+ShuybIzUCCoU=
X-Google-Smtp-Source: AGHT+IGBucHdkuDKMQ6DSRWOJOV5ZyBVxKbIQm5EuC/EJ/VdLJlaNUhjjO0R9VBwl14uIozB0iSfcA==
X-Received: by 2002:a05:600c:4311:b0:425:6bc4:c006 with SMTP id 5b1f17b1804b1-4256bc4c2d2mr10955275e9.16.1719562935204;
        Fri, 28 Jun 2024 01:22:15 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af376f5sm24085485e9.6.2024.06.28.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:22:14 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:22:13 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH 01/43] wifi: nxpwifi: add 11ac.c
Message-ID: <Zn5ytQtySds3Ix9g@linaro.org>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <20240621075208.513497-2-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621075208.513497-2-yu-hao.lin@nxp.com>

On 24-06-21 15:51:26, David Lin wrote:
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Hi David,

Please read the ./Documentation/process/submitting-patches.rst

Just a hint. There is no commit message.

> ---
>  drivers/net/wireless/nxp/nxpwifi/11ac.c | 366 ++++++++++++++++++++++++
>  1 file changed, 366 insertions(+)
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
> 
> diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
> new file mode 100644
> index 000000000000..3e14ee602cdc
> --- /dev/null
> +++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP Wireless LAN device driver: 802.11ac
> + *
> + * Copyright 2011-2024 NXP
> + */

[...]

