Return-Path: <linux-kernel+bounces-351314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED9990F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A311C21188
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9AA1AE01D;
	Fri,  4 Oct 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2WDZQJp"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68651AE010;
	Fri,  4 Oct 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069286; cv=none; b=h2qlzARjimwX3DlQVjvnQWfpcGyFs/2IzZkgLi9At8D1n7pICVX4GE0PjnVTknsxSljmUy1Q5oaLcRw/S1iMeL0GqbUTdo4tJsizrBt9EE5WXkNcP9Ce9HuSCB+Z3vVHTA6J/i4IKHmlSog7eLRAlcj8Co9wOVjDe0mkXZ3VGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069286; c=relaxed/simple;
	bh=Vm5cwzVRBb2+9hU6XAIcq43yYLjs8dd8c1WLVKtaLP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJx9oI7zVvfKz2pJUAzzkIxGN74DWCbF6Aex0o0qicuiD+hSTazfM2bj67nNYZsOr3Eu6+8DAMF6LxL5Ujx9P2OlncSJ3LYN0NGb/WzBrd8svwfqjgWGyR1eLYIZ/jPVlIJNk0LH9PsAwzQQfmj5ciPEZBqDm5e6Wk+UHvop8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2WDZQJp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso23760185e9.2;
        Fri, 04 Oct 2024 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728069283; x=1728674083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8CycWNZFawBP96zK96WEn+kWaW4vTJKQJHVIc0au9Ow=;
        b=S2WDZQJpY+B5HhYqkKNrcwTd8uqWJKPVI41nZyWsCNzOfYxLcnsCdiK+VEyU/M5LS/
         fieCyL+LvW4aafa/SMG8IwWnqbmGMt+eQ0JkVJ6nCLzpf2RuXB90mM45qXoIVYlhV9M1
         ItSRqm85eb7hqsX/BXS910lHAD/N5f3uJrG7UBqe+5v/PNpv/gUu8eu0NLUFLgdDWBTc
         0GDea8i3q1bRpLd0LjWISLEW2fiWNgZ0OZqjqTbyZAinsX92TH//dug4+elxzpIthBQM
         pdCMyQ+nJ5TIBjqU5iUnW6klGrhQjl7TGUd+DBMxzpU0IJ+DMMTqBPHUxiBHTH7xgenp
         tU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069283; x=1728674083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CycWNZFawBP96zK96WEn+kWaW4vTJKQJHVIc0au9Ow=;
        b=be3tAXwUMcbCJgczNiId/OExjf6KH1mVvJaFvF8Xe2my6xcrY80FJpRjMcpOL43WO5
         iQmPbQuQ/hQEjTbNNxTLJp6tXI2Rrf2iaKTv63/u1R8+1jwFy56anvDtQmp9Jxu/DsdM
         asXwdQQph+7v7CFT0DwcNNfEEB2FNIftln8n8eL1blIuJSLe9GU1eoj5evRi6b0LUj5E
         BlYmuEIEFNTfV5JJExACdor5AHYK3wMKLALNuknmSTtydLibPYRCbgtEy2Ka+AbTbdLR
         WvzZeKSx8xOTf0Say4ygr+lbUGyzhhPUyl6vo2hu9Rl2ASaT3w6bhqiJCfwFhUmALyQ4
         El1w==
X-Forwarded-Encrypted: i=1; AJvYcCVV/JHj6b9MHyEqoAAxVL4UuZFtmYRZQagM/Im3evcghrDKZyrjBocnNuy60tHcRJgHG12H3QR9DDVw@vger.kernel.org, AJvYcCXlNYac2a0YtgAFHPQtbLBYhJr0NS9hGkCJQ/kpjRndlrJQoVVUUHTWAw8W1mD5nI+KX+sAFb1Zwx9E2bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFr3D+WoINOBZy3AeVcapr2O+LhAnQyYhw6WyyiaUW1UiNXnEA
	KeDwDmtkwZkYobBLPPzLkCx6mDwZRoQm8EDQLEBGG3nRzmUttnZ3
X-Google-Smtp-Source: AGHT+IGCBOY3jHzzlTONE1G+8e4KYsJ+Y2gkCxsC/PCJoAHiPiLj0M+8frbC93RAc9jZzeID3U5I7Q==
X-Received: by 2002:a05:600c:474a:b0:42f:6d3d:399f with SMTP id 5b1f17b1804b1-42f85ac193fmr29861845e9.21.1728069282796;
        Fri, 04 Oct 2024 12:14:42 -0700 (PDT)
Received: from freebase (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89eac29dsm4271285e9.26.2024.10.04.12.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:14:41 -0700 (PDT)
Date: Fri, 4 Oct 2024 21:14:39 +0200
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [PATCH] usb: xhci: xhci_setup_port_arrays: early -ENODEV if
 maxports is 0.
Message-ID: <ZwA-n56XlNkkLNXM@freebase>
References: <20240930052336.80589-1-olivierdautricourt@gmail.com>
 <20241004125716.75c857ae@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004125716.75c857ae@foxbook>

Hello,

On Fri, Oct 04, 2024 at 12:57:16PM +0200, Michał Pecio wrote:
> Hi,
> 
> > If the controller reports HCSPARAMS1.maxports==0 then we can skip the
> > whole function: it would fail later after doing a bunch of unnecessary
> > stuff. It can occur on a buggy hardware (the value is driven by external
> > signals).
> 
> This function runs once during HC initialization, so what's the benefit
> of bypassing it? Does it take unusually long time? Does it panic?
> 
> It seems to alreday be written to handle such abnormal cases gracefully.

That is correct, the case is handled without panic, but the 0 value gets
silently propagated until it eventually fails on line 2220:
	if (xhci->usb2_rhub.num_ports == 0 && xhci->usb3_rhub.num_ports == 0) {
		xhci_warn(xhci, "No ports on the roothubs?\n");
		return -ENODEV;
	}
The benefits are only:
  - Reporting a more precise issue
  - Avoids iterating through the capability structures of the controller
  - failsafe if future changes

This is totally a nitpick as the case is unusual, if you think it is not
worth taking it upstream i'll understand.


Kr,
Olivier

