Return-Path: <linux-kernel+bounces-267987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F73941F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587001C230F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21E189906;
	Tue, 30 Jul 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP1eOuxI"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575031A76C9;
	Tue, 30 Jul 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362177; cv=none; b=tmR4actXdIEwgGbnL0tinPitfrJkAFzcm4NQEZY+Fm3A2hhL2uMjUDoMrHRRpv09c+HcN44DNF2UiesviyeQsL1GlSZpD/1WJksV5xgU7dK5zRZ6blmlKcOu9MMrfjpBT+E6Pzxs9HyXfHc4Uu3dbTFrRLUgTeJaynjenML8ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362177; c=relaxed/simple;
	bh=6vAOKdphjzKdVk57ZBLwcpv4/xeXmTtrgguL3dS7fiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T45VnjTQ+CyiyqS8wNu57gOj0WgFSUrY76bkKqF9m/cbjP2FarGZrFuKcLJtY4MqoMzTVHazauEpYTp+UG6Tu64AidAYNNRYmyIKhvIqLpsyEr3hjYQ0VfNTpUL0GYwj8qUguObeabplVsWt7E24b58BV56FD9kRYGHBK59oVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP1eOuxI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fdd6d81812so38751675ad.1;
        Tue, 30 Jul 2024 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722362175; x=1722966975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=No6rY78M5KIj3DpjY3N15+J63kX9R0sT/Ncp0Ijs1fo=;
        b=FP1eOuxIiURPotTFUa6M5Kt0ST9pJPUXLiO6259MpvvLvP12luhtx95PsPq2sDyJH0
         2Zbk4hDLDiFhNkGcEf8JH6IakxnoaMG3D+YUw5VaDFBLbLaWdgSXraZOu2wJW+h8DseC
         cpO5TyQNpw2rOBlx5c4eHmNL9F9uxpSO5LJtp0H4IQjuX/g9Vj6Ihlel3QIj3n6Pv2Mk
         pbQxvrAm5L+YPStU1KwONdapqCezB0BxkkbpVpdGHZCem0J9zNdR807wQu3RWdDplU8V
         RnZINNOGux+pXHXCgvHJR7j227Knowx9xgKrWwXmPeYmSFcP4bXGoFIBctYAlocU0/Fw
         4xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362175; x=1722966975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No6rY78M5KIj3DpjY3N15+J63kX9R0sT/Ncp0Ijs1fo=;
        b=mxCMKXCqRp/fd+HMQj86qMAINjC7YAQmuBMYjzOrwjSWwoCk7eqE/nUGrZ24EzaRoU
         SP+4ai8r5V4BPpw28ZV6LiN/lzpCb+1Ah7lKjyjrK1qJxzkE8mTmGdt1hiyAlE6GDIja
         lIb+p0dFSnGXsJDwb1AHufuc0dsXt3IidQT6OX+K7AOOM8IC1PjmnhpiBQyyT2Hc0wIJ
         cVKcE9mrKGtJpQ3xZmbLK+BKIE25pp/XhWaWMDUtBc1kkTfmCRY2DysPymi5HAaicIx4
         QfnV1gkeEkPMI0n9vjOI2d9stQHx4VSlzPAxj9MbPbKucZV2kHia1HWw2l6fqdKwLpkS
         yQLA==
X-Forwarded-Encrypted: i=1; AJvYcCUB9aGUTuc4tZ/G9aZl6jlb7xV3I6K7VBQj0qMOMHussp7g+QLbpRs1DNZmbpLf/XinkgWD9LlB0DBP@vger.kernel.org, AJvYcCXswenjQwkeIKt0izPAvrQ/XylXhQli5sbhVB+YrtoX2IO4phoOLgdL9XQZX/lk9+VUH94/J/r48QLYNps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbmt9tkVu1nJkbPeEHnNOJ5rjoGPB8wh5gv45lnP0Se6vLVXa
	UiKXA0PojOvU8Eq0bUXSOcZCG1M6jgqBXdGISCATPRcMM2//kCBt
X-Google-Smtp-Source: AGHT+IGeSA5Ardyq54qcy8JsPanVQiscsfFe2/iPX0z4l1px61+9+Ma6z8Z0QjCES1xy2qE3CX/ZOQ==
X-Received: by 2002:a17:902:fc48:b0:1fb:1cc3:646d with SMTP id d9443c01a7336-1ff048521b8mr155538275ad.29.1722362175400;
        Tue, 30 Jul 2024 10:56:15 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([49.37.130.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1b6c3sm104848285ad.192.2024.07.30.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:56:14 -0700 (PDT)
Date: Tue, 30 Jul 2024 23:26:09 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
	usb-storage@lists.one-eyed-alien.net, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
Message-ID: <ZqkpOQIjcBSAg8rC@embed-PC.myguest.virtualbox.org>
References: <20240729182348.451436-1-abhishektamboli9@gmail.com>
 <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>

On Tue, Jul 30, 2024 at 09:09:05AM +0200, Oliver Neukum wrote:
> 
> 
> On 29.07.24 20:23, Abhishek Tamboli wrote:
> > Change bl_len from u16 to u32 to accommodate the necessary bit shifts.
> 
> Hi,
> 
> while this patch is technically correct, it papers over the issue.
> Could you please
Thank you for your feedback on my patch. I have a few questions to ensure 
I make the appropriate changes.
> 
> 1. use a constant, where a constant is used
I think you are suggesting that I should replace hard-coded values like the 
buffer size with named constants. For example:

#define BUF_SIZE 8
unsigned char buf[BUF_SIZE];

> 2. use the macros for converting endianness
Can I use macros like cpu_to_le32 for converting the bl_num and bl_len values.
Should I replace all instances of manual bitwise shifts with these macros?
For example:

    u32 bl_len = 0x200;
    buf[0] = cpu_to_le32(bl_num) >> 24;
    buf[4] = cpu_to_le32(bl_len) >> 24;

Is using cpu_to_le32 appropriate for the data format required by this
device?

I will make the necessary updates once I have your confirmation.

Best Regards,
Abhishek Tamboli
> 
> 	Regards
> 		Oliver
> 

