Return-Path: <linux-kernel+bounces-220992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323A90EA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC181C21800
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E013EFEC;
	Wed, 19 Jun 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ednkHCdY"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBD84D2A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798935; cv=none; b=KcGSCN3FGPfUA54yzXXyt2fORcau1o4mip5JQnNuFxf66ChUB5IJrWa14D9EUcic8sthh9NL2lBA7YXVOq3zEXifHl5zBDtAn03VmkqzTScsHQRVcm0BwFexGH/xSeNOrJTr6XXmvQf8XguW2wcpCIfWFeCjDMeR6q5vgrAIsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798935; c=relaxed/simple;
	bh=fTvB1hEbxSBWiNyMp6BrQ//M2l+mBY4sasDhPslCkf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUs5E1Rb6ZV+ueC9NIqadvvemUgSdNma6YSuF9DLSizc4yP6Fx+fYFJMyzQBVogT8qT/GTRs29GDieuh/VStZhemvMQc0NFEUxIMqL6tEqtqnOAp0GDeMOxfwt6YUe7L4mxn28FMyQZme2/Q1/Eha1qvaB+utJsBhxU5rSFRyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ednkHCdY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebdfe26242so73793921fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718798931; x=1719403731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z91cdWhBSDARxTwwrjzqK6+kNXQCrIMh1WvKGrr9e4=;
        b=ednkHCdYH2eogjaKBYnrL/+W+79v6Hjcwuz/LubW+GcFijJSXG9fiJNtANznqKgW5T
         nS1iYJ9M+r3EDKKUTpp9ZAOAKxzyQjaN8s6Lv3AIftep0am9NmDuCuhSLGEYauUv7s+4
         l1hygFEYZOE0U10+VjzNz3T3DVq1blr1TFwZ1PArDOPq1bufPy2fgoftG8b52WpyriIj
         WHTNccUfNrYsm5OTkDepBqFZzjdObsWudmdULUVirdOUQ/GdoaofL0vmsK+QYl7zcES1
         UqcnSlc2ePV4BRU7Ug+cJeB8HwJjEPTjcx+FsX4CSConWp424INyXJeEjHASLy1qwi02
         yN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798931; x=1719403731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z91cdWhBSDARxTwwrjzqK6+kNXQCrIMh1WvKGrr9e4=;
        b=cUb9SNSj9DjEn7ZlnbQcBtm6IbSH03uoLr2YfDV37kWuGyM6oWT2aD5LsMW02XHpY8
         CD99eE6gvvdjyDpJbXIgDgHmx1OL37b0do2W9Y3FOfu/edDnSYXcuLXZ8qKnNRmOX7r5
         0/fzxO3BGVZ/wAv/k0y0Bv/T02GsFQOIqABOkEsCkQRm9PS3URcU9Ea+VgH9D/9J+fLi
         AxD1ThOBl3jsxnkIs2NKL38+9gXh/MRadKfgFmmB7TZeJjx3q4zEycqPsO4yv0Lc8dgZ
         C3gJje/oGf9W5EeafG91DAJ+/HH+KomgxM4BM3OpB6nMZ2dBIsYBM49FJdiErXpM4C4j
         U1og==
X-Forwarded-Encrypted: i=1; AJvYcCUqIo6cD49yGYSK9k07yZGmbKPV0QSMPm8LiPeD5xHPr0UHwdubkpuhvlAT1q00UYHRVG4UcjXe316PfBfd+k3llfrafW8QXGNDgpDl
X-Gm-Message-State: AOJu0Ywycbpyp+BlnMkQVa2dTJDNEuDOHaVQQwKgK1GkIJrSDcXBkrOG
	+3a2kUeOe/8wIIDIO1YOy9Fk4KeTXU64eHJ2gRK5YJLaoHBnygBhetJS3X/Dz/k=
X-Google-Smtp-Source: AGHT+IHxReTN0w2QaraX/PX9vfS48WsKjPuPHQ7NZwaQgMrkK4rxI3TUUAV/ivACQRkZaw1lT7yL1A==
X-Received: by 2002:a2e:a311:0:b0:2ec:27e6:39ba with SMTP id 38308e7fff4ca-2ec3cffce6emr16794281fa.53.1718798930960;
        Wed, 19 Jun 2024 05:08:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf49d7b1sm9480897a12.51.2024.06.19.05.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:08:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:08:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Rename preferred console handling
 for match and update
Message-ID: <ZnLKSEzKBTXYvOMe@pathway.suse.cz>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-4-tony.lindgren@linux.intel.com>
 <ZnGQ8JAu2OQf0GX8@pathway.suse.cz>
 <ZnJg6KQeIs95UFAB@tlindgre-MOBL1>
 <ZnKGGoboxRMwkeWm@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKGGoboxRMwkeWm@tlindgre-MOBL1>

On Wed 2024-06-19 10:17:46, Tony Lindgren wrote:
> On Wed, Jun 19, 2024 at 07:39:04AM +0300, Tony Lindgren wrote:
> > On Tue, Jun 18, 2024 at 03:51:44PM +0200, Petr Mladek wrote:
> > > It seems to try whether c->devname matches a number "X", or "ttySX".
> > > It even tries the sparc-specific transformations in
> > > serial_base_add_sparc_console()
> > > 
> > > But this is the original format which does _not_ include ":".
> > > It never will be stored in c->devname and will never match.
> > 
> > Good catch, this won't do anything now with console_setup()
> > checking for ":" for deferred consoles. So we should revert commit
> > a0f32e2dd998 ("serial: core: Handle serial console options").
> 
> Heh actually we can revert a lot more, basically leaving only
> the renamed serial_base_match_and_update_preferred_console().

I wonder if it would be cleaner to revert all patches adding
the feature and then add back just the minimalist solution.

Best Regards,
Petr

