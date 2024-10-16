Return-Path: <linux-kernel+bounces-368353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D823E9A0ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75FB1C21DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FECE3FBA5;
	Wed, 16 Oct 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MGxG5Lyt"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54617333A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093558; cv=none; b=WbXr5k9Gf/FgLv/WQCHvhkZbhgreidMTL4HelkGip9Hpt7AQazmUAzhMJ5tf3Y3+brYzI9cHpWHccmq2T0oa56rdCF+A/AC+EG4T7pfu4wBn5MmKchm696K/60sREhv8nx9URelXYEjKs6OKcFKs7oU3Yw8Ahhmwa0j2JR2Uu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093558; c=relaxed/simple;
	bh=EEZ2LDphVBRKBdoRQ+LSrY20LCMSUc6nsUE9KVF2o3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg/ZeTwv0qmmVrs6ZVA3LmotVMUGIrH+6QuxqstMbnQ+Qu6Q4QE6P5tPpnXjwNcjkii/4sUdew553qEKqzOcy8qe5OG7z9IKb9EnfL75YRR6irXhbR6jdiUjBHxW+U6Yh+UlnxLQ7WWxzNOtPJdsZ2ENGoeyjN6fR18JpIi71Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MGxG5Lyt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4605674e9cdso43753361cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729093556; x=1729698356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEZ2LDphVBRKBdoRQ+LSrY20LCMSUc6nsUE9KVF2o3U=;
        b=MGxG5Lyt0dJMwRuYBpXlRu0sIJbuKFX3a1SoEIq//LFRDs3X2jYtcrfmdZ6LNH4sx0
         BStOBYeg4rIZYQRnV8GC+chafiGB3/rju/0t40y05AgqE2XB7NVIDq9Dju+pgwATtQGB
         z5hZgZF6bZ/h5iZMnWNDzQsdZGzKUZZ+FIxEnA1DjMJjq4L21sKnSCvIz3PJdy835r2W
         LbiEK86EASOwscxFhJteCp9UnAGWylessV+55lAinPCP/nhmAgX4oyK4zKuowXx7RzBr
         qQKJguIrm1kRGt3vXzrG7n4ZxCiT/33IgdF6DHOFss6qO7fMw+yC5nzS2Um/+Dbp50gP
         8/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093556; x=1729698356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEZ2LDphVBRKBdoRQ+LSrY20LCMSUc6nsUE9KVF2o3U=;
        b=lkVyoBDjYeYQS1Zz6sCbiChceekJMeFQcZ+HhH7TdcrCCTzz9THtM/Lvx+97wA1xLR
         RFy1t62VpqPdwUaW1ap0No9wVninqxvRBjxRNslnUqT1Q/7cQ32bL/Q0Vs3iG8QxHmxg
         4NTsJcu0s8n+z7uO0FIoNXjlX2SxzNMYSbWIUXLz7J9F034fioagMzzbxISDvNgdbvla
         r9Y8zGRwi0fyA1IFJF/tOLWddWe3djwqHAtYFZgt9cAtjqX1wo7mSUudaYZwkoSMbcsX
         CMqDn0HzGSFCXLwk0/62ARejW4Ik2EiFayc3lQNlNkM5Z5ZtKhnrhDK4P11MVVtMHlYo
         P4uw==
X-Forwarded-Encrypted: i=1; AJvYcCWyvyquSJqdVtq2xZt+LcEeqNDpYPmb3hVP5JpyW2RFQsrdchTbz4ejsR4v55FiHUhfHfglEml8ToUEXew=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJ+PUcKLV2mR3cgh+ggHkgSynQ2jpg1NajanUHWZQ/a/tUbE6
	mwjUJqSJtzfqa1yJ0sMspPCULyIkpnN3rNvPHB7Q8u/HZRe840NH1kn4IbK6CPs=
X-Google-Smtp-Source: AGHT+IHBmbfM9O9ARExkpU9bIKavBiSK4W/Jp563MrmrJiE+AksYkKIOl96ws7ZKt4oJVaRWoyN41w==
X-Received: by 2002:a05:622a:1c06:b0:458:4bf1:1f46 with SMTP id d75a77b69052e-460584f2a14mr288154691cf.53.1729093556249;
        Wed, 16 Oct 2024 08:45:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4609784bfe1sm3525541cf.0.2024.10.16.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:45:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t16Dj-000Cg0-BG;
	Wed, 16 Oct 2024 12:45:55 -0300
Date: Wed, 16 Oct 2024 12:45:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, bskeggs@nvidia.com,
	Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <20241016154555.GE4020792@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <87frow8wdk.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frow8wdk.fsf@nvdebian.thelocal>

On Wed, Oct 16, 2024 at 04:10:53PM +1100, Alistair Popple wrote:
> On that note how is the refcounting of the returned p2pdma page expected
> to work? We don't want the driver calling hmm_range_fault() to be able
> to pin the page with eg. get_page(), so the returned p2pdma page should
> have a zero refcount to enforce that.

I think that is just the rule for hmm stuff in general, don't touch
the refcount.

We don't need to enforce, it we don't know what else the driver will
want to use that P2P page for after all. It might stick it in a VMA
for some unrelated reason.

Jason

