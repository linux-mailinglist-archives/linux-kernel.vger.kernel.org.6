Return-Path: <linux-kernel+bounces-234677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F267791C95E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED511C229F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50D3824A0;
	Fri, 28 Jun 2024 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWfgKgPM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE198136E30
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615405; cv=none; b=k0gdMCuUFRNS7iEw9euZsCGq/lzQcHVNI7BrKFhisokqpdSX+ssj8cmSzTwPTEx6ivyvIk5oVeaVn4HJ21phNae15Y2KmoX5kfCQkeFpDiBUWK5BLZgX2BjKb04yuvo5idYwh1UkJHwQ85B03tVAkoBXflEELiUvzfqVMjYn5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615405; c=relaxed/simple;
	bh=V8Xs5oEFMyWlCgx0JVqqdmlYRkAst9Z46Jf62IzRvcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQZ5N46SsX6xZX8ENsNHPnW6/lScC5Bt0lstuaRqfjrHk2c8z/FmneeY3elS9Xio6f5np8Rdfqzv74F3Pw1NzULk2jCzAdLb7SVNfJF9L065mB743E+VNCYOyryjEMUkC4OobK9eDFayscORtjyYY+AV86BwFqI1Ozx/GdspJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWfgKgPM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7065ba27265so1067880b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719615403; x=1720220203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g7HC7NkoYhxDVDG92lRPzaTUiH58rybHEhDqDsZUck=;
        b=IWfgKgPMXlAe2P3mDNq5XsvdOKgmGEJ86xCJ/m4fnHOQOpcrNRZazRgmriElJWvZ3B
         ixY4OaPe6fF+h09HiqPlnaCf+58gt6HFiGsJ0LN/xrMk8GfKKtLMc8TTP4L8QQIKLcF9
         s3v4wrHplm+kH7RrDlPudOzS0Ooxqu7R99s/SwsboD1uITkzJ1CtQ4q4myCYEN2IZsLl
         ysptAJYwGkbtlmsmi/AMxQt2B3fdjbsMR3xx5Es9yKkFqw7VWrS4h1vmhZc1h9ta1P3F
         nDz3AuNf8BfDSNRC2g1HEn1mxF/ITdH1SuUE6wlRKZEnWo6WTip/wT306hxu4IHJkV5x
         i+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615403; x=1720220203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g7HC7NkoYhxDVDG92lRPzaTUiH58rybHEhDqDsZUck=;
        b=j1CZwIFSw37q37TGO9lShBXJ/7w733XZiNPXOetrSY9ain/o054X05OC06yBle7sgT
         N1kvFuxzDNFqJ6zL00jQ94T8DllMsMKGH7wR54rrBnbqmGT9y85bjYqlv1+cJX2qxcve
         yurEEDEdPw32+W8zHF8l8NDjxpbtA2ciiudf5aGaj/WPbM7IJM5VzArKRuhzNOQCrqMx
         kGJuG7TBXCzgqpi61fxjHpb/tOoriTxsLONgsnM4eAb282O5JOdMJkdm2RBp4y+r305z
         RltNtA2+8uksOS1zJHMXkdhCQi+dTpCbCvxu1gYeLf58jWwI+CoHxYviKCdQCb8izgtk
         TEpg==
X-Forwarded-Encrypted: i=1; AJvYcCUX7qQS7Q7DY6TPP0zywuDu/PbKywr7U3fiG3+AN8YWXYKyA145t/E9olHZdhauQmFSoL1abaCb+VC709LoF7WuxDnPn4HlD9AhsSKt
X-Gm-Message-State: AOJu0YzEUNsnpdyJ1+pO6BdNqXHytgnym+535vV+GVqGLwB1IvVTMU+q
	URW4C5eOjBptd8X0NSDCFOHHTxZaUauadhenhOmcaFo2kJ8DO+hP55AwPw1d8yz8vpcxTV4JAri
	J3Q==
X-Google-Smtp-Source: AGHT+IFZIbWVtsJRk3IDXMv9GyWL21Uev0d/2w5PPrA739Xt6Gum+2Y1d5bUgMYVpteoD7TlihsqXTeYBvU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d0e:b0:706:2a35:66e3 with SMTP id
 d2e1a72fcca58-7067482fc9bmr387477b3a.6.1719615402966; Fri, 28 Jun 2024
 15:56:42 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:55:28 -0700
In-Reply-To: <cover.1718214999.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718214999.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <171961507216.241377.3829798983563243860.b4-ty@google.com>
Subject: Re: [PATCH V9 0/2] KVM: x86: Make bus clock frequency for vAPIC timer configurable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, isaku.yamahata@intel.com, pbonzini@redhat.com, 
	erdemaktas@google.com, vkuznets@redhat.com, vannapurve@google.com, 
	jmattson@google.com, mlevitsk@redhat.com, xiaoyao.li@intel.com, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, yuan.yao@intel.com, 
	Reinette Chatre <reinette.chatre@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 12 Jun 2024 11:16:10 -0700, Reinette Chatre wrote:
> Changes from v8:
> - v8: https://lore.kernel.org/lkml/cover.1718043121.git.reinette.chatre@intel.com/
> - Many changes to new udelay() utility patch as well as the APIC bus
>   frequency test aimed to make it more robust (additional ASSERTs,
>   consistent types, eliminate duplicate code, etc.) and useful with
>   support for more user configuration. Please refer to individual patches for
>   detailed changes.
> - Series applies cleanly to next branch of kvm-x86 with HEAD
>   e4e9e1067138e5620cf0500c3e5f6ebfb9d322c8.
> 
> [...]

Applied to kvm-x86 misc, with all the changes mentioned in my earlier replies.
I'm out next week, and don't want to merge the KVM changes without these tests,
hence the rushed application.

Please holler if you disagree with anything (or if I broke something).  I won't
respond until July 8th at the earliest, but worst case scenario we can do fixup
patches after 6.11-rc1.

[1/2] KVM: selftests: Add x86_64 guest udelay() utility
      https://github.com/kvm-x86/linux/commit/6b878cbb87bf
[2/2] KVM: selftests: Add test for configure of x86 APIC bus frequency
      https://github.com/kvm-x86/linux/commit/82222ee7e84c

--
https://github.com/kvm-x86/linux/tree/next

