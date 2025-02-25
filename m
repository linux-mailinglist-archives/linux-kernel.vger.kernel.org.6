Return-Path: <linux-kernel+bounces-531856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643A7A445E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AADC16CFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF56118DB14;
	Tue, 25 Feb 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7Pnd9rj"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4818DB11
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500527; cv=none; b=GXhZxce9SL5bCtW+x1k6TV9YI/2XTIHLmhU4vZyBA4Klv3b6MnZXsoZy7Asl1zzNZMRZJbrgDAGD7tJ549Yq2196fLpdfYW69OtnnO16FH+oLMQh7oMxj5x7joM/kUh6X26+ugS2slR6H9s2cVWRRVXQp+DzvPXetWjvrfy4sLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500527; c=relaxed/simple;
	bh=jM5sQZeJ8NG2PUq6xbOumgp5f1nJYudVynbtXZmZVOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpmWD+r8n4/Ixpw9TdGz+gjn5imG0EwCv6KmvkYB79kMLAWgGDFyCxWiA6ykPoVMnYajH8+xgfr/VZdLbEX8NuaSBqsNguGv6i43xuqPzLaAgSXWVDJU/6j6J0+GFRLVaAqRKFB6qopRMKwwil2Bvg27LEnknRom7Z3Lcy8zjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7Pnd9rj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220cd43c75aso187149045ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740500525; x=1741105325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=srEHHPJ1gbuHEqVaJLaXK3crvBH+hHlIUvswV7lRBmM=;
        b=k7Pnd9rjA+148lq/gxPqt0SFXUlmJr0pUTeg+M2a3IDhHkGtw7cqeSMjRx8BsurWrM
         9xtake6Q9lST2G4axByK2hsPxxi0evpTBCpGkU0WhZmY9NnnJQ3u1c6KS1Gy7ThH2JJ4
         BaS7ZIOtJphchBH/eYt5gsOchwPu6qfI28ZqSY89aGNu0yfk3XYqA2QPTwlBbe6sh4ac
         IUSiDua/S3JM+0A23bXBZBDyAV+2vzSgiofGP7ICh1NHJkAznSUGWY523vXNLedC8it5
         OKZfQp5ItNDcUYJvOS+97m+IeE8Uihx1VqepkonLPDmxmKO5iZcDCHD8DI5bF4tFMaU2
         tZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740500525; x=1741105325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srEHHPJ1gbuHEqVaJLaXK3crvBH+hHlIUvswV7lRBmM=;
        b=NR5Cut/j08GAA5TJb3478CXVumgamTtU1L4kJ33zH2a4vWize/eC2iHP4HSaO7AeSV
         jsqVzKvZFzyygrY6BCZC3nts8/+hCNzAZrIODk0c3AHMw1KdX5OBTNWAjRUfLkHCK1WD
         kr0StHLpO1Lpwyk6NC1DIHBBfOOPUIzeFYMYqphpiAciXx3UZFbiDLSgzNfv4xyYmnlH
         fe2pikMd+Ut6JLWU9iD6WKzIpgiNl3NxNaO5NXxjo98jGDpjdeT0UVQYY/US/4ZoeegU
         6AslvrjRst/AstqKSLIMCp9hzFUqykjqRV1UlTPbudhjBR7FFH24+aBemCoC1G6uENoY
         85ew==
X-Forwarded-Encrypted: i=1; AJvYcCUB+zktfv/wDLRyHdrRQWQcaskG2E69Li+lZj42S+YFC4/FOXXkIrKXnmtTuhs/nvJ4raEhIQbQtqnVvRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrtkEI51d0AITfQ0DASTUmUPHomOaBP8MfI7f6vNXaq5s4fVk
	kvgD6HGBL+5b1H0mpd7g2VIDfvoCRbWHLQ9ptTPq14OnptgCxNT6bCmA45LlcWPOjtuWjX8DDP0
	OpQ==
X-Google-Smtp-Source: AGHT+IH27/HQuhUl4nm8ASPw7CT4Y/JWCbdYuVCqkOCpy822McQQGOmUejPqAig7S/UmITePMhyGuWHT7Sg=
X-Received: from plog7.prod.google.com ([2002:a17:902:8687:b0:216:6463:1a1f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50c:b0:220:e5be:29c8
 with SMTP id d9443c01a7336-223201f7ecfmr1037415ad.32.1740500525271; Tue, 25
 Feb 2025 08:22:05 -0800 (PST)
Date: Tue, 25 Feb 2025 08:22:03 -0800
In-Reply-To: <20241001050110.3643764-25-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001050110.3643764-1-xin@zytor.com> <20241001050110.3643764-25-xin@zytor.com>
Message-ID: <Z73uK5IzVoBej3mi@google.com>
Subject: Re: [PATCH v3 24/27] KVM: nVMX: Add a prerequisite to existence of
 VMCS fields
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	peterz@infradead.org, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 30, 2024, Xin Li (Intel) wrote:
> Add a prerequisite to existence of VMCS fields as some of them exist
> only on processors that support certain CPU features.
> 
> This is required to fix KVM unit test VMX_VMCS_ENUM.MAX_INDEX.

If making the KVM-Unit-Test pass is the driving force for this code, then NAK.
We looked at this in detail a few years back, and came to the conclusion that
trying to precisely track which fields are/aren't supported would likely do more
harm than good.

https://lore.kernel.org/all/1629192673-9911-4-git-send-email-robert.hu@linux.intel.com

