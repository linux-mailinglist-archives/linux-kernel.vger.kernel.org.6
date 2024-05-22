Return-Path: <linux-kernel+bounces-186451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891468CC458
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC151F21B23
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B81420A8;
	Wed, 22 May 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGAyKEhW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115F13E8A0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392759; cv=none; b=eRYH+fgxIYziJau82dUBxhs1ulkv0LMbrGh37V4rUFYtJItf7EHphET9dx3d9M/+Oy3QZeDuc3YMke32zAxSBoqTYFcB+GkHlYB8C4NvvlIOXI+ehUaEzaNj/NJQ3oeQcDdcOlNEtOwU2m537/7JV7qOdLt76wwhDnvMvjle5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392759; c=relaxed/simple;
	bh=Mdb4OhrS+xxduGqCQenQjyZiiOEqWnw5Chesp52+Cyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTq14YmeK3HJmE2Pen9+Oyfy1ul/8Hoxuseieg3phmGuxweyZCtTJ3tgHuRTHiiiSM2na2O7jeFoC3r6L1eA8WxXei24fqLJ2kxznujp/i5rfT5E5Z6CfF9AXU5zzU3YpyYbdzx2nDYbCaXNz9tqVpUSDm6sSwRDgNHel6P2LtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGAyKEhW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716392756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mdb4OhrS+xxduGqCQenQjyZiiOEqWnw5Chesp52+Cyw=;
	b=AGAyKEhWPHFwhP5csu/9jm+KKi3DAP5+8MAeOOa7diUkO3B6qGZroHxB1za6S68psAtJ8C
	IeCJyzJzRjR9qCWbeiiGe5wO06FGozTbNXNJ09ihxumeS7h3EMsBM35l9DarWhGaGhbQQM
	ulgAsFGHu1b2LVuPDXohhoC0ZiyLLQU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-7f18bCruNo-SmbhIfwRwbA-1; Wed, 22 May 2024 11:45:52 -0400
X-MC-Unique: 7f18bCruNo-SmbhIfwRwbA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-354df3e1b0fso390553f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392752; x=1716997552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdb4OhrS+xxduGqCQenQjyZiiOEqWnw5Chesp52+Cyw=;
        b=UazgVT4C2+CfH5LQQlxoY4rXpmeucX/ofwwR1kR0XkUZd6ZnD1JrTY+AI5Q/n0E0YI
         gh0qAEyzROgTS86KjgbRvfI752pb41dTVaqFGwL433YGuv0N6WjpJOSuT3CdSiA4FIRq
         axV58AEyU+PbA6xAinepTTUWqPhkjAqtOHF0kxUk0KyX77+4MZpKSjyYDP9U+Cc6FnrW
         ULODXMAmrbtAnEOksRIF5jAhHldCntQVB+YbBDB61Isz62W3H1VKx2oZ0U+tBfoIDomt
         +homZLXPPDumKmAVuNtiHX23MQK7hE7W0Iw/kXbcbiiBLbGQcnUThH5ziDySZd4zw1uJ
         a3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW2lFoMPYaDUcr40dYazNJB0y6ON7c3+Rn+1udTGHI21wpNXLv7OTJzmnpVqa8jjapKEAX9YxuJTKheoTeDINvOx7cBqpiQtzlBmxzR
X-Gm-Message-State: AOJu0YyZrR77FQ2NVyKhQjAsII/q7qy8CMhEIKsJ3lk6yNBGbgMfdcdx
	MC1NOpV3sJjQMITvR0kazRGuRKOvwp3GekMpT2836xzf5kr0tp2aAZxk2OUoKPVp+tBQPt9gINs
	b346JVkDEI6sysrRk+LiESLeBbEqDYL4p6AfkbFGWeOPDejeJsli4FQLchHUlC9ev6b3K/usxZD
	lOuX+PhEXQdBDyVYpUlZXk94TxASuf8SFoa+fj
X-Received: by 2002:adf:eccd:0:b0:354:f452:c99a with SMTP id ffacd0b85a97d-354f452cc09mr512929f8f.25.1716392751782;
        Wed, 22 May 2024 08:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu6jDF0/N1JzMpNdLFgCRDbMRMnB/WJd7oq/LlNSDUtsAaagfukeItFC0VsQV7unOBGexMVYUOFO7FNwpI4uE=
X-Received: by 2002:adf:eccd:0:b0:354:f452:c99a with SMTP id
 ffacd0b85a97d-354f452cc09mr512909f8f.25.1716392751401; Wed, 22 May 2024
 08:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkUIMKxhhYbrvS8I@google.com> <1257b7b43472fad6287b648ec96fc27a89766eb9.camel@intel.com>
 <ZkUVcjYhgVpVcGAV@google.com> <ac5cab4a25d3a1e022a6a1892e59e670e5fff560.camel@intel.com>
 <ZkU7dl3BDXpwYwza@google.com> <175989e7-2275-4775-9ad8-65c4134184dd@intel.com>
 <ZkVDIkgj3lWKymfR@google.com> <7df9032d-83e4-46a1-ab29-6c7973a2ab0b@redhat.com>
 <Zk1KZDStu/+CR0i4@yzhao56-desk.sh.intel.com> <Zk1ZA-u9yYq0i15-@google.com> <Zk2VPoIpm9E6CCTm@yzhao56-desk.sh.intel.com>
In-Reply-To: <Zk2VPoIpm9E6CCTm@yzhao56-desk.sh.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 May 2024 17:45:39 +0200
Message-ID: <CABgObfaq4oHC9C_iA2OudmFN-7E9RDiw-WiDu9skmpsW39j0nQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 8:49=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
> > Disabling the quirk would allow KVM to choose between a slow/precise/pa=
rtial zap,
> > and full/fast zap.
> TDX needs to disable the quirk for slow/precise/partial zap, right?

Yes - and since TDX is a separate VM type it might even start with the
quirk disabled. For sure, the memslot flag is the worst option and I'd
really prefer to avoid it.

> > I have the same feeling that the bug is probably not reproducible with =
latest
> > KVM code

Or with the latest QEMU code, if it was related somehow to non-atomic
changes to the memory map.

Paolo


