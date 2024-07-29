Return-Path: <linux-kernel+bounces-265841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066093F6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97221F223E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19B148FEC;
	Mon, 29 Jul 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXeeu1fb"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B283C24
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259736; cv=none; b=Hb0AqBKMXVLm21JBFRlADTum8f7OY+KD+K7fGGH97boY87EKLYq17T9GkKXecRqaNRMcEodLmXy6CHC7BJbQWcCA2DPAzrjWqyB6PBAj7kbfaDGbFO6ftAtLvFlXXmnLTG6jUPp+EUlCQfii0HwN4haP3y73vGTBdrUqRfhoLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259736; c=relaxed/simple;
	bh=HI+x8GKy/scPD14KJfsxTgb0ZQpxymniFkm1g9+XLfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf5o1BgeQRfEy2mLkghs6iNkTl6+bHOUyetc0NcZksgkusgtsSF/YYCN1EW/kSen2EwIm1qlsv4vUWqs9tCJRxXfvbFRjqmqZj7geMV8Dfi2gpsdEXc/sz/2LdPOXpMc1JhDX63OelXm/sXC25QjdR1LlqohbgUV6b2PLFytaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXeeu1fb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70eae5896bcso2740796b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259734; x=1722864534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yL0QCQNpqeOCAknWlO99YLMk+NffPf4WTYM45aZYO8=;
        b=AXeeu1fbLzIS12A5HD8KfBJgqVUqP10+J7R17/R9mGsaCMWk7h/rL1D6xCiuyANmoS
         TBfiFEK/zDNsfLy6fCFB2q2J1XbCsce0J3ZOJHe4YhNV1zMY5PCoJlqt7UEYTOJdjwFA
         QZhuOjqagzE3ijAwdxsug64iNCHMdW0VkC0V4PbLd6UAlcLxd/ZZYplxky4aBy256N8R
         ErbT53RGTPYpXnujCCR2W3osOUOeLO2GQOo0aQM6nQ3QHJRKrzR2N5CPFsEIrKFOl5kF
         03SPBgiWGtcqMfhOmWNB08jONxVEre+3o8zbMx+k5bBcMxXsYsN4+p6bfyH7BxQ8OJ0u
         hMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259734; x=1722864534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yL0QCQNpqeOCAknWlO99YLMk+NffPf4WTYM45aZYO8=;
        b=SgGB+mAKwKM3eyF1d1t/7t0osvtez0cWP/q+1M6K8GNorJxFvr5MwZKnf62EwaVTfx
         8QlR8hwY5NCkaw4nzak5oDJzl7H0T86JnFW3DKpFs1hAEqy0Fl5lbQieHfMbtFI8ZbYY
         rMj50tzOf0TgitW3w9FpV392ojU6sc2r6UGgdqUoXW/AzeVs7/UUSQqg/UMGPfLVUZiz
         2di78ZDVNX3TdXx5gFMt4Cc+rOaO0j3BjwB60kXsolf3ITUOPniwmrtfDcfJrtwXY7TS
         lPvpIwynH/5OPnd46MySHrBzyAqQKMQyhhKh0cB+bkFG/UHD74CBmZcqrHkSupaInC3e
         mrUw==
X-Forwarded-Encrypted: i=1; AJvYcCV408p1RjkxcuHhtAu/wdyBj2zqoukf1kK8sMgONALzgbODjI54YLN3T2lgCBhoYAvc05gxP4UVljxZI6+3vxg2NEpr0h+raTyRWhrR
X-Gm-Message-State: AOJu0YxfVJ+DFViWoA563iaWFTeeuaCLjVVz6d+/qt4Ebe7ObALXS6MJ
	YswNxfcDUEuTUUvRqzvo+33obRvoJOpcOnQ7fAZWDL88Ex7vb3XH
X-Google-Smtp-Source: AGHT+IESX2PnLeI0EtJGrSeydGADF81jYh2s6zS5/LFhKulfASe7HsgEsqSl8L4xJCRK+QMMjg9fOQ==
X-Received: by 2002:a05:6a21:78a9:b0:1c1:89f8:8609 with SMTP id adf61e73a8af0-1c4a0e15171mr10085097637.0.1722259734258;
        Mon, 29 Jul 2024 06:28:54 -0700 (PDT)
Received: from void.tail05c47.ts.net ([240c:c001:1:4300:752c:bb84:7d45:2db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7edd91asm82647505ad.131.2024.07.29.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:28:53 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:28:48 +0800
From: Yanjun Yang <yangyj.ee@gmail.com>
To: Philippe CORNU <philippe.cornu@foss.st.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-stm32] [PATCH RESEND v3 0/3] Update STM DSI PHY driver
Message-ID: <ZqeZEB9peRSQkOLZ@void.tail05c47.ts.net>
References: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
 <21f4d43d-4abd-4aca-7abb-7321bcfa0f1d@foss.st.com>
 <CAE8JAfy9NtBa--DnUt2AEZPFnvjU6idj8DqUbaeLaH0DMFvuhw@mail.gmail.com>
 <e059f157-ff9c-32cb-57a6-48f2331f2555@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e059f157-ff9c-32cb-57a6-48f2331f2555@foss.st.com>

On Fri, Jul 26, 2024 at 09:55:35AM +0200, Philippe CORNU wrote:
> 
> 
> On 7/22/24 10:38, Yanjun Yang wrote:
> > 
> > This patch (commit id:185f99b614427360) seems to break the dsi of
> > stm32f469 chip.
> > I'm not familiar with the drm and the clock framework, maybe it's
> > because there is no
> >   "ck_dsi_phy" defined for stm32f469.
> > PS:  Sorry for receiving multiple copies of this email, I forgot to
> > use plain text mode last time.
> > 
> 
> Hi,
> Thank you for letting us know that there was this error. We should have
> detected this before merging, really sorry for the problems caused by this
> patch. We will investigate the issue and get back to you as soon as
> possible. In the meantime, I think you can revert this patch in your git
> tree.
> 
> Philippe :-)
> 

Hi,
After some testing, the reason behind my problem is the parent's name of
'clk_dsi_phy' for stm32f4 is 'clk-hse' other than 'ck_hse'.  I don't
know which is the better why to fix it:
1. Change "ck_hse" to "clk-hse" in where "clk_dsi_phy" is defined.
2. Use "pll_in_khz = clk_get_rate(dsi->pllref_clk) / 1000" instead of
   "pll_in_khz = (unsigned int)(parent_rate / 1000)" when get the clock
   rate.

Both method can fix my problem. The first one might break other
platforms. Maybe I should change the clock name of 'clk-hse'. However,
I can't find the defination of this clock name for stm32f4.

