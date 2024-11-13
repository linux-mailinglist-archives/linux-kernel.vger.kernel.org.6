Return-Path: <linux-kernel+bounces-408077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167D59C7A25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F0B1F255C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8F201262;
	Wed, 13 Nov 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NzEQ1SL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6751FF7BD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519878; cv=none; b=qJI8Mb8GyR0fdMvCAgRksCc1PqAIbazk7HOwlgLo0Piw6h2gEse2PMRwfoqOalLvV1tWJ7LcaNu/rvcX1qGVYkrsftg0qVMPhaNB4MK532lGmXL33GRGOG+RQAaN+kcSQL9//CkwE8MVWBReBuazW9l+Xs9ns36qmRd3JmvCsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519878; c=relaxed/simple;
	bh=TcvEUkeKFVgGLTt37+MUAGAHziBUQjifnkJdXdV9wRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYHvljiTExMIbNktP+uzC8RpERs4KluVr2fa1jutu/VEihtsW83C83NKXTYierQV9zeHcQKFck+6S9SaGVd41NdmuOhSGi9jWLCNADw8TDxYm5q64UaqLYg8pc8la5I+4Ce3Y9ifVgYMs+I+uA14NnXxWv9pkn1cGVxmjmIYcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NzEQ1SL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e66ba398so10627e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731519875; x=1732124675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Di+iKJ5akzTFP1IjKCqjyy6r9Jqh1xsxmJVtI0c5XMw=;
        b=2NzEQ1SLUDr16WIa7I5O1+BRSVbZidtehWFMcTahBxQf/FeuOKzO4HoWE4ylhzdqvW
         YxpHiS89GXeVubNcWbBHRibxjf5rlSxG5cR1hl6PuBJw9rdtRbfCV7T8mIBBBfV3b11T
         iFjGBudQh1vMf59kI70/LzO3PFGvjSNYYnpdGiHeqXYK58S0FctI2ElBHDAgDdUUw/8l
         8AL0Ow27S4pS1Kw/tFsNYMokBD8rkJf0e/rwf8tb2hDYTYpXdk3FWakeiwkeHDibi0bb
         mQDorCtGBjMdOf4DbeSOa624IIK6VO7BlQzkVvAvootbhEvEULlkWvASE6lQDdSkXpOm
         jYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519875; x=1732124675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Di+iKJ5akzTFP1IjKCqjyy6r9Jqh1xsxmJVtI0c5XMw=;
        b=vOuxIYmNmPcwFgZDFpAyVQLsPmKhE7nP/zLvvcg1wfKPRSJ2z9FlTVod+MhdOCTdNj
         V9XI1quYVAIRMdKSyM4LVMbzJ0lBz2NGyGZfpffnfREPazocL2F9WnQsAHaDsMbGaGgj
         0yENz+CespUoEQX3EdjbzmB2fO5xZGcDfpcmOvDPV9Xd1wcXbpkXV7s+rSH1tIQYlWvQ
         VdRqXMbqu8UyVe38ULqsyJ9jSyXGwJ5DqogRchtEVSR+7F3NQ8uL1HN4mQvySiREvpZr
         3hMwXzdfJXgXfQqS3pftYGKCp5q03Mrekd8tGGSZeDIYTRaoaYgGbi6V31UY84ztlQIs
         J0xw==
X-Forwarded-Encrypted: i=1; AJvYcCWIKAoOkyTpKFQbMlS7gN7SZY+7cTkuywjOKFm3ot9Ghmfpk2L7JXO5QiAS701oa8O6HWIDRvd6ebiS/lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LPIe8puEGEXgTjCeCPZUV4IoAEU+Y9pYmXbIbWnxcId2470+
	rzN2tVQS8P/De6M7qr0cKvMURGx9xEb3zdLBGKo3q0J1sJU+YFmnO0vHGiXqc3KP7T+IGtgPktW
	no02Z6gkIZ7S7gsJNMfe7M0SBw86g8PO1J10j
X-Gm-Gg: ASbGnctOSsqlj8E75pNoHNoT4s89m2+ZcX+uNhQn+WS2QLcaSblijZx4WmA+CA93kY3
	Zljb60jaDMtkiYDx2fysESvYqgrSdQLdtVPjFQbvwscAZZbT5U5CY7fpfEam2
X-Google-Smtp-Source: AGHT+IEBiRX+iakj03mwhRodl8EB4ddlvW0A0JNFLYItqjRlt/va0erAr2MtetPxwlyJPF24ToOICU0mFNtQbJtF85E=
X-Received: by 2002:ac2:4438:0:b0:539:d0c4:5b53 with SMTP id
 2adb3069b0e04-53da0736535mr143602e87.4.1731519874758; Wed, 13 Nov 2024
 09:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
 <le3ykvrau2lbncrjsqll7z6ck43bf3shon4g5ohchxcvcs4fuy@h3pq646xgoz6> <3593f7ab-c37d-4c1d-bf2f-e47c30bb5d2b@lucifer.local>
In-Reply-To: <3593f7ab-c37d-4c1d-bf2f-e47c30bb5d2b@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Wed, 13 Nov 2024 18:43:57 +0100
Message-ID: <CAG48ez3Ap0XWr+3UmQeW6O82PU_Fh85pCuwOpC9n6J+kxtPVRA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:44=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Tue, Nov 12, 2024 at 10:15:44AM -0500, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241108 08:57]:
> [snip]
> > > +Each mm object contains a maple tree data structure which describes =
all VMAs
> > > +within the virtual address space.
> > > +
> > > +.. note:: An exception to this is the 'gate' VMA which is provided b=
y
> > > +          architectures which use :c:struct:`!vsyscall` and is a glo=
bal static
> > > +          object which does not belong to any specific mm.
> >
> > vvars too?
>
> I'm not sure if that's the case? For instance for x86-64 we have:
>
> /*
>  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
>  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
>  * not need special handling anymore:
>  */
> static const char *gate_vma_name(struct vm_area_struct *vma)
> {
>         return "[vsyscall]";
> }
>
> With no reference to vvar. Also vsyscall exists in a kernel range, and vv=
ar
> in a userland mapping (along with the vdso).

Yeah, there are different gate VMA types depending on architecture
(arm has "vectors page", x86 has "vsyscall", ...), but vvar and vdso
are just normal VMAs set up at some point in execve().

