Return-Path: <linux-kernel+bounces-263273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386AE93D390
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E162028176F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7B17B503;
	Fri, 26 Jul 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FeOkDyjp"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21842B9DB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998527; cv=none; b=k6s7sQme1PeBRcNoUmMabHkWjGoU8Gfunb1rjuGG8MAh9WO4tthlf+z0GIgu8it/XnjNW6IpVf2b2cbzV+IOHJpmM4e4Gfo1Pg1waFwTM0T7Ae4SpfYiXuQcGk8UdJlWh55PGKjC3zkiTUBynx/VeqOZv4pxn2Fl5JyQOPvf+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998527; c=relaxed/simple;
	bh=gWOoP+fv7pEw1NtmadvLFDgb72DgvaG/iBv5rtP5pp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKVJ72kby54WQepaoqspDtlO62Ack0QkaXjSBRBSy3mz1jxidmXABkUsDZx/lDLZ/zcOf4g2KyjTR65cqdisjCgBeeKH2H3FWtGLZcg5lG5M5SBEXwkhFQjGPPFQJ8M6rvaqpU29nPoYF29zpgTXLPlaZPRuAQQQ5w+q+Wj/u7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FeOkDyjp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so145515366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721998524; x=1722603324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s515EiJfB3o6tNen+NDMFyeZUjEv5X30MYwMKJzwHj8=;
        b=FeOkDyjpPTo7CPeWvLjJJgpnRdsvyqXan7NDayAjU2ox+H6Z6KuTImF431xMiqRPHH
         lpp3FPmNyvPcV3Il6Ucsrm2pEG6OpuWv+ERTWhJn5GH8KPxSGCB3iQvrvog0aSdv7wFR
         eF1Wq/zXN3oUye24grwymDYs9JMXs9rRNa73FtahjrMDbvsCuZtAkQuocVhmuIX48xpU
         w2oEqkVaSEPTV9vL3esXYiXzfMENml5QvzqlZMeVO15dQ+0dZ0cFmnJ9YKG5mrfxkQQs
         5k8BOq1Q+Uk4xHmmA1bH1sNbpEn+4b5p0pokKO1Z9H3GbAF2xmKrlrwpce9sDogq6yAB
         5UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721998524; x=1722603324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s515EiJfB3o6tNen+NDMFyeZUjEv5X30MYwMKJzwHj8=;
        b=vHGQNYmVKrd1Z/7ggKVTRudMbV/IAvQFkjU8YQbbwrxHmq9H+GsHfYEcO7zkdpzyZM
         z0ycD/lSOMcmUTQYqcwisA51SJTXSq/VK3bVcLm7/bLo7WQYkfmxcSa6bCpTuCrBEKnZ
         OetIuiUJ9UUwgdByDcgABmJAvYfC84/Tsl4H/n1Gyiue7580i0CCbQu/k8/klQIGYZ+h
         QoB0TFARJV3s4KpEhkjmntJOHiE/pzncOL+S1TL6x9vMWOTrx5LfgdUaSDM60K8t42ix
         ZeAHPatX6PterFiCJ68bjb2XkMwntwnp46zhqNaD/aliHHvSDDciKKa87EuLfOkDaRuN
         UG9A==
X-Forwarded-Encrypted: i=1; AJvYcCWAxKLyMP6fh4oHzKQmtblqS3U+16c31duEw1mZuKtvNwACs4aTy/XG/+7UUnhzv4ZCEqXOp4sLYhBOabh7RTkcuaKSd2pghg14hXnt
X-Gm-Message-State: AOJu0Yw9BgZh0qq4TUKNiUVxkktTitd1DqgLn/lnLIQhsmv6zcaZ6+ov
	/vPljfklwid9T9+xc0Kph2GKeN4lomBZz9q+Vyi+oWCf23o/V5EwU+/OFv0uRtU=
X-Google-Smtp-Source: AGHT+IFw9Y73O/h52y1SJEkHvHV/QcTIkhQkRuDEuu+k9RfShmohgsnCDufOG7SeMxlnKM7+dVAiyw==
X-Received: by 2002:a17:907:72c9:b0:a77:eb34:3b4d with SMTP id a640c23a62f3a-a7acb3d9ee6mr388297966b.13.1721998524065;
        Fri, 26 Jul 2024 05:55:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acada2b1asm173725466b.158.2024.07.26.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:55:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 14:55:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 04/19] printk: nbcon: Clarify rules of the
 owner/waiter matching
Message-ID: <ZqOcuvuZM7_J-6C3@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-5-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:24, John Ogness wrote:
> The functions nbcon_owner_matches() and nbcon_waiter_matches()
> use a minimal set of data to determine if a context matches.
> The existing kerneldoc and comments were not clear enough and
> caused the printk folks to re-prove that the functions are
> indeed reliable in all cases.
> 
> Update and expand the explanations so that it is clear that the
> implementations are sufficient for all cases.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks a lot for documenting this!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

