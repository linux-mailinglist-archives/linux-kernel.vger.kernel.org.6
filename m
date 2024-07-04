Return-Path: <linux-kernel+bounces-240987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758292755F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07611B21383
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F21AB524;
	Thu,  4 Jul 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XHunqudP"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D11AC44B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093457; cv=none; b=fkgfn9HAdxuSLWmHBJrzrbeGVq2mGqIZgjZFxSt2apXG+IcJTFxpSAcFzjkrmwypodvLc2ZetcJAVmoby0sgnsaRclJmhBXKoq8+K6DBSK4WsxTzWzSRS+6z6bVLJ8di/qN51qM2dTzVTOikAHFNGK3m+p676RONddWdk5kLj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093457; c=relaxed/simple;
	bh=DsedHeJsS/amdZVpKFJyVeLkOMNQa+PMTWNkWl1ltVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbc3uMW3TDTaBcNbfdU0zdaoPNIFsPz5N7BhnszO0/+yW/tVS4Z5Ad/s3MeFFOkGJQLHwiBl05k7f6kHelg5bKkbYizrGvtu98LBoED5ZEJpc5rAGiZHmm/G17HYyrw2Bcwdv121d4tx/TmUPBlpt149gLQfT7JE2pZZSIeabzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XHunqudP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3679e9bfb08so301961f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720093453; x=1720698253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lD0PPZ24LDJ5fGIwXYEdiOvdE6uwqRXg1JRtKinTRe4=;
        b=XHunqudP/7g/rGD0xQyyRcYkJVzISGl6QC6/yqNZj6Mes7HDBRk4iRArO52D96CCB4
         uI4N8yKbrSMjcfv4C6pRJzhYyjRcRRNCAiFFfDQJAptIbroKCQMcGNzVWg/5Lbtn0QgE
         w5cU7XLemDMWgfldtunLL9cTuUaL9+qxmkBwL+XZDNeRHO2E+cXpqWrOvJ/kItgMw2U+
         Pb/OpK66PRy29h62V14IuFMbC3egj7lfZ6ZzijBBpjcvG0mta3Bw6xBTBt1fJpFSEG4Y
         F1fnJM7ThJFkCvCRJ5R/utaFT8ySspbpF+dhi6NcWS6HAS7sDZwQTYp/h0DWJdUers/S
         q7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720093453; x=1720698253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD0PPZ24LDJ5fGIwXYEdiOvdE6uwqRXg1JRtKinTRe4=;
        b=vMcO03VSCkhAUT2iqj3BjvsqLiHfGM/fOef2aG+vh9aFE+kmRDdPCl6qKWJpnC0Mr9
         yxxzkwpno2RUHzMFZYxuZgcjXqxEMDQA9rOkhIpP2yIRgX1XTQNzTTX5PcknagArYSU5
         ZEONopa1E9elovK2lSQKXhPjtRoK3MD5him3t9v7kRNMbCAXS5zuiQe0JrIwz8SBNIa3
         3wgCzyk4D0nQ3ChqAn970CPCG0eDRh0R876Xp952WExtwfudYoAL+pm+5uiDWBr2zljT
         iY08sMz68iuPCB6PN/cQHx98zvsHVXBGN/CN023WQ47Np2nE0GpdkhwRbBJEJuQ7TCSV
         YZfw==
X-Forwarded-Encrypted: i=1; AJvYcCVzsrM2h6ewUG8EQr5U9bfBxccD/vdUB6KVh0pnPg8mjp531wSHiVf1cfxUeLxv31EaUH0NMPVlLjh4wnOM/jYrZbD6SIi6eurvMv6t
X-Gm-Message-State: AOJu0YwvqmN4D5EmumNd7nN+udHmhprCQcNsMDy/F2u+muRLTSMIftTT
	sndhcyvI3m0T4zvFIn0EvSEZiTBscKOojNEbTSr4cElc1WT02pmKOl2eWMAfndo=
X-Google-Smtp-Source: AGHT+IGNLj31HSnKP8eMBVVDQWkUG1T6Sz0uQgf58SIcESsrCGl4BgnlWeQWQYBK7LzNx7BMg/xfeA==
X-Received: by 2002:a5d:58f7:0:b0:366:df35:b64f with SMTP id ffacd0b85a97d-3679f6c4ee3mr1144700f8f.4.1720093453629;
        Thu, 04 Jul 2024 04:44:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb33901426sm12164205ad.91.2024.07.04.04.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:44:13 -0700 (PDT)
Date: Thu, 4 Jul 2024 13:44:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Dhruva Gole <d-gole@ti.com>,
	Sebastian Reichel <sre@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] printk: Add
 match_devname_and_update_preferred_console()
Message-ID: <ZoaLA5IVTnh0E0QI@pathway.suse.cz>
References: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
 <20240703100615.118762-2-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703100615.118762-2-tony.lindgren@linux.intel.com>

On Wed 2024-07-03 13:06:08, Tony Lindgren wrote:
> Let's add match_devname_and_update_preferred_console() for driver
> subsystems to call during init when the console is ready, and it's
> character device name is known. For now, we use it only for the serial
> layer to allow console=DEVNAME:0.0 style hardware based addressing for
> consoles.
> 
> The earlier attempt on doing this caused a regression with the kernel
> command line console order as it added calling __add_preferred_console()
> again later on during init. A better approach was suggested by Petr where
> we add the deferred console to the console_cmdline[] and update it later
> on when the console is ready.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

