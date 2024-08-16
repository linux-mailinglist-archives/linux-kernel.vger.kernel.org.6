Return-Path: <linux-kernel+bounces-290375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968EE95530E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413D41F23072
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DE145B10;
	Fri, 16 Aug 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBNIKBTH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736F1448FF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845860; cv=none; b=u1oM6Wcc827EHLdUG5n3Wh4mSoc2Y07aWmUd2xuN+UCY2enFCY1NcgG/trc48jsSK4omXnHS/0q3bbemZyIOZ4ukzTRT8wY4mVaLDIwJhuK0EuQBVTftfUhLiX8AQxrx2gTWaT4aoMuLqVlP4N/2c8IPtNn4wGHj/EKguhN2Efc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845860; c=relaxed/simple;
	bh=KW9D5wVU77tNQ3/L82+SRnU+J+FVG21c6UL2U3LRiFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qk7DGNSyo6MuPWY25AGsMkG5C5cunaInw0kxMCIieAvB45KfHOS3UtEJbeZWDogDHlURtVNe7PfGRbrjGoG1A6u47z83+gOox/Q4Zp9l7MnhfBfVqbWHafHKbdSlRcClfTs515co09juw725MsNV70UYBPYQ7CobDMjf/j5bVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBNIKBTH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b3825748c2so11792217b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723845858; x=1724450658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW9D5wVU77tNQ3/L82+SRnU+J+FVG21c6UL2U3LRiFQ=;
        b=lBNIKBTHJ7DidOsalBFxEAycAcM7jaPXzMjoATR5hrBeGGaV9Kghuvd5FRj16yXQUz
         V9WjlUSlSxNcfjmzxT3ueZnOTuV9oZ1t8k6AonBuoQkPMyYf9T6m8sFO73mjdE8nHHUv
         EBnpw9Yk2Qxlp7euzzlT+XHPy7MwCjRLz4sztwnnjynt5GlvkUv7lHtmqXY9BwMY78CX
         HFKXu9Mmqokm1TdhAUmASowna2pec6tig0boDgz5UAbyUPAxXEjU+WvPqmufWK3FcEeX
         c+B5D1bDxQGQKl+Xhj8YrJJr7+g81BqZbsikODV4HRtMchsALvvNICUY1DdsgJjcXYgG
         BMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723845858; x=1724450658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW9D5wVU77tNQ3/L82+SRnU+J+FVG21c6UL2U3LRiFQ=;
        b=cWeBpy+O7tiGVSbOP9tcKVxA64I8Ejj3yy1zOEdgbC2rhShiW/7muik/b/m2zdRW5S
         7fqgeFOOQNZTEO2YItM4g01d50D8pw2mW12IX0gE+NeIZcyrpjzkcQ3ybqbCw5x3CmMN
         Ugn4AJcPm/q2d7tbbyfxTZo3goZDx5khCEshLBoj9i2NIST0GjtMLoJMfy+huYvMJusc
         Vw9mKe6R8Dmjt6nJIZeXb2+ABKXuH+WMcufern2NMmkRaICRbC84AuQFCCQZvuMRW6z0
         NOcJSbJPqDInKrWVcZvw1+N9vrs8qN1zf4ajKITfANfNxX68zkbOIgq0optmulBR5IDM
         udPg==
X-Forwarded-Encrypted: i=1; AJvYcCXbAOhoDgyX2Kjp2bjnKWiOTBMj+ae/yGFl+zvwkN3oDUGeiLiCNGLpFkE8IHAgKQV0X71pXTfy8D/SM/hOhk/T6Umx7FXdltPEQ1/q
X-Gm-Message-State: AOJu0YxBQOxHmXh2YgWGj5Li754oI2ORlF5PfgWoWgQQPhgegqY/XeIT
	9rCRZtRXF932z+hefzKuy3RYELFVe8TqzyzHkPOFTmYZunQNGcApGqQ93sQughDZ4QzMVTpVOln
	nfQ==
X-Google-Smtp-Source: AGHT+IGiXCTmOHYZrpZ5ro3nY0FBiXL9B2iTr8Z2RNZbiKrDwiWMXpDu7b0F/AQ1zuqdMV5L0qIZpi7Rif8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3141:b0:6af:623c:7694 with SMTP id
 00721157ae682-6b1b213ae21mr1025967b3.0.1723845857802; Fri, 16 Aug 2024
 15:04:17 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:04:16 -0700
In-Reply-To: <20240815123349.729017-5-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815123349.729017-1-mlevitsk@redhat.com> <20240815123349.729017-5-mlevitsk@redhat.com>
Message-ID: <Zr_M4Gp9oEXx4hzW@google.com>
Subject: Re: [PATCH v3 4/4] KVM: SVM: fix emulation of msr reads/writes of
 MSR_FS_BASE and MSR_GS_BASE
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 15, 2024, Maxim Levitsky wrote:
> If these msrs are read by the emulator (e.g due to 'force emulation'
> prefix), SVM code currently fails to extract the corresponding segment
> bases, and return them to the emulator.

I'll apply this one for 6.11 and tag it for stable, i.e. no need to include this
patch in v4.

