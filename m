Return-Path: <linux-kernel+bounces-429293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCD69E19D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F00289C78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63D1E1C05;
	Tue,  3 Dec 2024 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ervDszXz"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2411E0E06
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223009; cv=none; b=QReNdnGUvTZWvYFVBfX67BgvrYMnTXB1UkmNyKbafGK9iWog9JS18/RS1ywsLrhpme/FuyEmgfBz3aTcn++/6cJRdMDv49RyIhAaCcjHaHhexW3kat3txsYKRLh2m5wzA5hp8ycwI6ax8tnilH+6VImtp2e0ANCnGBpQ3ouIY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223009; c=relaxed/simple;
	bh=SYIWnqJvjU3tc6h0oX3EV+CMP9T1xXjaW/rfL4UV7+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OArIPUeJkmgYf2qq7Ewr5RQ+yEKCWAC9hwEfh5sW/2098QnDU1rGmr6dW4qeXpLC0vr+rdaQrDajrVhbsEcH4utyRUKd25rKRYRS/0sa1dVuKAKzNssdvEbjG6Eika9dlQYqsPFOUcthqGZOezQDhmWvamSdoWYJgZJuJjMQeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ervDszXz; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a777fd574bso21202515ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733223007; x=1733827807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRrhib0Kqa3gpxvZj/IdJvVp2U0qRI/cEqmhWx+o3pQ=;
        b=ervDszXzSOz/XxfPlJBE6PNFd20zc/WA8prU1VazxuF5YJysXp8GN4G17MdiK1FaqK
         4FN18dhWYwr0t4Iuo+3S7WH8Awha2+iiBik6F/5XxF36LQkLc/PEcuVg3ujV3xDvwxV3
         fgiD4U+IiKVz1OfszToEw1SwGYNgdlPCnNJZIo9+ZAmWAbYHbdwX6XZhZ7FhGrqKpUxU
         WahFXWQN6gF8jYU7a2W5sF6MDoIITxJJl7ZAwrFi9lfc7Jv+xiQdqfhuztu6UcShtUb/
         Q9CRIP5xLi6Gl1Aa4FGi2lqAe75m9Yn3fCVvyyxfcmsfNLVyrb2oAvfarHW6lmAhxc6V
         Gkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223007; x=1733827807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRrhib0Kqa3gpxvZj/IdJvVp2U0qRI/cEqmhWx+o3pQ=;
        b=IwEUBupd8AbDqboJe+tWbzr3ES12X8FsGFHPIvLZiVaRdPJRJL60F/81zPiS5atW0M
         do53rkJLPSqyDYabMjUTRtOlgxt+EpmfjL5r97FwjNg67xU6aHFvZqy6EfBzcko8WV6p
         69IBoOZIb964J9DmgUVPUl5Ruorp9TkldniDuElQH/s2Vo66tcW7o9qXaloQmyAirshT
         uxGQG6Zgh0KJNR+wilCcNGQ21nw4XgM3kV20TECtx4alYheO3nJvTo8vpJ/b0IowWP+t
         G2suEAW+vUKuhJBA//PR4thkAsOdiKguuSlohQt7IqThIJxfQjWS1AaO5YEbDVLgBTPs
         ymfg==
X-Forwarded-Encrypted: i=1; AJvYcCWJKHqBg+w/bpybf5NT9THWbX+yXFgTvpRuX7QLuTceCvsk/bYsFSYiPL3UDiMeJ9/dIsiwnwsOuwST4r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/62LS0LcBvuB+J9gUrSER/VYZfVJkQfFM66EP5Zhv8+Pqpe8o
	h7uaIuHUO0kZsHRTTVnMGSMB4EkwUgTvigFeR5VqQU8nrLKY8+64BhDfGz0nVGs=
X-Gm-Gg: ASbGncv25Poxv/TSllEU8+EydhG/aw7EHu8JA07NJ9uARKTn9wj/ZNRcuWCM3vR/gvM
	C4lEH/xJhsMOWf3wP1B8QBCltMFFWQ4VWw2fYRUTWa7SxjfqitcbYM90esuGBa2i3R0llHcA5WB
	r2ttGVY/0K1KZpAQQfhswI8qPMxhMzyfoPBTiH6hUe0AliPiNzfRBJ7UZEyir84SncFR70hQT2L
	zzd5jU4AyBQqEj1YYon4G87QNUyquvPgOKVd7lvVz4pQfK291Mx
X-Google-Smtp-Source: AGHT+IGl+KT43heBkxQ+hPgOKgFg2afkW/MI5pautzzaAO1WnCw2DNgd33igWPgCxY5ufydlibjV4w==
X-Received: by 2002:a05:6e02:1a85:b0:3a7:a738:d9c8 with SMTP id e9e14a558f8ab-3a7f9a295cemr28002915ab.2.1733223007571;
        Tue, 03 Dec 2024 02:50:07 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a0733sm8082097a12.75.2024.12.03.02.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:50:07 -0800 (PST)
Date: Tue, 3 Dec 2024 16:20:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
Message-ID: <20241203105004.fo4huxnbkl2jiu3n@vireshk-i7>
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
 <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com>
 <20241202205738.GA3149730-robh@kernel.org>
 <CAPDyKFo6j__CoReyAbeLJkA8JJQhJVc=umNesQRZKm-RxFHCwA@mail.gmail.com>
 <674ee1dc.050a0220.13fa34.f758@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674ee1dc.050a0220.13fa34.f758@mx.google.com>

On 03-12-24, 11:47, Christian Marangi wrote:
> Ok to summarize
> 
> - cpu node: use perf for PD
> - cpufreq node change node name to power-domain
> - Fix OPP format (already done)
> 
> Did I miss anything? It's strange these case weren't catch by
> dt_binding_check. Sorry, wasn't aware of all these common name.

Please also run "scripts/checkpatch.pl --strict" if you haven't already, I think
I saw some inconsistencies in the second patch.

-- 
viresh

