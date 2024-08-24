Return-Path: <linux-kernel+bounces-299786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0E95DA15
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65D7B21F75
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD9410F1;
	Sat, 24 Aug 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrJv3Enc"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98724382
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458042; cv=none; b=QACLLD0X3bt/vh7Gqz9N1S+SHFb1WgvCeIfbYUIwJcYLzi3FzRz8hCJFX/pE5SCMjIqdIIAjlvZ3fISs9l85hNAn+iBACy4EILkTLhsARCH+9MCCZLMTupIT0uXQ8sHxMnH9eEHO5tmn9fqJhP3ZM2pcNGD9WZcX+QfRSCxnyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458042; c=relaxed/simple;
	bh=UxLc+reGhnIYZ/XmNZ/MTTNcsHGvZUf9GNv+aLMVeRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BA96hC4FEZGlcQ0tWZ7FUW67Frhi00Q6Cxzr+u7niHeA8AqhdafUILQoei0n3/OhC3dKMkXXVINeWlRl5ud0ATNHpEY60uERjg8VSNtwFr8CZvKoeFJalMdg9L16Z2GVsZmFQ3T45/5R8ArZ8u1CJ0xd5EaoNdBei7N16hBihio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lrJv3Enc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20202f196c3so26518365ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724458041; x=1725062841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cl0NP/cfexcLY+3i5gFKc8CW6ky57wXGpDj5wl38pcY=;
        b=lrJv3Enc1xWNqErK6kk9TrfrxgYgsJQ5kWAGAD4fYIL+4qPgXTPEpE7e6QZ4sxCIFS
         fGq0PONX1YfFRbp/+G5E7vBN/evZs3n+Fy0wfZF8GQrNkwyFMeYrZcCUPhkOFw/Ftpz/
         LejQZMsWnIA66pchZD1nK2lXG+1985rsDURp9QGC2KF5uUg1RgtqmkLZBcfHp63wHKDx
         ncB6Fy1VSkKCPiGIPcOe9BRy+g0Pp6rFa45DPhzTOXo5DBJO/uVy3TOddonHb5lkRzF3
         2En2/B+vTz/BRoTZewvV2ygTefr63FRVSxHOYsTqtbYl2pH9Li0Ba73QmtHx1MwMz6rn
         fxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724458041; x=1725062841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cl0NP/cfexcLY+3i5gFKc8CW6ky57wXGpDj5wl38pcY=;
        b=NrV1uMjAYwPr4R9aRVdjTCs6XORs6//yDMkF/sYvYQ5U074mL1HCaLtdCdDZPbL0tc
         9tAZWc7mBMHmT/E2aGBcoH2r2MYhQRk9Fb+iYeKL+4V7hPfipmv8MqB33NoQ8l6xIzjU
         ZvagtLE611w8nAJGp3dK8VxUgWftQtshJb4tYGQeudFSAsu+8HDX8KMKYGRGOUPoz8wQ
         OZupwXpXW6pDxfE3198lxeMcl0JTvo4wavNBRGlzc0K1XGuikuj32AX6BR3pG7mHw1Pa
         JSgdfZCYDSfhHNSjcZm++rFWnarSeS3vTCD8YHD0qU1EPQxTxXPfavcudQygBRvCk/0m
         CUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu7wi7Cg9fGIIqD7dxjVvQCiwYIGyqJlHG+38X2RZVqpkWzCWIJ1xCg9RKahu9R3BhTvSs1RnpExW8BUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQN6ujdNIzdP27KR1Stp2WpnMv+8+gku1cUx1HGTNC9Crk0JTM
	xclwVCrY6YXwDylCdB2TbwQvL7O6ig4VROt1G1Jmc1Se2j3QPLIBn4ivOhrWJAR5XG+oQhUIIG7
	tyw==
X-Google-Smtp-Source: AGHT+IEm1MG0noaQz6f9egaj2JTStGrKDvJgtPOeJ9adqBSydYJilv9O6/dOicg7d/F+0wqnqZBXruBF3sk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c40e:b0:200:86f4:fa1b with SMTP id
 d9443c01a7336-2039e4a7403mr3085345ad.4.1724458040544; Fri, 23 Aug 2024
 17:07:20 -0700 (PDT)
Date: Fri, 23 Aug 2024 17:07:19 -0700
In-Reply-To: <Zr_M4Gp9oEXx4hzW@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815123349.729017-1-mlevitsk@redhat.com> <20240815123349.729017-5-mlevitsk@redhat.com>
 <Zr_M4Gp9oEXx4hzW@google.com>
Message-ID: <ZskkNyOoQqiOYKM7@google.com>
Subject: Re: [PATCH v3 4/4] KVM: SVM: fix emulation of msr reads/writes of
 MSR_FS_BASE and MSR_GS_BASE
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 16, 2024, Sean Christopherson wrote:
> On Thu, Aug 15, 2024, Maxim Levitsky wrote:
> > If these msrs are read by the emulator (e.g due to 'force emulation'
> > prefix), SVM code currently fails to extract the corresponding segment
> > bases, and return them to the emulator.
> 
> I'll apply this one for 6.11 and tag it for stable, i.e. no need to include this
> patch in v4.

I appear to have missed my normal "thank you" for this, so here it is, in kvm-x86
fixes:

[1/4] KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and MSR_GS_BASE
      https://github.com/kvm-x86/linux/commit/dad1613e0533

