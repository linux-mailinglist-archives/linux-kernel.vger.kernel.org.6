Return-Path: <linux-kernel+bounces-309432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A37966A60
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F8A284523
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6A1BF7EB;
	Fri, 30 Aug 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="du7skpTb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1611BD005
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049392; cv=none; b=E5ih0eH9K24bjmWPC99GFjH30QxbhEbO/Qk8cfZB5dlxEFBC1TlsQzYkUL+jRSsmNYvbDHKGSxrWWUNhafL4KGhPJe2rZc3hqYRqqq0DP4ENn/ltnv+RIc+BxtgcbnApoHaMZ037GDu8vSX35X2PWoQ9myelbCpbZrst261Fzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049392; c=relaxed/simple;
	bh=HHYq4lIrZwUIErDY1ULmrAi648bU5zYQhpY1dD2LPpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRdRHcxMAVtaNtFOmUop9I/pLqHN7eqcETln6bK8TUYmKyy5a8YF45qaH/aLpgJUlgfa/w0PEpmSERH8UmXDWgy0UYD+vdGR7EXNyLufDrMLmdyFtKtO4cWfjZUbE9BYLux2GKtG/3kDTO2iFGK8s4yaAoGhSYOfeKIgZExtgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=du7skpTb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374ba4e094aso326240f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725049389; x=1725654189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY4Amw8gJOTj4PW7gZjzdrs3IbXEA4NCHp+pehDFrvw=;
        b=du7skpTbEpk+pZUFfllz+7KsRCSCsTg9hJ97ZEiWzE3RurbqxGRxZpT1CFz7nGdzWw
         syl4fXugTpL+MbYm3ktxoa73nOLn/1fuvv4zuYzM+yY+8e5v7TVsfDigU2B7u17HBLSr
         vUahZb9sRTmLJ7fqr6dimMknOqPaO56k829ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049389; x=1725654189;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dY4Amw8gJOTj4PW7gZjzdrs3IbXEA4NCHp+pehDFrvw=;
        b=WTIrXWYB6TFChU6+5Z2L6nvouEs3PV4270WgxeShbbjtQ8I7CrK3CeONJq6vEiKVnn
         Q7PcEjzJNRN7g5SaxdJvI15BcAeMKB4KK3V8OeAsegLKNcfwhCGqVDjTUz4kzO6elj92
         /Y36wyNdFpCyFCM63YpMQwiTNnYsyQ5tmGn6Q9YhbRl2W5B7NvDTZZgrmOI5zpaM60qw
         YLTUbFapgMo7fDdEPPZItBJCtPzAAftNtyExvVRCoj1g6CgpFqtMcdepuFZogSipS/JE
         qzoFkHAVDeEF1LBuYnnm7kuN2ACU//N4bCD0V5lesuPCf7gieAx8TYN2LLoAaYh1T3t7
         4Hew==
X-Forwarded-Encrypted: i=1; AJvYcCWz0lRAVFSTIQrl3QMQyOVM0S+45EY+FNG69jiu85/E1h4QK1yyduEYYg8+D4gs3dREnGCGcLqj2dhuGGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLUApWFiHdMfVeb+Aqz7ldeX4btsg30fmRlTcMV66gKAEGRFR
	iinggPfa85nBIZQl2EEKvISwz5eTF4BgxvLF4zgd9GQL4/pU3IBiUh1KFd9Gf48=
X-Google-Smtp-Source: AGHT+IGTSnX9q2OLrTowkKkFCORzR3kOVTXj22YgCrsao2yn/enJOfKgrgmkn+96CYDGjR+J1G9oEA==
X-Received: by 2002:a5d:4706:0:b0:371:8e8b:902c with SMTP id ffacd0b85a97d-374bf1c954fmr33972f8f.38.1725049388241;
        Fri, 30 Aug 2024 13:23:08 -0700 (PDT)
Received: from LQ3V64L9R2 ([185.226.39.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df1066sm56001045e9.18.2024.08.30.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:23:07 -0700 (PDT)
Date: Fri, 30 Aug 2024 21:23:06 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <ZtIqKjdM6Cm8rbRw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-2-jdamato@fastly.com>
 <20240829150502.4a2442be@kernel.org>
 <ZtGNgfXZv2BWbtY3@LQ3V64L9R2>
 <20240830132112.0ee08109@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830132112.0ee08109@kernel.org>

On Fri, Aug 30, 2024 at 01:21:12PM -0700, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 10:14:41 +0100 Joe Damato wrote:
> > Otherwise: I'll make them static inlines as you suggested.
> > 
> > Let me know if you have a preference here because I am neutral.
> 
> No strong preference either, static inlines seem like a good
> middle ground :)

Ack. Already queued up in my v2 branch.

