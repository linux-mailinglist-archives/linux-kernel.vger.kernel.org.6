Return-Path: <linux-kernel+bounces-406166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE389C5BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10722822A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4D200CAA;
	Tue, 12 Nov 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmPomylr"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD31FF034
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424536; cv=none; b=E3evqLffS32GrGjZUjOgWuDh6Ga+W6aTWJFPLaVg4dXTTjzF1xvjYxMliyxUvEAyQF17dSZGASh++NnINad09BfrgtQEI2XoBMH0DxJEEJezKQ6IfvTNHh/6R8tf2+0dRMfnHAW/RdoKpKBm1b7mKjWqrrwYHOEK6PmAdNfRm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424536; c=relaxed/simple;
	bh=Bo3ao9aViUcA4ruZtCyRLPX+CTCLhQ+G+urhKISG53k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVvCRLiN1J92qW2TBkNxMWTNlP9x/XwE3KW/PjnQjLSVDPPtAxCy7q91sC7enUp2YvdxHZ1xuMpEiaOmSDFwq8ToXtCn0m8365Nk0JeT78GBiouA6+FJ1st/aBxAJr0VPES2r6PKmmucE4ScA3jeWDpEh3nBgkxLJ4uHBx926ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fmPomylr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca4877690so153795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731424534; x=1732029334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/7Hb1zXDXmZHIRmmdfCwjhUwkg8KKPMI1LS36ri7m4=;
        b=fmPomylrZHUivlWRm0t2h6noiRetR1GoHgXyfVwLnrC9VJ2YGGsX7NuEKjnDXH/K1F
         vR2hpU0q3riDB5O1gvVNH7z6BQ9xVADKGLHnkHIx/7LlP8GuNH7CMmO1eQgH76ea9sum
         MjXiBbxKRS6bWxQTLXTWXiMzv0GvdMYqNIzDBLWh7iLoy1YLyLdEymvNvl6SraXuqrtJ
         skBJxGNhN2Cop3n7khf7qg5pPglvHSBqZGCaQVI5boP0HY6gFDrKJDRMUspwxV00sCpy
         B9q8VK5ggxJ1HDpO0C+63XKHi3O3Ip8jS//xhSDQIR3linou4Ti50lNOvlV8UHYkjSfZ
         X95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424534; x=1732029334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/7Hb1zXDXmZHIRmmdfCwjhUwkg8KKPMI1LS36ri7m4=;
        b=hE1bvhAMdbLRrksGhP0WixOHk3esjYXfwlwYxyZ5fyFZ8oMgh4lU4zKYH6/cyv74mI
         Ti/rWneSPSNxn8s4as3qXUcV0KYl+xkIvvglZizEhUzc1hVgXj5XCDgew8HI1uKVQ2xC
         Dx1CG7Y1dqNmzXCiGnsZS+T+NP4UTwC7oLKD7/wG4ScTcCaPu3xEyJYAKZHJ9Iy3alIG
         X6BRyVP5lI+dLpV4RaAdL17cFMUnFyC4Jbnv/5qbWJBXNTJiMp6A2oe7UuQ7Z9k0Hg4d
         Iz8AM3jAhsBmlNsAPamdE76aLiSuFTqqQrjnztosQlIgDYtqflSySnABAmMXMs+tJYvw
         XlSg==
X-Forwarded-Encrypted: i=1; AJvYcCUU4OowjDye4uFq52Tn9DQ0Etlbj1R34hzxaVYCiRq/nbEV4aCqZOxJ2sbMdNZb2wyxS5hIRriJeBCwJuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXIByz+Ejo3SbedbByznPCZZM3wjEeTrPinKwxStZyiROPCYk
	p76haCBK2P53Tkzb3RGfpwC2UbcUDtIuyaEtdX/Lzsag0pQnC/iXMCHPUfRn8Q==
X-Gm-Gg: ASbGncsy3uqpPOAr0MvZ/Sn3AlxSxF8+5XOkan3jeT4OpBr0WqKpc8RAWhq5Gq9GCj8
	mV6Xu9MIbtKAJqmAURki17UqDG4FJVN9vQ355c1xs6+MzxGUFKjzF/VTfET6Rhgpc0iQbmMh81e
	vDYYhCA6P0P1ZaPCL0eL8/U2ReKx4s4qZffzjFqUpoui1a9lbRiHqxvVAxuPfdpnenGuyXtiw9/
	oI9qeq4cDEaVpa5xqhVww95U5PHm9IySGhVdC577bSKuDXnHwcIuGiBT1YhNYCmDvEhwh7mQwKK
	1BiPt1lnAMYdsNc=
X-Google-Smtp-Source: AGHT+IFFZ8qcqGz3mupCGP5fO5w1IcB7Knmjvr4nS/zA6WPO9ViBUKgk6ZCMK9Ym0wxoAQn89afaKQ==
X-Received: by 2002:a17:902:e741:b0:20c:5cb1:de07 with SMTP id d9443c01a7336-211aceb679fmr2067895ad.11.1731424534195;
        Tue, 12 Nov 2024 07:15:34 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5a7dfsm92829195ad.205.2024.11.12.07.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:15:33 -0800 (PST)
Date: Tue, 12 Nov 2024 15:15:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Barry Song <v-songbaohua@oppo.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v3 2/8] binder: concurrent page installation
Message-ID: <ZzNxEsF2HjQzI0ak@google.com>
References: <20241108191057.3288442-1-cmllamas@google.com>
 <20241108191057.3288442-3-cmllamas@google.com>
 <b0949317-9be5-49e4-9390-2ff1ca1b1ed9@redhat.com>
 <ZzNpe34A7Q4pTrpj@google.com>
 <4eac810c-60e5-409d-a4a3-452461ace9bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eac810c-60e5-409d-a4a3-452461ace9bb@redhat.com>

On Tue, Nov 12, 2024 at 03:53:51PM +0100, David Hildenbrand wrote:
> On 12.11.24 15:43, Carlos Llamas wrote:
> > On Tue, Nov 12, 2024 at 12:10:20PM +0100, David Hildenbrand wrote:
> > > On 08.11.24 20:10, Carlos Llamas wrote:
> > > > +	ret = vm_insert_page(vma, addr, page);
> > > > +	switch (ret) {
> > > > +	case -EBUSY:
> > > > +		/*
> > > > +		 * EBUSY is ok. Someone installed the pte first but the
> > > > +		 * lru_page->page_ptr has not been updated yet. Discard
> > > > +		 * our page and look up the one already installed.
> > > > +		 */
> > > > +		ret = 0;
> > > > +		__free_page(page);
> > > > +		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
> > > 
> > > This will trigger a page fault if we don't find what we expect (are races
> > > with e.g., MADV_DONTNEED possible?), is that really desired or not a
> > > problem?
> > 
> > This is fine. As of now, binder blocks its page faults:
> > 
> > 	static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
> > 	{
> > 		return VM_FAULT_SIGBUS;
> > 	}
> > 
> > If we race with something like MADV_DONTNEED then we would just
> > propagate the -EFAULT error. I could add FOLL_NOFAULT to the gup remote
> > call to make it evident we don't care though.
> 
> Might make it clearer ... or at least adding a comment how this is supposed
> to work. :)

Sounds good. I'll add both FOLL_NOFAULT flag and a comment for v4.

Cheers,
Carlos Llamas

