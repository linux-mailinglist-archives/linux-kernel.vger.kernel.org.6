Return-Path: <linux-kernel+bounces-196844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1944B8D627A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30E51F22DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0E158D6B;
	Fri, 31 May 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRkZ2JpY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AB158A1A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161063; cv=none; b=i2J3uvLUBpXu13aEfZ8TaH5w67sq84lMSDHvp6YMRGWuIanoWzy9pmONbDcpi+K/5o2b2HheRpxkLB2kGlcrZtYx6WPvxv8m877ItT+RUZ3mlY6QU+U8+LRlxiIi1KSulBK7xQcpOWUOeqWumT4MbOQtxTG8zeI6/6RURN0uhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161063; c=relaxed/simple;
	bh=CqLmmdZ2wecXUVkHp+HXQRJLjMCpZYdCiUOYNmrEQ+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKT7xiOv8cEQ6PAly5QvTHwPO9ZP4H35WhnK1W59kEQOG/MtRF+/wKBPYPxFm5JLAg+lwkSgld3A4Uqlyqwl8CrmlePWW/dPiI/vsNF8YErk+1qFAlUyc3cPCWezlBxy3NHxThoBBRZKJFfolaztYd1NMzEtT1bVyNrhNV69jR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRkZ2JpY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717161060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqLmmdZ2wecXUVkHp+HXQRJLjMCpZYdCiUOYNmrEQ+o=;
	b=VRkZ2JpYWdaB0zMjrltQURa58YDXyGRmyJdDqGzs4IaBzImBOT2h7SpZvquE9w7xvxHIfc
	2fUToYT2o33B+iFhFfmxoy6WWOekWUBpzIvEvPQ7OtV37Ykb0C/FugcKt6D+ds+ByVhnsY
	JB2VTDJo313H/wotjqIWVcOSKww+C74=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-HKdbloIIM9-56KI7ZpC6yQ-1; Fri, 31 May 2024 09:10:58 -0400
X-MC-Unique: HKdbloIIM9-56KI7ZpC6yQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35dc02b991eso1206087f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717161057; x=1717765857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqLmmdZ2wecXUVkHp+HXQRJLjMCpZYdCiUOYNmrEQ+o=;
        b=TLhsAodFBTzMmqGGGjuwTzBzV2rrpk4tSSoweWcy1xyMNxV3Ru5IAvx2GGc4GAUmXV
         NzlafCnDwqs6w0fDA1AfMTkfdz658Ou6m8fbg2nyvQ/eIO1Oc/mIZ/4MfNB4HnxEzpjJ
         tdF6rSL99ZiFo0k0+bJzSDVjpVC0AdLQw6z7sBzzgN7jMni2o+y940w2iUxNhZFHDEfm
         m4rxE8E/RTNgIKC+StN0dlE3nxzh1Kyp20rY6uA5QmYtrNOe4DbnmwG2YONJyG7eOy6l
         6gJLdixIGsUxGi6YPR2X5UOh/b7khnYx2/Sk8R0a6NLfPrl+y7sSFe2f85gU67CZ+HN0
         e8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUJb3mxfZ3vfxiCN2GZJFIsWNHboJ9a0baSORpo0kHXgRt3aG7cvECBndAOrdXPLtwIsqmmslusUSRCPvfGE85zQ1mfUEnPZMpmULe6
X-Gm-Message-State: AOJu0YyHuG97WfcY5XTFU6+06HssyKquxLkAOoe49uotq/luWjikiHHu
	IkAa6l/d9fOjLhLrhyhf3cZQPTTDU7iMxZ1PWFtJlMkx7+56XeDDXxTyYZ6+P+Gpnq1COtD6fae
	SXqU88W0QlBdEEAH4oOaKrvNi26wBxwE8As+ETVBltQfH+EbQ5BMqZy9Ky3lfxwKRNzEMtP5lBV
	1UaJDqoITSEeynbgu1RmwE5vF7XoljGRo/p6uB
X-Received: by 2002:a5d:4bd1:0:b0:354:e0e8:33ea with SMTP id ffacd0b85a97d-35e0f37119cmr1303110f8f.66.1717161056781;
        Fri, 31 May 2024 06:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3gzv4GfxGaWcm8XMVixs3+MtMYgeFKTzpnPkZZHcTWqGRUOOsjVrY6Fxl3SCwOqZe8dfStn6ygQ2HzwmiDVA=
X-Received: by 2002:a5d:4bd1:0:b0:354:e0e8:33ea with SMTP id
 ffacd0b85a97d-35e0f37119cmr1303068f8f.66.1717161056377; Fri, 31 May 2024
 06:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501085210.2213060-1-michael.roth@amd.com>
 <20240501085210.2213060-10-michael.roth@amd.com> <84e8460d-f8e7-46d7-a274-90ea7aec2203@linux.intel.com>
 <CABgObfaXmMUYHEuK+D+2E9pybKMJqGZsKB033X1aOSQHSEqqVA@mail.gmail.com>
 <7d6a4320-89f5-48ce-95ff-54b00e7e9597@linux.intel.com> <rczrxq3lhqguarwh4cwxwa35j5riiagbilcw32oaxd7aqpyaq7@6bqrqn6ontba>
 <7da9c4a3-8597-44aa-a7ad-cc2bd2a85024@linux.intel.com> <CABgObfajCDkbDbK6-QyZABGTh=5rmE5q3ifvHfZD1A2Z+u0v3A@mail.gmail.com>
 <ZleJvmCawKqmpFIa@google.com> <3999aadf-92a8-43f9-8d9d-84aa47e7d1ae@linux.intel.com>
In-Reply-To: <3999aadf-92a8-43f9-8d9d-84aa47e7d1ae@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 15:10:43 +0200
Message-ID: <CABgObfZZsJxQ5AKve+GYJiUB0cFc70qkDbvRB82KrvHvM0k3jg@mail.gmail.com>
Subject: Re: [PATCH v15 09/20] KVM: SEV: Add support to handle MSR based Page
 State Change VMGEXIT
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-crypto@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com, 
	ardb@kernel.org, vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 3:23=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
> About the chunk size, if it is too small, it will increase the cost of
> kernel/userspace context switches.
> Maybe 2MB?

Yeah, 2MB sounds right.

Paolo


