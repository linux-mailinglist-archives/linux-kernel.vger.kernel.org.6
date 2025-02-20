Return-Path: <linux-kernel+bounces-522769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73621A3CE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81EC7A89C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E453594A;
	Thu, 20 Feb 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nh3ImEaz"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7129406
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013222; cv=none; b=P7c0jbHsdNHTwILaH4J7xCO5SAF2RUyX54bG3XRXm8QsWtWNc+Dku9tTOyEzcz7xAVexV7midlDSM21dO/jdK6liucvSJwtu9k584b4Pnc/XlNyAmHvlktEH+JKdQXqaM4q7k5SEaQxhKdN9TZrq/WiCXvPdFoWBmNLrdcm+/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013222; c=relaxed/simple;
	bh=S2cqqpLULU681yBCINb9NMRfe7QfoxFetKPWkeHjawA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL0QDdn7oNG3i2Xjb0xMDt8i2yUT/wpeOWBrpSn4ZfJ5q40Ao8xRlZKv2AowjSfgJ6UMPOzPUwdS0AWONHNkE1B3/8EGY0Z92EqCudhrqzXBxcXcCKyKlY5b3M7bxBvytz0t4s8htyq/PiS6+5Ogc2Um0YSnCZ/gj/oR8AaGi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nh3ImEaz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fd4bf03cbso5911701cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740013220; x=1740618020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoi1brQ3a+Oq6+fnTxf4cmydsWprTu5/N19W7+q7/XE=;
        b=nh3ImEaz3Yf9IM26hAwkkW/lLl/ozABi2loe/l9++69QdWLgRm2gW8jWGZ1NyzxR19
         rjOQJE8smeLAQhbP7AglKbjkqELrzoudeo1FKHQI1rzNs+qkLYqI7uRMGVu0H4UusAZ2
         QCknzqjDlNfDWDF4/IM6heduHvisxBDqwoWwuVI1UYsW+cNZAyD+4LJJ/YIidEcrEJOs
         3ZYSw+efpaeIH84etBNB6MsHvbPhK87wiXg7gG0Znm6BdlR79PRFGmDkRe2toveYeZHc
         c1vGgk1i1cMC8BFtJ4d5OjYFVYODclNCjftYlryj0+p5cDzcvfz+fdfENgE2imhwjL3A
         PI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013220; x=1740618020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoi1brQ3a+Oq6+fnTxf4cmydsWprTu5/N19W7+q7/XE=;
        b=wTRZuqXNUnWLGmacIQiSvTUEX6WBylo/n3bgBFifEkPE8tYoPxakQ7bRyu27iUeVID
         6LDNein+u0bs7DrDLWpu6ocwMf4l9CpuK+DQIWYqOfG/UdNTxHQ17fMlJjnYiuae9sWA
         9jQNp/FNd8YxjmlFzZJo3RBEpRyfBMs7tGs4FATqlrqC/TKv1kiuvw6QuxGAXmI0tGRG
         EnWaY/KV7iI2f1jraLWk5r+2jt+Zqo5Yvexq5t9crToNVmG+Ge1DYdwQd+Z74HMwNZEE
         iNXY4fP6GLERmFM8L3q2LwiXD3tWBXnZzyEujLkk39uUKaFbjwBP1EjXVeJ0EzGs8qet
         T81Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5Q/sYh45fWnX9Km+ugbLTP6yLGL7fbYKnnKexXjnPAJkc8/XXUtzxO0cvgl2MDuJ5XZN+isT1L43III0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYn+CspFxU+lRfLqfx93jaE7K0aygeAGTfLUVTd0+AN2ACPsnT
	Ti8rOpYlFvOtKlayLkZ+NIa1XLTeFbJA4AXZt6HcmMim/JGa+AmX+0gmxtU675svQIn28Al/H/w
	u
X-Gm-Gg: ASbGncu4/tssklHrpYeWmnl+6W3+Zq7xxi/d+6RyRLNTznSTUg+Ku5/8Mc465g2JGYS
	oXPO0JdJCQTvTgcQPXYKY9o2WgFaKg5ho14Z+tmMVDRrzmbsiLLPMRCqimW4kL5rmXlYKxG3xfu
	0SDSdbuIaxBiYQuzKE/RV6S3AtXJ6Wa/8aqnKGXRO0W3tfBCEofr+jhriT8Kf9PXkGJcqK3hvqw
	beCfHRnxZTLss9GkPB6q53IVzbhXl8AHaNKa7T8ir57p8Cvz2Xc+8EMptGUMpAJAjBATuF0jNzi
	RQzuK+51+EQ9IpElvZKK7CDWRN2Rzes6RX9Ef3F5bdPFxN+V6LqOBIGIzAa5KRlaKlzUoJQ1Lg=
	=
X-Google-Smtp-Source: AGHT+IHP2N68gFzF7y0BSGx/PGzi5Hy/HoXLhJu7d4/VfDxpgfvOrxwBHyluL04L7qi40nZ87CEp1A==
X-Received: by 2002:a05:6214:627:b0:6e4:2d6d:5394 with SMTP id 6a1803df08f44-6e66ccf197emr301197996d6.28.1740013208049;
        Wed, 19 Feb 2025 17:00:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784ea4sm80495086d6.33.2025.02.19.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:00:07 -0800 (PST)
Date: Wed, 19 Feb 2025 20:00:05 -0500
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
Subject: Re: [PATCH v2 00/15] cxl: Address translation support, part 2:
 Generic support and AMD Zen5 platform enablement
Message-ID: <Z7Z-lcV7BAn1M0Gt@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:41PM +0100, Robert Richter wrote:
> This patch set adds support of address translation and enables this
> for AMD Zen5 platforms. This is a new appoach in response to an
> earlier attempt to implement CXL address translation [1] and the
> comments on it, esp. Dan's [2]. Dan suggested to solve this by walking
> the port hierarchy from the host port to the host bridge. When
> crossing memory domains from one port to the other, HPA translations
> are applied using a callback function to handle platform specifics.
> 
> This series bases on:
> 
>  [PATCH v3 00/18] cxl: Address translation support, part 1: Cleanups and refactoring
> 
> Purpose of patches:
>  * Patches #1-#2: Introduction of address translation callback,
>  * Patches #3-#12: Functional changes for address
>    translation (common code).
>  * #13: Architectural platform setup
>  * Patch #15, #15: AMD Zen5 address translation.
> 
> [1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
> [2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/
> 

With the one build fix i've reported, I have tested this with Part 1 on
a Zen5 system w/ the PRM functionality.

Will review patches individually, but for the set:

Tested-by: Gregory Price <gourry@gourry.net>


