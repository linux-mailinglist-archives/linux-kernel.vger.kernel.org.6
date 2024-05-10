Return-Path: <linux-kernel+bounces-176043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40828C2937
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77302B224FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6531804F;
	Fri, 10 May 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItjquVAK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93017BA2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361972; cv=none; b=OV+r6qW1f/ufJ72CVjHLRM207/rErLygcpvVoZ6watEt611MT/Bt6LeHY+U4ZkQsv8AfLVSEnDvC368lgPGcFNb+AVMUzh8xgFAwL2wvfp4rXNEBgObHcqhGoJOVWprYBS6zBUgSDR++qTWMlI9huDbJPJIsUEHmvcSBPlnYWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361972; c=relaxed/simple;
	bh=EsLzXB6Gs7ZQtkmepgwzqKCcyMI9oEm1j34c4xvtcr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tG5rXCGajW1QmZxwMh+O3wn/mpwhFyZIY+s/orZWrJlIKMsUeXoqKZnS3gwrVzgjo7lt4YiqPsFq3PgGG2foH00HKI8FMTc/NoNnSHWE1qW6zkKKKbtIVCEoh8628p2PyupGwkOsuYbHtEBe+b3KyFwWJP2wnGl1m3abRzbUinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItjquVAK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715361968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0uH1Y67e/JYlAU3ZBz+NOGOD31UpxofQKkMvjjtZOo=;
	b=ItjquVAKjF37OWt4ojFjYS8JkuzNqVBwkgiCSRRHnwtJRsaIKVGA2xyobmNGjymYVlidFa
	FPDUJdmLoxml/d1q637zrkvsPqV8UYHqjym5nNZa/3nIKn3FDXLd9sLhaqIhp51xIeQNzm
	OH3zPdYpaxq+VFbyvyE27GYMTce8VIk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-M7ZI8PHjO2Ws8osqmLei5A-1; Fri, 10 May 2024 13:25:48 -0400
X-MC-Unique: M7ZI8PHjO2Ws8osqmLei5A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e41bd70238so21488441fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715361947; x=1715966747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0uH1Y67e/JYlAU3ZBz+NOGOD31UpxofQKkMvjjtZOo=;
        b=ZAp0lXXHwZTruMRGs9/pfg9ORd9tQarswf2pjYxxXkMwweR72lrm8pUHG2jR5dKyzt
         V1QmaLvc/xYBTOvyzZWWSbRJhyOSL2Yfm0UTEKICD8PHACLYDeL9vGr0oPBs1GbpU3FS
         eDkUtOmOqReKKkz3VsGGf8BAY4eKWsxqC5KAqL9sPVaw6FCALNxJcdkuw+R/OLLAbYsV
         tq7qJSNz7OoCrtGkn+5k57KfUgAE9CrY6EJwUx3wawHRJCiQPNma9bH1UoRJcIufGpXM
         VmW+oiZwO+4RM46qBrMLxBUucrh1S96OT0sTo4ZuRCnSJppUI7XMaUPhreWCtx/+Robo
         ZQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXNsPgr/TovQXWYl5vKm7UkqAg8+Va73thmuyhpAHekjydqaZiQfk37RPInCYSAsKpPL8Ktzlrdq35kkZW4AyWz+2/cekth6JOU1Dot
X-Gm-Message-State: AOJu0Yysu3NXZfXA4D3z8wzlkAbpCaHoeMWGfKO2KnG9XR9EDJONFsHY
	zOHudahDcaqwgwwdEpZXv9b7t6EHGnkV9AzAn4ztjlBtMsQ1yqp1AIAFaMVYqYtUJ23DJ2OF2bv
	AV6E12YCySJofolg59PqxIcht/CnPLGNOrVHzyQJJjvYJycCb2pTFKcyPqVa3FQ5B/BI9aq5lvN
	MhDtGp6zsEQwTcHyQJEE2yiwe8FNHYS0FcQ2nR
X-Received: by 2002:a19:a40f:0:b0:522:f6:9268 with SMTP id 2adb3069b0e04-5220fc7eed8mr1904839e87.31.1715361947343;
        Fri, 10 May 2024 10:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+3UgqTDnmRVAiNjyATZxMd/ldNZtXGyYEy7zEh+oH8PVqYii06B+EkIez4lJParuMv/x2eUO16iD1lvVu4gU=
X-Received: by 2002:a19:a40f:0:b0:522:f6:9268 with SMTP id 2adb3069b0e04-5220fc7eed8mr1904804e87.31.1715361946880;
 Fri, 10 May 2024 10:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501085210.2213060-1-michael.roth@amd.com>
 <20240510015822.503071-1-michael.roth@amd.com> <20240510015822.503071-2-michael.roth@amd.com>
 <Zj4oFffc7OQivyV-@google.com> <566b57c0-27cd-4591-bded-9a397a1d44d5@redhat.com>
 <20240510163719.pnwdwarsbgmcop3h@amd.com> <a47e7b49-96d2-4e7b-ae39-a3bfe6b0ed83@redhat.com>
In-Reply-To: <a47e7b49-96d2-4e7b-ae39-a3bfe6b0ed83@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 May 2024 19:25:34 +0200
Message-ID: <CABgObfaJaDr38BsTYRrMQzYr-wK8cLW+TJr5ewsgBEcm8ghb3g@mail.gmail.com>
Subject: Re: [PATCH v15 22/23] KVM: SEV: Fix return code interpretation for
 RMP nested page faults
To: Michael Roth <michael.roth@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, papaluri@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 6:59=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> Well, the merge window starts next sunday, doesn't it?  If there's an
> -rc8 I agree there's some leeway, but that is not too likely.
>
> >> Once we sort out the loose ends of patches 21-23, you could send
> >> it as a pull request.
> > Ok, as a pull request against kvm/next, or kvm/queue?
>
> Against kvm/next.

Ah no, only kvm/queue has the preparatory hooks - they make no sense
without something that uses them.  kvm/queue is ready now.

Also, please send the pull request "QEMU style", i.e. with patches
as replies.

If there's an -rc8, I'll probably pull it on Thursday morning.

Paolo


