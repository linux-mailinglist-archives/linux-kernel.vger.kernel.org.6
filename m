Return-Path: <linux-kernel+bounces-262962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C393CF1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9126C1F22B04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A762176ABF;
	Fri, 26 Jul 2024 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fJRe4j+1"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34081741FB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980478; cv=none; b=S5LRwzjtNhxyL+ZKgaNPk2tKFVq6bXBxBb3n2Ql9NL1Eo7bF24Tyeo1RPylT5HURyLjuQyrNrvM7brz70CtW7r+TxGkDRFthdrp4YWID0K+dQxB75AloG5YdXeej4qQ01y3mbhFq5i2O7Pe8pvO6bkgP0VX0GxDrcdniH/xooH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980478; c=relaxed/simple;
	bh=RwzWWLRlKkqepKvBN5fdT/d0yz8f733U2RRrSTg9/no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5VeWnAhrRoxTBHXCDrtdaI+kz/Dy06zpfTAKhEpk8neviGuNyZrKLX6osnST3keOsCqhGpj/uKCE7g/7NUk4HL+oRdWoqMS3Lx/y4Gy8lzADH7ON+3bDCLCDdLuOlZ7xNxgYx+DZP2Ni/9y6FKtQZVDEVnQB78AYpxBoWXbwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fJRe4j+1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ef95ec938so1250985e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721980474; x=1722585274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLnzH0Tuz7U9XRD9djw1OdkIPjJA5X6DCcdcepF94ns=;
        b=fJRe4j+1QYtJrYzwt+C5BF9XKxPgaGFjmhApX8bYLp/i47eToIanWw32Ad83PI30KH
         NKuX04y0+hDGEWebmpwK3viJeFJ/QVe+EhCB0PSttPTgbzAd/DYd0ldils+I6lw986Xh
         vml3as+CsFtC9xE/ET+W+5VUfmeJ+js4C7kRif+I7qFsFogtuQykMOB8/5sBzj4yVWN4
         IOyxIdZN4sSPHCh2iIw5etQnXQ+fU7O1ECr9Snbs3i9w2NVoywKJPKVIdWGZAw6WfYMf
         xBCgh+j4Q7VlYWaaTfke6wZICC3mK9az4/RYJao3s0qqZz2wTp/+bDlK4Q1JDEk/PXvR
         f4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980474; x=1722585274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLnzH0Tuz7U9XRD9djw1OdkIPjJA5X6DCcdcepF94ns=;
        b=UrSlB+mj3zBPJoFkehLIpp1xY5srsrmqtM7CNzsD5zq2UzaIsTpv6E5y8bqs5sqNDa
         oxotuDUAgsAxXijAmyeN03ynS7AZZAKdUhg0TEtHML1QwhnuNDPIyRtzlPzPW++rCtFN
         GOMQw0DraqDYZ6a5BdLDIBubQyQpdyDK5Z7qExrZ1a5zB8naEm6sbx1UmXwJesaiJgkC
         Zm60UhrAtUPi30JbsHD6zn8rD2LzXsQTNyDEFcptVMLg8bCuT3lE7rpwp99/ZkGjR4SD
         6A+U0gNCfO1nmcs7CQtgklEOF/SOy5Bk1Y+smzk7mzoPLNdpHi2MAQrKbzDJ4t8lEZpw
         teQg==
X-Forwarded-Encrypted: i=1; AJvYcCV0/UTGBLI3RaQYFAq0JkX3ZrQk6TVEQe3pZAKLwcXk3zWO0pKtf2OptCUjhNfzztZtHS0ckE7x/dhBLDqm9vCKmVYxjtHSFaWnctrT
X-Gm-Message-State: AOJu0Yw33apm87Kdp7RheL5hq7+CQM4YvhdYi3v+atZbV3V/dItkPw6Y
	IIB0bjKzPfTeGEcrb1wQcr5J2Vmt44C2qBdJwe9lPUodTW18SidRAazwFYLejao=
X-Google-Smtp-Source: AGHT+IFnZcbYOKsf8mFfRLK1pWmaH8ouvafSG1jZC4pd2hKy8vDuX0O20rzr0mRRxFIliC1jFHoAew==
X-Received: by 2002:a05:6512:683:b0:52c:daa7:8975 with SMTP id 2adb3069b0e04-52fd3efe6aemr3714067e87.18.1721980473716;
        Fri, 26 Jul 2024 00:54:33 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590ac3sm1578410a12.34.2024.07.26.00.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:54:33 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:54:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg_write_event_control(): fix a user-triggerable oops
Message-ID: <ZqNWOLwOoKfquBvH@tiehlicka>
References: <20240726054357.GD99483@ZenIV>
 <ZqNLEc54NVP40Kpn@tiehlicka>
 <ZqNMfL6JmgHCJwBv@tiehlicka>
 <20240726074804.GE99483@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726074804.GE99483@ZenIV>

On Fri 26-07-24 08:48:04, Al Viro wrote:
> On Fri, Jul 26, 2024 at 09:13:00AM +0200, Michal Hocko wrote:
> > On Fri 26-07-24 09:06:59, Michal Hocko wrote:
> > > On Fri 26-07-24 06:43:57, Al Viro wrote:
> > > > We are *not* guaranteed that anything past the terminating NUL
> > > > is mapped (let alone initialized with anything sane).
> > > >     
> > > 
> > > Fixes: 0dea116876ee ("cgroup: implement eventfd-based generic API for notifications")
> > > 
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Btw. this should be
> > Cc: stable
> 
> Point, except that for -stable it needs to be applied to mm/memcontrol.c
> instead...

Correct. And if anybody wants to backport to pre 3.14 then to
kernel/cgroup.c

-- 
Michal Hocko
SUSE Labs

