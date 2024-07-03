Return-Path: <linux-kernel+bounces-239699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824092642F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979A9B21961
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379D17DA06;
	Wed,  3 Jul 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsKAr67b"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9817B51A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018826; cv=none; b=q2lKkS8QBLespjPc/rg2zvUwFdDDqtgyn8hQV53gGV6kI4ge2dO6rAoT1lLmLugYBt2MVAMgvYdpNdWCBP5jceu6feQRWKUqPUD1cLMO8Y2vMOhx6OsJQjaN1TE/F1nSF99CxjKy6itgGByCjCmfP7L/l8+3tDBARiBiHvy1P4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018826; c=relaxed/simple;
	bh=pSp1PuzxRZWoBwl8zQSH/UMHtVtob4sP/bXio51smWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDTs+DUD96FMllLanH4XohxiXRA+u0lbYj6Jj+5fVpQrAgMkcW1n4HJXZrUmZjBK0YafgG1tzEEBcfEE5vG1WR6f9DyLvH1fPrcew8NaghMz4MqyIp5+EezIguOdJNcWMzB0XcdW9gBu8qcg+TXi+iEJzMBooZumf0InC8zcJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsKAr67b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257c6eea33so72865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720018824; x=1720623624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3fbSQlxY/yUSIUYh846kDWcQmu6yIB/4g3qlEW2O5o=;
        b=dsKAr67byPoIGAls4so4GJt1bRZ0FTRNnQPjTYtsFIWQ36Nuwq/LYo/oOBL341HzH7
         vFIVmk/WXImx3uN+plwPUL+Cg2Hj+O+4h9AZS9Y6re/CmgvPypwm+MD6+arkQL41w6Q/
         lt7Z6KQ8iMdjCjoZsx476Ed+6tQhPBfId5Mbd3gsfPG2B2c2XczhDJ2YXcnOasA2czh9
         7JvRwKv6m71LSxhtpCaVyj5f5s3B6NviIG22M3LYIAnLV+tUyjm3wAjXaCgyTDbJUgDe
         det/kmsEk0BMnIRwHbkzNHAc0FPyx8BiK9BAjQs20OVF1y41WhAq5gFUbe2F7LBcAIQm
         GPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018824; x=1720623624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3fbSQlxY/yUSIUYh846kDWcQmu6yIB/4g3qlEW2O5o=;
        b=TLSSxdX7LphgG9G+EFKP1MoydoU9PItnPYI93vZ47ZnCDoaTMdIzH2qegL3vvC6ij0
         C3zb03avReZDlKD8oyfNvAOFD38DaBfB/RFKenFwo+117YaSyW2051lfBliEFxJDZSdx
         +6K8/fvWc+ZuA4U9S3fyP0ofKQwAMZJlJKQWoDB2UZgakv+U8z84BzE6sb91Bs3JasXH
         c9nkA+ge0q5wgUoiPsIn3GNZcoxlJbNZxWuK7rHttIA5cPAsNVyiBRYATbvuDdbvyg4A
         rqPMJ9k0s8xUOOP61CV3IgwKBjVF8/3JAJPYa74aiQ18e/BYAU/K/LeHakToAANu3Qc2
         QHig==
X-Forwarded-Encrypted: i=1; AJvYcCXUmfvwhaXj8UL9X6HXcF3qWv7RDHcJwvBx8e8ZRUpxpx2sPD0+dRte0hqPJBak2gRPTsTXnjwNhZvTzlBD4HM91J62N6DbnSXIILFi
X-Gm-Message-State: AOJu0YzknXG6RVmEimcXGq32gERhKT2QPlnyf81k0i1il+IgvVLY2IsZ
	vqnqxp1F5q3yVDzdSeiLFqp6033ucgUt+U3cO3XZSvo0WoRP7LPhuvtFFlUUoQ==
X-Google-Smtp-Source: AGHT+IGT2Fd6dmDgxQq0oDtjzEDnYQUJ92c772h1n5wmEe17DjTkq1mzFTmeGPGSC/hShAjW+3OAlA==
X-Received: by 2002:a05:600c:4f84:b0:424:895c:2f97 with SMTP id 5b1f17b1804b1-4263f7db838mr1542835e9.3.1720018823566;
        Wed, 03 Jul 2024 08:00:23 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af557fesm245013755e9.11.2024.07.03.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:00:23 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:00:21 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <maz@kernel.org>, arnd@arndb.de, will@kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 0/2] misc: vcpu_stall_detector: Add a PPI interrupt
Message-ID: <ZoVnhY6PzZ9kCzpw@google.com>
References: <20240613141335.1134341-1-sebastianene@google.com>
 <86tthwki93.wl-maz@kernel.org>
 <Zmsh53PnONKG23MC@google.com>
 <2024070357-henna-dubiously-bc1f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024070357-henna-dubiously-bc1f@gregkh>

On Wed, Jul 03, 2024 at 04:34:08PM +0200, Greg KH wrote:
> On Thu, Jun 13, 2024 at 04:44:23PM +0000, Sebastian Ene wrote:
> > On Thu, Jun 13, 2024 at 03:52:08PM +0100, Marc Zyngier wrote:
> > > On Thu, 13 Jun 2024 15:13:33 +0100,
> > > Sebastian Ene <sebastianene@google.com> wrote:
> > > > 
> > > > Hello,
> > > > 
> > > > I respined the v2 version to address an issue previously found here:
> > > > https://lore.kernel.org/all/202406132132.FBKSWFav-lkp@intel.com/
> > > 
> > > So is this v2 or v3? Having two v2s on the list is... confusing.
> > > 
> > > 	M.
> > > 
> > 
> > There is a small change in the patch 2/2 so you are right it should be v3,
> > sorry for the confusion.

Hello,

> 
> Please send a new version, nothing we can do with duplicate series on
> the lists...


Thanks for letting me know, I will spin a new version.

Seb

