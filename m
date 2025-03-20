Return-Path: <linux-kernel+bounces-569562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C3A6A4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4CE981429
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481F21CC74;
	Thu, 20 Mar 2025 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6jF10+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4FA2066DC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469356; cv=none; b=TM9dDkeD0d5VbIf1YNqtpS6tqOZpUSFQn2YU40LT5peC4/0r7/37zFuPvlsX6BLfV3lx1WcfyFAzd7zY+dzE94kFpaqZ/jlvQ0hliV7BZxxLNuLvEeXPCly4aRhEUuytNykdcQFv7snVPf86iG4c5nuxiuskkqtqLQ1xMesvHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469356; c=relaxed/simple;
	bh=GuTQSbeQ/uP+AkFQJqxbkb9TGxhTiSjtGoEhGkkSwoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyqftioviHI4440ACqHoBf0TO2S8tRUIyNdt8sEncxXdszcXbyYcnUNEeyUM2dJMXsUPdmNrjmqRkHGfPY0wnlPvvLY/6npYMTjDASqdjCuU8kLe95oXjA/+yobOFbF16sa0QWhIHOl+FXmu7wBNSOFk6Cc9aAvw5zdG+rEE0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6jF10+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742469353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zJmTq24j2TSdEMXZRAZzOm55bRd67GQpITR3GiP3qM=;
	b=U6jF10+rzxKZoc+KEvv4Fi7PdHoZ0i9ghA4zqGxmvTqhcfLMcVhrLd/Jsk2A3qdiiZg5iy
	KkeYglUBLDZ7UfFxg1Z8g/6nuAOeZJ4NE6t/e08nt7YzZZYWuThnJVAKmRGAIC58uTj5rR
	xyDN2Rxp08q/ee+l3hihG4nO9nik1LI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-i5iPdAL5OZOjPLCFwOQXgA-1; Thu, 20 Mar 2025 07:15:43 -0400
X-MC-Unique: i5iPdAL5OZOjPLCFwOQXgA-1
X-Mimecast-MFC-AGG-ID: i5iPdAL5OZOjPLCFwOQXgA_1742469342
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912d9848a7so896370f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469342; x=1743074142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zJmTq24j2TSdEMXZRAZzOm55bRd67GQpITR3GiP3qM=;
        b=Two7mGDtBvOhexbv+QPuL+DvjHFF5bSSIg+K4pkqqLBQ/IahKY8LjMUO0MY1VyR8cW
         mBBUo99IYLgg408cjKrC8p9Y+6mosvoCS9qOE31JZSStN5XB72pnmFWLfBGa8u354mII
         jDyEf4sTGlLFh+U6Er1kyJoGI7a3lHu/odY2iyoTqYOtYvmC1wjEFWZCe0k0PVtJFxqN
         IL4TQTDVaOIBrhn31KwsTOufzLPla0Mg01wa8kwmz84dxDK4qFQjZKGXueBIMf92c7yy
         zePwDCpZXuLHuloiMaQD38BImGDRix/rA5emd5LfCTsZUnS2gC0lPFlORxmtC6xWDNPZ
         xJVg==
X-Forwarded-Encrypted: i=1; AJvYcCU2LL4Z+GQzagyUK1X44a4F07bvGB+UX2SP6f6iUuUmXDDvRuD8eC1iOKxnQdjk0rcemNzL/0ThxLaamUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uWvC6xDawa+Sy7rKBpjilvFpgRSa1lkYboo4atF2pgyjVZlG
	ATJg4NQl4kXK+tC5feXqWLE/v59cHO+yVbwQo1OMbCrRHI9fy3GsIa0BY+n6NFdMDBbtwWQBxSP
	dQZj5Nm6r14S4Dhq4BMt/TKKio5pt8EHaxa6DrLcXPdznXUxLhypNVdlDw2IDPY5fhELC/w==
X-Gm-Gg: ASbGncukYGK1QciZB/eumbHBY88sIf5ER0mKDRQy/+Xa2FRwJJPJLrP8WtkZO6fMYXg
	sj/m0qZcQaV5NTyyJnPhrUfXRMSX3Yx52/P7WjKheH1bD+rdB5KYSXOS6odZjwDQbP+nn8nzo3y
	FfJV04GkAxXpZCYwgb0zPFO3L+Ot0iIUBqasujpKlmrEQRAPe4UblUaNZrnf+6kKtU3jw4VBytC
	VWBqpCip7RMD5cMKMpL2IfATN51ios3Hfphr5Ad8IpHrQuG0FUMFrv3v9RhjN/LojoCIZkWbrsC
	o8YyzBoNCSYa1bDxv0W+qTPjYIM4CJVZV7EPmYjaadRVqOsBe814wmXZyVYvCiLz
X-Received: by 2002:a05:6000:1548:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-39979556803mr2541230f8f.1.1742469341611;
        Thu, 20 Mar 2025 04:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqDtibOAZ2y1N0SPi/SBBDfHiePj8pG89PRaxe+lkVMALTkUpR5ddcZlaBUIMF9H9cEQB2cg==
X-Received: by 2002:a05:6000:1548:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-39979556803mr2541194f8f.1.1742469341019;
        Thu, 20 Mar 2025 04:15:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f7460fsm45091825e9.28.2025.03.20.04.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:15:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:15:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC PATCH 3/3] tpm/tpm_svsm: use send_recv() op
Message-ID: <7v7v7quud3z2fb5edh3aogzjyvb7lciaqlvjeuii3ca4glvlmq@joxaspk66q5v>
References: <20250311100130.42169-1-sgarzare@redhat.com>
 <20250311100130.42169-4-sgarzare@redhat.com>
 <20250319195818.GC126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319195818.GC126678@ziepe.ca>

On Wed, Mar 19, 2025 at 04:58:18PM -0300, Jason Gunthorpe wrote:
>On Tue, Mar 11, 2025 at 11:01:30AM +0100, Stefano Garzarella wrote:
>> This driver does not support interrupts, and receiving the response is
>> synchronous with sending the command.
>>
>> Let's simplify the driver by implementing the new send_recv() op.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> Note: this is based on "[PATCH v3 0/4] Enlightened vTPM support for SVSM
>> on SEV-SNP" series [1].
>> If we will merge this series before it, we can just ignore this patch
>> and I'll squash these changes in that series.
>>
>> [1] https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
>> ---
>>  drivers/char/tpm/tpm_svsm.c | 46 ++++++++-----------------------------
>>  1 file changed, 9 insertions(+), 37 deletions(-)
>
>I think the diffstat speaks for itself, you should send this as
>non-RFC

Ack, I'll re-send it.

Thanks,
Stefano


