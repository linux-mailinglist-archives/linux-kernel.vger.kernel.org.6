Return-Path: <linux-kernel+bounces-258360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 321739386C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB9BB20CBE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465C175AB;
	Sun, 21 Jul 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xy90NCGa"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09917552
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721606375; cv=none; b=SlE3Pqrg+1g2YjvPOY8h2FFiOElk8vHkP0MLclCvNK3auhosnNudf4kRaUQcuRvlgvSdxd8vJmGWYc0PfjOgImH0WmGVMz/5GCARweVpqA8bdkizXSbKwNOLcnxkIt+WiMniNwvkNIEb9veAEE358UxbXp9dDcV5mkUWUxVEnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721606375; c=relaxed/simple;
	bh=WOFMqWv6BalJziiXdfCEQkE0MOIy+Bx28w3rMsa4/7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYSlgWqXi62SVtZWIV0ypcHOR8EP0pm4hE2nxggZLrv9xEpnsCGqq33ROx9bOFb1HMPFT0U/+c1XAq57pV382vYdxtsblGxYegOJyzokxVETAA+fuZQ9JQ5/cNNKuMFaSt3eqAce/p8UV8RKBOkG22LjgbJRX4l6nAJ27MxkqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xy90NCGa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso11010301fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721606371; x=1722211171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+fOZVeriWhpqkH9YM43LruoiJ/1LHSMucjdwmnlpWHo=;
        b=Xy90NCGakbm8cjVWbpE695gGD7NhUmw0c2I4uIApSRR7Ci5CmwDXMGdSrw7rH2FZxg
         L1gWFyGOOwaUtu/sOw69fn/QPyspLkohro9XwpX1axT4C3Gtexj98BKBSpJOGwMoueb5
         m3tEuHgumPaObk444XwFN+rlvN7UH+68mHLe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721606371; x=1722211171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fOZVeriWhpqkH9YM43LruoiJ/1LHSMucjdwmnlpWHo=;
        b=JVwU/uRPtw8gVSHgyEoU3l6fs4A77Zy7Xj7rj1Ju49AiRdcxCJZn+6+fhBaW2o0WqU
         wIj7Wk6obU+aNMdYoctsNuqDsPgG5yrmB4elc01D9vDz0tzfJasbvxvbQlzg/4CyAR6h
         XkquNlyM20IqgvK7fV1vFlz+7wTZd9qmCd1XL/XQs2m+nDwuAHTWqZ2xvIdghRo9PSUH
         d6YlQnqGODG5V48GwNJdV3a1oM2tbts7iOG+QRXRvBuH6Ctg24vwzUTopC7bKW2i/XkS
         L37xfaN10SmtufEJ9OOUxuJzGt9Nyu6vuNWDtA3/3mMcJncP3e/ZKJjwJLkIGRLXgX2q
         iaOw==
X-Forwarded-Encrypted: i=1; AJvYcCVRDEsBjNt8TUnvUZF6V5xkvRipiBQxjWCjkbTgnxIK/buy8/Jg/XMg9mLmxqhC4fkc43W/gMQupxB4lRvwQx0L6M1nF0aAmJEx1GPE
X-Gm-Message-State: AOJu0YxC525sljCdFonmVNRed+HB34gCpXBGT8cXt5r37vyVr03iNdSu
	ZloUbJK57gcShrkHRcvFYkGD+iBPtNJByqy7uCKwvVM2MQX9aONP1etSn+rNm6+hIlaBVh72sbA
	sz7w=
X-Google-Smtp-Source: AGHT+IGvH0O/c73+87OJq5wlQzNBPz1t0EowGc0I4XL0iYb3I8X88+9swnUhWU4n+gJeZJBnCLFMEg==
X-Received: by 2002:a05:651c:c3:b0:2ef:2c6b:818 with SMTP id 38308e7fff4ca-2ef2c6b0b3dmr16153401fa.24.1721606371286;
        Sun, 21 Jul 2024 16:59:31 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef2232ff4esm7102361fa.135.2024.07.21.16.59.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 16:59:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef283c58f4so11114261fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:59:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQnIv6VopYDUEkDlFfN23rglHVYc2qZb0oRXjcl0v5sETipaNmUbnIUJxyHUB8u9dwGGSAdQ+B5Dkw12B4Tt4dBFt/ZwoM6+KaS4YU
X-Received: by 2002:a2e:9214:0:b0:2ef:2c20:e061 with SMTP id
 38308e7fff4ca-2ef2c20e213mr16484871fa.22.1721606370402; Sun, 21 Jul 2024
 16:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721145415.fbeb01a853962ef91334f3d1@linux-foundation.org>
 <CAHk-=wjpx6uTAvjNnD5eipGjNYcwTgG9G6Dct=eLTfyzaaTy_g@mail.gmail.com> <20240721165225.0c96cdf1a51bcd7630b0afdc@linux-foundation.org>
In-Reply-To: <20240721165225.0c96cdf1a51bcd7630b0afdc@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jul 2024 16:59:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOue1FHXP7gvC7Heq0AKFYC32FrUytSao6oBuChRCURg@mail.gmail.com>
Message-ID: <CAHk-=whOue1FHXP7gvC7Heq0AKFYC32FrUytSao6oBuChRCURg@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.11-rc1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jul 2024 at 16:52, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Yes, right, sorry.  "mm/hugetlb_vmemmap: fix race with speculative PFN
> walkers" was promoted into mm-hotfixes after I make this note.

Ah. And that explains why the commit ID is different too. Ok, thanks,

             Linus

