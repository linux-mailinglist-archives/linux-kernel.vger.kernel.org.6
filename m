Return-Path: <linux-kernel+bounces-388568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7049B6153
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607A0B2392B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5A1E4929;
	Wed, 30 Oct 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBlaY0r1"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE41E47CA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287209; cv=none; b=iZYZAPWCMFRFehca1dz7qHSazwGatcQokPHKp0YPZLWafBacpcAp131rtTFyrtuuIXPycEUHy4QpjtAYoXHlDokRiSmpQP3g5W+woSxc5d1WvdxVdxkKPp4mJFS34RruZ7v7MOZAvVUmtmyAuiJOmXpiB1UjUCiYlRoMqmmdQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287209; c=relaxed/simple;
	bh=E34cDbhoWFaOTge5djHJ7kU7XTfeh7DjhFUmukypNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL0DdaInnfK7E00/ArVzoz3aQ1PMqyNHoRljR4MMOKxLmtEV/enof3MUeDVNV32Fud+nCvRYcq5K/sqlzMrpzysOlPd6HQ0S0VWG685QP77tnWje7f5pSMppoxfPnWLYRIbjDpKJJCqFoG/6xc2y0zWkM/pjSkGw600wuHTSaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zBlaY0r1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso60828155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730287205; x=1730892005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afFNrnqW4FhVnOEQ1S9K7+CEGrEiaeSx1dvRA3QybgY=;
        b=zBlaY0r1sZ7udlWmlVuvlfJrBuK9AP7F3cRR4DKhSTxEvvreROQ+QtBUWvVwyLSJ+G
         7aO4Mg6esOLjIRr4qQ3jxpFgxBbEzvIUg00HqSQqJnwKfe2ijiTGJozO9fni6Dkzh3aM
         PvmReC6Px317CSXmzGDmLyRgUDY3IhQ7fjnExvTQHM0TQ/G9sOun4h1NHzATomt+AU30
         BZB0UIXS8eAHPa6fDDSnYr7fUFIYa1G2xS4RnrjF4ws4C3kBJkgzD7rmhJLtU9sukJkf
         VsAD9EIrA8fM0fhkcquH5B04V7FtVJSJLmoIOYXkneS063BdBy9A7Sm4L7gmXeYupHdy
         xvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287205; x=1730892005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afFNrnqW4FhVnOEQ1S9K7+CEGrEiaeSx1dvRA3QybgY=;
        b=ulaxSOPDwNQSCUPZW4ciD+OBwzqQyWjZYCP0pxTLvRc9IynuVLOen0ICz5zN7oywSr
         RMeS15l3MBR3859yJ9zkgEpb6M1P/hIskqFFD4HI0bE+Xlha3KEwtNdX0k3DWCdP0ubI
         BTFFOfuX+PFnMvrx0Xymqc/FMs3Cjct5BCdb+2dA0Ies1sGXr30KBKGC5m6Kna5RDvN6
         L9Rjkay0PQSY7fEJsrk0jwqPlwVIPi+hIuRZwUD2aUpwt5STyTh8qeXYO5hpxNFhnCkR
         B1B5MxLK+kPALaPdRIHSAzHBy1oOOl4lnm/EdROlWpJj4GaiAPgVGZswKkdvUL6DEU4k
         86Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVN71TWlnsmV2sw20guN7ZjFaGyvtgLdFPkpnBoue4uMsZcYODD2CnGwTwDYKeIZFhuGQXUI0LUrGCXshU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8haQ3qkfsF8LJnWM5Ojbkf0yUlF8v/1ELim4r7d5t5cpBqT8z
	IFq01rR11F/dF4hIB8k/hTYMLZWySCvEQiGQzmmubVYW6vuADDnsFJauMi+Bty4=
X-Google-Smtp-Source: AGHT+IHtm38/xWwZKdfE6rCwMknqgCM2HN1qz0TLHVXw/nvbyjWyNnTHVgN0RTV0nwIm7xZI7mlV8Q==
X-Received: by 2002:a05:600c:4f56:b0:431:52c4:1069 with SMTP id 5b1f17b1804b1-4319ac997c7mr140592835e9.8.1730287205578;
        Wed, 30 Oct 2024 04:20:05 -0700 (PDT)
Received: from localhost ([41.210.143.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9984sm18477285e9.32.2024.10.30.04.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:20:05 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:19:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Daniel Machon <daniel.machon@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
Message-ID: <bda38b6e-73df-4ca5-8606-b4701a4db482@stanley.mountain>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
 <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
 <8e1a742c-380c-4faf-a6c2-3fa67689c57e@intel.com>
 <62387bab-f42a-4981-9664-76c439e2aadb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62387bab-f42a-4981-9664-76c439e2aadb@intel.com>

Always just ignore the tool when it if it's not useful.

CHECK_PACKED_FIELDS_ macros are just build time asserts, right?  I can easily
just hard code Smatch to ignore CHECK_PACKED_FIELDS_* macros.  I'm just going to
go ahead an do that in the ugliest way possible.  If we have a lot of these then
I'll do it properly.

regards,
dan carpenter


