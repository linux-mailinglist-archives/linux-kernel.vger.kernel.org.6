Return-Path: <linux-kernel+bounces-395944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 271599BC52A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40071F2141C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A461F7550;
	Tue,  5 Nov 2024 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlWZK+9Y"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B291C07D9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786254; cv=none; b=YG3Qm3Dw0yI8b2Kh6htAICwz7w/pLlanXeHWSoKRE3hQNMFOPPuoiFvWG72be8EFgW7EM9WFzUv/0jqiUAUY48nvXzBzm1fNveMvTMpaAFm0cpm1ChcgLf337mIqjnI9j3Aa6b/JQW95agwQUTyl5I1hv8fkq90c5kSuPL4rHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786254; c=relaxed/simple;
	bh=i/u61Y6hRlUZbvtVL432X3tNFdkVbhJ+lBnGpyX96oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UJlQfUTG62AGxRiRMMGQu7gSlLNn+bBDFMOslKV2wVD8uKytgjzRLFHg/xNczauAZLSdp0DMWig2d3eYRLh9boprIyMj3Es4ZVr2NjSNU9zu/SqZ6c3EtMo62+NsCUWM/nMhni+EdE7SjeH2A7UyiQdxbQqzESN8hzXF+VuIH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlWZK+9Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so7422870276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730786251; x=1731391051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ3EwtZTnpXCooFm9nqJCTiI+ZBKbnHLrZbVmy/wA4A=;
        b=zlWZK+9Yh9wLHgekWQwOLRNH4twIdZtfjjCZXur0gMbOUiJFl+B1rqS4pyAHt/rRTC
         pR4iYiKcs94VWczcuQgeyG0tTXeCgsd80RBR/wO7LDWfn2jQGENZfbnJ4qqUqYeKTWpN
         Cq//U8TGSgqtZHqY6zhrqYue9hYZSTGqiOCW3/Y85j7Ro++XBTGD3qoBRlS+YfPLhn/9
         iZAxk9FVSDqlrb1xdlwXBve1OKVeIp5493pad8icGbmNN9/E1TwzwUfs3IT87YsbBFBF
         RV/SRfULAYTSXEZs9vgj6gru0ckUWTzGn2wNSoalbUs1CFSFgomx3zWorPwLRmLySOWs
         uVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786251; x=1731391051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ3EwtZTnpXCooFm9nqJCTiI+ZBKbnHLrZbVmy/wA4A=;
        b=vI4y8jARhSV0VC5G/dbOyb2p9PighfFH68ogjcTA/A0TmA2ThavahYG8NbpVVN9j0y
         X3utEa23wM0OqzQ/hzCDsvF9BRI5mUm8oQN8Wptu8uWR55+1aJXg5NHBcMQjkgqfuZF1
         udvzshDsavHS8/pdD6BF6ysE+V4TpdIhVFtHpUArpleekbbQoVYsMFgEvYd3wnDmisjm
         oNiCCw8wmWW/hEWEBEGJCyCDMqNUHUPI/u8r/yrguScjFIxohTzXw5zNFSAox7CZexPc
         lzslPbFeC2KomlYsSYlyFV/YFMrCI4vjkDLJ2D2SfXEr1VPqLErmAPAkn+2Xzq4BlrSQ
         W30A==
X-Forwarded-Encrypted: i=1; AJvYcCWEAiOaGBHCWT4eUvDP5s8hFiALJeoVBbTdTCyUR2gFcJn/tRJxIcAQmeeo3TD/bOkjzZy+dCEFzcok/3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWxljOiJlan+GswgRdlaaJpNzUJDOywNCZPIrnyicwoPLdM6J
	FvffUAbM/YiV8w7btlUBJln5dTTKgQ6iqjmdEQA6t++5qTYjF3L7WURvh3YAe5h63cL0Z/cKWw/
	kbQ==
X-Google-Smtp-Source: AGHT+IHd8VtQiU4QOG6WrVGuXgcKCyiP5d+8jxZCVHUQMIIkM1QICkMGUa8ktQd19ZCp8JdYqGS4LHY1Sho=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:ba0d:0:b0:e28:fb8b:9155 with SMTP id
 3f1490d57ef6-e3087bfc93amr66018276.9.1730786251034; Mon, 04 Nov 2024 21:57:31
 -0800 (PST)
Date: Mon,  4 Nov 2024 21:56:02 -0800
In-Reply-To: <20241031045333.1209195-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031045333.1209195-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <173078311649.2041825.11508702248531487348.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Don't force -march=x86-64-v2 if it's unsupported
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 30 Oct 2024 21:53:33 -0700, Sean Christopherson wrote:
> Force -march=x86-64-v2 to avoid SSE/AVX instructions if and only if the
> uarch definition is supported by the compiler, e.g. gcc 7.5 only supports
> x86-64.

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: Don't force -march=x86-64-v2 if it's unsupported
      https://github.com/kvm-x86/linux/commit/979956bc6811

--
https://github.com/kvm-x86/linux/tree/next

