Return-Path: <linux-kernel+bounces-436100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CEB9E8123
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF1E281ADC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F214A0BC;
	Sat,  7 Dec 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTHX3whf"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C43288DB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591275; cv=none; b=E6/Fvyi1yiQU5dx7LOewnv6wt42XYu9YLGSnOstbg3A+wiuoYBLdJQ1B6+xy1pLe1Ps3YfYY6f0m4c1RjXqWLIEcO1OT6mbBk3yCr/nznLuoAz2WqTYabFBc/oBQbk7zljUeBBPvZYNPQj3JK1eI0PfANhAxme3yLFUmiZJrXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591275; c=relaxed/simple;
	bh=6Fwkd5+NYkMOBlBy1d/flglYMZo39/21KFlyI6RzobY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAHd0M9TJgXAnUpE1VUiOaqufZe8Pl4+g/BVZ/sQLTrqScmE3L8lMHN0aucQbpvPrOYcyDwA7BbpQu6zKMjn/iZzXQ1tsQYUCAN/MtfPyNphLMlZGA4Vhs/vU1YH/klbS027mcTMgfS3rzLbQHwmABon5whaaWTLBuEJbHjqJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTHX3whf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434e406a547so5678935e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 09:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733591272; x=1734196072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjZHyEC8LMjiZRbwtvjzRgv7YlJDtkKDxaRNiR/V4l0=;
        b=lTHX3whfrTZLt6PH2gQ8KvOJuzVBBPWmCR2DZEZxUP9VDMUCoQWsZbj4udv9XgCa2Y
         WYdXvSwKcr638CjMwjaTJwOjz/xy2kc/w9AxyZt5Hh1Vl6Cxc7mubJmjieqt2zfRZ9hP
         +DS5ERml2as9AEChYSABsgnpiJTMmPRxGHYG2ZfyJUfE7ncDTtSmUYRLqrry3drPoyqY
         FlfS5UH0cLKOadEllobva6JNCxTtF8tbafsm3UAmEWPhBtUIetaQOqZm+tk+npahwaaR
         uQx6EdOaJEOc3zme1Yhu4D4uaF4ORtH6XJCOR5cAciP1gKFuS8v+RwrnjuWocHOCt/TL
         JCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733591272; x=1734196072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjZHyEC8LMjiZRbwtvjzRgv7YlJDtkKDxaRNiR/V4l0=;
        b=b7CKa0r4PLfqvqlhEw7IqQZbqW+2tO1+S+eqbHu6PS3FqOBwUuooMmff0cQDr4d9Mo
         1ui3nXZmDiyohRm6oePIQnUfYxjIGRjfNpryrglFDdT070LLbjmP0K147WvYzzLZ9VuC
         dfnUB/CQEHpt0SBsMmsW4pYWKokLOgfZmwFyvXKHlKDVf9rB093kIp4h5LdmjIc2qpI5
         MZVCDUUSKDIrBWiq1jnyrhSEx4TdvOlh+PLtIZBwcyFClxIHki5brjN4MWJ6SKl153rV
         ppTh71PqY7WBkUZmGQdnGBgBhHE9HdxwgPh0AD1ZeU5v5zxMuLcx5c8Wu4zmlDUNU9CG
         QRDw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Y2cRMmX3j8sttKg1YXlGa61lBFbcKLKeuYqSDgZYG4y4bQsDWN7TtsYy3lQDdo0WkVvYRzx1n2Tu3eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2iGnjoU7sKMOHT1FK8Cf/9UdGukf5aZZWmma3wsiadd9J18Oe
	VAzENi3zs6/Q2Crx0xQF+IoAqheVABF/X7Zrae5NcLPICVE216molsG+2xp57JU=
X-Gm-Gg: ASbGncuM69lVkXgJIxktGToBouB//Kg9mKZNuUkKNay0i2RHJhq54tw+Z04P+m55ocG
	og53rlC2a4fnaOVMVLTPTVNxou+cMH4yG3AKbHMT18aT6ze11bL5fNeKzXFLrqtiXOp1VxTM8j5
	/GT0hMpL0N4xgVL6EzH8eIpdiFuWiFa8n7dcUmyw4hI6UonyTU5TLn6wj6EPmVff2ANg5slKael
	EtwN7yV3Y7g4rvb9+ge6myhyvc9LZBsExlIYY1U1TkkteEzWApWEYQ=
X-Google-Smtp-Source: AGHT+IH++nUpXJiDBC4Fh9UkriWZ5KGl+qJZ3UNbkzOLpeFQE0OB7VJDLKVp6G3O8SOriSIauNPMjQ==
X-Received: by 2002:a05:600c:4ecd:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-434ddeadafcmr61344335e9.4.1733591271628;
        Sat, 07 Dec 2024 09:07:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862e975194sm4251385f8f.74.2024.12.07.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:07:51 -0800 (PST)
Date: Sat, 7 Dec 2024 20:07:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, idosch@nvidia.com,
	kernel-janitors@vger.kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
Message-ID: <4639f75f-d081-477c-bd61-a9ece93db5c7@stanley.mountain>
References: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
 <20241206232731.38026-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206232731.38026-1-kuniyu@amazon.com>

On Sat, Dec 07, 2024 at 08:27:31AM +0900, Kuniyuki Iwashima wrote:
> > [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
> 
> This should be tagged for net.git.
> 

Sorry about that.  It was a mistake in my scripting.  I'll fix it.

regards,
dan carpenter


