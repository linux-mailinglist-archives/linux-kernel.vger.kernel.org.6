Return-Path: <linux-kernel+bounces-567114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD17A68166
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6259C3BE03E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042E17BD9;
	Wed, 19 Mar 2025 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEWyzw6L"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101229A0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343679; cv=none; b=hppXu73QY7cLJ8q1HEYxtwxHH7D43VcJ3tAd+2QhkQsDK9jYbv+D+WMwi8GSzPaVtr5AH3K3gWMh4Ix4RiMvJqAHEXSDWlotNLoYeA6LmAt7IzBQC3df/JXrU1MT1fEP0lAowVUsQhv58rl+dSOErOOTiD3e24Dgr39YaVkQ9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343679; c=relaxed/simple;
	bh=unLay0tWJo+zIRXLvZVziyeIsjh99OV0EyMiGD0jKjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZwkmuOTOaJjIzUy7RwxWZneuNxMEby5hhOEjyMESUXSe97RVANtjZnmU9u+xCh16mlaDxFJgYJc2sKSZb6OfxA1VETAM5mwYE5GAHc5TN4sTaMhvnBdktuKnUc3qyoj8LbVRGfV2sEm6ZVDkqbdBKi+NFkfnxl6+GBPKLd1/qVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEWyzw6L; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2235a1f8aadso96284845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742343677; x=1742948477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+yivFEh5qOf2UENHN/ua45ozb9Plfqexph5vJsDbO4=;
        b=KEWyzw6LxIgg8KJPDyjzBu+U/TxXsxCZdLy9HypPZZPPTcGjzUQgFZT9RQLUE+otII
         LAjniK5rsgraI6SreUk5zK68gzvFgUnnpwZ+L+/Jcoswp4+zSf5l2fp3qFlH8uV6QQjp
         TFw0FaLf2NENSVGESYE0vhUMCkIdEZiTmUbQLTI0+kKJha4SXj+x8dWuHBKac8PGhK5i
         KwCsLXgVTvmApgV9LY3zWZQf9yMje3k3QDmak69rVNUqPnVCMICYoLjT8U0x93Yn3IQi
         VB4ahZ4d4QOGHODIdYrUCP4eJ+hNLPZQfTQQpQSA3O/0nUwAucF6SZ6ow75B87YG9qBJ
         CHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343677; x=1742948477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+yivFEh5qOf2UENHN/ua45ozb9Plfqexph5vJsDbO4=;
        b=Zu/vmHqftUvKQcw6PjJXxjax8L3eDmI3mAvD6nf5CLVbxvlNfGFdmTS2SEjrZw5iAN
         R8YrykQwxl+9fNb4iJBwkvWUaVek2K8uoh1co1GsVFvIk9RwCc6/+EMtaBrMhgGKvjOK
         +XoPynlseI44MvhYlyGVGTj/IafRpHNKkf3PfvGJneW6NGUJny6EG7GUytCQbrIqq4D3
         m6va+gkthcx6usTQx4wV+8f/3SIguVg7p+6Tcy8TmUMQzJDNpLgEYm3b948Ew4aAnFuz
         GR3QniA1Uxc0Ak3snmGMnJAc980R6QUngQcUFiOzXZkVHtSJugjV6LHqOAOGlrJGbyDP
         MixA==
X-Forwarded-Encrypted: i=1; AJvYcCVGSdPl/7vSokmSQMPlvSV+TZxIwZNgk+MTVuoKXwVO5n+DghWso+f1Ql1i407EXUxIJwDJljtX7ZwogtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJIe1/QKDSwf1tSKOehakYuuarmOspsyQmelaeOZSux3hcBaY
	SVL2w/Suy3fdSyH8AW33kkKwjpMwFKYxui2GwRzbNGhznUPdsSModuTYhKbHQE2m7YbyUj0ol22
	v1A==
X-Google-Smtp-Source: AGHT+IEq4/7cPjXUO+Mo2YUDd3ALnRfSq57C6kw6lpsTJfLnABMI2+T+W5EaFja4SMuqH4TlZs7PaUIJ/vQ=
X-Received: from pjbpl11.prod.google.com ([2002:a17:90b:268b:b0:301:1bf5:2efc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e748:b0:224:912:153
 with SMTP id d9443c01a7336-226499284d7mr8967045ad.5.1742343677549; Tue, 18
 Mar 2025 17:21:17 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:21:16 -0700
In-Reply-To: <6c811b8cf80eebdea921db41d16419919cfa76ae.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310161655.1072731-1-seanjc@google.com> <6c811b8cf80eebdea921db41d16419919cfa76ae.camel@intel.com>
Message-ID: <Z9oN_KShuFYnUg5_@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2025.03.12 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 19, 2025, Rick P Edgecombe wrote:
> On Mon, 2025-03-10 at 09:16 -0700, Sean Christopherson wrote:
> > Paolo and other folks in Europe, would you prefer to cancel PUCK for the rest
> > of March (until Europe joins the US in DST), or deal with the off-by-one error?
> 
> Did you guys decide on this?

I haven't heard a peep from anyone.  Let's cancel, I already have far too many
meetings this week.  I'll send the official notice.

Oh, and I'll cancel for next week as well, as Paolo will be travelling (and for
other reasons).

