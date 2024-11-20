Return-Path: <linux-kernel+bounces-415869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C6F9D3D62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A432813F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C491AB6CD;
	Wed, 20 Nov 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXNhBV1i"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EF2746D;
	Wed, 20 Nov 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112250; cv=none; b=gH+KjGkeOf1JF+3jC4OS9usHQUpRkFsnXr4D2AnzWcK5bUAG2K6pSUu6eJf4rU+OBA+2HpeNJllLaAE5yYLDicjeH4Ln+SMl9JK6IRfvV4ZidC9QQcSq9rQ4lac4tx+9x4tLzzO0MOW4cnmubVDGrMg2depv9xoXNMCtGGTA6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112250; c=relaxed/simple;
	bh=HogWdnf+gEHBSeIlBDgdFSdAuYMxYp4y2Azfwc74ToU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA7M/dexjjkWFDeXI3El/2y0KnpAPZR2/5zT17fHs1NRqd80ElWZxejdod9iZWaEmXrEE+u23L0WX/qA2HJzFcXdvWMlWgBslxUiih+uf+ttobpb4wJtCNHiq3JEt6oeT/NxzS4aPTF4+iMV5iYe/uLwE5ZNdk3BH81QbS5/7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXNhBV1i; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eea47d51aeso28907247b3.2;
        Wed, 20 Nov 2024 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732112248; x=1732717048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0ccxSot4avXFbxADK2ckghODPjyViSvYvN2WCFkbOZs=;
        b=VXNhBV1ian+kdGEWiTgo5orY0eX9xty5Usmw2aWyP9BCJMhj6d6xSV48fyIyHC/UJF
         eR7WP8PRRchGA8n9sUl+uTCOD1cmfPpZyeqXp/XRw4pGb6SeP4oVVrOBtaSt+9lTKil7
         vXe4ZvKXWs2VZki6GxwYQlNq+LLUoy/ufZnf8SpFGIV+jYTvmOTrvGsvWA0r+ekfdVrK
         ngfFlYAh84eC+p8NrjEmNJgSJ4skplWId+g1V+I5g/CoyuHIhmUIE+QJL60ohE5U24Ca
         nBjpWVYLqQ8ckVmD+5fq4wnDdfaEdGfUc4QwoTHlx9wP2le0ZhEdWo1/z8LH5vIfcSoR
         jstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112248; x=1732717048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ccxSot4avXFbxADK2ckghODPjyViSvYvN2WCFkbOZs=;
        b=i6+S/iBXuEyZMl4rTlS3inWY/I9Ld+Qd5PG0r4Neh3e6RN35D4JiA0fGxa7tqiWo1m
         +7MLYhyR9L5Op1l8qqmj4u/LUPtLDjC4ESlt6OgPpKdCpXHhTLGhIVbVt9uC5nmEvn/G
         /AqJwuK5+McWkr7i9MxVZ3ZfsPCjSbwuXCQc3Fobex1/97/pfGbtHxSf3NTAzG8rGn+2
         Ky0Tefu/ZihQgnPZ0r+v9bjIph4cQFg1BzDISelNqRL5mD0S40jkbLtwQOjxF/nGOgTX
         W5SeOV3TmuUYoOXqs8DzkXNGK1jeVmgCOBIdOUgs8bsZw5/WgY/e6zCmlqS+8ezyJf8/
         Uhvg==
X-Forwarded-Encrypted: i=1; AJvYcCUZSoAdYH57NfWkbeflaAxKraO+z7LYs/Yhpqn3nD8bIofj6iBi6tN2Gwt1QFm8yJaEquUpmxF68nOwW9g=@vger.kernel.org, AJvYcCWDzrvKrmdkKdnePqUeI6SOgNJbIY8lGYeeHSxEowLD+CrCqZuIhXbi4ebHWhtjvbVcsRbywNzmdz7k@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdv0CzykO5XzxJg3GoNzMPjx0ilu4p7zEoNZpqpmeDJsv2pU4P
	NvW/JJFlcHb5vMzjBUtsBFo6aRD+2T7Trmz8Y/www7lfclkoYkcuCTNhNo3wmpQ=
X-Google-Smtp-Source: AGHT+IG2fbF9JPwAVnL8nmjAvhR+0CJ3T/VO5RNO7UqN1gUoGlhS73H4DQR0txfc26cb3YoxEIeBYQ==
X-Received: by 2002:a05:690c:4b81:b0:6ee:7797:672 with SMTP id 00721157ae682-6eebd0d6e1emr32242637b3.7.1732112248013;
        Wed, 20 Nov 2024 06:17:28 -0800 (PST)
Received: from x13 ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee71341f80sm22515297b3.85.2024.11.20.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:17:27 -0800 (PST)
Date: Wed, 20 Nov 2024 09:17:26 -0500
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rbm@suse.com" <rbm@suse.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: remove unused sg struct member
Message-ID: <Zz3vdkEzSobJ54bI@x13>
References: <20241119212452.269255-1-luis.hernandez093@gmail.com>
 <20241119221907.tyt4luboduaymukl@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119221907.tyt4luboduaymukl@synopsys.com>

Thanks, Thinh and Greg, for the feedback!

On Tue, Nov 19, 2024 at 10:19:09PM +0000, Thinh Nguyen wrote:
> > Previously, this patch addressed a documentation warning caused by the
> 
> Remove this paragraph. This context only makes sense in this thread
> where the previous patch version is visible.
> 

I’ll update the commit message and remove the unnecessary paragraph as suggested.

> > Reported-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> I'm not the one who should be attributed to by the Reported-by tag.
> 
> I think Greg was alluding to this report by Stephen Rothwell:
> https://lore.kernel.org/all/20241118194006.77c7b126@canb.auug.org.au/
> 
> It wasn't Cc to the linux-usb list, so I'm not sure if you've seen it.
> If your change was base on the report above, then you can update the
> Reported-by tag accordingly.
> 

Regarding the report by Stephen Rothwell, I wasn’t aware of it before. I found the warning independently while trying to compile the Documentation subsystem, looking for bugs to address.

That said, now that I’m aware of Stephen’s thread, I wouldn’t mind updating the commit message to include a reference to it if you think it would help link the two discussions. Let me know your thoughts on this.

Thanks again for the clarification and the reviews!

Best,

Felipe

