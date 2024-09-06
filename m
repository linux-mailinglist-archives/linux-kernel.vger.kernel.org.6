Return-Path: <linux-kernel+bounces-319187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE35D96F915
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1702862C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B951D3623;
	Fri,  6 Sep 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwvfZrIK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A31C9ECF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639290; cv=none; b=uNZnDQVz370bQ0jasPBdLc2eAlIdQMOT+5f/90QyIGLcXlp0/EHC4gCw34qLPv7TprhDeG+SmZpMv2EoH3jTt8oyhUxPmAqulyfsuUAFsY2RWb5tu6kKgPoMqy3i5JMR+e75rriaOslQ05gG/OcgKA6Y4RZieTaUAhQHcv4aWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639290; c=relaxed/simple;
	bh=d7Xo+RfZkvV5Im86rGD5nZcCUUCXRDcL9EuyMzVxPzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m21fBxfkgqIU7JkpHY8Psdt+ongEFVpy9dP73Rzetx1TfrLryl7fpts43iE0R1o5qX4+02Efw9NWSDcjj/yGkR5l3MqljvGMYncBGSie+fRryXW7ekIa4WZqK+srEbACv/J2pS1Jg/cE7tOCuHG/ash0ZIMj7fXH34MTqUSeHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwvfZrIK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bba6a003bso56275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725639287; x=1726244087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d7Xo+RfZkvV5Im86rGD5nZcCUUCXRDcL9EuyMzVxPzQ=;
        b=XwvfZrIKtLmuIcr/BWp+B5CDmVlwDaeirs+XZhiUEVYCztqEVVv1uN4WWNgah4wHg2
         XP9p53GnBk+D9nbrjdIYrOChxEXYJF+68vp+Ds/6Mp0kOvktduLXndLnV7BV2rrUP3MO
         9Cbgk6amXCzav6MZlyp+9w1EpaMxVh6BKJtCVOibaLqz5mbL0uho8nQUc3bdiryIRxlY
         o3jQJtOJcdkqHGGhzcECZemUvNYEm/mn+IzmVbbNE8tCgXplaQU/VxRhbAIrF+TulhJe
         MPNf1aVwZSlbDevzWMGiiT3Sk15w8/lxytLVG4f+e9oGT/vHooayRur6eJsFZKHJVJW+
         +zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639287; x=1726244087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7Xo+RfZkvV5Im86rGD5nZcCUUCXRDcL9EuyMzVxPzQ=;
        b=gTd6xWe8Xflh68YxOni3FTGFnjHBdNBoHeo1gCB7BG9sJNJvcQR9pU2lq5PHOTBlff
         skDpvFDPthksRiNaBuM/2CeFztHo9YIrjYnonef2hdCnaN5VS8tCC70FsZsWOAM/ePj9
         d1p0vkMlmvB3/+L4mjK0z4Bbo0zz7C3RD1xNlgVMzn8q/qjpM4ZERU2ZtI52sAlkoKkN
         wgjnNwLenQ07112ClxusCnFp5FuUDbZyfOhr2l5SbOq/efKvnI6VWYC7ApgxpzJsEFv2
         IRRIdGGodFOM2auHEhhNqkXEakxsYRj5kfOYtImK6AEOOC4fgYuBCQqUeYxyclM+s6+t
         D7mA==
X-Forwarded-Encrypted: i=1; AJvYcCXhQnmL3jd8i+bl7uMnpo0X+mA+nrYZcvE/8pAui6iDgBBNzhrUj21FjSBuZcM+yPriPt6xpku1XbPHWOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+I1dWv8FJpz1NwVjKfPDxV6eHSjYzWi3zYxQM+13cSggcCrZ
	bbM8SHD5gCtW62gFGSgrkd8zcnhJWwtvkYu9DZk4tICIb8rslJg53qwiA2Tk4I50u8s3gcLmm6N
	1uugwT1I8sKMi+dLhmRfR4XGs01f/6Qtq/+RC
X-Google-Smtp-Source: AGHT+IFv++mggnfzy5t3bb9fWZkEUp45jrBIXinNKhaV4bb3A0qs16A2pUmUqjVrnmxrsaDxzWbJOV3LKYwj01XAx2w=
X-Received: by 2002:a05:600c:1f0b:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-42ca0d73c41mr990575e9.7.1725639287225; Fri, 06 Sep 2024
 09:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-kvm-arm64-fix-pkvm-sve-vl-v4-0-b6898ab23dc4@kernel.org>
 <86a5iw3ri2.wl-maz@kernel.org> <fec60c7f-0cc3-44e2-8be1-09c120e8523e@sirena.org.uk>
 <ZowGFl/1AEuevh96@e133380.arm.com> <a3f2f13e-be22-4a09-a8a6-5faef818defe@sirena.org.uk>
 <CA+EHjTyCvG2KL=LPhbAf+Wo66QoC_EMk1xn+R9X-yKunHQ-JhA@mail.gmail.com> <Ztspjf0SHx7nz2lV@finisterre.sirena.org.uk>
In-Reply-To: <Ztspjf0SHx7nz2lV@finisterre.sirena.org.uk>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 6 Sep 2024 17:14:09 +0100
Message-ID: <CA+EHjTyjVMw5CtEiLoZzvnnano94UGx_URhFBd7BRYm89K+XmQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] KVM: arm64: Fix underallocation of storage for SVE state
To: Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 17:10, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Sep 06, 2024 at 04:35:29PM +0100, Fuad Tabba wrote:
>
> > > > Can't pKVM just hide the non symmetrically supported VLs using ZCR_EL2,
> > > > just as regular KVM does for the guest?
>
> > > > (I may be making bad assumptions about pKVM's relationship with the host
> > > > kernel.)
>
> > > That's one for the pKVM people.
>
> > Yes, but that's not really the issue here, unless I'm missing
> > something else. The issue is that pKVM needs to store the host's SVE
> > state too, to be able to restore it. So hiding non-symmetrically
> > supported VLs for the guests shouldn't be relevant.
>
> If the host kernel is also running at EL1 and it's only the hypervisor
> running at EL2 then the hypervisor can control the VLs that the host
> kernel is able to access?

Yes it can. But do we want to impose limits on host VLs when running
pKVM that might not exist without pKVM?

Although AFAIK, such hardware doesn't exist in practice, the reason we
went down this rabbit hole from the beginning was to ensure that we
wouldn't run into problems if it were to happen.

Thanks,
/fuad

