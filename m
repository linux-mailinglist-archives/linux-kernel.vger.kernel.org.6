Return-Path: <linux-kernel+bounces-205653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7059F8FFE7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54421F2A1EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9C15B131;
	Fri,  7 Jun 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCaNvHPK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4418EA1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750624; cv=none; b=X+azzW47iIXQYUE6WNVtQTLGqlmx8tPl455JIlSQyd/Jvkl6stxcuZE7HK/hnsOGxoezCQ2oQEpJih4l30XnucZaYjcJBGmmoVAdFoeWdwUp7tyZeqjFR1/lmr9+juoIvl9hCwaP1j2OKzvmuGvWgVFGrzFy4ZJH0clvaeN4bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750624; c=relaxed/simple;
	bh=dnJ3s6hfgwAk/vZaYwvVpkpmujlzIZfHfB+ANFAuFhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPpWGGk5c9VsN5S9+jwSXLuppgnO4eGQUo5eIlp8kmH+FyEvgc6kiaIUyaz4k+/nJctnjAm5+Qq+fXb9u5oW7so6GuCajTUVUNQiS0yW7oezlO0FisGElbF9K1cSIBvNVKmKCao5bml3sjtJzUTMATuN2rWeryqesH0oXnzmW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCaNvHPK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717750621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRedVtxtM4aYweUIs3ZIlYgY2brCcQem2JU3eiYIqac=;
	b=fCaNvHPKsh+X8K+Kwhv6R8dn0qFIsnG2p8bBI2PwG8Wuh1qBGHOOzmp1rH0mBcLB1jSnWe
	yMyJAj8TA47nvH8li7T/43F8QIWy2+x2q7ePLleHvJdpE+fuPBe75ilYLafSh8stTl8cT1
	/DO/RzI4onFZlPJv+ant7qBsm4ONb8A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410--jdLEzYANy-iLbA7Q_DT4g-1; Fri, 07 Jun 2024 04:57:00 -0400
X-MC-Unique: -jdLEzYANy-iLbA7Q_DT4g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcf7d4014so1149205f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750619; x=1718355419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRedVtxtM4aYweUIs3ZIlYgY2brCcQem2JU3eiYIqac=;
        b=Lcn4IGus4Her0WTW8cp8oHEyqzNsgilaY2z0ZB/zpLieCgXqNCK/Un2rCMcAjxpQGa
         HwcWxx44eCs1Fqv7SikieYSHfg2VRT9LM/40br9SkbmG+e+qlWQwyU02tvPpYUi1ehay
         G7O/2ipc/mYujluNumtvRo5jAfsf7FzV8lyAkVHF3L3fmtpPZanZ5Wkj7cyhHfVMO180
         UtihUiuEywIigS8fa+PqMGYzIPuO8bmhMJPCQ5/yPL1BhfipdZgYKoj9Znuz2fEQQpSb
         AtAN23sUCUoc+JZOivjVkzu7kwNLTEv0eIpvpZmb9ENY/bds2AJqrlUjat6PPTITAjoX
         qErQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfwX1fL+PW7Hx0h96FvlAGx9sMufvC8IcoMfT37qNJxkzJ9RZNgpG2NzBIZwCuvlY+GkWKj5T74KFz3D/Bgdlx0R/9ffosKLSmwjao
X-Gm-Message-State: AOJu0YzL9EmjuCaQnzVXuBHVYYpU1HClgx/iw7W/ksGynepyEWSXua91
	/QIkgUIIpGdXZmWFXbQ89Jcdkyw+K556Pv3BWqdhsM/DPS2KtOUmkx2bIChL6u/s1Tw22Zb2AVF
	7zs1LXFIIE4aqmrQQWPa4e6yrPguTgcJKXiWUB84zi51b10gBnn5254t3llqCYD45nJ0t6G6Kw4
	ktNbMR51c/BJRJp+mXdGhNAKk3ZXCl5YEsCyx2
X-Received: by 2002:a05:6000:512:b0:35f:44c:b3ef with SMTP id ffacd0b85a97d-35f044cb688mr757442f8f.52.1717750618803;
        Fri, 07 Jun 2024 01:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnz+ujg3mXfUbzxVa9i6qFBledYwxNORWM+iQLuJuwcvJcvhbpMAHnqmH0KMu9Nvg4zZXmGJI1VYpV7yRvujk=
X-Received: by 2002:a05:6000:512:b0:35f:44c:b3ef with SMTP id
 ffacd0b85a97d-35f044cb688mr757429f8f.52.1717750618470; Fri, 07 Jun 2024
 01:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-14-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-14-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Jun 2024 10:56:46 +0200
Message-ID: <CABgObfanTZADEEsWwvc5vNHxHSqjazh33DBr2tgu1ywAS6c1Sw@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] KVM: x86/tdp_mmu: Make mmu notifier callbacks to
 check kvm_process
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"

Subject: propagate enum kvm_process to MMU notifier callbacks

But again, the naming... I don't like kvm_process - in an OS process
is a word with a clear meaning. Yes, that is a noun and this is a
verb, but then naming an enum with a verb is also awkward.

Perhaps kvm_gfn_range_filter and range->attr_filter? A bit wordy but very clear:

enum kvm_tdp_mmu_root_types types =
    kvm_gfn_range_filter_to_root_types(kvm, range->attr_filter)

I think I like it.

This patch also should be earlier in the series; please move it after
patch 9, i.e. right after kvm_process_to_root_types is introduced.

Paolo


