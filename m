Return-Path: <linux-kernel+bounces-414902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF0D9D2F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E0FB2B7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E841CEACE;
	Tue, 19 Nov 2024 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em2Sn64J"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B321D1305
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045586; cv=none; b=jG19PX7KTA5ZuTuVoxpuYhsj3yc6Mr+xYihWiPm9fGRIn0VvfPdoeFnVl717AoN7coX9FC2Xt5iOUgGUYKRESLd1IxQ9r1y1mkKMFYN6lGM4a2mN5AJbFEBkoxwt+UueC4HH23ogeCUBjU7DiqpE6p2f1xYRKfnNOhiiQ2bqvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045586; c=relaxed/simple;
	bh=1thykLAzLP0g/paubbG6Z2qKaaHJWSChf1kVxcmULbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/cSKNxw8sqVRl/njWIsGKrSe6bYgkJTPyBJMe9SGyGHw8EjqCQU8N5QZE9jV8KWt114R6i014aLMoqchhQlcQa8CeijBP+Olv0BARpQZ0j8YiTIIYtGjwXnEvysyGevfVrQqpQ6C9QT0Upp4rBgU6snvixRt2oEAyvxIM/CyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em2Sn64J; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-212581a0b33so10419615ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732045584; x=1732650384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+F7dYpCTXns14jzrM0GSqYlBRnuGW2O5+9hYw6msCU=;
        b=Em2Sn64J83Fe+qo58q3aABqdliz5HKYIrIsPaCgyV3Q2KFraalQGShZ+e8KZ5gpDpd
         qm5zG5Zy/89GgO/L6J+VGCbE5GpxSZ8bcRAE+WLRQ5AV6XmNMyPQUaF3wjiebfoqHr0z
         HsTIKuPWV0pZkZqUbyIfMVNfPCmBCg4nJRv9cUhQ4cdqPhOIAT6wMge8N4OBxOQHwH6q
         5zdOdXP6hRsZku4y/2OwKY/Z6/1Yqh9jDwT9cCQrT7NF2UmuSrX/kcOlsOlHAWhYRP2I
         /rlvHjqUGE2BNxsAAsDnEdUwkxIYZVdERB8kxOfYnAe2RY+GeoAYb/WPKfiNoK/Ghevr
         1TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732045584; x=1732650384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+F7dYpCTXns14jzrM0GSqYlBRnuGW2O5+9hYw6msCU=;
        b=eIvX46mVhFtLHFY4bNQuJKKCO+SktFTvqiM3yhOuiSA0ktueriFI2evCswluaj3HbN
         kFGvlU3adS8b90VwLMvUe9dgfgwnENLSmo2wwhNhiIuijXop/xIMtBt+RxYIDAc16vF5
         nXKkUcJS6OenO14Rw57qt38WsgZUWeuqW2V0SEv0KZIF3elDg+imGdk+njFWDtV31DvG
         HZOCayawC6sdH0DAdUhuWAO9bcf+dc75Ka9HmLLzmR0WYDpA//10pDoBBV+ASlVx42+t
         C9Jqu0Ts33NYL1IZ73eOAAgyQXZAjzdzaaQ8z1Iiq6D17mRMTQt31fkKbJ1rG/aTnwMg
         4mLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmH7pXAWawnYD2niwt+ujspxLaDqpCwaDnFVxoa+xU0rcsuHEaE6+J5jnCh68aHPWcxgrplte+2gXSu1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDQmrohtg1RSVA4A1HQQYjFkye9mmxNIAg7y5CmqTQ+pAyEfk
	4h3/2fIdVpPv21YmxlHXsr7jhiuyhl4bsFUqyp5EdtGjeaAJNgMK
X-Google-Smtp-Source: AGHT+IHi0AKilDOA4tpmO+IhzPoqmOdlLdyGpRxqj+kqXmspGv/3fYdswwBMd5HzdzBX6Wn32jn22A==
X-Received: by 2002:a17:902:f682:b0:20b:5351:f690 with SMTP id d9443c01a7336-2126a3a4926mr845595ad.16.1732045584482;
        Tue, 19 Nov 2024 11:46:24 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211f6b25339sm60211405ad.240.2024.11.19.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 11:46:24 -0800 (PST)
Date: Tue, 19 Nov 2024 11:46:20 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, thomas.lendacky@amd.com,
	ardb@kernel.org, tzimmermann@suse.de, bhelgaas@google.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating es_em_ctxt fi to zero
Message-ID: <ZzzrDB_1CyNfL0zo@desktop>
References: <20241119180517.196079-2-ragavendra.bn@gmail.com>
 <20241119192602.GA2272685@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119192602.GA2272685@bhelgaas>

On Tue, Nov 19, 2024 at 01:26:02PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 19, 2024 at 10:05:18AM -0800, Ragavendra wrote:
> > Updating es_em_ctxt to zero for the ctxt->fi variable in
> > verify_exception_info when ES_EXCEPTION is returned.
> 
> This commit log basically says in English what the code does in C.  If
> you can include the *reason* why this is important, it will be more
> helpful.  For example, maybe somebody consumes other parts of ctxt.fi
> (a struct es_fault_info), and without this patch, they use junk that
> causes an oops or some other bad thing.
> 
> If the 34ff65901735 Fixes: tag is correct, I suppose the problem
> happens because ctxt is allocated on the stack and contains junk, and
> then svsm_perform_ghcb_protocol() passes it on to
> vc_forward_exception(), which does use fields of ctxt->fi other than
> .vector, which will be junk without this patch.
> 
> Hints and samples for commit logs:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.11#n134
> 
> Based on "git log --oneline arch/x86/coco/sev", I would expect the
> subject line to have an "x86/sev: " prefix, e.g.,
> 
>   x86/sev: Clear es_em_ctxt.fi to ...
> 
> > Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
> > Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> > ---
> >  arch/x86/coco/sev/shared.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
> > index 71de53194089..b8540d85e6f0 100644
> > --- a/arch/x86/coco/sev/shared.c
> > +++ b/arch/x86/coco/sev/shared.c
> > @@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
> >  		if ((info & SVM_EVTINJ_VALID) &&
> >  		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
> >  		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
> > +			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
> > +
> >  			ctxt->fi.vector = v;
> >  
> >  			if (info & SVM_EVTINJ_VALID_ERR)
> > -- 
> > 2.46.1
> > 

Yes Bjorn, I completely agree with the need to update the reason, I will update the commit log and send the newer version accordingly.


--
Thanks & regards,
Ragavendra N

