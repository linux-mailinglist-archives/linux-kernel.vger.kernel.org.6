Return-Path: <linux-kernel+bounces-523017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E33A3D103
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92690170515
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55811E04BD;
	Thu, 20 Feb 2025 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afqgx2YO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1F19AD8D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030616; cv=none; b=h0BMfHqNLuUDvu+6jgID/BlPRoAYECW16H36Jjx7nuknJusg7xHWVzJo/9KrY0uP5fq3XQdJ4mQPzYmr21B0x1HzuuLcZ8IzeQnu+xE3Zdt4bKFxbbVZyWr/SSSrfVc+4VE0bBEA1Urs+3HQaz1wYD9ZxeZOQ05kypIY9E8CwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030616; c=relaxed/simple;
	bh=bSs6EObO01GFd1/soPW4V2bEKCnO+2d7+Dd0Cr0R9AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq9og5/q/X7cl+dghe6nYnO8PLZfm+DG/GFE3JsgJKVnn37+MtJ++5Ft/1LGr0jdK4ZiVVqfEm2GrifEFLsOuRhQBo5C77sArDfzp1Sg96oAJPA9OpTF+cAMCJOSNr6OX1cnN11qTEIFbMgTSw4N5SDYQyrnJJ2VO6fHkBkN6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afqgx2YO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb81285d33so117076166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740030612; x=1740635412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4UdQnDrC//12flSexyKbPIUDcd8LQ6iO5eT8IHA0tm4=;
        b=afqgx2YOIhdLYvVop4dDYxxTdJLf6zJA2caKQKm7Bs/lEtMKVdQ1v/XphNA+z3aCIk
         7Czlg70jbrce16vCazxEmpUCSnqogzMbgfRkNz6fCmYzG5CxXOf4cFassO0/JSR1fSAI
         z7wFOlkAiRlWNljNbuS5/SIv4LY2qX6EVVuQFtXHwaJIGeJZK8wH6R4S4auYrDJvynmU
         YtaGn1j/KH0rmtYWZZd16WuWqxdqJ88JdobaJt6yb4NWFQrYtCUqApueRPgi97WphQvj
         eoPNkliYX+k3T3cssQ7WGWhBL47vC4vM4FSLLWK8GJ91yWwweM8G9j54R8ypAtoHjyNM
         9O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740030612; x=1740635412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UdQnDrC//12flSexyKbPIUDcd8LQ6iO5eT8IHA0tm4=;
        b=DzPPMbA8nUK8Cyxw+RbvV39bDUYYRiPPIrW0v4hnaCbTXgKJtZNOe/1eaV+C4sIm4I
         T3dJhw3Y98Yp2E8bjTsb/4UD4XwNljveKo+4D1Hs+I9pg3d2joTGxFJKT7uBJeyoQWaU
         CWJsKSA15ui9NPllYrNXG4ZsxkobJpCU8oAYxL+w3viTRX1/3tvNgc+bSyTgZ9Imdgqj
         ExSIPSbRYOc9/rpE28jsZIqYcGtGwRlxW44gFQCnwsI/ICzV245PJPZdzUrcHISsDY4u
         F8Nr4lDqB0k3mPUoZ9wudPEDt3RsBdrhjmGhz4yLY7R1dlidHHbsgq1ZFkgBFXu8six7
         68OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+p7aSPC5eSGbNTqNjCmUYHOGxu/lfzkvlSwUISXRX9X0Uc/dBtx8+KxYokB/eafPnOktNuRh0isIEZyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTINAuZulfJkIMsTDoHCWdX93aVP7XxgtwPfjhpxoq8JqSOjp
	049gjdJ7GF6YRn5WdHTOEe+1xltxiav2zo9W0OsL+noEOF+mGPor25VI6lsOCT4=
X-Gm-Gg: ASbGncsOqkNmcBYKs+kv8yhtBWHr6KkDXqt8MtVuYWuOAg+1XegDTm+Ky6nE+F8kyKT
	eKWI83JvedsHsYNEDtj+XAsQGgyogfmqGvE3um5elCSANw74sb8mhsda/xJqumZSn7iypKoRJ/n
	LvxvQ0RR+iihYEmmHbvsZdKqlUxBR0LvEmRBtsAWAqI+r+kk8Qb1vwGJnYW6qgn8TPad6O3bA91
	SaJeD3guL6qF8+tlhlEqOYC0sdazHWBKkFMxTkC7WuvJMZUDhJuAtiK08uwrW0aUnbndoPjurKy
	tnocLeYkJRl7F8p2RURc
X-Google-Smtp-Source: AGHT+IErRbIkqhaq1U1Cvw6m/fzTGdjG/w1CKIiyvbxXGaxWJrO6d40PJ1AJLGV8a9Co67aHSnHXNw==
X-Received: by 2002:a17:906:314d:b0:ab7:d179:24a2 with SMTP id a640c23a62f3a-abbf380427cmr92734366b.1.1740030612432;
        Wed, 19 Feb 2025 21:50:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb989d89edsm735442866b.81.2025.02.19.21.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:50:11 -0800 (PST)
Date: Thu, 20 Feb 2025 08:50:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
Cc: "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
	"lkp@intel.com" <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
	"Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
	"Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
	"Arun Easi (aeasi)" <aeasi@cisco.com>
Subject: Re: drivers/scsi/fnic/fdls_disc.c:263
 fdls_schedule_oxid_free_retry_work() warn: inconsistent indenting
Message-ID: <5886f4ff-d6be-4804-8c76-c431946128a5@stanley.mountain>
References: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
 <fd4d8516-5eaa-43b0-9100-2984312930f8@stanley.mountain>
 <SJ0PR11MB58962A4F0B9CFFB9439FF959C3F92@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <SJ0PR11MB5896888C81BFF2EB81E2B533C3C42@SJ0PR11MB5896.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5896888C81BFF2EB81E2B533C3C42@SJ0PR11MB5896.namprd11.prod.outlook.com>

On Thu, Feb 20, 2025 at 03:10:26AM +0000, Karan Tilak Kumar (kartilak) wrote:
> On Saturday, February 15, 2025 1:03 PM, Karan Tilak Kumar (kartilak) wrote:
> >
> > On Friday, February 14, 2025 7:03 AM, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 05:42:25PM +0300, Dan Carpenter wrote:
> > > >
> > > > I guess we can't call schedule_delayed_work() without holding the
> > > > spin_lock?  It's a strange thing.
> > >
> > > Actually, I see now that we're just dropping the lock to avoid a sleeping
> > > in atomic warning with the GFP_ATOMIC allocation...  I bet you could make
> > > the code under the lock much smaller.  Just the test_and_clear_bit() stuff
> > > basically.
> > >
> > > regards,
> > > dan carpenter
> 
> The window can be further reduced by adding the lock/unlock around the list_add_tail. But this looks good too.
> 

Could you send the patch for this.  I don't know the code that well and
can't test it.

regards,
dan carpenter


