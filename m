Return-Path: <linux-kernel+bounces-421861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5569D910B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736DD169CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1769D31;
	Tue, 26 Nov 2024 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bN81gMN6"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9953EC0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595562; cv=none; b=AZJrJuTqs+BacfGiEKqA34poGLvOvglWe4fKu2Ri9Y6Jw1un0uqiWR1+P/YV3Hptuf4IkhWENH4RLY38KJIhiQ6kD/Yv14ZU9ZA8yvRE29vwpBM7c2G3OIfLgy07P5CLUsffvz5FZymkR61r++XOfHIuZ4SfjDyo0MuHFPjc4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595562; c=relaxed/simple;
	bh=wugeIFVZuQ9tQQCNyCWGQ5BTAZDhDWii7izA/Hi1bVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj/nnXeVabMZFPW3QAQ15WD2e6q5Q+DnBigxh7N9joNPNL/8Vle7odH7/pfahT8ziULWMEfeoxsI/Px5MEcsn1/41mark2Joga8mv5b2rW0DbLPRNLPOrlfeoYEtHdEL+Ao8NIYoJzMWfF3oarUYya1bdgpkf2H+g0b3cvEzwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bN81gMN6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eade1cad26so4102948a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732595560; x=1733200360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj9qgfhpew+joz5eAIS43G7ysXnxDcyXL0gGD9SLu88=;
        b=bN81gMN6SOebynFEKNUKEGrwcLFNKzwN/AuCuGKzsbVIFybIBc7XTcQaEpEooCKvvX
         YEbnZZjLFl5P0YnVm8m03jfGiilaHaQyqFl2H8fws7L5TkgzWaY4NkpsnOJ4IlhrJevo
         C55CKWITD8lMpTpZ0n60R3Ovbox0RGrZ98IME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732595560; x=1733200360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj9qgfhpew+joz5eAIS43G7ysXnxDcyXL0gGD9SLu88=;
        b=oVP4zytqSYTeW2c52rDY54D7sch0cIdLUiorGW5S7GWb3aRxkDHTUyAFRpbHOO1GjH
         8QrCqj63PeepmX4dEEvr7Bh7hnr1fwFhx+BG5zTIhg8kts30MfsZr9Sss4WV5oLFsBCE
         1a8QlhmJC+M/stColLWt/ls7j733zjxWxTbXGexQblghYlZvPuJJtkcbRU2VJO1AJLEz
         UZXRjXxya7eEapzzQ3RFPG7Aq6e2pwWms7fz6/g+IagLYWi7Z9dJ6fFa4c2HJCR6zXCy
         Kuf3lj0G5UNWB5HKs57otg+dr7upUwq6n0bN0aZtp5o3lWSiju1Ctx5JmUdLlZHo17jx
         Kgkw==
X-Forwarded-Encrypted: i=1; AJvYcCUT7vhEalvJ7v1WhDLOvczePuyXuknaBTrbHcSPDDQ6Aa/MXhbQYFiWuE2RQXl20KgDmxJFljrSEWvgopk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDp1cZW9ZISx9hdhIw8WwALsQPnGQNvWa6F3ne9dATo/88y0py
	2WlDt4hH9ttlUTLQ1tm25j2EnxjcOrG9QTVOpeW0wH8iXe6BPoCMREiPl3jZuA==
X-Gm-Gg: ASbGncsHPYOH4lotOSFO/whMuYumyiw/YDOqE3PzG63NCSl6HhfEQjdXcqah9ID/QwS
	NePvwjhAEcSv9y8zI+Yslf2uFKjHHSP9Tx2QCIIX8qYsRTopw5MESK+PAH7kjH5n+BauZ0Hj+HD
	tfJ6ixt6v7L62bZiFiCz2pBheRBAwbMEoBsmUx0m154SsRXo7sceK0Fp3NuaI57FIpFa+bJ3WIH
	WqdRZEBgFDyXoXuCeBmzt/Gy78uBVyZEdeTIls6+n7e2wq/tdVK
X-Google-Smtp-Source: AGHT+IE6782zuODFee99BheWhco6CMCToJMqye6QDHvuZHHJs8+0En7RLAL1hfPEuaUYRDTNmCBDDA==
X-Received: by 2002:a17:90b:1d81:b0:2e2:e31a:220e with SMTP id 98e67ed59e1d1-2eb0e1256f9mr20707685a91.8.1732595559907;
        Mon, 25 Nov 2024 20:32:39 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7631:203f:1b91:cbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d0451afsm7641478a91.32.2024.11.25.20.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:32:39 -0800 (PST)
Date: Tue, 26 Nov 2024 13:32:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Saru2003 <sarvesh20123@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, corbet@lwn.net, terrelln@fb.com,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: zram: fix dictionary spelling
Message-ID: <20241126043234.GB440697@google.com>
References: <20241125024927.GA440697@google.com>
 <20241125165122.17521-1-sarvesh20123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125165122.17521-1-sarvesh20123@gmail.com>

On (24/11/25 22:21), Saru2003 wrote:
> 
> Fixes a typo in the ZRAM documentation where 'dictioary' was
> misspelled. Corrected it to 'dictionary' in the example usage
> of 'algorithm_params'.
> 
> Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

