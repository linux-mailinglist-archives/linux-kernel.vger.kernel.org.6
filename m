Return-Path: <linux-kernel+bounces-386889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB089B491B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091E31C226DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C066205ADE;
	Tue, 29 Oct 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Udw2jUwU"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5B205AC1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203679; cv=none; b=dH6O+dFQYTxK5pjaWaQ6SuI8ADjW4W5Rp1C1qH7jpkXdNxAJPLw2gPqjKTYk8tQCgVcyn4GVZJPv1dCHakVIfCTfm44r2c1p6mrUeygjsQiU2go6K3qPUpU7oxg5ZL3zlXf6U+Qy6HG66LYQl13vMk85/rgXvuiwAo3fowiTC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203679; c=relaxed/simple;
	bh=hEN7fWVSBJu04ZdAcX65OAQfht163nAzvpw7EsYEBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3gIMoQZRWhIBwOW8h/+U+ZvyASJwTnea1khNm4G3EldVcax7kD5iAK04aMUf+ePXfYG/oxw/bp4xu06drf8fzUb69mAXX0xXPaBQ5aabm+G6YPS/pOTMkPuBnz7liBS1GPXHBH0mF2onxWGoXunEGi9BX5ynpu/AnNP8KiCdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Udw2jUwU; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso33542756d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730203677; x=1730808477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjG3TMjuly3+sxREugXUl9aKqFk9SyT5Z+kFrmhljos=;
        b=Udw2jUwU3/lnEHGDHHZLycx+SJNTHE/ylOhZ9jmB52DU0aOlCSj8uWIIIdS4//WZYs
         mteDGsUJZo8B5M5ZgZca2u5Wxy6KyPsWyRI+QgpHPQQLXFPYCZnU5P35qVLrkWZpQuST
         86f0ikR3vg+Wcp0mr/OZgIEC/eefkV99J6OmRa/d4xO2mHlC/3C9a8ChZdop9XWZDzjM
         AKTo60xHbNd4w+o6ZxEHTePm1M7npPE8VN9ot3W2Cx60GfWD5CH+aA1CIwctmVZ6aH3E
         rJNPjY2GipkG/dfcwW0bmo7heSRmyMTxfFGem0Snq+DtncyPBvGQPXrZM54cA477AgXN
         0l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203677; x=1730808477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjG3TMjuly3+sxREugXUl9aKqFk9SyT5Z+kFrmhljos=;
        b=nBopMbqpTN4wPZMINiZsbN0Q4Qhh2StWpRcYVMDOS4ijaC7JIq03S3bSyVNmSVsmUH
         CtoKLURIRxKogr64gQt1t6+4wwe741P0kjvoiVTiguA2Th1qJFt6LFT9vxABMn1sD197
         7CmqiUXElkd4deo1aFkPKjQCBaFhEOeL8opKQ444UMUv8CMOw783fKSzVt1pYHqFIS01
         U5u1FStUxd4hQEzjuwoMEXw465E0f3c0IzVSmRaMFB2YbVDW3j9nSM9jmtdRhrHmxj/l
         6rcekhk/8dAYWXQMIn6OXBZjKKHaHbGRzGI3xxNFERc8FdPut5v6jXoToj7cWpJ7Zozi
         KBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr6Sc0fPDSYMqyWhEtzGOG6Sp8lcPBd8Q52lgByItzwnkYQRotVCiN2GllWWOhgamRAj7tUhsuob5EMcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBTMoyMOG+7eiLOcH4VuJs6A2Fzk2oNc6jzz7ZdBqv23a6k/2A
	JyQDhkBLQ07IfORTt3lF3DbqwIVb1hH4La9ANxHe7f51QIu9/aS6jCdXLdtnG2CpWv4A8FZRmgW
	Z
X-Google-Smtp-Source: AGHT+IH4MuIST3OZKWrIx2hkCU7uyNoN+FQYg9OtcHZuiu5P6ktzot/euCRm8UR+I2yXMtXn0jPunA==
X-Received: by 2002:a0c:f987:0:b0:6d1:9f63:6d5e with SMTP id 6a1803df08f44-6d19f636d86mr28353386d6.10.1730203676814;
        Tue, 29 Oct 2024 05:07:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798a83a7sm41396586d6.41.2024.10.29.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:07:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5l0t-00000000new-3egT;
	Tue, 29 Oct 2024 09:07:55 -0300
Date: Tue, 29 Oct 2024 09:07:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Restore iommu_flush_iotlb_all()
Message-ID: <20241029120755.GK20281@ziepe.ca>
References: <20241029112302.63639-1-joro@8bytes.org>
 <20241029114201.GH20281@ziepe.ca>
 <ZyDPHtJkMdlVRj2N@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyDPHtJkMdlVRj2N@8bytes.org>

On Tue, Oct 29, 2024 at 01:03:42PM +0100, Joerg Roedel wrote:
> On Tue, Oct 29, 2024 at 08:42:01AM -0300, Jason Gunthorpe wrote:
> > Strange that 0-day didn't flag this in my trees. We really need to get
> > 0-day running on the iommu list too :\
> 
> In general I agree, but these issues where found with
> allnoconfig/allmodconfig builds. Or in other words, compile tests I
> expect patch submitters to do before sending changes my way.

I don't necessarily expect that. We have 0-day robots to do this, and
they are more effective..

Jason

