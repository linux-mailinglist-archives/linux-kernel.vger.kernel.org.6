Return-Path: <linux-kernel+bounces-309618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4868966D78
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B683281480
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF342AF1F;
	Sat, 31 Aug 2024 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8rcr5WZ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9C12E4A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063724; cv=none; b=IDmDvl2OHF0kiVelZ25GTzDdoUSGGIHhIVR3amdr8h+50/Ob6361wscZNgT1r8PgLfziQYc2s5udgsZOkVDqbORVKbJd41PMxbIIVtBJrD6U8x2YKCgxQPfAn815U0uOPyHffOIKibwUl1fzJ7ehz1oPGFs/5m7EBYCPSn8biho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063724; c=relaxed/simple;
	bh=vw86yD5qMg97x0yl3i+3uDCJ8Fe9SFkrt20HLRotJhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/ErvDnO4ksvjXrYlnM9tNJvvbd5knZinhif+Dv4DkdXKMsESgtYzBP/A416RPQbt2Yi0cnMuU8FHGmIKCKOrkQsIPknfjdnoI47f4Rb1sWwCH4j3YocAbFJvvQAdrhzAoAyMJWkYOAaZ+tmajMvqm5LiGD4cerhJEgiK3HWCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8rcr5WZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-201e49afd9aso29569465ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063722; x=1725668522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bzBZ6jVugRAK29EUIIi8mz9iSMsHNfrMYLCx/c02UY=;
        b=O8rcr5WZejf7lm+vfjzHKYxKspRE9wASc3s7Y/IqRjLFZKUU0ixSxx15OnklBnms6J
         cm3XWPfxk5P2JfTxLS9rg8UU3QU3mN8lN17q2JaSGmPsQCvJid5AzAaQl9W9EG/4wczx
         QGs7htGFxqWPxsRoxNegKg1038r1XxUuFXHJ6jHbKs6kO8wQ/A4Y+lmABcwb/8h6gXO3
         d+1AMaBctebUzTTp6HsdRemP3jPRowJfPklz6vSLkRLTPLgZq76jdG1d0LkAJ5h0ZWDc
         G5InU3+4b1xQ8CwpxpA1faYfT5S4HW3cCRfx1PwWb6ZZyAEA+aIdmW1vo9qSamLVZSWd
         eh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063722; x=1725668522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bzBZ6jVugRAK29EUIIi8mz9iSMsHNfrMYLCx/c02UY=;
        b=Zvq6mBF8Fwjqeuo9UKJ7LTW45vRi7QFz0hErJz0b76cZMQ/elpA7W+8pFutGP040yL
         mW0R43ecU2c7yAl7oR7U733yOTCqQueto3iaXfYDFIuTqkYFGh6vtVAjGfq9nSrCTlYo
         wppjlOKz7BIrBGYHqbmdcEg7tI/P855RzO9f+Czwhww3xTxQZjwf5UkFlvLI/ds9UQs6
         bRQdtHd64OqHyxScUqKQkBX/DSrIdBaGBLOy4UJwSCREhvrCCCyEq1SUdr8zduLBANEZ
         izpZSWaHkZ0r6SEm6jHOMT0jptpicBEpLhSflkWa1ytBq486QFQ26FT6fzIpEN8Mw76C
         z+pA==
X-Forwarded-Encrypted: i=1; AJvYcCXbZRZRvozLyR9gWbOBBMhaJuzsdXQGLfvOx2sNtWY47pHBycQ3FelX0wPS1SKZV9wb6ogB+38sidA/lYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvN/eVLMbrVjXz71Q5OdTlLctihsY099Sboy+WOdUKVnDTJ/Ym
	dS8kFTofeKFtfRkDFThZP53tt6HGz2kRiBzj8qSgApWqsUzZ0BN2eX/RwFe/XmrVJFJLOveqA7v
	VoA==
X-Google-Smtp-Source: AGHT+IGdpUX3VToFo4nIaK9SSXOYlSGllyeacR52Vw6RT9ybJgTIqagXp+nztNfoIe0M9lF5Urbzr9FwesE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:db0d:b0:1f8:66fb:1683 with SMTP id
 d9443c01a7336-20527a3a3a7mr2191585ad.3.1725063722099; Fri, 30 Aug 2024
 17:22:02 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:21:01 -0700
In-Reply-To: <20240802201429.338412-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802201429.338412-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <172506353058.338300.7439939228083527031.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Always unlink memory regions when
 deleting (VM free)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 13:14:29 -0700, Sean Christopherson wrote:
> Unlink memory regions when freeing a VM, even though it's not strictly
> necessary since all tracking structures are freed soon after.  The time
> spent deleting entries is negligible, and not unlinking entries is
> confusing, e.g. it's easy to overlook that the tree structures are
> freed by the caller.
> 
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Always unlink memory regions when deleting (VM free)
      https://github.com/kvm-x86/linux/commit/c0d1a39d1d20

--
https://github.com/kvm-x86/linux/tree/next

