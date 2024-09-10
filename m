Return-Path: <linux-kernel+bounces-322408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9889728B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6A284981
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315951684AE;
	Tue, 10 Sep 2024 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQVUiXak"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA81531F8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944322; cv=none; b=XyKn14M9c3mCfKAg6Jfplopamcs8dTlDGO7lTiQMeeYiNl8EAd6ZzNesAhyqZx0s3hzA4yci1y6DGo81Q+67QF7t565PAjUcp74btypV57MXG/18GoPqr6yNocPLzEHKqOx8+E+EGIQ6Y6IOFBwU3WPDN9q4Mb5sl7mpjZyqR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944322; c=relaxed/simple;
	bh=dJaAYe8taoaphDzwAxP5s7uks0FfXXrTZYZJDlRoqro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HbrwHBPPIoWQUwWCGRZ2Ll1/OhsiD/g9IyGZG6y4zbHdXuALZYRTTb+JcT+teLm1BHp1NXL19E/P6eupefVFoomvsrKCRzCMQRcmke+bvLMEmDEOqWw+mkui+UyVi/aRcF32Q31zgHMFCVkdhczZCOWr+Fh1wJHb7X5+D4PO+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQVUiXak; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d8a4fab0d7so6266240a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725944321; x=1726549121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctxPqvtN6tXOnflyu7Ll9TO7tWYMIjdIy+cR+i4LWlM=;
        b=lQVUiXaknorHE3lFpeSI+YDmlQeNvJcV1J0kxBG8GmYO+ijG/ksnCRT3J+mRY8uPo2
         gGrHgqUPo32QghjN3WVEAUWVKH3mQwrl3ptLQuAcuwJtbZLgh4LKHXeiGa5joqzOIasy
         PiAyxhLlnJQLuVxKBYdJwN1esJqi3GW4H2rWvUSP+ywHrcP1DB6kfaij1zSlOWB1XAx6
         bMp8xPymzjbrmAKU1QMODKjQ+ClltMluTyItKbnJ+E4b2EtvfcSIMu7ipj9dfqJWCm6I
         K/BreWSjvA9KzVor4NzLIhZ9QYY6o/4kXkul4RFonY24PeKB/AKy/iwHWtF6Pbbb+2v/
         rz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944321; x=1726549121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctxPqvtN6tXOnflyu7Ll9TO7tWYMIjdIy+cR+i4LWlM=;
        b=HnlviOqgzGj64L4gqZLBxg/I44WFNWen1wkFeQekFpjMkasCcH+DTc5mSVnXic5ehk
         XfDOK/zpEq58ANLnVABIrBic+q2/PVMz3Og5mvBf9qwa5pwVIPgLu3Ls67XBxdyh4+U0
         Plho/t0qIKiAS4iSlL6K53YZm0ryphIJyFdzF4Fif6Hml8E57S9cR3fSPtU8HtfwrLTn
         cAS3fXZmX/ob3vupho+qe1alEBOfphjszTHCHpDpwyoHN3ATLCOFvMevPzcVZH19hGYF
         awZKZZ53hjpNaX+iB8yUAkHmnEbgRp+BGDN3jmP9sw652MpSObP1H55XjYDgjS0t5MpP
         Xqcw==
X-Forwarded-Encrypted: i=1; AJvYcCUjnpRhBOoc+UtxsrLnCDm7Z+nH2lEfln1tWawBczhMQM1f2412zr8kPvqXRTe094fzqhjuJ1YKgyrz9Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRsQzVjwKXXWC6zUuxogh3Q5w2VXMOeA0mkowg6HmtRkBuJJO
	tOlc74gU6iB5xHh9NbGDfhd7vOgrYtYQfbNsgrrGss+klsbOTlNno04ZdzBNMvzBy5iKfLpd8s3
	tdw==
X-Google-Smtp-Source: AGHT+IFbn75t2C3kpQcMrOPy6y+G/tZIkGTTtzcSeihYGhxMuAYQIKZ+Jie4rnA/tJcKj6E6kAKPDfRIqlA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:296:b0:2d8:f814:edf8 with SMTP id
 98e67ed59e1d1-2dad512ca09mr120988a91.6.1725944320396; Mon, 09 Sep 2024
 21:58:40 -0700 (PDT)
Date: Mon,  9 Sep 2024 21:56:32 -0700
In-Reply-To: <20240830022537.2403873-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240830022537.2403873-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <172594252038.1552710.4200877965473080029.b4-ty@google.com>
Subject: Re: [PATCH -next] KVM: x86: Remove some unused declarations
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, Yue Haibing <yuehaibing@huawei.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 30 Aug 2024 10:25:37 +0800, Yue Haibing wrote:
> Commit 238adc77051a ("KVM: Cleanup LAPIC interface") removed
> kvm_lapic_get_base() but leave declaration.
> 
> And other two declarations were never implenmented since introduction.
 

Applied to kvm-x86 misc (I have yet to post my APIC cleanups), thanks!

[1/1] KVM: x86: Remove some unused declarations
      https://github.com/kvm-x86/linux/commit/4ca077f26d88

--
https://github.com/kvm-x86/linux/tree/next

