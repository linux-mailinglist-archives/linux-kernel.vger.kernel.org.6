Return-Path: <linux-kernel+bounces-575876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69938A7087E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696373B8E48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415A2627E3;
	Tue, 25 Mar 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BCW9UAoq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D515C140
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924951; cv=none; b=h1iErGoWpl12SVCeJFU8qnc1eDm7bBIMLEMwjxbReEPHD69cNG0Ier/TI1gnu9rz+b43Pr1A+pSZk02/qjn4f1a2YB1jE5kHsuvUcXX3ju56YBe+iRNUHXhbMDEXPK7Ugfpw5yPgWSt6kLWvaSGboSgBLaAurUhobPLBTXLDaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924951; c=relaxed/simple;
	bh=5lf9EyK9tb9PQqHAZDOiGSp/8OmQ860G+KzjdCsaVYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh1W5AyOZJ3ua92MVjkdA5CHYJZVdn3J9uPinmwRkI8wJlkXmn7/hf8cM0ta2LYGKc3Onk0AvqBsSIfv5UBG9bAj8DF++kiMfeqk2M0LEFyjIP3RU6G4B4uDn32Rv1tq8KWaLEnhddC2YXCMCBAiQBhbQWVkmCta3scFR1Q7YuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BCW9UAoq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbd96bef64so67769766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742924947; x=1743529747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6P+BC0MhYFh9Fc34++UOutlTwR2W5Ljjjnd/jFWs0/U=;
        b=BCW9UAoqI3WHbf2cyXkOX9nW+nzuK7Iz05wBQmRKVQcQq1Mznxce4mAwiwbRH8Kvkt
         MJRCyvQ481gi3OsHrhVFbQQ78/x3fQlcBUbBl5ilzrIpFpCFjUncAb+PLbReJvl+lYKL
         B6LoR9jmk7v5RDSg2TxetPaMTTT5WV4/syraA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924947; x=1743529747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P+BC0MhYFh9Fc34++UOutlTwR2W5Ljjjnd/jFWs0/U=;
        b=YhInJ6Ct7TLecAR9HX5EBDBmi/mWQ4UQqCZ12RpJ3KCdWtJavCVtYkblDRTLRxCKNM
         M/AHzjsSkLPrqYQWlUrxPrUUISMvrbRoJnoerOD2OTYiEZX7nd4I0jGExkeNZ5pnm/UC
         eYZ8iPitO0DRrHkfgBXGBio3Y6JvCAJxEAMBLsfC1E0w9vbbf9Z1Se5A93W/CIeIUdXH
         DazcgLnkibTNkVWzjpVdfFmbakEMwtOvaaJ4aozOlHKnXk7GAeDwkSv6yLIb/Q+lDgAf
         ibtL7giS6TraqLAcOO0UQLCgZ6X+fO3SydItdlTVjtMzMBmddQ3QTbuKyFZPYUsrwoDi
         b9BA==
X-Forwarded-Encrypted: i=1; AJvYcCXH+djDY6P020ZSbl2BzT6ukYW+TUUU/8VY4vWo0NksKWVHbJ+DPY0411UJNgoMhkLx1ro/L8BR5+2zHBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1zeeuHnuqrtPEzrUrNBHLBVKbIq9ABSTQ+EwFlCD6zKBzdxG
	hmZIIONaFXnDc0Q0YBQ7oYJ8SvtcBde48bCZsvz+VsSvcXm4fB0imtTqYK1YEhGjLi5e1JhgnrI
	14ZY=
X-Gm-Gg: ASbGnctpEp7uEbcz+0GYTV1DvZuh7PTPqV7Mqryrcd/5bPKPA5O8naCbEPU5q6Ef4GD
	v4BQ37CJ7B+mPX0pO1Radwp/W7TWBAnT2sOWnK/5alP+d9Uww84E0qDQIbwnI9Et5jw8ftRziwN
	Wi7YxtU+i90TskSMaff/PVtVqD7cFkSnqGhTo6YoJ7XRnFGKPz+GTODHiX+yOX2CmwzJNtrKbag
	lhbAhkVc9S2xdhl7L3KQJ7oL+fcZ4VpCRzKUUu2CBLMsRcWYPbp+DkZKhOuamtEo7qswSTiPZPY
	z66oXDRCHRV8VXdrItn5FESEKr2wC/r2ObkUZ8jMvL5VUIqDqXrZrbb4mZxtPTF8WOzVP5Nqh5c
	NXxyh5Y7lxWQH3tG+R0w=
X-Google-Smtp-Source: AGHT+IGGy71ZHRuM+uJHf0R606CtJ4CID5wIu1Gk3uRt/gRChk7hmBY+fsRF8lQbadurSxlgYxXrNA==
X-Received: by 2002:a17:907:958a:b0:ab7:b30:42ed with SMTP id a640c23a62f3a-ac3f1de5aabmr1879548966b.0.1742924947067;
        Tue, 25 Mar 2025 10:49:07 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb65899sm896956066b.104.2025.03.25.10.49.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 10:49:05 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbd96bef64so67763966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:49:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNVfAEN/SlK4HKzOn4860ViGA6Hmi8J5rFrVS5KoNcbdW09UJvO5n1Vz/lU1g+1SAIawpMQGbSC+Di7io=@vger.kernel.org
X-Received: by 2002:a17:907:9707:b0:ac3:9587:f2ac with SMTP id
 a640c23a62f3a-ac3f2293764mr1697642366b.33.1742924945447; Tue, 25 Mar 2025
 10:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317104257.3496611-2-mingo@kernel.org> <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net> <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com> <20250325123625.GM36322@noisy.programming.kicks-ass.net>
In-Reply-To: <20250325123625.GM36322@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 10:48:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>
X-Gm-Features: AQ5f1JotVBul2ZkcrgvaYiVPsvTjoSUOm9EMep0EghGICtNe3Dzg71mQtdusIkk
Message-ID: <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>
Subject: Re: [PATCH] bug: Introduce CONFIG_DEBUG_BUGVERBOSE_EXTRA=y to also
 log warning conditions
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

 On Tue, 25 Mar 2025 at 05:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The problem with WARN() is that it is a format string, which must be
> filled out in situ. Resulting in calls to snprintf() and arguments and
> whatnot.

A fair number of warnings do want the format string, so that you can
print out more information about what went wrong if the warning
triggered.

That said, I do think that the "just give a fixed string that is the
warning condition" is probably the right thing 90% of the time, and is
the much simpler interface both to use and causes much less code
(exactly because it's just a single hardcoded string at compile time).

So I think we end up wanting both.

But I *don't* like Ingo's suggestion of DEBUG_BUGVERBOSE_EXTRA,
because it does that "both" by making the simple case complicated.

How about going a different route instead? Right now we have that
CONFIG_DEBUG_BUGVERBOSE thing which adds the file name and line number
information. That has been very good.

But maybe that should be extended to also always take the compile-time
'#condition' string?

So then all warnings would have the warning condition string (assuming
you end up enabling DEBUG_BUGVERBOSE, of course, which I think
everybody pretty much does). With no extra code.

And then the _dynamic_ string - and associated code generation - would
be only for when you want to print out the actual values that caused
the warning.

Hmm?

             Linus

