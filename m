Return-Path: <linux-kernel+bounces-199761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487908FA577
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ADE1F23A7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A5513C908;
	Mon,  3 Jun 2024 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGCNMwMJ"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2201522E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453254; cv=none; b=mKsk4Wl4ZCXGHPeN88kRpXqYk22VpXhYlD4odKJpGXyDG4G8PbL4Q4nuOOxESGRRdFEs2/nUlwX0ovypJ4kMlN6GGw9tkbqabd8h2aPpIOJVnHYWap7gZr6eWCRO41jG808GWMNlNS+gTupmhlsmLUJ+J7f8z5YNnEkfHnPd2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453254; c=relaxed/simple;
	bh=c6jBUyO259XNej8LEP2rbYIgO5YtFqHRE1KGSirFT5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3Jq5mq3Hi5osxgGQb1N4t8kkTMvM8JIWhf3qUg+q8xJe+Jdomgwhk8AR11pTdrmJ/7Y0gsmXDM/HpxaAwe8cTyMW9B8bzvCUyZwVGmM/gu8pwx+EOmuxp6aRga9kxT0dC628ePghCB7mNquIYiLdg5/nlDh1imqcUFPAfkwWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGCNMwMJ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80ac7385672so1480609241.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717453251; x=1718058051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEZOzvR46o8OXs6b7inqNJNgoefs+GMVibdFACmN7vk=;
        b=dGCNMwMJYmehLihu7EqrdCEVK+QN7YxId7u2nlgBcOfJ+NXuVLDqGIjBX9Mg5+JKo+
         CbTyVENUibLvdm6WJlnDL3vo3j7Gy7F3BzcOozVkU8AAvGuvNw81te7Yv5ZJ7kuSZOfD
         ozzluDNtf3qNvH0gWkKhsQ2sinoHIeCBwodAZBkta0rZ9D5gFU2XbqO1G+ybLK0I7PIf
         W7weA2ZgFiCFPAA5xrR/jeV2sRr2+bFu4CJ/Rab1G9BlNMSTVaWm6tr5XUO6rTackJN2
         TylpKdQoph1p6mZgbQ3kCus+OP/LrNophtPsL1cr7XR5nAIqYwVpn3j6u2UReN+qPof+
         lwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453251; x=1718058051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEZOzvR46o8OXs6b7inqNJNgoefs+GMVibdFACmN7vk=;
        b=SSe282lyBrDkLIZh7ZOg5gHssPt1xe1PlJ9dqGLgJqsHnEzvb4yQ32Em7SXGjMOVD6
         KmyTXTavxsQpsEnjCoRcZvkCG5IQoAPjKKRXP3shZsvAGURxJ4dOYXFvBnjo8Nz0NExx
         Ozof7Mz4pKkSepkk7mtc3FBjUMOHhlC48m2mPFiYvpaERSCXKH89IKYXNg/CUhMeeau9
         GKG1xpjCdJT3ryTw1TI5u23XBpR22uXMbWnpaeem+jxdfKZ8w/qOBG47WDfkEELbC4zU
         iISVInhz7uq5PPR5QTdwJPuEmqese1rE0A9aiDKnckXAcJ4b/RxQrkT1ZB/uxldlovGC
         iGyw==
X-Forwarded-Encrypted: i=1; AJvYcCWbehzxpxn/5wnRa4HKOyPHnLCvc9LMD5S5ZfuRyjU4iR0FGWOZDHmUm7uM6Lk7J//Swpy8qmk4YAgFcWpJwBO0vlo5qTpdAgB8OJSQ
X-Gm-Message-State: AOJu0YzQ75HHKtwagqf5SSI0nvJ7K53IPLmz357/W+Zxw5UMcL9ui3/8
	lkQJi9CpIxs4QGt/IliLaSFy7EIu0U860xjclabXREb4oWrwCeSeTLpGjzgzlmVwj9HLbs4IOUw
	wl6kiv631GN8PwFUvF0yIddDrmshyWDkD+Xxz
X-Google-Smtp-Source: AGHT+IHFbxXZKsQ2frJDi24dIxOftLzRF5JfmD5NcIHKwHYp7Hpp2wU7HO+QfR0c+59/AhYKT8xewzKE4diwJ0oS8rI=
X-Received: by 2002:a05:6102:4b2:b0:47c:1255:dc2d with SMTP id
 ada2fe7eead31-48bc243c8d9mr10588883137.33.1717453251415; Mon, 03 Jun 2024
 15:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418012835.3360429-1-yosryahmed@google.com>
 <CAJD7tkZmDQi2HBOxe5u-Lji88NDuZKCQ_=N_O5aE1nq23aUPqw@mail.gmail.com>
 <9531f1fc-f91e-40ce-9432-5bcbba2fe2f7@intel.com> <CAJD7tkb7wz2P17pehTQtqjueMUxGaUOpFwzoQr_V39npOwuy7g@mail.gmail.com>
In-Reply-To: <CAJD7tkb7wz2P17pehTQtqjueMUxGaUOpFwzoQr_V39npOwuy7g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 3 Jun 2024 15:20:11 -0700
Message-ID: <CAJD7tkaVDrc=vioidZHM6KfdCqrCDt-HXn-RussNS145M1fNgg@mail.gmail.com>
Subject: Re: [PATCH tip:x86/mm v3 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, May 9, 2024 at 11:22=E2=80=AFAM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >
> > On 5/6/24 07:37, Yosry Ahmed wrote:
> > > The merge window is approaching, is this patchset ready to be picked
> > > up? Is any further action needed?
> >
> > Yosry, the merge window is when we send content to Linus.  We generally
> > create that content weeks or months before the merge window.
>
> Right. The patch series has been idle for a long time so I assumed it
> was going to be picked up for this merge window, but given how close
> we have gotten I think we're past this now.
>
> That's fine, I am just trying to get some clarity on whether anything
> else needs to be done for this to be in a mergeable state.
>
> >
> > The best action on your here would be to touch base with Andy and make
> > sure he's on board with the solution you think he suggested.
>
> I have been slightly pinging the series and/or resending every once in
> a while, trying not to be too annoying :) Hopefully Andy will voice
> his opinion.

Hey Dave,

I have tried reaching out to Andy on and off list, and didn't have any
luck unfortunately :/

Is there any way we can still make progress on getting the fixes in
this series merged?

Thanks!

