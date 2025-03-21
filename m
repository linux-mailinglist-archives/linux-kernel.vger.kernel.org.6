Return-Path: <linux-kernel+bounces-571912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA0A6C43D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC74C1892057
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A5231A2D;
	Fri, 21 Mar 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l5o0kxHw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28168230987
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589050; cv=none; b=nlIrM+JhxVNvlTNAJ8Wi5V8geuEI+3Pj1QCCesI6FbhNpYEpJ6L9jaTqNmszffCGVxYfDWqwvZeAkoSs7uE6XiTEV4auLaDCC48Sc2l+TSDd+N9z2XFBnfLIZMHq45tKMT5gh/Wz6NlQ/99J9qm+dYSSgU6OUwoIfiyV3Dg9Ztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589050; c=relaxed/simple;
	bh=kufjJ7ROxUIeeWBTf87pHaUYN0P9yN6f9l3gagdcYI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRXGjBZ+T8eja/6tA9EmVZOJFI6XYt3gW6V1B6afk2IxmJjRCpKTjvihsBHAB5IBk76uBScBfecincPzbiC4ytU8Nu8LZfffz78VhQgTYvX3PB0YZZUcrhOBKuYh7iymYQoWRd2kAVvubUe8i9jrSAFDQRVeegN5lccYU+26DjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l5o0kxHw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so49195735ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742589047; x=1743193847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=l5o0kxHwz56/APvSz0yxxES3DtKjkGRzP3aHJgNtqfsPTeXBNyJqn9VNgMK3W6VEgd
         C3QYN/SUg1QAF8O7bGci/PkW/6tvRBw+3iE/xpWr29FsLghzQGbm9S5Ud3iooTfeENXt
         V1W51rg8ZwyivdKhNuOGhhAQIyBNtmn8MsF/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589047; x=1743193847;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=f0FPR6Nv64PS+E49WSoHQdIoNciAHw1DjVpq6mk3cecD+CCEi5a81cI6ZcHn68sGXZ
         Yxu+J7Gm8bBfLh5oyVFMoq8M6kKHxAv9akfwZX5UbhnNc8KIWROrNKF2gPjIEh5g1qqI
         HK8IowfNXHu+7dwkL7mITZLpgt9yXr1QqPjije8uuFygtyOy1M1yXCStkUPUrpwtVaQf
         ibCOycfBty6qsEiy4T0oYALgdlyEGv0b/Nw8M2T027xBW3AVl5KYUB/M8dMlTR1eWGOn
         B4krys/FqPwQTYu9fBZEnPNbMelE7OdAdSO140olJIcbz1KvKk5a9cvSkcUxBLn5EuoM
         hXoA==
X-Forwarded-Encrypted: i=1; AJvYcCU3dRQ2dKVwF/T4lKz3yFe3I3ZKlERTug6Qx5/UtSyZVx2FkHLRVgLsJF/0XRxA1QyexcNMMkOnTyfDo4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9EKQ+MsV3XxdQ3vscCRiCIgb7YDCjgHDF8wYuLgJcPkLW3sRO
	bDQ+M+5ihHgQxPFsSboi9wnXY1WarHSGLeAHxZn3ZP7yXfgtp/21RaGUfiMeRLA=
X-Gm-Gg: ASbGncvzkOl+U6Wgc1Px2deJfpH6OaMaN4DuIWbNSrfN/G7GjN71GPy3ydxc93aXmRB
	Mg42j+jjKxeocn8baTqB9FWDkSjKPiAsXjbo3+2CQgvZBvo4CzEIvABDJYOAzKmEQ/jmdSViMYa
	AX+zamK64wa1ckknDsIvs4vcURqK2N+ZlfNgfTNOD6oYH5lS+0mTJZfqMfrRMF0XH2NPQ5UWKaS
	qE7ypNqVdEVGZYIbe6xdWy1bKF+r8Jg2rgPx0RPVtqnRqul1ZOfL9MqtrZdN3td1N66ff2CeQry
	yeHDYqTGHSpLZogoY6FkUQaIY7F8RfFEmIGc6NKHOwL/lVqAXohh/19ajh6WDoAFaIn/9ivd+3g
	wQ2/trVof/+TVSPMP
X-Google-Smtp-Source: AGHT+IE/0vRvWUIrCU9TpLfmE4aooUPQeYEWA/MrsW2UXdaB42a9j/XwGhSTptf5SM5XxL22FRt0Ug==
X-Received: by 2002:a17:903:41ce:b0:224:10b9:357a with SMTP id d9443c01a7336-22780e3fbabmr64649685ad.32.1742589047213;
        Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2aefsm21875045ad.109.2025.03.21.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:30:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>

On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> > On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> > >> I don't know the entire historical context, but I presume sendmsg
> > >> did that because there was no other mechanism at the time.
> > > 
> > > At least aio had been around for about 15 years at the point, but
> > > networking folks tend to be pretty insular and reinvent things.
> > 
> > Yep...
> > 
> > >> It seems like Jens suggested that plumbing this through for splice
> > >> was a possibility, but sounds like you disagree.
> > > 
> > > Yes, very strongly.
> > 
> > And that is very much not what I suggested, fwiw.
> 
> Your earlier message said:
> 
>   If the answer is "because splice", then it would seem saner to
>   plumb up those bits only. Would be much simpler too...
> 
> wherein I interpreted "plumb those bits" to mean plumbing the error
> queue notifications on TX completions.
> 
> My sincere apologies that I misunderstood your prior message and/or
> misconstrued what you said -- it was not clear to me what you meant.

I think what added to my confusion here was this bit, Jens:

  > > As far as the bit about plumbing only the splice bits, sorry if I'm
  > > being dense here, do you mean plumbing the error queue through to
  > > splice only and dropping sendfile2?
  > >
  > > That is an option. Then the apps currently using sendfile could use
  > > splice instead and get completion notifications on the error queue.
  > > That would probably work and be less work than rewriting to use
  > > iouring, but probably a bit more work than using a new syscall.
  > 
  > Yep

I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
through the error queue notifications was OK and your response here
("Yep") suggested to me that it would be a suitable path to
consider.

I take it from your other responses, though, that I was mistaken.

