Return-Path: <linux-kernel+bounces-319138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94B696F862
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B5C1F26111
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7067F1D2F5D;
	Fri,  6 Sep 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07X1KCYA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBAC381C2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636969; cv=none; b=eFcHQGd803ibGiC7vcJic0jsEAkcYyJpFRMeLwmtFVCEflbgJU1icg+mPEDFlEPLz3g3SQSN4vkeOvccaHZ/uwzK10eOzq0WSCpwZG9ng8FxqVi7Sb8potoajPEzu6MFPjtsYYNSttCPn+Kf5bPMDgPoMYgztRzF+hYdTbM26Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636969; c=relaxed/simple;
	bh=rj5X4jWsGQFekeqYk8dIy4ujKY1KtAbu6mrY3UaJpHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtYZu1nCfgT+AbLpgrBtkjtIOjqMxGp4TanBSR6o7xvc2Nehn9dMZi6chuP4BwHlIjGxwfZfFkCdypS4xqCulngwDaZRCjXFOwtgNBJ+bKb8IKr922zEyYx7K6Vu6SMoY6GduKSil4vsiR8kBr0JPNu2BfMzhyuidp+bsICrMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07X1KCYA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-429d1a9363aso52205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725636966; x=1726241766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rj5X4jWsGQFekeqYk8dIy4ujKY1KtAbu6mrY3UaJpHo=;
        b=07X1KCYAItufTpvX05/2Lmt5ByL9L/P2iqVUZYsp2ykRR8mk+cxs2JI3gja+lu7HW7
         mJIkjzTyMjlvCoyOHYKW+KXs9/uzgLL6aMVNcf6IJ/sZ103vzrenUYkk5nC0Vsdu++5b
         LtM6TdIyweFc4i65kkySqP7P2yT741JmTxmFOMSgVAsFGNwoz6Gs8aEDW7yNAl13edaw
         cXJpNn/BuTYHeCWgRiSa9z+BTwVeNgdxW00TD0IAkLWL10/qKZO6kzSJ4Isp7Vq1gk4b
         5TthqpFwXsttdFNBB2xl0/SLXEgJkUVj7Oauck+OnwbwgDcwAM2FXMOEDdjRUmBsoMV4
         ZySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636966; x=1726241766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rj5X4jWsGQFekeqYk8dIy4ujKY1KtAbu6mrY3UaJpHo=;
        b=h9vTjcIR2hyFXb544VCPkYFIPd32bufUOxRtDMFZFu6U435uO6Sy4CkzJBs1eFH95L
         Y+lNB0fUion0aBwPUg4oJkES1ItNSjeOVR0CARDI7wDDyFQC4H/iECQU4i7L7pYlVITO
         G72y0QE01z2tZISXDUmW55y+MN5EHcSC9Zt9RFzjjzNZZCMWdvcqjNyyF07bj4WQoza9
         tDO7/so+3cSXTtQci9j3Jz9oFNC8v/u45Qi5K44UUSge6fwaUmAJOr44HBuBRaTHup0K
         sfTPfEdJCpKiFJ/sgq6BMZfVlhYur7pYg85FqNf0h6VBQHRmsvJMpjYQxF4P2Xt7ltD8
         JJlA==
X-Forwarded-Encrypted: i=1; AJvYcCVCc4xnY2hpsTVTf4FsHWiG5oNf//KtHcWvpxiG8FcXQzJZXR4u6WpZABfcva3G2SKGvg04IR3Kfqdyi9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYjsMeBaQQ9rpS6EshAEQrIjSTTeGOyhMlfXeeddWZBu9VFMf
	ueFnOfN6bLK6Wu+xQf66PyppqmtsLDn8q6qTRB+eBwrwQk2KFFg2jMFHYKccqCCuw1XiSnBw7Pl
	QORQam70r88Dmseu4hxINMqbiG7nlBjJcmRDt
X-Google-Smtp-Source: AGHT+IE8hkyzS5q4Ko5VZqZkxV9Egjt+wIc+exqGjXRMHN4pkjGweyR6LB4uLnV4p3/PgpVKz2OZ4tmqw3FeIBgUGH4=
X-Received: by 2002:a05:600c:1f0b:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-42ca0d73c41mr914555e9.7.1725636966172; Fri, 06 Sep 2024
 08:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-kvm-arm64-fix-pkvm-sve-vl-v4-0-b6898ab23dc4@kernel.org>
 <86a5iw3ri2.wl-maz@kernel.org> <fec60c7f-0cc3-44e2-8be1-09c120e8523e@sirena.org.uk>
 <ZowGFl/1AEuevh96@e133380.arm.com> <a3f2f13e-be22-4a09-a8a6-5faef818defe@sirena.org.uk>
In-Reply-To: <a3f2f13e-be22-4a09-a8a6-5faef818defe@sirena.org.uk>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 6 Sep 2024 16:35:29 +0100
Message-ID: <CA+EHjTyCvG2KL=LPhbAf+Wo66QoC_EMk1xn+R9X-yKunHQ-JhA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] KVM: arm64: Fix underallocation of storage for SVE state
To: Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

> > Can't pKVM just hide the non symmetrically supported VLs using ZCR_EL2,
> > just as regular KVM does for the guest?
>
> > (I may be making bad assumptions about pKVM's relationship with the host
> > kernel.)
>
> That's one for the pKVM people.

Yes, but that's not really the issue here, unless I'm missing
something else. The issue is that pKVM needs to store the host's SVE
state too, to be able to restore it. So hiding non-symmetrically
supported VLs for the guests shouldn't be relevant.

Cheers,
/fuad

