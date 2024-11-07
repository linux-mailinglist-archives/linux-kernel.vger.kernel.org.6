Return-Path: <linux-kernel+bounces-399276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850669BFCEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFCA283E56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B35839E4;
	Thu,  7 Nov 2024 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKZK8TUM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA717C61
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949787; cv=none; b=SLurjd02UBzhDZK+GWTrRa5S1tHXTD0e8TuXYosPkFn6kB8Dxq33UL2dqS3HEQzb4U2GDZZ9tG6Sb7FXS0GxjWd2Ssc/ya0V3zJ4/CaSpOGKhS7grYJLR6sm7LECMN0FUkaL6jmtjN/k2cB1Rbsp6MLj8dx/+IN2873+8NFIkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949787; c=relaxed/simple;
	bh=Kn0K1WJ3zLDjBXja8dDUfylLVNYWZTyIXMqYGjddd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfx+cq633EyfYUlwinLe0pzFoE5eGR5apUkE2u+Nmkk8A+3k4zQX232RPI4nU8Mnr9OOy/snCAv15/Rq8f63V7x0IjzvDLRvJAimqk+QKRKXHFCGIjtydOwWce022aw6izhWdb0p/hZrOyE2lPE49sM+/8L/aGYjtJDOy2lFeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKZK8TUM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca4877690so49875ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 19:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730949785; x=1731554585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcDVaMJj03dteYAJkz9AeR1LSqYoJuu/dpBE5eqcCQY=;
        b=JKZK8TUMauXyPNWEXymV6bbHHFOtQlAYcyr9sYrCGVbIl7a7vWlh/su/TEN2qepn2g
         Nff90LBC7N1cvkgFqrCjrnRpgJyGR8On5P6QJwGmrIu6pXEUK2k7OEgjn0A8akJN6MGb
         c7egcQzWxSg9uFsbQmpYP8CuSedv7OJg2/E7arBZk496rXoQN69YTKBrY52SGeqzAjIg
         sth/Di0ceqLfRoYsd4inbH95p3PrL6LUfkN0fIQqhNaC9+obqGXNsH/lextzrQcj6dSu
         9ZWH0T4nam2VzQwO0AJGEbqhvWn+yM1xataDeHch9K7uWJmewAkNWss5ztuvRqeWEluz
         0FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949785; x=1731554585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcDVaMJj03dteYAJkz9AeR1LSqYoJuu/dpBE5eqcCQY=;
        b=Ytinxag72yPwVboYPZHSLnZdVG/yd1teBxtTDVzZ6kHERy6nMWa8Bry94I4VEOqLVe
         IEpnYlDYDzrDpeID0aX8uTA+ZeyWiVSA0Dxbgm/JvggRcWr4T0YmQajEr52VH5aU1Sp+
         OhWVIIJ2EhedxYIzt5IQ9DwkVU5kGphYHOEqUSx5rEThiNHVPM0MwnMn2wHE0X3Weryq
         NWuNZyiyhBZ9XXsPv18NDeCuBGCZthX2B09dTNpWebY/LardRaHlcb+mGBGmpKDN4RQS
         5e0W6NtFUTZi3TPBXvOzPcHqUdjc2Sd6Q7jKuy+XTFAZjGkflYGFuar5Z/h5QX9bhf45
         YMbg==
X-Gm-Message-State: AOJu0YzTvli/TS9oZiqKrmUfMAmxsBNHVdFHy+opWoIIFP17ZdKhMJlT
	CznOZKwOjEK6KZw4Wp+S8DPyrMMmnATie6YOLBrma+nepY5O9beE7lG8l9ww1Q==
X-Gm-Gg: ASbGncuvhJuo6N04A9w5TLu++O291c9OQAl9DKzMDmlbmbXJG5WIGPrmCiylSSpG2f/
	voXs8hRNy3LodXPcIaNOzQyzumY36sncRHrGLj8VGGxdkOkaVre3C3PbuEzWl1M667D+N/Uwe+R
	aJVR8qT9U8f5ydOFzri8iOcNVL/xzbXNnj7fmkDKChT8tgV/WwhrhZSABtQeBZBAjxjasgSPtKN
	09NgBMaEOirXxnxvSKcq8zZtJ5o+HIynyH7o751PnjUfW6OvpsGCuh4tclXBR3PhQmskTf0aKGY
	sBGYussGBJ2D9TI=
X-Google-Smtp-Source: AGHT+IEFwhh8NRuB/JLQMZ6mTzv6ppqBPAviAwKltC9QpMQ9BlPtvedliFAxuofWHPriSJtz/W4ibg==
X-Received: by 2002:a17:902:d488:b0:20b:b48d:6ae with SMTP id d9443c01a7336-211749815f3mr2124615ad.13.1730949785462;
        Wed, 06 Nov 2024 19:23:05 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864ebasm347717b3a.14.2024.11.06.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 19:23:04 -0800 (PST)
Date: Thu, 7 Nov 2024 03:23:01 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 8/8] binder: use per-vma lock in page installation
Message-ID: <ZywylcwmJFiVvkhb@google.com>
References: <20241105200258.2380168-1-cmllamas@google.com>
 <20241106225534.3388-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106225534.3388-1-hdanton@sina.com>

On Thu, Nov 07, 2024 at 06:55:34AM +0800, Hillf Danton wrote:
> On Tue,  5 Nov 2024 20:02:50 +0000 Carlos Llamas <cmllamas@google.com>
> > Use per-vma locking for concurrent page installations, this minimizes
> > contention with unrelated vmas improving performance. The mmap_lock is
> > still acquired when needed though, e.g. before folio_walk_start().
> > 
> Is the locking order correct in this patch?
> 
> 	lock vma
> 	lock vma->vm_mm

Sorry, I've also fixed this issue in v2.

I was trying to avoid having to vma_lookup() again after switching
locks. However, this seems unavoidable so I've fixed the locking order
and I've also switched to get_user_pages_remote(). This seems like a
better option now.

--
Carlos Llamas

