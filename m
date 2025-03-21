Return-Path: <linux-kernel+bounces-571642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F6A6C006
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E4D7A9801
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A037F1EBA1E;
	Fri, 21 Mar 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MZHWkbQV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36E1E3774
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575001; cv=none; b=AzR+6FtaCC7bCsjOGRZ/3TD2Mg0iug+K2rxOWL300p7rNiL9dQlcilo5GtRLCW/QqfYAnJ0aBU2JggaPXAJkc3aQhRHU4sgl/52eVjKVqgkfyMbPeuVp/dmJdHibx3Ii0cS51QCRUX+DcU1uUeAvR+OhW9eggue7Q2UV/EThl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575001; c=relaxed/simple;
	bh=Hjm+6X18HfhpHIGsOF0Wa+HjL7J2VCrd/SOk7TvJe8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfGG/omqY/8nmmpe8FKiKedOYqDDLiR1yEekEZIgHQ1cCgvIhcDqXpuWVfFPusu7DL9GMRRJof9DZIcg5/abosoVfmOgS//baq8pTERZLY7K4oE+H5s5KnQNab9Z9Oj+Gx/6Djg47PvfPCwv36yYIFHzPup5BiG2XgbgKxbAGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MZHWkbQV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22435603572so43054265ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742574999; x=1743179799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YALLnLfNqwU57i7wtFxN8i/4pwzBbw+w8xRGUYxzetU=;
        b=MZHWkbQV4x7bg/O4wFFFfRPlZtESaA0v8NXS4bwNrJ6AjgL6ju53tkdph3LJaiNMme
         Uzvt2rfsKBGYwXhkxusFMsVdUZtocME/uedeyElNWYuFM0pXYRhGn+chWuHm1avPkY+e
         bLTWDD3vMSIqEuSER+745abq7dnQ3YJWC0/HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574999; x=1743179799;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YALLnLfNqwU57i7wtFxN8i/4pwzBbw+w8xRGUYxzetU=;
        b=sc0VzPjQK6P7Rz6VHnqwvbpY51IeGAIvCBiIIyn+hU6YhQbS7NkZIgWlwVU7iw+IGw
         trBYb6bfOeppW+5pxqMHF++nG66DfU/m16GHvXtmWyHrOHwrhbldH6sLbJ11MKO+mCS9
         /rvUcBvtkfekh7V8JeHz1ccBknSQ6ONUudSSpGUbWq+xHWkutvHNi6iM6pSu2m/wgC6p
         +0hHNn8xtc4BYeirsvM2dRBCMVEZHA/AoA69YvfSIAxU3JorqaSN4zS0+wXNQ/Put09Y
         2EHRHq/GWeJ1dC0vgGXeH8MYiFR+9U9RAkVvarK/49Ke2aUi/cMVZDuMQnUor+FNzKOc
         DEkw==
X-Forwarded-Encrypted: i=1; AJvYcCVC1kiFrUPstMB419hS+fGHAL44Z0xlIMJkF3Cuy7b2HjoZ2mARdbd9LESc3fGyVKrHmRdxi3sVGE6yQQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzViXQui2H31w8dma3KMTIPdfHcrlzdmhrjLagR8lkXYM4SozVx
	mFfb7Z9PdTTGtIC4NfoJE6R79U7kLmfKXW4L9R0rC+8SjeJaxM1+Gt2UxnTdVdI=
X-Gm-Gg: ASbGncuGTUH3+yOIWCjxV4DODhT1nnSb9ElkWOAk+65FrS4dNBqqnhsK1PC3px9s+LA
	VHiAQwxkJdhR4y6iZye+h+mnrHZBSVlHjuOBugoaG6ndxX6w9Z+UPs0JKXy48AQmyPb48Z3grbj
	6uvMCjynT/4MongMgeFTR1/v1Z1IvNZI6cijW5TSH62mEm9mEUtodT6POwJjiO7ZumSKOJ11+gh
	hu76HtE47P1qsjkXiANM7fdIHH6no9rrHYineN6KjBW+EjfOgllGeFwB8SRNpdxeHyFK2KvrKa+
	v8QyeqOtvPfUnNPecUXvRgNb1+yjk09rJtOIW3ORvsN68Asyw0ddvAhZ7HrifRY9qm5pq/nbGdK
	36SXNSt1bLBIHHbRx
X-Google-Smtp-Source: AGHT+IHqu8khKPmdrz5ZxNhApg6woYn1wpjz3geiCjpfYxV9ENASu0IFRk3+3jTmUaVHH2l595zxFg==
X-Received: by 2002:a17:903:46d0:b0:224:160d:3f54 with SMTP id d9443c01a7336-22780da858bmr63728105ad.31.1742574998924;
        Fri, 21 Mar 2025 09:36:38 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f39772sm19205225ad.25.2025.03.21.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:36:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:36:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
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
References: <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>

On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> >> I don't know the entire historical context, but I presume sendmsg
> >> did that because there was no other mechanism at the time.
> > 
> > At least aio had been around for about 15 years at the point, but
> > networking folks tend to be pretty insular and reinvent things.
> 
> Yep...
> 
> >> It seems like Jens suggested that plumbing this through for splice
> >> was a possibility, but sounds like you disagree.
> > 
> > Yes, very strongly.
> 
> And that is very much not what I suggested, fwiw.

Your earlier message said:

  If the answer is "because splice", then it would seem saner to
  plumb up those bits only. Would be much simpler too...

wherein I interpreted "plumb those bits" to mean plumbing the error
queue notifications on TX completions.

My sincere apologies that I misunderstood your prior message and/or
misconstrued what you said -- it was not clear to me what you meant.

It is clear to me now, though, that adding a flag to splice as
previously proposed and extending sendfile based on the SO_ZEROCOPY
sock flag being set are both unacceptable solutions.

If you happen to have a suggestion of some piece of code that I
should read (other than the iouring implementation) to inform how I
might build an RFCv2, I would appreciate the pointer.

Thanks for your time and energy,
Joe

