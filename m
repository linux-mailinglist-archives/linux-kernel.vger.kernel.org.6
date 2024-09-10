Return-Path: <linux-kernel+bounces-322664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04785972C04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37EF287BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF017BEBF;
	Tue, 10 Sep 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gingQRL7"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E4210F8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956452; cv=none; b=W6gKkhh3hYDA4iKa3zlKjLSGs4AmRa1mGpKDJEAxtyZFzz7a28x6doPpcYUwEA7yThpQmSns4wiOMuAssSSQO+qptddErm5hBJ7dWGs6zSpw0kSjgm2upl9HddZXQ1MZrTyuPwCfe5aB116nWsfEPIgqAKhGh5Grj66vgp6mDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956452; c=relaxed/simple;
	bh=scNmR43cohIjixk7NGBKImQPntBVBGHcCuZp9CMrkyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7QSaLTGv6baNKKC95hfWNmM2Gyg/KC8nZS07zCS3bDCJBXxks9r4BKQ9nNPS3BCYuicpdwFLhvOIifjMqqfYAdbpJLd7Hc5Z7Oz/5CaoMLU9oT2KPUzOLaaxCBaeVhue8hr07IWA2cXM66VhxtRcqAsJ9ONUFWb9+upTs1DSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gingQRL7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so16575245e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725956449; x=1726561249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKooIVF6/9vRLildhU5E5+Y4BDwHX7mmS0y9s2Ui9OI=;
        b=gingQRL75QL3rtGr2ZuF94H5jWghDhYL/tiy6pMRE0RRHul8o3VodWzxEJ86HRPNL9
         OrpR0a/GYZFUxeW1fbETR92Kz6mpKcFUk3BeC/0E0iASjKkNcZWyPb5oIvelZea8pWLM
         xrF9aRZo+eP/ER3DSlU3ihF54fiYCTlKHI7/STyYMABQ7EP68mnm00x2Zfzg6PioZjKS
         4pwYXfG/mfdXu1LVQ9i9dTqpyZaAhastXqNB6+Z20EOH6edcl+sOj46/+Bt51fapSSSw
         7k9Cq23GRNM6XGfz890lYEogUSnfTThak1XDXZIZcpLXin+AlDRTcuaAXJyeVeTcIssa
         zoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956449; x=1726561249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKooIVF6/9vRLildhU5E5+Y4BDwHX7mmS0y9s2Ui9OI=;
        b=ozNyASpQktKAj09j/rNF+6SSYEJthINByPcedmSeDlbt+F09F6t/R5jGncm78AakeK
         GYhS2oZYPx+5rBYT64Ue7FE0AsEGTzdq9IR9d3f0AXCsAeGE+xOshWa9AwU4ZC0Nz42a
         Dyjl/9W/sF+0XjEKWL8p55BBsAt+gVzueHtR+OdISyBKB2HsWmS9o3pTpRADPG3e9BqL
         elWWVcNVz0Qwo/Taqi/d5DJVPTur4EXnWxao49yXxHdoJbnsaWlYIoUtAxLe+kUH//2V
         PbFO4dGsh122egdDfeIBPMKywGAi+dSGneilQvOxQ8/fzFsKIk6O+p3z6pMYrkiyN/l9
         AQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXezH5SRFhpwvq8JQb2btH1cXx7Cfs+6Wrm5c2SSlkq1L6bP+rQ/6bO+sao1Q5z+TtRrV6q8FCnTPxfAMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ElaTUDW5V5KfwbZxbmjwoS87r4EcqNYNVgVVP9yOMBWfj5Ew
	jzaco64VzoE5eRE/oAgOtLQ2e6flKVLqb7pVwsC5U4lcSdBww+aNWlI3AnoSkv0=
X-Google-Smtp-Source: AGHT+IEEmKubpCyw4PBhdc5wLZ8W0FL/s2J4w/3zB7kYhrMfFGAyKv3HgWu+pbO82pQHurjGivtqqA==
X-Received: by 2002:a05:600c:4798:b0:42c:a574:6364 with SMTP id 5b1f17b1804b1-42ca574664amr85544735e9.12.1725956448531;
        Tue, 10 Sep 2024 01:20:48 -0700 (PDT)
Received: from localhost (109-81-83-158.rct.o2.cz. [109.81.83.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb449aesm102347055e9.25.2024.09.10.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:20:48 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:20:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hailong Liu <hailong.liu@oppo.com>, Barry Song <21cnbao@gmail.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Nicolas Geoffray <ngeoffray@google.com>, gaoxu <gaoxu2@honor.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>,
	fengbaopeng <fengbaopeng@honor.com>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
Message-ID: <ZuABX8ohRClBagqp@tiehlicka>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
 <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
 <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
 <20240827021351.iq6i7zkwm32xili3@oppo.com>
 <CAGsJ_4wUrm1Q7Oxb5BHC2ypyf4wAH+UO9KYhCUwsEbhkcc7QGg@mail.gmail.com>
 <20240827022911.bcje3ofucegg6vjl@oppo.com>
 <20240909152215.31e85028c4d09681f09e7509@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909152215.31e85028c4d09681f09e7509@linux-foundation.org>

On Mon 09-09-24 15:22:15, Andrew Morton wrote:
[...]
> I'm not seeing much clarity on whether we should merge this change.  I
> think I'll drop this version - let's please revisit after -rc1.

I think the biggest thing to focus on is the change of the behavior and
whether LIFO aging strategy for MADV_FREE pages is really desirable. It
is a noticeable LRU antipattern.
-- 
Michal Hocko
SUSE Labs

