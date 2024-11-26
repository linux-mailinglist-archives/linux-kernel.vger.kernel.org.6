Return-Path: <linux-kernel+bounces-422765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB09D9DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA03163621
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FA1DE2D3;
	Tue, 26 Nov 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3vpRtxT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C016F0E8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648293; cv=none; b=JAeMLw5PSHpXFUKIPiuKT6GQVileq8/ceYbyJTq9/JO8fm0D/ak0JGPvkvZNhrjQPjQKewubJr7RHTc0HvCgoh/bROEJXPI8cUNv8pGOwrjPADNOe5+u5gQVdIGFvQAuziDBsHKbKLIcLjWf1rG1zPwpsAo1VRZeMzxLBm0yhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648293; c=relaxed/simple;
	bh=K736zKbrekQE3Hk8QsXEc1yrui4hDnXwadMOX6Abm7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kecTMoZgT9CTl/ICafqlxgtKUqQMrcgLL/d6Qcw/T1YjtJBRV6J1d8aVaat98Z+2ByZwxYQRM/7OJdbE0pD885W8G/2RC6fY7jhpGEsSMeFbzkptCNl3kMVjnpgdqMpQrVV91WqtaNMQa+Py90Lo+dW1YoVkykYKz8tYkBcG5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3vpRtxT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-211f1a46f7fso13395ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732648291; x=1733253091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TuNkjbgKSNF4zJxEyTXA0iGdHILBTGiqQMOX5EilRcI=;
        b=m3vpRtxT/egpXPjlVkKoe1C3d0WmQR8gK5GF8vozQ9QjBrrEsLISxz36Xbru0fQqn8
         u4hzl5DE312ma8qEOjbVj/12x7sCvOZxqJoGMddDOokSW7QigDxwjXemEfv6jSYnKPUc
         Tqyf8o5RqoAbcyU3ieH4s2DYEdjJjG98Kr9MDig1b2tVV+jELUHHsfTgGptcQnT/QAod
         WrewtCynaUilDOeYcL8LqMV6HfupgqMu0lr0Hb96mFT7d9NTAGhamhbfGemqvXJyV3fi
         Pl2L2bJYNuWopVJXJtDRtyfiu+n88gZKqGCQyOJ/rD2piQDgy6Pap/ma24G8OdWZvZK2
         xdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732648291; x=1733253091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuNkjbgKSNF4zJxEyTXA0iGdHILBTGiqQMOX5EilRcI=;
        b=m46Tm6YI6pwEZp9U7+MRqO+S3kTCG+s/BMwC5MbG6Wmeh4W+GQmP6rEuCmPp4AWfX6
         USi9tnB9H7m1mlaJUxe3SeraO5v31LgOQvzZkbnsgxC5ILBH4GQ6rB4uoYpuIT6Ct3Eg
         fIphsaAkT4l6R9Wg0vu/SOjo5d7bCJ0ObC2z8miAl1HW//wtv3zu3gQDsBbAHuv0ynzd
         JRKZhG+yzaZbAp4TnVv8zccFt1dxogDKielHRcmJ6NRqALTgK0mhf406zfFgE9HQ6E5T
         PbkzzkiionDbgtkGBalQjwpFawwMt5JonOh9MaToEpnyjCUYxxAps1cXqlsY9u93iI4I
         GHZw==
X-Forwarded-Encrypted: i=1; AJvYcCU4stSn2Nu4zWcGq1rgokg20GFcB+i55xJTv6OL27ZYenqjpaPThlnqjQzV4FCSNDeB70YGJqp+zyekiTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOh5+QfGhLT9U+LqgGYToLj1uC6gwTbXZPlMDaznDrGCW874VY
	RG3drNmJZSxEVjv5Sc8SPcDApe81SFB4h6E8T3mAmkZ/vHtLGKJAof3ml6TTug==
X-Gm-Gg: ASbGnculvXBrlt0SwqiYaRyefE0oWWCGvLmpllm3R/UYU42DV777ty4/C2Zn22K80jI
	SbNR85B0fjGqWkTuE3nv4SUMu/kM/gXHv7g6XECLpi/uGDj4Ojr0qRYp4QrRpdAOGullwW19ws8
	/9LNI1zcSP1/tUBIJAtq7aElxLMnzceLSXitroXRhZ1mGbTNN+Ew7b4p2N4EIOoTOyujRM+MwwK
	e6IT+rasEmAllnqxnBSIYO7S+zUA9RKVowVifbCMxlED0u6iBcryVtDy8levfwONvymDk0Dh8uA
	Tx7b0ja9D/N+
X-Google-Smtp-Source: AGHT+IFeAPI41yigRf2xWWG755mVZhZEtqGxDJO0fLexMDYuGaMHS67a9BqB6i+jHF7ppIs2ioXD+w==
X-Received: by 2002:a17:903:947:b0:20b:a6f5:2770 with SMTP id d9443c01a7336-215022bf562mr164815ad.6.1732648291418;
        Tue, 26 Nov 2024 11:11:31 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea3e9sm12802274a91.4.2024.11.26.11.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 11:11:30 -0800 (PST)
Date: Tue, 26 Nov 2024 19:11:26 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v5 9/9] binder: use per-vma lock in page reclaiming
Message-ID: <Z0YdXqS-rARwYI5L@google.com>
References: <20241126184021.45292-1-cmllamas@google.com>
 <20241126184021.45292-10-cmllamas@google.com>
 <CAJuCfpH+B1HrzXtM_3+H9m8NPkTzAX8S4oSwhTEW+07g9JceeQ@mail.gmail.com>
 <CAJuCfpHdYPf-WgheBSCK6Md1WakEy_XCiPrw6xTFmPHr7TgnqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHdYPf-WgheBSCK6Md1WakEy_XCiPrw6xTFmPHr7TgnqA@mail.gmail.com>

On Tue, Nov 26, 2024 at 10:46:03AM -0800, Suren Baghdasaryan wrote:
> On Tue, Nov 26, 2024 at 10:45 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > You did add a clarifying comment I asked for in
> > https://lore.kernel.org/all/CAJuCfpESdY4L_sSwiCYVCX+5y1WOuAjLNPw35pEGzTSyoHFYPA@mail.gmail.com/
> 
> s/did/did not

Oh, I added the comment to patch 5/9 since it fits better there (sorry
that I forgot to mention this). Now the kerneldoc section reads:

+ * @mapped:             whether the vm area is mapped, each binder instance is
+ *                      allowed a single mapping throughout its lifetime

... and the vma check now has the following comment:

+       /* ensure the vma corresponds to the binder mapping */
+       if (vma && !binder_alloc_is_mapped(alloc))
                goto err_invalid_vma;

This was the feedback right?

