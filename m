Return-Path: <linux-kernel+bounces-217758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319890B3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D228986C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144AD15B96C;
	Mon, 17 Jun 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATXhP6xm"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12C15B967
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635195; cv=none; b=iosPIBfirJBtLAaM1svVri0UfeiXUmh6u4ZDjVq2H4idpdfTHMy5DuYKcnWqVVS+M9D7Yw7Q7R/p+aLTtbV1g90iTmm5CxiR8aN4JZSLapsjMcHbukjZM/iw7DXZd0qHu3cAzlK4X2ZtgIelodTy4Lvl79hJjvBGWmjYSadcM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635195; c=relaxed/simple;
	bh=P80Zpu9tv1bMMBDh+ONi23eSh4o+SJsPhThAatrGgAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Btl2BnH4r3KC/6juinfyd+j3wiUSg7HWBow/V/AlFcp3NUENAFMW+s/bxKmi9Dr30pavAs7gzZpGTX8b5iPTjpWBF/+hZvZwqJZ4eTBomZYWep2I2hR1kAyycN7EcSYBq5c5/j8ZNJ6KB5raMxLZHm6DbT+jEPouQHJT94HEzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATXhP6xm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff16daff8dso6081976276.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718635193; x=1719239993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHyuZMITfnIkev2GvBkEnYE0p556d103ol755fiJd7Q=;
        b=ATXhP6xmmbOtB5bZgLEaYTrkmhoWJSYwiNH0L3VLmxolH8OSjOx/HEoWolgkdrsOYo
         waYljQegp1fJBADhvTePc9WSyYLlNiCtkj7rO8hLoiiTPZQv7cdHtYQXF8cV24vhC36p
         lc/Go67rXYZze3/PFDKktsQB3JoWUHCac8sW5bCNRsWjuu1BNeMKoLVf2d9ih08Z8L38
         8ZyJJEOSoaSbk3HrMXaTnWYiaetS97TmXLv69gT6HWPi71Sat6WQ51tZD/FWJIRSYeVg
         5mx20GNaySvSwjeskLEKgZv0d45+hUUXoFJVHR8ZJpCUB57U2duk3h3nE/HfcPE5ha1p
         pfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635193; x=1719239993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHyuZMITfnIkev2GvBkEnYE0p556d103ol755fiJd7Q=;
        b=ID5cDfs0OV6MT3w20y9f+JbV0DyXXYuidxYzB89pHi6iIRWb7ohhzF1Vzb5O5DeGq4
         CIjzQbBjP7LLU9jYSMfdnPfgVPIr6opIFiPanCH03valX9DPWqPzabErDYoOy2S/XxKd
         3RTRwT6OlpVf8LrpX0Qu8LHfV45jQ0kxTf6BVFy6ti7Pfq55Yuadg1JJ14IBylkHjy4R
         tF4YjUuuZiwsyklTR1yM5DB8yI670ThuDBpk/gLWf6HJlplqAQSveS5rR0JkfnbolZli
         sf7+9KnmcrYZpW8C2y4AJTRWbbRe/KpEWDmWgdCaEoa19j7lrBb5UThzaa2T/iEXGWRE
         Y74g==
X-Forwarded-Encrypted: i=1; AJvYcCUwgtgffA8HnDi3KPDhrKfCfhNwGwqFsKA9JR2vZ/93bWZegQx3gAdbxijF9q01sUPG1wRUwrEeepaOK2cT8ip+alyEZdJ2RjyaRGRD
X-Gm-Message-State: AOJu0YzkCtel8tHivKaueH0KTErWvCxiLyMaNYuXSiR4BmouPzLVhfnR
	qwM9SYz8eM6MC7O206zRBmXn1Bp/W7ZzFKzLWRCmhdk6GO9R1FOUvO604ilMrfbl8nFPTudEEZr
	QAA==
X-Google-Smtp-Source: AGHT+IGRkKuEbgZAbZlwQNI71faOZATSKDWCbKCMCbXhO0niCQ7K0aLbEl6u7tzApvz62D/KMq/FQjTcEF4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:f88:b0:dfb:1c1c:abf9 with SMTP id
 3f1490d57ef6-dff1534bb30mr3070719276.2.1718635193015; Mon, 17 Jun 2024
 07:39:53 -0700 (PDT)
Date: Mon, 17 Jun 2024 07:39:51 -0700
In-Reply-To: <20240615080902.GAZm1MHvXQ30rm1Nnk@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202406141648.jO9qNGLa-lkp@intel.com> <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
 <ZmxjOxhPy67QOh5Q@google.com> <20240615080902.GAZm1MHvXQ30rm1Nnk@fat_crate.local>
Message-ID: <ZnBKtwvvKXXK2b2u@google.com>
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning:
 objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Jun 15, 2024, Borislav Petkov wrote:
> On Fri, Jun 14, 2024 at 08:35:23AM -0700, Sean Christopherson wrote:
> > > I know Sean had a patchset to cleanup that gunk. Sean?
> > 
> > That series was just for the actual VM-Enter/VM-Exit path. 
> 
> Right, about that. I still see:
> 
> vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0xb0: call to sev_es_host_save_area() leaves .noinstr.text section
> vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0xbf: call to sev_es_host_save_area.isra.0() leaves .noinstr.text section
> 
> in allyesconfig builds....

Gah, sev_es_host_save_area() needs to be tagged __always_inline.

