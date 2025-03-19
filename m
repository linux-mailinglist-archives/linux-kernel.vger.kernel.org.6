Return-Path: <linux-kernel+bounces-568577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568AEA697C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7C1480A52
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E520AF89;
	Wed, 19 Mar 2025 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SO+my/8i"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62220AF69
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407939; cv=none; b=Gmx0az2y5CN+aPJzj9bWp0riRCSzpd47X0EUb/9+QUGUv1SPX+BkxWbmRcrs/g/UiFlBAchW0pcwB3WouPhm72WAuR5qSaj980I28HorkL3MyLjbF/3cRhb71OOEYsDxWhKDqv1HUlppeX3Z6CnSXIuACHkz+Fu2zJwqWXkxRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407939; c=relaxed/simple;
	bh=fFeqEDSx+gFrh11ijFVYJhwWlYSMde/JsajtuuK8bvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALFqEw7SENWfo5XDrXkkqQWmwPjvpMYzc2HAGZw0vbPd5nTXsOpOOb6ba/yHOT/I0BhZpmgjxr9IPmi/wGyveXo46njeaw+pmbg0ztFkbjnjf7UkKfCJgnVqsxRksDQfttrtVQ1Rv3w5fGYcj5Hq2+fnNWmYyE7iCsMrJ3g/b3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SO+my/8i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7430e27b2so164882966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742407935; x=1743012735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtsDpMKG3PVh8c/2wdkRvEAKIrMwiuW7c09tD+wzsRQ=;
        b=SO+my/8iQC8Sry5gW8ScLtTJKz1xPXEWyhJqAmZk6pqTd7ZwdCTM1TQFPBDiePS1d+
         T2u39Hctl8SR4BwtPK1xiHhBW8z3V4hBhIxnOdJ3qzOGK1nSPhn5TIYUixr6dvEsh2bx
         WQPpNR+W3NXEtmu93UpOmsRDn0+jGh5+nwijw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407935; x=1743012735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtsDpMKG3PVh8c/2wdkRvEAKIrMwiuW7c09tD+wzsRQ=;
        b=dCmNMlXXvn2tNixNnrv2S548e4N+QiQ84MYhJf9lnq6fRC1Cga4Xgab+84TPeptN/q
         DS8Fyg5LPYN7nCzeaXNr6XGshRgeY2ERdtFcfJHhMXKPKmsamCAselxkimJoHoa6the3
         3yeqncPhR6LdLuY1q17OTAE9JrIpolfSEaZ99kmpbag5tWI3e/KasKYHq4GAmWY1RquE
         708M/WdNQ5XYVjDg/ALABzjRZ4K40DrFlwUKElTLt9rOB8ID5j7aVgBucsiTnM0d+DTo
         Cv5Cz8fm3ue/SIX1iPSNlAIFpGE1cIh4F5haNMxQXEQj06zGgQXm4EaYHvMWdLrPG8A+
         HGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS8iyMrUDhy5SZBoAQAZyc3XVzBnWrQUpXDv80TCakS7rVWA7c8LPiVK3JVK9ZQCW0Xzplf2pSTEk+fjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmP9jtWoWoPLgO94+Zm5Opo/EwZfEL2GHUh/O/STPicQEv2/XK
	udbnXUWN8n5MiBTmimLDDvfU/JsTuVBfSq2l0LXDXnwSpps1/uauPobTeOLSR9/aFGpKwuDgRTs
	pv3U=
X-Gm-Gg: ASbGncv/mQGfkDvBsWWEAwZmUABQNON/PiOAFc3cVhSQEHkL35XuFs0fa/hKVv3QlVS
	YM3mbFB3fz6jYLevoSvC7aLKys+2KSKW4Xmuk53QOYhfDmBXP3u53GAQkM/pRGyx1mrRSrmyg4/
	iOYlwgEI7dCbYerLaKy+rV3AXa4GzRflwh4M2mFVOoSY/Wyu22UXIxRsbEz+s88pOjDgjBQ9rnY
	c7EwQEAQYVw53PDTsKzsbjRA5qgeDnrAZVudEP/jlX2jP7mmtDNS65Qg5D+V/cvcTE+Iuo4vb9Y
	dTKaMyZAaZgnLvAxEuTPwyKu+xFuh+H6IKvGe8+ipzljeaPzgXdXw1fEuJhRjwBUgDpCq1rcuDA
	YO9FPSzfniOe8DRD/1g==
X-Google-Smtp-Source: AGHT+IEa9iDUyzyr968Cxn/VGH8NpqxWYP21AHYy1GKA9mpyvleBoY7KsDC1nRfwARC7v96wsw71sg==
X-Received: by 2002:a17:906:730e:b0:ac3:413b:69c7 with SMTP id a640c23a62f3a-ac3b7f730cdmr428325166b.39.1742407935334;
        Wed, 19 Mar 2025 11:12:15 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefcfsm1037218766b.27.2025.03.19.11.12.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 11:12:13 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7430e27b2so164875066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjY6N+dEdN0+wgnPUhk341m4bGtKAgYnYF3do7M1unxk20ZKhA2vRHWfNIYdNSaY4kQpTxJjQnmS2q9UI=@vger.kernel.org
X-Received: by 2002:a17:907:ec0d:b0:ac3:bd68:24e4 with SMTP id
 a640c23a62f3a-ac3bd6830damr446966766b.53.1742407933026; Wed, 19 Mar 2025
 11:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2874581.1742399866@warthog.procyon.org.uk> <20250319163038.GD26879@redhat.com>
In-Reply-To: <20250319163038.GD26879@redhat.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 19 Mar 2025 11:11:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqidLD38wYUw-5Y6ztFdAvkX3P+Gv2=K+rpkFBG-bf7g@mail.gmail.com>
X-Gm-Features: AQ5f1JrIwulbm3bCXYePiRgtmwvEUEXDiL2TRjJKyWZ4_ecrDX73K-AxzmDTtIE
Message-ID: <CAHk-=wgqidLD38wYUw-5Y6ztFdAvkX3P+Gv2=K+rpkFBG-bf7g@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Fix UAF in key_put()
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Josh Drake <josh@delphoslabs.com>, 
	Suraj Sonawane <surajsonawane0215@gmail.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 09:31, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Can't resist, smp_mb__before_atomic() should equally work,
> but this doesn't really matter, please forget.

We really should have "test_bit_acquire()" and "set_bit_release()".

Well, we do have the test_bit_acquire().

We just don't have the set_bit side, because we only have the bit
clearing version (and it's called "clear_bit_unlock()" for historical
reasons).

Annoying.

             Linus

