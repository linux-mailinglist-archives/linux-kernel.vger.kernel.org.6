Return-Path: <linux-kernel+bounces-441990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A489ED672
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F01674F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80352594A8;
	Wed, 11 Dec 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JG6pPT31"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9104259483
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944979; cv=none; b=FwV9L+P0TRpiAT27EbPkw73juThXbryXayb3Y3k+mFSUBIQ5d15TA60vAB0IX9zxukQNlzB0R+glJQESD5CI+/Mswy28OB/3HEQklGFz/zb711szxLwIt5+WBRjxxkAWO9NaCSzWr1yJIeCWaMuYh2J7MIREtGQ//NKuQqPnNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944979; c=relaxed/simple;
	bh=iQWh6opfFLUpylYa6ZE0+Z5y0oJlV/Z158lXDuLo6Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WL0iHYCDzb+Bcv6XMpR8YOuPaqRxrWb3eI6ACIdw1HHzhEhbLo0J1DShp3eAWcce/S/L0+Hyf5j+/aTQqetfQZp8XWDz8znSfU3Y+jINb/6JY+7Fjs1icqNcFOU2HDtkhV9BMVf4ThESDRAOEvREdvZ6JDlIwX/pskhPFsXF9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JG6pPT31; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa66c1345caso327486566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733944975; x=1734549775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z/YhOBi0LQaIKNfwYjxglNoh+vEhk+Q/xwvKfIoew8c=;
        b=JG6pPT31TqFltg2am67QVelPmQthtQfGxphD8yrF7y8Vp5DJDtYIeJ8Zm+Kwd1GuTi
         /d2EVtejMMyO3gkSvyM4McUXP7comgvXCBrvfH8JZVYrAhvpmCjHpPaY3Y40hIFJR2Ac
         HsTfCvn03DcAvzj1A103cxPNooeUHsLvGasRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944975; x=1734549775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/YhOBi0LQaIKNfwYjxglNoh+vEhk+Q/xwvKfIoew8c=;
        b=wnRLjydcLQ6vsSisV0r7eeKDpLVUxQyjByzIJytwLGv3iL/ZSpd3Mhxg4Gqi26aDHD
         ru/ylqepTlrUE/TVIQDiONB/+Go3GUr4RDlHhXb9H5PRofiUO4jcrUJVa9Md5ORb8OPN
         YKDHSGI5qEnZ3w8/7OnWRWCy5lHcDJcsbQgSV/pgadzyU83dyhiIkpScmyHA7MEshG2D
         WzBM7DWfbYkdPAzb58p+EQSO2+4X34fLTHbEUlOtv7H3thHSLUFqia5Dq5JjuJIvW98o
         W3b7I1jJwGMprFUV3w7cdpDQ4d254heOe2qMNDqtp8s7jUw3Sb9ghdB/kgp3ckZ2Xvwr
         rINA==
X-Forwarded-Encrypted: i=1; AJvYcCVVgA441dUXsq9mH74g7R/KIrpTrn2G8IwAyT3FSNHCxig5xIGImUsExf9EeuZM0whjO1tBhUOxrEvTrTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWORr8oxXW0SrXAcsJjdrtX7Gcr/P7KeVUzxcvlHr5aiJ9Nb1H
	X54QOuam9ZQ8ORGEBVwiZBE6MNQY09oWARPdygI4Agrrc6VLCP19fdckCZA1EB5JUrsI3fqPUBd
	qO/w=
X-Gm-Gg: ASbGncu1fP5zNq7FgyadgdH56Pcqp1yFWNYuzjvaUU8Ck9Sq1bA2Vv0DmTg8GEezUkX
	w/hadtQllTDRxCeWNW23qtdW+Dm+dMhRGW6hmJz/1GcKnCHom/ka4PImkCpVv0IwAAYI1MH1Aap
	F2G15UQOxWy4qQ6SswrYHSFz/FLVDKT+EhIbacnhOQ/5TXfVfPx1HD32vT8AD1szRMJxFH86mA/
	dwbCNfopKxpLifEDx23C6rMsondeWsQfMD6CZUCFZpvqoGDSDt8ooyatexOyCJWPS4kiH2dLbiq
	3tpzBOlXtKHcBvX/PMtjcz02IhaG
X-Google-Smtp-Source: AGHT+IFjsKNlwdwvw08YjmmS9N5rXpUtnjkU8uKMliDlaU/Qs+j3wNYTqeZWXyQBHw0eFOeBugmrGg==
X-Received: by 2002:a17:907:c906:b0:aa6:3da3:db48 with SMTP id a640c23a62f3a-aa6c1d1309cmr88546366b.53.1733944974786;
        Wed, 11 Dec 2024 11:22:54 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa677c4970bsm599212166b.112.2024.12.11.11.22.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 11:22:54 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa69077b93fso525405466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:22:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXf/wIUgFyjGGFDy0pZR4hAdn9Jyfq0qkQ5KhCa1kankzalV+KlbH3sZPK58u6aXNpQX0GGfIYmKQGXQYk=@vger.kernel.org
X-Received: by 2002:a17:906:30cf:b0:aa6:748e:d20d with SMTP id
 a640c23a62f3a-aa6c1b103c1mr100558266b.32.1733944973650; Wed, 11 Dec 2024
 11:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
In-Reply-To: <87v7vqyzh4.fsf@mailhost.krisman.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 11:22:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgF7AjODAyO9n+8SfTiQd9-=zTLKh4SQP-xEpeMUPHvAw@mail.gmail.com>
Message-ID: <CAHk-=wgF7AjODAyO9n+8SfTiQd9-=zTLKh4SQP-xEpeMUPHvAw@mail.gmail.com>
Subject: Re: Unicode conversion issue
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "hanqi@vivo.com" <hanqi@vivo.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 08:08, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> It seems commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable
> code points") has affected more than ignorable code points, because that
> U+2764 is not marked as Ignorable in the unicode database.

It's not U+2764 - "Heavy Black Heart".

It's U+2764 _and_ U+FE0F - "Variation Selector-16 (VS16)"

And VS16 asks that the heart be shown as an emoji, which in turn turns
that black heart red.

And presumably that VS16 is one of those idiotic "ignorable" characters.

Christ, I don't understand why some people still think that
casefolding is sane.  It damn well isn't, exactly because it causes
these kinds of insane situations, because the "case folding" of "mark
it as an emoji" is damn well undefined.

> I still think the solution to the original issue is eliminating
> ignorable code points, and that should be fine.  Let me look at why this
> block of characters is mishandled.

I suspect we'll have to revert, and re-examine.

Of course, in the meantime, somebody has probably already created
files with the *new* hashing, so even reverting might not "fix" the
issue.

The real fix is to not do casefolding, or at least to never *EVER*
trust the hashing of case-folded crap, because the hash is
fundamentally not reliable.

What a case-folding filesystem should do is

 (a) preserve case and hash with that preserved case (which is
equivalent to NOT DOING CASE FOLDING! The user gave you binary data,
you *treat* it as binary sacred data instead of corrupting it)

 (b) only using case folding for "I didn't find the exact case, let's
do an approximate search".

but decades of history has shown that filesystem people seem to be
unable to understand the whole notion of "you don't screw with peoples
data".

That (a) guarantees that you get sane semantics for 1:1 names and that
you can *always* access the file using the preserved case.

And (b) is the "you get the insane case folded semantics for the
insane situation where it's needed, and never anywhere else".

Alternatively,  case-folding should only fold the really damn obvious
cases. That was the problem with the horrendous "ignorable code
points", where case-folding reacted to non-case characters by simply
ignoring them.

Damn how I hate broken filesystems that "interpret" the data that they
are given. Pure unadulterated garbage.

If I wanted made-up random crap and hallucinations, I'd ask ChatGPT,
not my filesystem.

                Linus

