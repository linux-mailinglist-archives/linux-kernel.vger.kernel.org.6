Return-Path: <linux-kernel+bounces-551191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADDA56931
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A23188E63D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32621ABC3;
	Fri,  7 Mar 2025 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C++tD6am"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70921A447
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355027; cv=none; b=VOiomwl4T1FeSReMN7rd9V2c4jDkf27ewEdS3NvWDzAfnBw8cRoIe/fcbP9lyvZfKeObvbExCnYXBI8RuHocY+ErMnVr5NlXTmHj8ww+7XGJcIRaXz5F9d+CBOpY/Q3M38AMm2FnArQIoY8NBl0/WhBwWwFmEg7qbTAz/eYGqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355027; c=relaxed/simple;
	bh=iQePSQa/VmIkiEWwwOhGq4x3G6rNZ0WRU2gH91xIhuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFdUZ5lm+fWBBm0oaXFDY7Wf/HLXNXR1iGsDui1TC77MNsABsMxnQrY7pRZrHYHbtnFcpZsHswYf/CQDzPG9SdY63vVkn5yky4dNuxrXQenWqQ3ZyteZ54fa2pgW4YdeDfFq3+K3N/VG12ciRS/8CUHQDC2dlbvzo0ilgHsKuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C++tD6am; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so15626875e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741355023; x=1741959823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwXZSVA9uDfpaltBI3c28B0VNZvXdvxIpnZGzFzKNI8=;
        b=C++tD6amL/AwLpodyfao4oJGIcCZn7m33wOCffq7R++CQWwrVbV8qLF68uvhBDMzmb
         8GsMJYlDglbeDp95BAg6HfTBJOAR+1LoNuLZdJCuSvMrw63OJnm3CVu3raKrqt61DExV
         K1o8c9h+QR6nM6SQZX+kcCOHME8Z0hr5ORMqg6Y73kSp6vIFHT+TB83FUyMcIlmwvY55
         rSBCWhzxMshv9QLlYNcEC8WwlvdEo5DqTjTRaQT29zFinGTp1wpIPCcW/TFMi285vKo0
         7bseFJ/c6jGFUq0g3iPZMfJrEj99Sc+FhwF+VVSN2RDwNmc3e/C9qZvnXXnTMHXuKaFU
         RT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355023; x=1741959823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwXZSVA9uDfpaltBI3c28B0VNZvXdvxIpnZGzFzKNI8=;
        b=Vn8WTiUd2f6Shg7tQDvJQJnrvo2RX/+Nbdx4Ls8Dm2q6CPR64no2u9yUqUIE7bBMm8
         4TSltBI/p9CL7gpv64tpYmbdfjqjgSPVdixlb0DJp2HtVuphx/4eocXg/VPr0ZB1+sJ6
         VgScsvUOWEbkXo2aZ6ogV0GahDkCESb58Q7mhAK/1te+FHn3bwrUtu/ATVz7P/fwPWoi
         L/64jp9MFq/VeHF9+imedM2E6XKBQCKvrjVASzlzWzqTgDwl0FdWzjlkho+O43+tHeJU
         st54jkrE6P/auTJAimaQSw/D4PzXNcGdeX7bmkMOJKQp+zfZlsY3M0MLWXA9AvcGShDl
         EnIg==
X-Forwarded-Encrypted: i=1; AJvYcCWvs5uEmK4yOzpzbSCqe/PYwtT+paNPl2fqLgOA2hr1uLf9LzDPiDt0kimwNJjaCezg5O+Wz6cuCTFNVIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LxWWnocYj3URfQi6arOYmUHB1Qmlo7LFajT66SwnEUgF/qzb
	lCCos7EWvqAgqRBg68pRF80cDz1f3ITnzDIOqPGFGUAZfpFU8J2kruSXm4LHRms=
X-Gm-Gg: ASbGncs40zu2tZaIwnpcHMrnYDAxhmtV2yrrCfcE2qvmuAFO9x06bzcUFeBLCJFcloA
	3Y7W64rqnNcRxUgj+CoMNzwBzKhJXCpGSheCW0uJHvJjJm2wZyBIN97QVZubaN+R1yS+uE94j8d
	IcXQ76/dKqUsSAXa0UeMLhvPsumL48mksLtby36h0DwobFvmoEZCbv2a//9WA9sVSmF+fUzQFO6
	2dJQEl/xc43g0Xb1VDEZVpmXvxqt9YU6OUIZ6EEZ4mbNJQb7CURl2nhdoFFSM1MLJ5hVgwPHMWD
	neb/seqp5dspn8Oor7ZUbnHl/VPS3ydL3Y1/5Mpp2927PsbM/A==
X-Google-Smtp-Source: AGHT+IFa2alqSGIKkLzzt+zL9Pg3YSFMY41VPpSwlcRRoSojAy2L3BjwP/rTiiK3+AR7CB/I2TIHig==
X-Received: by 2002:a5d:648b:0:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-39132d1fc83mr1919454f8f.17.1741355022100;
        Fri, 07 Mar 2025 05:43:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e1d67sm5380042f8f.74.2025.03.07.05.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:43:41 -0800 (PST)
Date: Fri, 7 Mar 2025 16:43:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: less size_t please (was Re: [PATCH net] xfrm: fix integer
 overflow in xfrm_replay_state_esn_len())
Message-ID: <f5100325-4b43-446c-85c0-6e3535305af6@stanley.mountain>
References: <03997448-cd88-4b80-ab85-fe1100203339@p183>
 <1ee57015-a2c3-4dd1-99c2-53e9ff50a09f@stanley.mountain>
 <3c8d42ca-fcaf-497d-ac86-cc2fc9cf984f@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c8d42ca-fcaf-497d-ac86-cc2fc9cf984f@p183>

On Thu, Feb 06, 2025 at 08:06:55PM +0300, Alexey Dobriyan wrote:
> On Thu, Jan 30, 2025 at 07:15:15PM +0300, Dan Carpenter wrote:
> > On Thu, Jan 30, 2025 at 04:44:42PM +0300, Alexey Dobriyan wrote:
> > > > -static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> > > > +static inline size_t xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> > > >  {
> > > > -	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
> > > > +	return size_add(sizeof(*replay_esn), size_mul(replay_esn->bmp_len, sizeof(__u32)));
> > > 
> > > Please don't do this.
> > > 
> > > You can (and should!) make calculations and check for overflow at the
> > > same time. It's very efficient.
> > > 
> > > > 1) Use size_add() and size_mul().  This change is necessary for 32bit systems.
> > > 
> > > This bloats code on 32-bit.
> > > 
> > 
> > I'm not sure I understand.  On 32-bit systems a size_t and an unsigned
> > int are the same size.  Did you mean to say 64-bit?
> 
> It looks like yes.
> 
> > Declaring sizes as u32 leads to integer overflows like this one.
> 
> No, the problem is unchecked C addition and mixing types which confuses
> people (in the opposite direction too -- there were fake CVEs because
> someone thought "size_t len" in write hooks could be big enough).
> 
> The answer is to use single type as much as possible and using checked
> additions on-the-go at every binary operator if possible.

In the write_hooks examples, we fixed those by moving to size_t.

64bit types are safer because 2**64 is a superset of 2**32.  Anything
which can overflow 64bits can overflow 32bits.  So obviously 64bits is
safer.

But it's surprising the extent of it.  We avoid using ulong types in
UAPI because it's a headache for 32bit support.  So normally we get
an u32 number_items from the user.  That's 4 billion.  It's a small
number and it's actually pretty hard for it to lead to an integer
overflow on 64bit systems.  The struct_size() function is basically
not needed if you're on 64bit and you declare your length variables as
size_t.

The rest of the kernel has an assumption that sizes are saved in size_t.
The size_add() and struct_size() macros rely on it.  In networking there
are a number of functions like sock_kmalloc() which truncate the size
parameter to int and they just make me itch to look at.

regards,
dan carpenter


