Return-Path: <linux-kernel+bounces-261153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECD93B342
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D91282A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8EC15B10F;
	Wed, 24 Jul 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T7uD8X1F"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D6158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833233; cv=none; b=dV9e0YXWBE+jVk1EPjK0Juk+yCNgRptG0FpCWZjLlpmadTbxBdTd1mCQpCBbwuZlY3DgnnjxaUczY2iaoz6vZIisbxlK4iVFi5GPhU6inrPo+sd9U0M+pxpJ/mp456XtxCZvHeWsrG0IVxCOxxbE3VVQ9GynHDSt2Kvc45KcEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833233; c=relaxed/simple;
	bh=iEJ4xAfm46CXzrs3lOkUkaZM1YNGSADIFCnZG5vUg2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlZuI4V/X/pv2t5/Mg5VTU7J3133ch2FnNDReRb+FJTftUTgGLiREMjuT17/F/zyZUbLGks9MVTBr0KPg9BCZVAc4533nxXegXXhNXQP4OAVmZyqKYcAsAwrpWEy/ZjgvKXu8XjT12FLHAibMB8pMIrBMHAUvSJb2TkjnEkdz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T7uD8X1F; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a728f74c23dso181646566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721833229; x=1722438029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUksBZpqWpsHw2koG1efF5qTi/txBixDZygv97SCPEk=;
        b=T7uD8X1FUZ6MJTkymRvgl5UnbVJIlOkTtNwxkTfv1ERR94y5eQEzqDnpr6w8JkuxV8
         hFMHLcLUYad7O3ByQ89DsxinNKe/YeMayAn2f76xnInI/DFiBCNQyRzLsvxpdLP3mSvp
         FFQKVCZM836NY/zLygNzvGQdLqoDTZuMlHfNlmlgsSlsppbci6LNBtpPN6ckXPYUE02t
         hoMbpSUphVvOAe619n8sqaFdaSu/x9NY/3HCKoJH2ozia83GDSNHXgbt8R4g3q+EEUpq
         4LYWBN1LGWmuW/je4Spg1Dz1qtfafOiNRUHtna2I1itLPKKj0gLiTPQ7dvgxziwG+gGG
         1qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721833229; x=1722438029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUksBZpqWpsHw2koG1efF5qTi/txBixDZygv97SCPEk=;
        b=Tambb+niVlCAIJz41Lg50RfRh9x7YNXGQNUvkGU0viJTVBGRUxAueIoOUD9Rg0jiSr
         GKMWLCSvNflvScehcJrrUcwz3M1mGK3C2rH4pucyNqy+WlWL44jyfcka1fXbnogMzrOI
         y8T/I1/XaK0snDkejDZ/i1K2OhcrzZfR7PDl21rMQLTXWsN59l58Mpri7DKx7MurMhGp
         wt8S2OwdTzfqqEczwmuC2McNh4wLQOxjSaSKj3mTLZKuzUgubI2lAAnkeCTz8qXo5edZ
         mR85ejMYVKar9IhzOMOJtNiGMc8f2PrmRvakDmNssK5TJiVDWBxh7oRYBEpVHCveaOnU
         EwYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZqzxmtrN0neZXr+ZamKWMCyekGI3uUbkF4GDIsOpqQ8acQD35HG/anjfdhagL3zvy3k51q69v3i/YtgkGNs4Ml/7BEId1S7witcJj
X-Gm-Message-State: AOJu0YwOczUKgIJBW3zsMRSdeKHtI1o9XU+WxAbEVUyukpybsz0juFDX
	5s5rQrtAngZscA4WWmIW9jH7A4aGJht2PWcea6HCVT++V1zOQITHB9xfx3I3ZAI=
X-Google-Smtp-Source: AGHT+IG0+SyZ9C3E4vSqFyVoFgHuf/zh0o2P/G3Dn148plAu4A0cE4wLTNW44/4c/xRYzWg7ojIG3g==
X-Received: by 2002:a17:907:7d86:b0:a77:dde0:d669 with SMTP id a640c23a62f3a-a7ab0fa45e2mr178694466b.45.1721833229538;
        Wed, 24 Jul 2024 08:00:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa439e40esm139830266b.48.2024.07.24.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:00:29 -0700 (PDT)
Date: Wed, 24 Jul 2024 17:00:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Add using attribute to klp_func for using
 func show
Message-ID: <ZqEXC7NVStjPA9os@pathway.suse.cz>
References: <20240718152807.92422-1-zhangyongde.zyd@alibaba-inc.com>
 <alpine.LSU.2.21.2407191402500.24282@pobox.suse.cz>
 <07DD1CA1-7E53-4E67-92DC-ECEC11424804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07DD1CA1-7E53-4E67-92DC-ECEC11424804@gmail.com>

On Sat 2024-07-20 13:56:56, zhang warden wrote:
> 
> > is this always correct though? See the logic in klp_ftrace_handler(). If 
> > there is a transition running, it is a little bit more complicated.
> > 
> > Miroslav
> 
> Hi! Miroslav.
> 
> In reality, we often encounter such situation that serval patch in one system, some patch make changes to one same function A. This make us confused that we don't know which version of function A is now using. 
> 
> In my view, this "using" state show the function version that is now enabling. Even if there is a transition running, the end state of one task will finally use patchN's version.
> 
> If we see the attribute "using" is 1, it mean that livepatch will use this function to work but seem to be not all task running this version because the "transition" flag of this patch is "1". We can be told from "transition" that if all threads have completed synchronization.
>
> So, the main function of this attribute is to enable user space find out which version of the patched function is running now (or will use after transition completed)in the system.

The value is useless when the transition is in progress.
You simply do not know which variant is used in this case.

Which brings the question how exactly you use the value.
Could you please provide an example of decision which you make based
on the value?

If we agree that it makes sense then we should make it 3-state
where the meaning of values would be:

   -1: unknown (transition in progress)
   0: unused
   1: used

Best Regards,
Petr

