Return-Path: <linux-kernel+bounces-252665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F50B931691
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B60F1C208BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56D18EA72;
	Mon, 15 Jul 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="qYjlqT6m"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C21E89C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053324; cv=none; b=MoE0+aqBI5Vpjf9k7LjI/+MgWRKvhTxTxRsL2NYdES9c1OEyb/fHIPXSdFiax0k0VD2boh4tn55H+7V6AKme1XAXDoNX5ylvJFfEP1sPf4rQmClUdRxb0clEkBCueUeiAgYOUVqmsulwC98n2l1iTWIw861qPrE79koq+f1rYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053324; c=relaxed/simple;
	bh=bH7oj4B2Zpz+lQHSYo37+KXB7q7AxK2kIhIqGARTFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/+n686fE2wy9w1zgyNZAf11a1GaesKCZ6ZGe9UmlJNbSSR0wdi//PFSblZwF5oC9bMGIDKhBIhii8rbkroAobPOFlpX8iszGA+Ig4MlN+ymb04O9ZRnZWxqfovl1FJPsdfcUq13u/jq0t4TrJNyHfkBu5asAWlhUZCLzTqoBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=qYjlqT6m; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a05b7c8e38so272339985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721053322; x=1721658122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOYxpElHtlrMz0PGrnNSIzCmyVdWznqg4w7SKp+uRk8=;
        b=qYjlqT6m+AQiWiymNRIbv1m5fezC0VTRfvNh1VKXN1+HZ3JEGtuSegU/g9PDjCPwuX
         dPbGxvafLgtal4dImD4uNjrJbfCMmElvGIjRY5TYEUKalZ5kj7DS7bL2mNF4oEalrpJZ
         SsFv3ClBJ4Zspn6D6siblE/q7Y6OBlMAtuAr2eShMOfwqDd9pe7qLo9XGYYmxcdrvMlh
         doHD5eVpZhYIZYIGNmYTmUPprW7JCp+/X1ZRyfEPN7hLvETvTmjy6B3nQb+6GQehwJLa
         XQrPenZIyII3/+2vdmDbTdUhZgecySteOPKuWsiS/pHNlzMA+o1uPufVxQn4iOsL0sVA
         Pftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053322; x=1721658122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOYxpElHtlrMz0PGrnNSIzCmyVdWznqg4w7SKp+uRk8=;
        b=Of3dmgBeb7XMAPKJjTqvf9AGokSGXw8RAib2WWdE18HykgvoHfIAgZBg0HYf7pKDHg
         YHanv3FZVJTu6iSvEXKcx5uqW8n+RM7f93s/PynfPEqWJNJjTp41ovSTzK1S8ugA9kNe
         jeIA1Bq+48YTu+X2ExxflWePXNfGyTinwe01GgrgOh8OoUJ86T4niObU0BAWZNtiPTNu
         bsllEadDPr0GyaP+s2H7kjD0VOs/dCZRwk0VXk1rV/oyh3a1lqG/g7QBkzw+y7jZQpEA
         ZWr4G7K8NtUcD1uF/XFNumDz4IMtRyImN45BaDBZdLmBKRQ/fGPG1rSoONebhrQ2yfFT
         iaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpMB8fkJ8QB5livMBz/49Tt2i2MWrc/0qyXDWrmclJGaXhP6ltMdBeADHdeGw2k88k5YM8Gfzg6cKmt7qd8IYXWW0cdpVi2Wcjmer4
X-Gm-Message-State: AOJu0YwUHQxgb7GWmaGAn+LnF78WtQQZPAsqKOtYo0wbzC6X+HY4gfgL
	zvLlA92dID7omP3lasUB4EOZ7XI3DVxrS4s8ZeANItIDYiHW6U6p679wO7DVqA==
X-Google-Smtp-Source: AGHT+IHvPuU1gQvilK4FmlZJIESIiWMSsLPbWZcGM/bvE/uUlsbqCoJwUAunDBkhbF87iSwEEqN4KA==
X-Received: by 2002:a05:620a:12d3:b0:79f:1915:5b3a with SMTP id af79cd13be357-79f19a7fb44mr1918954785a.38.1721053322220;
        Mon, 15 Jul 2024 07:22:02 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c6f5efsm203389885a.107.2024.07.15.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:22:01 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:22:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>, gregkh@linuxfoundation.org,
	brauner@kernel.org, jlayton@kernel.org, jack@suse.cz,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Message-ID: <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>

On Mon, Jul 15, 2024 at 10:53:14AM +0200, Oliver Neukum wrote:
> 
> 
> On 11.07.24 16:41, Alan Stern wrote:
> > On Thu, Jul 11, 2024 at 10:59:56AM +0200, Oliver Neukum wrote:
> 
> > > I am sorry, but this implementation has some fundamental issues.
> > 
> > Agreed, but the solution is pretty simple.  Because the device was
> > suspended, the userspace driver must have enabled suspend via the
> > USBDEVFS_ALLOW_SUSPEND ioctl.
> 
> The whole system could have been suspended, in particularly to S4.

You are right.  I was thinking of runtime suspend, not system suspend.
My mistake.

Alan Stern

