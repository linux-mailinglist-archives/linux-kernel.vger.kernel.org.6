Return-Path: <linux-kernel+bounces-355916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9669958DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD02820EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29D21264D;
	Tue,  8 Oct 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCJaTzfo"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAF58222
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421130; cv=none; b=J3L8bG2qc78uSBAy96h/ftN2eI1dfGMnqLc8br82PkNWZzvREzFmNLSKhAgRAptZgERqRTdzZHg0QnHQtXZs9dyJ1Kq86xUKTR9j8/2/uOobxI6LokoibGes5r/tlCxnwBOolZ7DULANBRxuPdenNZ20U+qfXXG0VjtncnwB5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421130; c=relaxed/simple;
	bh=4v/4rbgY+lMOZXshsITRS3EWgml8pCxVxcz7Rr/bs/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2Czs7HCDSfOQnkUOxcT8XQs902WFIJiMjYfJLXz1iMXtp2jtmRfT6OyJNIhPEqLowJGPX5TUNudBlcfT37k2TJdNfRA0HgpUlcLBFP1vepNK9NCPexstX79rI8Crwh/Py6up4vkS6GU4YdebjVCwS4CJ6zakI6Q1/PX1IHy5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCJaTzfo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c5b628b7cso53355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728421128; x=1729025928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8s2NR9TwHXt6LNMFYF0+KpCJ5x9+AuvXww7sZ0PTlM=;
        b=aCJaTzfoZDW3UFQv8rXd8RO2rICUH4kiQK+iOKyy1/cx7JvywFuvOpn5J+8NIboB5Q
         Anhee6QsN+nuECOmunvvbTGqsVwA+7OLML3z/oUc8OkVQePS6kZHDXzQv9jmY8cw2CNa
         Vr3Ms+0jtLAsC/C47ZXuqdVkSvjF3TqIrvTJINqaQALVrvX9IWY/a4f+v7RBFgw9q4N9
         m4R8YvvzM6nw4+XbZQ+GGNFncWHtEf3BlP+AK12AAaB+e/aU+BSqmCqKahgrklgIpds/
         LndLCvuYGEXrs2AH5e/sx+wll1PMHe83QGwsKxwG1ywUyZ6rzs2GvTZ4Duoy3CP8GAzS
         nG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728421128; x=1729025928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8s2NR9TwHXt6LNMFYF0+KpCJ5x9+AuvXww7sZ0PTlM=;
        b=FWNdKoqQUExPElarPiRdao/lf11pb5Yw1NsrQZZXwMruCw0fhopITcPPDNf4TziCfm
         YkZTEixxcHl/UY639p+LgPKwZXwDyKkj9kKHsX2u5XnMJJy8ThwgS8c2qr5+D5Ojw+Dy
         0L/EvVkHfS+fTomIsaq6GkeBSDn94vsVvD7Ss1djQwD+pTMOM70nHskcqX3q4Gj+i9Cd
         BaTt0BSuDZfmCcL4tnaBd0PgWY/S0OZUQ9FiQFNzofpWEGmSFeDuNhYdcm/mjj3iBWJ4
         YI3QbA5dEUteXE2q9c7BUzeIAFoj9HVcw4qQsa/HFH5220sdmcCEY2u4tA6nfQRus9yi
         DqYg==
X-Forwarded-Encrypted: i=1; AJvYcCX9sYMarDAUAAq9McDvReXzQof2ivP5rgE5NhlyhnI5C7h/dyjtSTWhKPDf+jHWv7KP1to5oYLaFONh7go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgthxNlgMAkjwHTBQzhyRGopTal9RZl7V/L37AtJghClCijO3
	kjMmr6PsSPumXqFPBHKiDVz0dn4il3tiE8hp+LYXYRRD1txdAsTw/p24+OQpHA==
X-Google-Smtp-Source: AGHT+IG5Zoos7dUp5jCd65Xyl++l553J5WhCJJvBZ1YOrY/N+jjV8Ss3AngJPatYxr9l5t5rxOOiqg==
X-Received: by 2002:a17:902:c412:b0:205:8121:e99a with SMTP id d9443c01a7336-20c62b65333mr786725ad.26.1728421128174;
        Tue, 08 Oct 2024 13:58:48 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm6562167b3a.6.2024.10.08.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:58:47 -0700 (PDT)
Date: Tue, 8 Oct 2024 20:58:44 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org,
	aliceryhl@google.com
Subject: Re: [PATCH] binder: use augmented rb-tree for faster descriptor
 lookup
Message-ID: <ZwWdBIu6j0lL2rbt@google.com>
References: <20240917030203.286-1-ebpqwerty472123@gmail.com>
 <ZuyQ8ECy0ypuOStg@google.com>
 <CAHQche-rZODDsxbf6b3uagLfM52YtcoUuaeW0NxXcPTFFNcsZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQche-rZODDsxbf6b3uagLfM52YtcoUuaeW0NxXcPTFFNcsZA@mail.gmail.com>

On Wed, Oct 02, 2024 at 08:24:34PM +0800, Shu Han wrote:
> Thanks for reply.

Ok, I'll have a look at your patch now.

> 
> Could you please let me know why this approach is not being used?

I honestly don't remember. It might have been that we required to expand
the 'struct binder_ref' size. This issue starts to be a problem when we
have thousands of references e.g. 30,000. Adding 4 bytes to each one of
them might not be worth it. But let me check...

> 
> I think it looks simple, with minimal modifications and
> better performance.

Yeah, I think it would look cleaner if we do a revert of the previous
patches though. This way we can remove the noise and see the actual
changes. I'll do this locally for now, no need to send a v2 just yet.

> 
> It is also suitable for possible future migration to XArray[1],
> as XArray is also a data structure with
> built-in ID allocation method(xa_alloc).
> 
> Link: https://lore.kernel.org/all/20231101-rust-binder-v1-0-08ba9197f637@google.com/
> [1]
> 
> Best regards.
> 
> Carlos Llamas <cmllamas@google.com> 于2024年9月20日周五 05:00写道：
> >
> > On Tue, Sep 17, 2024 at 11:02:03AM +0800, Shu Han wrote:
> > > The advantages of accelerating descriptor lookup were explained in the
> > > commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup").
> > > However, the time complexity of the bitmap is still O(n), and performance
> > > can still be slow when there are too many references. In addition,
> > > additional allocation/free calls are required.
> > > Since there is already an rb-tree with the key 'desc' on 'binder_proc', an
> > > augmented rb-tree with a subtree-size field can easily search for the
> > > smallest non-existent 'desc' in O(logn) time. This lookup can be merged
> > > with the subsequent rb-tree lookup for insertion, so there is no
> > > additional overhead except for maintaining the size field. And there is no
> > > need to maintain the fast path and slow path at the same time since this
> > > method is good enough for all cases.
> > > The core idea of this algorithm is to maintain the count of nodes whose
> > > descriptor is smaller than the current node, except the left subtree of
> > > the current node, when searching downwards from the root. To achieve this,
> > > simply add the size of the left subtree and the current node itself to the
> > > maintained value before moving to the right child. If the count of nodes
> > > whose descriptor is smaller than the current node (the sum of maintained
> > > value and the size of the left subtree of the current node) reaches the
> > > current node's descriptor, it means that there are no descriptors smaller
> > > than the current node waiting for allocation, so we should move to the
> > > right subtree. Otherwise, we should move to the left subtree.
> > > In order to be compatible with the behavior that only the context manager
> > > can be assigned by 0, an additional bool value is maintained on the proc
> > > to indicate whether there is a ref assigned as 0 and some adjustments to
> > > the search algorithm made.
> > > Another consideration is that as the descriptor allocation speed
> > > increases, integer overflow may become feasible.
> > >
> > > Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
> > > ---
> >
> > Thanks for you patch.
> >
> > I remeber discussing this exact approach with Alice sometime ago but I
> > don't recall why I decided not to go with it. I'll have a closer look
> > at your patch and will try to remember more details next week. Most
> > folks are currently at LPC right now.
> >
> > Cheers,
> > Carlos Llamas

Cheers,
Carlos Llamas

