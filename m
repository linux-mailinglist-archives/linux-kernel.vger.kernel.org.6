Return-Path: <linux-kernel+bounces-336907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA74984266
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA0F282A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D5515688C;
	Tue, 24 Sep 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZTVXHo2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696F154C0F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170859; cv=none; b=jy6TkzevzCIse0RQXGVRqmdoyefnYBGqU+ejEz/KHid+TMQlCgZZjlaLy2P8ickgE9mW4jQxpVU3TakQf6lU0PyMLtH7MI7eJmF86wAhJyA9gMkm+6HJwAYAa5eFW+qj1iriiierrW2RXPeJEZQ3nVn2pfW+AQ2Q8chR9TJQvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170859; c=relaxed/simple;
	bh=lWmCJtqv+vQCD54caHjbHBNnTILSelPZSN58h8zdfU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvjBTXHrwIdYRvPrp3ImnJd886/KBFtFgpyd7bFcx27dVmBbBfE0KH/V5Uw1Xv4CUSo622hyv9MyB5y0NhVJM8fDnA2pmugvTUA+00v4zfcodJkSSOoBIHJx/881OApq7QiP6wroM5dqwaRzNJqRzXXA8Sgo4+1iBCtwl3tDE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZTVXHo2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727170856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJB7ipz46koHNrHbD2B3lzoMb/WDq9C6nVfTbT9ZPF0=;
	b=CZTVXHo20WxdUZa0Nres2ZJR4KcIMZICk8IV90XCAqpUI5riBmiShhCIel87c56PMVzNZM
	0+ACrrQrZ1BcD/m1Rk4KGgFkqFY9sZsgOurUKo0pWIp2IPboOkEnG1x+80aTmpGk95Uxtl
	dN2cg51u3CwYbv//HCkWNqkdXRLriPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-veFr9Br6PKGqMZw8Bzpe6Q-1; Tue, 24 Sep 2024 05:40:55 -0400
X-MC-Unique: veFr9Br6PKGqMZw8Bzpe6Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b69e65e8so1987012f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170854; x=1727775654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJB7ipz46koHNrHbD2B3lzoMb/WDq9C6nVfTbT9ZPF0=;
        b=IPPZ6X6IrJqSg5bXcvqKvWkpICXetetmmvWy+LxRDUqQW/eRtmMrji+XOSBkoMYTD6
         4JDAyz0P/AA8tU+qvfouOUQEkYDfXiXGoToE/oz8LEaez4PI007pQws7559ET99PCUlV
         qplL9PazJwdWELwnAzTqllqegCHwl5W6WefCl12reC9mqMq3xTQL89TMW8BzdksbUdaJ
         lkITWpGo4rsVlClBVqBKmCZc/Zqk7HL9V94NRIA/XE7CaEK50MsLzvWRuTOyIGcf9qxc
         djQ0bjLYr7a4zHrMulMkjsp+udNG08R9jcQ8lTSjgBGt2TTuzlpZGgqDkCFw7apKB1BU
         JP8g==
X-Forwarded-Encrypted: i=1; AJvYcCWpKNpq1lWXjUZYfFhfBQgN1KoFEaCzGUc+f9HhLt/suDUatXsZ1Ls7zTDn/dILO+7j29Jkjcnf5sQLZic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3LmYPTRQ1H8wDZeyBLnHS+pU5xPW/34I7+OD07aFNXYgWKG/
	3jCsKJVBb11N7MiExDfWqDej0BDbez+4weJ0TrkpfptPG6NmzjPDHXsnEuIT14z+M1otHN/jEpj
	lvwTumfWA0Krf4c9OmIRpunVScMGLVvi/rcwuamBcydTgwEYq9ypeJZkeRBt1rA==
X-Received: by 2002:a5d:42d0:0:b0:375:56ed:a3a0 with SMTP id ffacd0b85a97d-37a4236e123mr8350631f8f.43.1727170853825;
        Tue, 24 Sep 2024 02:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtt9E1Goeg1abwDliN1EoQRDnu8vzFS6ICWKIFrsgHRaj8NAcm408nZayZB+C2juZ13OwrcA==
X-Received: by 2002:a5d:42d0:0:b0:375:56ed:a3a0 with SMTP id ffacd0b85a97d-37a4236e123mr8350617f8f.43.1727170853434;
        Tue, 24 Sep 2024 02:40:53 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f9669sm1093440f8f.68.2024.09.24.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:40:52 -0700 (PDT)
Date: Tue, 24 Sep 2024 11:40:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: boris.ostrovsky@oracle.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Mackay <eric.mackay@oracle.com>
Subject: Re: [PATCH] KVM/x86: Do not clear SIPI while in SMM
Message-ID: <20240924114051.1d5f7470@imammedo.users.ipa.redhat.com>
In-Reply-To: <534247e4-76d6-41d2-86c7-0155406ccd80@oracle.com>
References: <20240416204729.2541743-1-boris.ostrovsky@oracle.com>
	<c7091688-8af5-4e70-b2d7-6d0a7134dbbe@redhat.com>
	<66cc2113-3417-42d0-bf47-d707816cbb53@oracle.com>
	<CABgObfZ-dFnWK46pyvuaO8TKEKC5pntqa1nXm-7Cwr0rpg5a3w@mail.gmail.com>
	<77fe7722-cbe9-4880-8096-e2c197c5b757@oracle.com>
	<Zh8G-AKzu0lvW2xb@google.com>
	<77f30c15-9cae-46c2-ba2c-121712479b1c@oracle.com>
	<20240417144041.1a493235@imammedo.users.ipa.redhat.com>
	<cdbd1e4e-a5a3-4c3f-92e5-deee8d26280b@oracle.com>
	<534247e4-76d6-41d2-86c7-0155406ccd80@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 12:17:01 -0400
boris.ostrovsky@oracle.com wrote:

> On 4/17/24 9:58 AM, boris.ostrovsky@oracle.com wrote:
> > 
> > I noticed that I was using a few months old qemu bits and now I am 
> > having trouble reproducing this on latest bits. Let me see if I can get 
> > this to fail with latest first and then try to trace why the processor 
> > is in this unexpected state.  
> 
> Looks like 012b170173bc "system/qdev-monitor: move drain_call_rcu call 
> under if (!dev) in qmp_device_add()" is what makes the test to stop failing.
>
> I need to understand whether lack of failures is a side effect of timing 
> changes that simply make hotplug fail less likely or if this is an 
> actual (but seemingly unintentional) fix.

Agreed, we should find out culprit of the problem.

PS:
also if you are using AMD host, there was a regression in OVMF
where where vCPU that OSPM was already online-ing, was yanked
from under OSMP feet by OVMF (which depending on timing could
manifest as lost SIPI).

edk2 commit that should fix it is:
    https://github.com/tianocore/edk2/commit/1c19ccd5103b

Switching to Intel host should rule that out at least.
(or use fixed edk2-ovmf-20240524-5.el10.noarch package from centos,
if you are forced to use AMD host)

> -boris
> 


