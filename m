Return-Path: <linux-kernel+bounces-336270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776FD97F164
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340E1282944
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7C19F42D;
	Mon, 23 Sep 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TCOra/PQ"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A73F9D5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121220; cv=none; b=odeWsfPF8RLTRjIWl23ObxmWPXGvHoXk8pIiNWuMB0t1nHr8HUOZ+zdNJP/rMO7VEOx4MD2UP95tlQfAqBRLpQW7CWY2lqqgO1kbjQmz6fmGRUyC23ftPcJqtz18xM9f3LJ6fqzzaVXvHo4NQRGgX7yul9pCnl7gibDJIbS6lBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121220; c=relaxed/simple;
	bh=deZIlRwr9MjW6pszPZG0mminhXw8RdDxiI4OqxAaV/I=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ObUUPSPUoRZnufBMHB9brTMqDxS4YidycG+Ig+qG2zd0oteM2gpE6MmJyTz65nnojXUvP87khgIkngUfE0GrOnXFHXAgNMgKg/8QhIBXrMAIMD1vEz78ArgBz0+mzFevBHX3O7W3qVIY6NifDYH1J1VAJehyGHE4UHZulyLRMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TCOra/PQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c354091616so40978266d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727121217; x=1727726017; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MH/lfr64odg7IIk5zQ7fDXQq/NRQz0Gg/qhKBjs5LKY=;
        b=TCOra/PQhC/9eYKxw753y8/o6IYBUr/5af9/aZnK8xYgglX9DM653Qx+WxM0Ph8FgL
         v0u4dfW+lUUGpZT51HhQwFF/FiSX95mKj90GQozvWg+ZypX5269OIdUocsEPXRbjPjHz
         8hF4tnHFQyVNPFnEXDG7Dofa4t+76aXi4JePIGe1Kaur8M/D8i5p2qd+hry3qVAgLGl5
         cgBwxK+8x7RkxCPDAWbnwzo7/EaiuNuUALkV9RAmrNIYQf0gi4RQz0lgwuTrGGsC3AZh
         3+yp4ghBpyQEJqmYSPvKth5mjvsbaumz8JuNZ+11pL4lnwnbyRSyYWhLqdc7tCNzREQU
         rEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727121217; x=1727726017;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MH/lfr64odg7IIk5zQ7fDXQq/NRQz0Gg/qhKBjs5LKY=;
        b=oXx+85U1DFXb0Bl1g76TOhiUHPvZi3wQud2yMRW505+JqqnMWVNsfRXboosJJs5CHr
         Mv2ZuCLd96/2Sr4Wx5fUILG8QRwACOnkDY2JAc9JJx4pAq157j3Pi5JwD6zlo3RcVTjP
         wLi6YGgNrb5g8AXJp14xJydc9YdGW3KaiVAk+sMEG3pfANkxfVxzVlB9Z9KvzEGWjvBD
         TW0KkkXxQG0y4LOHCimaLAldJD9c6MWNVitpe/1VDM6R/0JTneE65dsgnsJqouvvTpJi
         Gt/qgKm63wXUa1qN4Vt14gI0fCoQfpkFdNEZrRGxgZub+3H4MkyoYb5ceAotOX6+cbNj
         P00Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy4OzVOlDtEiTlEgdhtQKiDQOuMPWbUkMqL9yJRxzvSefi3Mj5ZhrDF5a9bUtjWggcsKOaY8Q1fVsSShs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTXaPdPx6XYV9Su1+z7inDGHxTAHMv+2AhwMKMO/b7i9vPC6y
	gFsoqyB6vr+5dCurITnhCIW7Ujo59rdQHfyaFCE3G7oXyKTWuavOLnCrQWGntQ==
X-Google-Smtp-Source: AGHT+IHFW9xNBvbhiH5cDVb1FY/rbkAnvM+MZRpocjHqsvJoehxzGmbLycvHKjogmurwT6GvBm1Bew==
X-Received: by 2002:a05:6214:5f0c:b0:6c5:b886:ebe8 with SMTP id 6a1803df08f44-6c7bd59d816mr179462856d6.38.1727121216850;
        Mon, 23 Sep 2024 12:53:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e586b42sm50380286d6.138.2024.09.23.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 12:53:36 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:53:35 -0400
Message-ID: <9ea74820c1d8524319692483583546d3@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Guenter Roeck <linux@roeck-us.net>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH] ipe: Add missing terminator to list of unit tests
References: <20240922145226.491815-1-linux@roeck-us.net>
In-Reply-To: <20240922145226.491815-1-linux@roeck-us.net>

On Sep 22, 2024 Guenter Roeck <linux@roeck-us.net> wrote:
> 
> Add missing terminator to list of unit tests to avoid random crashes seen
> when running the test.
> 
> Fixes: 10ca05a76065 ("ipe: kunit test for parser")
> Cc: Deven Bowers <deven.desai@linux.microsoft.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Fan Wu <wufan@linux.microsoft.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Fan Wu <wufan@linux.microsoft.com>
> ---
>  security/ipe/policy_tests.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, merged into lsm/stable-6.12.

--
paul-moore.com

