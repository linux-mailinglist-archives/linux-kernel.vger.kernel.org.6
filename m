Return-Path: <linux-kernel+bounces-274680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A5D947B68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C84F1F2375F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169F15B15D;
	Mon,  5 Aug 2024 12:55:36 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AB15AD9E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862535; cv=none; b=Q6NpBVq2N7+OQQUU28S6zgMKLXD8bLvQXN2LAgnpNvOWoN8Dl76qUK4UNpAqOHMAmCMRbAjfRUg7p1VTJW5A4ikQvvwsW7TCRpgrA/VRCPMrRJJG7be6uQXlBcm9TIYM/dzt48HB6jq/HW+MXGHdp5Vf2dJyItnTnlpv2xRRcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862535; c=relaxed/simple;
	bh=H+eSgXnog3xvmBQGRjH46qJOXkssRfrUAJis+epDckw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5XAwKBH8EMBTa0FitYF4Z/Jg6Y+fIzcu1hxSebqBqM7z79oKaS6hrDLCqcrz+bASXN7ylSs55hiSExvG3INSoQpUDSBU+EnJZzlMF7XK80ExJMAhGL9D5JLUArEVhOpMYEFsnKBCyOLolXDIwCzUjXoNqC3Hc9vf2Z9Pz/HkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so12308715a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862533; x=1723467333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4Ff7wavW1oYJltFtashtF0E/OaArX05PUiDF3PqoSg=;
        b=od9qzmeiOuSlFCFZHWKYuW5nwASeZuMyGmUvFr1s46NwkW3ORjL6DlRJFKSVB35BrK
         PXY8Fxie2YbJ6v8ZiW7NoUyQXchB5W76IbjFEsJacgOaL0SZzFcJQG3efv2bOXOjukOf
         6sVGvVhxgjsDoXfi6R2aUchs08SQ6cr02InNSI+4kKVb4IxvjwQIy5YIQVvTN6KhyuDx
         39ZkMuWOW40pxc1JopSzxumqRN25b0zwRUC38nG+IKmaCUR/jtg0vU4v2YQ7S3mfLD/W
         XeheKEDz0XTZGQBNBoePY+OtNRNRN9g4KoURbRiujU35QLE9gTEJSHid2X3seDU+VJ7s
         hPrg==
X-Gm-Message-State: AOJu0Yw4FuaN1ASS1qD+XXlLjyea8N/en+p6UoA1bypuJ4IbIEqaW0TI
	eVHTcjtUFRnTUsxSxKw4Lcd8YZJelhfzrpZ9J5g+IWOrD+dhLA9zUL+48w==
X-Google-Smtp-Source: AGHT+IEvRr9K0cqHfUeU6PXIx8WlSvp9yIOz3LuCVonwZy1RBsioqMKqR+bPD9flRyVNaVKQedJtig==
X-Received: by 2002:a05:6402:457:b0:5a1:461a:d4c6 with SMTP id 4fb4d7f45d1cf-5b7f340c1demr9063077a12.5.1722862532323;
        Mon, 05 Aug 2024 05:55:32 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b933f1asm4922726a12.67.2024.08.05.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:55:32 -0700 (PDT)
Date: Mon, 5 Aug 2024 05:55:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 02/15] x86/ioapic: Mark mp_alloc_timer_irq() __init
Message-ID: <ZrDLws63ddndWsEC@gmail.com>
References: <20240802155038.556977544@linutronix.de>
 <20240802155440.339321108@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802155440.339321108@linutronix.de>

On Fri, Aug 02, 2024 at 06:15:36PM +0200, Thomas Gleixner wrote:
> Only invoked from check_timer() which is __init too. Cleanup the variable
> declaration while at it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Breno Leitao <leitao@debian.org>

