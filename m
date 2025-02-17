Return-Path: <linux-kernel+bounces-517493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3BA3818E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B777C3A567E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C0217F27;
	Mon, 17 Feb 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRWMIX1n"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779221772F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791271; cv=none; b=lAY1IDK4EiicRABFkw0C23ao9eHl5qE68eBb6IFRDljibc5omu74ENWn93Cq/LAWszLlVtcK0xW6sIlyh3lNyyCmMPjQpourlHCRcFIxtX3rwV/scJyPSHRLYKWnki96XgbgfSUDbBL8OBg3b3qw0YBmiG5exWYPNArpXQfPJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791271; c=relaxed/simple;
	bh=9fD49zca/a7CY/GAfkZOjSfYZ7J1TiWSw9PmjLL/NMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkKuSsJMHxmK7eLJcPucwpYrtbLYarlJsCjMq29PGHSIwPxmbglt6uK6qdJ41xVImPrpSpjfaC0tGsClRqXk6j99I0qCR7YxUfDoFbapEe1exc6P4d1GwNJ067aAwmmS3trIcIF1jUBQ3lhTcabzzLkRS6miA33zcJpeWtNDzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRWMIX1n; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471c9947bb5so465531cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739791269; x=1740396069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c/F61nasiGt/oZBal4vGoQato7Sw7jl8Q+DNm376G/k=;
        b=FRWMIX1ngUtEkpOwaXzt18sWJ4XQqdFaK9X59MRz91+M21bAp1jNEna0mVu85UT+Bv
         bNF/pRFi66CqmbetnsKGcSB6WlGw5O9GmFIqWHsB0FlZ5lNa8fxYJsHlob8MPC1+58Q4
         YSrEby7OsTXEctKp5i3/8l++xlotpz2ZytCj/bC/PX9ypv7xJS5ixbLZEKDn7kIiBR+C
         Lk74hiBz8Gq2o/aifEmlrmh598/bD/EfXluldZ6kSQXGI7dpgeHYPjDKWqVM24k4z192
         DrSfDm1BKAIew4QUCXRMcrfK5ujDsnxGsGmlRLkABQHCaNxSTOyT4eI3cTkNARE4gK6E
         4GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739791269; x=1740396069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/F61nasiGt/oZBal4vGoQato7Sw7jl8Q+DNm376G/k=;
        b=LGIaSGkOGNH6vkLy8BeHZQtEhTJAJhWZkC9OkxShVpotnbwuupjsGd8xN02JyEp1EJ
         HsaZaEo8F75xEDz/sa9pTvjJNBNvzlu5DhlXAsaA49JnT4yFjZ9pd+3i1PdF++IVuZC3
         ilEwL+r2h+lE5W1ksaAXPVci9TXQp30wScF1rFU9LnD4RY6mutBjAHK30FRTwvDIWIpf
         RLbnbsuP7/WBWZHeDyTz+xQFQsx8y/oJiaDOlJVkvYw8g7axeBuy1OXpSklPtxnOdqj7
         jq9zOscletEGUd5LPVXqOPbPBTST224ZoFJu/j52596e6pEyE2M4C0br40GiM8pbQBH/
         e6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9/vIwF8038Ti4wQfeEi2NipAWkvoFUn+06JFd7ND9xf0zMb7LhFUXKddNYo4roT+Y5YUtP/9+K0NmXmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9g/1RqzqeHXQSVyJ+QoucCK8FcKHVmjKR9iyqp6yaNNcAg0J
	rNhtndUMgJEk4v7IGIA0p+sBHg4IBYFHe+4C39O4kyhjnQz3EiyjNydC4uaNVmFm4204t8obiA1
	Pb6QBzUMmzEfmBZzkb4YgVJ2rh+D3wLp21oXE
X-Gm-Gg: ASbGncs55TnDO+jw9yrWZ/3gT4Nm5UVS1whc2nvp2sItfLAVnWQbdrhD8rVJYxPGbPP
	QnjMeck+tNwBXkIeMXVboYQUumCd5N5PBJlu66ReM6WWZ6oU1JMNkDFHrSQhVCigOo6c4Mkorbw
	/6ebO5baJRg5GBaobAnH899DPTbIc=
X-Google-Smtp-Source: AGHT+IEA1oHADje+ZqI4QhvdYoZ5pwlKb/TSeYiRyV0SvwPby3Andg0p/cEpbtOkmwEVn3yfGKPc8yk5Upi5XP7tuQs=
X-Received: by 2002:ac8:59ca:0:b0:471:92af:bf73 with SMTP id
 d75a77b69052e-471dc8f0171mr4982451cf.22.1739791268281; Mon, 17 Feb 2025
 03:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-3-5637b337b443@google.com> <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
In-Reply-To: <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 17 Feb 2025 12:20:56 +0100
X-Gm-Features: AWEUYZmUETjDhiEF2B1qzgoI8XTYa-MJljWmi_v2oHMRAAGbSdUt2z48cta-3uQ
Message-ID: <CA+i-1C2GF=5VE5Bfq_znG1nVU6K5orzhOohBatc64ghX7mW6FA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/3] x86/cpu: Enable modifying bug flags with {clear,set}puid
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 12:10, Borislav Petkov <bp@alien8.de> wrote:
>
> >  extern const char * const x86_bug_flags[NBUGINTS*32];
> > +#define x86_bug_flag(flag) x86_bug_flags[flag]
>
> Why?

That's just for consistency with x86_cap_flag().

I don't remember seeing any reason why that indirection exists. Maybe
it's vestigial. Shall I just remove it?

To everything else: ack, thanks for the review.

