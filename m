Return-Path: <linux-kernel+bounces-223703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251B8911720
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304E21C215A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6FA34;
	Fri, 21 Jun 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Leu36Pp"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34C17C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718928523; cv=none; b=qYcKANcIPrTYEZpufrRI1nAXgK18vcLvKFLmU58vNbJJVitIxNFq/8OEi8Nwtf5aq+tvqSUkNY6lYvvE+5KI9JrBdIfE+Aqd+dqk0AM0kDcme0r5NgoRv+KwwPXn+DNl5r5JWHgnRCHgU6SOZ4k1ptsEdx27CgKaHUi4InMDdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718928523; c=relaxed/simple;
	bh=ISBBegW703W66dTNDEhu09uWo2ThDdUCST5ziAh2y3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NC7d/cylNyR3eN4zas6tPmikL/r0EOHRhcmqiYKYIhsHcSd0Ow3G2rpOoSCvy3yEVBOEDhIJXTI+Ttr0r+kHTz/atJXVt9WbTCRmL1A464shtLitO1lpN/G2ggCDGgrB4enkww3AFmuWFp5EllRA4TgzLudzHXVQQ90DmDyQ5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Leu36Pp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6e79f0ff303so1254146a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718928521; x=1719533321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1M0qJ9Mx2uTBhiNLhNcShvhwKtaqNwMToy/ggjAM/w=;
        b=4Leu36PpsFufqH/KMSm69XB/ukO/Ietg1h6Y/tRxm8kq0R3nBFDaSnW/Cn/3ajLuqV
         LHP+1vlmT9nSFw/LfquCZkB1b25EejN0WYiMQxMG3yYSmH+Yms7dSkHvjq1SVLaH3f4E
         y02HGGN/Lwi2EbqbUeBuMfxlyqr4VDhFGys0pVMocRIxNEH/jVQTuV9ZHAamis5f16g3
         7SyfbdGJZ7UUWOIp190tR/HSB8YZrZ48KsA6iOMGd3W5hQSiAi3c9EbMUPiAC30m6pjh
         OMkF1p5PAO7Tw5vEXMFe5q2kbc8Sr9tCanm8rFNYY1XsST3emEd9tCiP4g797swnZCAh
         b37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718928521; x=1719533321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1M0qJ9Mx2uTBhiNLhNcShvhwKtaqNwMToy/ggjAM/w=;
        b=SdhLWdBRmXbEhqcW/883hr4PoOLG8eLwOJC4fGF6Yw43C0XQMnTZXomA4ujXm+neh0
         D57INlLIu9CFFWY5xMxzbCl6JfJ1JZHj/Hykn9VMZYvBsMsK1kNxsyXKZ+5yc8dYx9rj
         AjVzlK3ctnDRTTtbJJnXAPDxkeEpfBddp6g6qJHjtlZK/UWW0w8kIhk0OefmfzbeOy47
         N8S9WPjtARR47bSgkfbaJDt3wjNmHBw3AuLM2ENlax/4VGeOdSghm1MNmhGxXv1FYgaI
         IZMlJghEJkcUs++PE/OMmuSna3zugOYUcssVJApHZaq8wGmwRwjKw5kOZzB7WqE6a6vy
         j6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuSG7+zMQV0QO4JigopuplALGQUkwQnSLcy6cXLGc5XqX703fbx651PRqSoOumjygr+LwZ+rhAb3lZrCjJ3oLy9YSQ7+JRck3L4tmg
X-Gm-Message-State: AOJu0YxDeOLZmm3pwLKEbHHFiZkNDX57tylrPnXIj1uoHFQezq/Fef9d
	XvoV0d4eVs0vVhM/yrYDdm+YXcBo3zpNQ8LfC1r26QfZEPQadiARFK+XnreT9PXfX6Xz+BLnmOo
	OYw==
X-Google-Smtp-Source: AGHT+IERkxf3MqLsWOQpA9p8rwu/+0akF0lLP5N04RIZQdOzBjFXwegmUeEE1wtq6w6SRKUoxSzmurArdt8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:5a0:b0:6f9:6bdd:628a with SMTP id
 41be03b00d2f7-710b8610057mr16907a12.9.1718928519519; Thu, 20 Jun 2024
 17:08:39 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:08:37 -0700
In-Reply-To: <20240620193701.374519-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613060708.11761-1-yan.y.zhao@intel.com> <20240620193701.374519-1-rick.p.edgecombe@intel.com>
Message-ID: <ZnTEhQo2r3Uz9rDY@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Implement memslot deletion for TDX
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: yan.y.zhao@intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, sagis@google.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 20, 2024, Rick Edgecombe wrote:
> Force TDX VMs to use the KVM_X86_QUIRK_SLOT_ZAP_ALL behavior.
> 
> TDs cannot use the fast zapping operation to implement memslot deletion for
> a couple reasons:
> 1. KVM cannot zap TDX private PTEs and re-fault them without coordinating

Uber nit, this isn't strictly true, for KVM's definition of "zap" (which is fuzzy
and overloaded).  KVM _could_ zap and re-fault *leaf* PTEs, e.g. BLOCK+UNBLOCK.
It's specifically the full teardown and rebuild of the "fast zap" that doesn't
play nice, as the non-leaf S-EPT entries *must* be preserved due to how the TDX
module does is refcounting.

