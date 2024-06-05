Return-Path: <linux-kernel+bounces-202847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4368FD1D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EACB28BB1D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B267CF33;
	Wed,  5 Jun 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7mV3pBM"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9021773D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601890; cv=none; b=ZMAQr8pGGI9iULEjps+LnJrRK4R3l/8Q1zqgavzH1jLknlOaO49Tg1/b1seMPhy7b37/6ROiUUR2ZdJIoLQ4DusV8jXous92Kxnb8GuMrE/R+tQ80/Sa8YPi6pzc8DAGrgWlA68GGKokjZwX/ZLW7+KMYq43sgLggWMcHRDdHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601890; c=relaxed/simple;
	bh=bpFNmEe++Fm6Jhn5LqQS44pORnnsMVjcXJi0YMeG9xI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eU2Mkyj/5t8EEZ1mxIxK5ilkomLib0ZM+XWZzdzedRjXoaVYw8z8pn6jvBwkVNDj/cD9RG6Q9wipIgdL99zUR/X1xpx6hZTb9s5lIWXj+TUyi+rY0MZ0TjJ3UIC3CuGQQR5G2up7tRkzwV4OW/kVFz4lhvGT+k+j1wxr/haCSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7mV3pBM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a088faef7so13700397b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717601888; x=1718206688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kIwFDSYK6IZoKm19H7uH4SBYfg7R2PGBVGLBIDSlog=;
        b=i7mV3pBMEar5mH8xrDKUgrXbxQvALUJkZUo79eSMLMqN79Y4rVJwAbrYAuKHYa//T/
         Cv61I2YB7ou0dAgzKWVBsxaYX6qe84R9X4dNk6bwo8C8vdMO3FQy28JhaKQivJtweIsR
         6Af1FRZql7xQ+YOCTQ+NZk3sS9fvQzhEvUgtN9g2qyccE7tiKF7pCGkGEQBGHNqS41x5
         AZ1hl4Ric+S8oEk0DbLkpwYVGMmfX/atirjqU9cdNIF4ihqW6klDCyvVFfc+etFL8Pur
         HHL0oVa7e6HSZKcyv45X//ZqcFKaNIby4ku8mN7SNZSe/FgosbQsCRQURDKGMbufMkAx
         FCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601888; x=1718206688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kIwFDSYK6IZoKm19H7uH4SBYfg7R2PGBVGLBIDSlog=;
        b=u9W402S+cU3Mk7wNqM3pkI1yML04f1gdNMe1DOlZLXBjFt/SAqNmC7s+wSwQ2WXE1v
         ZJuVB5N+SvfFlZx2otYqHIsxxtQt5gWUtZTF9T2F6sKeHNw9DY+VgGERdzx6FVZQF06j
         gsfqZe3+UeII6n0imHlK++6zY0cRLor02dBjLaN3/ctwIcOHgEIuRzjLbObEHgb4HBei
         QlOLxuie9tMjykUgl6vvPKrL+bRYEXALCso1mxYDCraWcMwOdlpZk9l4o9CWs3rQGB1G
         4+AZFwXpXuROJUrgHNc2xukXmaPUffjqMp8TjmZO+XyrIzk4DS/pWJpEaSAM6a34ZgMc
         oqIw==
X-Forwarded-Encrypted: i=1; AJvYcCUfXgGazZk1ROfFHXmPzb6KJRor2NSzEx7whkU6M+z05+EvRCzPQNU7VM9FCDYpayLOM7anqaSksNillbSTUOfizNdHn8CwgpuI7kC6
X-Gm-Message-State: AOJu0YwexUDewysgv2/iVe5onzVbbimexuM3t+aItNFNPQp7DNaQoFjo
	dRr5qbA1QltAWXgaIXJFM1NYSmKIRWJ+WvjO7eKbDFti+fZyB+6Rhpsb1mo4QCuPnNSJcTX0txw
	uAA==
X-Google-Smtp-Source: AGHT+IFVGwW9/cpLUjRGOTBt7abgUxXeVyV3Hw/4O0+DzAsmAXs3qbFgTiclGA8Y/LqWnzwtdCDqyCrlowg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b02:b0:de5:9ecc:46b6 with SMTP id
 3f1490d57ef6-dfadeba2a13mr1790276.6.1717601888104; Wed, 05 Jun 2024 08:38:08
 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:38:06 -0700
In-Reply-To: <81d9b683-450a-4fb6-9d95-108c77d9b3cb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520175925.1217334-1-seanjc@google.com> <20240520175925.1217334-9-seanjc@google.com>
 <81d9b683-450a-4fb6-9d95-108c77d9b3cb@intel.com>
Message-ID: <ZmCGXhnlwQjqbfab@google.com>
Subject: Re: [PATCH v7 08/10] KVM VMX: Move MSR_IA32_VMX_MISC bit defines to asm/vmx.h
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, Xiaoyao Li wrote:
> On 5/21/2024 1:59 AM, Sean Christopherson wrote:
> > +#define VMX_MISC_ACTIVITY_SHUTDOWN		BIT_ULL(7)
> 
> Same as Patch 4. It is newly added but will be used by following patch 10.
> 
> Call out it in change log or move it to patch 10.

This one actually is mentioned, though it's not super obvious.

    Opportunistically use BIT_ULL() instead of open coding hex values, add
    defines for feature bits that are architecturally defined, and move the
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    defines down in the file so that they are colocated with the helpers for
    getting fields from VMX_MISC.

