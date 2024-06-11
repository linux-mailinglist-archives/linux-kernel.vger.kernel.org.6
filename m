Return-Path: <linux-kernel+bounces-209266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87155902FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAD5283447
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC017083A;
	Tue, 11 Jun 2024 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvgTBNF6"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A9469D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083091; cv=none; b=QFw9z2LaPMPnhLYcp0BOMS1KuBt1BNzvQVEvi6o915nMxii9WY5GUc3bawXujcDeJr1RggQQn7r27UEhWJANnRNuD7noPf8C8SuZlwJ/nAInDig5lZAXKOWdQQhrGo/K3DZC41FBnVv4F9GFyvAHURFDAKVaNgsk18R+4M9ONFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083091; c=relaxed/simple;
	bh=6OTUcRUUrdspohxppwdQEu0HKCFgNJDqHInYXkSTd+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE1NedAW+91JWQhaDdeSI4rED9J81VWxaJf5vPN9ie00TG0xzpgATGsFz4c2glJq6PTWhqwnEct5reez582UqQbImS1T06o8Fcc9rDTplmUuH7tIM6ua+rnY6FPi7XvNdapCECeVTrhNU3XptIPDBsH7S0UII9qLHez9+rHEByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvgTBNF6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f1a62f731so1847986f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718083088; x=1718687888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmU4ffLX3V4eUudJDevCe7/zEPmQFBgv5tDr195a2UA=;
        b=dvgTBNF6YhcNk23m5OMJWiQ6ihvVnk/wa47cmBxg/aD0C1QeUdRkDEfKy/dF+jXAiA
         t+qEGgM8dGnNr+pzL0Nq1ScQ1rzFI9B4YLqq8q8eq7E2RoEsXfnX/N+8KSbjZ7N788j3
         ZAZLcjilMJFKQZIS70yCnEMlqJxVSdZkypikkQpFAZgas+y2VXvbLj0XI2Mo+p4Z1MKs
         7kFab3BaTVp/9HYMWL0KKJqacoIj5bTBYC0kI+DbexpGdZhLcN4A2S3fnhbuiIeWqz/E
         csduoXhR0w14vxqi36dSDjDuMnHRUkaQ36RBLPWj5x80TBLEx4msZOLnB+Y0q1mN46XX
         eeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718083088; x=1718687888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmU4ffLX3V4eUudJDevCe7/zEPmQFBgv5tDr195a2UA=;
        b=g3bVZf0n43GKNc26vGwM0AUxejcGme5fPh3Fyuhrps8GovjayGsEPdC/b01YKL3cu8
         QjME7hcvDJYNj+/tlG+JPEXnuC6L6Bb1eN3J2NXfTvRdzAZU7V2iy2WyMMFGLiGzy86y
         9qWuJo7AueM7qp5/ZxJGECL9GU0BNiC4eMJPT06GZuoClq2iW+UpsG2l7G1fYtKhLnrH
         LqGP1yadRpTxRjwgYJvQj6h8UGWaINBX3By7Z/1k2jBAWDdPji8krND22L8vNM7zb6sQ
         hS1EPTrg5q+Fn9lB2JpU8wsR3Hs/0OqghpnZF78YjGr5jzWkZ1jgtv47M9CK4eqMlvWa
         x+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWCZjAETtXAvx5MhcTunogS3AcciYtAa1JqVGZMYrbOqsYVj4BBIlJaIsaMvUexDSM1QGDqJorMtJDd75Hk5mjd3YmT7+q598aCuelo
X-Gm-Message-State: AOJu0YzdHfJNJPHvJjA8oqV+kRKcw+ArXtgqYTJ9bQPt08U79+jZp2FD
	zJGhoR9NQrHmMO+bzRoLl0W8fPyplEbX0tkLee2ZpFoPfKi3NqAPaMDbevTcdcM=
X-Google-Smtp-Source: AGHT+IHwP2sXbnp5s72//FcHfUYCa9pMOUptw2DRVkkSYdcOQGPFYeC0WUlKVB3MWVQURanv1ZPO1Q==
X-Received: by 2002:a05:6000:2c1:b0:35f:231e:ef87 with SMTP id ffacd0b85a97d-35f231eefc8mr4729600f8f.29.1718083088259;
        Mon, 10 Jun 2024 22:18:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24c7a9c8sm4294926f8f.78.2024.06.10.22.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 22:18:07 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:18:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "<Tree Davies" <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/24] Staging: rtl8192e: Rename variable bforced_tx20Mhz
Message-ID: <a3049efc-b69f-427f-9de5-7e18c22e30b8@moroto.mountain>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
 <20240610054449.71316-10-tdavies@darkphysics.net>
 <5ccfa433-f1be-45f6-9138-348cb4093866@moroto.mountain>
 <ZmezV4UvCEImxMBX@lunchbox.darkphysics>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmezV4UvCEImxMBX@lunchbox.darkphysics>

On Mon, Jun 10, 2024 at 07:15:51PM -0700, <Tree Davies wrote:
> On Mon, Jun 10, 2024 at 09:08:03AM +0300, Dan Carpenter wrote:
> > On Sun, Jun 09, 2024 at 10:44:34PM -0700, Tree Davies wrote:
> > > Rename variable bforced_tx20Mhz to forced_tx_20mhz
> > > to fix checkpatch warning Avoid CamelCase.
> > 
> > The correct capitalization for megahertz is MHz.  So the original is
> > wrong but the new name is not correct either.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Thanks Dan,
> So... I guess just spell it out as 'forced_tx_20_megahertz' ?

No, just write it as "forced_tx_20MHz".  Don't bow down to checkpatch.

regards,
dan carpenter


