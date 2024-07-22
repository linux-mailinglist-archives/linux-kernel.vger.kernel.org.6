Return-Path: <linux-kernel+bounces-259151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCEA9391EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09201C214C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8816E876;
	Mon, 22 Jul 2024 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFaE+JAO"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E052208E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662778; cv=none; b=ArzVfxWVaccbGo0pRT5MpXMRtM2wm7f6hOj7yCV139cNx1mDmSfwFEMxMRBvXcOFTYAh+jumsjHrcsVKBZ+CYSgD+Xu7XPYIHLReyGD/HWjRcD9xC8PqbioD3VjsPMBWV6S7fIF4U5RfWMEPvn8YYIhLWHMa8izznaQ+ZRC1hKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662778; c=relaxed/simple;
	bh=cNUxyeKWJXB1FAFRTRbyYKPpovAm6su4pu9T1vm7jkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RskG+DP2ARnKcyU0heQCFzc/wkcnkr2SQyhpzvzsEbWEMht/JnywS3q39lutXr9NFON+6SqTl5OWGiqFOV7yEbLNPM5J61b9bIa69Zt+iNy6rfHy98zA0k5Jn9obXIg6N6LPF/nA5G24aeAHEaj9fTGvoERLG2mZCifs59/ZCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFaE+JAO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70aec66c936so2353952b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721662776; x=1722267576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9R1qE2tM8fwmnWyD6BchbvAYi/GTU3Fr9X7luY5GehU=;
        b=tFaE+JAOkfgvDYqFbi5mJBNUlreWmGUbPuBPaGcviIzvwUYzlQctR898V/U3oF8UcG
         WiSIGNSJc+oEqcsrnAGJAuBTsXRTEBpTg6khUUbjjptddxAJe+xyv55IbT/1OLl3CckV
         G5iKEoQ4h7Lwg99dIrIZDzlx6YFY8vI6Wq5fY36/1lydyFUPejS3u6CzYdV3yTmGNyyu
         PtN3HApWYh+Mp+yOsXqs6uF2R2tKZbF6qx6QH8q+u/84t58P9QhNzTTs8CsgTd+JpzGz
         N7xOnURlJXsFvWYSQkOkRMxSlx3NJCZvzxQh1tJvc/d3tR1u72ChVMKeqD3lxi1VDEYJ
         MdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721662776; x=1722267576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9R1qE2tM8fwmnWyD6BchbvAYi/GTU3Fr9X7luY5GehU=;
        b=EHmbjXHLTpBVmnaH/+BkXW0SeQEt072Dvoc/P1hOPKG/4+jfs8zrAcjlbuPuFSmgDq
         /j5Y/i3RkJ1MgeaOXzC3Br1R5R70OIt0vsEQDXGWv4T1FogHBckK/pdrtw3i52wy2OmA
         eXVGPHhIzJWDhSYxqXqHxd+zPsgEmyE9/wNdQOwpUsbvHkLztPR5QCWVrF/YiG/j2jjg
         pvXGjtMVXvQvcrxkFMKwNrr31N+RZads0SlixFYGMCS5dOWLfi+5t8sxYDiRoZ8VAyI0
         wNHTtd+wbZHM5nb0NwHzT3ps8LVqnzte+mhIcKRjacrhWl96vhDMsFGwY3jWhFF9hhOH
         bhFA==
X-Forwarded-Encrypted: i=1; AJvYcCVgzU4NPT4nChmIuFE/Rm/P0lE9FxqqJp1NJRQJf/BPp/13CEMkB2xQUPmv539nxIep8xIj7N5lRPbXrR90shRbKxYo5yPTFV2B4mx5
X-Gm-Message-State: AOJu0YxwFV+s2S71ZhPSd/qHWZg4Mbjiy3NnbgJ9Ei5fyCVDWhU4okW+
	TKdPlX3vIrA2zAuTnbPSf+D+QtRLOrhiQlDIa5sXSQhDmbkaTjrX9miJ6dKzpQ==
X-Google-Smtp-Source: AGHT+IED4obCdFHeSA58xp77MyGtahX6dbeBPcDXk3YR6oCQtBWbIVPobSMxIjC4AH1psUO5TYtJkg==
X-Received: by 2002:a05:6a20:72aa:b0:1c0:f1cb:c4b1 with SMTP id adf61e73a8af0-1c44f84c1d0mr41341637.13.1721662775799;
        Mon, 22 Jul 2024 08:39:35 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a3dee1csm4752900a12.14.2024.07.22.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:39:33 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:39:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
Message-ID: <Zp59Mh6MGUtJOcIB@google.com>
References: <000000000000601513061d51ea72@google.com>
 <20240716042856.871184-1-cmllamas@google.com>
 <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
 <CAH5fLgjP2uOJRKCpFrwGn7X3Gw=r=wCibejp59JhupDX+QA5fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjP2uOJRKCpFrwGn7X3Gw=r=wCibejp59JhupDX+QA5fg@mail.gmail.com>

On Mon, Jul 22, 2024 at 12:57:31PM +0200, Alice Ryhl wrote:
> On Tue, Jul 16, 2024 at 7:40 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > On Mon, Jul 15, 2024 at 9:29 PM Carlos Llamas <cmllamas@google.com> wrote:
> > >         /* 0 is reserved for the context manager */
> > > -       if (node == proc->context->binder_context_mgr_node) {
> > > -               *desc = 0;
> > > -               return 0;
> > > -       }
> > > +       offset = (node == proc->context->binder_context_mgr_node) ? 0 : 1;
> >
> > If context manager doesn't need to be bit 0 anymore, then why do we
> > bother to prefer bit 0? Does it matter?
> >
> > It would simplify the code below if the offset is always 0 since you
> > wouldn't need an offset at all.
> 
> Userspace assumes that sending a message to handle 0 means that the
> current context manager receives it. If we assign anything that is not
> the context manager to bit 0, then libbinder will send ctxmgr messages
> to random other processes. I don't think libbinder handles the case
> where context manager is restarted well at all. Most likely, if we hit
> this condition in real life, processes that had a non-zero refcount to
> the context manager will lose the ability to interact with ctxmgr
> until they are restarted.

Using handle 0 for transaction will always reach the current context
manager. This is hardcoded so it works regardless of the descriptor
assigned to any references.

Things get complicated when doing refcount operations though. It seems
that some commands will reach the new context manager and others will
reach the old dead node. Odd.

This needs to the fixed. I'll look into it.

> 
> I think this patch just needs to make sure that this scenario doesn't
> lead to a UAF in the kernel. Ensuring that userspace handles it
> gracefully is another matter.
> 

Right, the main concern in this patch is handling the BUG() assert.

Thanks,
--
Carlos Llamas

