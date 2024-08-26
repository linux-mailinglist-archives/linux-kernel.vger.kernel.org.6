Return-Path: <linux-kernel+bounces-301904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7566D95F729
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86251C2181A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D58197A7E;
	Mon, 26 Aug 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ReH+1kMB"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74117C9BE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691119; cv=none; b=uIV7v1hNScj48wYb5WClVudlnVMp0/cADGp18+yUghfFe17i1eVnZDFIijSu5S9OL7IUpSYNJqVq4gvWnUfYHFEFifXo6YdWbJjN9BAnnFHBfSFVjnSz3tiPtG3I+bIHJ46fVjjIqjCF4TM8tPVns6lP+fDlT476251JSqkjzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691119; c=relaxed/simple;
	bh=+L4oNHMCNWpuHYOaMMKItyPNozrAbfcW8AOsRv3DNvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV4/whpW5als9i5qjxpc8aAp8gH95FjBCqvq0YWoOaX7Bzn4Bv74ChbtmizfR6QtutXss42ZaYfI5d/WLTG+zOvzwtc0iFr1zf/sKf6ni/QYkXiX275kblvMFYTZVDfb9Qzr3hUWH+i2zCOEOMqlBV2Zp1sxvyIGkwJ3sVa5qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ReH+1kMB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5becdf7d36aso5100305a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724691116; x=1725295916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGTcWYcxKa7/MM+pYx91vIxpflLbKrK+tQNtIyIYCsw=;
        b=ReH+1kMBGLMwUaoYhCeOJgw9epKNiCjltcpXXw4YFoRGCyoXPe87LnlUvuFS19U7BW
         VQTcHLfvymEygRRjLKV2VzZexMfBCOzQMoUw1eP+HT8nYcJJU9KaINjH/4NlNL3kHNrn
         hVnQ6A0IJZ3BXm3dq4Z0ztImV6BGgXIuZNz2QbVhfxf28TwjwHjyxPVIuNME3cuqIDwm
         S5cZR2KXKeq868JZc62wVVnZ0xdaSpsKWdm8YIEAOyoy1Rtm3eu2qm3Cx794v/Ka+bvt
         8CziOvolrHjMqZ0/F5udWbz8HqS5TmXuw+9LPkutjVYkmMD6wRrzUIYfLl77fnUGbxH+
         61Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691116; x=1725295916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGTcWYcxKa7/MM+pYx91vIxpflLbKrK+tQNtIyIYCsw=;
        b=copNk125hVaaKuzkEW6usvbvlySpcPH2EnzB1QIR/4mD8ni3+u5HaWXqlt+tABGs13
         HwPJePM7Wcp7rwiTq3uoe6O/eT5nryIfODdDgU1XCVRIW2MsleabVnIqRnBSNxawewN6
         pOyssHD9keGHwhtpNXdEgIz2OL9dq9GWuAm9W3GOf28rbKknUuXWhv/jKJdIpY4eHZMZ
         3lSS3BXDZXPyI5GfcXiUEFtwu6NPjaxuN1DxapZDX/USbv0z8DcRTizgjFoIuScRqocS
         0CHSK16R2TmYK4VzGjmok+ejAP8sDRUXPIlSk6qNfuxES416fDMWUxsqM2hpXVLMssjk
         B7lg==
X-Forwarded-Encrypted: i=1; AJvYcCWLQ/lWVJNRDmwNuJAvsUdZJGXrKUjwrzArGfEcjcbj22NbrPFPE805s7fvDIDxC7lReBEw6qaXHcU66eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+gDCxSI4sHDP80D3JYKK6EOjCpm6MthDUNUDuXqAZ7FQstm0
	acb2OtRjBs9lZl/ESdWIjYUwWH9cNffm8aCGNvwmmxvGQ35eA/cUGtvN8ZYWaow=
X-Google-Smtp-Source: AGHT+IGad1dbexVhTpYCO13uCMg2SLCPwC55Yto2UhY1VO9tgHVcIhFpdgXzbXOnyKLfVkpECVPV8Q==
X-Received: by 2002:a05:6402:1e89:b0:5be:db8a:7f5e with SMTP id 4fb4d7f45d1cf-5c0891abb09mr7263514a12.37.1724691116442;
        Mon, 26 Aug 2024 09:51:56 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cb04csm5819961a12.31.2024.08.26.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:51:56 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:51:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <ZsyyqxSv3-IbaAAO@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
 <ZsyKQSesqc5rDFmg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyKQSesqc5rDFmg@casper.infradead.org>

On Mon 26-08-24 14:59:29, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 10:47:13AM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > There is no existing user of the flag and the flag is dangerous because
> > a nested allocation context can use GFP_NOFAIL which could cause
> > unexpected failure. Such a code would be hard to maintain because it
> > could be deeper in the call chain.
> > 
> > PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> > that such a allocation contex is inherently unsafe if the context
> > doesn't fully control all allocations called from this context.
> 
> Wouldn't a straight-up revert of eab0af905bfc be cleaner?  Or is there
> a reason to keep PF_MEMALLOC_NOWARN?

I wanted to make it PF_MEMALLOC_NORECLAIM specific. I do not have a
strong case against PF_MEMALLOC_NOWARN TBH. It is a hack because the
scope is claiming something about all allocations within the scope
without necessarily knowing all of them (including potential future
changes). But NOWARN is not really harmful so I do not care strongly.

If a plan revert is preferably, I will go with it.
-- 
Michal Hocko
SUSE Labs

