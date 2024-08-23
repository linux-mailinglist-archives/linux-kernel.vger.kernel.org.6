Return-Path: <linux-kernel+bounces-299774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00C95D9EB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF021C224CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19141C945D;
	Fri, 23 Aug 2024 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTcSSNh5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238119342B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457269; cv=none; b=Ybb31N7sBPcJHyCQvULkyczaBpOyEhzfBmTnweHqH8OdjTHbLAiqTYmy+Zp4jXL9uEgZs3wbmMy2VbP8M4rEvoVwl5nzRr3dR7f2Z/mNpvD84WIqBe01wj8OLTYvwQ6fmV2O1rTx8DqsQr8qShEZMJwV/E6A0JQhwMWZ+wn6law=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457269; c=relaxed/simple;
	bh=NFrH6QKQdAm7hqhMi1X6Y/Mb5BH/zBlLUwLwoHG2TGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O1D/YRxx3gfSOfBPCoC3R3JHjKtKTyNIg0rf7PcpkgZdbUILVqJdL1SFjM3pX++Z9YVP5r5xgPu4f6mzSQ1qr7XWgeFfDUboGXX/bhaggOuA/G9/frkmJmUYvO655YafwWdfUf2zLPBJUYTjprSG9B2HY/0PVS7Ul3S+//emxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTcSSNh5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6adcb88da08so51157697b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457266; x=1725062066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUG/VbNxzCYgL5k/uczQ4c0VmpcWo0PYIg3efsPlOFk=;
        b=oTcSSNh5yhhsq1DFNTCP0RbI+QyhH1VTTM3cPwjPc1qrLTpocMyjEX/zeixBjvZv8d
         e0MC3+1USoJ6u7AUOKqUBhVMu1cuznuu3cDhJmxcVKs/8hqyBBHzxDa1zt7SzoKjkD/h
         sqd53D1ImYxS87xRMSW+7ZxQ+pql49nro4iZSU45vRBgzxHDHgeA35vNXLihs1fgGrsg
         J29S3FKQbLrwjxUBCvc5DlKpZLNvKgN51WCPsRm3GgDpCw3dvi60vedXCbSUkHSYk5z+
         m6f2VrSE2ueeF3qL4kg/3WIoUq4SDPTtNyDZXOqxaOekMbtfNJ1LFUaBy69mqpyyJH8p
         FKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457266; x=1725062066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUG/VbNxzCYgL5k/uczQ4c0VmpcWo0PYIg3efsPlOFk=;
        b=tdoLX5dqE+zTVnJbGADKyKV8RYzCCqFB8IgRXKJKZxCQ9hst9N04VnYjNmy8NR5miI
         FuNcQ4/gSrB/iiomLWhBthRXUcNXXgsCrWH7r1UIEPmSoNYEvshOWTbzvI3SqAQ6hEBk
         i1ooUFL8ucRsjEiqJ7cblGG1uDVyJqpniko2kbIQqddfakoNBueyL7+tAeIIkWE0oH/d
         jQp6I9eNYnaTqm8+FuzMY2Y9bsQmGxjdzKGhHicSw39ZdVdehKFSoJg75Bh1fK5vKEV7
         FSgMPhS8E/i8PnwTzXZ5rsnrmICAX16kiGPztpyCskObB60Y+V1plrrFzLba4mOou5gm
         pyeg==
X-Forwarded-Encrypted: i=1; AJvYcCWehvridRMa9BWc9mQ2Re7hOHj95IoOqcfD3g37l4jLJkle5v66Afu+OYRHwik+v1qvfUpD99zkvdI8lEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6muc/OwVLW6hn5qT5EmxnZeqEuT3Xj4ukVCaxC1IeKN/FaOj
	w4vZasPWttow2j3+/+G9R7DGAZopZhzW374EAK++pfNTA2TmW7WbRGG35qMMoCzZP70EP4u3zlp
	Ekw==
X-Google-Smtp-Source: AGHT+IGS7BvoZUmzKrI7jiLE5DmLS4L7wkzo8CGb427MM110ZTx0sqvu9MQ9sxKwDppX+ynGW5ty+xXVnxA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ff08:0:b0:64a:8aec:617c with SMTP id
 00721157ae682-6c61e8fcf4dmr1253387b3.0.1724457266663; Fri, 23 Aug 2024
 16:54:26 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:47:51 -0700
In-Reply-To: <20240814203345.2234-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814203345.2234-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443883227.4128803.4411198613341670589.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Optimize local variable in start_sw_tscdeadline()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, Thorsten Blum <thorsten.blum@toblux.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 14 Aug 2024 22:33:46 +0200, Thorsten Blum wrote:
> Change the data type of the local variable this_tsc_khz to u32 because
> virtual_tsc_khz is also declared as u32.
> 
> Since do_div() casts the divisor to u32 anyway, changing the data type
> of this_tsc_khz to u32 also removes the following Coccinelle/coccicheck
> warning reported by do_div.cocci:
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Optimize local variable in start_sw_tscdeadline()
      https://github.com/kvm-x86/linux/commit/1448d4a935ab

--
https://github.com/kvm-x86/linux/tree/next

