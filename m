Return-Path: <linux-kernel+bounces-385759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ACF9B3B50
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330671F21ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13096190058;
	Mon, 28 Oct 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="auhLc0nz"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B821DF74C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146975; cv=none; b=YRa/RElzjVU0CERXbpnacsdHvZiFdhYQv0uAhdTbAZxXexL3vmBlwon7+zzkU+IuElJ4/ntg4XtjN6AJdCuVPOZhud8kOUPtq0+FUxxp+VU1Jdf9Au5wls/UoDqoV0iRm0Z8beU/7qKqaN1tLj8OFBFGw/gJ2ZaQBD9g8CGsUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146975; c=relaxed/simple;
	bh=rECbpenE2aWDk74oNvx9ttdJOJV/6vYMI47jep77XrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsqYDJ7auVFRiXppUuzQplCCY+K+9zumFn4hCqPrnmABM3Pavle+zjT7nQ9FYLq0oCA9tF2alAeab34enROu9NqH3oDBC8+IKQKAjm+iLnVmepjH+cagCnyc4TS9dYHdTxnezWQQQKNo6kzJMEP2zScqxirj8/psb8lb3PsAngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=auhLc0nz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso690247666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730146971; x=1730751771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6nAUNbudPdSaY4ohe22hR7sOvXwfvaldH6jIn/jf/c=;
        b=auhLc0nzSxTL5T9WAEpxQpuwF67CmODhQ7YFFsHIw758w1Qk67SHSq7KVxaTMGm7U2
         2pBNTLZDsoKGz6qcKl/f1OyvipOtQZHxy2q+zfYkxivx5MDf7Itqf/NCi3ntbzP5Rxyu
         e1igDPqiAUbvuG8kYiZf3Gy76dPT11Jj5Hn7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730146971; x=1730751771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6nAUNbudPdSaY4ohe22hR7sOvXwfvaldH6jIn/jf/c=;
        b=woewdkPpHLTw4EaLcHESC/S1eoCMd8u3bsHj84Vbjvg7ZHj9KUBDO1HuOW9y/EhfQH
         voUgKeV4mweXNxT/EgwC642VPxVFmQNRMccbuE+blKvpOld+TOGa2a91vRRKcxNUDnce
         GmsaX8qBUjrPdRFBkqeWMVx9wvsp8Ros4uQxihVRc6Dgbh3nriE7MXFhnMmW1FXNvWRe
         np8yqSdWs1wNRrmrrwwWVVD/EZe68DdzhYUQ91Tx2B2E8JAug/L5dS0e2BTUI5Ye0cXx
         F0i3lOtm+3xUVWCPhKqzs8m6dc971IhAeSlFpn3GY7UCJRJZXK+bufxD9Gutqb/tP5cm
         O3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUNhpx/KTYh/zB1wgQF+fMFESCgMtThT+DLt8u50fu1Xt6i56MKh0Zju9aRXv4V4Uaj1ZeXWq7Pgs1nFMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyiRyyIO73cSSpwxu/Iek8MJta6dBv3t4WBYnZLoBQmFp1rQb
	zDKhDsJA3rD77pjLzw0t6cw+X2abpWKKmq3zQ3IuhOfXiRBEJSl3EYcN7sEWZsGkIdDkTDmmdnc
	Ab2twCA==
X-Google-Smtp-Source: AGHT+IE26dyaCk7/R3EEzW0cCk9ukayKcq+S5vBBp8AUnol31V3Y6b1LbVni2q6hncH93sm+2EdUAw==
X-Received: by 2002:a17:907:e8d:b0:a9a:55dd:bc23 with SMTP id a640c23a62f3a-a9de5d6f205mr969647266b.8.1730146971083;
        Mon, 28 Oct 2024 13:22:51 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b317ef646sm409841366b.179.2024.10.28.13.22.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 13:22:50 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a156513a1so737658766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:22:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR9kxFokgX9rmBT3iqk/R8CXta89ClBkf+zy7ryRIhucK+TRcE+Rne0e32UcqGUe0s6ZtZ/2f8AkDr7uI=@vger.kernel.org
X-Received: by 2002:a17:907:3fa7:b0:a9a:8ee:5951 with SMTP id
 a640c23a62f3a-a9de5f4ac2amr729925566b.25.1730146969268; Mon, 28 Oct 2024
 13:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk> <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local> <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr> <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
In-Reply-To: <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Oct 2024 10:22:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
Message-ID: <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region() error
 path behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Brown <broonie@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 10:18, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> I'm genuinely not opposed to a horrible, awful:
>
> #ifdef CONFIG_ARM64
>         if (file && file->f_ops == shmem_file_operations)
>                 vm_flags |= VM_MTE_ALLOWED;
> #endif
>
> Early in the operation prior to the arch_validate_flags() check.

I would just put it inside the arm64 code itself.

IOW, get rid of the VM_MTE_ALLOWED flag entirely, and just make the
arm64 arch_validate_flags() code do something like

        if (flags & VM_MTE) {
                if (file->f_ops != shmem_file_operations)
                        return false;
        }

and be done with it.

Considering that we only have that horrendous arch_validate_flags()
for two architectures, and that they both just have magical special
cases for MTE-like behavior, I do think that just making it be a hack
inside those functions is the way to go.

              Linus

