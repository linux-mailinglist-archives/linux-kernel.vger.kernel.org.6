Return-Path: <linux-kernel+bounces-517658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF63A383FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A678418983D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423E621C173;
	Mon, 17 Feb 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SK4uiccn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26923C9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797575; cv=none; b=QnbpaKcejUNQge9afIaS/Ai0sw9iV/QRx6utjkd8O4qYxwGkYUMPlYHcPCcnTT6y3s7hkHF+vhLK0oKN0YCEd8ge2zCY7yn1/h4hz6UbQd9bC1sQAhs2ZEYPuldPHyQyigTQ0nqFEq2HrpsFwC39hedhS/CsxBtqTVrT4iqohmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797575; c=relaxed/simple;
	bh=ZKAxYYLxdNCr5VowdCBtoLawSOPUB9oQdK09VtVgZeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6P9ddTq6a5Os318AdfJvLN/ZZ1G8r4qb05VLsrBG8KWBIhW5RRsovCI6tWtfoBHskonDOZpRdZMjl0bin63Ls9S3RGRIsuAmQ0jqBevJkIIU8ecMoWZ7eBrVlDUJIf2YbLaMy1uwtXebZ55o16xMkZx21eT+5JA+erJ+oW5BTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SK4uiccn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739797572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kSiOdtiiGo1JzX8LMRCdFTwQjInIJfdLf9Cgv1ZJH3g=;
	b=SK4uiccnFzPsLvfKl0WXvTbXB9OKQayHbGOsu5KFFpDZ3g1N2lffjHCmgwXEmXc5CpTNQz
	8Np+bIgUUlTBGEF6MWKSUZbe5Dd3KAtxu5reT4Pbxe6DveWTsxwRwAKUHzZXfcKr3LhbHV
	VjvNO7Ebysp+tHC39hattluB3N2zK+8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-IcxTh0vcP1G7VJ2ntIt8Ow-1; Mon, 17 Feb 2025 08:06:11 -0500
X-MC-Unique: IcxTh0vcP1G7VJ2ntIt8Ow-1
X-Mimecast-MFC-AGG-ID: IcxTh0vcP1G7VJ2ntIt8Ow_1739797570
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5452e71d61dso1366627e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797569; x=1740402369;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSiOdtiiGo1JzX8LMRCdFTwQjInIJfdLf9Cgv1ZJH3g=;
        b=Jz5jScWxz/iIcBlOeiHUJpTYXMSyYNo52sftCES/pwafGG5vwL5rdw12dthuzJl2Ss
         hcT4QINrDjznMdPo9AGH9dqavLDR0Q41haiCBA/trXyt9DqgaR1qsDzuF5ROTlRVKplG
         gpzakCxcPMmL1z673KeKnq13vtdNiBfXOf3iK6J1RUBtEgJWPPMkJDizAbbk7S5qUgDJ
         A1s+HZNFhCr6WsHRQilLqDLm4nrFmb8V9iidKOXNd2q59jjdFMGEP+nW3nMt/LkuF4WM
         ZKPcFHO4nBkE2a7PEIeQWH6u3sVci/MmNJtmBCp//Y2yQe7iFgD874KEPSMXRlf5VWQ8
         IwYg==
X-Forwarded-Encrypted: i=1; AJvYcCU1ENLwgWmM0rUXqIYDVWkyFlRXgfVdURrkhGzrPvTU5jJxZMznRTjx88WTBaOAdm6L38zC2yemslUrkNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1qPijTKJ6qAM95Kz48Kc1E8SWpdXhKqEnlBfahOUHdkTPKhF
	xH0jPXhIv5r3IP3mWPGlWrqn6zriD/TlI++RJUg9L3CT3iuJuUCg43v6J4o+zyzpPyIjHLDUeH9
	5W9Oa+hEoHCRqY89ovSFjTCeYqHn9XA395nm6khke92NsNDgWysNxC5aMqPruiAlGUTpnNw==
X-Gm-Gg: ASbGncvhT7tDdPqV6tkMBtI6f+z0ekMqXfVpUJv62WIQkvUQl/gSi6gzuZxMS1/QAvh
	5UQsFPGgboZOQKia+AMGC24fNMAQGoEcto+WhIvfxctrZ+Fu/VDrbh2ccKDX4NEqitoaZMQK1Q/
	EjeDIsPuQbRT1WpbVpfrjvk+9aQKaIEE5xEH3oxgTUUMsiIeUDpuqyXW5pvNT518c7CUez37+0V
	a+2OI7q+NFlnrVcbszyfhcYwU+1KIPUEjrgEvMO2e6cwH7VdI+7WunGXZ/79UU0Z4pygggi5YL1
X-Received: by 2002:a17:906:6a0c:b0:ab7:d34a:8f83 with SMTP id a640c23a62f3a-abb70ab8b5emr1032880466b.17.1739797558562;
        Mon, 17 Feb 2025 05:05:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSLtEqy93wRPXG9nMCMJ0lRt4GquiQhPG/wEddubWd1+r9Qa8A53oIvQqaL6k/Vn2poTgPqg==
X-Received: by 2002:a05:600c:4e8d:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-4396e7d3b00mr82441835e9.0.1739797516788;
        Mon, 17 Feb 2025 05:05:16 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm12383958f8f.56.2025.02.17.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:05:16 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Nikita Kalyazin
 <kalyazin@amazon.com>
Cc: pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, xiaoyao.li@intel.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 roypat@amazon.co.uk, xmarcalx@amazon.com
Subject: Re: [PATCH 1/2] KVM: x86: async_pf: remove support for
 KVM_ASYNC_PF_SEND_ALWAYS
In-Reply-To: <Z6ucl7U79RuBsYJt@google.com>
References: <20241127172654.1024-1-kalyazin@amazon.com>
 <20241127172654.1024-2-kalyazin@amazon.com> <Z6ucl7U79RuBsYJt@google.com>
Date: Mon, 17 Feb 2025 14:05:15 +0100
Message-ID: <87frkcrab8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Nov 27, 2024, Nikita Kalyazin wrote:
>> 3a7c8fafd1b42adea229fd204132f6a2fb3cd2d9 ("x86/kvm: Restrict
>> ASYNC_PF to user space") stopped setting KVM_ASYNC_PF_SEND_ALWAYS in
>> Linux guests.  While the flag can still be used by legacy guests, the
>> mechanism is best effort so KVM is not obliged to use it.
>
> What's the actual motivation to remove it from KVM?  I agreed KVM isn't required
> to honor KVM_ASYNC_PF_SEND_ALWAYS from a guest/host ABI perspective, but that
> doesn't mean that dropping a feature has no impact.  E.g. it's entirely possible
> removing this support could negatively affect a workload running on an old kernel.
>
> Looking back at the discussion[*] where Vitaly made this suggestion, I don't see
> anything that justifies dropping this code.  It costs KVM practically nothing to
> maintain this code.
>
> [*] https://lore.kernel.org/all/20241118130403.23184-1-kalyazin@amazon.com
>

How old is old? :-)

Linux stopped using KVM_ASYNC_PF_SEND_ALWAYS in v5.8: 

commit 3a7c8fafd1b42adea229fd204132f6a2fb3cd2d9
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Apr 24 09:57:56 2020 +0200

    x86/kvm: Restrict ASYNC_PF to user space

and I was under the impression other OSes never used KVM asynchronous
page-fault in the first place (not sure about *BSDs though but certainly
not Windows). As Nikita's motivation for the patch was "to avoid the
overhead ... in case of kernel-originated faults" I suggested we start
by simplifyign the code to not care about 'send_user_only' at all. 

We can keep the code around, I guess, but with no plans to re-introduce
KVM_ASYNC_PF_SEND_ALWAYS usage to Linux I still believe it would be good
to set a deprecation date.

-- 
Vitaly


