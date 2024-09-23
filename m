Return-Path: <linux-kernel+bounces-335424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618A97E591
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43091F2160D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6C101DE;
	Mon, 23 Sep 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UauTYQKf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71E1C36;
	Mon, 23 Sep 2024 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727068323; cv=none; b=eeib1W/Q/zKNSuujdAF6lGETXA85qciZVa7FXFSUO/JNzoHoGHn/qngEMZnYzKXSeDMGaugLnQ585y1GFgZB7cQORmpKgJapFDN+B3PZCWwQyQIVWOCP1cRuR2mSJqbCdSxYFPdcKRsRBRvrIPLyoX9FCXj/hFCYNO+TThdesBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727068323; c=relaxed/simple;
	bh=tLrzH7cyt4PKwJlD9ZINZIh+1RSHsaBpokkMj0q80us=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvY/8Jnk/08jhJrXKEtARSH3kldv2v+Kt83zLhc/UZhcY+Fdz+veVcSagBQ1DNjgjroegPmZuIBKH89Ckyz1omHHfKvtvdAdqdT0qvsr9oriROD47cVj/suLCCMs39WYvaD40LkvKoWALRb2arkZ85nw7Vd1WiADQ/8nOqLMZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UauTYQKf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718e6299191so1975475b3a.2;
        Sun, 22 Sep 2024 22:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727068322; x=1727673122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nW6CPHpJvIaM3gpiDWQAQ1DWoqjRYJKxWMSCMCQcXLo=;
        b=UauTYQKfa34kcF32tKVcFNhrybLcopxZWx2b0uxYFSGuIXV8ktyVOIHMQEPw81WGhW
         lWpToZ3hHvybO5KaYgHJUIEbTYjtrGfk1Yr1JGFXLEtGOx7XSyY02RPT1iATjZpsjEI6
         /JWx4nzSEWjH0Lftm8yqk/9rkmHhi0XM3JuuBT3XPMESX/zdgJPXXRlD4NXY7w/hz4gv
         Stg1xRbhPAg+66ntOPnqb5CeZglGqecj2w6RlgKx3ouV6C6/vKSalqzSYe6uxaVNxljc
         Bqp9MX0TBfQK8VIz3LUbT1ytJflLegXi8i36Mh44zmaECXocXXAWFQDrKThn/sBRkhR7
         PpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727068322; x=1727673122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW6CPHpJvIaM3gpiDWQAQ1DWoqjRYJKxWMSCMCQcXLo=;
        b=ms/IjGbszKxZJS7UKcQ/BwbYlQWD4R+6iwYtecuVvqvy5Ygf8mxO9MGh6wII7GOVNz
         3YHec9TIqjWAjATqliyy1zbPyP5hnQXVe1dB5FIvW8tn8ntOfgBD06TgF/ubxJhPnGBG
         WxyyoroKT9NcZ8jgK3AjRn7lknRFnKFdS0Eyq+T138lqQchUGprXtwVEFpNwoxXhpyId
         PQhKCpN8jdWDuZ+9tkaAPVHnJECcpE2Yl/+P+/Ecb4vBuE1eE5nJ0BmsOOy2sfNBalWB
         N0y9+F+jpGuLhzmJdvUGcCFGgm0mO1svXq9bDWHid0ciVoQsAN3OWtnp1NRb+ccidyKW
         uZEw==
X-Forwarded-Encrypted: i=1; AJvYcCVBylf6Syc93VUQopmqMH2A5N7QYzktgjqQ1HNHhQ/CJajwmJL4l/WTG342oGtke3Ppz5d/rqtTXuZ1uzby@vger.kernel.org, AJvYcCVyUf6PGCUjkEhJo+bVb5CLwKQvQt3K17w7F2uQsUfr57HTyCPJyaKcD2sX0p5qdOfcqKjcrM1afpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysL9UdAobz/4HpydTlcok2hL4426b2FT89wpht+VUe722etxQ
	dIZZbCfMSHcpiDAbvSLlUkxItuknyMBcFQ7iRUZ1+ajNYe7b5sw3
X-Google-Smtp-Source: AGHT+IGPZ/WNBN33bCZrCAwOz50Jud3TglxTWM/rwe+QiAOAjA63/L5wOULAqZwuu6s8DD7MQjZqEQ==
X-Received: by 2002:a05:6a00:23c2:b0:706:3329:5533 with SMTP id d2e1a72fcca58-7199ce5bc21mr16075257b3a.24.1727068321876;
        Sun, 22 Sep 2024 22:12:01 -0700 (PDT)
Received: from localhost ([183.226.245.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4b080b29sm12540607a12.33.2024.09.22.22.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 22:12:01 -0700 (PDT)
From: chenqiwu <qiwuchen55@gmail.com>
X-Google-Original-From: chenqiwu <qiwu.chen@transsion.com>
Date: Mon, 23 Sep 2024 13:11:56 +0800
To: Oleg Nesterov <oleg@redhat.com>
Cc: "qiwu.chen" <qiwuchen55@gmail.com>, corbet@lwn.net, mhocko@suse.com,
	jani.nikula@intel.com, akpm@linux-foundation.org,
	brauner@kernel.org, paulmck@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] exit: dump current pt_regs info on global init
 exit
Message-ID: <20240923051156.GA55819@rlk>
References: <20240922095504.7182-1-qiwu.chen@transsion.com>
 <20240922095504.7182-2-qiwu.chen@transsion.com>
 <20240922125458.GA9426@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922125458.GA9426@redhat.com>

On Sun, Sep 22, 2024 at 02:54:59PM +0200, Oleg Nesterov wrote:
> 
> Well, this means that show_regs() will be called twice if CONFIG_DEBUG_BUGVERBOSE
> at least on x86, see dump_stack() in panic(). See also show_regs_if_on_stack()
> in show_trace_log_lvl().
> 
> Not good...
> 
Okay, I see. The dump_stack() is arch-dependent function, it doesn't call show_regs()
on arm64. Do you have any suggestion where to dump regs without arch-dependence
on task exiting flow?

Thanks
Qiwu

