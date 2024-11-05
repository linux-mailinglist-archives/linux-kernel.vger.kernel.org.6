Return-Path: <linux-kernel+bounces-395896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5879BC4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFB51C2133C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6841B6539;
	Tue,  5 Nov 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="OUPKLLqG"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1B1AB505
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784214; cv=none; b=BUE6Tf+H9Rs+S+LJWVLWpD/FHNQQfd08/ZQLkZ/FiXKchDWDF3rj4TGpNH/a4O+gYAB7zwxvjK9paNOMub84zqsXa0kB53sH3EQG/ASOU57euRUrOCaY0c3o5DmwqKyEnM4YMTqjakZ7jhJArMV6z/5WXIxx3rIlJWCTa+zxZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784214; c=relaxed/simple;
	bh=Zsdsrn5QyifI5KpUEy3Si6Hqlwx2uydMgzuv5g0ftik=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLp9JvEO2NCKZmtSIVYJVhf/ZSkYlm0fK1HNPhpPjN90NsyP4vwLq86mB6oaRg0J7UlyaUlnJAJerh4Z6IXaJGNmTScjhwJ99BovgME/SfRvgPUZ1FnyvvfrSMKSS+md8egGdlGMC+E86OuW2Oemp2EP36Szia8jSPBTq4ur9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=OUPKLLqG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a850270e2so829069366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1730784210; x=1731389010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLek+8rRFefzz3qfy2bF6CDdC5m9OTEU8lr9WxdqGCM=;
        b=OUPKLLqGiaq3JR1DjLLeKfn96BtuzkXt4KDKQoBGkM7tCUlGb0+oukSonlBsetvca+
         KEEMZEWOdVZpvofCrzf5vI5IrnVKeLiVS39JaKvDzXFfrAZOhhjI7oNLtxijFicckY+2
         DwlE0hLTTw9ETXmt8j8+vts64oYCx32+oA71FNMTzJ9eIX0BVFc+bhm36/ZdfYSs1bHE
         5C7VvLi5pyTcVOu5IKW1kKYzuW2mHY1XxCKMUO186oM6U4t24An2RyD6S17MCrcQQCuH
         /U09YzSqYanZ2KOQrsg4LEvhO3VcW5FTUBdQcdlGhxQsC+hXkfoUZbGZgRx4Tckd3wNY
         vKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730784210; x=1731389010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLek+8rRFefzz3qfy2bF6CDdC5m9OTEU8lr9WxdqGCM=;
        b=RLhbLf7yJ+86wnIZ4WdlccSOsk48Rgzz9sVCkHScjXM6D6rWnnm+doKKJqEChNQB9j
         sxQsmd82HjYGSVcSymBllnx9VKZa+w7JnHV7rgRo2AKjysttmTkT87lGErNSMpa140OI
         La6osEvDxVmc27nRfX2G206Id/IaXaRHg4xcuXZNNB9J/76YEbhk6xN2bXNllzsdUzbl
         NNMeLsWYCBNpBJJFajTD0CT268nm87BqlhXShMgcEVzYKW1yUGR9RNZMOu+kLtrxBF6L
         UZ4wLPvTbQI0zlXkodbvpx9uGqxqphbtkapT6TuNDSvmhUhQzXSc7qaYsX/R2s+ZAwKC
         Porw==
X-Forwarded-Encrypted: i=1; AJvYcCXM+Enh/qQ1ABXdfVoAZwiQWJZ3g09H7hZ8Z0gXY3m7mDlD22NrfAGLrYoCYbEvs+PHebFQHOktT66yHkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/9Dg9BfcYeBy7jIG3tGXY6yYjYWkMsShOhw1NhElzVkXEcQB
	m7TKm87NV6xNfKr754qBcwiTVQKXwHTd8ot2DTZ2y9bj+s7Xx1/kQ6EHPAFSxphh3kwixSc+msU
	pW2G9zKiWIQQcUwWdJ8O0+Cryu15NZgJnFUDiaVO00SsAk/RnbBp1aG+9Px+5/Aou3It6JLqfxi
	qUj5om6pKbib0dvtaBCw3YvcZide7HozX1Z0Hq4svv
X-Google-Smtp-Source: AGHT+IHEIACSt9/rcfK3SRS20RLq+YIWg4Kpqj9LfsyCOxuVCHRmz+k9dQ4OGU35Nq4IDBHXxM7DQQ==
X-Received: by 2002:a17:906:c145:b0:a99:7bc0:bca9 with SMTP id a640c23a62f3a-a9e6553af4fmr1495008166b.3.1730784209066;
        Mon, 04 Nov 2024 21:23:29 -0800 (PST)
Received: from admins-Air ([2a02:810d:aec0:2a54:587b:f26d:2c10:f02a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181398bsm76145566b.196.2024.11.04.21.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:23:27 -0800 (PST)
Date: Tue, 5 Nov 2024 06:23:20 +0100
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: michal.vokac@ysoft.com, pavel@ucw.cz, lee@kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v4 2/3] leds: Add LED1202 I2C driver
Message-ID: <ZymryKmQxU6Ndkih@admins-Air>
References: <Zx0A8ywBb9J65Rxl@admins-Air>
 <20241101170658.GA1807686@google.com>
 <ZyYKCMbviprVnoDK@admins-Air>
 <01b7029f-ecac-4b45-a28d-04081b326024@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b7029f-ecac-4b45-a28d-04081b326024@ysoft.com>

> 
> Hi Vicentiu,

Hey Michal
 
> Once a while I browse through the patches in various mailing lists to keep myself informed.
> So I came across your patch set pretty randomly.
> 
> I have few tips for you to make your life easier before you get to some serious troubles
> with the maintainers ;)
> 

Thanks for the advice. Annoying the maintainers was definitely not my intention.
My apologies for any inconvenience.

> 1. Always send all the patches in the series to the same recipients list.
> 
> That is, do not send dt-bindings to just Rob, Krzysztof etc. and LED driver
> patches to Lee et al. We all need to see the whole thing.
> 
> If you run the scripts/get_maintainer.pl script on the series, you get a complete list.
> This is what Krzysztof requested you to do in his comments to v3.

Ok. Understood

> 2. Use git format-patch and git send-email tools to submit patches.
> 
> If you use these tools you will avoid issues with wrong threading of the messages.
> 

I have a Macbook as a work computer. 
I've found online that the way to send it on Mac is with mutt.
Most certanly I lack some skills, but I took me almost 1 day to have everything working
mutt + google account + script mutt_oauth2.py

So, quickly jumping to git format-patch and git send-email was something I was not looking
forward to.


> 3. The following text should not be here.
> 
> You are supposed to just reply in-place to the review messages to acknowledge
> that you read the comments and you understand what the reviewers want to
> change. Then you send a next version of the series as a new message to all
> the recipients. Definitely not as a in-reply-to to the previous version.
> 

Ok. I think I got. Hopefully the next ones will be ok.

> 
> Best regards,
> Michal

Thanks again and best regards,
Vicentiu

