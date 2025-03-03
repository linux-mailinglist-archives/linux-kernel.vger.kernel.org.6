Return-Path: <linux-kernel+bounces-541394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38AA4BC81
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F47A3123
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A51F3BA2;
	Mon,  3 Mar 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEuwjdfT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478C1F30C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998100; cv=none; b=lZyOMgroQA//DlO17cBYYByqFpUZc6ElaIU92ceZsHVb/CPDZU2O9wFqj17tsn4HCohhv8ne/lxbLwUqPokksYsiBhOOwGHPk8GXH24PCGJQ9Pfueiave9rj7lSEG9EPAFFgGWdhPLkqecqUALwHorKZ0ZtaJcEqKMrzn3NhpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998100; c=relaxed/simple;
	bh=lpDLopW56ZiJmp1XcvXqO0pzbDV6pWgE4pCJfBENgvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3dEDoUpkGnOwD8vKysISAwcfxg6VP8Kq6Rw6iCsyCaklvvPRsazvUVMdaHf+2k+i4axV9Vhf/VvkEIVUKdlCOaGYZxxDvs7c6tAGy+kfBDqSIZIjGt6B/F1fgjVQnqWIasWmvTt4UbT/jwme+o0yuhBt/f7laKMIP+w1o+csVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEuwjdfT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ba8a87643so76945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740998097; x=1741602897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bSaBNG5Yoq7k/pu/7absa0rkEVoeKeNE/Soa/XJKAg=;
        b=LEuwjdfTBYUvSNpHfqrKJk1ufwL4Ps93/JmuQ7fKw1leSFtC9ZQS1HazDR5j2r91LR
         OkPPlYIqsAn1801FSJSJDWbY2Qfm0pyObUq/KuczBk15F8+gJgic6HrLxQkI9IFAD6+E
         Fp6d/X5Ip4o4+w/Dp205g4Exsaw3G01CHKrk9uAG1ir7hFTfBbzsLmlmkardaSdO4ayU
         p0PYgWpxCoJGfZ464Wxv4dDq5vAdN6sAdV/x4/XR2XrceKvdyFKhbaZTh0+3KTLl1iEG
         TM3q3hv+7w2UlUYKxzIPMMmkAAMeOUk+6uRg1geugTK7C46Vl7XeITmtl+d3KJgFxy1Q
         ZA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998097; x=1741602897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bSaBNG5Yoq7k/pu/7absa0rkEVoeKeNE/Soa/XJKAg=;
        b=Yan9rxqmmaaGieBwCjcSOjtU2Nz8/5V87Yt0m5gsj1d045tpDwpaii/ZzmOjLoo6Zl
         r8Fr1HtwaP9CxjCP93RTh3E85sD4v4/Tt2Ojkkg3++N4bYQf6pbEhw+UuIZv8Oi3C+C2
         aKWObZ49QDK+5MMH1VfE6uTMYcjwmkA2ZSifKxmsa2XaZkToe2D9e0IOQVwltKjvdvcJ
         tBNyBBm/9FYWhlfUfvOPlt7HFeeT9FeanI2PvmKj2V4gNPb9kxMfbx5+kSVmTk/4yYXY
         nnrX9+C8XupZabjY08+KaRHQg6Ld4O4MK6QMHIUQCgvWYteF4sSLTQKpR1/Y8/efk2Kd
         X0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRDUg8+8nqYZCL8E3T3hEQgt8mIvAlc5XyK2YYXOLeRrjGuVcq5EwqpN6WHUw+c7vjMWFDtr+eH2wNCXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lnDfcDilTiqwhyqjUgi1KlmaCSQzskAPfK+Z3uViB5hE3LwP
	PIhemeXpnmsyn25uqMa+EYVw0iBf9YP1ExIkzt85b3zL9hDhNcgrSf28n3yGZg==
X-Gm-Gg: ASbGncsPa9z497SA9lPPIvVfgsbhRDY+JLzKNNSFGrYNDx3MdGf899arEdvvtdQcrni
	xo95SWakakwaOZgFd1Qg9UrNNgEsf7tExlOEZmDCJg6RWppUbv19vXoJ2G22XjeBiLHupjWb01n
	WWcmC4RuhL4RdQkDX4wXZ6QFRBaqPxw0uz8oIBDnAqEHbyQ1xc2JmnjjcWK953SycGI5ggIqCfm
	YXXAjIzbRzul3h2wTs06tZRAxP6lYsAuJfOuI9WA5YVOG2AmO95H8v513EhbAmIjAwIIwzGRniB
	1eo0gVZACPF4qxRNfB2OyYPyb62PP18n0skJXD22bMdONsw4z35oDTY2QMuJG3bv7Y1/0Sqz+FG
	9l2Wi
X-Google-Smtp-Source: AGHT+IH5+lAh4aDnKOfBgCart5GsF44/Ttw0+2rACrYtMiBk/Nmmsik0qBemWNe1gfOZHSa/eQkRBw==
X-Received: by 2002:a05:600c:47d1:b0:43b:bf3f:9664 with SMTP id 5b1f17b1804b1-43bbf3f96f9mr1090565e9.5.1740998096859;
        Mon, 03 Mar 2025 02:34:56 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbf2ed24asm41351505e9.23.2025.03.03.02.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:34:56 -0800 (PST)
Date: Mon, 3 Mar 2025 10:34:52 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] selftests/mm/uffd: Rename nr_cpus -> nr_threads
Message-ID: <Z8WFzISSAmtjtu3L@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
 <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com>
 <Z8V6xYvqqkPxULgN@google.com>
 <18ea9794-3901-4802-875c-b0327984a9d6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18ea9794-3901-4802-875c-b0327984a9d6@arm.com>

On Mon, Mar 03, 2025 at 03:48:38PM +0530, Dev Jain wrote:
> 
> 
> On 03/03/25 3:17 pm, Brendan Jackman wrote:
> > On Fri, Feb 28, 2025 at 11:06:35PM +0530, Dev Jain wrote:
> > > Taking a cursory look at the test, it creates three threads for each cpu.
> > > The bounding of the variable is fine but that being the reason to rename the
> > > variable is not making sense to me.
> > 
> > Hmm yeah the name needs to be more abstract. Do you think nr_workers
> > would be confusing? Or even just "parallelism" or nr_parallel? Or any
> > other ideas?
> > 
> > FWIW I briefly looked at just cleaning this up to remove the global
> > variable but that's a bigger time investment than I can afford here I
> > think. (The local variable in stress() would still need a better name
> > anyway).
> > 
> > Thanks for the review BTW!
> 
> Your welcome.
> 
> I personally prefer leaving it as is; unless someone comes up and completely
> cleans up the structure, let us save our collective brain cycles for more
> meaningful battles than renaming variables :)

Hmm, I think that's a false economy on brain cycles. A variable called
nr_cpus that isn't a number of CPUs is bound to waste a bunch of
mental energy at some point in the future.

Unless you strongly object I'll go for nr_parallel. It's not a great
name but, well... I think that probably just suggests it's not a great
variable, and I don't have time to fix that.

