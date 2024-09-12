Return-Path: <linux-kernel+bounces-325760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D65975DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D02DB230A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F780B;
	Thu, 12 Sep 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P362+vOc"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393F163
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726099958; cv=none; b=npJEr9UZG4N52pGSdmPpVLot3J/m+hztmyMCBuW+HO6L9UYEDA7kfMuJQ5nhPJ+lra45pkNBEG2msjiItPcAk2aGs2KYSBgooS0MoXI1o/kp/T1JqiqCzCPgSv+hBp3c8m+cRoik+leOBv2eFut1y3XsRfrY8AMTUf16pac9+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726099958; c=relaxed/simple;
	bh=yE1e1oJjZv8b19e6MheS1wRSUqmnO5tHYjKTQN6gSz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjxmNgjxL7hgcean78u8peiGyVVxcLIbTU+IyHoLeZupB3lq6AqSuCOcOOWMwSBJFxMMuUjRo40w4kNINtj02bT/8ZpRqEIXzIgJINyWRUqWaju9nDMxt/CqwknoIXzM/Aflgjd25r8psf2UKe3zS9u1bHedw8lGX4Errpl61RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P362+vOc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1091464b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726099956; x=1726704756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YRhIRnidwJmOdSjyzFN3o9E8wDi15Yl61Z0LHp95sU4=;
        b=P362+vOc+xexclHKaDB+g9+wQSDvMvrRXx3Y3VErwh2KYl0ZzBkYL1DECNif6dL5e1
         ejRVJHDIvMBbttbDOkpIIa+KVwmCqJDpCrT8wmi3xuldTbcNGUc9fISjH2M4Yrwr37Uk
         90FBEg5CVDsvQlD/bItX6LvdmdNOVYh0tgGGSt9CIohggZjyDNUNtQVvRBAqtHFu1te3
         jqqsDYHo7IKLklCYH2Ie+LU2s7h5Xx/Yb4R9QvWrL7PM2TT/HuNZEXgTmlFWL97/bl+Z
         Weaky1MLjQMk5Dfd7ySIE4WPjtsZkvr+RScwcEo9LfRWfgA75THXLLlNphzTwEexZy6G
         mLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726099956; x=1726704756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRhIRnidwJmOdSjyzFN3o9E8wDi15Yl61Z0LHp95sU4=;
        b=Zw3TND40oVUBmilSTcDxXk9DrQNMSr9G56jNyN+p9+Due/1P9KXWPT6Zm9lOvOcGWI
         I7GQt/XLZoIDmLdfhC0jAXRyb/mlzNE9DGHux34jvQSoE8QUJiWLcWCMv5YvpAi6d3yR
         EWOqwQ8Zbvv9NvTDbU7T8dURRwFf5SJcI9t7oMYFoG8nGEqF4QPMkYL/jSafrL1HHygE
         I6o87I/cMwvtfAW73YYB4H4ipM6XoJGIfj52I8S/X6ld3YKf0crh6VEXtdDjgiShRFeD
         +R036t3f7BhcLLxFFWoKMzFNABU+fiHZZNfIEQtQDLSEMyAdBr+EYHv8u/S0cymtEr6g
         MT7A==
X-Forwarded-Encrypted: i=1; AJvYcCUspdmYWxMjDMakzloMLT8jlxpIsm5cg9T2AQiUyfhv8MvMR4JRWWulvpa2YmUw+7Mqd1EzbDC7EdR1jx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7f9+5fNQSP8znacuoysKEZ5EnKsWVIjQOM4I2L8HWeaJI79JY
	Gchoq3aoleaprFeQLeKMeerNh6qszqHP5wYoSLhfO7QLrZK+zhk3
X-Google-Smtp-Source: AGHT+IFiWt724MUdfh6lTY2YBFQTHx49rEguXMGqwgXVrmwES84P38IbzbLYqPVXsGKTuLUxvXhVfg==
X-Received: by 2002:a05:6a20:d807:b0:1cf:6713:b791 with SMTP id adf61e73a8af0-1cf75598c1bmr1419212637.2.1726099956034;
        Wed, 11 Sep 2024 17:12:36 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.234.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c37efsm3512676b3a.187.2024.09.11.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:12:35 -0700 (PDT)
Date: Thu, 12 Sep 2024 05:42:29 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, quic_jesszhan@quicinc.com,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	lkp@intel.com
Subject: Re: [PATCH v2] drm/panel: hx83112a: Transition to wrapped mipi_dsi
 functions
Message-ID: <ZuIx7dFxMa46dapr@embed-PC.myguest.virtualbox.org>
References: <20240903173130.41784-1-abhishektamboli9@gmail.com>
 <CAD=FV=VVxWBv2oqL39j8eoRdJf42byoiUJ+XvY0kwL-OXoe0fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VVxWBv2oqL39j8eoRdJf42byoiUJ+XvY0kwL-OXoe0fg@mail.gmail.com>

Hi Doug,
Thanks for the feedback.

On Tue, Sep 10, 2024 at 02:22:37PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 3, 2024 at 10:32 AM Abhishek Tamboli
> <abhishektamboli9@gmail.com> wrote:
> >
> > Transition to mipi_dsi_dcs_write_seq_multi() macros for initialization
> > sequences. The previous mipi_dsi_dcs_write_seq() macros were
> > non-intuitive and use other wrapped MIPI DSI functions in the
> > driver code to simplify the code pattern.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202409040049.2hf8jrZG-lkp@intel.com/
> 
> You'd only include the above two tags if the original problematic
> commit had actually landed. Since it didn't you leave them off and the
> Robot gets no credit (even though it is awesome).
Sure, I will keep this in mind before sending the next patch.
> 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> > Changes in v2:
> > - Update the commit message to explain the reason for the change.
> > - Correct the code by changing 'dsi->mode_flags' to 'dsi_ctx.dsi->mode_flags'
> > This change addresses a build error in v1 reported by kernel test robot
> > caused by using an undeclared variable 'dsi'.
> > [v1] : https://lore.kernel.org/all/20240902170153.34512-1-abhishektamboli9@gmail.com/
> >
> >  drivers/gpu/drm/panel/panel-himax-hx83112a.c | 140 ++++++++-----------
> >  1 file changed, 60 insertions(+), 80 deletions(-)
> 
> Just adding a note that there's nearly the same patch in
> https://lore.kernel.org/r/20240904141521.554451-1-tejasvipin76@gmail.com
> and we're discussing what to do about it there.
> 
Regards,
Abhishek

