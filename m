Return-Path: <linux-kernel+bounces-236595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2653291E489
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A0F1C21585
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE416D4D0;
	Mon,  1 Jul 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DdIxjcId"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3E16CD2E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848883; cv=none; b=sS3uq1FE67TdBQrcIFMcTKhfOj1Nxey0SQOI0zbfGE8Ln9nU4S0xngmYsPyG+89t+FULAaUSCQ9D7ne3pvYzzBOzjytfL+kg+rEQ4fbTNuc9BTiq0AkLNVTDuPWS1G69+ZC8kXyIVYZ1SzQ6Nng5NRQVWNK9yek6YBGNvK567RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848883; c=relaxed/simple;
	bh=bgZsYiiLzPqk9D5/qPj2Dk0l0ygcCkt+0t57HkzLs/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaLWG6gW9IuHlFlB6T+P49tz7qal28EGNmVaYjh4w4KOXbPeonJ9DAgB0tDwohPOGBYa5tYLlz1S2sZXJARuFo5KZAxBg+DMJHz8kyvvkB8iQOUDdz+hJl7janfwBBWo9bMtw7AENWY0zAa02gkC4TqfdRdwjY6sbEAjzDRjZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DdIxjcId; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec1620a956so36391411fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719848879; x=1720453679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/S6/sRocxwesAowLy485WuVHMdVxBuCShYp33Jt2FA=;
        b=DdIxjcIdguCjcdU2fbqh3gUB3UKjCXZckXN9cm1tfFv2N7ryDj+RLru60ZWrs6KpnP
         IpnLianQ13lDhQ18QarHxp1+0rHg8wqvywYxRXmEUjwg+gnKVBpGtJhQg/C3JCgjOIpc
         Od+pb6p0KBSPFpIJpkQy8kM9MjHaGB/JOwUT1E14br05rhgSliPplXA39tHfRXw4pAuq
         pdcfRShRsx7oA8v0+8zMWQ+wXXZ3Mzar7VVjgx4Y4fdVNA1T4gBdg+YoGudzKBQ9inpN
         QpwSZVlvofvi4zXKo9IX/xxLdhGB8VJQFyZPjFVijBHkZ7c91n/VmSJ5OWDftAJroyHk
         Mjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848879; x=1720453679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/S6/sRocxwesAowLy485WuVHMdVxBuCShYp33Jt2FA=;
        b=LplOl2L92ao4qsQjUnoLwTYsnfvtOI07LRZ64FBQMt76kUtqazlqXQxbpQ+Gz+zAgl
         zpbjToq28CSK/9dD2Xo39dMzM4jqwsynMw/Gm/y5LYYkAVToE3Et5hXZfMXq7kr5RIjY
         5cpgky88Y4mVO3cxpxqcEW0/a2dssAsiHoJx6u7xoRphIEpluM3XmIe4ZzmcV4cOF0Ms
         Rnxdadl21tiSaD4tUEduiOQej+9+0VrBkcf+ZmT1NcDhPlAnarfcBjrKJsOk6JTdriWM
         U5J8sPaZyjbfbZJdt4CwjFvEaI+FHndp31cFENufqokxz7a5mz46ipbeBK9skq+OYb4x
         YvrA==
X-Forwarded-Encrypted: i=1; AJvYcCXerWN7bKnHBJ9+p+IvsLdJvic1fW8m86GskPaLbf1cyJHdnH6+pONd3x2vBRvoXO3Yze1BlEGTeMNnxqhJQoeq92ZUnAdaQ20FRFGE
X-Gm-Message-State: AOJu0YxT893DgGTu06Hq1MYhoj/nF6oiuGlw9GB/9q2hxbbXHy+MxPSq
	YBx7tZkJlgX3nsG4i6lVVR01E5v+4vvNR5t1AlMM/tr4Zvs0UByqI4ExPqFT1Lg=
X-Google-Smtp-Source: AGHT+IHLQjQwvt9E/5s2tk8lEWfMDMzBJSpwqspSlsD26T4qHQmNl1L1z57DawnmFvA9vYX4BCLfMg==
X-Received: by 2002:a2e:a902:0:b0:2ee:5ec1:182f with SMTP id 38308e7fff4ca-2ee5ec11972mr52360601fa.6.1719848879007;
        Mon, 01 Jul 2024 08:47:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256dc9dsm6685795b3a.63.2024.07.01.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:47:58 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:47:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 14/18] proc: Add nbcon support for
 /proc/consoles
Message-ID: <ZoLPpc3SLUJjxJFw@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-15-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-15-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:49, John Ogness wrote:
> Update /proc/consoles output to show 'W' if an nbcon write
> callback is implemented (write_atomic or write_thread).
> 
> Also update /proc/consoles output to show 'N' if it is an
> nbcon console.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

