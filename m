Return-Path: <linux-kernel+bounces-269742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88827943653
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB4E1C22BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1E15FA7A;
	Wed, 31 Jul 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHxA4SNy"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5115252D;
	Wed, 31 Jul 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453526; cv=none; b=oAikoRP7fXtCOjIW0kE/RmNk8m/mh9a6vJEOc+P3AnnQCbKvY0V1fuDF4h7lqTwhH6gMslzzINSyDQHceBim1KtekhNqGTuDjzFbakbnluWr6wd3bJfHye8wBGTCGNIyhYDHFKTKoi3AkVU2FqkWLBjASascK9Nl+Fik8ucAPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453526; c=relaxed/simple;
	bh=KJXr8v/OtPrbW9nPLGgNd7ySuI7MnDx84Zz8ZrsnQlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNPml9/mDKMSNKUIGilLj81/OrPcEP1AviLi65Sxn21JtDujzD4n6po6rmQwSY3VuRsS3bEgx9X9hSsTpYsfnSUxP2P/1a0e65FV2VSYm5rE2qnAstNVmmVOKY0FVcgSlUUN91NdBFuOgrtmunft+mbddr9zfZu30UpOk5lssac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHxA4SNy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd6ed7688cso48084505ad.3;
        Wed, 31 Jul 2024 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722453524; x=1723058324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKmXPYGLiuooxOyOTiioTCzv35HEsS/Fq6QbtaZlhZ0=;
        b=aHxA4SNyBS2j58+Vg+Fs+D4Yd+myrY3Cy/6HT39JeXRx5P+WXDgCISaVgzAzYgIKSj
         PgyTu7cBO9bit/EO/7k9lAix6xyuCwbShxgVNBWcT3Wb/CcvI1leirriDFFFkkuefba/
         CXJLnvp3Y+7tRgFVvhCwMIGpPC5Xjz2u5EWQQlmFIgIUlFFdrInLMOPwmJSshNXrJinZ
         9Hfwu91W0rmAvCzHRL9+kJG4NVY2bGS4+0I+IZGiJwfZxApX1qCezVUKflseJHp5pieW
         8S0x9AS5bIN6IQ/Aoe9tZobf90hjhUe4orEC/RmwUr5nqxYvAuc3YgBDCjvkOiyRUoXi
         XrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722453524; x=1723058324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKmXPYGLiuooxOyOTiioTCzv35HEsS/Fq6QbtaZlhZ0=;
        b=b1JW+PXH9ac8s6Uyp8QpHdiqqP2gJFlTPmUgbAhT6/AfkBjC0o92zJzPocybN2j3PP
         gBuiRZjGIguGIgw7No06Xp9sLxcFV2UJUt2iTL7vqXYwrmQP0uSGDHkXcr+Tvv6we80k
         OM88yLm+S8tnMifcPmoWhHNgsOWpu3db41hr0gKo+0qQHgkdz8zKJg+Sq7yE8THLRVy9
         FAcuM2/8cz/szV/5RhEd7Ejlzcn1Ao/66GEDqbtc0ZQ04B/ws8YIWTgvqAMG1gNewCCF
         15mnfb5OWTK55ER1hQzNcG/S6IPR0pwgD/syOTxf+53jFY6UlyzIhPxf/b5OoG7uD+IY
         i8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUFofKlUwdlIyT9gmDWDJMUqqttW3ovleryqoX29tQcufk5CknCJfiyltMFix0sJiLVWWtSWrNq4nNFJcg8A52FZyuY3BhzrhwymYnZhG+B5JRZ1b6linECyBrfT4N/kvaNYP/a4TMM
X-Gm-Message-State: AOJu0YyKd8wxAQCdGleKlFgFJ5/upCoPGdlUsiBk8qPSB4SUrqRgi8mK
	N0PCrA3IuSmeEvo9/dha0os1YLV2B9q5HK845XGvBqDif8fhReTw
X-Google-Smtp-Source: AGHT+IGtmnnl8w0OObeGNOiEbvgRRrT+3phJ2aRna86jFJDkcu5+xWDzRmjV52RpxJofqPq1X8hLSw==
X-Received: by 2002:a17:903:2349:b0:1fb:4f7f:3b59 with SMTP id d9443c01a7336-1ff4ce5792fmr3809585ad.3.1722453524371;
        Wed, 31 Jul 2024 12:18:44 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.205.109.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d37745sm124165475ad.112.2024.07.31.12.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:18:43 -0700 (PDT)
Date: Thu, 1 Aug 2024 00:48:33 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com,
	usb-storage@lists.one-eyed-alien.net, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
Message-ID: <ZqqOCYZ6TtXdXpea@embed-PC.myguest.virtualbox.org>
References: <20240729182348.451436-1-abhishektamboli9@gmail.com>
 <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
 <ZqkpOQIjcBSAg8rC@embed-PC.myguest.virtualbox.org>
 <5d7870b0-6b63-430b-8885-2509b33dc78a@suse.com>
 <804a6d40-73a4-4af6-944b-95e9324d7429@rowland.harvard.edu>
 <Zqp8vbbIC8E/XrQY@embed-PC.myguest.virtualbox.org>
 <b35a344a-018b-44ae-975a-7767a3d5b6ec@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35a344a-018b-44ae-975a-7767a3d5b6ec@rowland.harvard.edu>

On Wed, Jul 31, 2024 at 02:19:54PM -0400, Alan Stern wrote:
> On Wed, Jul 31, 2024 at 11:34:45PM +0530, Abhishek Tamboli wrote:
> > On Wed, Jul 31, 2024 at 10:04:33AM -0400, Alan Stern wrote:
> > > On Wed, Jul 31, 2024 at 11:15:28AM +0200, 'Oliver Neukum' via USB Mass Storage on Linux wrote:
> > > > Hi,
> > > > 
> > > > On 30.07.24 19:56, Abhishek Tamboli wrote:
> > > > > On Tue, Jul 30, 2024 at 09:09:05AM +0200, Oliver Neukum wrote:
> > > > 
> > > > > > 1. use a constant, where a constant is used
> > > > > I think you are suggesting that I should replace hard-coded values like the
> > > > > buffer size with named constants. For example:
> > > > > 
> > > > > #define BUF_SIZE 8
> > > > > unsigned char buf[BUF_SIZE];
> > > > 
> > > > Yes, but the constant we need to look at here is bl_len.
> > > > This is a variable needlessly.
> > > 
> > > The code in ms_scsi_read_capacity() is written that way to be consistent 
> > > with the sd_scsi_read_capacity() routine.  Or maybe it was just 
> > > copied-and-pasted, and then the variable's type was changed for no good 
> > > reason.
> > > 
> > > Replacing the variable with a constant won't make much difference.  The 
> > > compiler will realize that bl_len has a constant value and will generate 
> > > appropriate code anyway.  I think just changing the type is a fine fix.
> > > 
> > > > > > 2. use the macros for converting endianness
> > > > > Can I use macros like cpu_to_le32 for converting the bl_num and bl_len values.
> > > > > Should I replace all instances of manual bitwise shifts with these macros?
> > > > 
> > > > Yes.
> > > > 
> > > > > For example:
> > > > > 
> > > > >      u32 bl_len = 0x200;
> > > > >      buf[0] = cpu_to_le32(bl_num) >> 24;
> > > > >      buf[4] = cpu_to_le32(bl_len) >> 24;
> > > > > 
> > > > > Is using cpu_to_le32 appropriate for the data format required by this
> > > > > device?
> > > > 
> > > > Well, the format is big endian. So, cpu_to_be32() will be required.
> > > 
> > > Better yet, use put_unaligned_be32().
> > Would you recommend submitting a follow-up patch to incorporate this change, or should I leave it as is for now.
> 
> You can submit another patch as a clean-up, if you want.  But as I said, 
> it isn't needed.
> 
> > >However, there's nothing really 
> > >wrong with the code as it stands. It doesn't need to be changed now.
> > As you mentioned there's no need to change the code, So my initial patch is okay as is?
> 
> It is as far as I'm concerned.  Obviously Oliver has a different 
> opinion.  But I'm the Maintainer of the usb-storage driver, so my 
> opinion counts for more than his does, in this case.  :-)
Thank you for your clarification and support. I appreciate your feedback.
I'm glad to know that my initial patch is acceptable to you.

Thanks & Regards
Abhishek Tamboli

