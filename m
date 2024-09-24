Return-Path: <linux-kernel+bounces-337107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E769984571
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C07C282DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1D1A4F20;
	Tue, 24 Sep 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/5xXDbf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE37126C02
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179452; cv=none; b=UNaxv0NGzmPWvFyLv7WpgUeRMycHZwI/Tpc5RxRI82H2AQ93VL1gkHYI7FKNeDpHxEjeJ/kovH0ZQFNopQDg272b2N7H/bpeB+WmfgALF3f2czurOGSEherqwG+NPpTX2c8dMMLZWGYzyaxQft+kdzQLYBYoExVlyrim7rJf194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179452; c=relaxed/simple;
	bh=9f9x5TXFk5tfcu5KU6qvQo0J67xm4FI85mVdI9vp2hM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0efmcyCgi7gSJWvE/bj0bOXVvHp9sWWuNzCx0nLGktdPtAA2VCvWfUj17snDt9WrB5aqlVv7wq7GZ1LAtmO9t4Hk7bpP7uG8KEpqhlClLAgM/zX+anyFDBZTDRvuP6MesyF2+niEwIZ7MI7Fr25uoLZZAmje0cEGLHCmQFNvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/5xXDbf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727179450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHPGJh8pMJuTB4PDpPJ+WO9iG6StJszjggfTKj8UGgM=;
	b=D/5xXDbfzPHS47PM4yIjijoiHRm8mG+6sDRep7MeJbEUiAtxoPESdSIQUZL/1yV/MIgzpZ
	rbL2Qy4QCaY+8om4ctbtmClwOu9vl42ggYVexlXmlQxJ9DKmIlLUKwlguAYs7g6NCwqERY
	fPKc1p+cG1Ha2nDf2XJMw4WcJPa8aio=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-UebdM8D8PzKLbogEvAMhWQ-1; Tue, 24 Sep 2024 08:04:09 -0400
X-MC-Unique: UebdM8D8PzKLbogEvAMhWQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb2c5d634so36581965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179448; x=1727784248;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHPGJh8pMJuTB4PDpPJ+WO9iG6StJszjggfTKj8UGgM=;
        b=U5+RtB320cqny4fDmSK0rq7u3fbLskI7g//S+t/+XB9F8b9QQu0aKR6bz/5g10z4qG
         ALALRuaAo3NTn9pthGe/oFPqUtRj87bJfxnbYs/lWj6NpdDtxTqdxPDkD4OFJUO0jsLr
         ti8CJL1vhr8btMvvHj6TzyyMvTltfTMBY4PpsVavosQSzoAzUpVjAP22XwjXGm+208yZ
         d29JlL/xdY53LFp9LTLb4xMTMKfpWUGJX8VrUi+vqrF1kXuCcZyiKV++Vl+NJj/p3aFg
         8fUzhrVkqimdg7+rkUXOp+uV/aGu0aBGLf/DMLlMs+d2WZSrUZDZI109r8bdnhCxtr1y
         Z3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXdS5qNTM01FQ8NX2OWHLKKqSFzV3DyHIQnzjwZZsW9oXLDygvWNHTpkz8NicJDGoAscUKRwbFJ0v0PfeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9T3wqBJShTfDp5egMD3MLTmzIcKn0uoph5/Ft9To7cZfUEdCs
	PFbbaFz3gjrTuyi1jJdI53qiyoOGu2n4rZbO4PSgjOM2tKGT+5KbphWUZMD50gB7hQ9Zh35SL6H
	BUUA+U02Gt55ks476NLXQGKZlSm9DbBxGcbPO+XKmVk74sV8DPw2zkVsFOrs2VA4ArCqvRQ==
X-Received: by 2002:a05:600c:1d1b:b0:42c:c08e:c315 with SMTP id 5b1f17b1804b1-42e7ac1c0dfmr118482065e9.16.1727179447767;
        Tue, 24 Sep 2024 05:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkwZoPOrtVWNrW1vej31s8KufRZ6MDtbVw9BSFK1If0z5Nh7q3q42jva/uYFt4EqX+A1Ahtg==
X-Received: by 2002:a05:600c:1d1b:b0:42c:c08e:c315 with SMTP id 5b1f17b1804b1-42e7ac1c0dfmr118481815e9.16.1727179447301;
        Tue, 24 Sep 2024 05:04:07 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e902b681esm20158575e9.37.2024.09.24.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:04:05 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Jan Richter <jarichte@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>
Subject: RE: [PATCH] KVM: selftests: x86: Avoid using SSE/AVX instructions
In-Reply-To: <2a62086810c14d0e88e38706a06aedde@AcuMS.aculab.com>
References: <20240920154422.2890096-1-vkuznets@redhat.com>
 <2a62086810c14d0e88e38706a06aedde@AcuMS.aculab.com>
Date: Tue, 24 Sep 2024 14:04:04 +0200
Message-ID: <87ikull0ln.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Laight <David.Laight@ACULAB.COM> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: 20 September 2024 16:44
>> 
>> Some distros switched gcc to '-march=x86-64-v3' by default and while it's
>> hard to find a CPU which doesn't support it today,
>
> I didn't think that any of the Atom based cpu supported AVX.
> I'm pretty sure one we use that are still in production as
> server motherboards don't support it.
>
> Doesn't -v3 also require support for the VEX encoding.
> Which removes a lot of perfectly reasonable cpu?
>

Well, distros making such decision are obviously not very interested in
running on these CPUs then :-) In this particular case, the distro was
Centos Stream 10 and they are very explicit about the decision:
https://developers.redhat.com/articles/2024/01/02/exploring-x86-64-v3-red-hat-enterprise-linux-10#new_cpu_capabilities_in_x86_64_v3

and 'gcc -v' tells me

Configured with: ../configure ... --with-arch_64=x86-64-v3  ...
...
gcc version 14.2.1 20240801 (Red Hat 14.2.1-1) (GCC) 

-- 
Vitaly


