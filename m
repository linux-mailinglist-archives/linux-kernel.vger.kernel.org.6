Return-Path: <linux-kernel+bounces-524624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B882FA3E53F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541EF701492
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157962641CA;
	Thu, 20 Feb 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LthYqdyv"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AE21480E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080600; cv=none; b=ifWMUDtcyfBlq2CKLijpe1J5FpMPwW7JubKhWsJKItuJfbZaQxuj6m05FWAt91uSBb4vflZveziOQwGIZEo8W8TFxHkYwiztImeU9L5o0bjlMGaIhd1NQpBvHYymLPVCNT44d+2Kx4pffnYz8wQoR5jhVzJWJ/+MCT+XXwttj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080600; c=relaxed/simple;
	bh=CQZh1hGW51X6+MKJqFHzqzZmBj8e2sGYeqjGA0wC2r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3w9Honhw9qf6sQnOg4u0BdVv7+I4z22a+JUEXfNwVGA8A29226xy9wzb8nm3qRRHhlZSUlXU/pIffui8Mv0u+hLuExVjSPdKanXjWKyR81kDeMpvO7+rbrug9Yf5RLBlOn+lhFCE2tP7Vu+sb7S1tfi0y/9wbZw6gtLcESfiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LthYqdyv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so134040785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740080597; x=1740685397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKXoW+AQZeUkigvC87NIB17R97sV2qU5a0HdEFayysQ=;
        b=LthYqdyv5NLj2SUCk5xSMEvDAeaRlAxaEMLHex+C3XnL4jnOovKcVFcUgt2Nj93JrV
         yKdDHNBx0ayUpACMDeGXhbrQoB+eMpEM/rivGVZ7Cn15NNJEM7umkoa1q6YzKUP4HGLT
         9uEHfOeoRb4p0z1W5yusU1fSeM+4k1/N2eLMi/6SnXbXvH7lC6dU2gb9vitHDWF23X41
         FC4WHPcEqOVTafL6oqJjKkxGtyH4JPKmNty4BcW9xXYzVSGM61XtDBQ5DIh4oRWP/eW0
         O32axZNWFGS0ryMgTD3TJ4sp4T4xE7sMLoJyns8nRa6CkOQA9DXDKKt7i/KB6X3E3leE
         7daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080597; x=1740685397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKXoW+AQZeUkigvC87NIB17R97sV2qU5a0HdEFayysQ=;
        b=kCmRBlhvhzCsOTOINq/EnMZ8kVLrGb37ztOlcr/IhxWxGFg9IAAbcXv340wT/5funH
         yeSjChSrOqBvgbNPQN/Lm7q9MrcPh9HH4kfsPt7mUGu8+TgqHwV+gIEJgSCzu+FiHsJw
         fpHcfF4ETUKHfeY9SKeMeuCAge2p+MA53EHcrH0l1sO+Zj1O3U/iM8xY0VZk2d6xYIIm
         hmvbYSFhM33+wy4g2lXQ7QAAcEeJP0d2OvFhZVS6qapZnAfqa01M1aBT2cIeUJj5q+Tl
         R4gqYiWEyCqaSMuD4V8oifHJ5GES2gvPz1DPJdxtU+Sw5c1JCr1L5CUdxRDTAp8FcNm/
         6kTw==
X-Forwarded-Encrypted: i=1; AJvYcCWGkViR3b1uz7e3YXniu3etuyByV/48Df8ePXtVUIW2L3JNH2eFh/gn5j1zlsPZ+takeIo9UzwvOK3Cueg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLdn6VtSHXRGZ6n2Z2LMtwWHUYxg0qs4q4HTTEDeAXRXAOeCl
	Nh9VNqyWf+ZJpOcpe/FTkZSF3pnFs5jEWOWHcKWLdeV5rwRKUR5u0io243LwkxA=
X-Gm-Gg: ASbGncuMv+iMatHJrkz11b2nhqAktK7v++yvIMZ/amIeMu0Clmj9xPmXDUZeP+gvXR1
	34PNiFJt/Y3eaJgkyQ/KjEHLaIKZ0yKY+GzADS9d83Zsc4AfSu+G2o/7O91/zrYq07FlNSXyVCf
	c1Ouyn+5IuBrG0i4ogTqvo6GLbE7T177zxi1yCg2iEkMAbkFq7fgaJCO19fY+Qw23kVXIFXEKtj
	NA9qyXuS/VJTS5HbRO5zT0CbclSMua7PV7jStFvDdwDJxO8w00F6m2IGyHVlNz0XALGjOd2wi9S
	uUHTC+05qnEQdA9MY5RPxEkjCE3eZlaCzIfrRazqTRsLXUwSuyRZCNTzdll/ahieF4xz94VRlA=
	=
X-Google-Smtp-Source: AGHT+IFkRBvFtjCgVNrmnWtpZGK+MU4yinBj+hI3wWaAiYndlO+MZu3xzUHT50RI7AcRiLnUL0Ns2A==
X-Received: by 2002:a05:620a:2495:b0:7c0:a16e:e83f with SMTP id af79cd13be357-7c0cf96f05bmr2517685a.52.1740080597543;
        Thu, 20 Feb 2025 11:43:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b2bb3d00sm289265585a.17.2025.02.20.11.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:43:17 -0800 (PST)
Date: Thu, 20 Feb 2025 14:43:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 10/15] cxl/region: Use root decoders interleaving
 parameters to create a region
Message-ID: <Z7eF04PLfr5rhiLT@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-11-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:51PM +0100, Robert Richter wrote:
... snip ...
>  static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +			     int *pos, int *ways, int *granularity)

Function name starting to diverge from functionality

find_interleave_config() ?

~Gregory

