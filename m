Return-Path: <linux-kernel+bounces-382295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD89B0BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8266128AAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426D1586D3;
	Fri, 25 Oct 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JzFTHL/d"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A420C32D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878124; cv=none; b=JHR70Jp6UUcnvlshdhA8HX2jBJuj6xME6mkaqwIZvPeqrOEXpHPInTL2rlzJN7YIQUrx1lzbMK+YeJPeDdLa7+maZTFbcmg5UTK7xMES5DbFuBtS7casnNb5laW9fQcQzPiuM6eDYvLAaTTJ/X6IMWvoRXqhbriZxdjOInc9QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878124; c=relaxed/simple;
	bh=7m1CbyNbzwRznOSwkqdI/3Hw7KLdl4LtvhYRSsWVjzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOlFvdx2MfTseAdWSERQAOCYOX5BJ22yaLmj8pU4KPRL/viHAhST8iyU2bgU8PxWuWVcp/qtxUO1mQjlTk195Anu/jUt6GTOOAybJWpBgl8rLZVXtbo8sPTdz2LMcTfWhy+GdodkT/4fuPZTiDCwljLgmgusqqLPDQIIuH7Yt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JzFTHL/d; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a850270e2so377216066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729878119; x=1730482919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLdP5NGAgbV2CtQjeAnOgWQ96jll7UvhXWw9FMt7xWE=;
        b=JzFTHL/dK8cX6OrvV6V7Hu4piIfDwa266yRGaHF2lc6bRJEA0et9/nU9CWyrCQc60O
         fO40f6602QId9BljEN1hwFca4xyLLMB4Bs/2GsZtQQTm4NLIGyhJvvf2ZUp/SIQyzkUr
         nJefr5YDEH6FOLp5HBN9rtzS64EZS5DMfPz18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878119; x=1730482919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLdP5NGAgbV2CtQjeAnOgWQ96jll7UvhXWw9FMt7xWE=;
        b=Ao/DHGdu4OBnHXfy9PfNDSr64IQ+TcQIPYYhOsHc7wV0sDYphJtAfvrxM3RJtXMSfp
         Femst+RjK2NcGsu6R6S7H7emilEA4E7q7hvSCLXB8exCvb7L1xwJs0XXiB4VVcmshZ5A
         3blmfkDkzUaY4pQRMTh041Irad7OOGNooJAIV0Pwj/4XJDL1cpTpdo9c1VafgT+2TUbI
         85/Z8cCmE/LgasD3GGUGtPY6NwmE2tRqIwSp/cApGAfmXfaMLLPfjrEAToSCiyx07r6B
         /9iSYZXVA/NItqHxUuy6GhcvL/iFpC8bXv5W0A4DA9kJ7LGZGaIsRyrVGvCbcC1/3Fo7
         PXJQ==
X-Gm-Message-State: AOJu0YwA0RJWXweE+u6npsHJpIrKELD1AYfOfRIE1HpVihKYnDjkPyAd
	JFUpC2jSTnAFXQTFp9JFVDhFuJFcu86hDfc3DNjbXqBkwhxDSLrfWPu//4fMwEJ5kCrXebHXMGt
	kNYbF7Q==
X-Google-Smtp-Source: AGHT+IGHeEccaB/uXQ9S5fO95vneIuNzLC+U1dBRyd/DdmaGeiweIpsHtN+xHkOY1xzxRMDtmECPDg==
X-Received: by 2002:a17:907:3187:b0:a99:f945:8776 with SMTP id a640c23a62f3a-a9abf88a58bmr909715866b.24.1729878119353;
        Fri, 25 Oct 2024 10:41:59 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a082548sm92550366b.196.2024.10.25.10.41.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:41:58 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so3347552a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:41:58 -0700 (PDT)
X-Received: by 2002:a17:907:3e9f:b0:a99:4ce4:27eb with SMTP id
 a640c23a62f3a-a9abf94da13mr789277966b.46.1729878118424; Fri, 25 Oct 2024
 10:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024013214.129639-1-torvalds@linux-foundation.org> <dak3d3rnzx5o6faogq3awougwateiwkf7a7o6el3iiwlghjxgf@dn2dxxg4ttfb>
In-Reply-To: <dak3d3rnzx5o6faogq3awougwateiwkf7a7o6el3iiwlghjxgf@dn2dxxg4ttfb>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Oct 2024 10:41:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2FoBH63Sap4=DY+QNwZ5WULYWKojVn8YzKmYv0xpDpQ@mail.gmail.com>
Message-ID: <CAHk-=wh2FoBH63Sap4=DY+QNwZ5WULYWKojVn8YzKmYv0xpDpQ@mail.gmail.com>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation issue
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 07:16, Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> I tested the patch on a Sierra Forest Xeon that is LAM capable and I didn't find
> any issues.
>
> To test the LAM related portion I uncommented the above if statement
> and enabled LAM_SUP during the boot process as well as enabled LAM for the user
> process with a syscall.

Thanks. I've applied the patch (with the LAM case still commented
out), and let's see if something comes up.

I guess that backporting it might be slightly painful due to the
runtime-const use, but I'm not even convinced it's needed for stable.

I'd expect that even on Zen 5 it's not actually a _practical_
information leak due to the whole GP exception thing going to mess
with any leaking signal.

          Linus

