Return-Path: <linux-kernel+bounces-426099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52B9DEEED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 05:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBCE281782
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 04:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E7139D1E;
	Sat, 30 Nov 2024 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CEY4599X"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FCB3FC2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732940714; cv=none; b=H9DEoGthbwce8KqaQvdEDcNq+FLLSdet741ICI/ok+hAw5pNhOCjPebAWlfHRujghPa9b6055Y7FXdPRDKGrEBKtInGji9drKZGoa5IW9CVMtErB4nACgCVO19HyUnyBpz3jkm4E4KJpoRpeHxjV3dNyuPlxInoCdbogN3sF6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732940714; c=relaxed/simple;
	bh=fap+TEgMohg/xzDdahlZebDlLLIq4TOx85Df7Y68IyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DInVCcNgacY6W6pUqEFeEet3lVghul+32vwwT+DIvcRYRO5yuS6ca/q0m0KiLZL24MTnpAe7EZYI1f3rYch8fS7jE+DdFzKIFyHg0L1S+1TH0e+Eivu7u3pV7MDvt82adSLVnW5icVKKfHqC9ZvOVO12gxWv+H2vWo+ubwgt2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CEY4599X; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so287972666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732940710; x=1733545510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6MAz+DPH9IklrDo1lsAmfekBZylxDZtcE17zmErLRIc=;
        b=CEY4599X5ICLwJAi2GQDxA3aeMWsQn6LDSD9+05e69wqmmcPwSJWiOuvlBZ1o4s5fl
         dDMNG2tV+/OvcEJawWv4FXBeG4CZhpEzPxlv1QppJpMrKbFvPo6XMhoy0LMBR6uJ8F8U
         XZDlB7ryiCZwUNmW4BhJs7DRGE63FdLt8m6dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732940710; x=1733545510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MAz+DPH9IklrDo1lsAmfekBZylxDZtcE17zmErLRIc=;
        b=SFAVN3fqZ7yDscDHuYFbQkjSzQtVoK3JBtQl6zVEW4FbGthvqZEVbkYgff/22NBQFb
         6+niAbhQm7TSt92G8Nex+/ZRSjcbL5abnUvJ4guiW50CrTWRlwNmJHj1gwmC81PXzFBA
         whmF5laVTpq+yX7Hf1/lfNJQAXVf90/ka+mVA8t9xHra4yZR8ptV/tRPMyTpHm5Xq4pW
         M4vjc8XzA44gf6i0duDwz1CFAwMq2cTV1BHC+MCP7s/Kg1BUTB8l1LZcU6H522q8/LjK
         taOBtGvM1nAkqoiR+UmeoE0fnqjmSqou4Tm+UhxFbWIINEUPq01N9Z5KUtdAQ5fFmbfH
         4xAw==
X-Forwarded-Encrypted: i=1; AJvYcCU6cXBdEB3Y24CkshUVk2Jat/lX9UJrB5hznm7KmIfOWxZeriFPEsQyOn7rjGaiNG7f8w9FgyUlwER6ak8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7x+1RXzp1i8jjhRs5X8ZGKvnEurXtayDIUKUu/zLdAhWXsu4Y
	YFAzyvdQxWnKeqIY1Yznc6t4jh+oFERPVIGOmi5PkcfkoR8K+0WfLVcuTtw4TUz8Om1eZCwy0wl
	jzLbkXA==
X-Gm-Gg: ASbGncvcZtJMo0ubh6YxRNlaS4Hh2tGDHXperVDiwOAxyu7qq6gi6kgcWvh99VmIEz2
	z6so8GdcQUXIhFD+cguK61lRF3KkaWcyoyQgUo/z7bM5vlW174qegvL5LzY5Twy35OetWCOtjMW
	HEZzGpHHkEb2fZLOsy4useqMSNJlhWziPmnmAWafjPzpotfYeb4uErYI8PmmATITC7F/NKfwfVq
	zR40yqKf2PgA3q9jy5kSgZcqNldkLtVHxnPcZUrQErO1df/gMQ3idwZ4H1Xu7r75nWPnJGBCvTS
	qQ+HFHp06FAAA//oL2UUZKOB
X-Google-Smtp-Source: AGHT+IGt65Yk0bKWNltgnA32jwe0BxUwEc8BGORUw3A97o5NEDUAMMLOs/1D01ggLu7SEAPbz709rA==
X-Received: by 2002:a17:906:32c3:b0:aa5:4982:abca with SMTP id a640c23a62f3a-aa580f2fb6emr1211678466b.25.1732940710188;
        Fri, 29 Nov 2024 20:25:10 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599903e6esm238265566b.136.2024.11.29.20.25.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 20:25:07 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso328580866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:25:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0OefN6d2AhuscbazJrTLgRw7BrFPHIAF7thUU3T4HAc2cibfw7FXdbZNtiv7vzVWcOtmCeUCHf485uhI=@vger.kernel.org
X-Received: by 2002:a17:907:77d6:b0:aa5:27ed:546c with SMTP id
 a640c23a62f3a-aa580f35378mr1107409166b.33.1732940706813; Fri, 29 Nov 2024
 20:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org> <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook> <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV> <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org> <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
 <20241129033419.GI3387508@ZenIV> <CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
 <d91debb6-2075-4e1a-af0c-2f3a658cabb3@oracle.com>
In-Reply-To: <d91debb6-2075-4e1a-af0c-2f3a658cabb3@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 20:24:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_=arZ+9MPnNu_wbZbp0yfVpbGp6768VHjUrv_--1SZA@mail.gmail.com>
Message-ID: <CAHk-=wg_=arZ+9MPnNu_wbZbp0yfVpbGp6768VHjUrv_--1SZA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 13:43, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Probably a silly question, but why not do the same thing in all cases?

Because it would actually make a difference for the symlink case.

And unlike the open() -> fd -> execveat() case, the symlink is
actually active at the time of the execve(), so at that time it's a
real part of the name.

Now, do I believe it would actually matter? No, I doubt anybody would
really notice. But let's not change user-visible behavior "just
because".

             Linus

