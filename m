Return-Path: <linux-kernel+bounces-223677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F1B9116AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65E81C222A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83292143865;
	Thu, 20 Jun 2024 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTnsTJB+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BE3838A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925667; cv=none; b=nSUom3fnORP3hHj4xY32+iVMSZQ355LVWV/jkDy/pBPcfStdSf9HrSVf/RUY+3blHFTVvzN/RYOFHLYdjmFcnhNP+FVpHs+zR49je5jHZxUG4LfhVlK/PCWPMHZawQPURcd3Tzael+ecXGPpQc3P8ISs4x6dwjrIhqJzwgGclYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925667; c=relaxed/simple;
	bh=RWA5OpLgder23ILHsRHLds/JqJ25q/4NikRxYtkbLcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTuvlGKPfIYAdAbLTrk6auD1l09eORVoK/7GFHijAJiwAsiu7z3QFpmYd28pF02aC6GO6nwhV68BtCc/iWbTUkuuFAoBgPgO4wqDYrNsIdLln7E45CiBwHc/wy8y+b8Ui5qRljGKH7oQCBbDEt3SNHBKcBqwVZ+Jfl8rWL5aBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTnsTJB+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e3741519d7so1022331a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718925666; x=1719530466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ft+z45cuUQ9u2kF2ga2hNisPwfOb7+8Gnd5P6uThaZU=;
        b=eTnsTJB+17Wz6qQErSGQT8Nsf/FAZ8pLusijRYqkWz4RkZ45tSg/wwfcy4y8KvkovE
         3CZR/1M2ow3de7MFmVJ9NHLI1YPXgq/i126u0rbW0gAF//4dPysOu7QYkw2+M5o02Tk6
         vjC2Zyen6bA7qy3aa38reteOPqQ9SOB5wdTdsPk5mAbBgIetekoGrmNMvyJqp4tjceSi
         Sxos5FMXnbX3BFUVjSh+aav1ikoYk7GF6/1azTQk6nhU0T8GqmDCFvN0OhGcQrb2ab9d
         dujGXtpQVZcompFg/qldWGamTDz6cU5RPm0rdXcLvORBFLvavww4z+TgjgpPoXcIfOAX
         swcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718925666; x=1719530466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft+z45cuUQ9u2kF2ga2hNisPwfOb7+8Gnd5P6uThaZU=;
        b=NAOdd3R1xRcVSnWO56xjfuu2yrzY5Sw4pw5228Boles7E7ZNGp/Q2D60PVdyEqXAYe
         Xjl4mJjpebcBxuYNOebNc1sLtrHDNCPrKn/vD51l/Bsd8EulPpp46TsXIh4r0JcG7D6e
         eVP5V/t/mumuQ4eiS5wLNbbdZv52cNkyCqvD8kvSWz3ovYeH9h+FMzkC1LEmrb/jgZNO
         iGbMpRuG+Mz0T1o5Ujw5a8X4qTqEguti/TMo8BoBJLBrMEeGRi69JmUs1lCxxr+xbGgr
         DSSV8kFzLdkSJDcrn0ItSojOthP3jyKkQFb6A7ZIDuwY8zn01kJHXAaw2v9RlX1NuYrp
         KKmg==
X-Forwarded-Encrypted: i=1; AJvYcCWqouU7ySD3CFl3q0bklHNDG7AZ09rftQizthWfInXQ64sbb9CSYw1d3Ca2HkxtlRn0dyFLf6srEuNlWxGDyifYAmEmbxQ9JcrdzMp5
X-Gm-Message-State: AOJu0YzgvgiMRSgZCHiVwYe6r34LlqWdYtnsQq7mNO153bevPavkF6E+
	iTqhJN9ncMqxS8JgCzIPUCz4/OtcXqTMfD/g+CpOkGavyjMAE5Upk58a0OE33A==
X-Google-Smtp-Source: AGHT+IF+soidRlhzyv4dS82DpJw+lOngVuJk7kF/LFLzK4LWYPZxk/sRyCOxX1cli1MK44zTbVpGEw==
X-Received: by 2002:a17:902:cec6:b0:1f6:62cb:7c22 with SMTP id d9443c01a7336-1f9aa45a631mr77847995ad.46.1718925665468;
        Thu, 20 Jun 2024 16:21:05 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5cbbsm1573635ad.137.2024.06.20.16.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:21:04 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:21:01 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
Message-ID: <ZnS5XVJaK1fWvkem@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-2-ipylypiv@google.com>
 <ZnAS1nux75l7QlqF@ryzen.lan>
 <ZnHnACszbExFJSuY@google.com>
 <ZnQXvmvbRWQs9dpz@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQXvmvbRWQs9dpz@ryzen.lan>

On Thu, Jun 20, 2024 at 01:51:26PM +0200, Niklas Cassel wrote:
> On Tue, Jun 18, 2024 at 07:58:56PM +0000, Igor Pylypiv wrote:
> > 
> > I think we should explicitly memset buffers before passing them to
> > atapi_eh_request_sense() in atapi_eh_clear_ua() and zpready() so that
> > atapi_eh_request_sense() can have the same behavior as ata_eh_request_sense()
> > with regards to sense buffer expectations i.e. both functions will expect
> > buffers that are already memeset to zero.
> 
> Well, you could argue that:
> static bool ata_eh_request_sense(struct ata_queued_cmd *qc)
> doesn't take a sense_buffer, but:
> 
> unsigned int atapi_eh_request_sense(struct ata_device *dev,
>                                     u8 *sense_buf, u8 dfl_sense_key)
> 
> does, so it makes sense for atapi_eh_request_sense() to memset() the buffer.
> 
> 
> > I think that it is still benefitial to remove the redundant memset() from
> > the ata_eh_analyze_tf() -> atapi_eh_request_sense() path?
> 
> atapi_eh_request_sense() should only be called when ATA_SENSE bit is set,
> so this is only called in special circumstances, so it is not like the
> memset() is in the hot path.
> 
> If you ask me, I think that the current code is fine.
> 

I didn't think about the "takes a sense_buffer as an argument" vs "doesn't take
a sense_buffer as an argument" aspect. Yeah, keeping memset() makes sense in
this case. I'll drop the memset removal from atapi_eh_request_sense() in v2.

Thank you!
Igor

> 
> Kind regards,
> Niklas

