Return-Path: <linux-kernel+bounces-201554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD18FBFF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A083F1F246AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2FE14D6FC;
	Tue,  4 Jun 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtciDoVm"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE714D6EE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544254; cv=none; b=B1ncEbDZKfRYrPtRsm53LpN+6trNUUt1SCfpwy/1EBjHSdYXHksinkm/OshLYI3g5gT+UDRGugyTrTY9y2vYmweQ/tb7a0ZdRblT07Cf4MfO0OIKgdMx0cCN8RhjzLrWk4eOFcKqopR92lF8EUzxUs/qHnwtptO4sS//rtm2hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544254; c=relaxed/simple;
	bh=U1yAyx7cuyVFpl60o3sFcCfbv96IoZW7jXHBYJj0J2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VwlCCEGS5Vknn//zRnZwYadE9XT8h89R+hYPNl0J9Q/CFTrmhSeck9EYy1aM8ICRfgxO2lIjTey6B0pwA1Vyhm5tl+u2mwLWqTqJqw13+GnJ2N5rJUgrAQoZs/A+disPC6Rt9Rd4DSQzpMKqdqsTn9GKK9+CIL0D+22tEg5DU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtciDoVm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f653adaed8so44893855ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544252; x=1718149052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aziGuG3oqscD80bCqynmifrWZFDgLg8pJgvYx3eIww=;
        b=mtciDoVmdJu7ss8MPLBDecxRLmZjXnRYIOYkVcF+kqF7g6EWvAP6kK2BOCfbi2uoc4
         zAiThLDEv4iF34Ai75Z4QJNlxIBxgFrsRl4ZKBIp7j8aFFhmSRGrzCwcjgTfzX1fZhUK
         JtkV7EQ87Ni4qYM0doiVQk1h8JWOqwREBLT7TZGP3ClxQKppytwBWEskxP4E0XY1riUt
         BBZIAA54pH1oprUMhwNwHnPmnXSiVp+7t00AsTnznxsKinfdfxuHGX/6Pkz9qmqhBx/r
         BVxjKjDDTsVxgkvR42mMmhuTrawR64RNf9Mh5C93BX8pIquwsqZZ7on13OEIHWBFlfTK
         fJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544252; x=1718149052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aziGuG3oqscD80bCqynmifrWZFDgLg8pJgvYx3eIww=;
        b=BDQgi8kEHe8QQD4M+uDoKIyat/wMcHK3qOZOWht2LNst8NIYGZGaWyFKahhrzDhxmU
         48msKIrOZCBVEzKWP/vXmW70O7vktkmavpqcfvJP9QN/WxejVF0WxIRsNB8JGMhxqH/o
         HRH++3dbXkxmX5CXjvcc9oFF7gaho2o8bwlaw6dq6rapySNnzfDfnyR9S9AReF34mzch
         0uIpICcKCCVG886TMtXk5/3zhA3E9ab1Z+E5wct/8YpzDaotHXu3QxwyaQZg03tbtE4Z
         sX9krr+3ivMVgJ+fpO3gDFBomqi1FE0U0UzrQM5EHgc73UwnpP+VNffAVuPhZIJgSQqo
         n+5Q==
X-Gm-Message-State: AOJu0YzyXMSIn21Wwq8dCtse4V6uDSITcSe3AwkjCFKEXAoAC37xzEgu
	ClV5VJ+1W+UnIz/DR14YBegshnW8sa1iuvL9CqcNW+H8kH9JxuefQj/goaUQCGoWI/xJzGqsqcn
	iUg==
X-Google-Smtp-Source: AGHT+IG8j9YdiZulKToJcOB+QeemX29Tr8HUrp2T7HOKShIoiBkbqEtI5DvXFe9kqpB9ZsQDTTdUbExlxXo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2311:b0:1f6:5631:4ec5 with SMTP id
 d9443c01a7336-1f6a5a0e853mr948095ad.5.1717544251880; Tue, 04 Jun 2024
 16:37:31 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:29 -0700
In-Reply-To: <20231102154628.2120-1-parshuram.sangle@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102154628.2120-1-parshuram.sangle@intel.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754275211.2777812.9934084019005836188.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: enable halt poll shrink parameter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	Parshuram Sangle <parshuram.sangle@intel.com>
Cc: linux-kernel@vger.kernel.org, jaishankar.rajendran@intel.com
Content-Type: text/plain; charset="utf-8"

On Thu, 02 Nov 2023 21:16:26 +0530, Parshuram Sangle wrote:
> KVM halt polling interval growth and shrink behavior has evolved since its
> inception. The current mechanism adjusts the polling interval based on whether
> vcpu wakeup was received or not during polling interval using grow and shrink
> parameter values. Though grow parameter is logically set to 2 by default,
> shrink parameter is kept disabled (set to 0).
> 
> Disabled shrink has two issues:
> 1) Resets polling interval to 0 on every un-successful poll assuming it is
> less likely to receive a vcpu wakeup in further shrunk intervals.
> 2) Even on successful poll, if total block time is greater or equal to current
> poll_ns value, polling interval is reset to 0 instead shrinking gradually.
> 
> [...]

Applied to kvm-x86 generic, with a reduced version of the doc update as
described in response to patch 2.  Thanks!

[1/2] KVM: enable halt polling shrink parameter by default
      https://github.com/kvm-x86/linux/commit/aeb1b22a3ac8
[2/2] KVM: documentation update to halt polling
      https://github.com/kvm-x86/linux/commit/f8aadead1971

--
https://github.com/kvm-x86/linux/tree/next

