Return-Path: <linux-kernel+bounces-293575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B98958184
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7321F2503C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866218A947;
	Tue, 20 Aug 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0xEEnAt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295477F01
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144275; cv=none; b=ZgeZmt5Tp6K4vd5P6Ayth/cG21dGVdxSH/xst0bysE6XbDwN8yBoPMbT6G4milDkCw/2EQ67x7sXc14WrB++GvK/SLv1U1AJoodAB+89dc1KlKlXjKMikX/jSbFXuEb+jvagwGFSlQrSxNliSVr+C4DQDYzv5YuiQ5g7s94esK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144275; c=relaxed/simple;
	bh=xjkK7iK5CvjdhuUb97GVoGF/BjUcoUNxCzEB6tB3sNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+RG43VSK2W2eMya9h3zRTGgWm3mYgeJd10AbyJIYFJsb0dssRVtQnVnvENTTmKtrRbXu5icG7BGbGItOkEysI5Mgmf50FSLudfCDnzCFJXRVvCltNAfGtsQaIVBdQ1WKfGUFTt9cEIvXAVyA7wPNTyEnAeFee6nnfi3MX774+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0xEEnAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724144272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjkK7iK5CvjdhuUb97GVoGF/BjUcoUNxCzEB6tB3sNQ=;
	b=J0xEEnAtIG2TSxHzQSfAYtk8PqlFocqLbBdr+enn2dhmW0On2FgJZf6Bhy0mfq/D3hfRbi
	yppd3uJJLEwZ0cqgGulC1Ez1RDZl2SLlhYvzOfufbIl2IX8hb7OlCb/b+D6CBDZb7TPTB9
	iRyLQ8+/XX0Ph3uNukMJxniYNbR+yxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-0-4E2RgHP76J5qMwsMjNvg-1; Tue, 20 Aug 2024 04:57:50 -0400
X-MC-Unique: 0-4E2RgHP76J5qMwsMjNvg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280a434147so44475555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144269; x=1724749069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjkK7iK5CvjdhuUb97GVoGF/BjUcoUNxCzEB6tB3sNQ=;
        b=mwPz4byaT2vc9p7R5atYcSnVlDwBX9+ZRjgGsXGuFnJt3uYUWXw2kK2eNo6MsJh7fU
         W5EzxwR96BscHuz3nTIzneT9AWP3lfftiR8NppF7yqFMJEx0fTPmxwEdtAbS6aK8qofG
         ej4OIEIiX9I3PI5qoFGh/9kNEOnCN6b4sdQZwOigGIQSnKB/gOqeknqwayMMmte6gJJw
         gMkQeCOGA8zP8KE5FCRsuZJ+M+pR/lFWCel8yuVmBY6URAYNtNlMyORkQ4akkx68ucYI
         u2Py1ZtyIp/CEcFBoby5nuxwcBieURQEP3nBv2hQ79ql+T0A7bd0G8ja3T+VjI5ES7SL
         BfQA==
X-Forwarded-Encrypted: i=1; AJvYcCWxcUgbf+iAWkDb5WjwXhbfJMddcomXKzwIBWVBdEOtl3Dder80SRhjJEdGKWx6gzu9LvKftSt0KMKvYd++j4aoCpVXekPLB7y7+ZH4
X-Gm-Message-State: AOJu0YyAMprhpvCxmg6CY0lAIPN1kyeNeXMbOYBaKzn3XGxZPNzPhFRF
	gsOzvwZYmxWsa2uD15jEWZnAq+lGS6Rtck3eaOWV0ftlqsjpHpq8GXpPOiMZcdRKbbvj1KZrooy
	FgdDEZmNe17f6h8eUVoeoYLcxaKoekXiqLKHSKLBc10Q7WnPDb2Hb1t63KGvzME/1CoxJ5+Wn7u
	u2+c/z0Hf/rhBSBjrK63B40YfduJ+QUhEdfb4L
X-Received: by 2002:a5d:6784:0:b0:371:7c71:9ab2 with SMTP id ffacd0b85a97d-371946bf3f5mr7728104f8f.52.1724144269564;
        Tue, 20 Aug 2024 01:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfN1DEa323emO5ciFDRq0ln5Ny7asNboij5b1hAStv+/CqQ8O7DlNLw/FVnkCMNUHeYkReZHjR71EMG+jD0E4=
X-Received: by 2002:a5d:6784:0:b0:371:7c71:9ab2 with SMTP id
 ffacd0b85a97d-371946bf3f5mr7728092f8f.52.1724144269036; Tue, 20 Aug 2024
 01:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608000639.3295768-1-seanjc@google.com>
In-Reply-To: <20240608000639.3295768-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Aug 2024 10:57:35 +0200
Message-ID: <CABgObfYNtyVnOYcpDVLNF-vuN0Caqump7dkgg9P6xQkMmzMc9Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] KVM: Register cpuhp/syscore callbacks when
 enabling virt
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>, 
	"Chen, Farrah" <farrah.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:06=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
> The suspend/resume and cphup paths still need to be fully tested, as do
> non-x86 architectures.

You can add

Tested-by: Farrah Chen <farrah.chen@intel.com>

> For CPU hotplug we tested this:
>
> 1) offline some CPUs;
> 2) load kvm-intel.ko;
> 3) run a VM;
> 4) online those offlined CPUs;
> 5) offline those CPUs again;
> 6) online those CPUs again;
>
> All steps can be done successfully, and the VM run as expected during
> step 4) to 6).
>
> For suspend/resume we tested:
>
> 1) load kvm-intel.ko and run a VM;
> 2) suspend host
> 3) resume the host back (using the IPMI KVM console)
>
> All steps worked successfully, and the VM still run fine after resume.

Thanks Kai and Farrah :)

Paolo


