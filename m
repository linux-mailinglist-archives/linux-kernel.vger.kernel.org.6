Return-Path: <linux-kernel+bounces-302367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9995FD52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AA61C21BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8405819DFA7;
	Mon, 26 Aug 2024 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iM2HYcUg"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DF19DF9D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712287; cv=none; b=sxqJNcppuUN8xhla+wruPskjz7kxrqZUtx+QYxB3IZi2LddWlIB518Hmul+iQm3ZbQ3UXWD6YCUsU0msvO+2xQCmSah3PMbCbZxAkIQ+rG0phTpA3Nk5s1KaY3XlfDRjrdMHR6HTGq1xQbDfCY70Hwd3+6Ch2DIFroIk87JYOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712287; c=relaxed/simple;
	bh=uwJweqgeCTTED5K/6X7SaDWohDy3XHJSFRBuGly0Daw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeP6b2CkEwFvwac+0c7wPd+nWMYu6/U2efOZGrTgz7GYhCLlRBmtkDL8xiGqU+kvXlnGSp4AOr4pSAZpAx3CZRLUaJKONVYIU+M6uzkOg//HvO9wV3dDiNyjPL2JsGW4MQLkznBxYnzTrkjq91xmC3aDBUIY4V8AxSFkAS488EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iM2HYcUg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-713edc53429so3585804b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724712286; x=1725317086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rP9S1KmGMHqf/jZ1mWqxHKUD0C7Gqq6pUqM5TETs1DQ=;
        b=iM2HYcUgKVZ2dPmUYcbkgQjDB9VBuoBP6z7n3RFzJvUrM2OtyuJY5TkA+v1yLUfbD6
         QFidE5y1b8NYG1qwZ3GP8Si3soMx/V3jCFKJFug93UJU5NYt17w9/dToB5U4IHpIvSfS
         eypoGKato5KJrHY//70Q847HUKz+MQt+zRnwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712286; x=1725317086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP9S1KmGMHqf/jZ1mWqxHKUD0C7Gqq6pUqM5TETs1DQ=;
        b=Kf0hFgaFkeiyJn68pQaWTDdniU4Wp+lrYd/sj8mbAl/xtaGuwQ03dyxuebY3E3KPr/
         taQ4QliFWkM4/Dq9fEjzUiuQgUNMtFdYPpqRocpD7V/MU7pjAHW3bp3uQ7Lh9iCJCt0r
         Hf8WypHWrm3vYL2jEyHPZzGtbcBPih+52W2AkaqcdZaKVjMY9m0TJTJnhQ02JqUDUEU4
         sf51y7X5JerOFVEIdFIUxRK9YsEEMFN5MisrbaGFEItTF+B9tulYMyj+OKaWHmj/R7f8
         2NVTjbZdtN6qY81kdeUZlLpBlYfxQEm9wxoyQkCCvWw18mvOREX73egL7qs23xf2yrt+
         vwyw==
X-Forwarded-Encrypted: i=1; AJvYcCVbcLg8ia4cm/4vKXN/ojhQXZ3EOTjUsZ1/AwmYkyRzybEYFsjvo6Uk0XYxiAorEGJkLTquVLT6zUeOIeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJm2LuM088LIH2aEbdql0VfZPidZbA+Qfb8g+E1XDMNxnz1O2E
	eumH2lzHX22k7c9M4soWQP9j/DDAJLpey6p3zkmq0p46i9Oq1Lb3wesdgpJECUo30sO/lHORfbM
	=
X-Google-Smtp-Source: AGHT+IFr990qWYgRpotf4EezEdiBDxHfz9bNsR9fu2eXVa7psPrw8ra7VHNA4eNyQDyn3HEPJCRE0A==
X-Received: by 2002:a05:6a00:1703:b0:714:2198:26b9 with SMTP id d2e1a72fcca58-715bfffce43mr1404443b3a.13.1724712285659;
        Mon, 26 Aug 2024 15:44:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:7e40:430b:848a:1da6])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71434af17ebsm7443413b3a.3.2024.08.26.15.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 15:44:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:44:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/31] wifi: mwifiex: drop HostCmd_CMD_802_11_MAC_ADDRESS
 response handling
Message-ID: <Zs0FW-LPW0ShGXV5@google.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>
 <Zsd-ZxscUBmf0xsu@google.com>
 <ZsxFt19nQs4D7Q7t@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsxFt19nQs4D7Q7t@pengutronix.de>

Hi Sascha,

On Mon, Aug 26, 2024 at 11:07:03AM +0200, Sascha Hauer wrote:
> On Thu, Aug 22, 2024 at 11:07:35AM -0700, Brian Norris wrote:
> > Hi Sascha,
> > 
> > On Tue, Aug 20, 2024 at 01:55:28PM +0200, Sascha Hauer wrote:
> > > The command response handler copies the new MAC address over to
> > > priv->curr_addr. The same is done in the code issuing the call
> > > already, so drop the unnecessary HostCmd_CMD_802_11_MAC_ADDRESS
> > > handling.
> > 
> > It took a bit to figure out what you meant here -- I guess you're
> > referring to mwifiex_set_mac_address()? It could help to document what
> > you mean.
> 
> Ok, I can clarify this a bit when sending this next time.
> 
> Right now what we have is:
> 
> 1) mwifiex_set_mac_address() sets priv->curr_addr to the desired new MAC
>    address
> 2) mwifiex_cmd_802_11_mac_address() (called from mwifiex_send_cmd())
>    constructs the HostCmd_CMD_802_11_MAC_ADDRESS command, using the MAC
>    address in priv->curr_addr
> 3) mwifiex_ret_802_11_mac_address(), called from the response handler,
>    sets priv->curr_addr to the MAC address received with the command
>    response, which of course is the same as we initially copied there
>    in step 1), which makes 3) redundant and unnecessary

Ack, that's the understanding I got, but it took a bit of reading to get
there.

> > I'm also a bit torn; this command API ostensibly has a (unused so far,
> > for this command) HostCmd_ACT_GEN_GET mode, in which case this *is*
> > important.
> > 
> > If anything, I might consider dropping some of the handling in
> > mwifiex_set_mac_address(), because it seems to presume (and then has to
> > undo for failure) behavior of the underlying command.
> 
> What we could do instead of dropping 3) is:
> 
> 1) pass the new MAC address in the data_buf argument to
>    mwifiex_send_cmd()
> 2) instead of priv->curr_addr use data_buf in
>    mwifiex_cmd_802_11_mac_address()
> 
> With this the response handler would still set priv->curr_addr in case
> the command went through successfully. No need to undo priv->curr_addr
> to the previous MAC address in case the command failed.
> 
> Sounds good to me. Is that where you aiming at?

Yes, that seems about right.

Brian

