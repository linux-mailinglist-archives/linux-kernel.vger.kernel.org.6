Return-Path: <linux-kernel+bounces-269652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77481943566
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF361F24CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ABD38DDB;
	Wed, 31 Jul 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV0eBr6u"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AB1B977;
	Wed, 31 Jul 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449095; cv=none; b=c5D5VcaSKH609lRtQRyI7Jmx9YHHU8TCVn4EgWYh7XBPUhWdioOIVSmN5qS1D1ecat9C4PMq51p1xM4DCLaebOtJsoCcP54g0oDmSPQn7FiNK5EL7pX039hkOOjBHBhQeiwhUarp28Y1TfnXqMbTkOyJJ3++XZDvy1CrNJkWbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449095; c=relaxed/simple;
	bh=H1eCGLUAUKLgn0fxJh75Nlr9rCHwTsr99fT5Sm7CQ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbbwN/R8aEEiE2zO7q17PPyznhJNziQyCSX+frHcKZif35je43cYsb1A6VxNMb0PxEpR8Y/hH5s87Nfkau+AirYlOzIM8tjuRaG6LUyKngFUK0AToKeb3GgTz9VIhbCw5RxSnLHP7CxLvXZUy+4OOQBry1758cLtqG6li8tEPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV0eBr6u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc56fd4de1so9267835ad.0;
        Wed, 31 Jul 2024 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722449094; x=1723053894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqDcpi/n8xO7BkglMX5k5WSiH67lYtHRaeeKrrUno3g=;
        b=kV0eBr6uGXkd4xwq+aSnoI+nwjEsg+5WbCg3aCQa1CQJVu1F9VRSTFVt8Qaz+4/ZIa
         w5jBGNVJ+WXQC0ZFutGJlZz2hlIQVbzXR1ojw3dDHGkRCdNuFvIsOyK6X5BNduRVsa4Q
         EfboDbVbyUIvu31c7xfq+CYk33+Tht5jT2g4WxEoK9KL2/xLhcjL7LBOSWzJ+hSVUq26
         skeBGIBftP8iLmJiXqjgtYE+bjBv767I7Xs/evCAHbqlLq+gb/ae2xfwx9/o7JD8rTPm
         zrUk6IkG1uykPkl5prfh43S2ns4PZjqy90tI5apd7BCHzg0JLxq2ExbZU4q6pHPvSVzN
         h1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449094; x=1723053894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqDcpi/n8xO7BkglMX5k5WSiH67lYtHRaeeKrrUno3g=;
        b=PXv9Y1piAm2YZQY+tfHHL9a3psSH997VjmllrGO6L1Si92sOF22QETk7nxOXDa8eVJ
         Us5neIq7FNhaFdLL894t8W4utlRv9pWdKue2MyXIjV1r93dw22JqRfBmcpZxKxhFTACI
         dGelz8iSrQwysOeqIks9fCaV4KbFzZvC5sBi0IkwqdzOOHuI05KoVLmafN5DKZDlnBYp
         gfOKbIS1R2A4ALIUBC/lSh57m9e2Ts4hHXi5nEcGT5ktgv8nRxHexanfSDngOvZUA68a
         lZzGxpos3iPnIB2zmOj8GMpiOku+6RQS0mKvNjotFqUoN5XjEo2RUa5a63kVwU8iZC1N
         Wytw==
X-Forwarded-Encrypted: i=1; AJvYcCUVTcHBZm8sFktYwziRWUFAdjCAguPko0lmsh0wmzMHhaljYMUWMVn/mErDIDq7KTuK1rqbzgKu8Qpm2eqJ5FdIkn9aMmgnk1HI2BwnQTPTT+e+Ht7vzz1cuortT6iOzSKSSbUhF/1/
X-Gm-Message-State: AOJu0Yz01ZwtjjUYyIFcxH4Rzz0XB0Q9e+OtZdaCV0S/qtBwpTQg1ffo
	CjhEldBG6fIpvChQEPGJ5MaB7sEdrMC484+8KVG3BnnHblVal1fy
X-Google-Smtp-Source: AGHT+IGr87v+wUp5xqRXUlpuhwtmGeHd1j63CbMiwKHYVOmvATIS215NgGEEX7p60CPIlwtSs+DC1Q==
X-Received: by 2002:a17:903:120c:b0:1fd:74ac:e6b8 with SMTP id d9443c01a7336-1ff37bc6620mr119657695ad.7.1722449093673;
        Wed, 31 Jul 2024 11:04:53 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.205.109.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee6a1esm123666655ad.164.2024.07.31.11.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:04:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 23:34:45 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com,
	usb-storage@lists.one-eyed-alien.net, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
Message-ID: <Zqp8vbbIC8E/XrQY@embed-PC.myguest.virtualbox.org>
References: <20240729182348.451436-1-abhishektamboli9@gmail.com>
 <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
 <ZqkpOQIjcBSAg8rC@embed-PC.myguest.virtualbox.org>
 <5d7870b0-6b63-430b-8885-2509b33dc78a@suse.com>
 <804a6d40-73a4-4af6-944b-95e9324d7429@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804a6d40-73a4-4af6-944b-95e9324d7429@rowland.harvard.edu>

On Wed, Jul 31, 2024 at 10:04:33AM -0400, Alan Stern wrote:
> On Wed, Jul 31, 2024 at 11:15:28AM +0200, 'Oliver Neukum' via USB Mass Storage on Linux wrote:
> > Hi,
> > 
> > On 30.07.24 19:56, Abhishek Tamboli wrote:
> > > On Tue, Jul 30, 2024 at 09:09:05AM +0200, Oliver Neukum wrote:
> > 
> > > > 1. use a constant, where a constant is used
> > > I think you are suggesting that I should replace hard-coded values like the
> > > buffer size with named constants. For example:
> > > 
> > > #define BUF_SIZE 8
> > > unsigned char buf[BUF_SIZE];
> > 
> > Yes, but the constant we need to look at here is bl_len.
> > This is a variable needlessly.
> 
> The code in ms_scsi_read_capacity() is written that way to be consistent 
> with the sd_scsi_read_capacity() routine.  Or maybe it was just 
> copied-and-pasted, and then the variable's type was changed for no good 
> reason.
> 
> Replacing the variable with a constant won't make much difference.  The 
> compiler will realize that bl_len has a constant value and will generate 
> appropriate code anyway.  I think just changing the type is a fine fix.
> 
> > > > 2. use the macros for converting endianness
> > > Can I use macros like cpu_to_le32 for converting the bl_num and bl_len values.
> > > Should I replace all instances of manual bitwise shifts with these macros?
> > 
> > Yes.
> > 
> > > For example:
> > > 
> > >      u32 bl_len = 0x200;
> > >      buf[0] = cpu_to_le32(bl_num) >> 24;
> > >      buf[4] = cpu_to_le32(bl_len) >> 24;
> > > 
> > > Is using cpu_to_le32 appropriate for the data format required by this
> > > device?
> > 
> > Well, the format is big endian. So, cpu_to_be32() will be required.
> 
> Better yet, use put_unaligned_be32().
Would you recommend submitting a follow-up patch to incorporate this change, or should I leave it as is for now.
>However, there's nothing really 
>wrong with the code as it stands. It doesn't need to be changed now.
As you mentioned there's no need to change the code, So my initial patch is okay as is?

Thanks & Regards,
Abhishek Tamboli

