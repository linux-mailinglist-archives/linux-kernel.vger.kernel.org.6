Return-Path: <linux-kernel+bounces-368922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B949A169A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9CE1C21A81
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56610F1;
	Thu, 17 Oct 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gX9R9ONQ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7423A0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123942; cv=none; b=cBOIq8wRGMevg+tHobneb+IzH77kIVEvbm1ncCtxku+caxLnjp3DO/vulaml5OCZDzrYwoFqtgviSBzb8Uo1KCU2vjdKzvfbbN5snJ3f55SdngvjGQQzoEQUXgDmu/158NR0IFLP6XtKpQlLLEVakLnzFlDNa4UVPLuDWavI40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123942; c=relaxed/simple;
	bh=rXOGyq/1p7N/WCfxOpv9Jkww8mtKP+qTaUR1eAOonTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv8M0LkLCJIh0FB8IhGAqtJu447CP9N0XhKkUFwC4uLrfE1E80etfHeaKeqPaHfY3ryVeW7yVwPcKex/Zp8Kp+jkQCgNnNPcMw955FpEnmUfGxaBZUW3fHI9axSzZSnshN62A7coqT2GTT+5im/RlTcK8fJLBfyWKth1JJBB0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gX9R9ONQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca4877690so43755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729123941; x=1729728741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TL+tpR2KEjbKJtOR5h/M5W4hpSWdtqpprLy0k1y45kU=;
        b=gX9R9ONQ33Po2Y8qEHfbYgWnzC9cPytoyFHA64JKRR0uGLJqCP7UI1treiX9R3WEYX
         AZ5Y5gxKk8xgoKI+pruXiYA5LUWPzbsC/mhorqGgy56yTy4uZ9c+o9HQ9tkHAGFCpR8h
         lyw6GrfvY32WEm/xcz+qUxq4lNigqh+/OBeAIzKMatiK+pjACJH4mCbrrwKCtYN6VPEW
         s2TPzJS9e+/1PYbs/ezIDvzRuyZylXE0/qiSMPr7NJvBcnbJrKYx6une4BrFDtY/Asj1
         m67UfEN7XXfCzcADuHh4IRrfuQO4L90Fsz2m6205FD8sdvnyydrVx+t1/7ioqepGRnq+
         UA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729123941; x=1729728741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL+tpR2KEjbKJtOR5h/M5W4hpSWdtqpprLy0k1y45kU=;
        b=RxCCq0ohxJNDNscPcTLU6qYksOO0/zFYndVR1Qc7JTEOWFZcGhuUwEfxAXtt0wcH7/
         OyOVdU4Q+YTMCnhk+6IOlclbVX5lupPLAzwQokFIFqe5Hgzjs4ExKQgeLuUqJh2rSfH4
         TCPSZ0ccVqPBlAvdPQvR/e6GjPWolv78tjkg73alflSTj+CPIN3IPNbdkP4wpy1ZkdZ9
         A0AqpsEeFVsEldSHFeAKa1dS027VlEowaHR+BL2l6w78r9FAyIP3lno2tk7e2SZ6bplb
         Q7riau15eA/RuTPXr4clL/gyNgWrtJDqffNODlKwv4xMubbUrtRDTo6i004Ba05KU3mA
         NsnA==
X-Forwarded-Encrypted: i=1; AJvYcCU2R5FyP2rYdTAr4OPkptBjep/5qNvjU1ebARkBCv8kJy36waajugla5pH+WuY5VRd8DwSIkpwqXvPDr0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvFvtiRhdswQX4Tdr1/KTe0jmQYS8Qf73NVD7yMUuAmdT4hjO
	rXT0i6cvp4v+0ZJCo0Dvfqx1Ql+bZxPjRVfZpx1QRPat1f/cMvgixKuLQO5BdA==
X-Google-Smtp-Source: AGHT+IEVF62am/fpzifyA7E1Kq7kvKn+4+AFiJAFM7ag19Zp34g5JsvIR6nN2HVSXydqE47G1k3+CA==
X-Received: by 2002:a17:903:2308:b0:1ff:3b0f:d61d with SMTP id d9443c01a7336-20d496410e2mr1326015ad.24.1729123940423;
        Wed, 16 Oct 2024 17:12:20 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d8c6sm34228495ad.72.2024.10.16.17.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:12:19 -0700 (PDT)
Date: Thu, 17 Oct 2024 00:12:16 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Will Deacon <will@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH] Revert "scripts/faddr2line: Check only two symbols when
 calculating symbol size"
Message-ID: <ZxBWYJpAnYVrjHx3@google.com>
References: <20240812230121.2658059-1-cmllamas@google.com>
 <20240816125046.GA24389@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816125046.GA24389@willie-the-truck>

On Fri, Aug 16, 2024 at 01:50:46PM +0100, Will Deacon wrote:
> On Mon, Aug 12, 2024 at 11:01:20PM +0000, Carlos Llamas wrote:
> > This reverts commit c02904f05ff805d6c0631634d5751ebd338f75ec.
> > 
> > Such commit assumed that only two symbols are relevant for the symbol
> > size calculation. However, this can lead to an incorrect symbol size
> > calculation when there are mapping symbols emitted by readelf.
> > 
> > For instance, when feeding 'update_irq_load_avg+0x1c/0x1c4', faddr2line
> > might need to processes the following readelf lines:
> > 
> >  784284: ffffffc0081cca30   428 FUNC    GLOBAL DEFAULT     2 update_irq_load_avg
> >   87319: ffffffc0081ccb0c     0 NOTYPE  LOCAL  DEFAULT     2 $x.62522
> >   87321: ffffffc0081ccbdc     0 NOTYPE  LOCAL  DEFAULT     2 $x.62524
> >   87323: ffffffc0081ccbe0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62526
> >   87325: ffffffc0081ccbe4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62528
> >   87327: ffffffc0081ccbe8     0 NOTYPE  LOCAL  DEFAULT     2 $x.62530
> >   87329: ffffffc0081ccbec     0 NOTYPE  LOCAL  DEFAULT     2 $x.62532
> >   87331: ffffffc0081ccbf0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62534
> >   87332: ffffffc0081ccbf4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62535
> >  783403: ffffffc0081ccbf4   424 FUNC    GLOBAL DEFAULT     2 sched_pelt_multiplier
> > 
> > The symbol size of 'update_irq_load_avg' should be calculated with the
> > address of 'sched_pelt_multiplier', after skipping the mapping symbols
> > seen in between. However, the offending commit cuts the list short and
> > faddr2line incorrectly assumes 'update_irq_load_avg' is the last symbol
> > in the section, resulting in:
> > 
> >   $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
> >   skipping update_irq_load_avg address at 0xffffffc0081cca4c due to size mismatch (0x1c4 != 0x3ff9a59988)
> >   no match for update_irq_load_avg+0x1c/0x1c4
> > 
> > After reverting the commit the issue is resolved:
> > 
> >   $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
> >   update_irq_load_avg+0x1c/0x1c4:
> >   cpu_of at kernel/sched/sched.h:1109
> >   (inlined by) update_irq_load_avg at kernel/sched/pelt.c:481
> > 
> > Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  scripts/faddr2line | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I'm assuming that Josh will pick this up.

I don't think this was picked up yet, at least I don't see it in tip. Or
maybe I looked in the wrong place?

Cheers,
Carlos Llamas

