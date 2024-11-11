Return-Path: <linux-kernel+bounces-403789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CF9C3AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D1B21D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3584175D34;
	Mon, 11 Nov 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X0a6FEtj"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A0175D26
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317217; cv=none; b=PZXFwWPIPPyFwm5g+jR7G83iHaoIHWaIZMtMWhFrDrBDRgLnf7Ue8tfZ816VDU8nyQcY2anC6AIYfx2BZfv5U+bdyKkk7mtG8kVUsXEHCN52XhsE8HTeeNGbMaGH4csvC9nMl8ohyNCNV7owR/pmbOetw1yiQ5qEIpASSuS918g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317217; c=relaxed/simple;
	bh=mgnfN2q0S7QgoKKl/Rauu5sGyAO9tc59zopJz1rrAdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qphimCOg4M1JGEIubr4QZhYi0m0dF6YIDzC/xtuQBKLtaOOFMdaLHN678OocBE209R1JSETY8G6Uy5XFIi0Ugh5EIZyL2r/kry6dTMyUX7DwOZOucdrj+nOg0jFGFKp7MiLCe2OH+haWgNAZEq7UlgP66J0EBdpZ/nSort3xmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X0a6FEtj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720c286bcd6so3612717b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731317215; x=1731922015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=brECuhaURidIOgej2HcdOUsYknBD6I4Lcs1/D1CO8rs=;
        b=X0a6FEtjcQ2FpXrujEcQAoffCiUlhwkIw6utF+m0UGWyzrfNPlyjtkUo4DVqGCPReq
         gvryHQ6TnFrmG9i/URxIUK3A67dnhsnQaJyEIQRjnG94/ivqimQAVMmWgNK92foC/yx+
         wnpOxl21X7ZAQVktl6j4txAYbWtLdtI7f1S1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731317215; x=1731922015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brECuhaURidIOgej2HcdOUsYknBD6I4Lcs1/D1CO8rs=;
        b=ZZUIAHgWPI0y2ztY/OEtYMlk2XG8YeMSHbz7ZIAvtyNuFB0lDza8aZazp0gqzsqoy1
         C6ksrPhgydm2doznAHoYmahyF8APVfpzud7AmZBUbL76OATPHKRs9F3be+DJH1/w+LC+
         MXmme/h5bpOEHRlzIFIjLjZapUGR6gHH0wnbDCCJPThM1z+4bZDqGOjqpUgY5ZjoT+Za
         B2SgTHp4z0ZIWJ8x31PoagRNKOi0mnygny2GiH/TTo9ARdn6Nn2Lu234AU8s4LLBXeGb
         cvOSkrcO4Cd/2o+llzHyu2PX2KDpKyxAfclsnKrPBcHLM1/1AVp0VHkdD6hsrH39LqiS
         Y37w==
X-Forwarded-Encrypted: i=1; AJvYcCU2mWOW/gNWaO0gVDngM2ckxcXhIoIyU7BVGybzU2dNmk2UVYwOnPMHs0QO3GZVp58yB0KVQcNHxindwLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTLu6uh1ZqSeD24jqB/dGnIEHKrHd8UJHOpqDCk+HqgeFz3o7
	cgomDucL+1b2Rn2luj6+x0R4/15mEiavlVDpP9ykWpCXuOeb9uDagasgkaPCtg==
X-Google-Smtp-Source: AGHT+IFv3/Z9/+3X9loXLTyXmodu1y1jPdWhOQT6PyEwQSEN4yeKKN8edDW3dCWplxOZylQnJGuxzA==
X-Received: by 2002:a05:6a21:32a1:b0:1db:f087:5b1d with SMTP id adf61e73a8af0-1dc22b94a7cmr16452244637.37.1731317214962;
        Mon, 11 Nov 2024 01:26:54 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a43c:b34:8b29:4f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860a42sm8662311b3a.17.2024.11.11.01.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:26:54 -0800 (PST)
Date: Mon, 11 Nov 2024 18:26:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: ZRAM_DEF_COMP should depend on ZRAM
Message-ID: <20241111092650.GB1458936@google.com>
References: <64e05bad68a9bd5cc322efd114a04d25de525940.1730807319.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e05bad68a9bd5cc322efd114a04d25de525940.1730807319.git.geert@linux-m68k.org>


Sorry for the delay


On (24/11/05 12:50), Geert Uytterhoeven wrote:
> When Compressed RAM block device support is disabled, the
> CONFIG_ZRAM_DEF_COMP symbol still ends up in the generated config file:
> 
>     CONFIG_ZRAM_DEF_COMP="unset-value"
> 
> While this causes no real harm, avoid polluting the config file by
> adding a dependency on ZRAM.
> 
> Fixes: 917a59e81c342f47 ("zram: introduce custom comp backends API")

Sort of feels like it might be 3d711a382735d that introduced
it first, but I'm okay with Fixes 917a59e81c342f47

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

