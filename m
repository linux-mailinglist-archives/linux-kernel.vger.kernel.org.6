Return-Path: <linux-kernel+bounces-523049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF2A3D164
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816DE178F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D21E3780;
	Thu, 20 Feb 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHzWGsBF"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FF1E04B5;
	Thu, 20 Feb 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032823; cv=none; b=pwmuzIX9ZdYi6zgMDaf0wIgbETLgT8UTjCpI7bluHI6Y4xuvswh+j4tRdvno6Bu4qX0r3V5S/PG4R9pf2Iiy6D41iR2BLpw/rg8mwDeBK6tD9rizAJXUt0ea3cQ6KHILWiSnbLbUvHfIMzrA+48kZwzCrh278J/bk9wjSqc6R3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032823; c=relaxed/simple;
	bh=LZBQBhfaFXyeS3pAaaQlyQR+S89x9I9NaFXrRW7TWSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8NQrBqrZM+FpPpzd3VqBhalqPnrI7/B1qaH+R8yMUf+2LMg+13WQniOU+uK1BR8jFfFKYf+ucS5Mz3clzhTdfa5enHQVZHrS2ZXk12V6rzIK02BEaoAgXiTcj32xb4jwgWisfmRmrHRUXWbptvA7/1KRQSDx4L1iAry52knwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHzWGsBF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab771575040so303318166b.1;
        Wed, 19 Feb 2025 22:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740032820; x=1740637620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmcS0wBHh82dG0N8AQzS/9OeO7GQPx1RnTtB6k5ffs8=;
        b=QHzWGsBFO3JwWVOjsu7P6ZXwq/IfNoeVm6gr/SyswHVbiOLKyGCL3o1mvhJYsVJPXQ
         5UKFn6TK1+XfFjevaa5+NrBQD4iX1rpn9PURZK+Hkcwo6gqlAhRaW4XKvAisMB5gdLHc
         iOxDW1nJ2u0VjvmQPfa0aX88JbTDz0YB5HcQJ6krHWQHptKAUiUYNa27+FUkFMYlUdHi
         z5kieB2jXOUFX5PSbTOk5NZZL3BvWQ6EcNO8MOE7s5LF06C/aaxlodhPssrtGxR16Z4u
         0NadUduVmfRwlWL7oTKYKmem+tmDVeAZl+ubPsghglqKwJwPxshbolC1GFDm/plweRvg
         ysMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740032820; x=1740637620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmcS0wBHh82dG0N8AQzS/9OeO7GQPx1RnTtB6k5ffs8=;
        b=CcmxIwMtbak521/EBK152vSE0yfuVAA9xU55tt9DOqXNgOnANUAqIRN5VB6h8m/t2v
         2B3Oc3lq23O3i3kArd+cICKIosrthlfobdMeJ7fC0xYWQi6bA2d+7D9MWFY0lpFfabLi
         WHVFpULaxpRDE5gMVKQfPf8NY2ChJ17CNdOaXtjSM6qmUVDq1g3RdUO8OGcVxdX5R1C+
         4FnfqkdmmGLoS/UoD7ZIbtomY8jC6kaGMMyF/V6a9JOmbvGB3VNr7b04+1KCf23wzL+T
         XiVFx3VAixlWwjOstYu1LnpYbPyKfvc9oNwVakpIKpTHcQqmBTq2jBj5DMSyfNwdtN5M
         4QqA==
X-Forwarded-Encrypted: i=1; AJvYcCUV0MLWeSGxGpc9/Ic+8UJEFfYFBj2aPVleGVhIF29ZWz0I+b0WfIN6QnXTnJLdQr8uevOfdq178rJQcZ9YBj0=@vger.kernel.org, AJvYcCXMpzwBnymWF+bt6TZagTRKtvVQ8/WEK3NTN9Z1dvN8IhO0uCl4vlzGwoN+7uN0G6FE/O7DETTh/dAOKHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSL8jt+ggcOysaMn5D2sg0fWG3NYHSjGCJQG1RCgq+XE742u1
	CZaRZy86ndUpU9piRI+AgT94kbykaZ9iXDQivNjUXCB94/B/KQk=
X-Gm-Gg: ASbGnctfelg00PXKrIUIzkyyNznHYe67PJCPyufzb/wlK1JPIiHVbXjx5VxmYsO1Wsj
	v8vT5AJi7IzXsM0wm9iipb/p2Pd+VItQYMx7Uo1gwbPT0Ro7lzNfQsPDELcR4S/IvAhNNQBH2EH
	O0QO9tUYqVuCQIXye0wU/MpYCI+uWOw5zwtuFpygqrducFaeMoqe7TFe2pa2S+0A8KWAGVIb0eq
	qHaMsxUXMU+KergfhFD+++hCQObGjjmJf5EPYVdbQ063RVAJjXG1lL+J7j81NBFAO9VpGfr2peH
	ybpRUg==
X-Google-Smtp-Source: AGHT+IEgkvW+ydWvcTheEuJsWN+EVna+K8YgnTZFPPR1Xvg4Tgt8IQlkkiAl20b6uqtCJDO6ElNGTA==
X-Received: by 2002:a17:907:8b96:b0:abb:ebf8:72d9 with SMTP id a640c23a62f3a-abbeddc91a6mr200014966b.15.1740032819413;
        Wed, 19 Feb 2025 22:26:59 -0800 (PST)
Received: from p183 ([178.172.146.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb0fb63ecsm529364466b.115.2025.02.19.22.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:26:58 -0800 (PST)
Date: Thu, 20 Feb 2025 09:26:55 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Willy Tarreau <w@1wt.eu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <f4a0d359-456d-4b90-bc0f-995d26837623@p183>
References: <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
 <20250219153350.GG19203@1wt.eu>
 <e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
 <20250219155617.GH19203@1wt.eu>
 <20250219160723.GB11480@pendragon.ideasonboard.com>
 <20250219161543.GI19203@1wt.eu>
 <20250219113331.17f014f4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219113331.17f014f4@gandalf.local.home>

On Wed, Feb 19, 2025 at 11:33:31AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 17:15:43 +0100
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > Yeah absolutely. However I remember having faced code in the past where
> > developers had abused this "unlock on return" concept resulting in locks
> > lazily being kept way too long after an operation. I don't think this
> > will happen in the kernel thanks to reviews, but typically all the stuff
> > that's done after a locked retrieval was done normally is down outside
> > of the lock, while here for the sake of not dealing with unlocks, quite
> > a few lines were still covered by the lock for no purpose. Anyway
> > there's no perfect solution.
> 
> This was one of my concerns, and it does creep up slightly (even in my own
> use cases where I implemented them!).
> 
> But we should be encouraging the use of:
> 
> 	scoped_guard(mutex)(&my_mutex) {
> 		/* Do the work needed for for my_mutex */
> 	}

Meh...

	with_rcu() {
	}

	with_mutex(g_mutex) {
	}

	with_spin_lock(g_lock) {
	}

> Which does work out very well. And the fact that the code guarded by the
> mutex is now also indented, it makes it easier to review.

It only works only for ~1-2 indents then the code flow away :-(

