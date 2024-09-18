Return-Path: <linux-kernel+bounces-332649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868D97BC87
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B2E1C21D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050B176ADA;
	Wed, 18 Sep 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NgCT4nhi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB529189901
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663946; cv=none; b=ujCNrFALwvYsqQIdAi88Mb4M39ZGkF1jKWQLzEaitKnED6qzMxd7izAOeqLn/3gyxes6IGD8rXKtm8YxMkneGBZcdrvsPwD/oRRCT/dzIxhvGGU58+O3070iCv3nbzhct1o8IWqrD5QGQfrtaL9F5nMXKjMTFSIZao0/Q5NqPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663946; c=relaxed/simple;
	bh=5QbounyFpdeLyPpqYbR0StL4YuvH2a6AMVNNNNvb9Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSnAyMtjRVj34B3oP59qT5GwYGJsqtJdhv9sPCFGWBljiIUs2vDDVMi+M00eACj1KSCRDTv5WU9TiKE6W6y5Br+FNAml6rxm5qyjwCPzB2NDgo+sbVFWim5pdqgtbvFteKkzxn8k+6nu1lezZRrRm8tjwEGVZIY/unk1ISyVuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NgCT4nhi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so66663175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726663941; x=1727268741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+s5jBMUot9g03xEiSgGkzS9qg+YNVwIhQFcEqltV6D0=;
        b=NgCT4nhiqTYFBrzcC9iixqV4la5ZcYUfAPFjOMXQSN0dtPg6wtkLGbszmdGa3h7dJf
         JLGiPTvldGF376yuuctA1BjQIdJPYa2zKvGWS0/lQnMIPOjRHoMrEWOjmVPjIAHGlpjJ
         jam+z2BZtkgQSBbw2BqK4T7t4HM1Z6X4BjQwz5Tjl8Aov8mO3NpO7P778HVNA4T7fYUf
         JY9RarhV2ZQ7f7E5f2RsL5i8AOmOq8tVkR94HtwGrMmSIIrnUdWQaH7wiCbkZTQlLxHR
         yTEhaa22uiArE6WquudZabBtzpk+yOHRaPbcDccQTGq3hnlCZ8Sa7o6UbmvUdocChDMe
         moVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663941; x=1727268741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s5jBMUot9g03xEiSgGkzS9qg+YNVwIhQFcEqltV6D0=;
        b=T/TK1Uoa45CZZl2diVAQbzU2n4P4MycC7LAE0obPS9go9AXzI9Sn7JSO2nu5rUtvEv
         puoOEtnhmMytNAxepSTcBO93h/VlfyWm6fF1py5AO2L8cJUdyUe5WTw61enPF1KQzOnE
         fYelO7cMmOeXjtnO//jf6JmB+/c3jfaM/0eDOp3X4/siTHVp3oHIUWICMwSbIs+dtNNW
         ar2oYEteKSdB+4fzB8fAyYrmGfLNttSZHG37bSspg2wehch3SDoLtltPm2ORMaTe26kK
         c5BZCv3leSHIvNYOT/Sq7KRueoJA1ojKhk6E9Dgk5+1k07jytRp0F2kdCuEXxwGFBWJw
         KUgw==
X-Forwarded-Encrypted: i=1; AJvYcCWXcMUOdZhnn8DIcjMVGq2lvUaakouabRznz0+YHrqvtNfL07iYRIcF0wWckMDp+13romeTg0EA9cmxg1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LqGExQXaPV7X4JG5v8q+FQbKN5mQDEjNxoMZmghoc6VBfq8p
	+e0eiz3YoZ6WjiBtvO47fWJNJMTT9JvMnb7JF80JITPKiYDwaz/p2aOy+rphxW8=
X-Google-Smtp-Source: AGHT+IG1ehOCKV8YfrxH+CjYDke8qE4rmuwAM6XvhbWHjYwR2pC+c9kHprUmLkqGKwV66QYZbIfGtg==
X-Received: by 2002:adf:a3c6:0:b0:374:cb30:b9b3 with SMTP id ffacd0b85a97d-378c2cfed36mr11530408f8f.2.1726663941116;
        Wed, 18 Sep 2024 05:52:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601083sm64767585ad.71.2024.09.18.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:52:20 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:52:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 4/4] serial: 8250: Revert "drop lockdep
 annotation from serial8250_clear_IER()"
Message-ID: <ZurM9ufiMsjT6qKo@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140538.221708-5-john.ogness@linutronix.de>

On Fri 2024-09-13 16:11:38, John Ogness wrote:
> The 8250 driver no longer depends on @oops_in_progress and
> will no longer violate the port->lock locking constraints.
> 
> This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

