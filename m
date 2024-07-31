Return-Path: <linux-kernel+bounces-269410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C994328B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AD7283504
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6121BBBEA;
	Wed, 31 Jul 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WK16iXdq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCB186E4F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437953; cv=none; b=uyCFEFfM63+RjoOowULMC3hZxt1M2lTehnVd/cWGMpRwsTEginUjHfyhjZwswP+COewoUvDuEQi2kHBLD96AJ4o+T2P10SzAtIhwUpVOf4WOIRF39L0YnanIBKpQaLeSAqA3Da17dD8OztnFycNdGw8jPYQTZoU/uUtbWvLcQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437953; c=relaxed/simple;
	bh=mv6la1zzKuIOdZkN18IqBhuFvq9G6xkdwAPiC81eQzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbbgJ4c6N7J63/h1T7+3UYPJPku+UlQrOxNJALn64Otxl+txvKDm/YxK2YZ+tuztu5r0fwIHiIcqoWfI80oT9jRyaoo8iaiye6oy8WS9QfT06rqKYSToGROoPHGXmx2Sn38Qm1zsWwN6Nx6/xWhW7S7AoDlauFS7gl5C1cXl6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WK16iXdq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aada2358fso183333966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722437949; x=1723042749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhbI2qcUD6BnGrdQ3FwKQWVw6U417wDQ0L9tf2bpCDU=;
        b=WK16iXdqt2zQPwMABVBpZOf3PLWi6HIAfMgAgeAcyzbu32rNRaaMCur8qoE9YNLlVj
         nbM8QVGY7ziL42YMPkZTCDquuKrhwntqB0YI2id0rLZ3RS41j5IOLJRC+rnE8cT6YI1P
         kXLFkoOfiTdjgjDe1GBwJ9QjmdpQJqwZ1HB6BkQvs9zkQHNzii7Wg5YZVuLf7hDSPu6c
         GbmaFACwT7dapHYTeltz/RuNy+aUbJB9JWmqrNsTcyEcrETKxu8m+sY5D/LovoWZueGV
         6TXHTbIJd14kEmXVAPVmFIqEYBZlpx5GAicpx0bAChF1qGTQ/wQbFdPbYPMRM5rnk5cK
         0ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722437949; x=1723042749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhbI2qcUD6BnGrdQ3FwKQWVw6U417wDQ0L9tf2bpCDU=;
        b=sx8Mj2fDxBSiwMJg95ll1JKolfYVdPAtxCm38DTkWHYGKmZ3uQFfByk/ZpL995o3cX
         c4G0Qq17tuxfMWsIKEMkNMiAkKqxAkcVNHd3iLMxX0utZMVRQNioxcUBLcFi/OUZcUEe
         C4ggd89n/aPGFSyq8Vi30rtu6XHO8DxVeonv4ntne+GadpeoBgldkMkRN9HqddEG4Zao
         ZlWejOzK2GNoGL11Cqo/Ka5yXISazpSAQqmpviqd+/Nwfy7eajl1uJCdkDRj11js2aoX
         OizpSQJN/YxnM08Dl2EhRi13wQBY4OG5ugRm5UH/JEl+aiAt8iMoGHx7sytJdKt8LFFg
         XKaw==
X-Forwarded-Encrypted: i=1; AJvYcCVDrS3RnYB69WQ6ianu0o26o+TOS5tGZ+TFeF6rz7T4/ZVWmINysavt9YfUMvMzUaqpnEaWi3HBXo5NZ3RoXD1sPsjG6PQoprQWUjkW
X-Gm-Message-State: AOJu0Yyf6ONHgQyfyifnFpF0L8kXtQ2IworRSu9fSIuwafzWDVVeRRzS
	Zs+bIswKtDEKo6p4sJh1bSre3uT17p476Lq1CCYznA2JkHzfD+S2Qp749sLxfDY=
X-Google-Smtp-Source: AGHT+IHVH+Xx7HrL913MR5RlHCHu1xgZx5vzcNo97br513mbozSHlnxNxBR8fViKxEHdoxWFvBT45Q==
X-Received: by 2002:a17:907:2d86:b0:a7a:a33e:47bf with SMTP id a640c23a62f3a-a7d859576eamr576235566b.18.1722437949297;
        Wed, 31 Jul 2024 07:59:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acada27ddsm771813366b.184.2024.07.31.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:59:09 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:59:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 13/19] printk: nbcon: Show replay message on
 takeover
Message-ID: <ZqpRO6YImKDRL8bS@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-14-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-14-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:33, John Ogness wrote:
> An emergency or panic context can takeover console ownership
> while the current owner was printing a printk message. The
> atomic printer will re-print the message that the previous
> owner was printing. However, this can look confusing to the
> user and may even seem as though a message was lost.
> 
>   [3430014.1
>   [3430014.181123] usb 1-2: Product: USB Audio
> 
> Add a new field @nbcon_prev_seq to struct console to track
> the sequence number to print that was assigned to the previous
> console owner. If this matches the sequence number to print
> that the current owner is assigned, then a takeover must have
> occurred. In this case, print an additional message to inform
> the user that the previous message is being printed again.
> 
>   [3430014.1
>   ** replaying previous printk message **
>   [3430014.181123] usb 1-2: Product: USB Audio
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

