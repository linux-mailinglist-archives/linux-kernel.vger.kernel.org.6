Return-Path: <linux-kernel+bounces-422899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA69D9FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B2AB24BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F381DEFC0;
	Tue, 26 Nov 2024 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIZ3JY/t"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793F17591
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732663969; cv=none; b=U9u4J/DDDjorC68o8uqdUDoHMhO43Jkj4RVd5mY95iajFAwfa8FHn81b65qO2DWFxrtEGsX5K94H9bS2e0UFk+lMugHpn1OpO6H4Es3hOQijCQKp9/q59k75DJDBpsCa6aTX8IPnhb+eOUHxgUNA6/E+kh0bKqMxXPf9DoEMYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732663969; c=relaxed/simple;
	bh=52Hw7NVp0OhNbuO4SkYXQGlMQ5mipRS5Xu8EpjXLGv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSwv1VRTx5pXngWt+cqfsfacotgv3n75sP5lC7IgpvY+ZZ0y/3fXbNB+INpBckQlOa9kK/uoAMkPgt4rakpNypVJ1wb2ZUn1wwm7EczDKFyAch8o9UsnaAtu07mixzEuSJhbKSWtiyLVwL2+uE8a8TrfrALg++ke9PZCr3ume/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIZ3JY/t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21238b669c5so25415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732663967; x=1733268767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBuN4pc3kBxz6CeyJjUu3j9V80400Pd2xFtut8NX8mk=;
        b=pIZ3JY/td521IXzzintQwCSzS3deg7vj+bwsC8G05NRxlOtPmJxE03/ID5NSTuxfLE
         PI7/0Q0rFO0eYsje54j59Z8Q11XAhMvq0z9IqHu05AGiomY/kye+2Pce8cWl8ilaPrVH
         ttlJkqrlEXnfBF/jWGq052O4gI9ubKrXCRk6JBJQxuIU+iyb+mpPkw5R3oJ3rHuAeNVb
         b0AkBAgn7QRdfx6YF+AORU4QXZjhAITYZWOYx6t9RN90Xa+VTbPNYaLQkdQq4UsNsxV4
         589wb6Yvi9ElFGBSxY8+KyppIBeHC+A4s4JxajqjjaVTYf/zcDnag7vRk1UH+hRqhTeQ
         3HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732663967; x=1733268767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBuN4pc3kBxz6CeyJjUu3j9V80400Pd2xFtut8NX8mk=;
        b=krO0jVVvwH81aYPrYGgQxFn4PnJ4QHreYp2ZDgwCiDuIxjdl7c3ecmwJDTVFuo7rgI
         hvibuKJeJLhEJZre94c0myz6JSftgKcWCdNoIRpVxlZuruFIe2K9fdYLlsI8haRZJ1lF
         CXWI8e1FyUaNPhCb+IUu6FOaHnO+9KhQpy3/o+/hha7RuxdKx2wwXuUZ0bT8ZJDPDDZp
         mCVLvBIfhdV5TZkmd8V3KGtxY5W+OQB+QnGtTZ3egdvVe7bNb0NToJAWmOAMpFk2qPqm
         dR/mxmnEspGYF06YYl0FQiDcjfYPCg8qP4UGdHIiTjqHvO991Su3a+Nh5cCVDdYMnTit
         11Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVZobeee8qzdZHrxxARDHmqN5Dbf8AaPXn19gyGbAgVhyitErHwGtOLNhgqGpa1gk1ZJ/mcWDqJkrqAslY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9LnfjptFXVOJQSVZ52k8hhI2UVUe1PI+pdMaT7jZPcG8/gkZ
	XDYL28+/hiWBNk5OWW48QIbpu2AV6dIG2hKSO/wKaPYlLWWLGHDqxQSTLNssIA==
X-Gm-Gg: ASbGnctUEGDDvYzYnBEKs67o/OuwJfn9ZQJeb1qnNVTBMPybfxTn8Lq+BS9HPx9vjB6
	c0uUarWoDgHVkgb5ilAbw8hh3xM7b/giUukumKHLD8kJPh2wl1lLyhm170IkqNeP26WjJr8aUtv
	fzm+qJXQLjMVmq1SMXYF8r3gojSF6Ct5dTxO2vtDlKLRrkg0AdRPdU58r2ZIYmvSKE2TPHk36gY
	TOZPQuGEuXTxXO/9Af3mXpFIgoNf7Ckm/Qtjth66xAmaLBU/+FK8+K1CpSe7zLqvpblRRSKHe0d
	UkRcKuxnQC4M
X-Google-Smtp-Source: AGHT+IGEmBffF8JgkwMIds+GZopWSd4/eA2aGB4obk+ZGs6O/BnaKvw5XB8kDxDSAWJruElRiDiVag==
X-Received: by 2002:a17:902:f605:b0:206:9e8f:7cb with SMTP id d9443c01a7336-215022c0ccamr869955ad.2.1732663966638;
        Tue, 26 Nov 2024 15:32:46 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfee87sm90848815ad.149.2024.11.26.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 15:32:46 -0800 (PST)
Date: Tue, 26 Nov 2024 23:32:42 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v5 9/9] binder: use per-vma lock in page reclaiming
Message-ID: <Z0ZamgSUxuuae0KP@google.com>
References: <20241126184021.45292-1-cmllamas@google.com>
 <20241126184021.45292-10-cmllamas@google.com>
 <CAJuCfpH+B1HrzXtM_3+H9m8NPkTzAX8S4oSwhTEW+07g9JceeQ@mail.gmail.com>
 <CAJuCfpHdYPf-WgheBSCK6Md1WakEy_XCiPrw6xTFmPHr7TgnqA@mail.gmail.com>
 <Z0YdXqS-rARwYI5L@google.com>
 <CAJuCfpFZ3L-OvZEdhCipx17=A9yMFNWfuaWVN-BDrbXjce=v-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFZ3L-OvZEdhCipx17=A9yMFNWfuaWVN-BDrbXjce=v-w@mail.gmail.com>

On Tue, Nov 26, 2024 at 12:05:58PM -0800, Suren Baghdasaryan wrote:
> On Tue, Nov 26, 2024 at 11:11 AM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Tue, Nov 26, 2024 at 10:46:03AM -0800, Suren Baghdasaryan wrote:
> > > On Tue, Nov 26, 2024 at 10:45 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > You did add a clarifying comment I asked for in
> > > > https://lore.kernel.org/all/CAJuCfpESdY4L_sSwiCYVCX+5y1WOuAjLNPw35pEGzTSyoHFYPA@mail.gmail.com/
> > >
> > > s/did/did not
> >
> > Oh, I added the comment to patch 5/9 since it fits better there (sorry
> > that I forgot to mention this). Now the kerneldoc section reads:
> >
> > + * @mapped:             whether the vm area is mapped, each binder instance is
> > + *                      allowed a single mapping throughout its lifetime
> >
> > ... and the vma check now has the following comment:
> >
> > +       /* ensure the vma corresponds to the binder mapping */
> 
> I think the above comment does not explain the race we are trying to avoid here.
> Something like this perhaps:
> /*
>  * binder does not allow mapping of the same buffer more than once, therefore
>  * alloc->vm_start could not have changed since the buffer can't be remapped.
>  * Checking binder_alloc_is_mapped() ensures that the vma is mapped and still
>  * covers the same area.
>  */

Right, that is the message I tried to convey: (1) Each binder instance
is allowed a single mapping throughout its lifetime (no re-mapping).
(2) alloc->mapped gets cleared when this mapping is removed e.g. during
vm_ops->close(). Putting 1 and 2 together... whenever binder looks up a
vma it also checks alloc->mapped to verify its mapping is still opened
and avoid poking into some other unrelated vma.

I tried writing a concise explanation but I guess it was not enough.

Note this unusual behavior is nothing new in binder and predates this
patchset, but I agree it needs to be documented somewhere. I'll send out
a new version attempting to document this better. It's a little tricky
though, since the same vma validation pattern is in multiple places and
obviously I don't want to duplicate the paragraph everywhere.

Maybe I can inline a "binder_vma_check()" and put the explanation there.
I'll think of something.

Cheers,
Carlos Llamas

