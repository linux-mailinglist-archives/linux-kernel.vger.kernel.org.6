Return-Path: <linux-kernel+bounces-271458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EC944E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334F6280C50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A721A99C4;
	Thu,  1 Aug 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ubdr++Sm"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1A1A7203
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523900; cv=none; b=k0JDhLWt5zTQmldSLpAU6dmWnXnP0CezAFnt5VfMlR/L+xmUsQa/K9Is/l/oiWK54FTAE0G9yu0JzW66S3i7XRL7Tpexgs/vYPVYQ2FFeTRsnjLFczmehfrBKopOLMOLEFZ415nCnrMg5+/YIHZosdj2zU5+mx+0BNF8MCEyFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523900; c=relaxed/simple;
	bh=nn9LkWIhnh3vLamC+TAfbe6VpAJDcd4OQsBnnLx771o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUD+6ofsJgDL/15QD6pACxLhnC4WLHu9DcHeuYNqjByn/t70b3GJjpsjAtmjUW+1SUrek6SUjyqHrc4A3shuDttCNn2y598ikdN7YF8OfZWgvPpr4Hkg9YrW3bivXCgCuqp5vkN6+C/Wug78rz5kpyYuizOhKl4N8ScvkJmz92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ubdr++Sm; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70945a007f0so3500444a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1722523898; x=1723128698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eg0bXkfAj/+Bepz1s51Vu2b4PmWBXCOAEfolPp84uSo=;
        b=ubdr++SmdOYo2WqzodztaU7dc8ozX0ayIX+L0ldKpegzFlLr0wQwBOKrK7NwWiOZ3t
         WGlnAUMPgQtNgFHZzD95frdOR2wMbRYbVmx5tyeWXoqQrmkWG6rXJuhTwj712q6kcaf5
         98yBItbXEeeembV7pDXM7Qs0Eg3XVekFnxplJr9yVXT6Q3epUQw71m+bhbQypS+382Yj
         GWB9AwJsbeINmHQWAgb9457tbeogSgFOOAQo//4LToOfq+ABs4Bxvc4z4M0H3Kc4pybL
         fX/2wuUXX5wlWjihCfz0b2GzetvmWeupjTZjn6sIbQFOAYnMvi8W4OWyVzYIuV8amYu9
         xEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523898; x=1723128698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg0bXkfAj/+Bepz1s51Vu2b4PmWBXCOAEfolPp84uSo=;
        b=XDAIdSWLw2KEaaevDEtCULHQrlqde3gsVJ/2DjEK4OebxSFf50wdsNE5KpUCb23Q8X
         q3ZanWDNucDj0awoPcpim9y7o8WjLqTAXN1d8FNoNMp82JLUx2gNGaVzuhlbGRjM0Hh/
         a1wWd9ZuAbK+D/X6Oj4RBbdBWcCREwuPbJMGXYWt2l8x1WF6DWqIsWlCOPGFUN+pqnpX
         BXbbf0gsTn3MwfujNjxO7f9GOsBAnzUpU69anIWLHNcqr7TVeWQmHclqYv5G5BOFxcR0
         CV6ft82vDV8hsdH+NbvXyrKCW29/GIU+IB66xoC4E7mbGwAS7GeO74NqvjjQrLKV8TMd
         ZVSA==
X-Forwarded-Encrypted: i=1; AJvYcCWzsc42Ud9udowDw9le5xI0/GaEn52mWGIOQQlax18gYgGfoETEPawdKyzADoVGZ55wCMh9ctvzfHmJglyPNQeDbCAu8PVSLl11byuF
X-Gm-Message-State: AOJu0Yw0WdbIhO5CMVV3In0rtpvVS/ZbVZzovf1JJkpT5TJ51mpJS6pt
	fp4AXvrukTQ2ZjnDDEGnbVZTb5gQ94Rzw3O3E6yH98EJA52pY+IMg0eNp/No4w==
X-Google-Smtp-Source: AGHT+IGvTWg2xLo8ers9vXVYlOj18rTUnVG5OWnVAexPis43OnNwricIwWWqflTqxwAsnRfQesQt3A==
X-Received: by 2002:a05:6830:628a:b0:709:2677:3435 with SMTP id 46e09a7af769-709b321d108mr403607a34.15.1722523898211;
        Thu, 01 Aug 2024 07:51:38 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a20d6426f4sm159025485a.8.2024.08.01.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:51:37 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:51:35 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
	linux-usb@vger.kernel.org, skhan@linuxfoundation.org,
	dan.carpenter@linaro.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
Message-ID: <890e0ed1-25c3-414e-9e8e-f5925fe8c778@rowland.harvard.edu>
References: <20240729182348.451436-1-abhishektamboli9@gmail.com>
 <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
 <ZqkpOQIjcBSAg8rC@embed-PC.myguest.virtualbox.org>
 <5d7870b0-6b63-430b-8885-2509b33dc78a@suse.com>
 <804a6d40-73a4-4af6-944b-95e9324d7429@rowland.harvard.edu>
 <Zqp8vbbIC8E/XrQY@embed-PC.myguest.virtualbox.org>
 <b35a344a-018b-44ae-975a-7767a3d5b6ec@rowland.harvard.edu>
 <f5d4711f-9b4a-457c-b68c-c2e9aefbe4a8@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d4711f-9b4a-457c-b68c-c2e9aefbe4a8@suse.com>

On Thu, Aug 01, 2024 at 08:54:18AM +0200, 'Oliver Neukum' via USB Mass Storage on Linux wrote:
> 
> 
> On 31.07.24 20:19, Alan Stern wrote:
> > On Wed, Jul 31, 2024 at 11:34:45PM +0530, Abhishek Tamboli wrote:
> > > On Wed, Jul 31, 2024 at 10:04:33AM -0400, Alan Stern wrote:
> 
> Hi,
> 
> I should make my reasoning clearer.
> 
> > > > Replacing the variable with a constant won't make much difference.  The
> > > > compiler will realize that bl_len has a constant value and will generate
> > > > appropriate code anyway.  I think just changing the type is a fine fix.
> 
> While that is absolutely true, it kind of removes the reason for the patch
> in the first place. The code gcc generates is unlikely to be changed.
> 
> We are reacting to a warning an automatic tool generates. That is a good thing.
> We should have clean code. The question is how we react to such a report.
> It just seems to me that if we fix such a warning, the code should really be clean
> after that. Just doing the minimum that will make the checker shut up is
> no good.

With this fix, the code seems clean to me.  It may not be as short as 
possible, but it's clean.

Alan Stern

